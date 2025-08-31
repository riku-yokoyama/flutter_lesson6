import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // プッシュ遷移用の関数
  void _pushPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NextPage();
    }));
  }

  // モーダル遷移用の関数
  void _modalPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) {
              return NextPage();
            },
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}

// 遷移先画面のウィジェット
class NextPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next Pageです',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(onPressed: () {}, child: Text('戻る'))
          ],
        ),
      ),
    );
  }
}
