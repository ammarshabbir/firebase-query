import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayData extends StatefulWidget {
  @override
  _DisplayDataState createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;



  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').where('name',isEqualTo: 'ammar shabbir').snapshots();

  Widget realtimeChanges(){
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          shrinkWrap: true,
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['name']),
              subtitle: new Text(document.data()['age']),
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Display Data'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            realtimeChanges(),
          ],
        ),
      ),
    );
  }
}
