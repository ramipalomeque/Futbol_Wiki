import 'package:flutter_riverpod/legacy.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:futbol_teams_app/domain/class_user.dart';
import 'package:futbol_teams_app/domain/class_session_config.dart';

import 'package:futbol_teams_app/data/database/database_helper.dart';

import 'package:flutter/material.dart';

final sessionProvider =
    StateNotifierProvider<SessionNotifier, SessionConfig>( (ref) => SessionNotifier(),);

class SessionNotifier extends StateNotifier<SessionConfig> {

  final DatabaseHelper dbHelper = DatabaseHelper();

  SessionNotifier(): super(const SessionConfig())
  {
    loadSession();
    loadTheme();
  }

  Future<void> loadSession() async {

    final prefs = await SharedPreferences.getInstance();

    final isLogged = prefs.getBool('isLogged') ?? false;
    final email = prefs.getString('user_email');
    UserData? user;

    if (isLogged && email != null)
     {
      user = await dbHelper.getUserByEmail(email);
    }

    state = state.copyWith( user: user, isLogged: isLogged,);
  }

  Future<void> login(UserData user) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isLogged', true);
    await prefs.setString('user_email', user.email,);
    state = state.copyWith(user: user, isLogged: true,);
  }

  Future<void> logout() async {

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = state.copyWith(
      themeMode: ThemeMode.system,
      seedColor: const Color(0xFF6750A4),
      fontScale: 1.0,
    );
  }

Future<void> loadTheme() async {

    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString('themeMode') ?? 'system';
    final colorValue = prefs.getInt('seedColor') ??  Color(0xFF6750A4).toARGB32();
    final fontScale = prefs.getDouble('fontScale') ?? 1.0;
    ThemeMode mode;
    switch (themeString) {
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }

    state = state.copyWith(
      themeMode: mode,
      seedColor: Color(colorValue),
      fontScale: fontScale,
    );
  }

  Future<void> changeThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode',mode.name,);
    state = state.copyWith(themeMode: mode, );
  }

  Future<void> changeSeedColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('seedColor',color.toARGB32(),);
    state = state.copyWith(seedColor: color,);
  }


  Future<void> changeFontScale(double scale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('fontScale',scale,);
    state = state.copyWith(fontScale: scale,);
    
  }
ThemeData buildTheme(Brightness brightness) {

  final colorScheme = ColorScheme.fromSeed(
    seedColor: state.seedColor,
    brightness: brightness,
  );

  final baseTheme = ThemeData(
    colorScheme: colorScheme,
    brightness: brightness,
    useMaterial3: true,
  );

  return baseTheme.copyWith(

    appBarTheme: AppBarTheme(
      backgroundColor: Color.alphaBlend(
        state.seedColor.withValues(alpha: 0.08),
        colorScheme.surface,
      ),
    ),

    scaffoldBackgroundColor: Color.alphaBlend(
      state.seedColor.withValues(alpha: 0.12),
      colorScheme.surface,
    ),

    cardTheme: CardThemeData(
      color: Color.alphaBlend(
        state.seedColor.withValues(alpha: 0.12),
        colorScheme.surfaceContainer,
      ),
    ),

    textTheme: baseTheme.textTheme.copyWith(
    displayLarge: baseTheme.textTheme.displayLarge?.copyWith(fontSize:(baseTheme.textTheme.displayLarge?.fontSize ?? 57) * state.fontScale,),
    displayMedium: baseTheme.textTheme.displayMedium?.copyWith(fontSize:(baseTheme.textTheme.displayMedium?.fontSize ?? 45) * state.fontScale,),
    displaySmall: baseTheme.textTheme.displaySmall?.copyWith(fontSize:(baseTheme.textTheme.displaySmall?.fontSize ?? 36) * state.fontScale,),

    headlineLarge: baseTheme.textTheme.headlineLarge?.copyWith(fontSize:(baseTheme.textTheme.headlineLarge?.fontSize ?? 32) * state.fontScale,),
    headlineMedium: baseTheme.textTheme.headlineMedium?.copyWith(fontSize:(baseTheme.textTheme.headlineMedium?.fontSize ?? 28) * state.fontScale,),
    headlineSmall: baseTheme.textTheme.headlineSmall?.copyWith(fontSize:(baseTheme.textTheme.headlineSmall?.fontSize ?? 24) * state.fontScale,),

    titleLarge: baseTheme.textTheme.titleLarge?.copyWith(fontSize:(baseTheme.textTheme.titleLarge?.fontSize ?? 22) * state.fontScale,),
    titleMedium: baseTheme.textTheme.titleMedium?.copyWith(fontSize:(baseTheme.textTheme.titleMedium?.fontSize ?? 16) * state.fontScale,),
    titleSmall: baseTheme.textTheme.titleSmall?.copyWith(fontSize:(baseTheme.textTheme.titleSmall?.fontSize ?? 14) * state.fontScale,),

    bodyLarge: baseTheme.textTheme.bodyLarge?.copyWith(fontSize:(baseTheme.textTheme.bodyLarge?.fontSize ?? 16) * state.fontScale,),
    bodyMedium: baseTheme.textTheme.bodyMedium?.copyWith(fontSize:(baseTheme.textTheme.bodyMedium?.fontSize ?? 14) * state.fontScale,),
    bodySmall: baseTheme.textTheme.bodySmall?.copyWith(fontSize:(baseTheme.textTheme.bodySmall?.fontSize ?? 12) * state.fontScale,),

    labelLarge: baseTheme.textTheme.labelLarge?.copyWith(fontSize:(baseTheme.textTheme.labelLarge?.fontSize ?? 14) * state.fontScale,),
    labelMedium: baseTheme.textTheme.labelMedium?.copyWith(fontSize:(baseTheme.textTheme.labelMedium?.fontSize ?? 12) * state.fontScale,),
    labelSmall: baseTheme.textTheme.labelSmall?.copyWith(fontSize:(baseTheme.textTheme.labelSmall?.fontSize ?? 11) * state.fontScale,),
    ),
  );
}

