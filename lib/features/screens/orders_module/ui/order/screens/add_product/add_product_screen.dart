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
  final qtyCtrl = TextEditingController(text: '1');
  final actualQtyCtrl = TextEditingController(text: '1');
  final priceCtrl = TextEditingController(text: '0');
  final discountAmountCtrl = TextEditingController(text: '0');
  final discountPercentCtrl = TextEditingController(text: '0');

  ProductListModel? selectedProduct;

  bool syncing = false;
  bool enableDiscount = false;

  double _d(String v) => double.tryParse(v) ?? 0;

  double get qty => _d(qtyCtrl.text);
  double get price => _d(priceCtrl.text);
  double get cgstRate => _d(selectedProduct?.tax1Rate ?? '0');
  double get sgstRate => _d(selectedProduct?.tax2Rate ?? '0');

  double get grossAmount => qty * price;
  double get discountAmount => enableDiscount ? _d(discountAmountCtrl.text) : 0;
  double get taxableValue => (grossAmount - discountAmount).clamp(0, double.infinity);

  double get cgstAmount => taxableValue * cgstRate / 100;
  double get sgstAmount => taxableValue * sgstRate / 100;
  double get orderTotal => taxableValue + cgstAmount + sgstAmount;

  void _syncQty(String v, TextEditingController target) {
    if (syncing) return;
    syncing = true;
    target.text = v;
    syncing = false;
    setState(() {});
  }

  void _discountFromAmount() {
    final amt = _d(discountAmountCtrl.text);
    final percent = grossAmount == 0 ? 0 : (amt / grossAmount) * 100;
    discountPercentCtrl.text = percent.toStringAsFixed(2);
    setState(() {});
  }

  void _discountFromPercent() {
    final percent = _d(discountPercentCtrl.text);
    final amt = grossAmount * percent / 100;
    discountAmountCtrl.text = amt.toStringAsFixed(2);
    setState(() {});
  }

  // 🔹 CARD (same style everywhere)
  Widget _card(String label, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasProduct = selectedProduct != null;

    return Scaffold(
      backgroundColor: const Color(0xFFF6FBFD),
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
                  _card(
                    'Select Product',
                    InkWell(
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
                            priceCtrl.text = result.productPrice;
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
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
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),

                  _card(
                    'Quantity',
                    TextField(
                      controller: qtyCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (v) => _syncQty(v, actualQtyCtrl),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  _card(
                    'Actual Quantity',
                    TextField(
                      controller: actualQtyCtrl,
                      keyboardType: TextInputType.number,
                      onChanged: (v) => _syncQty(v, qtyCtrl),
                      decoration: const InputDecoration(border: InputBorder.none),
                    ),
                  ),

                  if (hasProduct) ...[
                    _card(
                      'Price',
                      TextField(
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(border: InputBorder.none),
                      ),
                    ),

                    Row(
                      children: [
                        Checkbox(
                          value: enableDiscount,
                          onChanged: (v) {
                            setState(() {
                              enableDiscount = v ?? false;
                              if (!enableDiscount) {
                                discountAmountCtrl.text = '0';
                                discountPercentCtrl.text = '0';
                              }
                            });
                          },
                        ),
                        const Text('Enable Discount on Product'),
                      ],
                    ),

                    if (enableDiscount)
                      _card(
                        'Discount',
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: discountAmountCtrl,
                                keyboardType: TextInputType.number,
                                onChanged: (_) => _discountFromAmount(),
                                decoration: const InputDecoration(
                                  hintText: '₹ Amount',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: discountPercentCtrl,
                                keyboardType: TextInputType.number,
                                onChanged: (_) => _discountFromPercent(),
                                decoration: const InputDecoration(
                                  hintText: '%',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    _paymentSummaryCard(
                      totalMrp: grossAmount,
                      discount: discountAmount,
                      taxableValue: taxableValue,
                      cgst: cgstAmount,
                      sgst: sgstAmount,
                      orderTotal: orderTotal,
                    ),
                  ],
                ],
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(14),
            color: Colors.white,
            child: SafeArea(
              child: SizedBox(
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
                      ? () {
                    Navigator.pop(context, {
                      'product_id': selectedProduct!.id.toString(),
                      'product_actual_price': price.toStringAsFixed(2),
                      'qty': qty.toInt().toString(),
                      'actual_qty': actualQtyCtrl.text,
                      'discount_type': enableDiscount
                          ? (discountPercentCtrl.text != '0' ? '1' : '2')
                          : '0',
                      'discount_per':
                      enableDiscount ? discountPercentCtrl.text : '0',
                      'discount_rs':
                      enableDiscount ? discountAmountCtrl.text : '0',
                      'total_discount':
                      discountAmount.toStringAsFixed(2),
                      'total_mrp': grossAmount.toStringAsFixed(2),
                      'new_total_mrp': taxableValue.toStringAsFixed(2),
                      'cgst_value': cgstAmount.toStringAsFixed(2),
                      'sgst_value': sgstAmount.toStringAsFixed(2),
                      'igst_value': '0.00',
                      'order_total': orderTotal.toStringAsFixed(2),
                      'lead_product_id': '',
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentSummaryCard({
    required double totalMrp,
    required double discount,
    required double taxableValue,
    required double cgst,
    required double sgst,
    required double orderTotal,
  }) {
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
          _summaryRow(Icons.sell_outlined, 'Total MRP', totalMrp, Colors.green),
          _summaryRow(Icons.local_offer_outlined, 'Total Discount', -discount, Colors.red),
          _summaryRow(Icons.receipt_long_outlined, 'Total Taxable Value', taxableValue, Colors.green),
          _summaryRow(Icons.account_balance_outlined, 'CGST', cgst, Colors.orange),
          _summaryRow(Icons.account_balance_outlined, 'SGST', sgst, Colors.orange),
          Container(
            margin: const EdgeInsets.all(14),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF8F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.payments, color: Colors.green),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('Order Total',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    '₹ ${orderTotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
      IconData icon, String label, double value, Color color) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey.shade600),
              const SizedBox(width: 12),
              Expanded(child: Text(label)),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: color.withOpacity(0.4)),
                ),
                child: Text(
                  '${value >= 0 ? '+' : '-'} ₹ ${value.abs().toStringAsFixed(2)}',
                  style:
                  TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Divider(color: Colors.grey.shade200, height: 1),
      ],
    );
  }
}
