class FarmModel {
  final int? id;
  final String name;

  final String animal;
  final int count;
  final int age;
  final double weight;
  final String goal;

  final DateTime createdAt;

  FarmModel({
    this.id,
    required this.name,
    required this.animal,
    required this.count,
    required this.age,
    required this.weight,
    required this.goal,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "animal": animal,
      "count": count,
      "age": age,
      "weight": weight,
      "goal": goal,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory FarmModel.fromMap(Map<String, dynamic> map) {
    return FarmModel(
      id: map["id"],
      name: map["name"],
      animal: map["animal"],
      count: map["count"],
      age: map["age"],
      weight: map["weight"],
      goal: map["goal"],
      createdAt: DateTime.parse(map["createdAt"]),
    );
  }
}
