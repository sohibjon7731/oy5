import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oy5/features/authentication/presentation/pages/splash.dart';
import 'package:oy5/features/authentication/presentation/pages/login.dart';
import 'package:oy5/firebase_options.dart';

import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/authentication/presentation/pages/signup.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Color(0xFF131524),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Color(0xFF131524),
            appBarTheme: AppBarTheme(color: Color(0xFF131524))),
        home: SplashScreen(),
      ),
    );
  }
}
