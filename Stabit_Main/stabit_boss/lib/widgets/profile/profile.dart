import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../const.dart';
import '../../responsive.dart';
import 'widgets/scheduled.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  Future<List<String>> fetchAllCourses() async {
    try {
      final coursesCollection = await FirebaseFirestore.instance
          .collection("Stabit")
          .doc("Cources")
          .collection("AllCources")
          .get();

      final coursesData = coursesCollection.docs
          .map((doc) => doc.data()['Cource'] as String)
          .toList();

      return coursesData;
    } catch (e) {
      print("Error fetching all courses: $e");
      return []; // Handle errors gracefully
    }
  }

  Future<List<String>> fetchSoldCourses() async {
    try {
      final soldCoursesCollection = await FirebaseFirestore.instance
          .collection("Admin")
          .doc("SelledCources")
          .collection("Cources")
          .get();

      final soldCoursesData = soldCoursesCollection.docs
          .map((doc) => doc.data()['Cource Name'] as String)
          .toList();

      return soldCoursesData;
    } catch (e) {
      print("Error fetching sold courses: $e");
      return []; // Handle errors gracefully
    }
  }

  Future<List<String>> fetchStudentMessages() async {
    try {
      final messagesCollection = await FirebaseFirestore.instance
          .collection("Admin")
          .doc("Messages")
          .collection("Student Messages")
          .get();

      final messagesData = messagesCollection.docs
          .map((doc) => doc.data()['Message'] as String)
          .toList();

      return messagesData;
    } catch (e) {
      print("Error fetching student messages: $e");
      return []; // Handle errors gracefully
    }
  }

  Future<List<String>> fetchUsers() async {
    try {
      final usersCollection = await FirebaseFirestore.instance
          .collection("Admin")
          .doc("UserList")
          .collection("Users")
          .get();

      final usersData = usersCollection.docs
          .map((doc) => doc.data()['Email'] as String)
          .toList();

      return usersData;
    } catch (e) {
      print("Error fetching user data: $e");
      return []; // Handle errors gracefully
    }
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();

    // Fetch data from Firestore
    final List<String> users = await fetchUsers();
    final List<String> studentMessages = await fetchStudentMessages();
    final List<String> allCourses = await fetchAllCourses();
    final List<String> soldCourses = await fetchSoldCourses();

    // Create the PDF content
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Header(level: 0, text: 'User Data'),
          pw.ListView(
            children: users.map((user) => pw.Text(user)).toList(),
          ),
          pw.Header(level: 0, text: 'Student Messages'),
          pw.ListView(
            children:
                studentMessages.map((message) => pw.Text(message)).toList(),
          ),
          pw.Header(level: 0, text: 'All Courses'),
          pw.ListView(
            children: allCourses.map((course) => pw.Text(course)).toList(),
          ),
          pw.Header(level: 0, text: 'Sold Courses'),
          pw.ListView(
            children: soldCourses.map((course) => pw.Text(course)).toList(),
          ),
        ],
      ),
    );

    // Save the PDF to a file
    final file = File(
        '/storage/emulated/0/Download/Report.pdf'); // Android external storage

    await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
          topLeft: Radius.circular(Responsive.isMobile(context) ? 10 : 30.0),
        ),
        color: cardBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "assets/images/avatar.png",
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "srishti",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 2,
              ),
              SizedBox(
                height: Responsive.isMobile(context) ? 20 : 40,
              ),
              Scheduled(),
              ElevatedButton(
                onPressed: () {
                  generatePDF();
                },
                child: Text('Download Report'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
