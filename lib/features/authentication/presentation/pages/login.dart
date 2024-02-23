/* import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oy5/features/authentication/presentation/pages/signup.dart'; // Import SignUpScreen or the appropriate screen
import '../bloc/auth_bloc.dart';
import 'example.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ExampleScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Column(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password', ),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AuthBloc>().add(
                            AuthenticationLoginRequestedEvent(
                              email: _emailController.text,
                              password: _passwordController.text,
                              onSuccess: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => const ExampleScreen()),
                                  (route) => false,
                                );
                              },
                              onFailure: (message) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)));
                              },
                            ),
                          );
                    },
                    child: const Text("Login"),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to SignUpScreen or the appropriate screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    child: const Text("Sign Up"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:oy5/assets/constants/colors.dart';
import 'package:oy5/assets/constants/icons.dart';
import 'package:oy5/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:oy5/features/authentication/presentation/pages/profile.dart';
import 'package:oy5/features/authentication/presentation/pages/signup.dart';

class LoginScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginDataValid = false;
  final mailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final textFieldContentStyle = const TextStyle(
    color: hintTextColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  InputDecoration decoration({
    required String hintText,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 13.5),
        hintStyle: TextStyle(
          color: hintTextColor.withOpacity(.6),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        fillColor: textFieldBackgroundColor2,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorderColor.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
      );

  @override
  void initState() {
    mailTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });

    passwordTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    mailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    mailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const ExampleScreen()),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (FocusScope.of(context).hasFocus) {
                FocusScope.of(context).unfocus();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const Gap(67),
                    Image.asset("assets/logo/logo.png"),
                    const Gap(44),
                    TextFormField(
                      style: textFieldContentStyle,
                      cursorColor: cursorColor,
                      focusNode: mailFocusNode,
                      controller: mailTextEditingController,
                      decoration: decoration(hintText: 'Email'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onEditingComplete: () {
                        passwordFocusNode.requestFocus();
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, mail kiriting!';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Iltimos, yaroqli mail manzilini kiriting';
                        }

                        return null;
                      },
                    ),
                    const Gap(16),
                    TextFormField(
                      style: textFieldContentStyle,
                      cursorColor: cursorColor,
                      focusNode: passwordFocusNode,
                      controller: passwordTextEditingController,
                      decoration: decoration(
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 13.5),
                            child: SvgPicture.asset(
                              isObscure ? AppIcons.eyeOff : AppIcons.eyeOn,
                            ),
                          ),
                        ),
                      ),
                      onEditingComplete: () {
                        // TODO: Login
                      },
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: isObscure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Iltimos, parolingizni kiriting!';
                        } else if (value.length < 7) {
                          return 'Parol eng kamida 8ta belgidan tashkil topgan bo\'lishi kerak';
                        }

                        return null;
                      },
                    ),
                    const Gap(12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          
                        },
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: forgotPasswordColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              AuthenticationLoginRequestedEvent(
                                email: mailTextEditingController.text,
                                password: passwordTextEditingController.text,
                                onSuccess: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const ExampleScreen()),
                                    (route) => false,
                                  );
                                },
                                onFailure: (message) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                },
                              ),
                            );
                      },
                      child: const Text("Login"),
                    ),
                    const Gap(56),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Gap(6),
                        Text(
                          'OR',
                          style: TextStyle(
                            color: Color(0xFFFEFEFE),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(5),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset(AppIcons.facebook)),
                        const Gap(32),
                        ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset(AppIcons.google)),
                        const Gap(32),
                        ElevatedButton(
                            onPressed: () {},
                            child: SvgPicture.asset(AppIcons.apple)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 18,
                    right: 4),
                child: const Text(
                  "Don’t have an account ?",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFFEFEFE),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom + 18),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 15, color: signUpTextColor),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
