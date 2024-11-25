import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class ExchangePage extends StatefulWidget {
  const ExchangePage({super.key});

  @override
  State<ExchangePage> createState() => _ExchangeState();
}

class _ExchangeState extends State<ExchangePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
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
              Color(0xFF0B1930),  // 深い青
              Color(0xFF1B3366),  // ミッドナイトブルー
              Color(0xFF2C4999),  // 青紫
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
                          color: _isConnected ? Colors.green : Colors.white,  // 色を白に変更
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white24,  // ボタンを半透明に
                      foregroundColor: Colors.white,   // テキストを白に
                    ),
                    onPressed: _startBluetoothConnection,
                    child: Text(_isConnected ? '接続済み' : 'Bluetooth接続'),
                  ),
                ],
              ),
            ),
            // ホームアイコンを追加
            Positioned(
              top: 40,
              left: 16,
              child: GestureDetector(
                onTap: () {
                  context.go('/home');  // GoRouterを使用してホーム画面に遷移
                },
                child: const Icon(  // Image.assetをIconに変更
                  Icons.home,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startBluetoothConnection() async {
    // Bluetooth接続処理
    // 実際の実装ではここにBluetooth通信のロジックを追加
    setState(() {
      _isConnected = true;
    });
    _showProfilePopup();
  }

  void _showProfilePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/default_avatar.png'),
                ),
                SizedBox(height: 16),
                Text(
                  '山田 太郎',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '株式会社サンプル',
                  style: TextStyle(fontSize: 16),
                ),
                Text('営業部 部長'),
                SizedBox(height: 8),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('連絡先情報'),
                        Text('email@example.com'),
                        Text('090-1234-5678'),
                      ],
                    ),
                  ),
                ),
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
