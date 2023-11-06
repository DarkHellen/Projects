import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<StudentList> {
  List<Student> courses = [];

  @override
  void initState() {
    super.initState();

    // Fetch courses from Firestore
    fetchCoursesFromFirestore();
  }

  void fetchCoursesFromFirestore() {
    FirebaseFirestore.instance
        .collection('Admin')
        .doc("UserList")
        .collection("Users")
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Student> fetchedCourses = [];

        for (QueryDocumentSnapshot doc in snapshot.docs) {
          String name = doc['Emial'];

          Student student = Student(name);
          fetchedCourses.add(student);
        }

        setState(() {
          courses = fetchedCourses;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            Student course = courses[index];

            return Dismissible(
              key: Key(course.name),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  courses.removeAt(index);
                });
              },
              direction: DismissDirection.endToStart,
              child: Card(
                elevation: 5,
                child: Container(
                  height: 40.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                course.name,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Student {
  final String name;

  Student(this.name);
}
