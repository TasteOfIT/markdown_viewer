import 'package:flutter/material.dart';
import 'package:markdown_parser/markdown_parser.dart';
import 'package:markdown_viewer/utils/colors.dart';

const Map<ElemType, TextStyle> textStyles = {
  ElemType.link: TextStyle(
    decoration: TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed,
  ),
  ElemType.bold: TextStyle(
    fontWeight: FontWeight.bold,
  ),
  ElemType.italic: TextStyle(
    fontStyle: FontStyle.italic,
  ),
  ElemType.code: TextStyle(
    fontWeight: FontWeight.w300,
    backgroundColor: Color(backgroundCode),
    letterSpacing: 1.0,
  ),
  ElemType.text: TextStyle(),
};

const TextStyle fallbackHeading = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
