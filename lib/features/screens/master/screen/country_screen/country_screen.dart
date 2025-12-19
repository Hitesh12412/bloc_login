import 'package:bloc_login/features/screens/master/bloc/country_bloc/country_screen_bloc.dart';
import 'package:bloc_login/features/screens/master/bloc/country_bloc/country_screen_event.dart';
import 'package:bloc_login/features/screens/master/bloc/country_bloc/country_screen_state.dart';
import 'package:bloc_login/features/screens/master/model/country_model/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CountrySelectView extends StatelessWidget {
  const CountrySelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountryBloc()..add(FetchCountryEvent()),
      child: const CountrySelectScreen(),
    );
  }
}

class CountrySelectScreen extends StatefulWidget {
  const CountrySelectScreen({super.key});

  @override
  State<CountrySelectScreen> createState() => _CountrySelectScreenState();
}

class _CountrySelectScreenState extends State<CountrySelectScreen> {
  CountryData? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Select Country',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<CountryBloc, CountryState>(
        builder: (context, state) {
          if (state is CountryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CountryLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: state.countries.length,
              itemBuilder: (context, index) {
                final country = state.countries[index];
                final isSelected = selectedCountry?.id == country.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedCountry = null;
                      } else {
                        selectedCountry = country;
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
                      children: [
                        Text(
                          country.emoji,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            country.name,
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
                              if (isSelected) {
                                selectedCountry = null;
                              } else {
                                selectedCountry = country;
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

          if (state is CountryFailure) {
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
              selectedCountry == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedCountry == null
                ? null
                : () {
              Navigator.pop(context, selectedCountry);
            },
            child: const Text(
              'Select Country',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
