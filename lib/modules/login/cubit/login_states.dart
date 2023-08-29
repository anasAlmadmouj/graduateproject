import 'package:graduateproject/main_imports.dart';


abstract class LoginStates{}

class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}

class SuffixIsPasswordState extends LoginStates{}

class GetUserInfoLoadingState extends LoginStates{}
class GetUserInfoSuccessState extends LoginStates{}
class GetUserInfoErrorState extends LoginStates{}

class GetUserTypeSuccessState extends LoginStates{}
class GetUserTypeErrorState extends LoginStates{}
