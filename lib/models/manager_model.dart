class Manager {
  String id;
  String name;

  Manager({
    required this.id,
    required this.name,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
