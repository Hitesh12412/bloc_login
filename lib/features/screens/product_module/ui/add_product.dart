import 'dart:convert';

import 'package:bloc_login/features/screens/product_module/bloc/add_product/add_product_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/add_product/add_product_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/add_product/add_product_state.dart';
import 'package:bloc_login/features/screens/product_module/bloc/tax_type/tax_type_rate_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/tax_type/tax_type_rate_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/tax_type/tax_type_rate_state.dart';
import 'package:bloc_login/features/screens/product_module/bloc/unit_product_type/unit_product_type_bloc.dart';
import 'package:bloc_login/features/screens/product_module/bloc/unit_product_type/unit_product_type_event.dart';
import 'package:bloc_login/features/screens/product_module/bloc/unit_product_type/unit_product_type_state.dart';
import 'package:bloc_login/features/screens/product_module/model/brand_model_class.dart';
import 'package:bloc_login/features/screens/product_module/model/category_model_class.dart';
import 'package:bloc_login/features/screens/product_module/model/sub_category_class.dart';
import 'package:bloc_login/features/screens/product_module/model/unit_and_product_type_model.dart';
import 'package:bloc_login/features/screens/product_module/ui/add_sub_product.dart';
import 'package:bloc_login/features/screens/product_module/ui/brand_list_screen.dart';
import 'package:bloc_login/features/screens/product_module/ui/category_screen.dart';
import 'package:bloc_login/features/screens/product_module/ui/sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductCreateBloc()),
        BlocProvider(
          create: (_) => UnitProductBloc()..add(FetchUnitProductEvent()),
        ),
      ],
      child: const AddProduct(),
    );
  }
}

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final productNameCtrl = TextEditingController();
  final descriptionCtrl = TextEditingController();
  final jobNumberCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final maxPriceCtrl = TextEditingController();
  final hsnCtrl = TextEditingController();
  final qtyCtrl = TextEditingController();

  CategoryModel? selectedCategory;
  SubCategoryModel? selectedSubCategory;
  BrandModel? selectedBrand;

  UnitProductModel? selectedUnit;
  UnitProductModel? selectedProductType;

  String? cgstRate;
  String? sgstRate;
  String? igstRate;

  List<Map<String, dynamic>> selectedProducts = [];

  String _v(Map<String, dynamic> p, String key, [String def = '0']) {
    final val = p[key];
    if (val == null) return def;
    return val.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        titleSpacing: 0,
        backgroundColor: Colors.blue,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          "Add Product",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: BlocListener<ProductCreateBloc, ProductCreateState>(
        listener: (context, state) {
          if (state is ProductCreateSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pop(context);
          }
          if (state is ProductCreateFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInputField(
                  "Product Name", "Enter product name...", productNameCtrl),
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
                      'Product Description',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextField(
                      maxLines: 3,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter additional product details...',
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
              _buildInputField(
                  "Job Number", "Enter job number...", jobNumberCtrl),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CategoryView()),
                  );
                  if (result != null && result is CategoryModel) {
                    setState(() {
                      selectedCategory = result;
                      selectedSubCategory = null;
                    });
                  }
                },
                child: _buildSelectField(
                  "Select Category",
                  selectedCategory?.name ?? "Tap to select a category...",
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  if (selectedCategory == null) return;
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SubCategoryView(
                        categoryId: selectedCategory!.id.toString(),
                      ),
                    ),
                  );
                  if (result != null && result is SubCategoryModel) {
                    setState(() => selectedSubCategory = result);
                  }
                },
                child: _buildSelectField(
                  "Select Sub-Category",
                  selectedSubCategory?.subCategoryName ??
                      "Tap to select a sub category...",
                ),
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BrandView()),
                  );
                  if (result != null && result is BrandModel) {
                    setState(() => selectedBrand = result);
                  }
                },
                child: _buildSelectField(
                  "Select Brand",
                  selectedBrand?.name ?? "Tap to select a brand...",
                ),
              ),
              _buildInputField(
                  "Price", "Enter price for product...", priceCtrl),
              _buildInputField("Max Purchase Price",
                  "Enter max purchase price for product...", maxPriceCtrl),
              _buildInputField("HSN Code", "Enter HSN code...", hsnCtrl),
              _taxBox("CGST"),
              _taxBox("SGST"),
              _taxBox("IGST"),
              _buildInputField("Quantity", "Enter quantity...", qtyCtrl),
              BlocBuilder<UnitProductBloc, UnitProductState>(
                builder: (context, state) {
                  if (state is! UnitProductLoaded) {
                    return _buildSelectField("Units", "Select units...");
                  }

                  return _buildUnitDropdown(
                    label: "Units",
                    hint: selectedUnit?.name ?? "Select units",
                    items: state.units,
                    onChanged: (val) {
                      setState(() => selectedUnit = val);
                    },
                  );
                },
              ),

              BlocBuilder<UnitProductBloc, UnitProductState>(
                builder: (context, state) {
                  if (state is! UnitProductLoaded) {
                    return _buildSelectField(
                      "Product Type",
                      "Select product type...",
                    );
                  }

                  return _buildUnitDropdown(
                    label: "Product Type",
                    hint: selectedProductType?.name ?? "Select product type",
                    items: state.productTypes,
                    onChanged: (val) {
                      setState(() => selectedProductType = val);
                    },
                  );
                },
              ),
              GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddProductScreen(),
                      ),
                    );

                    if (result != null && result is Map<String, dynamic>) {
                      setState(() {
                        selectedProducts.add(result);
                      });
                    }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            shape: BoxShape.circle,
                  ),
                          child: Icon(Icons.add_box_outlined,color: Colors.blue.shade700,)),
                      const SizedBox(width: 10,),
                      Text("Add New Product",style: TextStyle(color: Colors.blue.shade700),)
                    ],
                  ),
                ),
              ),

              if (selectedProducts.isNotEmpty) ...[
                const SizedBox(height: 16),
                _section('Products'),
                ...selectedProducts.map(_productTile),
              ],

              const SizedBox(height: 20),
              BlocConsumer<ProductCreateBloc, ProductCreateState>(
                listener: (context, state) {
                  if (state is ProductCreateSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Product saved successfully'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    Navigator.pop(context);
                  }

                  if (state is ProductCreateFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: state is ProductCreateLoading
                          ? null
                          : () {
                        final productDataJson = jsonEncode(
                          selectedProducts.map((p) {
                            return {
                              "product_id": p['product_id'],
                              "qty": p['qty'],
                              "category_id": p['category_id'],
                              "sub_category_id": p['sub_category_id'],
                              "brand_id": p['brand_id'],
                            };
                          }).toList(),
                        );

                        context.read<ProductCreateBloc>().add(
                          ProductCreateRequested(
                            userId: '1',
                            categoryId: selectedCategory?.id.toString() ?? '',
                            subCategoryId:
                            selectedSubCategory?.id.toString() ?? '',
                            unitId: '1',
                            productTypeId: '1',
                            brandId: selectedBrand?.id.toString() ?? '',
                            name: productNameCtrl.text,
                            productPrice: priceCtrl.text,
                            qty: qtyCtrl.text,
                            tax1: 'CGST',
                            tax1Rate: cgstRate ?? '0',
                            tax2: 'SGST',
                            tax2Rate: sgstRate ?? '0',
                            tax3: 'IGST',
                            tax3Rate: igstRate ?? '0',
                            productData: productDataJson,
                          ),
                        );
                      },
                      icon: state is ProductCreateLoading
                          ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Icon(Icons.save),
                      label: Text(
                        state is ProductCreateLoading ? "Saving..." : "Save Product",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _taxBox(String taxType) {
    String? rate;
    if (taxType == 'CGST') rate = cgstRate;
    if (taxType == 'SGST') rate = sgstRate;
    if (taxType == 'IGST') rate = igstRate;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openTaxBottomSheet(taxType),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tax Type',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                Text(taxType, style: const TextStyle(fontSize: 15)),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Tax Rate',
                    style: TextStyle(color: Colors.blue, fontSize: 12)),
                Text(
                  rate == null ? '%' : '$rate%',
                  style: TextStyle(
                      fontSize: 15,
                      color: rate == null ? Colors.grey : Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openTaxBottomSheet(String taxType) {
    String? selectedRate;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            const Icon(Icons.receipt_long, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Add Tax Details',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.cancel,
                            color: Colors.grey,
                            size: 30,
                          )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tax Type',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              taxType,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async {
                      final rate = await _openTaxRateSheet(taxType);
                      if (rate != null) {
                        setSheetState(() {
                          selectedRate = rate;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Tax Rate',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.blue),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                selectedRate == null
                                    ? 'Select Tax Rate'
                                    : '$selectedRate%',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: selectedRate == null
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Icon(Icons.keyboard_arrow_down_rounded),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selectedRate == null
                          ? null
                          : () {
                              setState(() {
                                if (taxType == 'CGST') {
                                  cgstRate = selectedRate;
                                }
                                if (taxType == 'SGST') {
                                  sgstRate = selectedRate;
                                }
                                if (taxType == 'IGST') {
                                  igstRate = selectedRate;
                                }
                              });
                              Navigator.pop(context);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Add Tax',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<String?> _openTaxRateSheet(String taxType) {
    return showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return BlocProvider(
          create: (_) => TaxBloc()..add(FetchTaxEvent(taxType)),
          child: BlocBuilder<TaxBloc, TaxState>(
            builder: (context, state) {
              if (state is TaxLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is TaxLoaded) {
                return ListView.builder(
                  itemCount: state.taxes.length,
                  itemBuilder: (context, index) {
                    final tax = state.taxes[index];
                    return ListTile(
                      title: Text(tax.taxName),
                      onTap: () => Navigator.pop(context, tax.taxRate),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        );
      },
    );
  }

  Widget _buildUnitDropdown({
    required String label,
    required String hint,
    required List<UnitProductModel> items,
    required ValueChanged<UnitProductModel?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<UnitProductModel>(
          isExpanded: true,
          hint: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                hint,
                style: TextStyle(
                  fontSize: 16,
                  color: hint.startsWith("Select")
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
            ],
          ),
          items: items
              .map(
                (e) => DropdownMenuItem<UnitProductModel>(
              value: e,
              child: Text(e.name),
            ),
          )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 18,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }


  Widget _buildInputField(
      String label, String hint, TextEditingController ctrl) {
    return Container(
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
          Text(
            label,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: ctrl,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
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
    );
  }


  Widget _buildSelectField(String label, String hint) {
    return Container(
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
              Text(
                label,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text(hint,
                  style: TextStyle(
                      fontSize: 16,
                      color:
                      hint.startsWith("Tap") ? Colors.grey : Colors.black),),

            ],
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _productTile(Map<String, dynamic> p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.inventory_2_outlined,
                          color: Colors.green, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _v(p, 'product_name'),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,color: Colors.green),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 3,bottom: 3),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Qty: ${_v(p, 'qty')}',
                            style: TextStyle(color: Colors.blue.shade700,fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.more_vert,color: Colors.blue.shade700,size: 20,),)
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.category_outlined,color: Colors.grey,size: 20,),
                          const SizedBox(width: 8),
                          Text("Category :  ${_v(p, 'category_name')}")
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.subdirectory_arrow_right,color: Colors.grey,size: 20,),
                          const SizedBox(width: 8),
                          Text("Sub-Category :  ${_v(p, 'sub_category_name')}")
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.branding_watermark_outlined,color: Colors.grey,size: 20,),
                          const SizedBox(width: 8),
                          Text("Brand :  ${_v(p, 'brand_name')}")
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$title :-',
        style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }


}
