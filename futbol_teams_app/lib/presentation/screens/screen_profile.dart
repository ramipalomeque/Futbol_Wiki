import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';
import 'package:futbol_teams_app/presentation/providers/provider_users.dart';

import 'package:futbol_teams_app/domain/class_user.dart';

import 'package:futbol_teams_app/presentation/screens/screen_home.dart';

final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double basicHeight = 40.0;
final double borderRadiusValue = 12.0;

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
   final textStyle = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Profile Information', 
            style: textStyle.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            )
          ),
          centerTitle: true,
          elevation: 0 ,
        ),
        
        body: _ProfileView(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        drawer: LateralMenuView(),
      ),
    );
  }
}

class _ProfileView extends ConsumerWidget {
  const _ProfileView();

  @override
  Widget build(BuildContext context,ref) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = ref.watch(sessionProvider).user;

    return SingleChildScrollView(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${user?.name ?? ''} ${user?.surname ?? ''}',
            style:
                textStyle.headlineLarge?.copyWith(
                color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: basicHeight),

          Icon(
            user?.gender == 'M' ? Icons.man: Icons.woman,
            size: basicHeight * 3,
            color: colorScheme.primary,
          ),

          SizedBox(height: basicHeight),

          Card(
            child: ListTile(
              leading: const Icon(Icons.person_outlined),
              title:  Text('DNI',
                style: textStyle.titleMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ), 
              ),
              subtitle: Text('${user?.dni ?? ''}',
                style: textStyle.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),

          SizedBox(height: fieldSpacing/2),

          Card(
            child: ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: Text('Birthdate'),
              subtitle: Text(user?.birthdate != null ? DateFormat('dd/MM/yyyy').format(user!.birthdate) : ''),
            ),
          ),

          SizedBox(height: fieldSpacing/2),

          Card(
            child: ListTile(
              leading: const Icon(Icons.email_outlined),
              title:  const Text('Email'),
              subtitle:Text(user?.email ?? ''),
            ),
          ),

          SizedBox(height: fieldSpacing/2),

          Card(
            child: ListTile(
              leading: const Icon(Icons.phone_outlined),
              title: const Text('Phone'),
              subtitle: Text(user?.phone?.toString() ?? 'N/A',),
            ),
          ),

          SizedBox(height: fieldSpacing),

          _FormResetPassword(user: user,),
        ],
      ),
    );
  }
}

class _FormResetPassword
    extends ConsumerStatefulWidget {

  const _FormResetPassword({
    this.user,
  });

  final UserData? user;

  @override
  ConsumerState<_FormResetPassword>
      createState() =>
          _FormResetPasswordState();
}

class _FormResetPasswordState extends ConsumerState<_FormResetPassword> {

  bool _showResetPassword = false;
  bool _obscurePassword = true;

  final _formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();
  final oldPasswordController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;


    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          TextButton.icon(
            onPressed: () {       
              oldPasswordController.clear();      
              passwordController.clear();
              passwordController2.clear();
              setState(() {_showResetPassword = true;});
            },
            icon: Icon(Icons.lock_reset, color: colorScheme.primary, size: fieldSpacing*3,),
            label: Text('Reset Password', 
              style: textStyle.bodyMedium?.copyWith(color: colorScheme.primary),
            ),
          ),

          if (_showResetPassword) ...[
            Form(
              key: _formKey,
              child: Column(
                children: [              
                   SizedBox(height: fieldSpacing/2),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide( color: colorScheme.outline, width: 1,),
                    ),
                
                    child: TextFormField(
                      controller: oldPasswordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Old Password',
                        prefixIcon: const Icon(Icons.lock_outline,),
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
                        contentPadding:EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding,),
                        hintText:'Enter your old password',
                      ),
                      style: textStyle.bodySmall,
                      validator: (value) {
                        if (value != widget.user?.password) {return 'Password is incorrect';}                     
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: fieldSpacing/2),
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusValue),
                      side: BorderSide( color: colorScheme.outline, width: 1,),
                    ),
                
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        prefixIcon: const Icon(Icons.lock_outline,),
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
                        contentPadding:EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding,),
                        hintText:'Enter your new password',
                      ),
                      style: textStyle.bodySmall,
                      validator: (value)  {
                        if (value == null || value.isEmpty) {return 'Please enter a new password';}                      
                        if (value == oldPasswordController.text) { return 'New password must be different';}
                        return null;
                      },
                    ),
                  ),
                
                  SizedBox(height: fieldSpacing/2),
                
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
                      controller: passwordController2,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Repeat New Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: InputBorder.none,
                        contentPadding:EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding,),
                        hintText: 'Repeat your new password',
                      ),
                      style: textStyle.bodySmall,
                      validator: (value) => (value == null || value.isEmpty || value != passwordController.text)
                          ? 'Passwords do not match'
                          : null,
                    ),
                  ),
                
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
                                  _updatePassword(widget.user,passwordController.text);
                                  setState(() {_showResetPassword = false;});
                                  return;
                                }                              
                              }, 
                              icon: const Icon(Icons.save, color: Colors.white),
                              label: Text(
                                'Save Password',
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
                        SizedBox(width: fieldSpacing,),
                        Expanded(
                          child: SizedBox(
                            height: buttonHeight*4/3,
                            child: ElevatedButton.icon(
                              onPressed: () => setState(() {_showResetPassword = false;}), 
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
          ],
        ],
      ),
    );
  }


  void _updatePassword(UserData? user, String password) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final result = ref.watch(usersProvider.notifier);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('Change Password', style: textStyle.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),),
        content: Text('Are you sure you want to cahange your password?', style: textStyle.bodyMedium),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed:(){
                    user?.password = password;
                    user?.updatedAt = DateTime.now();
                    result.editUser(user!);
                    Navigator.pop(dialogContext);
                            
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Password changed successfully',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 3),
                      ),
                    );
                    
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