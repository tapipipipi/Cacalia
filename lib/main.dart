import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String generatedText = 'Loading...';

  @override
  void initState() {
    super.initState();
    generateText();
  }

  Future<void> generateText() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: 'AIzaSyDvlwupnHlUINeIAt5yBGP1KASRGNqlwVA',
    );

    const prompt = 'I`ll send 2 sentences. compare and find common points. then create any topic and say like this ["Topic u generated"という話題でお話してみませんか？] no need other explain. 1.I hate u 2.I dont like u';
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
  Widget build(BuildContext context) {
    debugPrint("Generated Text: $generatedText"); // Log to confirm the UI update
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(generatedText), // Display generated text
        ),
      ),
    );
  }

}
