part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class passwordstate extends AuthState {
  final bool obescure;

  passwordstate({required this.obescure});
}

final class uploadprofilestate extends AuthState {
   
}

final class loginloading extends AuthState {}

final class loginsucess extends AuthState {}

final class loginfailure extends AuthState {
  final String error_message;

  loginfailure({required this.error_message});
}

final class SignUpLoading extends AuthState {}

final class SignUpSucess extends AuthState {}

final class SignUpFaulure extends AuthState {
  final String error_message;

  SignUpFaulure({required this.error_message});
}
final class passwordnotsamestate extends AuthState {}

final class adduserSucess extends AuthState {}
final class uploadphotoSucess extends AuthState {}

