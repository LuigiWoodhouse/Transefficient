import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting

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
          // Get current timestamp in GMT-5
          var currentTime = DateTime.now().toUtc().subtract(Duration(hours: 5));
          var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
          String formattedTime = formatter.format(currentTime);

          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ticket ${index + 1}'), // Number each ticket
                Text('UUID: ${uuidList[index]}'), // Display UUID
                Text('Timestamp: $formattedTime (GMT-5)'), // Display timestamp in GMT-5
              ],
            ),
          );
        },
      ),
    );
  }
}
