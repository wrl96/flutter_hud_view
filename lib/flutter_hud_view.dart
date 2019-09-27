library flutter_hud_view;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/// [HUDView]为对外开放的唯一接口
/// 通过[HUDView.of]拿到当前context的[_HUD]实例进行相关操作
/// 最简单的调用例子（显示圆圈，点击关闭）
/// HUDView.of(context).init(tapClose: true).show(autoDestroy:true);
class HUDView {

  /// [_hudMap] 保存[_HUD]实例
  /// 建议使用[_HUD].show(autoDestroy=true) 或在页面切换时调用 [_HUD].destroy()
  /// 来销毁实例，以免造成内存泄漏
  static Map<BuildContext, _HUD> _hudMap = {};

  /// 通过[of]从[_hudMap]中获取相关实例
  /// 当[_hudMap]中没有实例的时候会新建一个但不会保存
  /// 只有再调用[_HUD.init()]后才会保存
  static _HUD of(BuildContext context) {
    if (_hudMap.containsKey(context)) {
      return _hudMap[context];
    }
    _HUD hud = _HUD(context);
    return hud;
  }
}


class _HUD {

  /// 调用HUD的[BuildContext]
  BuildContext context;

  /// HUD类型，默认为[HUDType.ANDROID]
  /// [HUDType.IOS] 是默认的iOS样式，透明背景，黑色半透明对话框，白色文字
  /// [HUDType.ANDROID] 是默认的Android样式，灰色半透明背景，白色对话框，
  /// 文字颜色默认为[ThemeData.accentColor]
  /// [HUDType.CUSTOM] 是自定义样式，透明背景，如果设置为[HUDType.CUSTOM],
  /// 则[customWidget]不能为空
  HUDType hudType;

  /// HUD指示类型，默认为[HUDIndicatorType.INDICATOR]
  /// [HUDIndicatorType.INDICATOR] 是默认Loading样式，HUDType相关
  /// [HUDIndicatorType.SUCCESS] 显示Success Icon
  /// [HUDIndicatorType.FAIL] 显示Failure Icon
  /// [HUDIndicatorType.CUSTOM] 可以自定义显示的Icon
  HUDIndicatorType hudIndicatorType;

  /// 提示文字，不设置不显示
  String text;

  /// HUD指示颜色，不设置参考[HUDType]说明
  Color hudColor;

  /// HUD文字颜色，不设置参考[HUDType]说明
  Color hudTextColor;

  /// HUD对话框背景颜色，不设置参考[HUDType]说明
  Color hudBackgroundColor;

  /// 全屏背景颜色，不设置参考[HUDType]说明
  Color backgroundColor;

  /// 自定义显示Widget，当[HUDType]设置为[HUDType.CUSTOM]时有效
  Widget customWidget;

  /// 自定义显示Icon，当[HUDIndicatorType]设置为[HUDIndicatorType.CUSTOM]时有效
  Widget customIndicatorWidget;

  /// 点击对话框外部是否关闭
  bool tapClose;

  /// 是否设置倒计时自动关闭
  bool timerClose;

  /// 倒计时关闭，单位 秒
  int timerSeconds;

  /// 显示状态
  bool _visible;

  /// 自动销毁
  bool _autoDestroy;

  /// 持有的[_HUDWidget.key]
  GlobalKey<_HUDWidgetState> _hudWidgetStateKey;

  /// 倒计时器
  Timer _timer;

  _HUD(this.context) {
    this._hudWidgetStateKey = GlobalKey();
    this._visible = false;
    this._autoDestroy = false;
  }


  /// 初始化函数
  /// 为空的项目将会被赋默认值
  /// 该实例会被保存到[HUDView._hudMap]中
  _HUD init({
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
  }) {
    this.hudType = hudType;
    this.hudIndicatorType = hudIndicatorType;
    this.text = text;
    this.hudColor = hudColor;
    this.hudTextColor = hudTextColor;
    this.hudBackgroundColor = hudBackgroundColor;
    this.backgroundColor = backgroundColor;
    this.customWidget = customWidget;
    this.customIndicatorWidget = customIndicatorWidget;
    this.tapClose = tapClose;
    this.timerClose = timerClose;
    this.timerSeconds = timerSeconds;
    if (this.hudType == HUDType.CUSTOM) assert(customWidget != null);
    if (this.hudIndicatorType == HUDIndicatorType.CUSTOM) assert(customIndicatorWidget != null);
    if (this.timerClose) assert(timerSeconds != null);
    if (this.backgroundColor == null) {
      if (this.hudType == HUDType.ANDROID) {
        this.backgroundColor = Color(0xA0000000);
      } else {
        this.backgroundColor = Color(0x00FFFFFF);
      }
    }
    HUDView._hudMap[context] = this;
    return this;
  }


  /// 更新属性
  /// 如果某项不赋值则保持原来的值
  /// 例如执行
  /// [HUDView].of(context).init(hudType: [HUDType.IOS], text: 'init').update(text: 'update')
  /// 则该HUD的属性为 hudType: [HUDType.IOS], text: 'update'
  _HUD update({
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
  }) {
    assert(HUDView._hudMap.containsKey(this.context));
    if (hudType != null) this.hudType = hudType;
    if (hudIndicatorType != null) this.hudIndicatorType = hudIndicatorType;
    if (text != null) this.text = text;
    if (hudColor != null) this.hudColor = hudColor;
    if (hudTextColor != null) this.hudTextColor = hudTextColor;
    if (hudBackgroundColor != null) this.hudBackgroundColor = hudBackgroundColor;
    if (backgroundColor != null) this.backgroundColor = backgroundColor;
    if (customWidget != null) this.customWidget = customWidget;
    if (customIndicatorWidget != null) this.customIndicatorWidget = customIndicatorWidget;
    if (tapClose != null ) this.tapClose = tapClose;
    if (timerClose != null) this.timerClose = timerClose;
    if (timerSeconds != null) this.timerSeconds = timerSeconds;
    if (this.hudType == HUDType.CUSTOM) assert(customWidget != null);
    if (this.hudIndicatorType == HUDIndicatorType.CUSTOM) assert(customIndicatorWidget != null);
    if (this.timerClose) {
      assert(this.timerSeconds != null);
      this._timer?.cancel();
    }
    return this;
  }


