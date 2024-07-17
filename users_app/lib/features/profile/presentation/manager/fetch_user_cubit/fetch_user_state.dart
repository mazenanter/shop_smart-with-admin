part of 'fetch_user_cubit.dart';

@immutable
sealed class FetchUserState {}

final class FetchUserInitial extends FetchUserState {}

final class FetchUserSuccess extends FetchUserState {
  final UserModel userModel;

  FetchUserSuccess(this.userModel);
}

final class FetchUserError extends FetchUserState {
  final String errMsg;

  FetchUserError(this.errMsg);
}

final class FetchUserLoading extends FetchUserState {}
