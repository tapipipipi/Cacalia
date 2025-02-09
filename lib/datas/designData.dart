// 設定できるフォントの定義
class Fonts {
  static const String font0 = 'Roboto';
  static const String font1 = 'ArchitectsDaughter';
  static const String font2 = 'Anton';
  static const String font3 = 'Lobster';
  static const String font4 = 'PirataOne';
}

String setFont(String font) {
  print('setFont処理開始');
  print(font);
  var selected = '0';
  switch (font) {
    case '0':
      selected = Fonts.font0;
      break;
    case '1':
      selected = Fonts.font1;
      break;
    case '2':
      selected = Fonts.font2;
      break;
    case '3':
      selected = Fonts.font3;
      break;
    case '4':
      selected = Fonts.font4;
      break;
  }
  print('selected: ' + selected);
  // ignore: void_checks
  return selected;
}

// 設定できる背景の定義 ----------------------------------------------------------
class bgImg {
  static const String design0 = 'assets/images/designs/design0.png';
  static const String design1 = 'assets/images/designs/design1.png';
  static const String design2 = 'assets/images/designs/design2.png';
  static const String design3 = 'assets/images/designs/design3.png';
}

// 設定できる背景テーマ選択の表示
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

// 設定できる背景の定義 ----------------------------------------------------------
class cardImg {
  static const String cardTheme0 = 'assets/images/designCards/card0.png';
  static const String cardTheme1 = 'assets/images/designCards/card1.png';
  static const String cardTheme2 = 'assets/images/designCards/card2.png';
  static const String cardTheme3 = 'assets/images/designCards/card3.png';
}

// 設定できる背景テーマ選択の表示
String setCardTheme(String card) {
  print('setCardTheme処理開始');
  print(card);
  var selected = '0';
  switch (card) {
    case '0':
      selected = cardImg.cardTheme0;
      break;
    case '1':
      selected = cardImg.cardTheme1;
      break;
    case '2':
      selected = cardImg.cardTheme2;
      break;
    case '3':
      selected = cardImg.cardTheme3;
      break;
  }
  print('selected: ' + selected);
  // ignore: void_checks
  return selected;
}
