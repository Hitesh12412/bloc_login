import 'package:bloc_login/features/screens/production/bloc/production_list_details/production_list_details_bloc.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_details/production_list_details_event.dart';
import 'package:bloc_login/features/screens/production/bloc/production_list_details/production_list_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductionDetail extends StatelessWidget {
  final int orderId;
  const ProductionDetail({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductionDetailBloc()
        ..add(
          FetchProductionDetailEvent(orderId: orderId),
        ),
      child: ProductionDetailView(orderId: orderId),
    );
  }
}

class ProductionDetailView extends StatefulWidget {
  final orderId;
  const ProductionDetailView({super.key, required this.orderId});

  @override
  State<ProductionDetailView> createState() => _ProductionDetailViewState();
}

class _ProductionDetailViewState extends State<ProductionDetailView> {
  bool isBillingAddressExpanded = false;
  bool isShippingAddressExpanded = false;
  bool isStatusExpanded = false;
  bool isDescriptionExpanded = false;
  bool isProductSummaryExpanded = false;
  bool isBillingDetailsExpanded = false;
  Map<int, bool> productExpansionState = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),),
        title: const Text(
          'View Order',
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
          Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'ID: #000${widget.orderId}',
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: BlocBuilder<ProductionDetailBloc, ProductionDetailStates>(
        builder: (context, state) {
          if (state is LoadingProductionDetailState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LoadedProductionDetailState) {
            final order = state.model.data;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildNonExpandableSection(
                    title: 'Client Details',
                    icon: Icons.person,
                    child: _buildClientDetails(order),
                  ),

                  const SizedBox(height: 16),

                  _buildExpandableSection(
                    title: 'Billing Address',
                    icon: Icons.location_on,
                    isExpanded: isBillingAddressExpanded,
                    onTap: () {
                      setState(() {
                        isBillingAddressExpanded = !isBillingAddressExpanded;
                      });
                    },
                    child: _buildBillingAddress(order),
                  ),

                  const SizedBox(height: 16),

                  _buildExpandableSection(
                    title: 'Shipping Address',
                    icon: Icons.local_shipping,
                    isExpanded: isShippingAddressExpanded,
                    onTap: () {
                      setState(() {
                        isShippingAddressExpanded = !isShippingAddressExpanded;
                      });
                    },
                    child: _buildShippingAddress(order),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.error_outline,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              order.status == 2 ? 'Production' : 'In Progress',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  _buildExpandableSection(
                    title: 'Order Description',
                    icon: Icons.description,
                    isExpanded: isDescriptionExpanded,
                    onTap: () {
                      setState(() {
                        isDescriptionExpanded = !isDescriptionExpanded;
                      });
                    },
                    child: _buildDescriptionSection(order),
                  ),

                  const SizedBox(height: 16),

                  _buildExpandableSection(
                    title: 'Product Summary',
                    icon: Icons.inventory,
                    isExpanded: isProductSummaryExpanded,
                    onTap: () {
                      setState(() {
                        isProductSummaryExpanded = !isProductSummaryExpanded;
                      });
                    },
                    child: _buildProductSummary(order),
                  ),

                  const SizedBox(height: 16),

                  _buildExpandableSection(
                    title: 'Billing Details',
                    icon: Icons.receipt,
                    isExpanded: isBillingDetailsExpanded,
                    onTap: () {
                      setState(() {
                        isBillingDetailsExpanded = !isBillingDetailsExpanded;
                      });
                    },
                    child: _buildBillingDetails(order),
                  ),
                ],
              ),
            );
          } else if (state is FailureProductionDetailState ||
              state is InternalServerErrorProductionDetailState) {
            final error = state is FailureProductionDetailState
                ? (state).error
                : (state as InternalServerErrorProductionDetailState).error;
            return Center(child: Text(error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required IconData icon,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isExpanded ? Radius.zero : const Radius.circular(12),
                  bottomRight: isExpanded ? Radius.zero : const Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.blue.shade800,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.blue.shade800,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.blue.shade800,
                    size: 24,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: child,
            ),
        ],
      ),
    );
  }

  Widget _buildNonExpandableSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.blue.shade800,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }

  Widget _buildClientDetails(dynamic order) {
    return Column(
      children: [
        _buildClientDetailItem(Icons.person, 'Name', order.customerName ?? '-'),
        _buildClientDetailItem(Icons.business, 'Company', '-'),
        _buildClientDetailItem(Icons.phone, 'Phone Number', order.mobileNo ?? '-'),
        _buildClientDetailItem(Icons.message, 'WhatsApp Number', order.whatsappNo ?? '-'),
        _buildClientDetailItem(Icons.email, 'Email', order.email ?? '-'),
        _buildClientDetailItem(Icons.location_on, 'Branch', order.branchName ?? '-'),
      ],
    );
  }

  Widget _buildBillingAddress(dynamic order) {
    return Column(
      children: [
        _buildAddressItem(Icons.home, 'Address', order.billingAddress ?? '-'),
        _buildAddressItem(Icons.public, 'Country', 'India'),
        _buildAddressItem(Icons.map, 'State', 'Gujarat'),
        _buildAddressItem(Icons.location_city, 'City', 'Morbi'),
        _buildAddressItem(Icons.pin_drop, 'Pin Code', order.billingPincode ?? '363641'),
      ],
    );
  }

  Widget _buildShippingAddress(dynamic order) {
    return Column(
      children: [
        _buildAddressItem(Icons.home, 'Address', order.shippingAddress ?? 'Halvad'),
        _buildAddressItem(Icons.public, 'Country', 'India'),
        _buildAddressItem(Icons.map, 'State', 'Gujarat'),
        _buildAddressItem(Icons.location_city, 'City', 'Morbi'),
        _buildAddressItem(Icons.pin_drop, 'Pin Code', order.shippingPincode ?? '363641'),
      ],
    );
  }

  Widget _buildDescriptionSection(dynamic order) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.description, color: Colors.grey.shade600, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Order Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            order.description?.isNotEmpty == true
                ? order.description
                : 'No description available for this order.',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSummary(dynamic order) {
    return Column(
      children: [
        for (int i = 0; i < (order.orderProductList?.length ?? 2); i++)
          _buildProductItem(i, order.orderProductList?[i]),
      ],
    );
  }

  Widget _buildProductItem(int index, dynamic product) {
    bool isExpanded = productExpansionState[index] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade200),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                productExpansionState[index] = !isExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: isExpanded ? Radius.zero : const Radius.circular(12),
                  bottomRight: isExpanded ? Radius.zero : const Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.green.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.inventory,
                      color: Colors.green.shade800,
                      size: 16,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Product ${index + 1}',
                          style: TextStyle(
                            color: Colors.green.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          product?.orderProduct ?? 'New Product',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: Colors.green.shade800,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Column(
                children: [
                  _buildDetailRow('QTY × Price', '${product?.qty ?? 50} × ₹${product?.price ?? '10.00'}'),
                  _buildDetailRow('Subtotal', '₹${product?.totalAmount ?? '500.00'}'),
                  const SizedBox(height: 8),
                  _buildDiscountRow(product?.discountPer ?? '5.0'),
                  const SizedBox(height: 8),
                  _buildTaxRow('GST', '₹${product?.cgstValue ?? '23.76'}'),
                  const SizedBox(height: 12),
                  _buildTotalRow('₹${product?.totalPrice ?? '498.76'}'),
                  const SizedBox(height: 8),
                  _buildSavingsRow('₹${product?.discountRs ?? '25.00'}'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBillingDetails(dynamic order) {
    return Column(
      children: [
        _buildBillingDetailRow(Icons.local_offer, 'Total MRP', '₹${order.totalMrp ?? '1,500.00'}', Colors.green),
        _buildBillingDetailRow(Icons.local_offer, 'Total Discount', '- ₹${order.discountTotal ?? '75.00'}', Colors.red),
        _buildBillingDetailRow(Icons.payments, 'New Total MRP', '₹${order.newTotalMrp ?? '1,425.00'}', Colors.green),
        _buildBillingDetailRow(Icons.account_balance, 'CGST', '+ ₹${order.cgst ?? '35.63'}', Colors.orange),
        _buildBillingDetailRow(Icons.account_balance, 'SGST', '+ ₹${order.sgst ?? '35.63'}', Colors.orange),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Order Total',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '₹${order.orderTotal ?? '1,496.00'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildDiscountRow(String discount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.local_offer, color: Colors.orange.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Discount Applied', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('$discount% Off', style: TextStyle(color: Colors.orange.shade700)),
              ],
            ),
          ),
          Text('- ₹25.00', style: TextStyle(color: Colors.orange.shade700, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTaxRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.receipt, color: Colors.blue.shade700, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
          Text(value, style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Icon(Icons.account_balance_wallet, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('All taxes included', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSavingsRow(String amount) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.savings, color: Colors.orange.shade700, size: 20),
          const SizedBox(width: 8),
          const Expanded(child: Text('You saved:', style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('₹$amount', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildClientDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: Colors.blue.shade700),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value.isNotEmpty ? value : '—',
              style: const TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillingDetailRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade600),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
