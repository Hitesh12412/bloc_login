import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  /// Add a task to the Operations category
  Future addOperationsTask(Map<String, dynamic> operationsTask, String id) async {
    return await FirebaseFirestore.instance
        .collection("Operations")
        .doc(id)
        .set(operationsTask);
  }

  /// Add a task to the HR category
  Future addHRTask(Map<String, dynamic> hrTask, String id) async {
    return await FirebaseFirestore.instance
        .collection("HR")
        .doc(id)
        .set(hrTask);
  }

  /// Add a task to the Office category
  Future addOfficeTask(Map<String, dynamic> officeTask, String id) async {
    return await FirebaseFirestore.instance
        .collection("Office")
        .doc(id)
        .set(officeTask);
  }

  /// Get task stream based on category
  Future<Stream<QuerySnapshot>> getTask(String taskCategory) async {
    return FirebaseFirestore.instance.collection(taskCategory).snapshots();
  }

  /// Mark task as completed (Yes = true)
  Future tickMethod(String id, String taskCategory) async {
    return FirebaseFirestore.instance
        .collection(taskCategory)
        .doc(id)
        .update({"Yes": true});
  }

  /// Remove a completed task
  Future removeMethod(String id, String taskCategory) async {
    return FirebaseFirestore.instance
        .collection(taskCategory)
        .doc(id)
        .delete();
  }
}
