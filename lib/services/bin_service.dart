import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';
import '../models/bin_model.dart';

class BinService {
  final DatabaseReference _realtimeDb = FirebaseDatabase.instance.ref();
  final Logger _logger = Logger(); // Logger instance

  // Fetch a single bin from Realtime Database
  Future<BinModel?> fetchBinFromRealtimeDatabase(String id) async {
    try {
      DataSnapshot snapshot = await _realtimeDb.child('bins/$id').get();
      if (snapshot.exists) {
        _logger.i('Fetched bin with ID $id from Realtime Database');
        return BinModel.fromJson(snapshot.value as Map<dynamic, dynamic>, id);
      } else {
        _logger.w('Bin with ID $id does not exist in Realtime Database');
      }
    } catch (e) {
      _logger.e('Error fetching bin from Realtime Database: $e');
    }
    return null;
  }

  // Fetch all bins from Realtime Database
  Future<List<BinModel>> fetchBins() async {
    List<BinModel> bins = [];
    try {
      DataSnapshot snapshot = await _realtimeDb.child('bins').get();
      if (snapshot.exists) {
        _logger.i('Fetched bins from Realtime Database');
        final data = snapshot.value as Map<dynamic, dynamic>;
        data.forEach((key, value) {
          bins.add(BinModel.fromJson(value as Map<dynamic, dynamic>, key));
        });
      } else {
        _logger.w('No bins found in Realtime Database');
      }
    } catch (e) {
      _logger.e('Error fetching bins from Realtime Database: $e');
    }
    return bins;
  }

  // Listen for real-time updates for a single bin
  Stream<BinModel> listenToBinChanges(String id) {
    return _realtimeDb.child('bins/$id').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        return BinModel.fromJson(data, id);
      } else {
        throw Exception('No data available');
      }
    });
  }

  // 🔹 Real-time bin level listener (NEW FUNCTION)
  Stream<double> getBinLevel(String id) {
    return _realtimeDb.child("bins/$id/wasteLevel").onValue.map((event) {
      final value = event.snapshot.value;
      if (value != null) {
        _logger.i("Bin Level Updated: $value");
        return double.tryParse(value.toString()) ?? 0;
      } else {
        _logger.w("No level data found for bin ID: $id");
        return 0;
      }
    });
  }
}