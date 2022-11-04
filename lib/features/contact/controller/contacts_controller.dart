import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/features/contact/repository/contacts_repository.dart';

final getContactsProvider = FutureProvider((ref) {
  final contactsRepository = ref.watch(contactsRepositoryProvider);
  return contactsRepository.getAllContacts();
});
