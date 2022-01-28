part of 'services.dart';

class MessageServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List> getContacts(User user) async {
    List contacts = [];
    var data = await _firestore.collection('room').doc(user.uid).get();
    if (data.data() != null && (data.data()!['contacts'] as List).isNotEmpty) {
      contacts.addAll(data.data()!['contacts'] as List);
    }
    return contacts;
  }

  static Future<List> getRooms(User user, List contacts) async {
    List rooms = [];
    for (var contact in contacts) {
      var data =
          _firestore.collection('room').doc(user.uid).collection(contact).id;
      rooms.add(contact);
    }
    return rooms;
  }

  static Stream<QuerySnapshot<Map?>> getMessage(User user, String to) {
    var data =
        _firestore.collection('room').doc(user.uid).collection(to).snapshots();
    return data;
  }

  static Future sendMessage(String message, User user, String to) async {
    await _firestore
        .collection("room")
        .doc(user.uid)
        .collection(to)
        .doc(DateTime.now().toIso8601String())
        .set({
      'from': user.uid,
      'to': to,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    await _firestore
        .collection("room")
        .doc(to)
        .collection(user.uid)
        .doc(DateTime.now().toIso8601String())
        .set({
      'from': user.uid,
      'to': to,
      'message': message,
      'timestamp': DateTime.now().toIso8601String(),
    });
    var data = await _firestore.collection("room").doc(user.uid).get();

    if (data.exists) {
      await _firestore.collection("room").doc(user.uid).update({
        'timestamp': DateTime.now().toIso8601String(),
        'contacts': FieldValue.arrayUnion([to])
      });
    } else {
      await _firestore.collection("room").doc(user.uid).set({
        'timestamp': DateTime.now().toIso8601String(),
        'contacts': FieldValue.arrayUnion([to])
      });
    }

    var dataTo = await _firestore.collection("room").doc(to).get();

    if (dataTo.exists) {
      await _firestore.collection("room").doc(to).update({
        'timestamp': DateTime.now().toIso8601String(),
        'contacts': FieldValue.arrayUnion([user.uid])
      });
    } else {
      await _firestore.collection("room").doc(to).set({
        'timestamp': DateTime.now().toIso8601String(),
        'contacts': FieldValue.arrayUnion([user.uid])
      });
    }
  }
}
