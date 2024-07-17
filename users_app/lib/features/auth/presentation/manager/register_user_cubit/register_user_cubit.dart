import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUserCubit(this.authRepo) : super(RegisterUserInitial());
  final AuthRepo authRepo;
  void registerUser(
      {required String email,
      required String password,
      required String name,
      required String image,
      required List userCart,
      required List wishlist,
      required File pickedImage,
      required Timestamp timestamp}) async {
    emit(RegisterUserLoading());
    var user = await authRepo.registerUser(
      email: email,
      timestamp: timestamp,
      pickedImage: pickedImage,
      name: name,
      image: image,
      password: password,
      userCart: userCart,
      wishlist: wishlist,
    );
    return user.fold(
      (l) => emit(RegisterUserError(l.errMsg)),
      (r) => emit(RegisterUserSuccess()),
    );
  }
}
