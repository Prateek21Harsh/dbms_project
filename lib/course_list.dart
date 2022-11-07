import 'dart:convert';
import 'package:dbms1/add_data.dart';
import 'package:dbms1/update_delete_data.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CourseList extends StatefulWidget {
  const CourseList({Key? key}) : super(key: key);

  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  List<DataModal> dataList = [];
  bool isLoading = true;

  Future<void> getAllCourses() async{
    Response response;
    var dio = Dio();
    response = await dio.get('http://10.6.2.183/myWork/getdata.php');
    final list = json.decode(response.data) as List<dynamic>;

    dataList = list.map((e) => DataModal.fromJson(e)).toList();

    setState(() {
      if(dataList.isNotEmpty) {
        isLoading = false;
      }
    });
  }

  @override
  void initState() {
    getAllCourses();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      getAllCourses();
    });
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return AddData();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          child: isLoading ? Center(child: Text('Data not found'),) :
          ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (context, index){
                return ListTile(
                  leading: Text(dataList[index].id),
                  title: Text(dataList[index].name),
                  subtitle: Text(dataList[index].mobile),
                  onTap: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) =>
                        UpdateDeleteData(
                            id: dataList[index].id,
                            orgName: dataList[index].name,
                            orgMobile: dataList[index].mobile,
                        )
                    ));
                  },
                );
              }
          )
        ),
      ),
    );
  }
}

class DataModal{
  String id;
  String name;
  String mobile;

  DataModal({required this.id, required this.name, required this.mobile});

  factory DataModal.fromJson(Map<String, dynamic> json) => DataModal(
      id: json['id'] as String,
      name: json["name"] as String,
      mobile: json["mobile"] as String
  );
}