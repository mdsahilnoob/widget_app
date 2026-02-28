import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_brand_theme.dart';

abstract class ThemeFonts {
  static TextTheme resolve(AppBrandTheme brand, TextTheme base) =>
      switch (brand) {
        AppBrandTheme.nothing => base,
        AppBrandTheme.onePlus => GoogleFonts.outfitTextTheme(base),
        AppBrandTheme.iOS => GoogleFonts.interTextTheme(base),
      };
}
