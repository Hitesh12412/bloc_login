import 'package:bloc_login/features/screens/master/bloc/state_bloc/state_screen_bloc.dart';
import 'package:bloc_login/features/screens/master/bloc/state_bloc/state_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/state_bloc/state_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/state_model/state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class StateSelectView extends StatelessWidget {
  final int countryId;

  const StateSelectView({
    super.key,
    required this.countryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StateBloc()..add(FetchStateEvent(countryId)),
      child: const StateSelectScreen(),
    );
  }
}

class StateSelectScreen extends StatefulWidget {
  const StateSelectScreen({super.key});

  @override
  State<StateSelectScreen> createState() => _StateSelectScreenState();
}

class _StateSelectScreenState extends State<StateSelectScreen> {
  StateData? selectedState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Select State',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<StateBloc, StateState>(
        builder: (context, state) {
          if (state is StateLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is StateLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: state.states.length,
              itemBuilder: (context, index) {
                final item = state.states[index];
                final isSelected = selectedState?.id == item.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedState = isSelected ? null : item;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
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
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.blue, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Checkbox(
                          value: isSelected,
                          activeColor: Colors.blue,
                          onChanged: (_) {
                            setState(() {
                              selectedState =
                              isSelected ? null : item;
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

          if (state is StateFailure) {
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
              selectedState == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedState == null
                ? null
                : () {
              Navigator.pop(context, selectedState);
            },
            child: const Text(
              'Select State',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
