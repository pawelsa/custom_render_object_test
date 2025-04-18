import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextWidget extends SingleChildRenderObjectWidget {
  final String text;
  final Widget? trailingWidget;
  final bool shouldExpand;

  const CustomTextWidget({
    required this.text,
    this.trailingWidget,
    this.shouldExpand = false,
    super.key,
  }) : super(child: trailingWidget);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomTextWidget(
      text: text,
      shouldExpand: shouldExpand,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderCustomTextWidget renderObject) {
    renderObject
      ..text = text
      ..shouldExpand = shouldExpand;
  }
}

class RenderCustomTextWidget extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  RenderCustomTextWidget({
    required String text,
    required bool shouldExpand,
  })  : _text = text,
        _shouldExpand = shouldExpand;

  String _text;
  bool _shouldExpand;
  late TextPainter _textPainter = _buildTextPainter();

  TextPainter _buildTextPainter() {
    return TextPainter(
      text: TextSpan(
        text: _text,
        style: TextStyle(fontSize: 16.0, color: Colors.black),
      ),
      textDirection: TextDirection.ltr,
      maxLines: _shouldExpand && child != null ? null : 2,
    );
  }

  set text(String value) {
    if (_text == value) return;
    _text = value;
    _textPainter = _buildTextPainter();
    markNeedsLayout();
  }

  set shouldExpand(bool value) {
    if (_shouldExpand == value) return;
    _shouldExpand = value;
    _textPainter = _buildTextPainter();
    markNeedsLayout();
  }

  bool _isUsingChild = false;

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = BoxParentData();
    }
  }

  @override
  void performLayout() {
    final maxTwoLinesPainter = _buildTextPainter()..maxLines = 2;
    maxTwoLinesPainter.layout(
        maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);
    _textPainter.layout(
        maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

    var child = this.child;
    var shouldShowChild = maxTwoLinesPainter.didExceedMaxLines;
    _isUsingChild = child != null && shouldShowChild;
    if (!_isUsingChild) {
      size = _textPainter.size;
      return;
    }

    child!.layout(constraints.loosen(), parentUsesSize: true);
    _textPainter.layout(maxWidth: constraints.maxWidth - child.size.width);

    (child.parentData as BoxParentData).offset = Offset(_textPainter.width, 0);

    size = Size(
      constraints.maxWidth,
      max(_textPainter.height, child.size.height),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
    final child = this.child;
    if (_isUsingChild && child != null) {
      var childOffset = (child.parentData as BoxParentData).offset;
      context.paintChild(child, childOffset + offset);
    }
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    final RenderBox? child = this.child;
    if (child != null && _isUsingChild) {
      final BoxParentData childParentData = child.parentData! as BoxParentData;
      return result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child.hitTest(result, position: transformed);
        },
      );
    }
    return false;
  }
}
