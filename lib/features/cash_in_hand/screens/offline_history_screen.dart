
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/widgets/offline_list_widget.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/styles.dart';

class OfflineHistoryScreen extends StatefulWidget {
  final bool fromNotification;
  const OfflineHistoryScreen({super.key, required this.fromNotification});

  @override
  State<OfflineHistoryScreen> createState() => _OfflineHistoryScreenState();
}

class _OfflineHistoryScreenState extends State<OfflineHistoryScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CashInHandController>().getOfflineList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        if(widget.fromNotification) {
          Get.offAllNamed(RouteHelper.getInitialRoute());
          return true;
        } else {
          Get.back();
          return true;
        }
      },
      child: Scaffold(

        appBar: CustomAppBarWidget(title: 'offline_history'.tr, menuWidget: PopupMenuButton(
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              getMenuItem(Get.find<CashInHandController>().offlineStatusList[0], context),
              const PopupMenuDivider(),
              getMenuItem(Get.find<CashInHandController>().offlineStatusList[1], context),
              const PopupMenuDivider(),
              getMenuItem(Get.find<CashInHandController>().offlineStatusList[2], context),
              const PopupMenuDivider(),
              getMenuItem(Get.find<CashInHandController>().offlineStatusList[3], context),
            ];
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
          offset: const Offset(-25, 25),
          child: Container(
            width: 40, height: 40,
            margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).disabledColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            ),
            child: const Icon(Icons.arrow_drop_down, size: 30),
          ),
          onSelected: (dynamic value) {
            int index = Get.find<CashInHandController>().offlineStatusList.indexOf(value);
            Get.find<CashInHandController>().filterOfflineList(index);
          },
        )),

        body: GetBuilder<CashInHandController>(builder: (CashInHandController) {
          return CashInHandController.offlineHistoryList!.isNotEmpty ? ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: CashInHandController.offlineHistoryList!.length,
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            itemBuilder: (context, index) {
              return OfflineListWidget(
                offlineListModel: CashInHandController.offlineHistoryList![index],
                showDivider: index != CashInHandController.offlineHistoryList!.length - 1,
              );
            },
          ) : Center(child: Text('no_history_found'.tr));
        }),

      ),
    );
  }

  PopupMenuItem getMenuItem(String status, BuildContext context) {
    return PopupMenuItem(
      value: status,
      height: 30,
      child: Text(status.toLowerCase().tr, style: robotoRegular.copyWith(
        color: status == 'Pending' ? Theme.of(context).primaryColor : status == 'Approved' ? Colors.green
            : status == 'Denied' ? Colors.red : null,
      )),
    );
  }
}
