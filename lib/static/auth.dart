import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hero_chum/static/state.dart';

Future<UserCredential?> registerUser(
    String emailAddress, String password) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    GlobalState.isUserLoggedIn.value = true;
    GlobalState.user = credential.user!;

    // create user object in firestore
    await FirebaseFirestore.instance
        .collection("users")
        .doc(credential.user!.uid)
        .set({"gems": 100});

    Get.toNamed("/");
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  return null;
}

Future<UserCredential?> signInUser(String emailAddress, String password) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    GlobalState.isUserLoggedIn.value = true;
    GlobalState.user = credential.user!;

    // get gems count from firestore user doc
    final userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(credential.user!.uid)
        .get();
    GlobalState.gems.value = userDoc.data()!["gems"];

    Get.toNamed("/");
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    print(e);
  }

  return null;
}

Future<void> signOutUser() async {
  await FirebaseAuth.instance.signOut();
  GlobalState.isUserLoggedIn.value = false;
  Get.toNamed("/");
}
