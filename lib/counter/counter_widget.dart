import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/constants/constants.dart';

class CounterWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('counter').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              final counterDocument = snapshot.data.documents
                  .where((document) =>
              document.documentID == COUNT_DOCUMENT_ID)
                  .first;
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'You guys have pushed the button this many times:',
                    ),
                    Text(
                      counterDocument['count'].toString(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .display1,
                    ),
                  ]
              );
          }
        }
      );
  }
}