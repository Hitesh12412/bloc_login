import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'create_agreement_event.dart';
import 'create_agreement_state.dart';

class CreateAgreementBloc extends Bloc<CreateAgreementEvent, CreateAgreementState> {
  CreateAgreementBloc() : super(CreateAgreementInitial()) {
    on<SubmitAgreementEvent>(_onSubmitAgreementEvent);
  }

  Future<void> _onSubmitAgreementEvent(SubmitAgreementEvent event, Emitter<CreateAgreementState> emit) async {
    emit(CreateAgreementLoading());
    try {

      final formData = http.MultipartRequest('POST', Uri.parse('https://shiserp.com/demo/api/agreementCreate'));
      formData.fields.addAll({
        'db_connection': "erp_tata_steel_demo",
        'user_id': "1",
        'employee_id': event.employeeId,
        'association_type': event.associationType,
        'agreement_start_date': event.startDate,
        'agreement_end_date': event.endDate,
        'appraisal_due_on': event.dueDate,
      });

      if (event.document != null && event.document!.path.isNotEmpty ) {
        formData.files.add(await http.MultipartFile.fromPath(
          'document_upload',
          event.document!.path,
        ));
      }

      final response = await formData.send();
      final responseJson = await http.Response.fromStream(response);
      if(response.statusCode == 200){
        var decode = json.decode(responseJson.body);
        if(decode['status'] == 200){
          // toastInfo(msg: decode['message']);
          emit(CreateAgreementSuccess());
        }
        else {
          emit(CreateAgreementFailure(error: decode['message']));
        }
      }
    } catch (e) {
      emit(CreateAgreementFailure(error: e.toString()));
    }
  }
}
