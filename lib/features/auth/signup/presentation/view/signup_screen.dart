import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_flutter_app/core/utils/constants/ui_result.dart';
import 'package:shopping_flutter_app/features/auth/login/data/models_DTOs/user_model.dart';
import 'package:shopping_flutter_app/features/auth/signup/presentation/viewModel/signup_view_model.dart';
import '../../../../../core/utils/constants/validations.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/custom_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController idController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void submit(SignupViewModel vm) {
    if (_formKey.currentState!.validate()) {
      vm.signup(UserModel(
        id: int.parse(idController.text),
        username: userNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<SignupViewModel>(builder: (context, vm, child) {
          final state = vm.state;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state is Success) {
              Navigator.pushReplacementNamed(context, '/main');
            } else if (state is Error<Response>) {
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
                  child: Form(key:_formKey,child:  Column(children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 180,
                      width: 250,
                      fit: BoxFit.contain,
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
                      controller: userNameController,
                      hintText: 'Enter your Name'.tr(),
                      prefixIcon: Icons.perm_identity,
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name cannot be empty'.tr();
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
                    CustomInputField(
                      controller: _confirmPasswordController,
                      hintText: 'Enter confirm password'.tr(),
                      isPassword: true,
                      prefixIcon: Icons.lock_outline,
                      inputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty'.tr();
                        }
                        if (_passwordController.value.text != value) {
                          return 'Confirmed password not matched password'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // (state is Loading )? const CircularProgressIndicator():
                    CustomButton(
                      text: 'Signup'.tr(),
                      color: Colors.cyan.shade600, // custom color
                      borderRadius: 30, // custom curve
                      onPressed: () {
                        submit(vm);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Login".tr(),
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ]), )


                ),
              ),
              if (state is Loading)
                Container(
                  color: Colors.grey.withAlpha(128),
                  child: const Center(child: CircularProgressIndicator()),
                )
            ],
          );
        }));
  }
}
