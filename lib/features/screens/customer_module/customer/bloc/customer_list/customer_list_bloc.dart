import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/customer_module/customer/bloc/customer_list/customer_list_event.dart';
import 'package:bloc_login/features/screens/customer_module/customer/bloc/customer_list/customer_list_state.dart';
import 'package:bloc_login/features/screens/customer_module/customer/model/customer_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class CustomerListBloc extends Bloc<CustomerListEvents, CustomerListStates> {
  int pageNumber = 1;

  CustomerListBloc() : super(InitialCustomerListState()) {
    on<FetchCustomerListEvent>((event, emit) async {
      if (state is InitialCustomerListState) {
        emit(LoadingCustomerListState());
        try {
          CustomerList model = await _fetchCustomerList(pageNumber: pageNumber.toString());
          if (model.status == 200) {
            emit(LoadedCustomerListState(model: model));
          } else {
            emit(FailureCustomerListState(error: model.message));
          }
        } on HttpException catch (e) {
          emit(ServerErrorCustomerListState(error: e.message));
        } catch (e) {
          emit(FailureCustomerListState(error: e.toString()));
        }
      } else if (state is LoadedCustomerListState) {
        final currentState = state as LoadedCustomerListState;
        if (currentState.model.hasNextPage) {
          pageNumber++;
          try {
            CustomerList model = await _fetchCustomerList(pageNumber: pageNumber.toString());
            if (model.status == 200) {
              final updatedModel = CustomerList(
                status: model.status,
                data: currentState.model.data + model.data,
                totalPages: model.totalPages,
                totalCount: model.totalCount,
                pageNumber: model.pageNumber,
                hasNextPage: model.hasNextPage,
                hasPreviousPage: model.hasPreviousPage,
                message: model.message,
              );
              emit(LoadedCustomerListState(model: updatedModel));
            } else {
              emit(FailureCustomerListState(error: model.message));
            }
          } on HttpException catch (e) {
            emit(ServerErrorCustomerListState(error: e.message));
          } catch (e) {
            emit(FailureCustomerListState(error: e.toString()));
          }
        }
      }
    });
  }

  Future<CustomerList> _fetchCustomerList({
    required String pageNumber,
  }) async {
    final data = {
      'db_connection': 'erp_tata_steel_demo',
      'page_number': pageNumber,
      'page_size': '10',
      'user_id': '1',
      'status': '2',
    };
    final Uri url = Uri.parse("https://shiserp.com/demo/api/customerList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return CustomerList.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
