import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode
        ? ThemeData(
            fontFamily: "SfPro",
            colorScheme: const ColorScheme.dark(),
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (BuildContext context) => IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(CupertinoIcons.back,
                      size: 26.r,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.white)),
            ),
          )
        : ThemeData(
            fontFamily: "SfPro",
            colorScheme: const ColorScheme.light(),
            actionIconTheme: ActionIconThemeData(
              backButtonIconBuilder: (BuildContext context) => IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: Icon(CupertinoIcons.back,
                      size: 26.r,
                      color: Theme.of(context).brightness == Brightness.light
                          ? Colors.white
                          : Colors.white)),
            ),
          );
  }
}
