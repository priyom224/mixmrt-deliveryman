import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/cash_in_hand/domain/models/wallet_payment_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_method_model.dart';

abstract class CashInHandServiceInterface {
  Future<ResponseModel> makeCollectCashPayment(double amount, String paymentGatewayName);
  Future<List<Transactions>?> getWalletPaymentList();
  Future<List<Transactions>?> getWalletProvidedEarningList();
  Future<ResponseModel> makeWalletAdjustment();
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<ResponseModel> saveOfflineInfo(String data);
  Future<Response> getOfflineList();
}