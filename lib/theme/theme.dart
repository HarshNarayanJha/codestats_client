import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff186584),
      surfaceTint: Color(0xff186584),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc1e8ff),
      onPrimaryContainer: Color(0xff004d67),
      secondary: Color(0xff4e616c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd1e6f3),
      onSecondaryContainer: Color(0xff364954),
      tertiary: Color(0xff5f5a7d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe5deff),
      onTertiaryContainer: Color(0xff474364),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fafe),
      onSurface: Color(0xff171c1f),
      onSurfaceVariant: Color(0xff40484d),
      outline: Color(0xff71787d),
      outlineVariant: Color(0xffc0c7cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ecff2),
      primaryFixed: Color(0xffc1e8ff),
      onPrimaryFixed: Color(0xff001e2b),
      primaryFixedDim: Color(0xff8ecff2),
      onPrimaryFixedVariant: Color(0xff004d67),
      secondaryFixed: Color(0xffd1e6f3),
      onSecondaryFixed: Color(0xff091e28),
      secondaryFixedDim: Color(0xffb5c9d7),
      onSecondaryFixedVariant: Color(0xff364954),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff1b1736),
      tertiaryFixedDim: Color(0xffc9c2ea),
      onTertiaryFixedVariant: Color(0xff474364),
      surfaceDim: Color(0xffd6dade),
      surfaceBright: Color(0xfff6fafe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffeaeef2),
      surfaceContainerHigh: Color(0xffe5e9ed),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003b50),
      surfaceTint: Color(0xff186584),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff2e7494),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff253943),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5c707c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff363252),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6e698c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fafe),
      onSurface: Color(0xff0d1215),
      onSurfaceVariant: Color(0xff30373c),
      outline: Color(0xff4c5358),
      outlineVariant: Color(0xff676e73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ecff2),
      primaryFixed: Color(0xff2e7494),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff025c7a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5c707c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff445763),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6e698c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff555173),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc3c7cb),
      surfaceBright: Color(0xfff6fafe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffe5e9ed),
      surfaceContainerHigh: Color(0xffd9dde1),
      surfaceContainerHighest: Color(0xffced2d6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003042),
      surfaceTint: Color(0xff186584),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004f6a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1b2f39),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff384c57),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2c2848),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff4a4566),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fafe),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff262d32),
      outlineVariant: Color(0xff434a4f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff8ecff2),
      primaryFixed: Color(0xff004f6a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff00374b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff384c57),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff223540),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff4a4566),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff332f4f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb5b9bd),
      surfaceBright: Color(0xfff6fafe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffedf1f5),
      surfaceContainer: Color(0xffdfe3e7),
      surfaceContainerHigh: Color(0xffd1d5d9),
      surfaceContainerHighest: Color(0xffc3c7cb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ecff2),
      surfaceTint: Color(0xff8ecff2),
      onPrimary: Color(0xff003548),
      primaryContainer: Color(0xff004d67),
      onPrimaryContainer: Color(0xffc1e8ff),
      secondary: Color(0xffb5c9d7),
      onSecondary: Color(0xff1f333d),
      secondaryContainer: Color(0xff364954),
      onSecondaryContainer: Color(0xffd1e6f3),
      tertiary: Color(0xffc9c2ea),
      onTertiary: Color(0xff312c4c),
      tertiaryContainer: Color(0xff474364),
      onTertiaryContainer: Color(0xffe5deff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdfe3e7),
      onSurfaceVariant: Color(0xffc0c7cd),
      outline: Color(0xff8a9297),
      outlineVariant: Color(0xff40484d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inversePrimary: Color(0xff186584),
      primaryFixed: Color(0xffc1e8ff),
      onPrimaryFixed: Color(0xff001e2b),
      primaryFixedDim: Color(0xff8ecff2),
      onPrimaryFixedVariant: Color(0xff004d67),
      secondaryFixed: Color(0xffd1e6f3),
      onSecondaryFixed: Color(0xff091e28),
      secondaryFixedDim: Color(0xffb5c9d7),
      onSecondaryFixedVariant: Color(0xff364954),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff1b1736),
      tertiaryFixedDim: Color(0xffc9c2ea),
      onTertiaryFixedVariant: Color(0xff474364),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f12),
      surfaceContainerLow: Color(0xff171c1f),
      surfaceContainer: Color(0xff1b2023),
      surfaceContainerHigh: Color(0xff262b2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb2e3ff),
      surfaceTint: Color(0xff8ecff2),
      onPrimary: Color(0xff002939),
      primaryContainer: Color(0xff5698b9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffcbdfed),
      onSecondary: Color(0xff142832),
      secondaryContainer: Color(0xff7f94a0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffdfd7ff),
      onTertiary: Color(0xff262141),
      tertiaryContainer: Color(0xff928cb2),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd6dde3),
      outline: Color(0xffacb3b8),
      outlineVariant: Color(0xff8a9197),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inversePrimary: Color(0xff004e69),
      primaryFixed: Color(0xffc1e8ff),
      onPrimaryFixed: Color(0xff00131d),
      primaryFixedDim: Color(0xff8ecff2),
      onPrimaryFixedVariant: Color(0xff003b50),
      secondaryFixed: Color(0xffd1e6f3),
      onSecondaryFixed: Color(0xff00131d),
      secondaryFixedDim: Color(0xffb5c9d7),
      onSecondaryFixedVariant: Color(0xff253943),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff110c2b),
      tertiaryFixedDim: Color(0xffc9c2ea),
      onTertiaryFixedVariant: Color(0xff363252),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff404548),
      surfaceContainerLowest: Color(0xff04080b),
      surfaceContainerLow: Color(0xff191e21),
      surfaceContainer: Color(0xff24282c),
      surfaceContainerHigh: Color(0xff2e3336),
      surfaceContainerHighest: Color(0xff393e42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe0f3ff),
      surfaceTint: Color(0xff8ecff2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff8acbee),
      onPrimaryContainer: Color(0xff000d15),
      secondary: Color(0xffe0f3ff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb1c6d3),
      onSecondaryContainer: Color(0xff000d15),
      tertiary: Color(0xfff3edff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc5bee6),
      onTertiaryContainer: Color(0xff0b0625),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeaf1f7),
      outlineVariant: Color(0xffbcc4c9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inversePrimary: Color(0xff004e69),
      primaryFixed: Color(0xffc1e8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff8ecff2),
      onPrimaryFixedVariant: Color(0xff00131d),
      secondaryFixed: Color(0xffd1e6f3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5c9d7),
      onSecondaryFixedVariant: Color(0xff00131d),
      tertiaryFixed: Color(0xffe5deff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc9c2ea),
      onTertiaryFixedVariant: Color(0xff110c2b),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff4c5154),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2023),
      surfaceContainer: Color(0xff2c3134),
      surfaceContainerHigh: Color(0xff373c3f),
      surfaceContainerHighest: Color(0xff43474b),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
