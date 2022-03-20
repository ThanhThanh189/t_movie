import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  FirebaseAuth? firebaseAuth;

  UserRepository() {
    firebaseAuth = FirebaseAuth.instance;
  }

  Future<User?> createUserWithEmailPassword(
      String email, String password) async {
    try {
      var result = await firebaseAuth!
          .createUserWithEmailAndPassword(email: email, password: password);

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
    return  firebaseAuth!.currentUser;
  }

  Future<void> logOut() async {
    await firebaseAuth!.signOut();
  }

  Future<void> updateUser({String? displayName, String? photoURL}) async {
    var user = firebaseAuth!.currentUser;
    if (displayName != null) {
      await user!.updateProfile(displayName: displayName);
    }
    if (photoURL != null) {
      await user!.updateProfile(photoURL: photoURL);
    }
  }
}
