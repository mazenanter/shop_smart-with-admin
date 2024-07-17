part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

final class RegisterUserSuccess extends RegisterUserState {}

final class RegisterUserError extends RegisterUserState {
  final String errMsg;

  RegisterUserError(this.errMsg);
}

final class RegisterUserLoading extends RegisterUserState {}
