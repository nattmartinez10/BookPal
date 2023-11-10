import 'package:bookpal/data/data_sources/remote/api_service.dart';
import 'package:bookpal/data/util/response_verifier.dart';
import 'package:bookpal/data/models/loan_model.dart';
import 'package:bookpal/domain/repositories/loan_repository.dart';
import 'package:bookpal/core/resources/data_state.dart';
import 'package:dio/dio.dart';

class LoanRepositoryImplementation implements LoanRepository {
  final ApiService _apiService;

  LoanRepositoryImplementation(this._apiService);

  @override
  Future<DataState<LoanModel>> getLoan(int id) async {
    try {
      final httpResponse = await _apiService.getLoan(
        id: id,
      );
      final ResponseVerifier<LoanModel> responseVerifier =
          ResponseVerifier<LoanModel>();
      return responseVerifier.validateResponse(httpResponse);
    } on DioException catch (e) {
      List<String>? messages = (e.response?.data['message'] is List)
          ? List<String>.from(
              e.response?.data['message'].map((m) => m.toString()))
          : [e.response?.data['message']];
      return DataFailed(e.response?.statusCode ?? 500, e, messages);
    }
  }

  @override
  Future<DataState<List<LoanModel>>> getLoansByUser(int userId) async {
    try {
      final httpResponse = await _apiService.getLoansByUser(
        userId: userId,
      );
      final ResponseVerifier<List<LoanModel>> responseVerifier =
          ResponseVerifier<List<LoanModel>>();
      return responseVerifier.validateResponse(httpResponse);
    } on DioException catch (e) {
      List<String>? messages = (e.response?.data['message'] is List)
          ? List<String>.from(
              e.response?.data['message'].map((m) => m.toString()))
          : [e.response?.data['message']];
      return DataFailed(e.response?.statusCode ?? 500, e, messages);
    }
  }

  @override
  Future<DataState<LoanModel>> postLoan(int userId, String bookBarcode) async {
    try {
      final httpResponse = await _apiService.postLoan(fields: {
        'userId': userId,
        'bookBarcode': bookBarcode,
      });
      final ResponseVerifier<LoanModel> responseVerifier =
          ResponseVerifier<LoanModel>();
      return responseVerifier.validateResponse(httpResponse);
    } on DioException catch (e) {
      List<String>? messages = (e.response?.data['message'] is List)
          ? List<String>.from(
              e.response?.data['message'].map((m) => m.toString()))
          : [e.response?.data['message']];
      return DataFailed(e.response?.statusCode ?? 500, e, messages);
    }
  }

  @override
  Future<DataState<LoanModel>> makeReturn(int id) async {
    try {
      final httpResponse = await _apiService.makeReturn(
        id: id,
      );
      final ResponseVerifier<LoanModel> responseVerifier =
          ResponseVerifier<LoanModel>();
      return responseVerifier.validateResponse(httpResponse);
    } on DioException catch (e) {
      List<String>? messages = (e.response?.data['message'] is List)
          ? List<String>.from(
              e.response?.data['message'].map((m) => m.toString()))
          : [e.response?.data['message']];
      return DataFailed(e.response?.statusCode ?? 500, e, messages);
    }
  }
}
