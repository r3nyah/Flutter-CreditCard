import 'package:flutter/material.dart';

const double kCardHeight = 225;
const double kCardWidth = 356;
const double kSpaceBetweenCard = 24;
const double kSpaceBetweenUnselectCard = 32;
const double kSpaceUnselectedCardToTop = 320;
const Duration kAnimationDuration = Duration(milliseconds: 245);

class CreditCardData {
  CreditCardData({
    required this.backgroundColor
  });
  final Color backgroundColor;
}