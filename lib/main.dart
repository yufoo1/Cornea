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


import 'package:cornea/login/pages/login_page.dart';
import 'package:flutter/material.dart';

import 'package:cornea/navigation_bar/custom_appbar_sample.dart';
import 'package:cornea/navigation_bar/convex_bottom_bar.dart';
import 'package:cornea/navigation_bar/convex_button_demo.dart';
import 'package:cornea/navigation_bar/default_appbar_demo.dart';

import 'folding_cell/folding_cell_list_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => DefaultAppBarDemo(),
        "/custom": (BuildContext context) => LoginPage(),
        "/fab": (BuildContext context) => ConvexButtonDemo(),
      },
    );
  }
}
