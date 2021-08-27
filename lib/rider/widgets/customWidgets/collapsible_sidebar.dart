library collapsible_sidebar;

import 'dart:math' as math show pi;

import 'package:flutter/material.dart';
import 'package:get_smart_ride_cas/app/theme/colors.dart';
import 'package:get_smart_ride_cas/rider/widgets/custom_drawer/slidebar/collapsible_container.dart';
import 'package:get_smart_ride_cas/rider/widgets/custom_drawer/slidebar/collapsible_item.dart';
import 'package:get_smart_ride_cas/rider/widgets/custom_drawer/slidebar/collapsible_item_selection.dart';
import 'package:get_smart_ride_cas/rider/widgets/custom_drawer/slidebar/collapsible_item_widget.dart';

class CollapsibleSidebar extends StatefulWidget {
  const CollapsibleSidebar({
    @required this.items,
    this.title = 'Lorem Ipsum',
    this.titleStyle,
    this.textStyle,
    this.toggleTitleStyle,
    this.toggleTitle = 'Collapse',
    this.avatarImg,
    this.height = double.infinity,
    this.minWidth = 70,
    this.maxWidth = 250,
    this.borderRadius = 15,
    this.iconSize = 40,
    this.toggleButtonIcon = Icons.chevron_right,
    this.backgroundColor = AppColors.mainColor,
    this.selectedIconBox = const Color(0xff2F4047),
    this.selectedIconColor = const Color(0xff4AC6EA),
    this.selectedTextColor = const Color(0xffF3F7F7),
    this.unselectedIconColor = const Color(0xff6A7886),
    this.unselectedTextColor = const Color(0xffC0C7D0),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.screenPadding = 0,
    this.showToggleButton = true,
    this.topPadding = 0,
    this.bottomPadding = 10,
    this.fitItemsToBottom = false,
    @required this.body,
  });

  final String title, toggleTitle;
  final TextStyle titleStyle, textStyle, toggleTitleStyle;
  final Widget body;
  final avatarImg;
  final bool showToggleButton, fitItemsToBottom;
  final List<CollapsibleItem> items;
  final double height,
      minWidth,
      maxWidth,
      borderRadius,
      iconSize,
      padding = 10,
      itemPadding = 10,
      topPadding,
      bottomPadding,
      screenPadding;
  final IconData toggleButtonIcon;
  final Color backgroundColor,
      selectedIconBox,
      selectedIconColor,
      selectedTextColor,
      unselectedIconColor,
      unselectedTextColor;
  final Duration duration;
  final Curve curve;
  @override
  _CollapsibleSidebarState createState() => _CollapsibleSidebarState();
}

