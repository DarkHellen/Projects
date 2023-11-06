import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stabit_boss/pages/Exams.dart';
import 'package:stabit_boss/pages/Quiz.dart';
import 'package:stabit_boss/pages/home/AddCourse.dart';

class CoursesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListItemWidget();
  }
}

class ListItemWidget extends State<CoursesList> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();

    // Fetch courses from Firestore
    fetchCoursesFromFirestore();
  }

  void fetchCoursesFromFirestore() {
    FirebaseFirestore.instance
        .collection('Stabit')
        .doc("Cources")
        .collection("AllCources")
        .get()
        .then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Course> fetchedCourses = [];

        for (QueryDocumentSnapshot doc in snapshot.docs) {
          String name = doc['Cource'];
          String imageURL = doc['PhototUrl'];
          String price = doc['Price'];
          String teacher = doc['Teacher Name'];

          Course course = Course(name, imageURL, price, teacher);
          fetchedCourses.add(course);
        }

        setState(() {
          courses = fetchedCourses;
        });
      }
    });
  }

  void addCourse() {
    Navigator.push(
        context, MaterialPageRoute(builder: ((context) => AddCourseWidget())));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Courses List'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              Course course = courses[index];

              return GestureDetector(
                onTap: () {
                  showOptionsPopupMenu(context, course);
                },
                child: Dismissible(
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
                      height: 100.0,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5),
                                  topLeft: Radius.circular(5)),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(course.imageURL)),
                            ),
                          ),
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child: Text(
                                      'Price: ${course.price}',
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                    child: Text(
                                      'Teacher: ${course.teacher}',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addCourse,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void showOptionsPopupMenu(BuildContext context, Course course) {
    // Show a pop-up menu with options when the item is tapped.
    showMenu(
      context: context,
      position: RelativeRect.fill,
      items: <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Quiz'),
            onTap: () {
              // Handle the "Add Quiz" action here.
              addQuiz(course);
              //Navigator.of(context).pop();
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Add Exam'),
            onTap: () {
              // Handle the "Add Exam" action here.
              addExam(course);
              //Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  void addQuiz(Course course) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => QuizForm(
                  name: course.name,
                ))));
  }

  void addExam(Course course) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => ExamForm(
                  name: course.name,
                ))));
  }
}

class Course {
  final String name;
  final String imageURL;
  final String price;
  final String teacher;

  Course(this.name, this.imageURL, this.price, this.teacher);
}
