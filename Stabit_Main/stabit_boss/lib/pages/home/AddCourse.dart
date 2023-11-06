import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCourseWidget extends StatefulWidget {
  @override
  _AddCourseWidgetState createState() => _AddCourseWidgetState();
}

class _AddCourseWidgetState extends State<AddCourseWidget> {
  final TextEditingController courseNameController = TextEditingController();
  final TextEditingController teacherNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  List<String> videoURLs = [];
  File? courseImage;

  void addCourseToFirestore() async {
    // First, upload video files to Firebase Storage
    List<String> uploadedVideoURLs = [];
    final FirebaseStorage storage = FirebaseStorage.instance;

    for (int i = 0; i < videoURLs.length; i++) {
      String videoPath = videoURLs[i];
      final Reference videoRef = storage.ref().child('videos/$i.mp4');
      final UploadTask uploadTask = videoRef.putFile(File(videoPath));
      await uploadTask.whenComplete(() async {
        final downloadURL = await videoRef.getDownloadURL();
        uploadedVideoURLs.add(downloadURL);
      });
    }

    // Upload the course image to Firebase Storage
    if (courseImage != null) {
      final Reference imageRef =
          storage.ref().child('course_images/${DateTime.now()}.jpg');
      final UploadTask imageUploadTask = imageRef.putFile(courseImage!);
      await imageUploadTask.whenComplete(() async {
        final imageDownloadURL = await imageRef.getDownloadURL();

        // Add course details to Firestore with the course image URL
        FirebaseFirestore.instance
            .collection('Stabit')
            .doc("Cources")
            .collection("AllCources")
            .doc(courseNameController.text)
            .set({
          'Cource': courseNameController.text,
          'Teacher Name': teacherNameController.text,
          'Price': priceController.text,
          'Description': descriptionController.text,
          'PhototUrl': imageDownloadURL,
        });

        FirebaseFirestore.instance
            .collection('Stabit')
            .doc("Cources")
            .collection("PaidCources")
            .doc(courseNameController.text)
            .set({
          'Cource': courseNameController.text,
          'Teacher Name': teacherNameController.text,
          'Price': priceController.text,
          'Description': descriptionController.text,
          'videos': uploadedVideoURLs,
          'PhototUrl': imageDownloadURL,
        });

        Navigator.pop(context); // Close the dialog after adding the course
      });
    }
  }

  // Function to pick an image file for the course image
  Future pickCourseImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        courseImage = File(pickedFile.path);
      });
    }
  }

  // Function to pick a video file
  Future pickVideo() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        videoURLs.add(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Course'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: courseNameController,
              decoration: const InputDecoration(labelText: 'Course Name'),
            ),
            TextField(
              controller: teacherNameController,
              decoration: const InputDecoration(labelText: 'Teacher Name'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            ElevatedButton(
              onPressed: pickCourseImage,
              child: const Text('Add Course Image'),
            ),
            Text(courseImage != null
                ? 'Course Image Selected'
                : 'No Course Image Selected'),
            ElevatedButton(
              onPressed: pickVideo,
              child: const Text('Add Video'),
            ),
            Text('Selected Videos: ${videoURLs.length}'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: addCourseToFirestore,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
