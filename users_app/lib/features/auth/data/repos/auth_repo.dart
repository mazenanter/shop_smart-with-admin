import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_firebase/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserCredential>> registerUser(
      {required String email,
      required String password,
      required String name,
      required String image,
      required List userCart,
      required List wishlist,
      required File pickedImage,
      required Timestamp timestamp});
  Future<Either<Failure, UserCredential>> loginUser(
      {required String email, required String password});

  Future<Either<Failure, UserCredential>> googleSignIn();
}
