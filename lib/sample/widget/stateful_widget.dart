import 'package:flutter/material.dart';

// Flutter 实战·第二版
class GetStateObjectRoute extends StatefulWidget {
  const GetStateObjectRoute({Key? key}) : super(key: key);

  @override
  State<GetStateObjectRoute> createState() => _GetStateByGlobalKey();
}

// 在 widget 树中通过 Context 获取 State 对象
// context 对象有一个 findAncestorStateOfType( )方法，
// 该方法可以从当前节点沿着 widget 树向上查找指定类型的
// StatefulWidget 对应的 State 对象。下面是实现打开
// SnackBar 的示例：
class _GetStateByState extends State<GetStateObjectRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("在子树中获取 State 对象"),
      ),
      body: Center(
        child: Column(children: [
          Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                // ScaffoldState? state = context.findAncestorStateOfType();
                // state!.openDrawer();

                // 一般来说，如果 StatefulWidget 的状态是私有的（不应该向外部暴露），
                // 那么我们代码中就不应该去直接获取其 State 对象；如果 StatefulWidget
                // 的状态是希望暴露出的（通常还有一些组件的操作方法），我们则可以去直接
                // 获取其 State 对象。但是通过 context.findAncestorStateOfType 获取
                // StatefulWidget 的状态的方法是通用的，我们并不能在语法层面指定
                // StatefulWidget 的状态是否私有，所以在 Flutter 开发中便有了一个默认
                // 的约定：如果 StatefulWidget 的状态是希望暴露出的，应当在 StatefulWidget
                // 中提供一个 of 静态方法来获取其 State 对象，开发者便可直接通过该方法来获取；
                // 如果 State 不希望暴露，则不提供 of 方法。
                ScaffoldState state = Scaffold.of(context);
                state.openDrawer();
              },
              child: const Text("打开抽屉菜单"),
            );
          })
        ]),
      ),
      drawer: const Drawer(),
    );
  }
}

class _GetStateByOf extends State<GetStateObjectRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("在子树中获取状态"),
      ),
      body: Center(
        child: Column(children: [
          Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("我是SnackBar")));
              },
              child: const Text("显示 SnackBar"),
            );
          })
        ]),
      ),
    );
  }
}

class _GetStateByGlobalKey extends State<GetStateObjectRoute> {
  // 定义一个 globalKey , 由于 GlobalKey 要保持全局唯一性，
  // 我们使用静态变量存储。
  static final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey, //设置key
      appBar: AppBar(
        title: const Text("在子树中获取状态"),
      ),
      body: Center(
        child: Column(children: [
          Builder(builder: (context) {
            return ElevatedButton(
              onPressed: () {
                _globalKey.currentState!.openDrawer();
              },
              child: const Text("打开抽屉菜单"),
            );
          })
        ]),
      ),
      drawer: const Drawer(),
    );
  }
}
