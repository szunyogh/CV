import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:common/model/response/user.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<user.User> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    String? token = await FirebaseMessaging.instance.getToken();

    await FirebaseAuth.instance.signInWithCredential(credential);

    await FirebaseFirestore.instance.collection('users').doc(googleUser!.id).set({
      "name": googleUser.displayName,
      "profilePic": googleUser.photoUrl,
      "email": googleUser.email,
      "id": googleUser.id,
      "notificationId": int.tryParse(googleUser.id.substring(0, 6)),
      "fcmToken": token,
      "typingStatus": {"user_1": false, "user_2": false},
    });

    return user.User(
      id: googleUser.id,
      name: googleUser.displayName ?? "",
      email: googleUser.email,
      profilePic: googleUser.photoUrl ?? "",
      notificationId: int.tryParse(googleUser.id.substring(0, 6)) ?? 0,
      fcmToken: token ?? "",
      typingStatus: {"user_1": false, "user_2": false},
    );
  }

  Future<user.User> getUser() async {
    final id = FirebaseAuth.instance.currentUser?.providerData[0].uid ?? "";
    final _user = await FirebaseFirestore.instance.collection('users').doc(id).get();
    return user.User.fromJson(_user.data() ?? {});
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
