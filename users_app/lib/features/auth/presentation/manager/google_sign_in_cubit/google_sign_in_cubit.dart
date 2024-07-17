import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit(this.authRepo) : super(GoogleSignInInitial());
  final AuthRepo authRepo;
  void googleSignIn() async {
    emit(GoogleSignInLoading());
    var result = await authRepo.googleSignIn();
    return result.fold(
      (l) => emit(GoogleSignInError(l.errMsg)),
      (r) => emit(GoogleSignInSuccess()),
    );
  }
}
