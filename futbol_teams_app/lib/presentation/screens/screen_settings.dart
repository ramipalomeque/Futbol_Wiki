import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';

import 'package:futbol_teams_app/presentation/screens/screen_home.dart';

final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double basicHeight = 40.0;
final double borderRadiusValue = 12.0;

class ScreenSettings extends StatelessWidget {
  const ScreenSettings({super.key});

  @override
  Widget build(BuildContext context) {
   final colorScheme = Theme.of(context).colorScheme;
   final textStyle = Theme.of(context).textTheme;
   return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Settings', style: textStyle.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          )),
          centerTitle: true,
          elevation: 0 ,
        ),
        body: _SettingsMenu(),
        drawer: LateralMenuView(),
      ),
    );
  }
}

class _SettingsMenu extends ConsumerWidget {
  const _SettingsMenu();

  @override
  Widget build(BuildContext context,ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme;
    final sessionContext = ref.read(sessionProvider.notifier);
    final session = ref.watch(sessionProvider);
    final brightness = MediaQuery.of(context).platformBrightness;

    final isDarkMode =
        session.themeMode == ThemeMode.system
            ? brightness == Brightness.dark
            : session.themeMode == ThemeMode.dark;
        
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      children: [
        Center(
              child: Text('Select Theme mode', style: textStyle.headlineMedium?.copyWith(
                fontWeight: textStyle.headlineMedium?.fontWeight,
                color: colorScheme.onSurface,
              )),
            ),

        SizedBox(height: fieldSpacing/2),

        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue),),
          child: ListTile(
            leading: Icon(Icons.dark_mode,
              color: colorScheme.onSurfaceVariant,
              size: basicHeight,
            ),
            title: Text('Dark Mode', 
              style: textStyle.titleMedium?.copyWith(
                fontWeight: textStyle.titleMedium?.fontWeight,
                color: colorScheme.onSurfaceVariant,
              )
            ),
            trailing: Switch.adaptive(
                activeTrackColor: colorScheme.primaryContainer,
                inactiveThumbColor: Colors.grey,
              value:  isDarkMode,
              onChanged: (value) => sessionContext.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light),
            ),
          ),

        ),

        SizedBox(height: fieldSpacing*4),

        Center(
              child: Text('Select Theme color', style: textStyle.headlineMedium?.copyWith(
                fontWeight: textStyle.headlineMedium?.fontWeight,
                color: colorScheme.onSurface,
              )),
            ),

        SizedBox(height: fieldSpacing/2),

        Row(
          children: [
            Expanded(
              child: Card(
                      elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue)),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Color(0xFF6750A4)),
                  title: Text(
                    'Default Theme',
                    style: textStyle.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => sessionContext.changeSeedColor(const Color(0xFF6750A4)),
                ),
              ),
            ),
            SizedBox(width: fieldSpacing),
            Expanded(
              child: Card(
                      elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue)),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.green),
                  title: Text(
                    'Green Theme',
                    style: textStyle.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => sessionContext.changeSeedColor(Colors.green),
                ),
              ),
            ),
          ]
        ),

        SizedBox(height: fieldSpacing),

        Row(
          children: [
            Expanded(
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue)),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.red),
                  title: Text(
                    'Red Theme',
                    style: textStyle.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => sessionContext.changeSeedColor(Colors.red),
                ),
              ),
            ),
            SizedBox(width: fieldSpacing),
            Expanded(
              child: Card(
                      elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue)),
                child: ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.blue),
                  title: Text(
                    'Blue Theme',
                    style: textStyle.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => sessionContext.changeSeedColor(Colors.blue),
                ),
              ),
            ),
          ]
        ),

        SizedBox(height: fieldSpacing*4),

        Center(
              child: Text('Select Font Size', style: textStyle.headlineMedium?.copyWith(
                fontWeight: textStyle.headlineMedium?.fontWeight,
                color: colorScheme.onSurface,
              )),
            ), 

        SizedBox(height: fieldSpacing/2), 

        Card(
          //color: colorScheme.surfaceContainerHigh,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusValue),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Slider(
                  value: session.fontScale,
                  min: 0.5,
                  max: 1.5,
                  divisions: 4,
                  label: session.fontScale.toString(),
                  onChanged: (value) {

                    final values = [0.5,0.8,1.0,1.2,1.5];

                    double closest = values.first;

                    for(final item in values){
                      if((item - value).abs() < (closest - value).abs()){
                        closest = item;
                      }
                    }

                    sessionContext.changeFontScale(closest);
                  },
                ),
              ],
            ),
          ),
        ),       
      ],
    );
  }
}

