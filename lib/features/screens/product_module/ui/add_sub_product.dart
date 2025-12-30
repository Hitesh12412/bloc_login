import 'package:flutter/material.dart';
import 'package:bloc_login/features/screens/orders_module/ui/order/screens/product_list_Screen/product_list_screen.dart';
import 'package:bloc_login/features/screens/product_module/model/products_list_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final productCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();




  ProductListModel? selectedProduct;


  @override
  Widget build(BuildContext context) {
    final hasProduct = selectedProduct != null;

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
          'Add Product',
          style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(14, 16, 14, 90),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProductSelectSingleScreenView(),
                        ),
                      );
                      if (result is ProductListModel) {
                        setState(() {
                          selectedProduct = result;
                          productCtrl.text = result.name;
                        });
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Product',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                productCtrl.text.isEmpty
                                    ? 'Select Product'
                                    : productCtrl.text,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: productCtrl.text.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios,size: 18,color: Colors.grey,),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Quantity',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: qtyCtrl,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Write Actual Quantity...',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 15,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: hasProduct ? Colors.blue : Colors.grey,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: hasProduct
                          ? () async {
                        FocusScope.of(context).unfocus();

                        await Future.delayed(const Duration(milliseconds: 50));

                        Navigator.pop(context, {
                          'product_id': selectedProduct!.id.toString(),
                          'product_name': selectedProduct!.name,
                          'qty': qtyCtrl.text.isEmpty ? '1' : qtyCtrl.text,
                          'category_id': selectedProduct!.categoryId.toString(),
                          'category_name': selectedProduct!.categoryName,
                          'sub_category_id': selectedProduct!.subCategoryId.toString(),
                          'sub_category_name': selectedProduct!.subCategoryName,
                          'brand_id': selectedProduct!.brandId.toString(),
                          'brand_name': selectedProduct!.brandName,
                        });
                      }
                          : null,
                      child: const Text(
                        'Save',
                        style:
                        TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
