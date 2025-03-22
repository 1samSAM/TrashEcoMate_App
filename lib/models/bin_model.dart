class BinModel {
  final String id; // Unique identifier for the bin
  final String location; // Location of the bin
  final double distance; // Distance from the current location (in meters)
  final double wasteLevel; // Waste level percentage

  BinModel({
    required this.id,
    required this.location,
    required this.distance,
    required this.wasteLevel, // Updated to match Firebase
  });

  // Factory constructor for Firestore or Realtime Database JSON
  factory BinModel.fromJson(Map<dynamic, dynamic> json, String id) {
    return BinModel(
      id: id,
      location: json['location'] ?? 'Unknown Location',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      wasteLevel: (json['wasteLevel'] as num?)?.toDouble() ?? 0.0, // Updated field
    );
  }

  // Convert BinModel to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'distance': distance,
      'wasteLevel': wasteLevel, // Updated field
    };
  }
}