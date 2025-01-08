import 'package:chat_app/src/core/field_validators.dart';
import 'package:chat_app/src/core/themes/app_colors.dart';
import 'package:chat_app/src/providers/auth_provider.dart';
import 'package:chat_app/src/core/constants.dart';
import 'package:chat_app/src/core/extensions/context_extensions.dart';
import 'package:chat_app/src/core/routes/app_routes.dart';
import 'package:chat_app/src/core/strings.dart';
import 'package:chat_app/src/widgets/app_button.dart';
import 'package:chat_app/src/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'login_form');
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final FocusNode _emailNode = FocusNode(debugLabel: '_emailNode');
  final FocusNode _passNode = FocusNode(debugLabel: '_passNode');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                50.h.verticalSpace,
                RichText(
                  text: TextSpan(
                    text: Strings.welcome,
                    style: Theme.of(context).textTheme.titleLarge?.apply(
                          fontWeightDelta: 2,
                          color: AppColors.lTextPrimary,
                        ),
                    children: [
                      TextSpan(
                        text: '\n${Strings.loginTOContinueApp}',
                        style: Theme.of(context).textTheme.bodyLarge?.apply(
                              color: AppColors.lTextSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
                80.h.verticalSpace,
                AppTextField(
                  controller: _emailController,
                  focusNode: _emailNode,
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_passNode),
                  labelText: Strings.email,
                  hintText: Strings.emailHint,
                  validator: (val) => FieldValidators().multiCheck(val, [
                    FieldValidators().required,
                    FieldValidators().email,
                  ]),
                ),
                20.h.verticalSpace,
                AppTextField(
                  controller: _passController,
                  focusNode: _passNode,
                  obscureText: true,
                  obscuringCharacter: '-',
                  onTapOutside: (_) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (_) => _onLoginTap(),
                  labelText: Strings.password,
                  validator: (val) => FieldValidators().multiCheck(val, [
                    FieldValidators().required,
                    FieldValidators().password,
                  ]),
                ),
                50.h.verticalSpace,
                Align(
                  alignment: Alignment.center,
                  child: Consumer<AuthenticationProvider>(
                    builder: (context, provider, _) {
                      return AppButton(
                        onPressed: _onLoginTap,
                        suffixSpace: 30,
                        title: Strings.continueTxt,
                        isLoading: provider.isLaoding,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onLoginTap() {
    final provider = context.read<AuthenticationProvider>();
    if (_formKey.currentState?.validate() == true) {
      provider.signIn(
        _emailController.text.trim(),
        _passController.text.trim(),
        onSuccess: (uid) async {
          context.showSuccess(Strings.loggedIn);
          context.goNamed(
            await provider.isObBoarded(uid)
                ? AppRoutes.homePage.name
                : AppRoutes.setupProfilePage.name,
          );
        },
        onFailure: (msg) => context.showError(msg),
      );
    }
  }
}
