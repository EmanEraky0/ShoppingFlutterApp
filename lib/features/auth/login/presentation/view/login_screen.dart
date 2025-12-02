import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/utils/constants/ui_result.dart';
import 'package:shopping_flutter_app/core/utils/constants/validations.dart';
import 'package:shopping_flutter_app/features/auth/login/presentation/viewmodel/login_viewmodel.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_field_input.dart';
import '../../data/models_DTOs/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenContent();
}

class _LoginScreenContent extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void submitLogin(LoginViewModel vm) {
    if (_formKey.currentState!.validate()) {
      vm.login(idController.text);
    }
  }

  @override
  void dispose() {
    idController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<LoginViewModel>(builder: (context, vm, child) {
          final state = vm.state;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is Success<UserModel>) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //       content: Text(state.data.username),
              //       backgroundColor: Colors.green),
              // );

              Navigator.pushReplacementNamed(context, '/main');
            } else if (state is Error<UserModel>) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          });
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          Image.asset(
                            "assets/images/logo.png",
                            height: 180,
                            width: 250,
                            fit: BoxFit.contain,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (context.locale.languageCode == 'en') {
                                context.setLocale(const Locale('ar'));
                              } else {
                                context.setLocale(const Locale('en'));
                              }
                            },
                            child: Text(
                                context.locale.languageCode == 'en'
                                    ? "Arabic".tr()
                                    : "English".tr(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'welcomeMessage'.tr(),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomInputField(
                            controller: idController,
                            hintText: 'Enter your Id'.tr(),
                            prefixIcon: Icons.perm_identity,
                            inputType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Id cannot be empty'.tr();
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomInputField(
                            controller: _emailController,
                            hintText: 'Enter your email'.tr(),
                            prefixIcon: Icons.email_outlined,
                            inputType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email cannot be empty'.tr();
                              }
                              if (!RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$')
                                  .hasMatch(value)) {
                                return 'Invalid email'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomInputField(
                            controller: _passwordController,
                            hintText: 'Enter your password'.tr(),
                            isPassword: true,
                            prefixIcon: Icons.lock_outline,
                            inputType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password cannot be empty'.tr();
                              }
                              if (!validationPassword(value)) {
                                return 'Invalid password format'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            text: 'Login'.tr(),
                            color: Colors.cyan.shade600, // custom color
                            borderRadius: 30, // custom curve
                            onPressed: () {
                              submitLogin(vm);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Don’t have an account? ".tr(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              children: [
                                TextSpan(
                                  text: "Sign up".tr(),
                                  style: const TextStyle(
                                    color: Colors.cyan,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(context, "/signup");
                                    },
                                ),
                              ],
                            ),
                          )
                        ]))),
              ),
              if (state is Loading)
                Container(
                  color: Colors.grey.withAlpha(128),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        }));
  }
}
