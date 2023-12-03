class Measurement {
  final String id;
  final String measurementName;
  final String description;
  final String imageData;
  final String userId;
  final String createdAt;
  final String updatedAt;

  Measurement({
    required this.id,
    required this.measurementName,
    required this.description,
    required this.imageData,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      id: json['_id'] ?? "",
      measurementName: json['productName'] ?? "",
      description: json['description'] ?? "null",
      imageData: json['imagebase64'] ?? "null",
      userId: json['user_id'] ?? "",
      createdAt: json['createdAt'] ?? "",
      updatedAt: json['updatedAt'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productName': measurementName,
      'description': description,
      'user_id': userId,
      'imagebase64': imageData,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
