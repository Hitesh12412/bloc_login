import 'package:bloc_login/features/screens/inventory/bloc/out_off_product/out_off_stck_bloc.dart';
import 'package:bloc_login/features/screens/inventory/bloc/out_off_product/out_off_stck_event.dart';
import 'package:bloc_login/features/screens/inventory/bloc/out_off_product/out_off_stck_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OutOfStock extends StatelessWidget {
  const OutOfStock({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OutOfStockBloc>(
      create: (context) => OutOfStockBloc()..add(LoadOutOfStockEvent()),
      child: const OutOfStockList(),
    );
  }
}

class OutOfStockList extends StatelessWidget {
  const OutOfStockList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Out of Stock Inventory',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Inventory Management',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                )
              ],
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              // Add search functionality
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
      body: BlocBuilder<OutOfStockBloc, OutOfStockStates>(
        builder: (context, state) {
          if (state is LoadingOutOfStockState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedOutOfStockState) {
            final outOfStockList = state.outOfStockResponse.data;
            return ListView.builder(
                itemCount: outOfStockList.length,
                itemBuilder: (context, index) {
                  final outOfStock = outOfStockList[index];
                  return GestureDetector(
                    onTap: () {
                      //
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
                                outOfStock.productName,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
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
                                      ' Qty : ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      outOfStock.qty,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
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
                },);
          } else if (state is FailureOutOfStockState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.error,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OutOfStockBloc>().add(LoadOutOfStockEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is InternalServerErrorOutOfStockState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.error,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
