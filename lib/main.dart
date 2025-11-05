import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_lesson6/widgets/row_info.dart';

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

/**
 * メイン画面
 */
class _MyHomePageState extends State<MyHomePage> {
  /* ListView画面から遷移先の詳細画面に渡すデータを定義する */
  // 要素にMapを格納したList
  List<Map<String, String>> contacts = [
    // 各要素(Map)を定義
    {'name': '山田 太郎', 'number': '080-1234-5678', 'address': '東京都'},
    {'name': '鈴木 一郎', 'number': '080-1234-5678', 'address': '千葉県'},
    {'name': '佐藤 花子', 'number': '080-1234-5678', 'address': '埼玉県'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),

        /* ボディ部(電話帳のリスト画面) */
        body: ListView.builder(
          itemCount: contacts.length,
          // ListView.builderはitemContに定義した数分itemBuilder内が繰り返される
          itemBuilder: (context, index) {
            /* 以下のリストタイルが三枚分繰り返される */
            return ListTile(
              // 電話アイコン
              leading: Icon(Icons.phone),
              // 名前 ** コードの説明は以下 **
              // contactsはMapを格納するListの2重配列のような構造
              // contacts[index] = contactsというリストのindex番目の要素を取得
              // ['name'] = 取り出した要素(= Map) のどの要素化をキー名を指定して取得
              // 最後の! = dartではMapの要素はnull許容の場合コンパイルエラーになるので、
              // 絶対にnullでないことの明示として!をつける
              title: Text(contacts[index]['name']!),
              // 電話番号
              subtitle: Text(contacts[index]['number']!),
              // 右矢印アイコン
              trailing: Icon(Icons.keyboard_arrow_right),
              // 詳細ページに遷移するコード
              onTap: () {
                // リストタイルを押したときの処理
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // MaterialPageRouteのbuilderプロパティにcontextを受け取ってDetailPageを返す無名関数を定義
                  return DetailPage(contact: contacts[index]);
                }));
              },
            );
          },
        ));
  }
}

/**
 * 遷移先の詳細画面
 */
class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.contact});

  // contactsの1要素であるcontact(Map)のコンストラクタ
  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${contact['name']}'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowInfo(
                    icon: Icon(Icons.account_circle_outlined),
                    contact: contact,
                    message: '名前',
                    mapKey: 'name')),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: RowInfo(
                    icon: Icon(Icons.phone),
                    contact: contact,
                    message: '電話番号',
                    mapKey: 'number')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowInfo(
                  icon: Icon(Icons.home),
                  contact: contact,
                  message: '住所',
                  mapKey: 'address'),
            ),
            // 電話アイコン付きボタン
            ElevatedButton.icon(
              // ★　Icons.phoneはウィジェットではないのでIconウィジェットの引数として渡す
              icon: Icon(Icons.phone),
              label: Text('電話をかける'),
              onPressed: () {
                // 電話をかけるボタン押下時の処理
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CallPage(contact: contact);
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}

/**
 * 電話画面（電話をかけるボタンを押した際の遷移先画面）
 */
class CallPage extends StatelessWidget {
  const CallPage({super.key, required this.contact});

  // 電話帳情報を格納するMap
  final Map<String, String> contact;

  @override
  Widget build(BuildContext context) {
    // サイズボックス
    const size = SizedBox(height: 90);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            // 氏名
            Text(
              '${contact['name']}',
              style: TextStyle(fontSize: 35),
            ),
            // 電話番号
            Text(
              '${contact['number']}',
              style: TextStyle(fontSize: 17),
            ),
            size,
            // 横並びに丸画像を並べる
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.mic_off),
                ),
                CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.keyboard_alt_outlined),
                ),
                CircleAvatar(
                  radius: 35,
                  child: Icon(Icons.phone_disabled_sharp),
                ),
              ],
            ),
            size,
            size,
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.phone_missed_sharp,
                size: 29,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(25),
                  backgroundColor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
