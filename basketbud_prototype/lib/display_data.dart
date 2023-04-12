import 'package:basketbud_prototype/database_access.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database_access.dart';

class DisplayData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _getData().snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData) {
          return Text('Loading...');
        }
        return DataTable(
          columns: <DataColumn>[DataColumn(label: Text('Name'))],
          rows: _buildRows(snapshot.data!.docs),
        );
      },
    );
  }

  Query<Object?> _getData() {
    final collection = FirebaseFirestore.instance.collection('Item');
    Query query = collection.where('Name', isEqualTo: 'AMP MIXED BER');
    return query;
  }

  List<DataRow> _buildRows(List<DocumentSnapshot> documents) {
    List<DataRow> rows = [];

    for (DocumentSnapshot document in documents) {
      String name;
      if (document.exists) {
        name = document.get('Name');
      } else {
        name = "DNE";
      }

      DataRow row = DataRow(cells: [DataCell(Text(name))]);

      rows.add(row);
    }
    return rows;
  }
}
