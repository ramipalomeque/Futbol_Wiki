import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/go_router.dart';

import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';

void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context,ref) {
  final session = ref.watch(sessionProvider);
  final sessionNotifier = ref.read(sessionProvider.notifier);

  return MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: appRouter,
    theme: sessionNotifier.buildTheme(Brightness.light),
    darkTheme: sessionNotifier.buildTheme(Brightness.dark),
    themeMode: session.themeMode,
  );
  }
}

