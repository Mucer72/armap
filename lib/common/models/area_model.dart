class AreaModel {
  final int id;
  final String name;
  final List<dynamic> poliline;

  AreaModel({required this.id, required this.name, required this.poliline});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
      id: json['id'],
      name: json['name'],
      poliline: json['poliline'] ?? [],
    );
  }
}
