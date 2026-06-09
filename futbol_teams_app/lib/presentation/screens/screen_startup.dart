import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:futbol_teams_app/presentation/providers/provider_users.dart';
import 'package:futbol_teams_app/presentation/providers/provider_futbol_teams.dart';
import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';

import 'package:futbol_teams_app/data/database/database_helper.dart';

final String appLogoPath = 'lib/data/sources/logo_app.png';
class AppStartup extends ConsumerStatefulWidget{
  const AppStartup({super.key});

    @override
    ConsumerState<AppStartup> createState() => _AppStartupState();
    }

class _AppStartupState extends ConsumerState<AppStartup>  {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await DatabaseHelper().database;
    await ref.read(usersProvider.notifier).loadUsers();
    await ref.read(futbolTeamsProvider.notifier).loadTeams();
    await ref.read(sessionProvider.notifier).loadSession();
    await ref.read(sessionProvider.notifier).loadTheme();

    final sessionContext = ref.watch(sessionProvider);
    
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      if (sessionContext.isLogged) {
        context.go('/home');
        return;
      }
      context.go('/login'); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(appLogoPath,
              width: 250,
              height: 250,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
