import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/order_model.dart';
import 'package:ecommerce_app_firebase/features/profile/data/repos/profile_repo.dart';
import 'package:meta/meta.dart';

part 'fetch_orders_state.dart';

class FetchOrdersCubit extends Cubit<FetchOrdersState> {
  FetchOrdersCubit(this.profileRepo) : super(FetchOrdersInitial());
  final ProfileRepo profileRepo;
  List<OrderModel>? ordersList = [];
  Future<void> fetchAllOrders() async {
    emit(FetchOrdersLoading());
    ordersList = await profileRepo.fetchAllOrders().then((value) {
      emit(FetchOrdersSuccess(value));
    }).catchError((onError) {
      emit(FetchOrdersError(onError.toString()));
    });
  }
}
