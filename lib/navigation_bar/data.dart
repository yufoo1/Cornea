/*
 *  Copyright 2020 chaobinwu89@gmail.com
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:cornea/navigation_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'model/badge.dart';
import 'model/choice_value.dart';
import 'model/named_color.dart';

/// tab config used in example
class Data {
  static const gradients = [
    null,
  ];

  static const namedColors = [
    NamedColor(Colors.blue, 'Blue'),
  ];
  static const namedShadowColors = [
    NamedColor(Colors.black38, 'Black'),

  ];
  static const badges = [
    null,
    myBadge('hot',
        badgeColor: Colors.orange, padding: EdgeInsets.only(left: 7, right: 7)),
  ];

  static const curves = [
    ChoiceValue<Curve>(
      title: 'Curves.bounceInOut',
      label: 'The curve bounceInOut is used',
      value: Curves.bounceInOut,
    ),
  ];

  static List<TabItem> items({bool image = false}) {
    return [
      TabItem<IconData>(icon: Icons.schedule, title: 'Schedule'),
      TabItem<IconData>(icon: Icons.table_chart, title: "Statistics"),
      TabItem<IconData>(icon: Icons.home, title: 'Home'),
    ];
  }
}
