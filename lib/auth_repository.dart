import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    if (user != null) {
      final userRef = _firestore.collection('users').doc(user.uid);
      userRef.get().then((doc) {
        if (!doc.exists) {
          userRef.set({
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'wallet': 0,
          });
        }
      });
    }

    return user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await googleSignIn.signOut();
  }

  Stream<User?> get user {
    return _auth.authStateChanges();
  }
}
