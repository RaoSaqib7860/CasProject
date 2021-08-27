import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_smart_ride_cas/rider/firebaseAuth/user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth
      .instance; //gives access to all the methods and properties on this class, so we can do things like sign in anonymously or email or password or signout

  // auth change user stream
  // ignore: deprecated_member_use
  // Stream<UserF> get user {
  //   //  return auth.onAuthStateChanged
  //   //   .map((FirebaseUser user) => _userFromFireBase(user));
  //   // ignore: deprecated_member_use
  //   return auth.onAuthStateChanged.map(_userFromFireBase);
  // }

  // ignore: deprecated_member_use
  UserF _userFromFireBase(final user) {
    return user != null ? UserF(uid: user.uid) : null;
  }

  // ignore: deprecated_member_use
  signInAnon() async {
    try {
      UserCredential userCredential = await auth.signInAnonymously();
      //   userCredential.user;
      final user = userCredential.user;
      //final user = (await auth.signInAnonymously()).user;
      // ignore: deprecated_member_use
      //   FirebaseUser user = userCredential.user;
      //  print(user);
      // return _userFromFireBase(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      final user = credential.user;
      print(user);
      return user;
      //return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      final user = credential.user;
      print(user);
      return user;
      //return _userFromFireBase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  /// GOOGLE SIGN_IN
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User> signInWithGoogle() async {
    /// 1st of all we need google signin Account
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    // After it we need to authenticated
    //auth details from request

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

    var result = await auth.signInWithCredential(googleAuthCredential);
    User user = result.user;
    print(
        "name........${user.displayName}....email. ${user.email}...........${user.phoneNumber}...........${user.emailVerified}");
    return user;

    //  User currentUser = auth.currentUser;
  }

  googleSignOut() {
    googleSignIn.signOut();
    print('user signed out');
  }
}
