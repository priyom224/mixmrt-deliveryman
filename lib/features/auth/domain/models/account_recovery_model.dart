class AccountRecoveryModel {
  List<Errors>? errors;
  DeliveryMan? deliveryMan;

  AccountRecoveryModel({this.errors, this.deliveryMan});

  AccountRecoveryModel.fromJson(Map<String, dynamic> json) {
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
    deliveryMan = json['delivery_man'] != null ? DeliveryMan.fromJson(json['delivery_man']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    if (deliveryMan != null) {
      data['delivery_man'] = deliveryMan!.toJson();
    }
    return data;
  }
}

class Errors {
  String? code;
  String? message;

  Errors({this.code, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}

class DeliveryMan {
  int? id;
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? identityNumber;
  String? identityType;
  String? identityImage;
  String? image;
  int? zoneId;
  String? createdAt;
  String? updatedAt;
  bool? status;
  int? active;
  int? earning;
  int? currentOrders;
  String? type;
  String? applicationStatus;
  int? orderCount;
  int? assignedOrderCount;
  int? vehicleId;
  String? agreementDocument;
  String? collectedCash;
  String? reason;
  String? dmAddress;
  String? dmAddressProof;
  int? dmWithdrawToStoreStatus;
  int? withdrawReqStatus;
  String? imageFullUrl;
  List<String>? identityImageFullUrl;
  List<String>? dmAddressProofFullUrl;

  DeliveryMan({
    this.id,
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.identityNumber,
    this.identityType,
    this.identityImage,
    this.image,
    this.zoneId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.active,
    this.earning,
    this.currentOrders,
    this.type,
    this.applicationStatus,
    this.orderCount,
    this.assignedOrderCount,
    this.vehicleId,
    this.agreementDocument,
    this.collectedCash,
    this.reason,
    this.dmAddress,
    this.dmAddressProof,
    this.dmWithdrawToStoreStatus,
    this.withdrawReqStatus,
    this.imageFullUrl,
    this.identityImageFullUrl,
    this.dmAddressProofFullUrl,
  });

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    identityNumber = json['identity_number'];
    identityType = json['identity_type'];
    identityImage = json['identity_image'];
    image = json['image'];
    zoneId = json['zone_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    active = json['active'];
    earning = json['earning'];
    currentOrders = json['current_orders'];
    type = json['type'];
    applicationStatus = json['application_status'];
    orderCount = json['order_count'];
    assignedOrderCount = json['assigned_order_count'];
    vehicleId = json['vehicle_id'];
    agreementDocument = json['agreement_document'];
    collectedCash = json['collected_cash'];
    reason = json['reason'];
    dmAddress = json['dm_address'];
    dmAddressProof = json['dm_address_proof'];
    dmWithdrawToStoreStatus = json['dm_withdraw_to_store_status'];
    withdrawReqStatus = json['withdraw_req_status'];
    imageFullUrl = json['image_full_url'];
    identityImageFullUrl = json['identity_image_full_url'].cast<String>();
    dmAddressProofFullUrl = json['dm_address_proof_full_url'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['l_name'] = lName;
    data['phone'] = phone;
    data['email'] = email;
    data['identity_number'] = identityNumber;
    data['identity_type'] = identityType;
    data['identity_image'] = identityImage;
    data['image'] = image;
    data['zone_id'] = zoneId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['status'] = status;
    data['active'] = active;
    data['earning'] = earning;
    data['current_orders'] = currentOrders;
    data['type'] = type;
    data['application_status'] = applicationStatus;
    data['order_count'] = orderCount;
    data['assigned_order_count'] = assignedOrderCount;
    data['vehicle_id'] = vehicleId;
    data['agreement_document'] = agreementDocument;
    data['collected_cash'] = collectedCash;
    data['reason'] = reason;
    data['dm_address'] = dmAddress;
    data['dm_address_proof'] = dmAddressProof;
    data['dm_withdraw_to_store_status'] = dmWithdrawToStoreStatus;
    data['withdraw_req_status'] = withdrawReqStatus;
    data['image_full_url'] = imageFullUrl;
    data['identity_image_full_url'] = identityImageFullUrl;
    data['dm_address_proof_full_url'] = dmAddressProofFullUrl;
    return data;
  }
}
