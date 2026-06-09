import 'package:go_router/go_router.dart';

import 'package:futbol_teams_app/presentation/screens/screen_login.dart';
import 'package:futbol_teams_app/presentation/screens/screen_singup.dart';
import 'package:futbol_teams_app/presentation/screens/screen_startup.dart';
import 'package:futbol_teams_app/presentation/screens/screen_home.dart';
import 'package:futbol_teams_app/presentation/screens/screen_team_details.dart';
import 'package:futbol_teams_app/presentation/screens/screen_team_add.dart';
import 'package:futbol_teams_app/presentation/screens/screen_team_list.dart';
import 'package:futbol_teams_app/presentation/screens/screen_profile.dart';
import 'package:futbol_teams_app/presentation/screens/screen_settings.dart';

import 'package:futbol_teams_app/domain/class_futbol_team.dart';


final appRouter = GoRouter(
  initialLocation: '/startup',
  routes: [
    GoRoute(
      path: '/startup',
      builder: (context, state) => const AppStartup(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const ScreenLogin(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const ScreenSingUp(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => ScreenHome(),
    ),
    GoRoute(
      path: '/team/details',
      builder: (context, state) => ScreenTeamDetails(teamID: state.extra as int),
    ),
    GoRoute(
      path: '/team/add',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return ScreenTeamAdd(
          teamID: data?['teamID'] as int?,
          type: data!['type'] as TeamType,
        );
      },
    ),
    GoRoute(
      path: '/team/edit',
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>?;
        return ScreenTeamAdd(
          teamID: data?['teamID'] as int?,
          type: data!['type'] as TeamType,
        );
      },
    ),
    GoRoute(
      path: '/team/list',
      builder: (context, state) => ScreenTeamList(filterTeams: state.extra as String),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ScreenProfile(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const ScreenSettings(),
    ),
  ],
);