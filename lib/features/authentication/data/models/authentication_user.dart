import 'package:firebase_auth/firebase_auth.dart';
import 'package:oy5/features/authentication/domain/entities/authentication_user.dart';

class AuthenticationUserModel extends AuthenticatedUserEntity{
  AuthenticationUserModel({required super.email});

  factory AuthenticationUserModel.fromFirebaseUser(User user){
    return AuthenticationUserModel(email:user.email??"");
  }
} 