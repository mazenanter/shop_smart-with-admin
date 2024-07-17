import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_user_state.dart';

class LoginUserCubit extends Cubit<LoginUserState> {
  LoginUserCubit(this.authRepo) : super(LoginUserInitial());
  final AuthRepo authRepo;

  void loginUser({required String email, required String password}) async {
    emit(LoginUserLoading());
    var user = await authRepo.loginUser(
      email: email,
      password: password,
    );
    return user.fold(
      (l) => emit(LoginUserError(l.errMsg)),
      (r) => emit(LoginUserSuccess()),
    );
  }
}
