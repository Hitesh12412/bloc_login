import 'package:bloc_login/features/screens/master/bloc/branch_bloc/branch_screen_bloc.dart';
import 'package:bloc_login/features/screens/master/bloc/branch_bloc/branch_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/branch_bloc/branch_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/branch_model/branch_model_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BranchSelectView extends StatelessWidget {
  const BranchSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BranchBloc()..add(FetchBranchEvent()),
      child: const BranchSelectScreen(),
    );
  }
}

class BranchSelectScreen extends StatefulWidget {
  const BranchSelectScreen({super.key});

  @override
  State<BranchSelectScreen> createState() => _BranchSelectScreenState();
}

class _BranchSelectScreenState extends State<BranchSelectScreen> {
  BranchData? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Select Branch',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<BranchBloc, BranchState>(
        builder: (context, state) {
          if (state is BranchLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BranchLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: state.branches.length,
              itemBuilder: (context, index) {
                final branch = state.branches[index];
                final isSelected = selectedBranch?.id == branch.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedBranch = null;
                      } else {
                        selectedBranch = branch;
                      }
                    });
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:
                      isSelected ? Colors.blue.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color:
                        isSelected ? Colors.blue : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          branch.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                          value: isSelected,
                          activeColor: Colors.blue,
                          onChanged: (_) {
                            setState(() {
                              if (isSelected) {
                                selectedBranch = null;
                              } else {
                                selectedBranch = branch;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is BranchFailure) {
            return Center(child: Text(state.error));
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
              selectedBranch == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedBranch == null
                ? null
                : () {
              Navigator.pop(context, selectedBranch);
            },
            child: const Text(
              'Select Branch',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
