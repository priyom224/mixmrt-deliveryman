class TransactionReportModel {
  OrderTransactions? orderTransactions;

  TransactionReportModel({this.orderTransactions});

  TransactionReportModel.fromJson(Map<String, dynamic> json) {
    orderTransactions = json['order_transactions'] != null ? OrderTransactions.fromJson(json['order_transactions']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderTransactions != null) {
      data['order_transactions'] = orderTransactions!.toJson();
    }
    return data;
  }
}

class OrderTransactions {
  List<Transaction>? data;

  OrderTransactions({this.data});

  OrderTransactions.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Transaction>[];
      json['data'].forEach((v) {
        data!.add(Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int? orderId;
  String? createdAt;
  String? updatedAt;
  String? deliveryCharge;
  String? originalDeliveryCharge;
  double? dmTips;

  Transaction({
    this.orderId,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.originalDeliveryCharge,
    this.dmTips,
  });

  Transaction.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryCharge = json['delivery_charge'];
    originalDeliveryCharge = json['original_delivery_charge'];
    dmTips = json['dm_tips'] != null ? double.tryParse(json['dm_tips'].toString()) : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['delivery_charge'] = deliveryCharge;
    data['original_delivery_charge'] = originalDeliveryCharge;
    data['dm_tips'] = dmTips;
    return data;
  }
}
