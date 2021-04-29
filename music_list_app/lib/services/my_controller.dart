import 'package:music_list_app/services/auth.dart';

import '../model/track.dart';
import 'firestore_backend.dart';

class MyController {

  static Future<List<Track>> getTracks() {
    return FirestoreBackend.getTracks();
  }

  static Future<List<Track>> getUserTracks() {
    return FirestoreBackend.getUserTracks(Auth.getUserId());
  }

  static Future<void> deleteUserTrack(Track track) {
    return FirestoreBackend.removeUserTrack(track, Auth.getUserId());
  }

  static Future<Track> addUserTrack(Track track) {
    return FirestoreBackend.insertUserTrack(Auth.getUserId(), track);
  }

  static Future<String> createAccount({String email, String password}) {
    return Auth.createAccountWithEmailAndPassword(email: email, password: password);
  }

  static Future<String> signIn({String email, String password}) {
    return Auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signInWithGoogle() {
    return Auth.signInWithGoogle();
  }

  static Future<void> signOut() {
    return Auth.signOut();
  }

  static bool isSignedIn() {
    return Auth.isSignedIn();
  }
}
