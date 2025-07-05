import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_chat/core/error/failure.dart';

class AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSource({required this.firebaseAuth});

  Future<User> signIn(String email, String password) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  Future<User> register(String email, String password) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerFailure(e.message ?? 'Unknown Error');
    }
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
