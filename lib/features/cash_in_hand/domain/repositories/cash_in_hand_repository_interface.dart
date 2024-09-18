import 'package:get/get_connect/http/src/response/response.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/order/domain/models/offline_method_model.dart';
import 'package:sixam_mart_delivery/interface/repository_interface.dart';

abstract class CashInHandRepositoryInterface implements RepositoryInterface {
  Future<dynamic> makeCollectCashPayment(double amount, String paymentGatewayName);
  Future<dynamic> getWalletProvidedEarningList();
  Future<dynamic> makeWalletAdjustment();
  Future<List<OfflineMethodModel>?> getOfflineMethodList();
  Future<ResponseModel> saveOfflineInfo(String data);
  Future<Response> getOfflineList();
}