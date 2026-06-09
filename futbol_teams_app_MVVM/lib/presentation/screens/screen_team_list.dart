import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import 'package:futbol_teams_app/domain/class_futbol_team.dart';

import 'package:futbol_teams_app/presentation/providers/provider_futbol_teams.dart';

import 'package:futbol_teams_app/presentation/screens/screen_home.dart';

final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double basicHeight = 40.0;
final double borderRadiusValue = 12.0;

class ScreenTeamList extends ConsumerWidget {
  const ScreenTeamList({super.key, required this.filterTeams});

  final String filterTeams;

  @override
  Widget build(BuildContext context,ref) {

    final allTeams = ref.watch(futbolTeamsProvider);

    List<Team> listTeams = _getFilteredItems(filterTeams, allTeams);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(  
          appBar: AppBar(
            title:  Text('Team List', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)
            ),
            centerTitle: true,
            elevation: 0 ,
          ),
          body: listTeams.isNotEmpty ? _ListView(listTeams: listTeams) : _NoListView(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: LateralMenuView(),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => context.push('/team/add',
              extra: {
                'teamID': null,
                'type':  listTeams.isNotEmpty ? listTeams.first.type : TeamType.football,
              }
            ),
          )
        ),
    );
  }
}

class _NoListView extends StatelessWidget {
  const _NoListView();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_outlined,
            size: 100,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(height: basicHeight),
          Text('No teams found', style: textStyle.headlineMedium),
          SizedBox(height: basicHeight),
          Text('Create a new team', style: textStyle.bodyMedium),
        ],
      )
    );
  }
}

class _ListView extends StatelessWidget {
  const _ListView({required this.listTeams});

  final List<Team> listTeams;

  @override
  Widget build(BuildContext context) {
    final sortedTeams = [...listTeams]..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase(),),);
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      itemCount: sortedTeams.length,
      itemBuilder:(context, index){
        final team = sortedTeams[index];
        return _ListItem(team: team);
      },
    );
  }
}


class _ListItem extends ConsumerWidget {
  const _ListItem({
    required this.team,
  });

  final Team team;

  @override
  Widget build(BuildContext context,ref) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme; 
      
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadiusValue),
      side: BorderSide(
        color: colorScheme.outline,
        width: 1,
        ),
      ),
      child: ListTile(
        leading: Container(
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding / 2, vertical: verticalPadding / 2),
          width: basicHeight * 2,        
          height: basicHeight * 3,        
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Center(
            child: Image.network(
                    team.logoUrl,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(
                      Icons.sports_soccer,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
          ),
        ),

        title: Text(team.name,
          style: textStyle.titleLarge,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: fieldSpacing),
            Row(
              children: [
                Icon(Icons.location_on, size: basicHeight * 0.5, color: colorScheme.primary,),
                SizedBox(width: fieldSpacing),
                if (team is FootballTeam)
                  Expanded(
                    child: Text(
                      '${(team as FootballTeam).city}, ${team.country}',
                      style: textStyle.bodyMedium,
                    ),
                  ),


                if (team is NationalTeam)
                  Expanded(
                    child: Text(
                      '${team.country}, ${(team as NationalTeam).continent}',
                      style: textStyle.bodyMedium,
                    ),
                  ),
          
              ],
            ),

            SizedBox(height: fieldSpacing),

            Row(
              children: [
                Icon(Icons.people, size: basicHeight * 0.5, color: colorScheme.primary,),

                SizedBox(width: fieldSpacing),

                Expanded(
                  child: Text(
                    'Head Coach: ${team.headCoach ?? 'N/A'}',
                    style: textStyle.bodyMedium,
                  ),
                ),
              ],
            ),

            SizedBox(height: fieldSpacing),

            Row(
              children: [
                Icon(Icons.star, size: basicHeight * 0.5, color: colorScheme.primary,),

                SizedBox(width: fieldSpacing),

                Expanded(
                  child: Text(
                    'Captain: ${team.captain ?? 'N/A'}',
                    style: textStyle.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.arrow_forward_ios, size: 18),
          onPressed: () {
            context.push('/team/details', extra: team.id);
          },
        ),
        onTap: () {
          context.push('/team/details', extra: team.id);
        },
        onLongPress: () => _deleteTeamDialog(context: context, ref: ref, team: team),
      ),
    );
  }
  Future<void> _deleteTeamDialog({required BuildContext context, required WidgetRef ref, required Team team,}) async {

    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text( 'Delete Team',
          style: textStyle.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text('Are you sure you want to delete ${team.name}?',
          style: textStyle.bodyMedium,
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                  final result = await ref.read(futbolTeamsProvider.notifier).deleteTeam(team.id!);
                          
                  if (!context.mounted) return;
                  Navigator.pop(dialogContext);
                          
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result ? 'Team deleted successfully' : 'Error deleting team',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      backgroundColor: result ? Colors.green : Colors.redAccent,
                      duration: Duration(seconds: 3),
                    ),
                  );
                  if (!context.mounted) return;
                },
                icon: const Icon(Icons.done, color: Colors.white),
                label: Text(
                  'Confirm',
                  style: textStyle.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    side: BorderSide(
                      color: colorScheme.outline,
                      width: 1,
                    ),
                  ),
                  elevation: 4,                                
                ),
              ),
            ),

            SizedBox(width: fieldSpacing),

            Expanded(
              child: ElevatedButton.icon(
                onPressed: () =>Navigator.pop(dialogContext),
                icon: const Icon(Icons.cancel, color: Colors.white),
                label: Text(
                  'Cancel',
                  style: textStyle.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                  ),
                  elevation: 4,
                ),
              ),
            ),
            ],
          ),
        ],
      ),
    );
  }
}





  List<Team> _getFilteredItems(String filterTeams, List<Team> allTeams) {
  List<Team> listTeams = [];
  if (filterTeams == 'Futbol Teams') {
    listTeams = allTeams
        .where((team) => team.type == TeamType.football)
        .toList();
  } 
  else if (filterTeams == 'National Teams') {
    listTeams = allTeams
        .where((team) => team.type == TeamType.national)
        .toList();
  } 
  else if (filterTeams == 'All Teams') {
    listTeams = allTeams;
  } 
  else {
    listTeams = allTeams
        .where((team) =>
            team.type == TeamType.football &&
            team.country == filterTeams)
        .toList();
  }
  return listTeams;
}