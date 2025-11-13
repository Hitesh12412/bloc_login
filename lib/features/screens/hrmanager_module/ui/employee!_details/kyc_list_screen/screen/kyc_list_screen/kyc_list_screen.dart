import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/bloc/kyc_list_bloc/Kyc_list_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/bloc/kyc_list_bloc/Kyc_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/bloc/kyc_list_bloc/Kyc_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/kyc_list_screen/screen/kyc_list_screen/delete_kyc_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class KycListScreen extends StatefulWidget {
  final String employeeId;

  const KycListScreen({
    required this.employeeId,
    super.key,
  });

  @override
  State<KycListScreen> createState() => _KycListScreenState();
}

class _KycListScreenState extends State<KycListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => KycBloc(),
      child: KycListScreenWidget(
        employeeId: widget.employeeId,
      ),
    );
  }
}

class KycListScreenWidget extends StatefulWidget {
  final String employeeId;

  const KycListScreenWidget({
    required this.employeeId,
    super.key,
  });

  @override
  State<KycListScreenWidget> createState() => _KycListScreenWidgetState();
}

class _KycListScreenWidgetState extends State<KycListScreenWidget> {
  final Map<String, String> _downloadedFiles = {};

  String? _downloadingUrl;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    BlocProvider.of<KycBloc>(context).add(
      FetchKycEvent(employeeId: widget.employeeId),
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
        SnackBar(content: Text("Download failed: $e")),
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
              "KYC List",
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
          BlocBuilder<KycBloc, KycStates>(
            builder: (context, state) {
              if (state is LoadingKycState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedKycState) {
                final Kycs = state.model.data;
                if (Kycs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: Kycs.length,
                    itemBuilder: (context, index) {
                      final Kyc = Kycs[index];
                      final docUrl = Kyc.documentUpload;

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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.2),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.description_outlined,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Document Type",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      Text(
                                        Kyc.documentType,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  PopupMenuButton<String>(
                                    itemBuilder: (_) => [
                                      PopupMenuItem<String>(
                                        child: Row(children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
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
                                        ]),
                                      ),
                                      PopupMenuItem<String>(
                                        onTap: () => showModalBottomSheet(
                                          context: context,
                                          backgroundColor: Colors.transparent,
                                          isScrollControlled: true,
                                          builder: (context) {
                                            return DeleteKycBottomSheet(
                                              Kyc: Kyc,
                                              onDeleteConfirmed: () {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Deleted Kyc: ${Kyc.fullName}'),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        child: Row(children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(Icons.delete_outline,
                                                  color: Colors.red)),
                                          const SizedBox(width: 8),
                                          const Text('Delete'),
                                        ]),
                                      ),
                                    ],
                                    icon: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.blue.shade100),
                                      ),
                                      child: const Icon(Icons.more_vert,
                                          color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.tag_sharp,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Document Number',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            Kyc.documentNo,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 15),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 4,
                                    height: 30,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.person_2_outlined,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Name',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            Kyc.fullName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(15),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(Icons.description_outlined,
                                            color: Colors.blue),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        child: const Text('Document'),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Container(
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
                                        child: Row(
                                          children: [
                                            Text(
                                              Kyc.documentUpload
                                                  .split('/')
                                                  .last,
                                              style: const TextStyle(
                                                  color: Colors.black87),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(width: 5),
                                            const Icon(Icons.remove_red_eye)
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                        onTap: () =>
                                            _openIfDownloadedOrDownload(docUrl),
                                        child: _downloadedFiles
                                                .containsKey(docUrl)
                                            ? Container(
                                                padding:
                                                    const EdgeInsets.all(8),
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
                                                          offset: const Offset(
                                                              0, 3),
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
                                ],
                              ),
                            ),
                          ],
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
              } else if (state is FailureKycState) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is InternalServerErrorKycState) {
                return Center(child: Text(state.error));
              } else if (state is ServerErrorKycState) {
                return Center(child: Text(state.error));
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
