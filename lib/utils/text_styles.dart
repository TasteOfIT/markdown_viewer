import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/colors.dart';

const Map<ElementType, TextStyle> textStyles = {
  ElementType.link: TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed,
  ),
  ElementType.bold: TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.bold,
  ),
  ElementType.italic: TextStyle(
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.normal,
  ),
  ElementType.code: TextStyle(
    fontWeight: FontWeight.w300,
    backgroundColor: Color(backgroundCode),
    letterSpacing: 1.0,
  ),
  ElementType.plain: TextStyle(
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  ),
};
