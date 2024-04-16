import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';
import 'view-all-ticket.dart';

class UUIDGenerator extends StatefulWidget {
  @override
  _UUIDGeneratorState createState() => _UUIDGeneratorState();
}

class _UUIDGeneratorState extends State<UUIDGenerator> {
  List<String> uuidList = [];
  String uuid = '';
  bool isButtonDisabled = false;
  int countdown = 30;

  void generateUUID() {
    if (!isButtonDisabled) {
      setState(() {
        uuid = Uuid().v4();
        uuidList.add(uuid); // Add the generated UUID to the list
        isButtonDisabled = true;
        countdown = 30;
      });

      // Countdown timer
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (countdown == 0) {
          timer.cancel();
          setState(() {
            isButtonDisabled = false;
          });
        } else {
          setState(() {
            countdown--;
          });
        }
      });

      // Enable button after 30 seconds
      Timer(Duration(seconds: 30), () {
        setState(() {
          isButtonDisabled = false;
        });
      });
    }
  }

  void viewUUIDList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UUIDListPage(uuidList: uuidList)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transefficient'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bus Ticket Number:',
            ),
            SizedBox(height: 10),
            Text(
              uuid,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isButtonDisabled ? null : () => generateUUID(),
              child: Text('Get a ticket'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Colors.purple; // Set background color to purple
                  },
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Color.fromARGB(255, 62, 59, 59); // Set text color to black when disabled
                    }
                    return Colors.white; // Set text color to white when enabled
                  },
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 10),
            Visibility(
              visible: isButtonDisabled,
              child: Text(
                'You can get another ticket in $countdown seconds',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: viewUUIDList, // Navigate to UUID list page
              child: Text('View All Tickets'),
            ),
          ],
        ),
      ),
    );
  }
}
