import 'package:flutter/material.dart';

class UUIDListPage extends StatelessWidget {
  final List<String> uuidList;

  UUIDListPage({required this.uuidList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Tickets'),
      ),
      body: ListView.builder(
        itemCount: uuidList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(uuidList[index]),
          );
        },
      ),
    );
  }
}