class _CollapsibleSidebarState extends State<CollapsibleSidebar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _widthAnimation;
  CurvedAnimation _curvedAnimation;
  double tempWidth;

  var _isCollapsed = true;
  double _currWidth, _delta, _delta1By4, _delta3by4, _maxOffsetX, _maxOffsetY;
  int _selectedItemIndex;

  @override
  void initState() {
    super.initState();

    tempWidth = widget.maxWidth > 270 ? 270 : widget.maxWidth;

    _currWidth = widget.minWidth;
    _delta = tempWidth - widget.minWidth;
    _delta1By4 = _delta * 0.25;
    _delta3by4 = _delta * 0.75;
    _maxOffsetX = widget.padding * 2 + widget.iconSize;
    _maxOffsetY = widget.itemPadding * 2 + widget.iconSize;
    for (var i = 0; i < widget.items.length; i++) {
      if (!widget.items[i].isSelected) continue;
      _selectedItemIndex = i;
      break;
    }

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _controller.addListener(() {
      _currWidth = _widthAnimation.value;
      if (_controller.isCompleted) _isCollapsed = _currWidth == widget.minWidth;
      setState(() {});
    });
  }

  void _animateTo(double endWidth) {
    _widthAnimation = Tween<double>(
      begin: _currWidth,
      end: endWidth,
    ).animate(_curvedAnimation);
    _controller.reset();
    _controller.forward();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _currWidth += details.primaryDelta;
    if (_currWidth > tempWidth)
      _currWidth = tempWidth;
    else if (_currWidth < widget.minWidth)
      _currWidth = widget.minWidth;
    else
      setState(() {});
  }

  void _onHorizontalDragEnd(DragEndDetails _) {
    if (_currWidth == tempWidth)
      setState(() => _isCollapsed = false);
    else if (_currWidth == widget.minWidth)
      setState(() => _isCollapsed = true);
    else {
      var threshold = _isCollapsed ? _delta1By4 : _delta3by4;
      var endWidth = _currWidth - widget.minWidth > threshold
          ? tempWidth
          : widget.minWidth;
      _animateTo(endWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        widget.body,
        Padding(
          padding: EdgeInsets.all(widget.screenPadding),
          child: GestureDetector(
            onHorizontalDragUpdate: _onHorizontalDragUpdate,
            onHorizontalDragEnd: _onHorizontalDragEnd,
            child: CollapsibleContainer(
              height: widget.height,
              width: _currWidth,
              padding: widget.padding,
              borderRadius: widget.borderRadius,
              color: widget.backgroundColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _avatar,
                  SizedBox(
                    height: widget.topPadding,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      reverse: widget.fitItemsToBottom,
                      child: Stack(
                        children: [
                          CollapsibleItemSelection(
                            height: _maxOffsetY,
                            offsetY: _maxOffsetY * _selectedItemIndex,
                            color: widget.selectedIconBox,
                            duration: widget.duration,
                            curve: widget.curve,
                          ),
                          Column(
                            children: _items,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: widget.bottomPadding,
                  ),
                  widget.showToggleButton
                      ? Divider(
                    color: widget.unselectedIconColor,
                    indent: 5,
                    endIndent: 5,
                    thickness: 1,
                  )
                      : SizedBox(
                    height: 5,
                  ),
                  widget.showToggleButton
                      ? _toggleButton
                      : SizedBox(
                    height: widget.iconSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget get _avatar {
  //   return CollapsibleItemWidget(
  //     padding: widget.itemPadding,
  //     offsetX: _offsetX,
  //     scale: _fraction,
  //     leading: CollapsibleAvatar(
  //       backgroundColor: widget.unselectedIconColor,
  //       avatarSize: widget.iconSize,
  //       name: widget.title,
  //    //   avatarImg: widget.avatarImg,
  //       textStyle: _textStyle(widget.backgroundColor, widget.titleStyle),
  //     ),
  //     title: widget.title,
  //     textStyle: _textStyle(widget.unselectedTextColor, widget.titleStyle),
  //   );
  // }

  List<Widget> get _items {
    return List.generate(widget.items.length, (index) {
      var item = widget.items[index];
      var iconColor = widget.unselectedIconColor;
      var textColor = widget.unselectedTextColor;
      if (item.isSelected) {
        iconColor = widget.selectedIconColor;
        textColor = widget.selectedTextColor;
      }
      return CollapsibleItemWidget(
        padding: widget.itemPadding,
        offsetX: _offsetX,
        scale: _fraction,
        leading: Icon(
          item.icon,
          size: widget.iconSize,
          color: iconColor,
        ),
        title: item.text,
        textStyle: _textStyle(textColor, widget.textStyle),
        onTap: () {
          if (item.isSelected) return;
          item.onPressed();
          item.isSelected = true;
          widget.items[_selectedItemIndex].isSelected = false;
          setState(() => _selectedItemIndex = index);
        },
      );
    });
  }

  Widget get _toggleButton {
    return CollapsibleItemWidget(
      padding: widget.itemPadding,
      offsetX: _offsetX,
      scale: _fraction,
      leading: Transform.rotate(
        angle: _currAngle,
        child: Icon(
          widget.toggleButtonIcon,
          size: widget.iconSize,
          color: widget.unselectedIconColor,
        ),
      ),
      title: widget.toggleTitle,
      textStyle:
      _textStyle(widget.unselectedTextColor, widget.toggleTitleStyle),
      onTap: () {
        _isCollapsed = !_isCollapsed;
        var endWidth = _isCollapsed ? widget.minWidth : tempWidth;
        _animateTo(endWidth);
      },
    );
  }

  double get _fraction => (_currWidth - widget.minWidth) / _delta;
  double get _currAngle => -math.pi * _fraction;
  double get _offsetX => _maxOffsetX * _fraction;

  TextStyle _textStyle(Color color, TextStyle style) {
    return style == null
        ? TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: color,
    )
        : style.copyWith(color: color);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}