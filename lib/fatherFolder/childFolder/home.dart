import 'package:flutter/material.dart';
import 'package:molahadati/fatherFolder/childFolder/edit.dart';
import 'package:molahadati/fatherFolder/childFolder/sql.dart';
import 'package:molahadati/fatherFolder/childFolder/add.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({
    super.key,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<Map<String, dynamic>> NOOT = [];
  Sqldb ob = Sqldb();
  bool loading = false;

  Future<List<Map<String, dynamic>>> GETDATA() async {
    List<Map<String, dynamic>> response = await ob.read('note');
    NOOT.addAll(response);
    setState(() {});
    return response;
  }

  // Future upd() async {
  //   int respons = await ob.update3(NOOT);
  //   GETDATA();
  //   return respons;
  // }

  // Future<Map> iserting(String n) async {
  //   Map<String, dynamic> alldata = {'notes': n};
  //   int reponse = await ob.Insert('note', alldata);
  //   GETDATA();
  //   print(reponse);
  //   return alldata;
  // }

  Future<void> deliting() async {}

  @override
  void initState() {
    // TODO: implement initState
    GETDATA();

    loading = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => adding(),
              ),
              (Route) => false);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('MY NOTES...'),
      ),
      body: Center(
        child: loading == false
            ? CircularProgressIndicator()
            : Container(
                padding: EdgeInsets.all(15.0),
                child: ListView.builder(
                  itemCount: NOOT.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text('${NOOT[index]['notes']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                                color: Color.fromARGB(255, 27, 85, 178),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => editing(
                                            note: NOOT[index]['notes'],
                                            id: NOOT[index]['id']),
                                      ),
                                      (Route) => false);
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                color: Color.fromARGB(255, 238, 72, 72),
                                onPressed: () async {
                                  int respons = await ob.deletdata(
                                      'DELETE FROM note WHERE id = ${NOOT[index]['id']}');
                                  print(respons);
                                  if (respons > 0) {
                                    NOOT.removeWhere(
                                        (e) => e['id'] == NOOT[index]['id']);
                                    setState(() {});
                                  }
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                        // title: Text(GETDATA().toString()),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
