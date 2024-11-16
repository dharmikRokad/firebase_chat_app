import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/utils/context_extensions.dart';
import 'package:chat_app/utils/router.dart';
import 'package:chat_app/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.h.verticalSpace,
              Text(
                'Welcome to the app!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              40.h.verticalSpace,
              RichText(
                text: TextSpan(
                  text: 'Login',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.apply(fontWeightDelta: 2),
                  children: [
                    TextSpan(
                      text: '\nto continue using the app.',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              30.h.verticalSpace,
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'test@mailinator.com',
                  border: OutlineInputBorder(),
                ),
              ),
              10.h.verticalSpace,
              TextFormField(
                controller: _passController,
                obscureText: true,
                obscuringCharacter: '-',
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              50.h.verticalSpace,
              Align(
                alignment: Alignment.center,
                child: ValueListenableBuilder(
                  valueListenable: isLoading,
                  builder: (context, value, _) {
                    return AppButton(
                      onPressed: () async {
                        try {
                          isLoading.value = true;
                          await AuthService().signIn(
                            email: _emailController.text,
                            password: _passController.text,
                          );
                          if (!context.mounted) return;
                          context
                              .pushReplacementNamed(RouteNames.homePage.name);
                        } on FirebaseAuthException catch (e) {
                          context.showWarning(e.message ?? '');
                        } finally {
                          isLoading.value = false;
                        }
                      },
                      suffixSpace: 30,
                      title: 'Start',
                      isLoading: value,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
