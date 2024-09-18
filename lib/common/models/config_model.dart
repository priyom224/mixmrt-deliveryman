class ConfigModel {
  String? businessName;
  String? logo;
  String? address;
  String? phone;
  String? email;
  String? country;
  DefaultLocation? defaultLocation;
  String? currencySymbol;
  String? currencySymbolDirection;
  double? appMinimumVersionAndroid;
  String? appUrlAndroid;
  double? appMinimumVersionIos;
  String? appUrlIos;
  bool? customerVerification;
  bool? scheduleOrder;
  bool? orderDeliveryVerification;
  bool? cashOnDelivery;
  bool? digitalPayment;
  double? perKmShippingCharge;
  double? minimumShippingCharge;
  double? freeDeliveryOver;
  bool? demo;
  bool? maintenanceMode;
  String? orderConfirmationModel;
  bool? showDmEarning;
  bool? canceledByDeliveryman;
  String? timeformat;
  List<Language>? language;
  bool? toggleVegNonVeg;
  bool? toggleDmRegistration;
  bool? toggleStoreRegistration;
  int? scheduleOrderSlotDuration;
  int? digitAfterDecimalPoint;
  double? parcelPerKmShippingCharge;
  double? parcelMinimumShippingCharge;
  ModuleConfig? moduleConfig;
  bool? dmPictureUploadStatus;
  String? additionalChargeName;
  bool? webSocketStatus;
  String? webSocketUri;
  int? webSocketPort;
  String? webSocketKey;
  String? disbursementType;
  List<PaymentBody>? activePaymentMethodList;
  double? minAmountToPayDm;
  bool? deliveryAgreement;

  ConfigModel({
    this.businessName,
    this.logo,
    this.address,
    this.phone,
    this.email,
    this.country,
    this.defaultLocation,
    this.currencySymbol,
    this.currencySymbolDirection,
    this.appMinimumVersionAndroid,
    this.appUrlAndroid,
    this.appMinimumVersionIos,
    this.appUrlIos,
    this.customerVerification,
    this.scheduleOrder,
    this.orderDeliveryVerification,
    this.cashOnDelivery,
    this.digitalPayment,
    this.perKmShippingCharge,
    this.minimumShippingCharge,
    this.freeDeliveryOver,
    this.demo,
    this.maintenanceMode,
    this.orderConfirmationModel,
    this.showDmEarning,
    this.canceledByDeliveryman,
    this.timeformat,
    this.language,
    this.toggleVegNonVeg,
    this.toggleDmRegistration,
    this.toggleStoreRegistration,
    this.scheduleOrderSlotDuration,
    this.digitAfterDecimalPoint,
    this.moduleConfig,
    this.parcelPerKmShippingCharge,
    this.parcelMinimumShippingCharge,
    this.dmPictureUploadStatus,
    this.additionalChargeName,
    this.webSocketUri,
    this.webSocketPort,
    this.webSocketKey,
    this.webSocketStatus,
    this.disbursementType,
    this.activePaymentMethodList,
    this.minAmountToPayDm,
    this.deliveryAgreement,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    logo = json['logo'];
    address = json['address'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    defaultLocation = json['default_location'] != null ? DefaultLocation.fromJson(json['default_location']) : null;
    currencySymbol = json['currency_symbol'];
    currencySymbolDirection = json['currency_symbol_direction'];
    appMinimumVersionAndroid =
        json['app_minimum_version_android_deliveryman'] != null ? json['app_minimum_version_android_deliveryman']?.toDouble() : 0.0;
    appUrlAndroid = json['app_url_android_deliveryman'];
    appMinimumVersionIos = json['app_minimum_version_ios_deliveryman'] != null ? json['app_minimum_version_ios_deliveryman']?.toDouble() : 0.0;
    appUrlIos = json['app_url_ios_deliveryman'];
    customerVerification = json['customer_verification'];
    scheduleOrder = json['schedule_order'];
    orderDeliveryVerification = json['order_delivery_verification'];
    cashOnDelivery = json['cash_on_delivery'];
    digitalPayment = json['digital_payment'];
    perKmShippingCharge = json['per_km_shipping_charge']?.toDouble();
    minimumShippingCharge = json['minimum_shipping_charge']?.toDouble();
    freeDeliveryOver = json['free_delivery_over'] != null ? json['free_delivery_over']?.toDouble() : 0.0;
    demo = json['demo'];
    maintenanceMode = json['maintenance_mode'];
    orderConfirmationModel = json['order_confirmation_model'];
    showDmEarning = json['show_dm_earning'];
    canceledByDeliveryman = json['canceled_by_deliveryman'];
    timeformat = json['timeformat'];
    if (json['language'] != null) {
      language = <Language>[];
      json['language'].forEach((v) {
        language!.add(Language.fromJson(v));
      });
    }
    toggleVegNonVeg = json['toggle_veg_non_veg'];
    toggleDmRegistration = json['toggle_dm_registration'];
    toggleStoreRegistration = json['toggle_store_registration'];
    scheduleOrderSlotDuration = json['schedule_order_slot_duration'] == 0 ? 30 : json['schedule_order_slot_duration'];
    digitAfterDecimalPoint = json['digit_after_decimal_point'];
    moduleConfig = json['module_config'] != null ? ModuleConfig.fromJson(json['module_config']) : null;
    parcelPerKmShippingCharge = json['parcel_per_km_shipping_charge']?.toDouble();
    parcelMinimumShippingCharge = json['parcel_minimum_shipping_charge']?.toDouble();
    dmPictureUploadStatus = json['dm_picture_upload_status'] == 1 ? true : false;
    additionalChargeName = json['additional_charge_name'];
    webSocketUri = json['websocket_url'];
    webSocketPort = json['websocket_port'];
    webSocketKey = json['websocket_key'];
    webSocketStatus = json['websocket_status'] == 1;
    disbursementType = json['disbursement_type'];
    if (json['active_payment_method_list'] != null) {
      activePaymentMethodList = <PaymentBody>[];
      json['active_payment_method_list'].forEach((v) {
        activePaymentMethodList!.add(PaymentBody.fromJson(v));
      });
    }
    minAmountToPayDm = json['min_amount_to_pay_dm']?.toDouble();
    deliveryAgreement = json['dm_agreement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['logo'] = logo;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    if (defaultLocation != null) {
      data['default_location'] = defaultLocation!.toJson();
    }
    data['currency_symbol'] = currencySymbol;
    data['currency_symbol_direction'] = currencySymbolDirection;
    data['app_minimum_version_android'] = appMinimumVersionAndroid;
    data['app_url_android'] = appUrlAndroid;
    data['app_minimum_version_ios'] = appMinimumVersionIos;
    data['app_url_ios'] = appUrlIos;
    data['customer_verification'] = customerVerification;
    data['schedule_order'] = scheduleOrder;
    data['order_delivery_verification'] = orderDeliveryVerification;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['free_delivery_over'] = freeDeliveryOver;
    data['demo'] = demo;
    data['maintenance_mode'] = maintenanceMode;
    data['order_confirmation_model'] = orderConfirmationModel;
    data['show_dm_earning'] = showDmEarning;
    data['canceled_by_deliveryman'] = canceledByDeliveryman;
    data['timeformat'] = timeformat;
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    data['toggle_veg_non_veg'] = toggleVegNonVeg;
    data['toggle_dm_registration'] = toggleDmRegistration;
    data['toggle_store_registration'] = toggleStoreRegistration;
    data['schedule_order_slot_duration'] = scheduleOrderSlotDuration;
    data['digit_after_decimal_point'] = digitAfterDecimalPoint;
    if (moduleConfig != null) {
      data['module_config'] = moduleConfig!.toJson();
    }
    data['parcel_per_km_shipping_charge'] = parcelPerKmShippingCharge;
    data['parcel_minimum_shipping_charge'] = parcelMinimumShippingCharge;
    data['dm_picture_upload_status'] = dmPictureUploadStatus;
    data['additional_charge_name'] = additionalChargeName;
    data['websocket_url'] = webSocketUri;
    data['websocket_port'] = webSocketPort;
    data['websocket_key'] = webSocketKey;
    data['websocket_status'] = webSocketStatus;
    data['disbursement_type'] = disbursementType;
    if (activePaymentMethodList != null) {
      data['active_payment_method_list'] = activePaymentMethodList!.map((v) => v.toJson()).toList();
    }
    data['min_amount_to_pay_dm'] = minAmountToPayDm;
    data['dm_agreement'] = deliveryAgreement;
    return data;
  }
}

class DefaultLocation {
  String? lat;
  String? lng;

  DefaultLocation({this.lat, this.lng});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Language {
  String? key;
  String? value;

  Language({this.key, this.value});

  Language.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class ModuleConfig {
  List<String>? moduleType;
  Module? module;

  ModuleConfig({this.moduleType, this.module});

  ModuleConfig.fromJson(Map<String, dynamic> json) {
    moduleType = json['module_type'].cast<String>();
    module = json[moduleType![0]] != null ? Module.fromJson(json[moduleType![0]]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module_type'] = moduleType;
    if (module != null) {
      data[moduleType![0]] = module!.toJson();
    }
    return data;
  }
}

class Module {
  OrderStatus? orderStatus;
  bool? orderPlaceToScheduleInterval;
  bool? addOn;
  bool? stock;
  bool? vegNonVeg;
  bool? unit;
  bool? orderAttachment;
  bool? showRestaurantText;
  bool? isParcel;
  bool? newVariation;

  Module({
    this.orderStatus,
    this.orderPlaceToScheduleInterval,
    this.addOn,
    this.stock,
    this.vegNonVeg,
    this.unit,
    this.orderAttachment,
    this.showRestaurantText,
    this.isParcel,
    this.newVariation,
  });

  Module.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'] != null ? OrderStatus.fromJson(json['order_status']) : null;
    orderPlaceToScheduleInterval = json['order_place_to_schedule_interval'];
    addOn = json['add_on'];
    stock = json['stock'];
    vegNonVeg = json['veg_non_veg'];
    unit = json['unit'];
    orderAttachment = json['order_attachment'];
    showRestaurantText = json['show_restaurant_text'];
    isParcel = json['is_parcel'];
    newVariation = json['new_variation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderStatus != null) {
      data['order_status'] = orderStatus!.toJson();
    }
    data['order_place_to_schedule_interval'] = orderPlaceToScheduleInterval;
    data['add_on'] = addOn;
    data['stock'] = stock;
    data['veg_non_veg'] = vegNonVeg;
    data['unit'] = unit;
    data['order_attachment'] = orderAttachment;
    data['show_restaurant_text'] = showRestaurantText;
    data['is_parcel'] = isParcel;
    data['new_variation'] = newVariation;
    return data;
  }
}

class OrderStatus {
  bool? accepted;

  OrderStatus({this.accepted});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accepted'] = accepted;
    return data;
  }
}

class PaymentBody {
  String? getWay;
  String? getWayTitle;
  String? getWayImageFullUrl;
  String? storageType;

  PaymentBody({
    this.getWay,
    this.getWayTitle,
    this.getWayImageFullUrl,
    this.storageType,
  });

  PaymentBody.fromJson(Map<String, dynamic> json) {
    getWay = json['gateway'];
    getWayTitle = json['gateway_title'];
    getWayImageFullUrl = json['gateway_image_full_url'];
    storageType = json['storage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway'] = getWay;
    data['gateway_title'] = getWayTitle;
    data['gateway_image_full_url'] = getWayImageFullUrl;
    data['storage'] = storageType;
    return data;
  }
}
