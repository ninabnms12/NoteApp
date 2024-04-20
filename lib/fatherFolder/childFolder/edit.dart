import 'dart:async';

import 'package:flutter/material.dart';
import 'package:molahadati/fatherFolder/childFolder/home.dart';
import 'package:molahadati/fatherFolder/childFolder/sql.dart';

class editing extends StatefulWidget {
  final id;
  final note;
  const editing({super.key, this.id, this.note});

  @override
  State<editing> createState() => _editingState();
}

class _editingState extends State<editing> {
  GlobalKey<FormState> _forme = GlobalKey();
  TextEditingController _mark = TextEditingController();
  Sqldb ob = Sqldb();
  Future<void> updating() async {
    int response = await ob.Updatedata(
        'UPDATE note SET notes ="${_mark.text}" WHERE id = ${widget.id}');
    if (response > 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MyWidget(),
          ),
          (Route) => false);
    }

    print('respons = $response');
    print("id = ${widget.id}");
  }

  @override
  void initState() {
    // TODO: implement initState
    _mark.text = widget.note ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Container(
        child: Form(
            key: _forme,
            child: Column(
              children: [
                TextFormField(
                  controller: _mark,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      // mark = value;
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_forme.currentState!.validate()) {
                      updating();
                    }
                  },
                  child: Text('edit'),
                ),
              ],
            )),
      ),
    );
  }
}
