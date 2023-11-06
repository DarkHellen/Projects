import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExamQuestion {
  String question;
  List<String> options;
  int correctAnswerIndex;

  ExamQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class ExamForm extends StatefulWidget {
  final name;

  const ExamForm({Key? key, required this.name}) : super(key: key);

  @override
  _QuizFormState createState() => _QuizFormState();
}

class _QuizFormState extends State<ExamForm> {
  List<ExamQuestion> questions = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Fetch and populate quiz questions when the widget is created
    fetchExamQuestions();
  }

  Future<void> fetchExamQuestions() async {
    try {
      QuerySnapshot querySnapshot = await getExamQuestions(widget.name);
      questions = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return ExamQuestion(
          question: data['question'],
          options: List<String>.from(data['options']),
          correctAnswerIndex: data['correctAnswerIndex'],
        );
      }).toList();
      setState(() {
        // Trigger a rebuild with the fetched data
      });
    } catch (e) {
      print("Error fetching quiz questions: $e");
    }
  }

  Future<QuerySnapshot> getExamQuestions(String courseName) async {
    // Create a reference to the "Quiz" collection for the specific course
    CollectionReference ExamCollection = _firestore
        .collection('Stabit')
        .doc('Cources')
        .collection("PaidCources")
        .doc(courseName)
        .collection("Exam");

    // Get all quiz questions for the course
    return await ExamCollection.get();
  }

  void showAddQuestionSheet(BuildContext context, String name) {
    TextEditingController questionController = TextEditingController();
    TextEditingController optionsController = TextEditingController();
    int correctAnswerIndex = 0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Wrap the content in SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: questionController,
                  decoration: const InputDecoration(labelText: 'Question'),
                ),
                TextFormField(
                  controller: optionsController,
                  decoration: const InputDecoration(
                      labelText: 'Options (comma-separated)'),
                ),
                DropdownButton<int>(
                  value: correctAnswerIndex,
                  onChanged: (int? newValue) {
                    setState(() {
                      correctAnswerIndex = newValue!;
                    });
                  },
                  items: List.generate(optionsController.text.split(',').length,
                      (index) {
                    return DropdownMenuItem<int>(
                      value: index,
                      child: Text('Option ${index + 1}'),
                    );
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (questionController.text.isNotEmpty &&
                        optionsController.text.isNotEmpty) {
                      List<String> options = optionsController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList();
                      ExamQuestion newQuestion = ExamQuestion(
                        question: questionController.text,
                        options: options,
                        correctAnswerIndex: correctAnswerIndex,
                      );
                      addQuestion(
                          newQuestion, name); // Add the question to Firestore
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add Question'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void addQuestion(ExamQuestion question, String name) {
    // Create a reference to the "quiz_questions" collection in Firestore
    CollectionReference quizQuestionsCollection = _firestore
        .collection('Stabit')
        .doc('Cources')
        .collection("PaidCources");

    // Add the question to Firestore
    quizQuestionsCollection.doc(name).collection("Exam").add({
      'question': question.question,
      'options': question.options,
      'correctAnswerIndex': question.correctAnswerIndex,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Questions for ${widget.name}'),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('Question ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Question: ${questions[index].question}'),
                        Text('Options: ${questions[index].options}'),
                        Text(
                            'Correct Answer: ${questions[index].options[questions[index].correctAnswerIndex]}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddQuestionSheet(context, widget.name);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
