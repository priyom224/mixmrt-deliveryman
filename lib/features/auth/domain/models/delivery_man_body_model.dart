class DeliveryManBodyModel {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? identityType;
  String? identityNumber;
  String? earning;
  String? zoneId;
  String? vehicleId;
  String? dmAddress;
  int? dmPreviousId;
  int? isForResubmit;

  DeliveryManBodyModel({
    this.fName,
    this.lName,
    this.phone,
    this.email,
    this.password,
    this.identityType,
    this.identityNumber,
    this.earning,
    this.zoneId,
    this.vehicleId,
    this.dmAddress,
    this.dmPreviousId,
    this.isForResubmit,
  });

  DeliveryManBodyModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    email = json['email'];
    password = json['password'];
    identityType = json['identity_type'];
    identityNumber = json['identity_number'];
    earning = json['earning'];
    zoneId = json['zone_id'];
    vehicleId = json['vehicle_id'];
    dmAddress = json['dm_address'];
    dmPreviousId = json['dm_previous_id'];
    isForResubmit = json['is_for_resubmit'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['f_name'] = fName!;
    data['l_name'] = lName!;
    data['phone'] = phone!;
    data['email'] = email!;
    data['password'] = password!;
    data['identity_type'] = identityType!;
    data['identity_number'] = identityNumber!;
    data['earning'] = earning!;
    data['zone_id'] = zoneId!;
    data['vehicle_id'] = vehicleId!;
    data['dm_address'] = dmAddress!;
    data['dm_previous_id'] = dmPreviousId.toString();
    data['is_for_resubmit'] = isForResubmit.toString();
    return data;
  }
}