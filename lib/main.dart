// Copyright 2019 KagurazakaHanabi<i@yaerin.com>
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:io';

import 'package:dailypics/model/app.dart';
import 'package:dailypics/pages/splash.dart';
import 'package:dailypics/widget/error.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:scoped_model/scoped_model.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux) {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  }
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(details);
  };
  runApp(TujianApp());
}

class TujianApp extends StatelessWidget {
  final AppModel model = AppModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: model,
      child: CupertinoApp(
        title: '图鉴日图',
        home: SplashPage(),
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget child) {
          CupertinoThemeData theme = CupertinoTheme.of(context).copyWith(
            brightness: MediaQuery.platformBrightnessOf(context),
          );
          CupertinoTextThemeData textTheme = theme.textTheme;
          return CupertinoTheme(
            data: theme,
            child: DefaultTextStyle(
              style: textTheme.textStyle,
              child: child,
            ),
          );
        },
        supportedLocales: const [
          Locale('zh'),
          Locale('ja'),
          Locale('en'),
        ],
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      ),
    );
  }
}