  /// 展示HUD
  /// [autoDestroy] 自动销毁，仅在[timerClose] = true时有效
  /// 关闭时自动销毁该[context]在[HUDView]中的实例
  _HUD show({autoDestroy = false}) {
    _autoDestroy = autoDestroy;
    if (timerClose) {
      _timer?.cancel();
      _timer = Timer(Duration(seconds: timerSeconds), () {
        if (_autoDestroy) {
          this.destroy();
        } else {
          this.dismiss();
        }
      });
    }
    if (!_visible) {
      Navigator.of(context).push(
          PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, _, __) {
                _visible = true;
                return _HUDWidget(_hudWidgetStateKey, this);
              }));
    } else {
      _hudWidgetStateKey.currentState.updateConfig(this);
    }
    return this;
  }

  /// 关闭HUD
  /// 如果在关闭后还需要调用[update]，请使用此函数
  /// 如果在关闭后不再需要[update]，请使用[destroy]
  _HUD dismiss() {
    this._timer?.cancel();
    _autoDestroy = false;
    if (_visible) {
      Navigator.of(_hudWidgetStateKey.currentContext).pop();
      _hudWidgetStateKey = GlobalKey();
      _visible = false;
    }
    return this;
  }


  /// 销毁HUD
  /// 在关闭该HUD的基础上销毁了该[context]在[HUDView]中的实例
  /// 销毁后再调用[update]会报错，如需使用请重新调用[init]
  _HUD destroy() {
    this.dismiss();
    HUDView._hudMap.remove(context);
    return this;
  }
}

enum HUDType {
  ANDROID,
  IOS,
  CUSTOM,
}

enum HUDIndicatorType {
  INDICATOR,
  SUCCESS,
  FAIL,
  CUSTOM,
}

class _HUDWidget extends StatefulWidget {
  final _HUD config;

  _HUDWidget(Key key, this.config) : super(key:key);

  @override
  _HUDWidgetState createState() => _HUDWidgetState();
}

class _HUDWidgetState extends State<_HUDWidget> {
  _HUD _config;

  void updateConfig(_HUD newConfig) {
    setState(() {
      _config = newConfig;
    });
  }

  @override
  void initState() {
    super.initState();
    _config = widget.config;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _config.backgroundColor,
      body: GestureDetector(
        child: Container(
            color: Color(0x00FFFFFF),
            constraints: BoxConstraints.expand(),
            child: _getCenterContent()
        ),
        onTap: () {
          if (_config.tapClose) {
            if (_config._autoDestroy) {
              _config.destroy();
            } else {
              _config.dismiss();
            }
          }
        },
      ),
    );
  }

  Widget _getCenterContent() {
    return Center(
      child: _config.hudType == HUDType.CUSTOM ? _config.customWidget : Container(
        height: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: _getHUDBackgroundColor(),
          borderRadius: BorderRadius.circular(10.0),
        ),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width * 0.3,
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getIndicatorWidget(),
            Offstage(
              offstage: _config.text.isEmpty,
              child: SizedBox(height: _config.hudIndicatorType == HUDIndicatorType.INDICATOR ? 20.0 : 10.0,),
            ),
            Offstage(
              offstage: _config.text.isEmpty,
              child: Text(
                _config.text,
                style: TextStyle(
                    color: _getHUDTextColor(),
                    fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color _getHUDBackgroundColor() {
    if (_config.hudBackgroundColor != null) return _config.hudBackgroundColor;
    if (_config.hudType == HUDType.ANDROID) return Colors.white;
    if (_config.hudType == HUDType.IOS) return Colors.black.withAlpha(200);
    return Color(0x00FFFFFF);
  }

  Color _getHUDColor() {
    if (_config.hudColor != null) return _config.hudColor;
    if (_config.hudType == HUDType.ANDROID) return Theme.of(context).accentColor;
    if (_config.hudType == HUDType.IOS) return Colors.white;
    return Color(0x00FFFFFF);
  }

  Color _getHUDTextColor() {
    if (_config.hudTextColor != null) return _config.hudTextColor;
    if (_config.hudType == HUDType.ANDROID) return Theme.of(context).accentColor;
    if (_config.hudType == HUDType.IOS) return Colors.white;
    return Color(0x00FFFFFF);
  }

  Widget _getIndicatorWidget() {
    if (_config.hudIndicatorType == HUDIndicatorType.CUSTOM) return _config.customIndicatorWidget;
    if (_config.hudIndicatorType == HUDIndicatorType.SUCCESS) return Icon(Icons.check, color: _getHUDColor(), size: MediaQuery.of(context).size.width * 0.15,);
    if (_config.hudIndicatorType == HUDIndicatorType.FAIL) return Icon(CupertinoIcons.clear_thick, color: _getHUDColor(), size: MediaQuery.of(context).size.width * 0.15,);
    if (_config.hudType == HUDType.ANDROID) return CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation(_getHUDColor()));
    if (_config.hudType == HUDType.IOS) return CupertinoActivityIndicator(
      radius: MediaQuery.of(context).size.width * 0.05,
    );
    return Container();
  }
}
