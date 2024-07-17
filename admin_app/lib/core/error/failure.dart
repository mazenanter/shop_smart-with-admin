import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Failure {
  final String errMsg;

  Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  factory ServerFailure.fromFirebaseErr(FirebaseException e) {
    switch (e.code) {
      case 'weak-password':
        return ServerFailure('The password provided is too weak');
      case 'email-already-in-use':
        return ServerFailure('The account already exists for that email');
      default:
        return ServerFailure(e.message.toString());
    }
  }
}
