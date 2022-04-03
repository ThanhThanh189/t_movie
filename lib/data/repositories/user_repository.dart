import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<User?> createUserWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
    String? photoURL,
  }) async {
    try {
      var result = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);
      if (result.user != null) {
        await updateUser(displayName: displayName, photoURL: photoURL);
      }
      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      var result = await firebaseAuth!
          .signInWithEmailAndPassword(email: email, password: password);

      return result.user;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isSignedIn() async {
    var currentUser = firebaseAuth!.currentUser;
    return currentUser != null;
  }

  Future<User?> getCurrentUser() async {
    return firebaseAuth?.currentUser;
  }

  Future<void> logOut() async {
    await firebaseAuth?.signOut();
  }

  Future<bool> fetchSignInMethodsForEmail({required String email}) async {
    final value = await firebaseAuth?.fetchSignInMethodsForEmail(email);
    return value!.isNotEmpty ? true : false;
  }

  Future<void> updateUser({String? displayName, String? photoURL}) async {
    var user = firebaseAuth?.currentUser;
    if (displayName != null) {
      await user!.updateDisplayName(displayName);
    }
    if (photoURL != null) {
      await user!.updatePhotoURL(photoURL);
    }
  }
}
