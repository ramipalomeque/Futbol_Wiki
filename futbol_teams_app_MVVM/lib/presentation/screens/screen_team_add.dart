import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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


class ScreenTeamAdd extends ConsumerWidget {
  const ScreenTeamAdd({super.key, this.teamID,required this.type});
  
  final int? teamID;
  final TeamType type;
  @override
  Widget build(BuildContext context,ref) {
    final Team? team = teamID == null ? null : ref.watch(futbolTeamsProvider).firstWhere((team) => team.id == teamID);
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title:  Text( 
              teamID == null
                ? 'Add ${type == TeamType.national ? 'National Team' : 'Football Team'}'
                : 'Edit ${type == TeamType.national ? 'National Team' : 'Football Team'}',
              style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            )),
            centerTitle: true,
            elevation: 0 ,
          ),
          body: type == TeamType.football
            ? _AddTeamView(team: team)
            : _AddNationalTeamView(team: team),
        drawer: LateralMenuView(),
      
      ),
    );
  }
}

class _AddTeamView extends ConsumerStatefulWidget {

  const _AddTeamView({this.team});

  final Team? team;

  @override
  ConsumerState<_AddTeamView> createState() => _AddTeamViewState();
}

class _AddTeamViewState extends ConsumerState<_AddTeamView> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final cityController = TextEditingController();
  final coachController = TextEditingController();
  final captainController = TextEditingController();
  final logoController = TextEditingController();
  final stadiumController = TextEditingController();
  final capacityController = TextEditingController();
  final nationalTitlesController = TextEditingController();
  final internationalTitlesController = TextEditingController();
  final foundedDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.team == null) return;
    final FootballTeam futbolteam = widget.team as FootballTeam;

    nameController.text = futbolteam.name;
    countryController.text = futbolteam.country;
    cityController.text = futbolteam.city;
    coachController.text = futbolteam.headCoach ?? '';
    captainController.text = futbolteam.captain ?? '';
    logoController.text = futbolteam.logoUrl;
    stadiumController.text = futbolteam.stadiumName;
    capacityController.text =  futbolteam.stadiumCapacity?.toString() ?? '';
    nationalTitlesController.text = futbolteam.nationalTitles?.toString() ?? '';
    internationalTitlesController.text = futbolteam.internationalTitles?.toString() ?? '';
    foundedDateController.text = DateFormat('dd/MM/yyyy').format(futbolteam.foundedDate!);
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    cityController.dispose();
    coachController.dispose();
    captainController.dispose();
    logoController.dispose();
    stadiumController.dispose();
    capacityController.dispose();
    nationalTitlesController.dispose();
    internationalTitlesController.dispose();
    foundedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    DateTime foundeddate = DateTime(2000, 1, 1);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),

        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Basic Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: nameController,

                      decoration: InputDecoration(
                        labelText: 'Team Name',
                        prefixIcon: const Icon(Icons.shield_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter team name',
                      ),

                      style: textStyle.bodySmall,

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter team name'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: countryController,

                      decoration: InputDecoration(
                        labelText: 'Country',
                        prefixIcon: const Icon(Icons.flag_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter country',
                      ),

                      style: textStyle.bodySmall,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter country'
                          : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: cityController,

                      decoration: InputDecoration(
                        labelText: 'City',
                        prefixIcon: const Icon(Icons.location_city_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter city',
                      ),

                      style: textStyle.bodySmall,
                      validator: (value) => (value == null || value.isEmpty)
                          ? 'Please enter city'
                          : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: logoController,

                      decoration: InputDecoration(
                        labelText: 'Logo URL',
                        prefixIcon: const Icon(Icons.image_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter logo URL',
                      ),

                      style: textStyle.bodySmall,
                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter logo URL'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: foundedDateController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        DateFormatter(),
                      ],

                      decoration: InputDecoration(
                        labelText: 'Founded Date',
                        prefixIcon: const Icon(Icons.calendar_month_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        hintText: 'dd/MM/yyyy',
                      ),
                      style: textStyle.bodySmall,
                      validator: (value){
                        if(value == null || value.isEmpty){  return null;}
                        try{
                          foundeddate = DateFormat('dd/MM/yyyy').parseStrict(value);
                          return null;
                        } catch (e) {
                          return 'Please enter a valid date';
                        } 
                                         
                      },
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Team Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: coachController,

                      decoration: InputDecoration(
                        labelText: 'Head Coach',
                        prefixIcon: const Icon(Icons.people_outline),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter head coach',
                      ),

                      style: textStyle.bodySmall,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: captainController,

                      decoration: InputDecoration(
                        labelText: 'Captain',
                        prefixIcon: const Icon(Icons.star_outline),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter captain',
                      ),

                      style: textStyle.bodySmall,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Stadium Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: stadiumController,

                      decoration: InputDecoration(
                        labelText: 'Stadium Name',
                        prefixIcon: const Icon(Icons.stadium_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter stadium name',
                      ),

                      style: textStyle.bodySmall,
                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter stadium name'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: capacityController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'Capacity',
                        prefixIcon: const Icon(Icons.groups_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter stadium capacity',
                      ),

                      style: textStyle.bodySmall,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Titles Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: nationalTitlesController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'National Titles',
                        prefixIcon: const Icon(Icons.emoji_events_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter national titles',
                      ),

                      style: textStyle.bodySmall,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide(
                        color: colorScheme.outline,
                        width: 1,
                      ),
                    ),

                    child: TextFormField(
                      controller: internationalTitlesController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'International Titles',
                        prefixIcon: const Icon(Icons.workspace_premium_outlined),
                        border: InputBorder.none,

                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),

                        hintText: 'Enter international titles',
                      ),

                      style: textStyle.bodySmall,
                    ),
                  ),
                  SizedBox(height: fieldSpacing / 2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding,),
                child: Row(
                  
                  children:
                  [
                    
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight*4/3,                    
                        child: ElevatedButton.icon(
                          onPressed:(){
                            if (_formKey.currentState!.validate())
                            {                              
                              final newTeam = FootballTeam(      
                                id: widget.team?.id,                      
                                name: nameController.text.trim(),
                                country: countryController.text.trim(),
                                headCoach: coachController.text.isEmpty ? null : coachController.text.trim(),
                                captain: captainController.text.isEmpty ? null : captainController.text.trim(),
                                logoUrl: logoController.text.trim(),
                                city: cityController.text.trim(),
                                foundedDate: foundeddate,
                                stadiumCapacity: capacityController.text.isEmpty ? null : int.parse(capacityController.text.trim()),
                                stadiumName: stadiumController.text.trim(),
                                nationalTitles: nationalTitlesController.text.isEmpty ? null : int.parse(nationalTitlesController.text.trim()),
                                internationalTitles: internationalTitlesController.text.isEmpty ? null : int.parse(internationalTitlesController.text.trim()),
                                state: 'active',
                                createdAt: widget.team == null ? DateTime.now() : widget.team!.createdAt,
                                updatedAt: DateTime.now(),
                                );
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  
                                  builder: (dialogContext) => AlertDialog(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    title: Text('Confirmation Message', style: textStyle.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    content: Text('Are you sure you want to ${widget.team == null ? 'add' : 'update'} this team?', style: textStyle.bodyMedium),
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              onPressed: (){Navigator.pop(dialogContext);
                                              _saveTeam(context: context, ref: ref, team: newTeam);},
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
                                              label: Text('Cancel',
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
                              
                              return;
                            }                              
                          }, 
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: Text(
                            'Save Team',
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
                            ),
                            elevation: 4,                                
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(width: fieldSpacing*2),
                
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight*4/3,
                        child: ElevatedButton.icon(
                          onPressed: () => context.pop(), 
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
                    ),
                  ]    
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddNationalTeamView extends ConsumerStatefulWidget {

  const _AddNationalTeamView({this.team});

  final Team? team;

  @override
  ConsumerState<_AddNationalTeamView> createState() => _AddNationalTeamViewState();
}

class _AddNationalTeamViewState extends ConsumerState<_AddNationalTeamView> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final countryController = TextEditingController();
  final coachController = TextEditingController();
  final captainController = TextEditingController();
  final logoController = TextEditingController();

  final continentController = TextEditingController();
  final federationController = TextEditingController();
  final federationRankingController = TextEditingController();
  final federationTitlesController = TextEditingController();
  final worldCupAppearancesController = TextEditingController();
  final worldCupTitlesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if(widget.team == null) return;

    final NationalTeam nationalteam = widget.team as NationalTeam;

    nameController.text = nationalteam.name;
    countryController.text = nationalteam.country;
    coachController.text = nationalteam.headCoach ?? '';
    captainController.text = nationalteam.captain ?? '';
    logoController.text = nationalteam.logoUrl;
    continentController.text = nationalteam.continent;
    federationController.text = nationalteam.federation;
    federationRankingController.text = nationalteam.federationRanking.toString();
    federationTitlesController.text = nationalteam.federationTitles.toString();
    worldCupAppearancesController.text = nationalteam.worldCupAppearances.toString();
    worldCupTitlesController.text = nationalteam.worldCupTitles.toString();
  }

  @override
  void dispose() {
    nameController.dispose();
    countryController.dispose();
    coachController.dispose();
    captainController.dispose();
    logoController.dispose();
    continentController.dispose();
    federationController.dispose();
    federationRankingController.dispose();
    federationTitlesController.dispose();
    worldCupAppearancesController.dispose();
    worldCupTitlesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),

        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          child: Column(
            children: [

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Basic Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    child: TextFormField(
                      controller: nameController,

                      decoration: InputDecoration(
                        labelText: 'Team Name',
                        prefixIcon: const Icon(Icons.shield_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter team name'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: countryController,

                      decoration: InputDecoration(
                        labelText: 'Country',
                        prefixIcon: const Icon(Icons.flag_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter country'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: logoController,

                      decoration: InputDecoration(
                        labelText: 'Logo URL',
                        prefixIcon: const Icon(Icons.image_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter logo URL'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Team Information',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    child: TextFormField(
                      controller: coachController,

                      decoration: InputDecoration(
                        labelText: 'Head Coach',
                        prefixIcon: const Icon(Icons.people_outline),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: captainController,

                      decoration: InputDecoration(
                        labelText: 'Captain',
                        prefixIcon: const Icon(Icons.star_outline),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: continentController,

                      decoration: InputDecoration(
                        labelText: 'Continent',
                        prefixIcon: const Icon(Icons.public_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter continent'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: federationController,

                      decoration: InputDecoration(
                        labelText: 'Federation',
                        prefixIcon: const Icon(Icons.account_tree_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),

                      validator: (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter federation'
                              : null,
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),
                ],
              ),

              SizedBox(height: fieldSpacing*2),

              ExpansionTile(
                initiallyExpanded: true,

                title: Text(
                  'Statistics',
                  style: textStyle.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                children: [

                  Card(
                    child: TextFormField(
                      controller: federationRankingController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'Federation Ranking',
                        prefixIcon: const Icon(Icons.leaderboard_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: federationTitlesController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'Federation Titles',
                        prefixIcon: const Icon(Icons.emoji_events_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: worldCupAppearancesController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'World Cup Appearances',
                        prefixIcon: const Icon(Icons.sports_soccer_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: fieldSpacing/2),

                  Card(
                    child: TextFormField(
                      controller: worldCupTitlesController,
                      keyboardType: TextInputType.number,

                      decoration: InputDecoration(
                        labelText: 'World Cup Titles',
                        prefixIcon: const Icon(Icons.workspace_premium_outlined),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: fieldSpacing*2),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding,),
                child: Row(                 
                  children:
                  [                   
                    Expanded(
                      child: 
                      SizedBox(
                        width: double.infinity,
                        height: buttonHeight*4/3,

                        child: ElevatedButton.icon(
                          onPressed: ()  {

                            if (!_formKey.currentState!.validate()) {
                              return;
                            }

                            final newTeam = NationalTeam(
                              id: widget.team?.id,
                              name: nameController.text.trim(),
                              country: countryController.text.trim(),
                              headCoach: coachController.text.isEmpty ? null : coachController.text.trim(),
                              captain: captainController.text.isEmpty ? null : captainController.text.trim(),
                              logoUrl: logoController.text.trim(),
                              continent: continentController.text.trim(),
                              federation: federationController.text.trim(),
                              federationRanking: int.parse(federationRankingController.text.trim()),
                              federationTitles: int.parse(federationTitlesController.text.trim()),
                              worldCupAppearances: int.parse(worldCupAppearancesController.text.trim()),
                              worldCupTitles: int.parse(worldCupTitlesController.text.trim()),
                              state: 'active',
                              createdAt: widget.team == null ? DateTime.now() : widget.team!.createdAt,
                              updatedAt: DateTime.now(),
                            );
                            showDialog(
                              context: context,                         
                              barrierDismissible: false,
                              builder: (dialogContext) => AlertDialog(
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                title: Text('Confirmation Message', style: textStyle.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
                                content: Text('Are you sure you want to ${widget.team == null ? 'add' : 'update'} this team?', style: textStyle.bodyMedium),
                                actions: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: (){Navigator.pop(dialogContext);
                                          _saveTeam(context: context, ref: ref, team: newTeam);},
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
                          },

                          icon: const Icon(Icons.save, color: Colors.white),

                          label: Text(
                            'Save Team',
                            style: textStyle.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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
                          ),
                        ),
                      ),
                    ),
                
                    SizedBox(width: fieldSpacing*2),
                
                    Expanded(
                      child: SizedBox(
                        height: buttonHeight*4/3,
                        child: ElevatedButton.icon(
                          onPressed: () => context.pop(), 
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
                              side: BorderSide(
                                color: colorScheme.outline,
                                width: 1,
                              ),
                            ),
                            elevation: 4,
                          ),
                        ),
                      ),
                    ),
                  ]    
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String text = newValue.text.replaceAll('/', '');

    if (text.length > 8) return oldValue;

    String formatted = '';

    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) formatted += '/';
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

Future<void> _saveTeam({required BuildContext context, required WidgetRef ref, required Team team}) async {
  final teamProviderNotifier = ref.read(futbolTeamsProvider.notifier);

  bool result;

  if (team.id == null) {
    result = await teamProviderNotifier.addTeam(team);
  } else {
    result = await teamProviderNotifier.updateTeam(team);
  }

  if (!context.mounted) return;

  if (!result) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(team.id == null
          ? 'Already exists a team with the same name and country'
          : 'Error updating team',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
          ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 3),
      ),
    );
    return;
  }

  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        team.id == null
            ? 'Team created successfully'
            : 'Team updated successfully',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium  
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
    ),
  );

  if (!context.mounted) return;
  context.pop();
}