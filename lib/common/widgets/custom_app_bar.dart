import 'package:com.hzztai.mdt/common/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final PreferredSizeWidget child;
  final Color color;
  final SystemUiOverlayStyle uiStyle;
  final Widget leading;
  final String title;
  final Widget action;

  final bool needBack;

  CustomAppbar({
    this.child,
    this.color,
    this.uiStyle,
    this.leading,
    this.title: '',
    this.action,
    this.needBack: false,
  });

  Size get preferredSize => Size.fromHeight(titleH + (child?.preferredSize?.height ?? 0.0));

  double get titleH => kToolbarHeight;

  bool get hasBottom => child != null;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Color(0xFF000000),
          systemNavigationBarDividerColor: null,
          statusBarColor: primaryColor,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Material(
          color: primaryColor,
          elevation: 0.0,
          child: Semantics(
            explicitChildNodes: true,
            child: Container(
              decoration: BoxDecoration(
                color: color ?? primaryColor,
                boxShadow: appBarShadow,
              ),
              child: SafeArea(
                top: true,
                child: child ??
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        leading ??
                            Container(
                              width: 60,
                              child: leading ?? needBack
                                  ? IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                            ),
                        Text(title, style: TextStyle(color: Colors.white, fontSize: 22)),
                        action ??
                            Container(
                              width: 60,
                              child: action ?? Container(),
                            ),
                      ],
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
