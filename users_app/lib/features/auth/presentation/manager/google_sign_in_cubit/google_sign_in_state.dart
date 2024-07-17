part of 'google_sign_in_cubit.dart';

@immutable
sealed class GoogleSignInState {}

final class GoogleSignInInitial extends GoogleSignInState {}

final class GoogleSignInSuccess extends GoogleSignInState {}

final class GoogleSignInLoading extends GoogleSignInState {}

final class GoogleSignInError extends GoogleSignInState {
  final String errMsg;

  GoogleSignInError(this.errMsg);
}
