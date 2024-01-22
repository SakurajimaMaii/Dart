import 'package:flutter/material.dart';

// Flutter 实战·第二版
// StatelessWidget 简介
class Echo extends StatelessWidget {
  const Echo({Key? key, required this.content, this.background = Colors.grey})
      : super(key: key);

  final String content;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: background,
        child: Text(content),
      ),
    );
  }
}

// Flutter 实战·第二版
// Context 示例
class ContextRoute extends StatelessWidget {
  const ContextRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Context测试"),
      ),
      body: Builder(
        builder: (context) {
          // 在 widget 树中向上查找最近的父级 Scaffold widget
          Scaffold? scaffold =
              context.findAncestorWidgetOfExactType<Scaffold>();
          // 直接返回 AppBar的title， 此处实际上是Text("Context测试")
          return (scaffold!.appBar as AppBar).title!;
        }
      )
    );
  }
}