/*
ThemeData buildTheme(Brightness brightness) {

  final colorScheme = ColorScheme.fromSeed(
    seedColor: state.seedColor,
    brightness: brightness,
  );

  final baseTheme = ThemeData(
    colorScheme: colorScheme,
    brightness: brightness,
    useMaterial3: true,
  );

  TextStyle? scaleStyle(TextStyle? style) {
    if (style == null) return null;

    return style.copyWith(
      fontSize: (style.fontSize ?? 14) * state.fontScale,
    );
  }

  return baseTheme.copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Color.alphaBlend(
        state.seedColor.withValues(alpha: 0.08),
        colorScheme.surface,
      ),
    ),

    scaffoldBackgroundColor: Color.alphaBlend(
      state.seedColor.withValues(alpha: 0.12),
      colorScheme.surface,
    ),

    cardTheme: CardThemeData(
      color: Color.alphaBlend(
        state.seedColor.withValues(alpha: 0.12),
        colorScheme.surfaceContainer,
      ),
    ),

    textTheme: baseTheme.textTheme.copyWith(
      displayLarge: scaleStyle(baseTheme.textTheme.displayLarge),
      displayMedium: scaleStyle(baseTheme.textTheme.displayMedium),
      displaySmall: scaleStyle(baseTheme.textTheme.displaySmall),
      headlineLarge: scaleStyle(baseTheme.textTheme.headlineLarge),
      headlineMedium: scaleStyle(baseTheme.textTheme.headlineMedium),
      headlineSmall: scaleStyle(baseTheme.textTheme.headlineSmall),
      titleLarge: scaleStyle(baseTheme.textTheme.titleLarge),
      titleMedium: scaleStyle(baseTheme.textTheme.titleMedium),
      titleSmall: scaleStyle(baseTheme.textTheme.titleSmall),
      bodyLarge: scaleStyle(baseTheme.textTheme.bodyLarge),
      bodyMedium: scaleStyle(baseTheme.textTheme.bodyMedium),
      bodySmall: scaleStyle(baseTheme.textTheme.bodySmall),
      labelLarge: scaleStyle(baseTheme.textTheme.labelLarge),
      labelMedium: scaleStyle(baseTheme.textTheme.labelMedium),
      labelSmall: scaleStyle(baseTheme.textTheme.labelSmall),
    ),
  );
}*/
  
}