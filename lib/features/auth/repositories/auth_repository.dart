import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/common/helper/show_alert_dialog.dart';
import 'package:whatsapp_chat_app/features/auth/pages/user_info_page.dart';
import 'package:whatsapp_chat_app/features/auth/pages/verification_page.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({required this.auth, required this.firestore});

  void verifiySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(verificationId: smsCodeId, smsCode: smsCode);
      await auth.signInWithCredential(credential);
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(UserInfoPage.id, (route) => false);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.message.toString());
    }
  }

  void sendSmsCode({required BuildContext context, required String phone}) async {
    try {
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
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
