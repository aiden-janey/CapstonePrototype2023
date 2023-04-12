import 'package:cloud_firestore/cloud_firestore.dart';

//get data from database
Future<Query<Object?>> getData() async {
  final collection = FirebaseFirestore.instance.collection('Item');
  Query query = collection.where('Name', isEqualTo: 'AMP MIXED BER');
  return query;
}
