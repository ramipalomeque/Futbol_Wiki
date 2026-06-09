import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:futbol_teams_app/presentation/providers/provider_users.dart';
import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';

final String appLogoPath = 'lib/data/sources/logo_app.png';
final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double buttonHeight = 40.0;
final double imageSize = 150.0;
final double borderRadiusValue = 12.0;


class ScreenLogin extends ConsumerWidget {
  const ScreenLogin({super.key});
  @override
  Widget build(BuildContext context, ref) {  
    final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Login', 
            style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold, 
            ),
          ),
          centerTitle: true,
          elevation: 0 ,
        ),
      
        body: _LoginMenu(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class _LoginMenu extends ConsumerStatefulWidget{
  const _LoginMenu();

  @override
  ConsumerState<_LoginMenu> createState() => _LoginMenuState();

}

class _LoginMenuState extends ConsumerState<_LoginMenu> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  
  void _doLogin() {
    final usersList = ref.watch(usersProvider);
    final sessionContext = ref.read(sessionProvider.notifier);
    final matchedUser = usersList.where(
      (user) => user.email == usernameController.text && 
                user.password == passwordController.text,
    ).firstOrNull;

    if (matchedUser == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials, please try again',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,  
          ),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    } 
    else {
      sessionContext.login(matchedUser);
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical: verticalPadding),
            child: Container(
              padding: EdgeInsets.all(horizontalPadding),
              margin:  EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                children: [
                  SizedBox(
                      width: imageSize,
                      child: Image.asset(
                        appLogoPath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.sports_soccer,
                              size: imageSize,
                              color: Colors.red,
                            ),
                          );
                        },
                      ),
                    ),
                  
 
                  Text(
                    'Welcome to Futbol Wiki',
                    style: textStyle.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: fieldSpacing / 2),

                  Text(
                    'Sign in to continue',
                    style: textStyle.bodyMedium?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              children: [
                Card(               
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      hintText: 'Enter your email',
                    ),
                    style: textStyle.bodySmall,
                  ),
                ),

                SizedBox(height: fieldSpacing),
                
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadiusValue),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: horizontalPadding,
                        vertical: verticalPadding,
                      ),
                      hintText: 'Enter your password',
                    ),
                    onSubmitted: (_) => _doLogin(),
                    onEditingComplete: _doLogin,
                    style: textStyle.bodySmall,
                  ),
                ),

                SizedBox(height: fieldSpacing),

                SizedBox(
                  width: double.infinity,
                  height: buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: _doLogin, 
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: Text(
                      'Login',
                      style: textStyle.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
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

                SizedBox(height: fieldSpacing),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: textStyle.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        context.push('/signup');
                      },
                      child:  Text(
                        'Register here',
                        style: textStyle.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}