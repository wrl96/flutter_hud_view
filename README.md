# flutter_hud_view

一个高可定制化的、无侵入的、支持链式调用的指示条组件（支持进度条指示，自定义提示等）

## Demo

## 使用

在 `pubspec.yml` 文件中添加依赖

```yaml
dependencies:
  flutter_hud_view: ^1.0.0
```

在需要使用的地方import package

```dart
import 'package:flutter_hud_view/flutter_hud_view.dart';
```

基础使用

```dart
/// 初始化
HUDView.of(context).init();

/// 更新部分属性
HUDView.of(context).update();

/// 展示
HUDView.of(context).show();

/// 关闭
HUDView.of(context).dismiss(); /// 或 HUDView.of(context).destroy(); 具体区别请看代码注释
```

## 主要函数

### init()

声明
```dart
init({
  HUDType hudType = HUDType.ANDROID,
  HUDIndicatorType hudIndicatorType = HUDIndicatorType.INDICATOR,
  String text = '',
  Color hudColor,
  Color hudTextColor,
  Color hudBackgroundColor,
  Color backgroundColor,
  Widget customWidget,
  Widget customIndicatorWidget,
  bool tapClose = false,
  bool timerClose = false,
  int timerSeconds,
});
```

参数说明

|参数名		|描述	|默认值   |
|:---------------|:---------------|:-------|
|hudType| HUD类型，HUDType.IOS, HUDType.ANDROID, HUDType.CUSTOM可选|HUDType.ANDROID|
|hudIndicatorType| 指示样式，HUDIndicatorType.INDICATOR(指示器样式，与HUDType相关), HUDIndicatorType.SUCCESS, HUDIndicatorType.FAIL, HUDIndicatorType.CUSTOM可选| HUDIndicatorType.INDICATOR|
|text| 提示文字，不设置不显示|
|hudColor| 指示颜色| HUDType.IOS: Colors.white <br> HUDType.ANDROID: Theme.of(context).accentColor|
|hudTextColor| 提示文字颜色|HUDType.IOS: Colors.white <br> HUDType.ANDROID: Theme.of(context).accentColor|
|hudBackgroundColor| HUDView背景色|HUDType.IOS: Colors.black.withAlpha(200) <br> HUDType.ANDROID: Colors.white|
|backgroundColor|全屏背景色 |HUDType.IOS: Color(0x00FFFFFF) <br> Other: Color(0xA0000000)|
|customWidget| 自定义Widget，当hudType为HUDType.CUSTOM时必填 | null|
|customIndicatorWidget| 指示器Widget，当hudIndicatorType为HUDIndicatorType.CUSTOM时必填 | null|
|tapClose| 点击HUDView时是否关闭 | false|
|timerClose| 是否开启倒计时关闭 | false|
|timerSeconds| 倒计时关闭秒数，timerClose为true时必填| null |


### update()

声明
```dart
update({
  HUDType hudType,
  HUDIndicatorType hudIndicatorType,
  String text,
  Color hudColor,
  Color hudTextColor,
  Color hudBackgroundColor,
  Color backgroundColor,
  Widget customWidget,
  Widget customIndicatorWidget,
  bool tapClose,
  bool timerClose,
  int timerSeconds,
});
```

参数说明

|参数名		|描述	|默认值   |
|:---------------|:---------------|:-------|
|hudType| HUD类型，HUDType.IOS, HUDType.ANDROID, HUDType.CUSTOM可选|HUDType.ANDROID|
|hudIndicatorType| 指示样式，HUDIndicatorType.INDICATOR(指示器样式，与HUDType相关), HUDIndicatorType.SUCCESS, HUDIndicatorType.FAIL, HUDIndicatorType.CUSTOM可选| HUDIndicatorType.INDICATOR|
|text| 提示文字，不设置不显示|
|hudColor| 指示颜色| HUDType.IOS: Colors.white <br> HUDType.ANDROID: Theme.of(context).accentColor|
|hudTextColor| 提示文字颜色|HUDType.IOS: Colors.white <br> HUDType.ANDROID: Theme.of(context).accentColor|
|hudBackgroundColor| HUDView背景色|HUDType.IOS: Colors.black.withAlpha(200) <br> HUDType.ANDROID: Colors.white|
|backgroundColor|全屏背景色 |HUDType.IOS: Color(0x00FFFFFF) <br> Other: Color(0xA0000000)|
|customWidget| 自定义Widget，当hudType为HUDType.CUSTOM时必填 | null|
|customIndicatorWidget| 指示器Widget，当hudIndicatorType为HUDIndicatorType.CUSTOM时必填 | null|
|tapClose| 点击HUDView时是否关闭 | false|
|timerClose| 是否开启倒计时关闭 | false|
|timerSeconds| 倒计时关闭秒数，timerClose为true时必填| null |

### show()

声明
```dart
show({
  autoDestroy = false
});
```

参数说明

|参数名		|描述	|默认值   |
|:---------------|:---------------|:-------|
|autoDestroy| 在HUDView关闭后是否自动销毁，只有tapClose或timerClose为true时有效|false|

### dismiss()

声明
```dart
dismiss();
```

### destroy()

声明
```dart
destroy();
```

## 需要注意的地方

- update()需要在init()后调用
- 调用destroy()后，如需再次显示需要init()

### init和update的使用场景

如果完全不使用update是可以的

使用update可以在同一个context下显示HUDView时复用widget，提高性能

最常见的情况是在联网请求时，当点击按钮后会弹出Loading的HUDView，直到请求结束拿到返回值需要告知用户操作结果

例子代码
```dart
Future request() async {
  HUDView.of(context).init(text: 'Loading').show();
  doRequest(onResponse: () {
    HUDView.of(context).update(hudIndicatorType: HUDIndicatorType.SUCCESS, text: 'Success', timerClose: true, timerSeconds: 2).show(autoDestroy: true);
  });
}
```

如果使用了init，则会覆盖之前所有的update修改

### 为什么要有destroy

由于HUDView针对context的widget进行了缓存，如果不销毁已经失效的context的widget的话，将会出现内存泄漏的情况，所以引入了destroy

那么destroy需要在什么时候使用呢？

- 一次完整的操作结束后
- 页面pop或push之前

例如上面的代码，一次request会展示两次HUDView，所以可以视为一次完整的操作，我们只需在最后一次操作的show函数中设置autoDestroy参数为true即可

或者是当某个页面不再使用了的时候

例如登录，如果登录成功，将会跳转到另一个页面，永远不会再退回来
```dart
Future login() async {
  HUDView.of(context).init(text: 'Loading').show();
  bool result = await login();
  if (result) {
    HUDView.of(context).destroy(); /// 此时使用dismiss()也可以关掉HUDView，但是由于页面会跳转再也不会回来，所以内部的缓存就永久留下了
    Navigator.of(context).push();
  } else {
    HUDView.of(context).update(hudIndicatorType: HUDIndicatorType.FAIL, text: 'Some Error', timerClose: true, timerSeconds: 2).show(autoDestroy: true);  /// 完成了一次完整操作，但是由于后面还会进行再次登录，所以show函数中的autoDestroy就是可选的
  }
}
```

## 开发计划

- 增加带进度的指示器类型