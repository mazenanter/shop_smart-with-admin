import 'package:firebase_auth/firebase_auth.dart';

abstract class Failure {
  final String errMsg;

  Failure(this.errMsg);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMsg);

  factory ServerFailure.fromFirebaseErr(FirebaseAuthException e) {
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
