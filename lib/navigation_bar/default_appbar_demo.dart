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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../folding_cell/folding_cell.dart';
import 'components/chip_item.dart';
import 'components/choose_tab_item.dart';
import 'components/colors_item.dart';
import 'components/gradient_item.dart';
import 'components/heading.dart';
import 'components/radio_item.dart';
import 'data.dart';
import 'model/badge.dart';
import 'model/choice_value.dart';

class DefaultAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DefaultAppBarDemo>
    with SingleTickerProviderStateMixin {
  static const kStyles = [
    ChoiceValue<TabStyle>(
      title: 'TabStyle.reactCircle',
      label: 'Appbar use reactCircle style',
      value: TabStyle.reactCircle,
    ),
  ];

  static final kTabTypes = [
    ChoiceValue<List<TabItem>>(
      title: 'Icon Tab',
      label: 'Appbar use icon with Tab',
      value: Data.items(image: false),
    ),
  ];
  var _tabItems = kTabTypes.first;

  ChoiceValue<TabStyle> _style = kStyles.first;
  ChoiceValue<Curve> _curve = Data.curves.first;
  Color _barColor = Data.namedColors.first.color;
  Color _shadowColor = Data.namedColors.first.color;
  Gradient? _gradient = Data.gradients.first;
  myBadge? _badge;
  TabController? _tabController;
  TextDirection _textDirection = TextDirection.ltr;
  late Set<int> openedIndices = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabItems.value.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var options = <Widget>[
      const Heading('Appbar Color'),
      ColorsItem(Data.namedColors, _barColor, _onBarColorChanged),
      const Heading('Shadow Color'),
      ColorsItem(Data.namedShadowColors, _shadowColor, _onShadowColorChanged),
      const Heading('Background Gradient'),
      GradientItem(Data.gradients, _gradient, _onGradientChanged),
      const Heading('Badge Chip'),
      ChipItem(Data.badges, _badge, _onBadgeChanged),
      const Heading('Tab Type'),
      ChooseTabItem(kTabTypes, _tabItems, _onTabItemTypeChanged),
      const Heading('Tab Style'),
    ];
    options.addAll(kStyles.map((s) => RadioItem<TabStyle>(s, _style,
        s.value == TabStyle.flip && kIsWeb ? _onNothing : _onStyleChanged)));
    if (_style.value != TabStyle.fixed &&
        _style.value != TabStyle.fixedCircle) {
      options.add(const Heading('Animation Curve'));
      options.addAll(
          Data.curves.map((c) => RadioItem<Curve>(c, _curve, _onCurveChanged)));
    }

    return Directionality(
      textDirection: _textDirection,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cornea'),
          backgroundColor: _barColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.style),
              color: Colors.white,
              tooltip: "Custom style example",
              onPressed: () => Navigator.of(context).pushNamed('/custom'),
            ),
            IconButton(
              icon: Icon(Icons.radio_button_checked),
              color: Colors.white,
              tooltip: "convex button example",
              onPressed: () => Navigator.of(context).pushNamed('/fab'),
            ),
            IconButton(
              icon: Icon(Icons.looks_two),
              color: Colors.white,
              tooltip: "change tab by controller",
              onPressed: () {
                _tabController?.animateTo(2);
              },
            ),
          ],
        ),
        body: TabBarView(
            controller: _tabController,
            children: _tabItems.value
                .map((i) => i.title == 'Schedule'
                    ? Stack(
                        children: [
                          Image.asset(
                            'assets/images/background.png',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          ),
                          Center(
                            child: ListView.builder(
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return FoldingCell(
                                  key: ValueKey(index),
                                  foldingState: openedIndices.contains(index) ? FoldingState
                                      .open : FoldingState.close,
                                  onChanged: (foldState) {
                                    if (foldState == FoldingState.open) {
                                      print('open cell -- $index');
                                      openedIndices.add(index);
                                    } else {
                                      print('close cell -- $index');
                                      openedIndices.remove(index);
                                    }
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      )
                    : Center(
                        child: Text(
                        '${i.title} Page',
                        style: TextStyle(fontSize: 30),
                      )))
                .toList(growable: false)),
        bottomNavigationBar: _badge == null
            ? ConvexAppBar(
                items: _tabItems.value,
                style: _style.value,
                curve: _curve.value,
                shadowColor: _shadowColor,
                backgroundColor: _barColor,
                gradient: _gradient,
                controller: _tabController,
                onTap: (int i) => debugPrint('select index=$i'),
              )
            : ConvexAppBar.badge(
                {
                  3: _badge!.text,
                  4: Icons.assistant_photo,
                  2: Colors.redAccent
                },
                badgePadding: _badge!.padding,
                badgeColor: _badge!.badgeColor,
                badgeBorderRadius: _badge!.borderRadius,
                badgeMargin: EdgeInsets.only(bottom: 20, left: 30),
                items: _tabItems.value,
                style: _style.value,
                curve: _curve.value,
                shadowColor: _shadowColor,
                backgroundColor: _barColor,
                gradient: _gradient,
                controller: _tabController,
                onTap: (int i) => debugPrint('select index=$i'),
              ),
      ),
    );
  }

  void _onTabItemTypeChanged(ChoiceValue<List<TabItem>>? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _tabItems = value;
    });
  }

  void _onNothing(ChoiceValue<TabStyle>? value) {}

  void _onStyleChanged(ChoiceValue<TabStyle>? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _style = value;
    });
  }

  void _onCurveChanged(ChoiceValue<Curve>? value) {
    if (value == null) {
      return;
    }
    setState(() {
      _curve = value;
    });
  }

  void _onBarColorChanged(Color value) {
    setState(() {
      _barColor = value;
    });
  }

  void _onShadowColorChanged(Color value) {
    setState(() {
      _shadowColor = value;
    });
  }

  void _onGradientChanged(Gradient? value) {
    setState(() {
      _gradient = value;
    });
  }

  void _onBadgeChanged(myBadge? value) {
    setState(() {
      _badge = value;
    });
  }
}
