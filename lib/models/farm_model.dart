class FarmModel {
  final String animal;
  final int count;
  final int age;
  final double weight;
  final String goal;

  FarmModel({
    required this.animal,
    required this.count,
    required this.age,
    required this.weight,
    required this.goal,
  });

  Map<String, dynamic> toJson() {
    return {
      "animal": animal,
      "count": count,
      "age": age,
      "weight": weight,
      "goal": goal,
    };
  }
}
