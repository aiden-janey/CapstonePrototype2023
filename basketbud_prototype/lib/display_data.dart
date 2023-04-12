import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final Stream<QuerySnapshot> itemStream =
      FirebaseFirestore.instance.collection('Item').snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: itemStream, //_getData().snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Material(
              child: ListTile(
                title: Text(data['Name']),
              ),
            );
          }).toList(),
        );
        // return DataTable(
        //   columns: <DataColumn>[DataColumn(label: Text('Name'))],
        //   rows: _buildRows(snapshot.data!.docs),
        // );
      },
    );
  }

  // Query<Object?> _getData() {
  //   Query query = FirebaseFirestore.instance.collection('Item');
  //   return query;
  // }

  // List<DataRow> _buildRows(List<DocumentSnapshot> documents) {
  //   List<DataRow> rows = [];

  //   for (DocumentSnapshot document in documents) {
  //     String name;
  //     if (document.exists) {
  //       name = document.get('Name');
  //     } else {
  //       name = "DNE";
  //     }

  //     DataRow row = DataRow(cells: [DataCell(Text(name))]);

  //     rows.add(row);
  //   }
  //   return rows;
  // }
}
