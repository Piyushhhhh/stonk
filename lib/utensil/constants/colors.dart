import 'package:flutter/material.dart';

class AppColors {
  static bool isLightMode = false;

  static Color primary() => const Color(0xFF21CE99);
  static Color accent() => const Color(0xFFF5AC6E);
  static Color positive() => const Color(0xFF00C287);
  static Color negative() => const Color(0xFFEA394E);

  static Color text({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode ? Colors.black : Colors.white;
  static Color fadeText({bool? lightMode}) => lightMode ?? AppColors.isLightMode
      ? const Color(0xFF49494D)
      : const Color(0xFFA8A8A8);
  static Color elementText({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? const Color(0xFFA8A8A8)
          : const Color(0xFFD8D8D8);
  static Color background({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? const Color(0xFFF2F2F2)
          : const Color(0xFF1C1E29);
  static Color containerBackground({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? Colors.white
          : const Color(0xFF262C3A);
  static Color elementBackground({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? const Color(0xFFF2F2F2)
          : const Color(0xFF49494D);
  static Color elementBackground2({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? const Color(0xFFF2F2F2)
          : const Color(0xFF1A1A1B);
  static Color activeElementBackground({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode
          ? const Color(0xFFD8D8D8)
          : const Color(0xFF49494D);
  static Color whiteBlack({bool? lightMode}) =>
      lightMode ?? AppColors.isLightMode ? Colors.white : Colors.black;

  static Color portfolioEquity() => const Color(0xFF21CE99);
  static Color portfolioDerivative() => const Color(0xFFFFDC5D);
  static Color portfolioEtf() => const Color(0xFF95A1C0);
  static Color portfolioMutualFund() => const Color(0xFFF9A671);
  static Color portfolioCurrency() => const Color(0xFFF3705A);
  static Color portfolioNft() => const Color(0xFFBFC4CC);
  static Color portfolioCryptoToken() => const Color(0xFF60B7FF);
  static Color portfolioCryptoProtocol() => const Color(0xFF5B3F7B);
  static Color portfolioMetals() => Colors.teal;
  static Color portfolioPrivateEquity() => Colors.amber;
  static Color portfolioCollectible() => Colors.green;
  static Color portfolioRealEstate() => Colors.blueAccent;
  static Color portfolioOther() => Colors.grey;

  static Color boosted() => const Color(0xFF7B61FF);
  static Color allocation() => const Color(0xFF60B7FF);
  static Color secondContainerColor() =>
      AppColors.isLightMode ? const Color(0xFFF2F2F2) : const Color(0xFFF3B3E5);

  static Color textSnackBar() => Colors.white;
  static Color negativeSnackbar() => const Color(0xFFE8444D);

  static Color bottomNavSelected() => const Color(0xFF62C696);
  static Color bottomNavUnselected() => const Color(0xFF95A1C0);

  static Color appBarIcon() => accent();

  static Color link() => const Color(0xFF55ACEE);

  static Color inputIcon() => const Color(0xFF999999);

  static Color custom(Color lightModeColor, Color darkModeColor) {
    return isLightMode ? lightModeColor : darkModeColor;
  }

  static ButtonColors get buttonDefault =>
      ButtonColors(buttonColor: primary(), textColor: Colors.white);
  static ButtonColors get buttonRed => ButtonColors(
      buttonColor: negative(),
      borderColor: negative(),
      textColor: Colors.white);
  static Color disabledButton() => isLightMode
      ? const Color(0xff49494D).withOpacity(.1)
      : const Color(0xff49494D);

  static Color border() => const Color(0xFFD8D8D8);
  static Color divider({bool? lightMode}) => lightMode ?? AppColors.isLightMode
      ? const Color(0xFFD8D8D8)
      : const Color(0xff49494D);
  static Color editTextLine() => const Color(0xFFDFDFDF);
  static List<Color> percentageChartColorList() => [
        primary(),
        accent(),
        portfolioCurrency(),
        portfolioCryptoToken(),
        const Color(0xff9B63DB),
      ];
}

class ButtonColors {
  final Color buttonColor;
  final Color? borderColor;
  final Color textColor;

  ButtonColors(
      {required this.buttonColor, this.borderColor, required this.textColor});
}
