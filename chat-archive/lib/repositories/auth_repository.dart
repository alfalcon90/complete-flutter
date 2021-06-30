import 'package:app_name/providers/general_providers.dart';
import 'package:app_name/repositories/custom_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    // 'https://www.googleapis.com/auth/userinfo.profile	',
  ],
  // clientId:
  // '2386866246-6smggkmvikaqi1qr7iq01j518iq6mr57.apps.googleusercontent.com',
);

abstract class BaseAuthRepository {
  Stream<User?> get authStateChanges;
  Future<UserCredential?> signInWithGoogle();
  User? getCurrentUser();
  Future<void> signOut();
}

final authRepositoryProvider =
    Provider<AuthRepository>((ref) => AuthRepository(ref.read));

class AuthRepository implements BaseAuthRepository {
  final Reader _read;

  const AuthRepository(this._read);

  @override
  Stream<User?> get authStateChanges =>
      _read(firebaseAuthProvider).authStateChanges();

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }
      print(googleUser.displayName);

      // // Obtain the auth details from the request
      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;

      // // Create a new credential
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth.accessToken,
      //   idToken: googleAuth.idToken,
      // );

      // // Once signed in, return the UserCredential
      // return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  User? getCurrentUser() {
    try {
      _read(firebaseAuthProvider).currentUser;
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      _googleSignIn.disconnect();
    } on FirebaseAuthException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
