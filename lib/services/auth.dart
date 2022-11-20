import 'package:firebase_auth/firebase_auth.dart';
import 'package:org_off_ia/models/user.dart';


class AuthService {
  final FirebaseAuth _firebaseInstance = FirebaseAuth.instance;

  // create myUser
  MyUser? _firebaseUser(User? user) {
    bool isAdmin = user?.email?.contains('admin') ?? false;
    if (user != null) {
      return MyUser(uid: user.uid, isAdmin: isAdmin);
    } else {
      return null;
    }
  }

  // stream
  Stream<MyUser?> get user {
    return _firebaseInstance.authStateChanges()
    .map((User? user) => _firebaseUser(user));
  }
  // sign in anononymously 
  Future signInAnon() async {
    try {
    UserCredential result = await _firebaseInstance.signInAnonymously();
    User user = result.user!;
    return _firebaseUser(user);

    } catch(e) {
      print(e.toString());
      return null;

    }
  }

  // sign in 
  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _firebaseInstance.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _firebaseUser(user);

    } catch(e) {
      print(e.toString());
    }
  }



  // sign out
  Future signOut() async {
    try {

return await _firebaseInstance.signOut();
    } catch(e){
      print(e.toString());
      return null;

    }
  }
}