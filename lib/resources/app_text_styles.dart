import 'package:flutter/material.dart';
import 'package:sirenhead_test/resources/app_colors.dart';
class AppTextStyles {
  static const TextStyle incoming24w600 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.callScreenWhite
  );

  static const TextStyle home20w600 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.callScreenWhite
  );
  static const TextStyle rateUs16w600 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );
  static const TextStyle rateUs18w600 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white
  );
  static  TextStyle option = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
    decoration: TextDecoration.underline,
  );
  static const TextStyle black18w600 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );
  static const TextStyle rateUs24w800 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w800,
      color: Colors.black
  );

  static const TextStyle chat16w700 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.black
  );
  static const TextStyle home14w600 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.appPurple
  );
  static const TextStyle incoming14w400 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.callScreenGrey
  );
  static const TextStyle black14w400 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black
  );
  static const TextStyle chat14w400Black = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black
  );
  static const TextStyle chat14w400White = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white
  );
  static const TextStyle incoming16w400 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.callScreenGrey
  );
  static const TextStyle incoming14w600 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.callScreenWhite
  );
  static const TextStyle black14w600 = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black
  );
  static const TextStyle white18w700 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white
  );
}


const gradientBackground = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF00ABF5),
      Color(0xFF0230D3),
    ],
  ),
);