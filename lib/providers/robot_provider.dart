import 'package:flutter/material.dart';
import '../models/robot_model.dart';
import '../services/api_service.dart';

class RobotProvider with ChangeNotifier {
  final ApiService apiService;
  List<RobotModel> _robots = [];
  bool _isLoading = false;

  RobotProvider(this.apiService);

  List<RobotModel> get robots => _robots;
  bool get isLoading => _isLoading;

  Future<void> fetchRobots() async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await apiService.get('/robots');
      _robots = (response as List).map((robot) => RobotModel.fromJson(robot)).toList();
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}