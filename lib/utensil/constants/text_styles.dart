import 'package:flutter/cupertino.dart';
import 'package:flutter_app/utensil/constants/colors.dart';

class TextStyles {
  static const regular36 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 36,
  );
  static const regular32 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 32,
  );

  static const regular24 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 24,
  );

  static const regular22 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 22,
  );

  static const regular20 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 20,
  );

  static const regular18 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 18,
  );

  static const regular16 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 16,
  );

  static const regular14 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 14,
  );

  static const regular12 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 12,
  );

  static const regular10 = TextStyle(
    fontFamily: Fonts.ProximaNovaRegular,
    fontSize: 10,
  );

  static const bold10 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 10,
  );

  static const bold12 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 12,
  );

  static const bold14 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 14,
  );

  static const bold16 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 16,
  );

  static const bold18 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 18,
  );

  static const bold20 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 20,
  );

  static const bold22 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 22,
  );

  static const bold24 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 24,
  );
  static const bold28 = TextStyle(
    fontFamily: Fonts.ProximaNovaBold,
    fontSize: 28,
  );

  static const semibold12 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 12,
  );

  static const semibold14 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 14,
  );

  static const semibold16 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 16,
  );

  static const semibold18 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 18,
  );

  static const semibold20 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 20,
  );

  static const semibold24 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 24,
  );

  static const semibold22 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 22,
  );

  static const semibold36 = TextStyle(
    fontFamily: Fonts.ProximaNovaSemibold,
    fontSize: 36,
  );
}

extension TextStyleExt on TextStyle {
  TextStyle textColor() => withColor(AppColors.text());

  TextStyle withColor(Color color) => copyWith(color: color);

  TextStyle withAccent() => withColor(AppColors.accent());

  TextStyle withPrimary() => withColor(AppColors.primary());

  TextStyle withPositive() => withColor(AppColors.positive());

  TextStyle withNegative() => withColor(AppColors.negative());

  TextStyle withValueSentiment(double value) {
    if (value > 0) return withColor(AppColors.positive());
    if (value < 0) return withColor(AppColors.negative());
    return withColor(AppColors.text());
  }

  TextStyle withFadeText() => withColor(AppColors.fadeText());

  TextStyle withElementText() => withColor(AppColors.elementText());
}

class Fonts {
  Fonts._();

  // ignore: constant_identifier_names
  static const String ProximaNovaRegular = "ProximaNovaRegular";
  // ignore: constant_identifier_names
  static const String ProximaNovaSemibold = "ProximaNovaSemibold";
  // ignore: constant_identifier_names
  static const String ProximaNovaBold = "ProximaNovaBold";
  // ignore: constant_identifier_names
  static const String ProximaNovaLight = "ProximaNovaLight";
}
