import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/features/auth/repositories/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  void saveUserInfoToFirestore({
    required String username,
    required var profileImage,
    required BuildContext context,
    required bool mounted,
  }) {
    authRepository.saveUserInfoToFirestore(
      username: username,
      profileImage: profileImage,
      ref: ref,
      context: context,
      mounted: mounted,
    );
  }

  void verifiySmsCode({
    required BuildContext context,
    required String smsCodeId,
    required String smsCode,
    required bool mounted,
  }) {
    authRepository.verifiySmsCode(
      context: context,
      smsCodeId: smsCodeId,
      smsCode: smsCode,
      mounted: mounted,
    );
  }

  void sendSmsCode({required BuildContext context, required String phone}) {
    authRepository.sendSmsCode(context: context, phone: phone);
  }
}
