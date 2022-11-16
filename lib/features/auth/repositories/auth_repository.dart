import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_chat_app/common/helper/show_loading_dialog.dart';
import 'package:whatsapp_chat_app/common/repository/firebase_storage_repository.dart';
import 'package:whatsapp_chat_app/features/auth/pages/user_info_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/verification_page.dart';
import 'package:whatsapp_chat_app/features/home/pages/home_page.dart';
import 'package:whatsapp_chat_app/models/user_model.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
    database: FirebaseDatabase.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseDatabase database;

  AuthRepository({
    required this.auth,
    required this.firestore,
    required this.database,
  });

  Stream<UserModel> getUserOnlineStatus(String uid) {
    return firestore.collection('users').doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data()!),
        );
  }

  void updateUserPresence() async {
    Map<String, dynamic> presenceStatusTrue = {
      'active': true,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };
    Map<String, dynamic> presenceStatusFalse = {
      'active': false,
      'lastSeen': DateTime.now().millisecondsSinceEpoch,
    };

    final connectedRef = database.ref(".info/connected");
    connectedRef.onValue.listen((event) async {
      final connected = event.snapshot.value as bool? ?? false;
      if (connected) {
        await database
            .ref()
            .child(auth.currentUser!.uid)
            .update(presenceStatusTrue);
      } else {
        database
            .ref()
            .child(auth.currentUser!.uid)
            .onDisconnect()
            .update(presenceStatusFalse);
      }
    });
  }

  Future<UserModel?> getCurrentUserInfo() async {
    final userInfo =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void saveUserInfoToFirestore({
    required String username,
    required var profileImage,
    required ProviderRef ref,
    required BuildContext context,
    required bool mounted,
  }) async {
    try {
      String uid = auth.currentUser!.uid;
      String profileImageUrl = profileImage is String ? profileImage : '';

      showLoadingDialog(
        context: context,
        message: 'Saving user info...',
      );

      if (profileImage != null && profileImage is! String) {
        profileImageUrl = await ref
            .read(firebaseStorageRepositoryProvider)
            .storeFileToFirebase(
              'profileImage/$uid',
              profileImage,
            );
      }

      UserModel user = UserModel(
        username: username,
        uid: uid,
        profileImageUrl: profileImageUrl,
        active: true,
        lastSeen: DateTime.now().millisecondsSinceEpoch,
        phoneNumber: auth.currentUser!.phoneNumber!,
        groupId: [],
      );

      await firestore.collection('users').doc(uid).set(user.toMap());

      updateUserPresence();

      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        HomePage.id,
        (route) => false,
      );
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifiySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      showLoadingDialog(
        context: context,
        message: 'Verifiying code...',
      );
      final credential = PhoneAuthProvider.credential(
          verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      UserModel? user = await getCurrentUserInfo();
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        UserInfoPage.id,
        (route) => false,
        arguments: user?.profileImageUrl,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.message.toString());
    }
  }

  void sendSmsCode(
      {required BuildContext context, required String phone}) async {
    try {
      showLoadingDialog(
        context: context,
        message: 'Sending a verification code to $phone',
      );
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          showAlertDialog(context: context, message: e.toString());
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            VerificationPage.id,
            (route) => false,
            arguments: {'phone': phone, 'verificationId': verificationId},
          );
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      Navigator.pop(context);
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
