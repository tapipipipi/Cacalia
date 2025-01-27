// 設定できるフォントの定義
import 'package:flutter/material.dart';

class Fonts {
  static const String font0 = '';
  static const String font1 = 'ArchitectsDaughter';
  static const String font2 = 'Anton';
  static const String font3 = 'Lobster';
  static const String font4 = 'PirataOne';
}

// 設定できる背景の定義
// ignore: camel_case_types
class bgImg {
  static const String design0 = 'assets/images/designs/design0.png';
  static const String design1 = 'assets/images/designs/design1.png';
  static const String design2 = 'assets/images/designs/design2.png';
  static const String design3 = 'assets/images/designs/design3.png';
}

String setBg(String bg) {
  print('setBg処理開始');
  print(bg);
  var selected = '0';
  switch (bg) {
    case '0':
      selected = bgImg.design0;
      break;
    case '1':
      selected = bgImg.design1;
      break;
    case '2':
      selected = bgImg.design2;
      break;
    case '3':
      selected = bgImg.design3;
      break;
  }
  print('selected: ' + selected);
  // ignore: void_checks
  return selected;
}

// 設定できる背景テーマ選択の表示
