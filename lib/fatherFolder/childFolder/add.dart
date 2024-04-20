import 'package:flutter/material.dart';
import 'package:molahadati/fatherFolder/childFolder/home.dart';
import 'package:molahadati/fatherFolder/childFolder/sql.dart';

class adding extends StatefulWidget {
  final id;
  final note;
  const adding({super.key, this.id, this.note});

  @override
  State<adding> createState() => _edditing_addingState();
}

class _edditing_addingState extends State<adding> {
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController _mark = TextEditingController();

  Sqldb ob = Sqldb();
  Future<Map> isertingdata(String n) async {
    Map<String, dynamic> alldata = {'notes': n};
    int reponse = await ob.Insert('note', alldata);

    if (reponse > 0) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => MyWidget(),
          ),
          (Route) => false);
    }
    print(reponse);
    print(alldata);
    return alldata;
  }

  // @override
  // void initState() {
  //   _mark.text = widget.note ?? '';

  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 237, 163, 163),
        title: Text('add'),
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Form(
              key: _form,
              child: TextFormField(
                controller: _mark,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    // mark = value;
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_form.currentState!.validate()) {
                  isertingdata(_mark.text);
                }

                setState(() {});
              },
              child: Text('ADD'),
            )
          ],
        ),
      ),
    );
  }
}
