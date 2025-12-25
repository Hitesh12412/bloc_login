import 'package:bloc_login/features/screens/product_module/bloc/products_list/products_list_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/products_list/products_list_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/products_list/products_list_state.dart';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductSelectSingleScreenView extends StatefulWidget {
  const ProductSelectSingleScreenView({super.key});

  @override
  State<ProductSelectSingleScreenView> createState() =>
      _ProductSelectSingleScreenViewState();
}

class _ProductSelectSingleScreenViewState
    extends State<ProductSelectSingleScreenView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(
          FetchProducts(
            dbConnection: 'erp_tata_steel_demo',
            searchText: '',
            pageNumber: 1,
            pageSize: 20,
          ),
        ),
      child: const ProductSelectSingleScreen(),
    );
  }
}

class ProductSelectSingleScreen extends StatefulWidget {
  const ProductSelectSingleScreen({super.key});

  @override
  State<ProductSelectSingleScreen> createState() =>
      _ProductSelectSingleScreenState();
}

class _ProductSelectSingleScreenState
    extends State<ProductSelectSingleScreen> {
  ProductListModel? selectedProduct;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        'Select Product',
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 90),
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                final isSelected = selectedProduct?.id == product.id;

                return InkWell(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedProduct = null;
                      } else {
                        selectedProduct = product;
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
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                        isSelected ? Colors.blue : Colors.grey.shade300,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state is ProductError) {
            return Center(child: Text(state.message));
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
              selectedProduct == null ? Colors.grey : Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: selectedProduct == null
                ? null
                : () {
              Navigator.pop(context, selectedProduct);
            },
            child: const Text(
              'Save Selection',
              style:
              TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
