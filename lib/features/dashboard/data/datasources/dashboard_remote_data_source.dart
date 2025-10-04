
import '../../../../core/services/api_service.dart';
import '../models/call_contact_model.dart';
import '../models/call_status_model.dart';

class DashboardRemoteDataSource {
  final ApiService apiService;

  DashboardRemoteDataSource({required this.apiService});

  Future<CallStatsModel> getCallStats() async {
    try {
      final response = await apiService.get('/dashboard/stats');
      return CallStatsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CallContactModel>> getCallContacts({
    int page = 1,
    int limit = 20,
    String? search,
    String? status,
  }) async {
    try {
      final queryParams = {
        'page': page,
        'limit': limit,
        if (search != null) 'search': search,
        if (status != null) 'status': status,
      };

      final response = await apiService.get(
        '/dashboard/contacts',
        queryParameters: queryParams,
      );

      final List<dynamic> data = response.data;
      return data.map((json) => CallContactModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CallContactModel> startCalling() async {
    try {
      final response = await apiService.post('/dashboard/start-calling');
      return CallContactModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateCallStatus({
    required String contactId,
    required String status,
    String? notes,
  }) async {
    try {
      await apiService.put(
        '/dashboard/call-status/$contactId',
        data: {
          'status': status,
          if (notes != null) 'notes': notes,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> syncData() async {
    try {
      await apiService.post('/dashboard/sync');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendLogs() async {
    try {
      await apiService.post('/dashboard/send-logs');
    } catch (e) {
      rethrow;
    }
  }
}