import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_firebase/core/error/failure.dart';
import 'package:ecommerce_app_firebase/features/profile/data/models/user_model.dart';
import 'package:ecommerce_app_firebase/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepoImpl extends AuthRepo {
  @override
  Future<Either<Failure, UserCredential>> registerUser(
      {required String email,
      required String password,
      required String name,
      required String image,
      required List userCart,
      required File pickedImage,
      required List wishlist,
      required Timestamp timestamp}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? userId = auth.currentUser;
      final String uId = userId!.uid;
      final ref = FirebaseStorage.instance
          .ref()
          .child('usersImages')
          .child('${email}.jpg');
      await ref.putFile(File(pickedImage.path));
      image = await ref.getDownloadURL();
      FirebaseFirestore.instance.collection('users').doc(uId).set(UserModel(
            email: email,
            name: name,
            image: image,
            createdAt: timestamp,
            userCart: userCart,
            wishlist: wishlist,
            userId: uId,
          ).toJson());
      return right(user);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(ServerFailure.fromFirebaseErr(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> loginUser(
      {required String email, required String password}) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(user);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return left(ServerFailure.fromFirebaseErr(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      var result = await FirebaseAuth.instance.signInWithCredential(credential);

      final String uId = result.user!.uid;
      if (result.additionalUserInfo!.isNewUser) {
        FirebaseFirestore.instance.collection('users').doc(uId).set(UserModel(
              email: result.user!.email!,
              name: result.user!.displayName!,
              image: result.user!.photoURL!,
              createdAt: Timestamp.now(),
              userCart: [],
              wishlist: [],
              userId: uId,
            ).toJson());
      }
      return right(result);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
