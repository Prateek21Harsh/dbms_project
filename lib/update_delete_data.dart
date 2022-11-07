import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class UpdateDeleteData extends StatefulWidget {
  final String id;
  final String orgName;
  final String orgMobile;

  const UpdateDeleteData({Key? key, required this.id, required this.orgName, required this.orgMobile}) : super(key: key);

  @override
  _UpdateDeleteDataState createState() => _UpdateDeleteDataState();
}

class _UpdateDeleteDataState extends State<UpdateDeleteData> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void dispose(){
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> updateData() async{
    var dio = Dio();
    var formData = FormData.fromMap({
      'id' : widget.id,
      'name' : nameController.text,
      'mobile' : mobileController.text,
    });
    await dio.post('http://10.6.2.183/myWork/editdata.php',data: formData);
  }

  Future<void> deleteData() async{
    var dio = Dio();
    var formData = FormData.fromMap({
      'id' : widget.id,
    });
    await dio.post('http://10.6.2.183/myWork/deletedata.php',data: formData);
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.orgName;
    mobileController.text = widget.orgMobile;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(widget.id, style: TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 5),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Name",
                labelText: "Enter Name",
              ),
            ),
            SizedBox(height: 5),
            TextField(
              controller: mobileController,
              decoration: InputDecoration(
                hintText: "Enter Mobile",
                labelText: "Enter Mobile",
              ),
            ),
            SizedBox(height: 5),
            MaterialButton(
              child: Text("Update Data"),
              color: Colors.blue,
              onPressed: (){
                setState(() {
                  updateData();
                });
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 5),
            MaterialButton(
              child: Text("Delete Data"),
              color: Colors.blue,
              onPressed: (){
                setState(() {
                  deleteData();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
