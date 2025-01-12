import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:cacalia/features/home/pages/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cacalia/CS/create.dart';

//BLEセントラル側のライブラリ
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//振る処理のライブラリ
import 'package:shake_gesture/shake_gesture.dart';
//BLEペリフェラル側のライブラリ
import 'package:ble_peripheral/ble_peripheral.dart' as ble_peripheral;
//UUIDを作成するライブラリ
import 'package:uuid/uuid.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangeState();
}

///必要な権限を許可するメソッド
Future<bool> requestPermissions(
    Permission permission, String permissionName) async {
  if (await permission.request().isGranted) {
    print("$permissionName パーミッションが許可されました");
    return true;
  } else {
    print("$permissionName パーミッションが拒否されました");
    return false;
  }
}

///許可したい権限を記入
Future<void> checkPermission() async {
  await requestPermissions(Permission.location, "位置情報");
  await requestPermissions(Permission.bluetoothScan, "Bluetooth Scan");
  await requestPermissions(Permission.bluetoothConnect, "Bluetooth Connect");
  await requestPermissions(
      Permission.bluetoothAdvertise, "Bluetooth Advertise");
}

class _ExchangeState extends State<ExchangePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool setAI = false;

  Map<String, String> myprofiles = <String, String>{
    'u_id': profileList[myuid]["u_id"],
    "name": profileList[myuid]["name"],
    "read_name": profileList[myuid]["read_name"],
    "gender": profileList[myuid]["gender"],
    "age": profileList[myuid]["age"],
    "comment": profileList[myuid]["comment"],
    "events": profileList[myuid]["events"],
    "belong": profileList[myuid]["belong"],
    "skill": profileList[myuid]["skill"],
    "interest": profileList[myuid]["interest"],
    "hoby": profileList[myuid]["hoby"],
    "background": profileList[myuid]["background"],
    "bairth": profileList[myuid]["bairth"],
    "serviceUuid": profileList[myuid]["serviceUuid"],
    "charactaristicuuid": profileList[myuid]["charactaristicuuid"]
  };

  String generatedText = 'Loading...';

  //画面に表示するテキスト
  // String displayText = "近くにデバイスがありません。";

  //受け取ったデータ
  Map<String, dynamic> receivedData = {};

  //デバイスに接続できるボタンの状態
  bool _isfinded = false;

  //スキャンされたデバイス
  BluetoothDevice? selectdevaice;

  //スキャンされたデバイスのUUID
  String? deviceUUID;

  //サービスを格納するリスト
  List<BluetoothService> services = [];

  //接続状態を示す変数
  bool _isConnected = false;

  //ペリフェラルのサポート有無
  bool _isSupported = false;

  //データを受けとったかどうか
  final isReceived = StreamController<bool>();

  //スキャン処理状態を保持する変数
  bool _isScanning = false;

  //Uuidを生成
  var uuid = Uuid();

  //BLEの通信処理に使う変数
  String serviceUuid = ""; // サービスUUID

  String charactaristicuuid = ""; // キャラクタリスティックUUID

  //使用するASCIIバイト列（Cacalia）
  final List<int> manucacaria = [0x43, 0x61, 0x63, 0x61, 0x6C, 0x69, 0x61];

  //受け取った値をデコードする変数
  Map<String, dynamic> decodereceived = {};

  DateTime? _lastShakeTime;

  void handleShake() {
    final now = DateTime.now();
    // 前回のシェイクから500ミリ秒以上経過している場合のみ処理を実行
    if (_lastShakeTime == null || 
        now.difference(_lastShakeTime!) > const Duration(milliseconds: 500)) {
    
      _lastShakeTime = now;
      startScan();
    }
  }

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラーの初期化
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // ストリームリスナーの設定
    _setupStreamListener();

    generateUuids();

    print(profileList);

    Future.delayed(Duration.zero, () {
      start();
    });
  }

  void start() async {
    await checkPermission();

    // BLEペリフェラルの初期化
    await ble_peripheral.BlePeripheral.initialize();

    await initializePeripheral();

    // await startAdvertise();

    ///
  }

  _setupStreamListener() {
    isReceived.stream.listen(
      (value) {
        if (value) {
          stopAdvertise();
          // generateText();
          _showProfilePopup();
        }
      },
      onError: (error) {
        print('ストリームエラー: $error');
      },
      cancelOnError: false,
    );
  }

  //ユーザのUUIDを生成
  generateUuids() {
    serviceUuid = uuid.v4();
    charactaristicuuid = uuid.v4();
    print('UUIDを作成しました');
  }

  Future<void> generateText() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyDvlwupnHlUINeIAt5yBGP1KASRGNqlwVA',
    );

    const prompt =
        'I`ll send 2 sentences. compare and find common points. then create any topic and say like this ["Topic u generated"という話題でお話してみませんか？] no need other explain. 1.I hate u 2.I dont like u';
    final content = [Content.text(prompt)];

    try {
      final response = await model.generateContent(content);
      print(response.text); // Log response to debug
      setState(() {
        generatedText = response.text ?? 'No response text';
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        generatedText = '生成エラー: $e';
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0B1930), // 深い青
              Color(0xFF1B3366), // ミッドナイトブルー
              Color(0xFF2C4999), // 青紫
            ],
          ),
        ),
        child: Stack(
          children: [
            // 星のエフェクト
            Positioned.fill(
              child: CustomPaint(
                painter: StarsPainter(),
              ),
            ),
            // メインコンテンツ
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2.0 * 3.14159,
                        child: Icon(
                          Icons.bluetooth_searching,
                          size: 100,
                          color: _isConnected
                              ? Colors.green
                              : Colors.white, // 色を白に変更
                        ),
                      );
                    },
                  ),
                  ShakeGesture(
                    onShake: handleShake,
                    child: Text(''),
                  ),
                ],
              ),
            ),
            // ホームアイコンを追加
            Positioned(
              top: 60,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  context.go('/home'); // GoRouterを使用してホーム画面に遷移
                },
                child: const Icon(
                  // Image.assetをIconに変更
                  Icons.home,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // JSONデータをUint8Listに変換
  Uint8List _jsonToUint8List(Map<String, dynamic> uidData) {
    return Uint8List.fromList(utf8.encode(jsonEncode(uidData)));
  }

  //受信データからuuidのみ取り出すメソッド([uuid]のような形式で送られてくる)
  static splitdata(String data) {
    List<String> splitleft = data.split("[");
    List<String> splitright = splitleft[1].split("]");
    String result = splitright[0];
    return result;
  }

  //以下ペリフェラル側の処理
  //ペリフェラル側のサービス処理
  initializePeripheral() async {
    await checkPermission();
    // Readリクエストのコールバック設定
    ble_peripheral.BlePeripheral.setReadRequestCallback(
        (device, characteristic, offset, value) {
      try {
        Uint8List senddata = _jsonToUint8List({'u_id': myuid});

        //データが大きい場合を考慮し、offsetを使用して分割読み出しを行う
        Uint8List partialData = senddata.sublist(offset);

        return ble_peripheral.ReadRequestResult(
            value: partialData, status: 0 // GATT_SUCCESS
            );
      } catch (e) {
        print("Error in ReadRequestCallback: $e");

        return ble_peripheral.ReadRequestResult(
            value: Uint8List(0), // 空のデータを返す
            status: 1 //GATT_FAILURE
            );
      }
    });

    //Writeリクエストのコールバック設定
    ble_peripheral.BlePeripheral.setWriteRequestCallback(
        (device, charactaristic, offset, value) {
      //値がUnit8Listじゃない場合エラーを返す
      if (value == null) {
        print("Received null value");
        return ble_peripheral.WriteRequestResult(status: 1);
      }

      try {
        setState(() async {
          //受け取ったデータをデコード
          String received = utf8.decode(value);
          print("Received raw data: $received");

          // JSON形式に変換して取得
          decodereceived = Map<String, String>.from(jsonDecode(received));
          receivedData = await getProfile(decodereceived['u_id']!);
          print("Decoded JSON: $receivedData");
          isReceived.add(true);
        });

        return ble_peripheral.WriteRequestResult(status: 0); // GATT_SUCCESS
      } catch (e) {
        print("Error: $e");

        return ble_peripheral.WriteRequestResult(status: 1); //GATT_FAILURE
      }
    });

    // サービスとキャラクタリスティックの作成
    await ble_peripheral.BlePeripheral.addService(ble_peripheral.BleService(
      uuid: serviceUuid,
      primary: true,
      characteristics: [
        ble_peripheral.BleCharacteristic(
            uuid: charactaristicuuid, // キャラクタリスティックUUID
            //キャラクタリスティックの特性を設定
            properties: [
              ble_peripheral.CharacteristicProperties.read.index, //読み込み
              ble_peripheral.CharacteristicProperties.write.index, //書き込み
              ble_peripheral
                  .CharacteristicProperties.notify.index, //通知（コールバック使うため必要）
            ],
            //notifyを使用するための記述
            descriptors: [
              ble_peripheral.BleDescriptor(
                uuid: '00002902-0000-1000-8000-00805f9b34fb', //固定uuid
                value: Uint8List.fromList([0x01, 0x00]), //許可
              ),
            ],
            //許可する権限を付与
            permissions: [
              ble_peripheral.AttributePermissions.readable.index,
              ble_peripheral.AttributePermissions.writeable.index
            ]),
      ],
    ));
  }

  //アドバタイズ（宣伝）をスタートするメソッド
  startAdvertise() async {
    // //宣伝する際に使用するマニュファクチャリングデータを作成

    // //Uint8List形式にキャスト
    // final Uint8List manucacalia8List = Uint8List.fromList(manucacaria);

    // //ManufacturerDataを宣言
    // ble_peripheral.ManufacturerData manuData = ble_peripheral.ManufacturerData(
    //     manufacturerId: 0xA705, data: manucacalia8List);

    //宣伝開始
    await ble_peripheral.BlePeripheral.startAdvertising(
        services: [serviceUuid], localName: 'Cacalia'); //開始
    print("開始");

    //状態更新
    setState(() {
      _isSupported = true;
    });
  }

  //宣伝終了
  stopAdvertise() async {
    await ble_peripheral.BlePeripheral.stopAdvertising(); //停止
    print("停止");
    // displayText = "宣伝してよ...o(≧口≦)o";

    //状態更新
    setState(() {
      _isSupported;
    });
  }
  //ここまで

  //以下セントラル側の処理
  //接続できる端末を探すメソッド
  void startScan() async {
    await startAdvertise();

    ///
    //処理中にメソッドが呼び出された場合
    if (_isScanning) return;

    setState(() {
      //判定に必要な変数を初期化
      _isfinded = false;
      _isScanning = true;
      isReceived.add(false);
      _isConnected = false;
      setAI = false;
      // displayText = "スキャン中...";
    });

    //接続可能な端末をスキャンする
    await FlutterBluePlus.startScan(
        withNames: ['Cacalia'], timeout: const Duration(seconds: 3)); //３秒間
    try {
      //結果を受け取る
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          print(
              //接続可能なデバイスを表示
              '${r.advertisementData.serviceUuids}: "${r.device.advName}" found!');

          //任意のデバイスが見つかった場合
          if (r.device.advName.toString().contains("Cacalia")) {
            print("デバイス情報$r");

            setState(() {
              //端末のUUIDを取得
              deviceUUID =
                  splitdata(r.advertisementData.serviceUuids.toString());

              _isfinded = true;

              selectdevaice = r.device;
            });
            //スキャン終了
            FlutterBluePlus.stopScan();
            connectDevaice(selectdevaice!);
            break;
          }
        }
      });

      //スキャンが終わりデバイスが見つからなかった場合
      await Future.delayed(const Duration(seconds: 3), () {
        stopAdvertise();

        ///
      });
    } catch (e) {
      setState(() {
        // displayText = "エラーが発生しました: $e";
      });
    } finally {
      setState(() {
        _isScanning = false;
      });
    }
  }

  //見つかったデバイスに接続するメソッド
  void connectDevaice(BluetoothDevice device) async {
    try {
      //見つかったデバイスに接続
      await device.connect(timeout: const Duration(seconds: 5));
      print('${device.advName}に接続しました');

      //接続されたデバイスのサービスを取得
      await Future.delayed(const Duration(seconds: 1));
      services = await device.discoverServices();
      await readCharacteristic(); //ReadWrighメソッド
      disconnectDevaice(device);
    } catch (e) {
      print('エラーでちゃった。。。:$e');
      _isConnected = false;
      stopAdvertise();

      ///
    }
  }

  //接続を解除するメソッド
  disconnectDevaice(BluetoothDevice device) async {
    await device.disconnect();
    print('接続解除');
    setState(() {
      _isConnected = false;
      isReceived.add(false);
    });
  }

  //ペリフェラル側から送られてきた値を受信し、送信もするメソッド
  readCharacteristic() async {
    //サービス一覧を表示
    for (BluetoothService service in services) {
      print('さーびす:$service');
      //サービスのキャラクタリスティック一覧を表示
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        print('きゃらくたりすてぃっく:$characteristic');
        //ペリフェラル側で設定したキャラクタリスティックの場合
        if (characteristic.serviceUuid.toString() == deviceUUID) {
          // 通知を有効化
          characteristic.setNotifyValue(true);
          //値を読み込む
          final value = await characteristic.read();
          // 受信データを文字列に変換
          final received = utf8.decode(value);
          print("received:$received");
          decodereceived = Map<String, String>.from(jsonDecode(received));
          receivedData = await getProfile(decodereceived['u_id']!);
          print("Caractaristic:${characteristic.uuid}");
          print("Received: $receivedData");

          setState(() {
            isReceived.add(true);
            _isConnected = true;
          });

          ///

          //_showProfilePopup();

          writeCaracteristic(characteristic);

          disconnectDevaice(selectdevaice!);
          stopAdvertise();
          break;
        }
      }
    }
  }

  void writeCaracteristic(BluetoothCharacteristic characteristic) async {
    await characteristic.write(_jsonToUint8List({
      "u_id": myuid,
    }));
    // disconnectDevaice(selectdevaice!);
    // stopAdvertise(); ///
  }
  //ここまで

  //AI提案をするメソッド
  _showProfilePopup() async {
    //比較する項目を設定
    List<String> keys = ["events", "comment", "hoby", "background"];

    //受け取ったデータと自分のデータの中で、keysで指定した値で初期化
    List<dynamic> receivevalue =
        keys.map((key) => receivedData[key] ?? "N/A").toList();
    List<String> myvevalue =
        keys.map((key) => myprofiles[key] ?? "N/A").toList();
    print('受け渡す値：$myvevalue : $receivevalue');

    //Geminiのmodelとapiキー
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyDvlwupnHlUINeIAt5yBGP1KASRGNqlwVA',
    );

    //Geminiにプロンプト送信
    final prompt =
        'I`ll send 2 sentences. compare and find common points. then create any topic and only say like this ["Topic u generated"という話題でお話してみませんか？] no need other explain. 1.$receivevalue 2.$myvevalue}';
    final content = [Content.text(prompt)];

    //送られてきたメッセージを代入
    try {
      final response = await model.generateContent(content);
      print(response.text); // Log response to debug
      setState(() {
        generatedText = response.text ?? 'No response text';
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        generatedText = '生成エラー: $e';
      });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage('assets/images/default_avatar.png'),
                ),
                const SizedBox(height: 16),
                Text(
                  'ユーザ：${receivedData['name']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'コメント：${receivedData['comment']}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  generatedText,
                  style: const TextStyle(fontSize: 16),
                ),
                TextButton(
                    onPressed: () {
                      updateFriend('friend_uid', decodereceived['u_id']);
                      context.go('/home');
                      print('ホームに移動');
                    },
                    child: const Text(
                      'フレンドに追加',
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

// StarsPainterクラスを追加
class StarsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // 固定の星の位置を定義
    final starPositions = [
      Offset(size.width * 0.2, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.15),
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.7, size.height * 0.4),
      Offset(size.width * 0.1, size.height * 0.6),
      Offset(size.width * 0.9, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.8),
      Offset(size.width * 0.6, size.height * 0.85),
    ];

    // 定義された位置に星を描画
    for (var position in starPositions) {
      canvas.drawCircle(position, 1.5, paint);
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => false;
}

//テストデータ
  //   'uid': "Hxva1aGnNMcwg8s7esKDNmNll6u1",
  //   "name": "谷岡 義貴",
  //   "read_name": "Tanioka Yoshitaka",
  //   "gender": "男",
  //   "age": '2004',
  //   "comment": "ドラムが好きです",
  //   "events": "HACK U",
  //   "belong": "ECCコンピュータ専門学校",
  //   "skill": "0",
  //   "interest": "0",
  //   "hoby": "カラオケ",
  //   "background": "基本情報技術者試験取得、Hack U NAGOYA優秀賞",
  //   "bairth": "12/26",
  //   "serviceUuid": "forBLE",
  //   "charactaristicuuid": "forBLE"

  // 'uid': "Hxva1aGnNMcwg8s7esKDNmNll6u1",
  // "name": "文元 沙弥",
  // "read_name": " Fumimoto Saya",
  // "gender": "女",
  // "age": "2004",
  // "comment": "ダーツ友達ください",
  // "events": "HACK U",
  // "belong": "ECCコンピュータ専門学校",
  // "skill": "0",
  // "interest": "0",
  // "hoby": "カラオケ",
  // "background": "Geekハッカソン企業賞、基本情報技術者試験取得",
  // "bairth": "05/14",
  // "serviceUuid": "forBLE",
  // "charactaristicuuid": "forBLE"
