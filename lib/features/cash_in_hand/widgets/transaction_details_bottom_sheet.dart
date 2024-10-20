import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_list_model.dart';
import 'package:sixam_mart_delivery/helper/date_converter_helper.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';

class TransactionDetailsBottomSheetWidget extends StatelessWidget {
  final Transactions? transactions;
  final OfflineHistoryListModel? offlineListModel;
  final bool fromTransaction;

  const TransactionDetailsBottomSheetWidget({super.key, this.transactions, this.offlineListModel, this.fromTransaction = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusExtraLarge),
          topRight: Radius.circular(Dimensions.radiusExtraLarge),
        ),
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [

        Container(
          width: double.infinity,
          color: Theme.of(context).disabledColor.withOpacity(0.1),
          child: Column(children: [

            const SizedBox(height: Dimensions.paddingSizeLarge),

            Container(
              height: 5, width: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('transaction_details'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.6))),
              ]),
            ),

          ]),
        ),

        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: fromTransaction ? Column(mainAxisSize: MainAxisSize.min, children: [

                Row(children: [
                  Expanded(child: Text('transaction_id'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions!.id.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_amount'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(PriceConverterHelper.convertPrice(transactions!.amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('payment_method'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.method?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_status'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.status?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_ref'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.ref?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_time'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.paymentTime ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                transactions?.type != null ? Row(children: [
                  Expanded(child: Text('transaction_type'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.type?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]) : const SizedBox(),
                SizedBox(height: transactions?.type != null ? Dimensions.paddingSizeDefault : 0),

                transactions?.createdBy != null ? Row(children: [
                  Expanded(child: Text('created_by'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(transactions?.createdBy?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]) : const SizedBox(),
                SizedBox(height: transactions?.createdBy != null ? Dimensions.paddingSizeDefault : 0),

              ]) : Column(mainAxisSize: MainAxisSize.min, children: [

                Row(children: [
                  Expanded(child: Text('transaction_id'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(offlineListModel!.id.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_amount'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(PriceConverterHelper.convertPrice(offlineListModel!.amount), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('payment_method'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(offlineListModel?.paymentInfo?.methodName?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_status'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(offlineListModel?.status?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_note'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(offlineListModel?.note?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                Row(children: [
                  Expanded(child: Text('transaction_time'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(DateConverterHelper.formatDateTime(offlineListModel!.createdAt!), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]),
                const SizedBox(height: Dimensions.paddingSizeDefault),

                offlineListModel?.type != null ? Row(children: [
                  Expanded(child: Text('transaction_type'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                  const Padding(padding: EdgeInsets.only(right: 5), child: Text(':')),
                  Expanded(child: Text(offlineListModel?.type?.replaceAll('_', ' ').capitalize ?? '', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                ]) : const SizedBox(),
                SizedBox(height: offlineListModel?.type != null ? Dimensions.paddingSizeDefault : 0),

              ]),
            ),
          ),
        ),

      ]),
    );
  }
}