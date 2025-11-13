import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/bloc/exp_list_bloc/exp_list_bloc.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/bloc/exp_list_bloc/exp_list_event.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/bloc/exp_list_bloc/exp_list_state.dart';
import 'package:bloc_login/features/screens/hrmanager_module/ui/employee!_details/experience_screen/screen/exp_list_screen/delete_exp_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';

class ExperienceListScreen extends StatefulWidget {
  final String employeeId;

  const ExperienceListScreen({
    required this.employeeId,
    super.key,
  });

  @override
  State<ExperienceListScreen> createState() => _ExperienceListScreenState();
}

class _ExperienceListScreenState extends State<ExperienceListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExperienceBloc(),
      child: ExperienceListScreenWidget(
        employeeId: widget.employeeId,
      ),
    );
  }
}

class ExperienceListScreenWidget extends StatefulWidget {
  final String employeeId;

  const ExperienceListScreenWidget({
    required this.employeeId,
    super.key,
  });

  @override
  State<ExperienceListScreenWidget> createState() => _ExperienceListScreenWidgetState();
}

class _ExperienceListScreenWidgetState extends State<ExperienceListScreenWidget> {
  final Map<String, String> _downloadedFiles = {};
  final _formatDate = DateFormat("dd/MM//yyyy");

  String? _downloadingUrl;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    BlocProvider.of<ExperienceBloc>(context).add(
      FetchExperienceEvent(employeeId: widget.employeeId),
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
              "Experience List",
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
          BlocBuilder<ExperienceBloc, ExperienceStates>(
            builder: (context, state) {
              if (state is LoadingExperienceState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LoadedExperienceState) {
                final Experiences = state.model.data;
                if (Experiences.isNotEmpty) {
                  return ListView.builder(
                    itemCount: Experiences.length,
                    itemBuilder: (context, index) {
                      final Experience = Experiences[index];
                      final docUrl = Experience.documentUpload;

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
                                      CupertinoIcons.building_2_fill,
                                      color: Colors.blue,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    Experience.companyName,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  const Spacer(),
                                  PopupMenuButton<String>(
                                    itemBuilder: (_) => [
                                      PopupMenuItem<String>(
                                        child: Row(children: [
                                          Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color:
                                                Colors.blue.withOpacity(0.2),
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
                                            return DeleteExperienceBottomSheet(
                                              Experience: Experience,
                                              onDeleteConfirmed: () {
                                                Navigator.of(context).pop();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Deleted Experience: ${Experience.companyName}'),
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
                            const SizedBox(height: 15,),
                            Container(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Row(
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
                                        Text(_formatDate.format(
                                          DateTime.parse(
                                              Experience.joiningDate),
                                        ),),
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
                                      color: Colors.orange.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.orange.shade100),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Icon(Icons.stop, color: Colors.orange),
                                            SizedBox(width: 5),
                                            Text(
                                              'End Date',
                                              style:
                                              TextStyle(color: Colors.orange),
                                            ),
                                          ],
                                        ),
                                        Text(_formatDate.format(
                                          DateTime.parse(
                                              Experience.endDate),
                                        ),),
                                      ],
                                    ),
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
                                          borderRadius: BorderRadius.circular(10),
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
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0.1),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              Experience.documentUpload.split('/').last,
                                              style: const TextStyle(color: Colors.black87),
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
                                        child: _downloadedFiles.containsKey(docUrl)
                                            ? Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                            BorderRadius.circular(10),
                                          ),
                                          child: const Icon(Icons.folder_open,
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
                                            BorderRadius.circular(10),
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
              } else if (state is FailureExperienceState) {
                return Center(child: Text('Error: ${state.error}'));
              } else if (state is InternalServerErrorExperienceState) {
                return Center(child: Text(state.error));
              } else if (state is ServerErrorExperienceState) {
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
