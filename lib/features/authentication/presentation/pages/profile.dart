import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oy5/features/authentication/presentation/pages/login.dart';

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({Key? key}) : super(key: key);

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          GestureDetector(
            onTap: _logout,
            child: const Icon(Icons.exit_to_app, color: Colors.red),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(16),
        child: _user != null
            ? ListTile(
                leading: _user!.photoURL != null
                    ? Image.network(
                        _user!.photoURL!,
                        fit: BoxFit.cover,
                      )
                    : Icon(Icons.person),
                title: Text(
                  _user!.displayName ?? "No Name",
                  style: TextStyle(
                    color: Color(0xFF001444),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  _user!.email ?? "No Email",
                  style: TextStyle(
                    color: Color(0xFF8C97AB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "No Name",
                  style: TextStyle(
                    color: Color(0xFF001444),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Text(
                  "No email",
                  style: TextStyle(
                    color: Color(0xFF8C97AB),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
