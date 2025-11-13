import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/bloc/agreement_list_bloc/agreement_list_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/bloc/agreement_list_bloc/agreement_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/bloc/agreement_list_bloc/agreement_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/agreement_screen/screen/agreement_list/delete_agreement_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class AgreementListScreen extends StatefulWidget {
  final String employeeId;

  const AgreementListScreen({
    required this.employeeId,
    super.key,
  });

  @override
  State<AgreementListScreen> createState() => _AgreementListScreenState();
}

class _AgreementListScreenState extends State<AgreementListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AgreementBloc(),
      child: AgreementListScreenWidget(
        employeeId: widget.employeeId,
      ),
    );
  }
}

class AgreementListScreenWidget extends StatefulWidget {
  final String employeeId;

  const AgreementListScreenWidget({
    required this.employeeId,
    super.key,
  });

  @override
  State<AgreementListScreenWidget> createState() =>
      _AgreementListScreenWidgetState();
}

class _AgreementListScreenWidgetState extends State<AgreementListScreenWidget> {
  final Map<String, String> _downloadedFiles = {};
  final _formatDate = DateFormat("dd/MM//yyyy");

  String? _downloadingUrl;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    BlocProvider.of<AgreementBloc>(context).add(
      FetchAgreementEvent(employeeId: widget.employeeId),
    );
    super.initState();
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (_) {
      return '';
    }
  }

  Future<void> _downloadAndOpenDocument(String url) async {
    setState(() {
      _downloadingUrl = url;
      _downloadProgress = 0.0;
    });
    try {
      final dir = await getTemporaryDirectory();
      final filename = url.split('/').last;
      final savePath = "${dir.path}/$filename";
      await Dio().download(
        "https://shiserp.com/demo/$url",
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );
      setState(() {
        _downloadedFiles[url] = savePath;
        _downloadingUrl = null;
        _downloadProgress = 0;
      });
      await OpenFile.open(savePath);
    } catch (e) {
      setState(() {
        _downloadingUrl = null;
        _downloadProgress = 0;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Download failed: $e"),
        ),
      );
    }
  }

  Future<void> _openIfDownloadedOrDownload(String url) async {
    if (_downloadedFiles.containsKey(url)) {
      await OpenFile.open(_downloadedFiles[url]!);
    } else if (_downloadingUrl == null) {
      await _downloadAndOpenDocument(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child:
            const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
        ),
        title: const Row(
          children: [
            Text(
              "Agreement List",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
        centerTitle: false,
        titleSpacing: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),),
        actions: [
          IconButton(
            onPressed: () {
              //
            },
            icon: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.blue),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<AgreementBloc, AgreementStates>(
            builder: (context, state) {
              if (state is LoadingAgreementState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LoadedAgreementState) {
                final agreements = state.model.data;
                if (agreements.isNotEmpty) {
                  return ListView.builder(
                    itemCount: agreements.length,
                    itemBuilder: (context, index) {
                      final agreement = agreements[index];
                      final docUrl = agreement.documentUpload;

                      return Container(
                        margin: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      agreement.associationType,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    itemBuilder: (_) => [
                                      PopupMenuItem<String>(
                                        child: Row(
                                          children: [
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Icon(Icons.edit,
                                                    color: Colors.blue)),
                                            const SizedBox(width: 8),
                                            const Text('Edit'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () => showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return DeleteAgreementBottomSheet(
                                              agreement: agreement,
                                              onDeleteConfirmed: () {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Deleted agreement: ${agreement.associationType}'),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(Icons.delete_outline,
                                                  color: Colors.red),
                                            ),
                                            const SizedBox(width: 8),
                                            const Text('Delete'),
                                          ],
                                        ),
                                      ),
                                    ],
                                    icon: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey.shade100),
                                      ),
                                      child: const Icon(Icons.more_vert,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            75) /
                                        2,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.blue.shade100),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.not_started_outlined,
                                                color: Colors.blue),
                                            SizedBox(width: 5),
                                            Text(
                                              'Start Date',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _formatDate.format(
                                            DateTime.parse(
                                                agreement.agreementStartDate),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: (MediaQuery.of(context).size.width -
                                            75) /
                                        2,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.red.shade100),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.stop, color: Colors.red),
                                            SizedBox(width: 5),
                                            Text(
                                              'End Date',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          _formatDate.format(
                                            DateTime.parse(
                                              agreement.agreementEndDate,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (agreement.appraisalDueOn != null)
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.purple[50],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.purple.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time,
                                          color: Colors.purple),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Appraisal Due Date',
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formatDate(
                                                agreement.appraisalDueOn!),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 18),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.file_present_rounded,
                                          color: Colors.blue),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                          ),
                                        ),
                                        child: Text(
                                          agreement.documentUpload
                                              .split('/')
                                              .last,
                                          style:
                                              const TextStyle(color: Colors.black87),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    GestureDetector(
                                      onTap: () =>
                                          _openIfDownloadedOrDownload(docUrl),
                                      child: _downloadedFiles
                                              .containsKey(docUrl)
                                          ? Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                  Icons.folder_open,
                                                  color: Colors.white),
                                            )
                                          : (_downloadingUrl == docUrl
                                              ? const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 2),
                                                )
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.blue
                                                            .withOpacity(0.3),
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                        offset:
                                                            const Offset(0, 3),
                                                      ),
                                                    ],
                                                  ),
                                                  child: const Icon(
                                                      Icons.download,
                                                      color: Colors.white),
                                                )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          'https://cdni.iconscout.com/illustration/premium/thumb/no-data-found-illustration-download-in-svg-png-gif-file-formats--office-computer-digital-work-business-pack-illustrations-7265556.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        const Text("Data Not Found!",style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,color: Colors.grey
                        ),),
                      ],
                    ),
                  );
                }
              } else if (state is FailureAgreementState) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                  ),
                );
              } else if (state is InternalServerErrorAgreementState) {
                return Center(
                  child: Text(
                    state.error,
                  ),
                );
              } else if (state is ServerErrorAgreementState) {
                return Center(
                  child: Text(
                    state.error,
                  ),
                );
              }
              return Container();
            },
          ),
          if (_downloadingUrl != null)
            Container(
              color: Colors.black45,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        'Downloading...  ${(100 * _downloadProgress).toStringAsFixed(1)}%',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
