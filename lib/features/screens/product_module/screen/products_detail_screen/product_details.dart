import 'package:bloc_login/features/screens/product_module/bloc/product_details/product_detail_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/product_details/product_detail_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/product_details/product_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatelessWidget {
  final String productId;
  const ProductDetail({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailBloc()
        ..add(
          FetchProductDetailEvent(productID: productId),
        ),
      child: ProductDetailView(productId: productId),
    );
  }
}

class ProductDetailView extends StatelessWidget {
  final productId;
  const ProductDetailView({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.only(left: 7),
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 20,
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
              margin: const EdgeInsets.only(
                right: 10,
              ),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.edit,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailStates>(
        builder: (context, state) {
          if (state is LoadingProductDetailState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FailureProductDetailState) {
            return Center(child: Text(state.error));
          } else if (state is LoadedProductDetailState) {
            final Product = state.model.data;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProductDetailBloc>().add(
                      FetchProductDetailEvent(productID: productId),
                    );
                await Future.delayed(
                  const Duration(seconds: 1),
                );
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(
                          0.2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade300),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.inventory,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  Product.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  Product.brandName,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Product Information',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.category,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Product Type:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.productTypeName,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.folder,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Category:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.categoryName,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.folder_special,
                                  color: Colors.orange,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Sub-Category:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.subCategoryName,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.purple.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.straighten,
                                  color: Colors.purple,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Unit:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.unitName,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.inventory_outlined,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Quantity:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.qty.toString(),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.currency_rupee,
                                    color: Colors.redAccent),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Price:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        Product.productPrice,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.redAccent.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.currency_rupee,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Max Purchase Price:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.currency_rupee,
                                        size: 15,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        Product.maxPurchasePrice,
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.qr_code,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'HSN Code:',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    Product.hsnCode,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 0.9,
                            height: 10,
                            indent: 5,
                            endIndent: 5,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            'Tax Information',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'CGST',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text('${Product.tax1Rate}%'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'SGST',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${Product.tax2Rate}%',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.2),
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'IGST',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${Product.tax3Rate}%',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (Product.productItemList.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Text(
                            'Product Items',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: Text(Product.productItemList.length.toString()),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Product.productItemList.length,
                      itemBuilder: (context, index) {
                        final item =
                        Product.productItemList[index] as Map<String, dynamic>;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.inventory_2_outlined,
                                      color: Colors.green,
                                      size: 25,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['product_name'] ?? 'Product',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Job: ${item['job_number'] ?? '-'}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),

                              _infoRow(
                                icon: Icons.category,
                                label: 'Category',
                                value: item['category_name'] ?? '-',
                              ),
                              _infoRow(
                                icon: Icons.layers_outlined,
                                label: 'Sub Category',
                                value: item['sub_category_name'] ?? '-',
                              ),
                              _infoRow(
                                icon: Icons.branding_watermark_outlined,
                                label: 'Brand',
                                value: item['brand_name'] ?? '-',
                              ),
                              _infoRow(
                                icon: Icons.branding_watermark_outlined,
                                label: 'Quantity',
                                value: item['qty'] ?? '-',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
