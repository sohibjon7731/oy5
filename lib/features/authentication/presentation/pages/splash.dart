import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oy5/features/authentication/presentation/pages/profile.dart';
import 'package:oy5/features/authentication/presentation/pages/login.dart';

import '../bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const ExampleScreen()),
              (_) => false);
        } else if (state.status == AuthenticationStatus.unauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false);
        }
      },
      builder: (context, state) {
        if (state.status == AuthenticationStatus.unknown) {
          context.read<AuthBloc>().add(AuthenticationGetStatusEvent());
        }
        return Scaffold(
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(40),
            child: const CupertinoActivityIndicator(
              radius: 16,
              color: Color(0xFF8C97AB)
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),
              Center(child: Image.asset("assets/logo/logo.png")),
              SizedBox(height: 5,),
              Text(
                "Productive",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              
            ],
          ),
        );
      },
    );
  }
}
