import 'package:futbol_teams_app/domain/class_futbol_team.dart';


import 'package:flutter_riverpod/legacy.dart';
import 'package:futbol_teams_app/data/database/database_helper.dart';


final futbolTeamsProvider =
    StateNotifierProvider<TeamsNotifier, List<Team>>(
  (ref) => TeamsNotifier(),
);

class TeamsNotifier extends StateNotifier<List<Team>> {
  TeamsNotifier() : super([]) {
    loadTeams();
  }

  final DatabaseHelper db = DatabaseHelper();

  Future<void> loadTeams() async {
    final teams = await db.getTeams();
    state = teams;
  }

Future<bool> addTeam(Team team) async {
  
  final existsInState = state.any((t) =>
      t.name.toLowerCase() == team.name.toLowerCase() &&
      t.country.toLowerCase() == team.country.toLowerCase() &&
      t.type == team.type);

  if (existsInState) return false;

  final teamIndb = await db.teamExists(team.name, team.country);

  if (teamIndb != null) {
    team = team.copyWith(id: teamIndb.id, state: 'active');
    await db.updateTeam(team);
  }
  else  {await db.insertTeam(team);}

  await loadTeams();
  return true;  
}

  Future<bool> updateTeam(Team team) async {
    final existsInState = state.any((t) => t.id == team.id);
    if (!existsInState) return false;

    await db.updateTeam(team);
    await loadTeams();
    return true;
  }

  Future<Team?> getTeamById(int id) async {
    return await db.getTeamById(id);
  }

  Future<bool> deleteTeam(int id) async {
    final existsInState = state.any((t) => t.id == id);
    if (!existsInState) return false;

    await db.deleteTeam(id);
    await loadTeams();
    return true;
  }

  
}