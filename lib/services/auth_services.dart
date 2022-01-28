part of 'services.dart';

enum LoginType { email, anonymous }

class AuthServices {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<String>> getUsers(User user) async {
    List<String> users = [];

    var data = await _firestore.collection('users').get();
    data.docs.map((e) {
      if (e.id != user.uid) {
        users.add(e.id);
      }
    }).toList();
    return users;
  }

  static Future<UserCredential> login(LoginType loginType,
      {String? email, String? password}) async {
    UserCredential credential;
    try {
      if (loginType == LoginType.anonymous) {
        credential = await _auth.signInAnonymously();
      } else {
        credential = await _auth.signInWithEmailAndPassword(
            email: email!, password: password!);
      }
      _firestore.collection('users').doc(credential.user!.uid).set({
        'id': credential.user!.uid,
        'email': credential.user!.email,
        'name': credential.user!.displayName,
      });

      return credential;
    } catch (e) {
      throw Future.error(e);
    }
  }
}
