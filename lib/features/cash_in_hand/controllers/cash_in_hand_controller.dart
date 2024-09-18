import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart_delivery/api/api_checker.dart';
import 'dart:async';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/services/cash_in_hand_service_interface.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_list_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_method_model.dart';
import 'package:sixam_mart_delivery/features/profile/controllers/profile_controller.dart';

class CashInHandController extends GetxController implements GetxService {
  final CashInHandServiceInterface cashInHandServiceInterface;
  CashInHandController({required this.cashInHandServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Transactions>? _transactions;
  List<Transactions>? get transactions => _transactions;

  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;

  int _paymentIndex = 0;
  int get paymentIndex => _paymentIndex;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  List<Transactions>? _walletProvidedTransactions;
  List<Transactions>? get walletProvidedTransactions => _walletProvidedTransactions;

  List<OfflineMethodModel>? _offlineMethodList;
  int _selectedOfflineBankIndex = 0;
  List<TextEditingController> informationControllerList = [];
  List<FocusNode> informationFocusList = [];
  List<OfflineHistoryListModel>? _offlineHistoryList;
  late List<OfflineHistoryListModel> _allOfflineList;
  double _pendingOffline = 0;
  double _offlineVerified = 0;
  final List<String> _offlineStatusList = ['all', 'pending', 'verified', 'denied'];
  int _filterIndex = 0;

  List<OfflineMethodModel>? get offlineMethodList => _offlineMethodList;
  int get selectedOfflineBankIndex => _selectedOfflineBankIndex;
  List<OfflineHistoryListModel>? get offlineHistoryList => _offlineHistoryList;
  double get pendingOffline => _pendingOffline;
  double get offlineVerified => _offlineVerified;
  int get filterIndex => _filterIndex;
  List<String> get offlineStatusList => _offlineStatusList;



  void selectOfflineBank(int index, {bool canUpdate = true}){
    _selectedOfflineBankIndex = index;
    if(canUpdate) {
      update();
    }
  }

  Future<void> getOfflineMethodList() async{
    List<OfflineMethodModel>? offlineMethodList = await cashInHandServiceInterface.getOfflineMethodList();
    if(offlineMethodList != null) {
      _offlineMethodList = [];
      _offlineMethodList!.addAll(offlineMethodList);
    }
    update();
  }
  void changesMethod({bool canUpdate = true}) {
    List<MethodInformations>? methodInformation = offlineMethodList![selectedOfflineBankIndex].methodInformations!;

    informationControllerList = [];
    informationFocusList = [];

    for(int index=0; index<methodInformation.length; index++) {
      informationControllerList.add(TextEditingController());
      informationFocusList.add(FocusNode());
    }
    if(canUpdate) {
      update();
    }

  }

  Future<bool> saveOfflineInfo(String data) async {
    _isLoading = true;
    bool success = false;
    update();
    ResponseModel response = await cashInHandServiceInterface.saveOfflineInfo(data);
    if (response.isSuccess) {
      success = true;
      _isLoading = false;
      showCustomSnackBar('${response.message}', isError: false);
    }
    _isLoading = false;
    update();
    return success;
  }

  void filterOfflineList(int index) {
    _filterIndex = index;
    _offlineHistoryList = [];
    if(index == 0) {
      _offlineHistoryList!.addAll(_allOfflineList);
    }else {
      for (var offline in _allOfflineList) {
        if(offline.status == _offlineStatusList[index]) {
          _offlineHistoryList!.add(offline);
        }
      }
    }
    update();
  }

  Future<void> getOfflineList() async {
    Response response = await cashInHandServiceInterface.getOfflineList();
    if(response.statusCode == 200) {
      _offlineHistoryList = [];
      _allOfflineList = [];
      _pendingOffline = 0;
      _offlineVerified = 0;
      response.body.forEach((offline) {
        OfflineHistoryListModel offlineListModel = OfflineHistoryListModel.fromJson(offline);
        _offlineHistoryList!.add(offlineListModel);
        _allOfflineList.add(offlineListModel);
        if(offlineListModel.status == 'pending') {
          _pendingOffline = _pendingOffline + offlineListModel.amount!;
        }else if(offlineListModel.status == 'verified') {
          _offlineVerified = _offlineVerified + offlineListModel.amount!;
        }
      });
    }else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName) async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await cashInHandServiceInterface.makeCollectCashPayment(amount, paymentGatewayName);
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> getWalletPaymentList() async {
    _transactions = null;
    List<Transactions>? transactions = await cashInHandServiceInterface.getWalletPaymentList();
    if(transactions != null) {
      _transactions = [];
      _transactions!.addAll(transactions);
    }
    update();
  }

  Future<void> getWalletProvidedEarningList() async {
    _walletProvidedTransactions = null;
    List<Transactions>? walletProvidedTransactions = await cashInHandServiceInterface.getWalletProvidedEarningList();
    if(walletProvidedTransactions != null) {
      _walletProvidedTransactions = [];
      _walletProvidedTransactions!.addAll(walletProvidedTransactions);
    }
    update();
  }

  Future<void> makeWalletAdjustment() async {
    _isLoading = true;
    update();
    ResponseModel responseModel = await cashInHandServiceInterface.makeWalletAdjustment();
    if(responseModel.isSuccess) {
      Get.find<ProfileController>().getProfile();
      Get.back();
      showCustomSnackBar(responseModel.message, isError: false);
    }else{
      Get.back();
      showCustomSnackBar(responseModel.message, isError: true);
    }
    _isLoading = false;
    update();
  }

  void setPaymentIndex(int index){
    _paymentIndex = index;
    update();
  }

  void changeDigitalPaymentName(String? name, {bool canUpdate = true}){
    _digitalPaymentName = name;
    if(canUpdate) {
      update();
    }
  }

  void setIndex(int index) {
    _selectedIndex = index;
    update();
  }

}