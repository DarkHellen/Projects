class Model {
  String? id;
  String? text;
  bool? isComplete;
  Model({required this.id, required this.text, this.isComplete = false});

  static List<Model> TodoList() {
    return [
      Model(id: '01', text: 'Morning Excercise', isComplete: true),
      Model(id: '02', text: 'Morning Excercise')
    ];
  }
}
