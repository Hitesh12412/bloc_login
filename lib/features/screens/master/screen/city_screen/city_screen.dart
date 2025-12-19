import 'package:bloc_login/features/screens/master/bloc/city_bloc/city_screen_bloc.dart';
import 'package:bloc_login/features/screens/master/bloc/city_bloc/city_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/city_bloc/city_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/city_model/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CitySelectView extends StatelessWidget {
  final int stateId;

  const CitySelectView({
    super.key,
    required this.stateId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CityBloc()..add(FetchCityEvent(stateId)),
      child: const CitySelectScreen(),
    );
  }
}

class CitySelectScreen extends StatefulWidget {
  const CitySelectScreen({super.key});

  @override
  State<CitySelectScreen> createState() => _CitySelectScreenState();
}

class _CitySelectScreenState extends State<CitySelectScreen> {
  CityData? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Select City',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CityBloc, CityState>(
        builder: (context, state) {
          if (state is CityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CityLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                final isSelected = selectedCity?.id == city.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedCity = isSelected ? null : city;
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
                        const Icon(Icons.location_city,
                            color: Colors.blue, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            city.name,
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
                              selectedCity =
                              isSelected ? null : city;
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

          if (state is CityFailure) {
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
              selectedCity == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedCity == null
                ? null
                : () {
              Navigator.pop(context, selectedCity);
            },
            child: const Text(
              'Select City',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
