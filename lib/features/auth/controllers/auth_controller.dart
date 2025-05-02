import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sixam_mart_delivery/api/api_client.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/account_recovery_model.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/delivery_man_body_model.dart';
import 'package:sixam_mart_delivery/common/models/response_model.dart';
import 'package:sixam_mart_delivery/features/auth/domain/models/vehicle_model.dart';
import 'package:sixam_mart_delivery/features/auth/screens/account_recovery_screen.dart';
import 'package:sixam_mart_delivery/helper/route_helper.dart';
import 'package:sixam_mart_delivery/common/widgets/custom_snackbar_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart_delivery/features/auth/domain/services/auth_service_interface.dart';
import 'package:sixam_mart_delivery/util/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController implements GetxService {
  final AuthServiceInterface authServiceInterface;
  AuthController({required this.authServiceInterface}){
    _notification = authServiceInterface.isNotificationActive();
  }

  bool _isActiveRememberMe = false;
  bool get isActiveRememberMe => _isActiveRememberMe;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool _notification = true;
  bool get notification => _notification;
  
  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;
  
  List<XFile> _pickedIdentities = [];
  List<XFile> get pickedIdentities => _pickedIdentities;

  List<XFile> _pickedProofAddress = [];
  List<XFile> get pickedProofAddress => _pickedProofAddress;
  
  final List<String> _identityTypeList = AppConstants.baseUrl.contains('zm') ? ['nrc', 'driving_license', 'passport'] : ['nid', 'driving_license', 'passport'];
  List<String> get identityTypeList => _identityTypeList;
  
  int _identityTypeIndex = 0;
  int get identityTypeIndex => _identityTypeIndex;
  
  final List<String?> _dmTypeList = ['freelancer', 'salary_based'];
  List<String?> get dmTypeList => _dmTypeList;
  
  int _dmTypeIndex = 0;
  int get dmTypeIndex => _dmTypeIndex;
  
  List<VehicleModel>? _vehicles;
  List<VehicleModel>? get vehicles => _vehicles;
  
  List<int?>? _vehicleIds;
  List<int?>? get vehicleIds => _vehicleIds;
  
  int? _vehicleIndex = 0;
  int? get vehicleIndex => _vehicleIndex;
  
  double _dmStatus = 0.4;
  double get dmStatus => _dmStatus;
  
  bool _lengthCheck = false;
  bool get lengthCheck => _lengthCheck;
  
  bool _numberCheck = false;
  bool get numberCheck => _numberCheck;
  
  bool _uppercaseCheck = false;
  bool get uppercaseCheck => _uppercaseCheck;
  
  bool _lowercaseCheck = false;
  bool get lowercaseCheck => _lowercaseCheck;
  
  bool _spatialCheck = false;
  bool get spatialCheck => _spatialCheck;
  
  bool _showPassView = false;
  bool get showPassView => _showPassView;
  
  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;

  bool _isAgreement = true;
  bool get isAgreement => _isAgreement;

  bool _isPrivacyPolicy = true;
  bool get isPrivacyPolicy => _isPrivacyPolicy;

  XFile? _pickedAgreement;
  XFile? get pickedAgreement => _pickedAgreement;

  bool _notificationLoading = false;
  bool get notificationLoading => _notificationLoading;

  DeliveryMan? _deliveryMan;
  DeliveryMan? get deliveryMan => _deliveryMan;

  void initData() {
    _pickedAgreement = null;
  }

  Future<ResponseModel?> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authServiceInterface.login(phone, password);
    ResponseModel? responseModel;
    if (response.statusCode == 200) {
      authServiceInterface.saveUserToken(response.body['token'], response.body['topic'], response.body['parcel_topic']);
      await authServiceInterface.updateToken();
      responseModel = ResponseModel(true, 'successful');
    }else if(response.statusCode == 420){
      _deliveryMan = DeliveryMan.fromJson(response.body['delivery_man']);
      Get.to(() => const AccountRecoveryScreen());
      responseModel = ResponseModel(false, 'Account Recovery');
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> registerDeliveryMan(DeliveryManBodyModel deliveryManBody) async {
    _isLoading = true;
    update();
    List<MultipartBody> multiParts = authServiceInterface.prepareMultiPartsBody(_pickedImage, _pickedIdentities, _pickedProofAddress);
    bool isSuccess = await authServiceInterface.registerDeliveryMan(deliveryManBody, multiParts);
    if (isSuccess) {
      Get.offAllNamed(RouteHelper.getSignInRoute());
      showCustomSnackBar('delivery_man_registration_successful'.tr, isError: false);
    }
    _isLoading = false;
    update();
  }

  Future<void> getVehicleList() async {
    List<VehicleModel>? vehicles = await authServiceInterface.getVehicleList();
    if (vehicles != null) {
      _vehicles = [];
      _vehicleIds = [];
      _vehicles!.addAll(vehicles);
      _vehicleIds!.addAll(authServiceInterface.vehicleIds(vehicles));
    }
    update();
  }

  void setVehicleIndex(int? index, bool notify) {
    _vehicleIndex = index;
    if(notify) {
      update();
    }
  }

  void setAccRecVehicleIndex(int? id, bool notify) {
    int index0 = 0;
    for(int index=0; index<_vehicles!.length; index++) {
      if(_vehicles?[index].id == id) {
        index0 = index;
        break;
      }
    }
    _vehicleIndex = index0;
    if(notify) {
      update();
    }
  }

  Future<void> updateToken() async {
    await authServiceInterface.updateToken();
  }

  void dmStatusChange(double value, {bool isUpdate = true}){
    _dmStatus = value;
    if(isUpdate) {
      update();
    }
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  void toggleAgreement() {
    _isAgreement = !_isAgreement;
    update();
  }

  void togglePrivacyPolicy() {
    _isPrivacyPolicy = !_isPrivacyPolicy;
    update();
  }

  void toggleRememberMe() {
    _isActiveRememberMe = !_isActiveRememberMe;
    update();
  }

  bool isLoggedIn() {
    return authServiceInterface.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authServiceInterface.clearSharedData();
  }

  void saveUserNumberAndPassword(String number, String password, String countryCode) {
    authServiceInterface.saveUserNumberAndPassword(number, password, countryCode);
  }

  String getUserNumber() {
    return authServiceInterface.getUserNumber();
  }

  String getUserCountryCode() {
    return authServiceInterface.getUserCountryCode();
  }

  String getUserPassword() {
    return authServiceInterface.getUserPassword();
  }

  Future<bool> clearUserNumberAndPassword() async {
    return authServiceInterface.clearUserNumberAndPassword();
  }

  String getUserToken() {
    return authServiceInterface.getUserToken();
  }

  Future<bool> setNotificationActive(bool isActive) async {
    _notificationLoading = true;
    update();
    _notification = isActive;
    authServiceInterface.setNotificationActive(isActive);
    _notificationLoading = false;
    update();
    return _notification;
  }

  void setDMTypeIndex(int dmType, bool notify) {
    _dmTypeIndex = dmType;
    if(notify) {
      update();
    }
  }

  void setIdentityTypeIndex(String? identityType, bool notify) {
    int index0 = 0;
    for(int index=0; index<_identityTypeList.length; index++) {
      if(_identityTypeList[index] == identityType) {
        index0 = index;
        break;
      }
    }
    _identityTypeIndex = index0;
    if(notify) {
      update();
    }
  }

  void pickDmImageForRegistration({bool isLogo = false, bool pickedIdentities = false, bool isRemove = false}) async {
    if(isRemove) {
      _pickedImage = null;
      _pickedIdentities = [];
      _pickedProofAddress = [];
    }else {
      if (isLogo) {
        _pickedImage = await authServiceInterface.pickImageFromGallery();
      } else if(pickedIdentities) {
        XFile? pickedIdentities = await authServiceInterface.pickImageFromGallery();
        if(pickedIdentities != null) {
          _pickedIdentities.add(pickedIdentities);
        }
      }else{
        XFile? pickedProofAddress = await authServiceInterface.pickImageFromGallery();
        if(pickedProofAddress != null) {
          _pickedProofAddress.add(pickedProofAddress);
        }
      }
      update();
    }
  }

  void removeDmImage(){
    _pickedImage = null;
    update();
  }

  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    update();
  }

  void removeProofAddressImage(int index) {
    _pickedProofAddress.removeAt(index);
    update();
  }

  void saveDmImage(String imageUrl) async {
    XFile? xFile = await urlToXFile(imageUrl);
    if(xFile != null) {
      _pickedImage = xFile;
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      update();
    });
  }

  void clearDmImage() {
    _pickedImage = null;
  }

  void saveProofAddressImage(String imageUrl) async {
    XFile? xFile = await urlToXFile(imageUrl);
    if(xFile != null) {
      _pickedProofAddress.add(xFile);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      update();
    });
  }

  void clearProofAddressImage() {
    _pickedProofAddress.clear();
  }

  void saveIdentityImage(String imageUrl) async {
    XFile? xFile = await urlToXFile(imageUrl);
    if(xFile != null) {
      _pickedIdentities.add(xFile);
    }
    Future.delayed(const Duration(milliseconds: 500), () {
      update();
    });
  }

  void clearIdentityImage() {
    _pickedIdentities.clear();
  }

  Future<XFile?> urlToXFile(String imageUrl) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/${imageUrl.split('/').last}';

      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return XFile(filePath);
      } else {
        showCustomSnackBar('${'Failed to download file'.tr} ${response.statusCode}');
        return null;
      }
    } catch (e) {
      showCustomSnackBar('Error occurred while converting URL to XFile: $e');
      return null;
    }
  }

  void showHidePass({bool isUpdate = true}){
    _showPassView = ! _showPassView;
    if(isUpdate) {
      update();
    }
  }

  void validPassCheck(String pass, {bool isUpdate = true}){
    _lengthCheck = false;
    _numberCheck = false;
    _uppercaseCheck = false;
    _lowercaseCheck = false;
    _spatialCheck = false;

    if(pass.length > 7){
      _lengthCheck = true;
    }
    if(pass.contains(RegExp(r'[a-z]'))){
      _lowercaseCheck = true;
    }
    if(pass.contains(RegExp(r'[A-Z]'))){
      _uppercaseCheck = true;
    }
    if(pass.contains(RegExp(r'[ .!@#$&*~^%]'))){
      _spatialCheck = true;
    }
    if(pass.contains(RegExp(r'[\d+]'))){
      _numberCheck = true;
    }
    if(isUpdate) {
      update();
    }
  }

  void pickAgreement() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles( type: FileType.custom, allowedExtensions: ['png','jpg','jpeg','pdf','doc','docx','gif','txt','pptx','xlsx']);
    if (result != null) {
      _pickedAgreement = XFile(result.files.single.path!);
    }
    update();
  }
  
}