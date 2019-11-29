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
var hud = HUDView.of(context);

/// 更新属性
hud.update();

/// 展示
hud.show();

/// 关闭
hud.dismiss();
```

## 主要函数

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
  Function closeCallback,
  int countdown,
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
|closeCallback| 关闭回调函数 | null|
|countdown| 倒计时关闭秒数，默认不自动关闭 | null |

### show()

声明
```dart
show();
```

### dismiss()

声明
```dart
dismiss();
```

## 开发计划

- 增加带进度的指示器类型
- iOS的菊花有点问题需要修复
