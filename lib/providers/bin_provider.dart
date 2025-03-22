import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/bin_model.dart';
import '../services/bin_service.dart';

class BinProvider with ChangeNotifier {
  final BinService binService;
  final Logger _logger = Logger(); // Logger instance
  final List<BinModel> _bins = []; // List to hold bin models
  bool _isLoading = false; // Loading state
  Stream<BinModel>? _binStream;
  double _wasteLevel = 0; // Waste level for a single bin

  BinProvider(this.binService);

  List<BinModel> get bins => _bins;
  bool get isLoading => _isLoading;
  Stream<BinModel>? get binStream => _binStream;
  double get wasteLevel => _wasteLevel;

  // Fetch real-time updates for a specific bin
  void startListeningToBinChanges(String id) {
    _logger.d("Starting to listen to bin changes for ID: $id"); // Log the action
    _binStream = binService.listenToBinChanges(id);
    binService.getBinLevel(id).listen((level) {
      _logger.i("Real-time Bin Level for ID $id: $level");
      _wasteLevel = level;
      notifyListeners();
    });
    notifyListeners();
  }

  // Stop listening to real-time updates
  void stopListeningToBinChanges() {
    _logger.d("Stopped listening to bin changes"); // Log the action
    _binStream = null;
    notifyListeners();
  }

  // Fetch bins from the service
  Future<void> fetchBins() async {
    _isLoading = true; // Set loading state to true
    notifyListeners(); // Notify listeners about loading state change

    try {
      // Fetch bins from the service
      final fetchedBins = await binService.fetchBins();
      _bins.clear(); // Clear existing bins
      _bins.addAll(fetchedBins); // Add fetched bins to the list
    } catch (e) {
      _logger.e("Error fetching bins: $e"); // Log any errors
    } finally {
      _isLoading = false; // Set loading state to false
      notifyListeners(); // Notify listeners about loading state change
    }
  }
}