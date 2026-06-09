import 'package:flutter/material.dart';
import 'package:futbol_teams_app/domain/class_user.dart';

class SessionConfig {

  final UserData? user;
  final bool isLogged;
  final ThemeMode themeMode;
  final Color seedColor;
  final double fontScale;

  const SessionConfig(
{
    this.user,
    this.isLogged = false,
    this.themeMode = ThemeMode.system,
    this.seedColor = Colors.blue,
    this.fontScale = 1.0,
  });

  SessionConfig copyWith({
    UserData? user,
    bool? isLogged,
    ThemeMode? themeMode,
    Color? seedColor,
    double? fontScale,
  }) {

    return SessionConfig(
      user: user ?? this.user,
      isLogged: isLogged ?? this.isLogged,
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
      fontScale: fontScale ?? this.fontScale,
    );
  }
}