import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:futbol_teams_app/presentation/providers/provider_futbol_teams.dart';

import 'package:futbol_teams_app/presentation/screens/screen_home.dart';

import 'package:futbol_teams_app/domain/class_futbol_team.dart';

import 'package:intl/intl.dart';

final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double basicHeight = 40.0;
final double borderRadiusValue = 12.0;

class ScreenTeamDetails extends ConsumerWidget {
  const ScreenTeamDetails({super.key, required this.teamID});
  final int teamID;
  

  @override
  Widget build(BuildContext context,ref) {
    final Team team = ref.watch(futbolTeamsProvider).firstWhere((team) => team.id == teamID);
    final textStyle = Theme.of(context).textTheme;
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title:  Text('Team Details',
             style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              )
            ),
            elevation: 0,
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  context.push('/team/edit', extra: {'teamID': teamID, 'type':  team.type,});
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ),
        body: team is FootballTeam
            ? _FutbolTeamViewDetail(team: team )
            : team is NationalTeam
                ? _NationalTeamViewDetail(team: team)
                : const Center(
                    child: Text('Error'),
                  ),
        drawer: LateralMenuView(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      
      ),
    );
  }
}

class _FutbolTeamViewDetail extends StatelessWidget {
  const _FutbolTeamViewDetail({
    required this.team,
  });

  final FootballTeam team;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return PageView(
      children: [
        ListView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          children: [

            Center(
              child: Text(team.name,
                style: textStyle.headlineLarge,
                textAlign: TextAlign.center
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: verticalPadding*2, horizontal: horizontalPadding*2),
                child: Image.network(
                  team.logoUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.sports_soccer,
                    size: 150,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),            

            Text('Basic Information', style: textStyle.headlineMedium, textAlign: TextAlign.center),

            SizedBox(height: basicHeight/2),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_city),
                title: Text('City',
                  style: textStyle.titleLarge
                ),
                subtitle: Text(team.city,
                  style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )
                ),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.public),
                title: Text('Country',
                  style: textStyle.titleLarge
                ),
                subtitle: Text(team.country,
                  style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )
                ),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.date_range),
                title: Text('Foundation Date',
                style: textStyle.titleLarge),
                subtitle: Text(team.foundedDate != null ? DateFormat('dd/MM/yyyy').format(team.foundedDate!) : 'N/A',
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            )
          ],
        ),

        ListView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          children: [
            Center(
              child: Text('Team Information', 
                style: textStyle.headlineMedium,
                textAlign: TextAlign.center
              ),
            ),

            SizedBox(height: basicHeight/2),
        
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text('Head Coach',
                style: textStyle.titleLarge),
                subtitle: Text(team.headCoach ?? 'N/A' ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: Text('Captain',
                style: textStyle.titleLarge),
                subtitle: Text(team.captain ?? 'N/A' ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),               
            ),

            SizedBox(height: basicHeight/2),

            Center(
              child: Text('Stadium Information', 
                style: textStyle.headlineMedium),
            ),

            SizedBox(height: basicHeight/2),

            Card(
              child: ListTile(
                leading: const Icon(Icons.stadium),
                title: Text('Name',
                style: textStyle.titleLarge),
                subtitle: Text(team.stadiumName,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text('Capacity',
                style: textStyle.titleLarge),
                subtitle: Text(
                  '${team.stadiumCapacity ?? 'N/A'} fans',
                  style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),

            SizedBox(height: basicHeight/2),

            Center(
              child: Text('Titles Information', 
                style: textStyle.headlineMedium),
            ),

            SizedBox(height: basicHeight/2),

            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events),
                title: Text('National Titles',style: textStyle.titleLarge),
                subtitle: Text(
                  '${team.nationalTitles ?? 'N/A'}',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )
                ),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.workspace_premium),
                title: Text('International Titles',style: textStyle.titleLarge),
                subtitle: Text(
                  '${team.internationalTitles ?? 'N/A'}',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NationalTeamViewDetail extends StatelessWidget {
  const _NationalTeamViewDetail({
    required this.team,
  });

  final NationalTeam team;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return PageView(

      children: [
        ListView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          children: [
            Center(
              child: Text(team.name,
                style: textStyle.headlineLarge,
                textAlign: TextAlign.center
              ),
            ),

            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: verticalPadding*2, horizontal: horizontalPadding*2),
                child: Image.network(
                  team.logoUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.sports_soccer,
                    size: 150,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),            

            Text('Basic Information', style: textStyle.headlineMedium, textAlign: TextAlign.center),

            SizedBox(height: basicHeight/2),

            Card(
              child: ListTile(
                leading: const Icon(Icons.flag),
                title: Text('Country',
                style: textStyle.titleLarge),
                subtitle: Text(team.country,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.public),
                title: Text('Continent',
                  style: textStyle.titleLarge),
                subtitle: Text(team.continent,
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.groups),
                title: Text('Federation',
                  style: textStyle.titleLarge),
                subtitle: Text(team.federation,
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),
          ],
        ),

        ListView(
          padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
          children: [
            Center(
              child: Text('Team Information', 
                style: textStyle.headlineMedium),
            ),

            SizedBox(height: basicHeight/2),
        
            Card(
              child: ListTile(
                leading: const Icon(Icons.people),
                title: Text('Head Coach',
                style: textStyle.titleLarge),
                subtitle: Text(team.headCoach ?? 'N/A' ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.star),
                title: Text('Captain',
                style: textStyle.titleLarge),
                subtitle: Text(team.captain ?? 'N/A' ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),               
            ),

            SizedBox(height: basicHeight/2),

            Center(
              child: Text('Titles and Awards', 
                style: textStyle.headlineMedium),
            ),

            SizedBox(height: basicHeight/2),

            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events),
                title: Text('Federation Titles',
                style: textStyle.titleLarge),
                subtitle: Text(team.federationTitles.toString() ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              ),
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.emoji_events),
                title: Text('World Titles',
                style: textStyle.titleLarge),
                subtitle: Text(team.worldCupTitles.toString() ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              )
            ),

            SizedBox(height: fieldSpacing),

            Card(
              child: ListTile(
                leading: const Icon(Icons.group_add),
                title: Text('Word Cup Apearances',
                style: textStyle.titleLarge),
                subtitle: Text(team.worldCupAppearances.toString() ,
                style: textStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                  )),
              )
            ),

          ],
        ),
      ],
    );
  }
}

