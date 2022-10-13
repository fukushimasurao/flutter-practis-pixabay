import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PixabayPage(),
    );
  }
}

class PixabayPage extends StatefulWidget {
  const PixabayPage({super.key});

  @override
  State<PixabayPage> createState() => _PixabayPageState();
}

class _PixabayPageState extends State<PixabayPage> {
  // 初期値を用意する
  List hits = [];

  Future<void> fetchImages(String text) async {
    final response = await Dio().get(
        'https://pixabay.com/api/?key=30523579-ac10442b817f8d76f382240fa&q=$text&image_type=photo&pretty=true&per_page=100');

    hits = response.data['hits'];
    setState(() {});
  }

  @override
  void initState() {
    // initStateは最初に１度だけ呼ばれる。
    super.initState();
    fetchImages('花');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          initialValue: '花',
          decoration: const InputDecoration(
            fillColor: Colors.white,
            filled: true,
          ),
          onFieldSubmitted: (text) {
            fetchImages(text);
          },
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3),
          itemCount: hits.length,
          itemBuilder: (context, index) {
            final hit = hits[index];
            return InkWell(
              onTap: () async {
                // print(hit['likes']);
                // urlから画像をダウンロード
                final response = await Dio().get(hit['webformatURL'],
                    options: Options(responseType: ResponseType.bytes));

                // 画像データをファイルに保存
                // 一時的に保存可能なファイルを取得
                final dir = await getTemporaryDirectory();

                // ふぁいるを保存する。
                File file = await File('${dir.path}/image.png')
                    .writeAsBytes(response.data);

                // print(file.path);
                // shereパッケージを呼び出し共有
                Share.shareFiles([file.path]);
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    hit['previewURL'],
                    fit: BoxFit.cover,
                  ),
                  // alignment: Alignment.bottomRight,

                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Text('${hit['likes']}'),
                              const Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 14,
                              ),
                              Text('${hit['likes']}'),
                            ],
                          ))),
                ],
              ),
            );
          }),
    );
  }
}
