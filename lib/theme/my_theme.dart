import 'package:flutter/material.dart';
import 'package:storematic_flutter/utils/constants.dart';

class AppTheme {
  final String appBarColor;
  final String statusBarColor;
  final String sectionBgColor;
  final String sectionHeadingFontColor;
  final String sectionButtonColor;
  final String sectionButtonFontColor;
  final String cardTitleFontColor;
  final String cardSubtitleFontColor;
  final String cardPriceFontColor;
  final String circularCardTitleFontColor;
  final String appBgColor;
  final double borderRadiusDefault = 10;

  final double bannerWidgetBorderRadiusDefault = 0;
  final double elevation = 0;
  final double appBarHeightFactor = 0.15;
  final double appBarBottomHeightFactor = 0.4;
  final double drawerWidthFactor = 0.7;
  final int homePageGridNumOfColumnDefault = 2;
  final int categoryPageGridNumOfColumnDefault = 3;
  final double itemAspectRatioDefault = 4 / 6;
  final double itemWidthFactorDefault = 0.4;
  final double bannerAspectRatioDefault = 16 / 9;
  final double sectionMarginTopDefault = 0;
  final double sectionMarginBottomDefault = 0;
  final double sectionPaddingTopDefault = 0;
  final double sectionPaddingBottomDefault = 0;
  final double cardPaddingDefault = 5;
  final double cardMarginDefault = 4;
  final String gradientStartDefault = 'top_center';
  final String gradientEndDefault = 'bottom_center';

  int get appBarColorInt => DefaultColors.parseColor(this.appBarColor);

  int get statusBarColorInt => DefaultColors.parseColor(this.statusBarColor);
  int get sectionBgColorInt => DefaultColors.parseColor(this.sectionBgColor);
  int get sectionHeadingFontColorInt =>
      DefaultColors.parseColor(this.sectionHeadingFontColor);
  int get sectionButtonColorInt =>
      DefaultColors.parseColor(this.sectionButtonColor);
  int get sectionButtonFontColorInt =>
      DefaultColors.parseColor(this.sectionButtonFontColor);
  int get cardTitleFontColorInt =>
      DefaultColors.parseColor(this.cardTitleFontColor);
  int get cardSubtitleFontColorInt =>
      DefaultColors.parseColor(this.cardSubtitleFontColor);
  int get cardPriceFontColorInt =>
      DefaultColors.parseColor(this.cardPriceFontColor);
  int get circularCardTitleFontColorInt =>
      DefaultColors.parseColor(this.circularCardTitleFontColor);
  int get appBgColorInt => DefaultColors.parseColor(appBgColor);

  Color get appBarColorParsed => Color(this.appBarColorInt);
  Color get statusBarColorParsed => Color(this.statusBarColorInt);
  Color get sectionBgColorParsed => Color(this.sectionBgColorInt);
  Color get sectionHeadingFontColorParsed =>
      Color(this.sectionHeadingFontColorInt);
  Color get sectionButtonColorParsed => Color(this.sectionButtonColorInt);
  Color get sectionButtonFontColorParsed =>
      Color(this.sectionButtonFontColorInt);
  Color get cardTitleFontColorParsed => Color(this.cardTitleFontColorInt);
  Color get cardSubitleFontColorParsed => Color(this.cardSubtitleFontColorInt);
  Color get cardPriceFontColorParsed => Color(this.cardPriceFontColorInt);
  Color get circularCardTitleFontColorParsed =>
      Color(this.circularCardTitleFontColorInt);
  Color get appBgColorParsed => Color(this.appBgColorInt);

  AppTheme(
      {this.appBarColor = '#0000FF',
      this.statusBarColor = '#0000FF',
      this.sectionBgColor = '#FFFFFF',
      this.sectionButtonColor = '#0000FF',
      this.sectionButtonFontColor = '#FFFFFF',
      this.sectionHeadingFontColor = '#000000',
      this.cardPriceFontColor = '#80A4A8',
      this.cardSubtitleFontColor = '#80A4A8',
      this.cardTitleFontColor = '#80A4A8',
      this.circularCardTitleFontColor = '#000000',
      this.appBgColor = '#FFFFFF'});
}
