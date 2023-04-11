import 'package:basketbud_prototype/database_access.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database_access.dart';

class DisplayData extends StatelessWidget {
  Future<List<Map<String, dynamic>>> items = getData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt Data'),
      ),
      body: SingleChildScrollView(
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
          ],
          rows: items.then((list) {
            return DataRow(cells: [DataCell(Text(list['Name'].toString()))]);
          }),
        ),
      ),
    );
  }
}
