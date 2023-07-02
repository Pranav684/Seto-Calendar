//  created this file while searching the methods to sync the data
// currently not in use...

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // google sign in
  Future<UserCredential> signInWithGoogle() async {
    // begin interactive sign in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    print('checkPoint-1');

    // obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    print('checkPoint-2');

    // create a new credentail for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    print('checkPoint-3');
    // let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
