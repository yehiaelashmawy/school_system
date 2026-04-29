import 'package:dartz/dartz.dart';
import 'package:school_system/core/api/api_errors.dart';
import 'package:school_system/core/api/api_service.dart';
import 'package:school_system/features/parent/data/models/parent_dashboard_model.dart';

class ParentDashboardRepo {
  final ApiService apiService;

  ParentDashboardRepo(this.apiService);

  Future<Either<ApiErrors, ParentDashboardModel>> getDashboard() async {
    try {
      final response = await apiService.get('/api/Parents/dashboard');
      final data = ParentDashboardModel.fromJson(response['data']);
      return Right(data);
    } catch (e) {
      if (e is ApiErrors) return Left(e);
      return Left(ApiErrors(errorMessage: e.toString()));
    }
  }
}