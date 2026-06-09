import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:futbol_teams_app/core/menus/home_menu.dart';
import 'package:futbol_teams_app/core/menus/home_lateral_menu.dart';

import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';


final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double buttonHeight = 40.0;
final double borderRadiusValue = 12.0;

class ScreenHome extends ConsumerWidget {
  const ScreenHome({super.key,});
  @override
  Widget build(BuildContext context,ref) {
    final textStyle = Theme.of(context).textTheme;
    final user = ref.watch(sessionProvider).user;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Welcome ${user?.name ?? ''}', 
            style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0 ,
        ),
        body: _HomeMenuView(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: LateralMenuView(),
      ),
    );
  }
}

class LateralMenuView extends ConsumerWidget {
   LateralMenuView({super.key,});
  final lateralMenuItems = homeLateralMenuItems;
  @override
  Widget build(BuildContext context,ref) {
    final sessionContext = ref.read(sessionProvider.notifier);
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    debugPrint('mid${textStyle.headlineMedium?.fontSize}');
  debugPrint('small${textStyle.headlineSmall?.fontSize}');

return Drawer(
  child: Column(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: verticalPadding*2, horizontal: horizontalPadding),
        color: colorScheme.primary,
        child: SafeArea(
          bottom: false,
          child: Text(
            'Menu',
            style: textStyle.headlineLarge,
          ),
        ),
      ),
      Expanded(
        child: ListView.separated(
          padding: EdgeInsets.zero,
          itemCount: lateralMenuItems.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = lateralMenuItems[index];

            return ListTile(
              leading: Icon(item.icon.icon, color: colorScheme.primary),
              title: Text(
                item.title,
                style: textStyle.titleMedium,
              ),
              onTap: () {
                if (item.title == 'Logout') {
                  sessionContext.logout();
                  Navigator.pop(context);
                  context.go(item.route);
                  return;
                }

                Navigator.pop(context);
                context.push(item.route);
              },
            );
          },
        ),
      ),
    ],
  ),
);
  }
}

class _HomeMenuView extends StatelessWidget {
   _HomeMenuView();

  final menuItems = homeMenuItems;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      itemCount: menuItems.length,
      separatorBuilder: (context, index) =>  SizedBox(height: fieldSpacing),
      itemBuilder: (context, index) {
        final item = menuItems[index];

        return ListTile(
          leading: Text(
            item.emoji,
            style:  textStyle.titleLarge,
          ),
          title: Text(
            item.title,
            style: textStyle.titleLarge,
          ),
          subtitle: Text(
            item.subtitle,
            style: textStyle.bodyMedium,
          ),
          trailing:  Icon(Icons.arrow_forward_ios, size: fieldSpacing*2, color: colorScheme.onSurfaceVariant,),
          onTap: () {
            context.push('/team/list', extra: item.title);
          },
        );
      },
    );
  }
}