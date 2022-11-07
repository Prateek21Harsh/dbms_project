import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController cid = new TextEditingController();
  TextEditingController cname = new TextEditingController();
  TextEditingController cmobile = new TextEditingController();

  @override
  void dispose(){
    cid.dispose();
    cname.dispose();
    cmobile.dispose();
    super.dispose();
  }

  Future<void> addData() async{
    var dio = Dio();
    var formData = FormData.fromMap({
      'id' : cid.text,
      'name' : cname.text,
      'mobile' : cmobile.text,
    });
    await dio.post('http://10.6.2.183/myWork/adddata.php',data: formData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: cid,
              decoration: InputDecoration(
                hintText: "Enter Id",
                labelText: "Enter Id",
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: cname,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Enter Name",
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: cmobile,
              decoration: InputDecoration(
                hintText: "Enter Mobile",
                labelText: "Enter Mobile",
              ),
            ),
            SizedBox(height: 5),
            MaterialButton(
              child: Text("Add Data"),
              color: Colors.blue,
              onPressed: (){
                addData();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}