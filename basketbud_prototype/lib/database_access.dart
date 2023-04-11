import 'package:cloud_firestore/cloud_firestore.dart';

//get data from database
Future<Map<String, dynamic>> getData() async {
  final DocumentSnapshot snapshot = FirebaseFirestore.instance
      .collection('Item') as DocumentSnapshot<Object?>;
  return snapshot.data() as Map<String, dynamic>;
}
