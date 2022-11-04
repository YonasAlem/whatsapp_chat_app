import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_chat_app/models/user_model.dart';

final contactsRepositoryProvider = Provider((ref) {
  return ContactsRepository(
    firestore: FirebaseFirestore.instance,
  );
});

class ContactsRepository {
  final FirebaseFirestore firestore;

  ContactsRepository({required this.firestore});

  Future<List<List>> getAllContacts() async {
    List<UserModel> positiveNumbers = [];
    List<UserModel> negativeNumbers = [];

    try {
      if (await FlutterContacts.requestPermission()) {
        final userCollection = await firestore.collection('users').get();
        List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
        bool contactFound = false;
        for (var contact in contacts) {
          for (var firebaseList in userCollection.docs) {
            var firebaseContact = UserModel.fromMap(firebaseList.data());
            if (contact.phones[0].number.replaceAll(' ', '') == firebaseContact.phoneNumber) {
              positiveNumbers.add(firebaseContact);
              contactFound = true;
              break;
            }
          }
          if (!contactFound) {
            negativeNumbers.add(
              UserModel(
                username: contact.displayName,
                uid: '',
                profileImageUrl: '',
                active: false,
                phoneNumber: contact.phones[0].number,
                groupId: [],
              ),
            );
          }
          contactFound = false;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    for (var data in negativeNumbers) {
      log(data.username);
    }
    return [positiveNumbers, negativeNumbers];
  }
}
