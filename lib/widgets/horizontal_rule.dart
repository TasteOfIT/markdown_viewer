import 'package:flutter/material.dart';
import 'package:markdown_viewer/utils/colors.dart';

class HorizontalRule extends StatelessWidget {
  const HorizontalRule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Divider(height: 1, thickness: 1, color: Color(ruleColor)),
    );
  }
}
