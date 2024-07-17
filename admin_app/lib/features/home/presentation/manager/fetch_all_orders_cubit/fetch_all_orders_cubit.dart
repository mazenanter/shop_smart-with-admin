import 'dart:developer';

import 'package:admin_app/features/home/data/models/order_model.dart';
import 'package:admin_app/features/home/data/repos/dashboard_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'fetch_all_orders_state.dart';

class FetchAllOrdersCubit extends Cubit<FetchAllOrdersState> {
  FetchAllOrdersCubit(this.dashboardRepo) : super(FetchAllOrdersInitial());
  final DashboardRepo dashboardRepo;
  List<OrderModel>? ordersList = [];
  // Future<void> fetchAllOrders() async {
  //   emit(FetchAllOrdersLoading());
  //   ordersList = await dashboardRepo.fetchAllOrders().then((value) {
  //     emit(FetchAllOrdersSuccess(value));
  //   }).catchError((onError) {
  //     emit(FetchAllOrdersError(onError.toString()));
  //   });
  // }

  Future<List<OrderModel>> fetchAllOrders() async {
    emit(FetchAllOrdersLoading());

    try {
      List<OrderModel> orders = [];
      final res = await FirebaseFirestore.instance.collection('orders').get();
      log('res lent : ${res.size.toString()}');
      for (var doc in res.docs) {
        log('res lent : ${res.docs.toString()}');
        final ordersListRes =
            await doc.reference.collection('ordersList').get();

        // لكل وثيقة في مجموعة 'ordersList'، قم بإضافة OrderModel إلى قائمة الطلبات
        for (var orderDoc in ordersListRes.docs) {
          orders.add(OrderModel.fromJson(orderDoc.data()));
        }
        log('order list is : ${orders.length.toString()}');
      }
      emit(FetchAllOrdersSuccess(orders));

      return orders;
    } catch (e) {
      emit(FetchAllOrdersError(e.toString()));
      log('Error fetching orders: $e');
      rethrow;
    }
  }
}
