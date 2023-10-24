import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bookpal/core/resources/data_state.dart';
import 'package:bookpal/core/util/utilities.dart';
import 'package:bookpal/data/models/physical_book_model.dart';
import 'package:bookpal/domain/usecases/physical_book/get_all_physical_books_usecase.dart';
import 'package:bookpal/domain/usecases/physical_book/get_physical_book_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part 'remote_physical_book_event.dart';
part 'remote_physical_book_state.dart';

class RemotePhysicalBookBloc
    extends Bloc<RemotePhysicalBookEvent, RemotePhysicalBookState> {
  final GetPhysicalBookUsecase _getPhysicalBook;
  final GetAllPhysicalBooksUsecase _getPhysicalBooks;

  RemotePhysicalBookBloc(this._getPhysicalBook, this._getPhysicalBooks)
      : super(RemotePhysicalBookInitial()) {
    on<GetPhysicalBook>(onGetPhysicalBook);
    on<GetAllPhysicalBooks>(onGetAllPhysicalBooks);
  }

  FutureOr<void> onGetPhysicalBook(GetPhysicalBook event, Emitter<RemotePhysicalBookState> emit) async {
    emit(RemotePhysicalBookLoading());
    try {
      final dataState = await _getPhysicalBook(params: {Utilities.getBookIdentifierName(event.identifier): event.identifier});
      if (dataState is DataSuccess && dataState.data != null) {
        emit(RemotePhysicalBookLoaded(
            dataState.statusCode, dataState.data! as PhysicalBookModel));
      } else if (dataState is DataFailed) {
        emit(RemotePhysicalBookError(dataState.error!, dataState.statusCode));
      }
    } on DioException catch (e) {
      emit(RemotePhysicalBookError(e, e.response?.statusCode));
    } catch (e) {
      emit(RemotePhysicalBookError.genericError(e));
    }
  }

  FutureOr<void> onGetAllPhysicalBooks(GetAllPhysicalBooks event, Emitter<RemotePhysicalBookState> emit) async {
    emit(RemotePhysicalBookLoading());
    try {
      final dataState = await _getPhysicalBooks();
      if (dataState is DataSuccess && dataState.data != null) {
        emit(RemotePhysicalBooksLoaded(
            dataState.statusCode, dataState.data! as List<PhysicalBookModel>));
      } else if (dataState is DataFailed) {
        emit(RemotePhysicalBookError(dataState.error!, dataState.statusCode));
      }
    } on DioException catch (e) {
      emit(RemotePhysicalBookError(e, e.response?.statusCode));
    } catch (e) {
      emit(RemotePhysicalBookError.genericError(e));
    }
  }
}