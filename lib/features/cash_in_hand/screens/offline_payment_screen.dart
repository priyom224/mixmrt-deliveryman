import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_app_bar_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_button_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_text_field_widget.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/controllers/cash_in_hand_controller.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_method_model.dart';
import 'package:sixam_mart_delivery/helper/price_converter_helper.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/dimensions.dart';
import 'package:sixam_mart_delivery/util/images.dart';
import 'package:sixam_mart_delivery/util/styles.dart';


class OfflinePaymentScreen extends StatefulWidget {
  final double total;

  const OfflinePaymentScreen({
    super.key, required this.total,});

  @override
  State<OfflinePaymentScreen> createState() => _OfflinePaymentScreenState();
}

class _OfflinePaymentScreenState extends State<OfflinePaymentScreen> {
  PageController pageController = PageController(viewportFraction: 0.85, initialPage: Get.find<CashInHandController>().selectedOfflineBankIndex);
  final FocusNode _customerNoteNode = FocusNode();

  @override
  void initState() {
    super.initState();

    initCall();
  }

  Future<void> initCall() async {
    if(Get.find<CashInHandController>().offlineMethodList == null){
      await Get.find<CashInHandController>().getOfflineMethodList();
    }
    Get.find<CashInHandController>().informationControllerList = [];
    Get.find<CashInHandController>().informationFocusList = [];
    if(Get.find<CashInHandController>().offlineMethodList != null && Get.find<CashInHandController>().offlineMethodList!.isNotEmpty) {
      for(int index=0; index<Get.find<CashInHandController>().offlineMethodList![Get.find<CashInHandController>().selectedOfflineBankIndex].methodInformations!.length; index++) {
        Get.find<CashInHandController>().informationControllerList.add(TextEditingController());
        Get.find<CashInHandController>().informationFocusList.add(FocusNode());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'offline_payment'.tr),
      body: SafeArea(
        child: GetBuilder<CashInHandController>(
            builder: (CashInHandController) {
              List<MethodInformations>? methodInformation = CashInHandController.offlineMethodList != null ? CashInHandController.offlineMethodList![CashInHandController.selectedOfflineBankIndex].methodInformations! : [];

              return CashInHandController.offlineMethodList != null ? Column(children: [
                Expanded(child: SingleChildScrollView(
                  child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      Image.asset(Images.offlinePayment, height: 100),
                      const SizedBox(height: Dimensions.paddingSizeDefault),

                      Text('pay_your_bill_using_the_info'.tr, textAlign: TextAlign.center, style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodySmall?.color,
                      )),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      SizedBox(
                        height: 170,
                        child: PageView.builder(
                            onPageChanged: (int pageIndex) {
                              CashInHandController.selectOfflineBank(pageIndex);
                              CashInHandController.changesMethod();
                            },
                            scrollDirection: Axis.horizontal,
                            controller: pageController,
                            itemCount: CashInHandController.offlineMethodList!.length,
                            itemBuilder: (context, index) {
                              bool selected = CashInHandController.selectedOfflineBankIndex == index;
                              return bankCard(context, CashInHandController.offlineMethodList, index, selected);
                            }),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeLarge),

                      Text(
                        '${'amount'.tr} '' ${PriceConverterHelper.convertPrice(widget.total)}',
                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                      ),
                      const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'payment_info'.tr,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                            ),
                          ),

                          ListView.builder(
                            itemCount: CashInHandController.informationControllerList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                                child: CustomTextFieldWidget(
                                  hintText: methodInformation[i].customerPlaceholder!,
                                  controller: CashInHandController.informationControllerList[i],
                                  focusNode: CashInHandController.informationFocusList[i],
                                  nextFocus: i != CashInHandController.informationControllerList.length-1 ? CashInHandController.informationFocusList[i+1] : _customerNoteNode,
                                  showTitle: true,
                                ),
                              );
                            },
                          ),

                        ]),
                      ),


                    ]),
                  ),
                )),

                completeButton(CashInHandController, methodInformation)


              ]) : const Center(child: CircularProgressIndicator());
            }
        ),
      ),
    );
  }

  Widget completeButton(CashInHandController CashInHandController, List<MethodInformations>? methodInformation, ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
      child: CustomButtonWidget(
        buttonText: 'complete'.tr,
        isLoading: CashInHandController.isLoading,
        onPressed: () async {
          bool complete = false;
          String text = '';
          for(int i=0; i<methodInformation!.length; i++){
            if(methodInformation[i].isRequired!) {
              if(CashInHandController.informationControllerList[i].text.isEmpty){
                complete = false;
                text = methodInformation[i].customerPlaceholder!;
                break;
              } else {
                complete = true;
              }
            } else {
              complete = true;
            }
          }

          if(complete) {
            String methodId = CashInHandController.offlineMethodList![CashInHandController.selectedOfflineBankIndex].id.toString();


            Map<String, String> data = {
              "method_id": methodId,
              "amount": widget.total.toString(),
              "token" : Get.find<AuthController>().getUserToken(),
            };

            for(int i=0; i<methodInformation.length; i++){
              data.addAll({
                methodInformation[i].customerInput! : CashInHandController.informationControllerList[i].text,
              });
            }

            CashInHandController.saveOfflineInfo(jsonEncode(data)).then((success) {
              if(success){
                Get.offAllNamed(RouteHelper.getInitialRoute());
              }
            });



          } else {
            showCustomSnackBar(text);
          }
        },
      ),
    );
  }

  Widget bankCard(BuildContext context, List<OfflineMethodModel>? offlineMethodList, int index, bool selected) {
    return Container(
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).cardColor : Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        boxShadow: selected ? const [BoxShadow(color: Colors.black12, blurRadius: 10)] : [],
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('bank_info'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
          const Spacer(),

          selected ? Row(children: [
            Text('pay_on_this_account'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),),
            Icon(Icons.check_circle_rounded, size: 20, color: Theme.of(context).primaryColor),
          ]) : const SizedBox(),
        ]),
        const SizedBox(height: Dimensions.paddingSizeSmall),

        ListView.builder(
            itemCount: offlineMethodList![index].methodFields!.length,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                child: Row(children: [
                  Text(
                    '${offlineMethodList[index].methodFields![i].inputName!.toString().replaceAll('_', ' ')} : ',
                    style: robotoMedium.copyWith(color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(0.5)),
                  ),
                  Text(offlineMethodList[index].methodFields![i].inputData!, style: robotoMedium),
                ]),
              );
            })


      ]),
    );
  }
}
