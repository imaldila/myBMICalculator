import 'package:flutter/material.dart';

import '../constants.dart';

class ButtonBottom extends StatelessWidget {
  ButtonBottom({Key? key, required this.buttonTitle, this.onTap})
      : super(key: key);

  final String buttonTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        child: Text(
          buttonTitle,
          style: kLargeButtonTextStyle,
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 5),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}