class FarmState {
  static String animal = "مرغ گوشتی";
  static int count = 0;
  static int age = 0;
  static double weight = 0;
  static String goal = "growth";

  static List<String> inventory = [];

  static Map<String, dynamic>? lastAIResult;

  static void updateFarm({
    required String newAnimal,
    required int newCount,
    required int newAge,
    required double newWeight,
    required String newGoal,
  }) {
    animal = newAnimal;
    count = newCount;
    age = newAge;
    weight = newWeight;
    goal = newGoal;
  }

  static void updateInventory(List<String> items) {
    inventory = items;
  }

  static void setAIResult(Map<String, dynamic> result) {
    lastAIResult = result;
  }
}
