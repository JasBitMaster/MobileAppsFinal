import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;

  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<String> signInWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (exception) {
      return _parseSignInAuthException(exception);
    }
  }

  static Future<String> createAccountWithEmailAndPassword(
      {String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (exception) {
      return _parseCreateAccountAuthException(exception);
    }
  }

  static String getUserId() {
    return _auth.currentUser.uid;
  }

  static bool isSignedIn() {
    var _user = _auth.currentUser;
    return (_user != null);
  }

  static Future<void> signOut() {
    return _auth.signOut();
  }

  static String _parseSignInAuthException(FirebaseAuthException exception) {
    print(exception.code);
    switch (exception.code) {
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'user - not - found':
      case 'wrong - password':
      case 'user-disabled':
        return 'Invalid username or password';
      case 'too-many-requests':
      case 'operation-not-allowed':
      default:
        return 'An unknown error occurred';
    }
  }

  static String _parseCreateAccountAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'email - already-in-use':
        return 'This email address is already in use';
      default:
        return 'An unknown error occurred';
    }
  }
}
