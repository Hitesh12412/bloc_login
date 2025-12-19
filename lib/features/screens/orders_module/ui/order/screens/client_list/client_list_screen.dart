import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/client_list/client_list_bloc.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/client_list/client_list_event.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/bloc/client_list/client_list_state.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/model/client_list/client_list_model_class.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/screens/create_order/create_order.dart';

class SelectClientScreenView extends StatelessWidget {
  const SelectClientScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ClientBloc()..add(FetchClientEvent(userId: '1')),
      child: const SelectClientScreen(),
    );
  }
}

class SelectClientScreen extends StatefulWidget {
  const SelectClientScreen({super.key});

  @override
  State<SelectClientScreen> createState() => _SelectClientScreenState();
}

class _SelectClientScreenState extends State<SelectClientScreen> {
  ClientData? selectedClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(8)),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios,
                  size: 20, color: Colors.white)),
        ),
        backgroundColor: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),),),
        titleSpacing: 0,
        title: const Text(
          'Select Client',
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ClientBloc, ClientStates>(
        builder: (context, state) {
          if (state is LoadingClientState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LoadedClientState) {
            if (state.clients.isEmpty) {
              return const Center(child: Text('No clients found'));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 10),
              itemCount: state.clients.length,
              itemBuilder: (context, index) {
                final client = state.clients[index];
                final isSelected = selectedClient?.id == client.id;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedClient = isSelected ? null : client;
                    });
                  },
                  child: Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color:
                      isSelected ? Colors.blue.shade100 : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                        isSelected ? Colors.blue : Colors.grey.shade300,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                client.customerName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (client.customerLevelName.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                                  margin: const EdgeInsets.only(bottom: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(client.customerLevelName,style: TextStyle(color: Colors.blue.shade700,fontSize: 12),),
                                ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.mail_outline,color: Colors.blue,),),
                                  const SizedBox(width: 4),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Email',style: TextStyle(fontSize: 12),),
                                      Text(
                                        client.email,
                                        style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue.shade100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.phone,color: Colors.blue,)),
                                  const SizedBox(width: 4),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Mobile',style: TextStyle(fontSize: 12),),
                                      Text(
                                        client.mobileNo,
                                        style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.blue
                                        ,decoration: TextDecoration.underline,decorationColor: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          value: isSelected,
                          side: const BorderSide(color: Colors.grey),
                          activeColor: Colors.blue,
                          onChanged: (_) {
                            setState(() {
                              selectedClient =
                              isSelected ? null : client;
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

          if (state is FailureClientState) {
            return Center(child: Text(state.error));
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
              selectedClient == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedClient == null
                ? null
                : () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CreateOrderView(
                    selectedClient: selectedClient!,
                  ),
                ),
              );
            },
            child: const Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
