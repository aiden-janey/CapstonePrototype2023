import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DisplayData extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'name': 'John', 'age': 28, 'email': 'john@example.com'},
    {'name': 'Sarah', 'age': 32, 'email': 'sarah@example.com'},
    {'name': 'Tom', 'age': 24, 'email': 'tom@example.com'},
    {'name': 'Jane', 'age': 41, 'email': 'jane@example.com'},
    {'name': 'David', 'age': 36, 'email': 'david@example.com'},
  ];
  final DocumentSnapshot snapshot = FirebaseFirestore.instance
      .collection('Item') as DocumentSnapshot<Object?>;
  final Map<String, dynamic> items = snapshot.data() as Map<String, dynamic>;

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
            DataColumn(label: Text('Age')),
            DataColumn(label: Text('Email')),
          ],
          rows: data.map((row) {
            return DataRow(cells: [
              DataCell(Text(row['name'])),
              DataCell(Text(row['age'].toString())),
              DataCell(Text(row['email'])),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
