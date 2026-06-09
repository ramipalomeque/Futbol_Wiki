import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:futbol_teams_app/domain/class_user.dart';

import 'package:futbol_teams_app/presentation/providers/provider_users.dart';
import 'package:futbol_teams_app/presentation/providers/provider_session_config.dart';

final double horizontalPadding = 20.0;
final double verticalPadding = 10.0;
final double fieldSpacing = 10.0;
final double buttonHeight = 40.0;
final double borderRadiusValue = 12.0;


class ScreenSingUp extends StatelessWidget {
  const ScreenSingUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Sign Up', style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
          elevation: 0 ,
        ),
      
        body: _SingUpMenu(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}

class _SingUpMenu extends StatelessWidget {
  const _SingUpMenu();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(horizontalPadding),
                margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  children: [
                    Icon(
                      Icons.app_registration,
                      size: 50,
                      color: colorScheme.secondary,
                    ),

                    SizedBox(height: fieldSpacing),

                    Text(
                      'Join Our Community',
                      style: textStyle.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),

                    SizedBox(height: fieldSpacing / 2),

                    Text(
                      'Create your account to get started',
                      style: textStyle.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: fieldSpacing),

              _RegisterForm(),

              SizedBox(height: fieldSpacing),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: textStyle.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: Text(
                      'Login here',
                      style: textStyle.labelLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: fieldSpacing),
            ],
          ),
        ),
      );

  }
}

class _RegisterForm extends ConsumerStatefulWidget {
  const _RegisterForm();

  @override
  ConsumerState<_RegisterForm> createState() =>
      _RegisterFormState();
}

class _RegisterFormState
    extends ConsumerState<_RegisterForm> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final dniController = TextEditingController();
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final birthdateController = TextEditingController();

  String selectedGender = 'M';
  DateTime birthdate = DateTime(2000, 1, 1);
  int dni = -1;

  bool termsAreChecked = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;
  final colorScheme = Theme.of(context).colorScheme;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              'Personal information',
              style: textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            children:[ 
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
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your name',
                  ),
                  style: textStyle.bodySmall,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your name'
                      : null,
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
                  controller: surnameController,
                  decoration: InputDecoration(
                    labelText: 'Surname',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your surname',
                  ),
                  style: textStyle.bodySmall,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your surname'
                      : null,
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
                  controller: dniController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'DNI',
                    prefixIcon: const Icon(Icons.badge_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your DNI',
                  ),
                  style: textStyle.bodySmall,
                  validator: (value) => (value == null || value.isEmpty || int.tryParse(value) == null)
                      ? 'Please enter your DNI'
                      : null,
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding,
                    vertical: verticalPadding,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.wc_rounded, color: colorScheme.onSurfaceVariant),
                      SizedBox(width: 12),
                      Text(
                        'Gender',
                        style: textStyle.bodyMedium,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'M',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Icon(Icons.man, color: colorScheme.onSurfaceVariant),
                            ],
                          ),
                          
                          SizedBox(width: fieldSpacing*2),

                          Row(
                            children: [
                              Radio<String>(
                                value: 'F',
                                groupValue: selectedGender,
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender = value!;
                                  });
                                },
                              ),
                              Icon(Icons.woman, color: colorScheme.onSurfaceVariant),
                            ],
                          ),

                          SizedBox(width: fieldSpacing*3),
                        ],
                      ),
                    ],
                  ),
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
                  controller: birthdateController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DateFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Birthdate',
                    prefixIcon: const Icon(Icons.cake_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your birthdate',
                  ),
                  style: textStyle.bodySmall,
                  validator: (value){
                    if(value == null || value.isEmpty){ return 'Please enter your birthdate'; }

                    try{
                      birthdate = DateFormat('dd/MM/yyyy').parseStrict(value);
                      return null;
                    } catch (e) {
                      return 'Please enter a valid birthdate';
                    }                      
                  },
                ),
              ),

              SizedBox(height: fieldSpacing),

            ],
          ),
          
          SizedBox(height: fieldSpacing*2),

          ExpansionTile(
            title: Text(
              'Account details',
              style: textStyle.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            children:[
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
                  controller: emailController,
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
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your email'
                      : null,
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
                  style: textStyle.bodySmall,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter your password'
                      : null,
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
                    labelText: 'Repeat Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Repeat your password',
                  ),
                  style: textStyle.bodySmall,
                  validator: (value) => (value == null || value.isEmpty || value != passwordController.text)
                      ? 'Passwords do not match'
                      : null,
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your phone number',
                  ),
                  style: textStyle.bodySmall,
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
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    prefixIcon: const Icon(Icons.home_outlined),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    hintText: 'Enter your address',
                  ),
                  style: textStyle.bodySmall,
                ),
              ),

              SizedBox(height: fieldSpacing),

            ],
          ),

          SizedBox(height: fieldSpacing*2),

          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusValue),
              side: BorderSide(
              color: colorScheme.outline,
              width: 1,
            ),
            ),

            child: SizedBox(
          
              child: CheckboxListTile(
              title: const Text('I accept terms and conditions'),
              subtitle: const Text('Read our terms and conditions here'),
              value: termsAreChecked,
              onChanged: (bool? value) {
                setState(() {
                  termsAreChecked = value ?? false;
                });
              },
            ),
            ),
          ),

          SizedBox(height: fieldSpacing*2),

          SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () {
                if(!_validateFields( context))
                {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (dialogContext) {
                      final dialogNavigator = Navigator.of(dialogContext);

                      Future.delayed(const Duration(seconds: 3), () {
                        if (!mounted) return;
                        if (dialogNavigator.canPop()) {
                          dialogNavigator.pop();
                        }
                      });

                      return const AlertDialog(
                        title: Text('Error'),
                        content: Text('Please fill all fields correctly and accept the terms and conditions'),
                      );
                    },
                  );
                  return;
                }
                //final count = ref.read(usersProvider.notifier).getUsersCount();

                final newUser = UserData(
                  //id: count + 1,
                  name: nameController.text.trim(),
                  surname: surnameController.text.trim(),
                  dni: dni,
                  gender: selectedGender,
                  birthdate: birthdate,
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  phone: int.tryParse(phoneController.text.trim()) ?? 0,
                  address: addressController.text.trim(),
                  state: "active",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (dialogContext) => AlertDialog(
                    title: Text('Confirmation Sign Up', style: textStyle.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),),
                    content: Text('Are you sure you want to create an account?', style: textStyle.bodyMedium),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: (){Navigator.pop(dialogContext);_addNewUsser(newUser);},
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

              icon: const Icon(Icons.person_add, color: Colors.white),
              label: Text(
                'Sign Up',
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
        ],
      ),
    );
  }

  Future<void> _addNewUsser(UserData newUser) async {
    final userProviderNotifier = ref.read(usersProvider.notifier);
    final sessionContext = ref.read(sessionProvider.notifier);

    final result = await userProviderNotifier.addUser(newUser);
    if (!mounted) return;
  
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result ? 'Account created successfully ' : 'A user with the same email or DNI already exists',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium
          ),
          backgroundColor: result ? Colors.green : Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );
    if (!result) return;
    sessionContext.login(newUser);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    context.go('/home');
  }

  bool _validateFields(BuildContext context) {
    final aux = int.tryParse(dniController.text);              
    if(aux == null || birthdate == DateTime(2000, 1, 1) || !_formKey.currentState!.validate() || !termsAreChecked)
    {
      return false;
    }
    dni = aux;
    return true;
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