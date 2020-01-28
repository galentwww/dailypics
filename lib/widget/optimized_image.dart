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

import 'package:flutter/cupertino.dart';

class OptimizedImage extends StatelessWidget {
  OptimizedImage(
    this.imageUrl, {
    Key key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.heroTag,
  })  : assert(imageUrl != null),
        assert(borderRadius != null),
        super(key: key);

  final String imageUrl;

  final double width;

  final double height;

  final BoxFit fit;

  final BorderRadius borderRadius;

  final Object heroTag;

  @override
  Widget build(BuildContext context) {
    bool isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    Widget result = ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            color: isDark ? const Color(0xFF1F1F1F) : const Color(0xFFE0E0E0),
            child: Image.asset('res/placeholder${isDark ? '-night' : ''}.jpg'),
          ),
          Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            frameBuilder: (_, Widget child, int frame, bool wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) return child;
              return AnimatedOpacity(
                child: child,
                curve: Curves.easeOut,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(milliseconds: 300),
              );
            },
          )
        ],
      ),
    );
    if (heroTag != null) {
      result = Hero(
        tag: heroTag,
        transitionOnUserGestures: true,
        child: result,
      );
    }
    return result;
  }
}
