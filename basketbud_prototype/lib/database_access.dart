import 'package:cloud_firestore/cloud_firestore.dart';

//get data from database
getData() async {
  List<Map<String, dynamic>> documents = [];
  await FirebaseFirestore.instance.collection('Item').get().then((snapshot) {
    snapshot.docs.forEach((element) {
      Map<String, dynamic> data = element.data();
      documents.add(data);
    });
  });
  return documents;
}
