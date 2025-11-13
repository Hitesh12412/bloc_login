import 'package:bloc_login/features/screens/inventory/bloc/inventory_list_bloc/inventory_list_bloc.dart';
import 'package:bloc_login/features/screens/inventory/bloc/inventory_list_bloc/inventory_list_state.dart';
import 'package:bloc_login/features/screens/inventory/bloc/inventory_list_bloc/inventory_list_event.dart';
import 'package:bloc_login/features/screens/inventory/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InventoryProduct extends StatelessWidget {
  const InventoryProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InventoryListBloc>(
      create: (context) => InventoryListBloc()..add(LoadInventoryListEvent()),
      child: const InventoryProductList(),
    );
  }
}

class InventoryProductList extends StatelessWidget {
  const InventoryProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inventory',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: Container(
          padding: const EdgeInsets.only(left: 5),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            onPressed: () => {
              Navigator.pop(context),
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () {
              //
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.search,
                  color: Colors.blue,
                )),
          )
        ],
      ),
      body: BlocBuilder<InventoryListBloc, InventoryListStates>(
        builder: (context, state) {
          if (state is LoadingInventoryListState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedInventoryListState) {
            final inventoryList = state.inventoryResponse.data;
            return ListView.builder(
              itemCount: inventoryList.length,
              itemBuilder: (context, index) {
                final inventory = inventoryList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductDetails(),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.inventory_2_outlined,
                            size: 30,
                            color: Colors.blue.shade800,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              inventory.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    ' Qty:  ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    inventory.qty,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.blue.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (state is FailureInventoryListState) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is InternalServerErrorInventoryListState) {
            return Center(
              child: Text(state.error),
            );
          }
          return Container();
        },
      ),
    );
  }
}
