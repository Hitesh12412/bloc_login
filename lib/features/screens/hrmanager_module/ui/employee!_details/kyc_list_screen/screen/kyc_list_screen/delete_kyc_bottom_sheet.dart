import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/model/kyc_list_model.dart';
import 'package:flutter/material.dart';

class DeleteKycBottomSheet extends StatelessWidget {
  final KycData Kyc;
  final VoidCallback onDeleteConfirmed;

  const DeleteKycBottomSheet({
    super.key,
    required this.Kyc,
    required this.onDeleteConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomSheetHeight = screenHeight * 0.32;

    return SafeArea(
      child: Container(
        height: bottomSheetHeight,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  'Delete Kyc',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            const Row(
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 40,
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alert!',
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                    Text('This action cannot be undone'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade400)),
              child: const Text(
                'Are you sure you want to delete this Kyc ? All associated data will be permanently removed from the system.',
                style: TextStyle(color: Colors.black),
                overflow: TextOverflow.visible,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: const Center(
                      child:
                          Text('Cancel', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    onDeleteConfirmed();
                  },
                  child: Container(
                    width: (MediaQuery.of(context).size.width - 3 * 16) / 2,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child:
                          Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
