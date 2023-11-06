import 'package:flutter/material.dart';

import 'package:stabit_boss/dashboard.dart';
import 'package:stabit_boss/pages/Student.dart';

import '../model/menu_modal.dart';
import '../pages/Feedback.dart';
import '../pages/Messeges.dart';

import '../pages/home/Cources.dart';
import '../responsive.dart';

class Menu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const Menu({super.key, required this.scaffoldKey});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<MenuModel> menu = [
    MenuModel(icon: Icons.home_filled, title: "Dashboard"),
    MenuModel(icon: Icons.person_3, title: "Students"),
    MenuModel(icon: Icons.book_online_outlined, title: "Cources"),
    MenuModel(icon: Icons.star_border_purple500_rounded, title: "Feedbacks"),
    MenuModel(icon: Icons.message_sharp, title: "Messages"),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey[800]!,
              width: 1,
            ),
          ),
          color: const Color(0xFF171821)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: Responsive.isMobile(context) ? 40 : 80,
            ),
            for (var i = 0; i < menu.length; i++)
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                  color: selected == i
                      ? Theme.of(context).primaryColor
                      : Colors.transparent,
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      selected = i;
                    });
                    switch (selected) {
                      case 0:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => DashBoard())));

                        break;

                      case 1:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => StudentList())));

                        break;
                      case 2:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CoursesList())));

                        break;
                      case 3:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => FeedbackList())));

                        break;
                      case 4:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MessagesList())));

                        break;
                    }
                    widget.scaffoldKey.currentState!.closeDrawer();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 7),
                        child: Icon(
                          menu[i].icon, // Use the Icon widget here
                          size: 24,
                          color: selected == i ? Colors.black : Colors.grey,
                        ),
                      ),
                      Text(
                        menu[i].title,
                        style: TextStyle(
                            fontSize: 16,
                            color: selected == i ? Colors.black : Colors.grey,
                            fontWeight: selected == i
                                ? FontWeight.w600
                                : FontWeight.normal),
                      )
                    ],
                  ),
                ),
              ),
          ],
        )),
      ),
    );
  }
}
