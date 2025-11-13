class AgreementListModel {
  final int status;
  final List<AgreementData> data;
  final String message;

  AgreementListModel.fromJsonMap(Map<String, dynamic> json)
      : status = json['status'],
        data = List.from(json['data']).map((e) => AgreementData.fromJsonMap(e)).toList(),
        message = json['message'];
}

class AgreementData {
  final int id;
  final int employeeId;
  final String associationType;
  final String agreementStartDate;
  final String agreementEndDate;
  final String documentUpload;
  final String? appraisalDueOn;

  AgreementData.fromJsonMap(Map<String, dynamic> json)
      : id = json['id'],
        employeeId = json['employee_id'],
        associationType = json['association_type'],
        agreementStartDate = json['agreement_start_date'],
        agreementEndDate = json['agreement_end_date'],
        documentUpload = json['document_upload'],
        appraisalDueOn = json['appraisal_due_on'];
}
