import 'api_service.dart';

class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<dynamic> login(String email, String password) async {
    final response = await apiService.post('/login', {
      'email': email,
      'password': password,
    });
    return response; // Handle response as needed
  }

  Future<dynamic> signup(String name, String email, String password) async {
    final response = await apiService.post('/signup', {
      'name': name,
      'email': email,
      'password': password,
    });
    return response; // Handle response as needed
  }
}