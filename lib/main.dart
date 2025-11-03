import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  /* プッシュ遷移用の関数 */
  void _pushPage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NextPage(id: 1, name: 'プッシュ遷移');
    }));
  }

  /* モーダル遷移用の関数 */
  void _modalPage() {
    Navigator.push(
        // Navidatorは画面遷移を管理する。contextはスタックで保存される画面情報において
        // 今どこにいるかを示す情報。
        context,
        MaterialPageRoute(
            // 次にどのように画面遷移するかを示す属性
            builder: (context) {
              return NextPage(
                id: 2,
                name: 'モーダル遷移',
              );
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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                _pushPage();
              },
              child: Text('プッシュ遷移')),
          ElevatedButton(
              onPressed: () {
                _modalPage();
              },
              child: Text('モーダル遷移'))
        ],
      )),
    );
  }
}

// 遷移先画面のウィジェット
class NextPage extends StatelessWidget {
  /* コンストラクタ */
  NextPage({required this.id, required this.name});
  // 遷移元ID
  final int id;
  // 画面名
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next page'),
      ),

      /* 遷移先ページのボディ部 */
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next Pageです id = $id, name = $name',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                // idによって遷移先を変える
                child: Text(id == 1 ? '戻る' : '閉じる'))
          ],
        ),
      ),
    );
  }
}
