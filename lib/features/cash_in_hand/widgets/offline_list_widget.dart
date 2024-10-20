import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/widgets/transaction_details_bottom_sheet.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_list_model.dart';
import 'package:sixam_mart_delivery/helper/date_converter_helper.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';

class OfflineListWidget extends StatelessWidget {
  final OfflineHistoryListModel offlineListModel;
  final bool showDivider;
  const OfflineListWidget({super.key, required this.offlineListModel, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    return Column(children: [

      InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true, useRootNavigator: true, context: context,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge),
              ),
            ),
            builder: (context) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
                child: TransactionDetailsBottomSheetWidget(offlineListModel: offlineListModel, fromTransaction: false),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
          child: Row(children: [

            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              Text(PriceConverterHelper.convertPrice(offlineListModel.amount), style: robotoMedium),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Text('${'payment_method'.tr} ${offlineListModel.paymentInfo?.methodName}', style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor,
              )),
            ])),
            const SizedBox(width: Dimensions.paddingSizeSmall),

            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [

              Text(
                DateConverterHelper.formatDateTime(offlineListModel.createdAt!),
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
              ),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),

              Text(offlineListModel.status!.tr, style: robotoRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: offlineListModel.status == 'verified' ? Theme.of(context).primaryColor : offlineListModel.status == 'denied'
                    ? Theme.of(context).colorScheme.error : Colors.blue,
              )),

            ]),

          ]),
        ),
      ),

      Divider(color: showDivider ? Theme.of(context).disabledColor : Colors.transparent),

    ]);
  }
}
