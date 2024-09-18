import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/repositories/cash_in_hand_repository_interface.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_method_model.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/util/app_constants.dart';

class CashInHandRepository implements CashInHandRepositoryInterface {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CashInHandRepository({required this.apiClient, required this.sharedPreferences});

  @override
  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName) async {
    ResponseModel responseModel;
    Response response = await apiClient.postData(AppConstants.makeCollectedCashPaymentUri, {
      "amount": amount,
      "payment_gateway": paymentGatewayName,
      "callback": RouteHelper.success,
      "token": _getUserToken(),
    }, handleError: false);

    if (response.statusCode == 200) {
      String redirectUrl = response.body['redirect_link'];
      Get.back();
      if(GetPlatform.isWeb) {
        // html.window.open(redirectUrl,"_self");
      } else{
        Get.toNamed(RouteHelper.getPaymentRoute(redirectUrl));
      }
      responseModel = ResponseModel(true, response.body.toString());
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<List<Transactions>?> getList() async {
    List<Transactions>? transactions;
    Response response = await apiClient.getData('${AppConstants.walletPaymentListUri}?token=${_getUserToken()}');
    if(response.statusCode == 200) {
      transactions = [];
      WalletPaymentModel walletPaymentModel = WalletPaymentModel.fromJson(response.body);
      transactions.addAll(walletPaymentModel.transactions!);
    }
    return transactions;
  }

  @override
  Future<List<Transactions>?> getWalletProvidedEarningList() async {
    List<Transactions>? walletProvidedTransactions;
    Response response = await apiClient.getData('${AppConstants.walletProvidedEarningListUri}?token=${_getUserToken()}');
    if(response.statusCode == 200) {
      walletProvidedTransactions = [];
      WalletPaymentModel walletPaymentModel = WalletPaymentModel.fromJson(response.body);
      walletProvidedTransactions.addAll(walletPaymentModel.transactions!);
    }
    return walletProvidedTransactions;
  }

  @override
  Future<ResponseModel> makeWalletAdjustment() async {
    ResponseModel responseModel;
    Response response = await apiClient.postData(AppConstants.makeWalletAdjustmentUri, {'token': _getUserToken()}, handleError: false);
    if(response.statusCode == 200) {
      responseModel = ResponseModel(true, 'wallet_adjustment_successfully'.tr);
    }else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  String _getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? "";
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(int? id) {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body) {
    throw UnimplementedError();
  }

  @override
  Future<List<OfflineMethodModel>?> getOfflineMethodList() async{
    Response response = await apiClient.getData('${AppConstants.offlineMethodListUri}?token=${Get.find<AuthController>().getUserToken()}');
    List<OfflineMethodModel>? offlineMethodList;
    if(response.statusCode == 200) {
      offlineMethodList = [];
      response.body.forEach((method) {
        OfflineMethodModel offlineMethod = OfflineMethodModel.fromJson(method);
        offlineMethodList!.add(offlineMethod);
      });
    }
    return offlineMethodList;
  }

  @override
  Future<ResponseModel> saveOfflineInfo(String data) async{
    Response response = await apiClient.postData(AppConstants.makeCollectedCashPaymentUriOffline, jsonDecode(data),);
    if(response.statusCode == 200){
      return ResponseModel(true, response.body.toString());
    }else{
      return ResponseModel(false, response.statusText);
    }

  }

  @override
  Future<Response> getOfflineList() async{
    return await apiClient.getData('${AppConstants.offlineMethodDeliveryListUri}?token=${Get.find<AuthController>().getUserToken()}');
  }

}