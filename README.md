# pixabay

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# 以下メモ

flutterでパッケージ追加

`flutter pub add XXX`

Http通信をする、bioを追加する

```bash
flutter pub add bio
```

### Future型を受け取る時

Future型は時間がかかる。
async,awaitを利用する。
引数にも、Futureをつけてあげる。

### initState

initStateは最初に１度だけ呼ばれる。

### intを文字列にする

'${int}'でok

### ウィジェットを重ねる

Stackでラップする。

### finalとは

後から変数に再代入できなくなる。
finalを使うと、型宣言しなくても良くなる。
