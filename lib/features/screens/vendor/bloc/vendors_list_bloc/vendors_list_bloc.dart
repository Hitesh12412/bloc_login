import 'dart:convert';
import 'dart:io';
import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_event.dart';
import 'package:bloc_login/features/screens/vendor/bloc/vendors_list_bloc/vendors_list_state.dart';
import 'package:bloc_login/features/screens/vendor/model/vendors_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class VendorsListBloc extends Bloc<VendorsListEvents, VendorsListStates> {
  VendorsListBloc() : super(InitialVendorsListState()) {
    on<FetchVendorsListEvent>((event, emit) async {
      emit(LoadingVendorsListState());

      try {
        VendorsList model = await fetchVendorsList(
          dbConnection: 'erp_tata_steel_demo',
          pageNumber: event.pageNumber ?? '1',
          pageSize: '30',
          vendorLevelId: '0',
          searchText: '',
          productId: '',
        );
        if (model.status == 200) {
          emit(LoadedVendorsListState(model: model));
        } else {
          emit(FailureVendorsListState(error: model.message));
        }
      } on HttpException catch (e) {
        if (e.message.contains('500')) {
          emit(InternalServerErrorVendorsListState(error: "Internal server error: 500"));
        } else {
          emit(ServerErrorVendorsListState(error: "HTTP error occurred: ${e.message}"));
        }
        throw Exception(e);
      } catch (error) {
        emit(FailureVendorsListState(error: "An error occurred"));
        throw Exception(error);
      }
    });
  }

  Future<VendorsList> fetchVendorsList({
    required String dbConnection,
    required String pageNumber,
    required String pageSize,
    required String vendorLevelId,
    required String searchText,
    required String productId,
  }) async {
    final data = {
      'db_connection': dbConnection,
      'page_number': pageNumber,
      'page_size': pageSize,
      'vendor_level_id': vendorLevelId,
      'search_text': searchText,
      'product_id': productId,
    };
    final Uri url = Uri.parse("https://shiserp.com/demo/api/vendorList");
    final response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      return VendorsList.fromJson(json.decode(response.body));
    } else {
      throw HttpException('Error: ${response.statusCode}');
    }
  }
}
