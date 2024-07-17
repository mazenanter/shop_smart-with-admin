import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/user_model.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_user_state.dart';

class FetchUserCubit extends Cubit<FetchUserState> {
  FetchUserCubit(this.profileRepo) : super(FetchUserInitial());

  final ProfileRepo profileRepo;
  UserModel? userModel;
  Future<void> fetchUserInfo() async {
    emit(FetchUserLoading());
    var result = await profileRepo.fetchUserInfo();
    return result.fold(
      (failure) => emit(FetchUserError(failure.errMsg)),
      (right) {
        userModel = right;
        return emit(
          FetchUserSuccess(right),
        );
      },
    );
  }
}
