import 'package:flutter/material.dart';

class BrandingAssets {
  const BrandingAssets._();

  static String logoFull(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/branding/logo_full_dark.png'
        : 'assets/branding/logo_full.png';
  }

  static String appIcon(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/branding/app_icon_dark.png'
        : 'assets/branding/app_icon.png';
  }
}
