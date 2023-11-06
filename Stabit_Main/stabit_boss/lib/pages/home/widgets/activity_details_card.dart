import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/health_model.dart';
import '../../../responsive.dart';
import '../../../widgets/custom_card.dart';

class ActivityDetailsCard extends StatelessWidget {
  const ActivityDetailsCard({Key? key});

  Future<int> getSignedUpUserCount() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection("Admin")
          .doc("UserList")
          .collection("Users");
      QuerySnapshot querySnapshot = await collectionRef.get();
      int count = querySnapshot.docs.length;
      return count;
    } catch (e) {
      print("Error retrieving signed-up user count: $e");
      return 0; // Handle errors gracefully
    }
  }

  Future<int> getSignedUpTeacherCount() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection("Admin")
          .doc("Messages")
          .collection("Student Messages");
      QuerySnapshot querySnapshot = await collectionRef.get();
      int count = querySnapshot.docs.length;
      return count;
    } catch (e) {
      print("Error retrieving signed-up user count: $e");
      return 0; // Handle errors gracefully
    }
  }

  Future<int> getCourcesCount() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection("Stabit")
          .doc("Cources")
          .collection("AllCources");
      QuerySnapshot querySnapshot = await collectionRef.get();
      int count = querySnapshot.docs.length;
      return count;
    } catch (e) {
      print("Error retrieving signed-up user count: $e");
      return 0; // Handle errors gracefully
    }
  }

  Future<int> getCourcesBoughtCount() async {
    try {
      CollectionReference collectionRef = FirebaseFirestore.instance
          .collection("Admin")
          .doc("SelledCources")
          .collection("Cources");
      QuerySnapshot querySnapshot = await collectionRef.get();
      int count = querySnapshot.docs.length;
      return count;
    } catch (e) {
      print("Error retrieving signed-up user count: $e");
      return 0; // Handle errors gracefully
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: getSignedUpUserCount(),
      builder: (context, snapshot) {
        int studentsCount = snapshot.data ?? 0;

        return FutureBuilder<int>(
          future: getSignedUpTeacherCount(),
          builder: (context, snapshot) {
            int teachersCount = snapshot.data ?? 0;

            return FutureBuilder<int>(
              future: getCourcesCount(),
              builder: (context, snapshot) {
                int coursesCount = snapshot.data ?? 0;

                return FutureBuilder<int>(
                  future: getCourcesBoughtCount(),
                  builder: (context, snapshot) {
                    int coursesBoughtCount = snapshot.data ?? 0;

                    final List<HealthModel> healthDetails = [
                      HealthModel(
                        icon: 'assets/svg/op.svg',
                        value: studentsCount.toString(),
                        title: "Students",
                      ),
                      HealthModel(
                        icon: 'assets/svg/steps.svg',
                        value: teachersCount.toString(),
                        title: "Messages",
                      ),
                      HealthModel(
                        icon: 'assets/svg/distance.svg',
                        value: coursesCount.toString(),
                        title: "Courses",
                      ),
                      HealthModel(
                        icon: 'assets/svg/sleep.svg',
                        value: coursesBoughtCount.toString(),
                        title: "Courses Bought",
                      ),
                    ];

                    return GridView.builder(
                      itemCount: healthDetails.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
                        crossAxisSpacing:
                            !Responsive.isMobile(context) ? 15 : 12,
                        mainAxisSpacing: 12.0,
                      ),
                      itemBuilder: (context, i) {
                        return CustomCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // SvgPicture.asset(healthDetails[i].icon),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, bottom: 4),
                                child: Text(
                                  healthDetails[i].value,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                healthDetails[i].title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
