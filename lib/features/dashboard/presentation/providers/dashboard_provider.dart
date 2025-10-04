import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/api_service.dart';
import '../../data/datasources/dashboard_remote_data_source.dart';
import '../../data/models/call_contact_model.dart';
import '../../data/models/call_status_model.dart';

/// ---------------------------
/// Data source provider
/// ---------------------------
final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  final apiService = ApiService();
  return DashboardRemoteDataSource(apiService: apiService);
});

/// ---------------------------
/// Dashboard Notifier
/// ---------------------------
/// We make DashboardNotifier manage AsyncValue so `.when()` works in the UI
class DashboardNotifier extends StateNotifier<AsyncValue<(CallStatsModel, List<CallContactModel>)>> {
  final DashboardRemoteDataSource _dataSource;

  DashboardNotifier(this._dataSource) : super(const AsyncValue.loading()) {
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    state = const AsyncValue.loading();
    try {
      final stats = await _dataSource.getCallStats();
      final contacts = await _dataSource.getCallContacts();
      state = AsyncValue.data((stats, contacts));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refreshData() async {
    try {
      final stats = await _dataSource.getCallStats();
      final contacts = await _dataSource.getCallContacts();
      state = AsyncValue.data((stats, contacts));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<CallContactModel?> startCalling() async {
    try {
      final contact = await _dataSource.startCalling();
      await loadDashboardData();
      return contact;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> updateCallStatus({
    required String contactId,
    required String status,
    String? notes,
  }) async {
    try {
      await _dataSource.updateCallStatus(
        contactId: contactId,
        status: status,
        notes: notes,
      );
      await refreshData();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> syncData() async {
    try {
      await _dataSource.syncData();
      await loadDashboardData();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendLogs() async {
    try {
      await _dataSource.sendLogs();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// ---------------------------
/// Providers
/// ---------------------------
final dashboardProvider = StateNotifierProvider<
    DashboardNotifier, AsyncValue<(CallStatsModel, List<CallContactModel>)>>((ref) {
  final dataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardNotifier(dataSource);
});

final callStatsProvider = Provider<CallStatsModel?>((ref) {
  final state = ref.watch(dashboardProvider);
  return state.when(
    data: (data) => data.$1,
    loading: () => null,
    error: (_, __) => null,
  );
});

final callContactsProvider = Provider<List<CallContactModel>?>((ref) {
  final state = ref.watch(dashboardProvider);
  return state.when(
    data: (data) => data.$2,
    loading: () => null,
    error: (_, __) => null,
  );
});
