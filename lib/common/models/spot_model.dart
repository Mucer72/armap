class SpotModel {
  final int id;
  final int destinationId;
  final String name;
  final List<dynamic> tags;

  SpotModel({required this.id, required this.destinationId, required this.name, required this.tags});

  factory SpotModel.fromJson(Map<String, dynamic> json) {
    return SpotModel(
      id: json['id'],
      destinationId: json['destination_id'],
      name: json['name'],
      tags: json['tags'] ?? [],
    );
  }
}
