import 'package:bloc_login/features/screens/support/bloc/support_details_bloc/support_details_bloc.dart';
import 'package:bloc_login/features/screens/support/bloc/support_details_bloc/support_details_event.dart';
import 'package:bloc_login/features/screens/support/bloc/support_details_bloc/support_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportDetailBlocProvider extends StatelessWidget {
  final int supportId;

  const SupportDetailBlocProvider({super.key, required this.supportId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SupportDetailBloc>(
      create: (context) => SupportDetailBloc()
        ..add(
          FetchSupportDetailEvent(supportId: supportId),
        ),
      child: const SupportListDetails(),
    );
  }
}

class SupportListDetails extends StatefulWidget {
  const SupportListDetails({super.key});

  @override
  State<SupportListDetails> createState() => _SupportListDetailsState();
}

class _SupportListDetailsState extends State<SupportListDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 8),
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Support Details",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        titleSpacing: 0,
      ),
      body: BlocBuilder<SupportDetailBloc, SupportDetailStates>(
        builder: (context, state) {
          if (state is LoadingSupportDetailState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedSupportDetailState) {
            final userData = state.model.data.userData;
            final supportData = state.model.data.supportListData.isNotEmpty
                ? state.model.data.supportListData[0]
                : null;
            if (supportData == null) {
              return const Center(child: Text("No support data found"));
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: supportData.status == 1
                          ? Colors.orange.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: supportData.status == 1
                            ? Colors.orange.shade300
                            : Colors.green.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: supportData.status == 1
                              ? Colors.orange.shade600
                              : Colors.green.shade600,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          supportData.statusName,
                          style: TextStyle(
                            color: supportData.status == 1
                                ? Colors.orange.shade800
                                : Colors.green.shade800,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.blue.shade800,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Customer Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                icon: Icons.badge_outlined,
                                label: 'Name',
                                value: userData.userName,
                              ),
                              _buildDetailRow(
                                icon: Icons.phone_outlined,
                                label: 'Phone',
                                value: userData.mobileNo,
                                isClickable: true,
                                onTap: () => _launchPhone(userData.mobileNo),
                              ),
                              _buildDetailRow(
                                icon: Icons.email_outlined,
                                label: 'Email',
                                value: userData.email,
                                isClickable: true,
                                onTap: () => _launchEmail(userData.email),
                              ),
                              _buildDetailRow(
                                icon: Icons.business_outlined,
                                label: 'Company',
                                value: userData.companyName,
                              ),
                              _buildDetailRow(
                                icon: Icons.public_outlined,
                                label: 'Country',
                                value: userData.countryName,
                              ),
                              _buildDetailRow(
                                icon: Icons.location_on_outlined,
                                label: 'State',
                                value: userData.stateName,
                              ),
                              _buildDetailRow(
                                icon: Icons.location_city_outlined,
                                label: 'City',
                                value: userData.cityName,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.support_agent,
                                color: Colors.blue.shade800,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Issue Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              _buildDetailRow(
                                icon: Icons.apps_outlined,
                                label: 'Module',
                                value: supportData.moduleName,
                              ),
                              _buildDetailRow(
                                icon: Icons.description_outlined,
                                label: 'Description',
                                value: supportData.description,
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (supportData.media.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.attachment,
                                  color: Colors.blue.shade800,
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  supportData.media.length == 1
                                      ? 'Attachments (1)'
                                      : 'Attachments (${supportData.media.length})',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: supportData.media.map((mediaFile) {
                                return GestureDetector(
                                  onTap: () => _openFile(mediaFile),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: _getFileTypeColor(
                                                mediaFile.mediaType),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            _getFileTypeIcon(
                                                mediaFile.mediaType),
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${mediaFile.mediaType.toUpperCase()} File',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Text(
                                                mediaFile.media,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              Text(
                                                'Tap to open',
                                                style: TextStyle(
                                                  color: Colors.blue.shade600,
                                                  fontSize: 12,
                                                  decoration:
                                                      TextDecoration.underline,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey.shade400,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          } else if (state is FailureSupportDetailState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is InternalServerErrorSupportDetailState) {
            return Center(
              child: Text(state.error),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Future<void> _openFile(dynamic mediaFile) async {
    try {
      _showLoadingDialog();

      final fullUrl = 'https://shiserp.com/demo/${mediaFile.media}';
      print('Attempting to open URL: $fullUrl');

      final uri = Uri.parse(fullUrl);

      if (await canLaunchUrl(uri)) {
        bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );

        if (!launched) {
          launched = await launchUrl(
            uri,
            mode: LaunchMode.platformDefault,
          );
        }

        if (!launched) {
          throw 'Failed to launch URL in any mode';
        }

        print('Successfully opened file');
      } else {
        print('Cannot launch URL, trying browser fallback');
        await _openInBrowser(fullUrl);
      }
    } catch (e) {
      print('Error opening file: $e');
      _showError('Error opening file: $e');
    } finally {
      Navigator.of(context).pop();
    }
  }

  Future<void> _openInBrowser(String url) async {
    try {
      final uri = Uri.parse(url);
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
        webViewConfiguration: const WebViewConfiguration(
          enableJavaScript: true,
        ),
      );
    } catch (e) {
      throw 'Could not open file in browser: $e';
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showError('Could not launch phone dialer');
      }
    } catch (e) {
      _showError('Error launching phone: $e');
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showError('Could not launch email client');
      }
    } catch (e) {
      _showError('Error launching email: $e');
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Opening file...'),
            ],
          ),
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: Colors.grey.shade100, width: 1),
              ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue.shade600,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isClickable
                          ? Colors.blue.shade600
                          : Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getFileTypeColor(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Colors.red;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
        return Colors.green;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
        return Colors.purple;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Colors.orange;
      case 'doc':
      case 'docx':
        return Colors.blue;
      case 'xls':
      case 'xlsx':
        return Colors.teal;
      case 'txt':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  IconData _getFileTypeIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
        return Icons.image;
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'wmv':
        return Icons.video_file;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Icons.audio_file;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }
}
