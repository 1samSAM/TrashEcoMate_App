class RobotModel {
  final String id;
  final String status;
  final String currentLocation;

  RobotModel({
    required this.id,
    required this.status,
    required this.currentLocation,
  });

  factory RobotModel.fromJson(Map<String, dynamic> json) {
    return RobotModel(
      id: json['id'],
      status: json['status'],
      currentLocation: json['current_location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'current_location': currentLocation,
    };
  }
}