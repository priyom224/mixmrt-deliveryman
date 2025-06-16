import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_delivery/features/order/controllers/order_controller.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';

class OrderTransactionScreen extends StatefulWidget {
  const OrderTransactionScreen({super.key});

  @override
  State<OrderTransactionScreen> createState() => _OrderTransactionScreenState();
}

class _OrderTransactionScreenState extends State<OrderTransactionScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<OrderController>().getTransactionReport(dmId: Get.find<ProfileController>().profileModel!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarWidget(title: 'Transactions Report'),
      body: GetBuilder<OrderController>(builder: (orderController) {
        if (orderController.transactionReport == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (orderController.transactionReport!.isEmpty) {
          return Center(
            child: Text(
              'No transactions found',
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          );
        }

        // Calculate total earnings
        double totalEarnings = orderController.transactionReport!.fold(0, (sum, transaction) {
          double originalDeliveryCharge = double.tryParse(transaction.originalDeliveryCharge ?? '0') ?? 0;
          double tips = transaction.dmTips ?? 0;
          return sum + originalDeliveryCharge + tips;
        });

        return Column(
          children: [
            // Summary Card
            Container(
              margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                )],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Transactions',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        orderController.transactionReport!.length.toString(),
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Total Earnings',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor,
                        ),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                      Text(
                        PriceConverterHelper.convertPrice(totalEarnings),
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Transaction List
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                itemCount: orderController.transactionReport?.length,
                itemBuilder: (context, index) {
                  final transaction = orderController.transactionReport![index];
                  double originalDeliveryCharge = double.tryParse(transaction.originalDeliveryCharge ?? '0') ?? 0;
                  double tips = transaction.dmTips ?? 0;
                  double total = originalDeliveryCharge + tips;

                  return Container(
                    margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      boxShadow: [BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      )],
                    ),
                    child: ExpansionTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${transaction.orderId}',
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                            ),
                          ),
                          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                          Text(
                            _formatDate(transaction.createdAt),
                            style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                              color: Theme.of(context).disabledColor,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        PriceConverterHelper.convertPrice(total),
                        style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeSmall,
                          ),
                          child: Column(
                            children: [
                              _buildTransactionDetailRow(
                                context,
                                'Delivery Fee',
                                originalDeliveryCharge.toString(),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              _buildTransactionDetailRow(
                                context,
                                'Tips',
                                tips.toString(),
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              _buildTransactionDetailRow(
                                context,
                                'Total',
                                total.toString(),
                                isTotal: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTransactionDetailRow(BuildContext context, String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal
              ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)
              : robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).disabledColor,
          ),
        ),
        Text(
          PriceConverterHelper.convertPrice(double.tryParse(value) ?? 0),
          style: isTotal
              ? robotoBold.copyWith(
            fontSize: Dimensions.fontSizeDefault,
            color: Theme.of(context).primaryColor,
          )
              : robotoRegular.copyWith(fontSize: Dimensions.fontSizeDefault),
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('MMM dd, yyyy - hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
