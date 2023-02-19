import 'dart:async';

import 'package:dio/dio.dart';
import 'package:listar_flutter_pro/api/http_manager.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class Api {
  static final httpManager = HTTPManager();

  //++++++++++++++++++++++ URL API Endpoints ++++++++++++++++++++//

  // New API Endpoint
  static const String login = "/api/login";
  static const String register = "/api/register";
  static const String newHome = "/api/dashboard";
  static const String addBooking = "/api/addbooking";
  static const String saveProduct = "/api/savePlace";
  static const String saveWishList = "/api/saveWishlist";
  static const String getWishList = "/api/getWishlist";
  static const String clearWishList = "/api/resetWishlist";
  static const String removeWishList = "/api/removeWishlist";
  static const String bookingList = "/api/listBooking";
  static const String list = "/api/listPlaces";
  static const String bookingDetail = "/api/viewBooking";
  static const String bookingForm = "/api/requestBookingForm";
  static const String calcPrice = "/api/addToCart";
  static const String submitSetting = '/api/placeForm';
  static const String product = '/api/viewPlace';
  static const String tags = "/api/tags";
  static const String bookingCancel = "/api/cancelBooking";
  static const String forgotPassword = "/api/forgotPassword";
  static const String deleteProduct = "/api/deletePlace";



  //  Old Api Endpoints
  static const String changePassword = "/wp/v2/users/me";
  static const String changeProfile = "/wp/v2/users/me";
  static const String setting = "/listar/v1/setting/init";
  static const String categories = "/listar/v1/category/list";
  static const String discovery = "/listar/v1/category/list_discover";
  static const String authorList = "/listar/v1/author/listing";
  static const String authorReview = "/listar/v1/author/comments";
  static const String comments = "/listar/v1/comments";
  static const String saveComment = "/wp/v2/comments";

  static const String uploadImage = "/wp/v2/media";
  static const String locations = "/listar/v1/location/list";
  
  // static const String deleteProduct = "/listar/v1/place/delete";
  // static const String user = "/listar/v1/auth/user";
  // static const String forgotPassword = "/listar/v1/auth/reset_password";
  // static const String bookingCancel = "/listar/v1/booking/cancel_by_id";
  // static const String tags = "/listar/v1/place/terms";
  // static const String home = "/listar/v1/home/init";
  // static const String submitSetting = "/listar/v1/place/form";
  // static const String product = "/listar/v1/place/view";
  // static const String saveProduct = "/listar/v1/place/save";
  // static const String removeWishList = "/listar/v1/wishlist/remove";
  // static const String list = "/listar/v1/place/list";
  // static const String bookingForm = "/listar/v1/booking/form";
  // static const String authValidate = "/jwt-auth/v1/token/validate";
  // static const String oldlogin = "/jwt-auth/v1/token";
  // static const String oldRegister = "/listar/v1/auth/register";
  // static const String withLists = "/listar/v1/wishlist/list";
  // static const String addWishList = "/listar/v1/wishlist/save";
  // static const String clearWishList = "/listar/v1/wishlist/reset";
  // static const String calcPrice = "/listar/v1/booking/cart";
  // static const String order = "/listar/v1/booking/order";
  // static const String bookingDetail = "/listar/v1/booking/view";
  // static const String bookingList = "/listar/v1/booking/list";

  ///Login api
  static Future<ResultApiModel> requestLogin(params) async {
    final result = await httpManager.post(url: login, data: params);
    return ResultApiModel.fromJson(result);
  }


  ///Forgot password
  static Future<ResultApiModel> requestForgotPassword(params) async {
    Map<String, dynamic> result = await httpManager.post(
      url: forgotPassword,
      data: params,
      loading: true,
    );
    result['message'] = result['code'] ?? result['msg'];
    return ResultApiModel.fromJson(result);
  }

  ///Register account
  static Future<ResultApiModel> requestRegister(params) async {
    final result = await httpManager.post(
      url: register,
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['code'] == 200,
      "message": result['message'],
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Change Profile
  static Future<ResultApiModel> requestChangeProfile(params) async {
    final result = await httpManager.postOldDomain(
      url: changeProfile,
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['code'] == null,
      "message": result['code'] ?? "update_info_success",
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///change password
  static Future<ResultApiModel> requestChangePassword(params) async {
    final result = await httpManager.postOldDomain(
      url: changePassword,
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['code'] == null,
      "message": result['code'] ?? "change_password_success",
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }


  ///Get Setting
  static Future<ResultApiModel> requestSetting() async {
    final result = await httpManager.getTestingDomain(url: setting);
    return ResultApiModel.fromJson(result);
  }

  ///Get Submit Setting
  static Future<ResultApiModel> requestSubmitSetting(params) async {
    final result = await httpManager.post(
      url: submitSetting,
    );
    final convertResponse = {
      "success": result['data']['countries'] != null,
      "data": result['data']
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Get Area
  static Future<ResultApiModel> requestLocation(params) async {
    final result =
        await httpManager.getTestingDomain(url: locations, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Get Category
  static Future<ResultApiModel> requestCategory() async {
    final result = await httpManager.getOldDomain(url: categories);
    return ResultApiModel.fromJson(result);
  }

  ///Get Discovery
  static Future<ResultApiModel> requestDiscovery() async {
    // final result = await httpManager.get(url: discovery);
    final result = await httpManager.getTestingDomain(url: discovery);
    return ResultApiModel.fromJson(result);
  }

  ///Get Home
  static Future<ResultApiModel> requestHome() async {
    final result = await httpManager.get(url: newHome);
    return ResultApiModel.fromJson(result);
  }

  ///Get ProductDetail
  static Future<ResultApiModel> requestProduct(params) async {
    final result = await httpManager.post(
      url: product,
      data: params,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Wish List
  static Future<ResultApiModel> requestWishList(params) async {
    final result = await httpManager.post(
        url: getWishList, data: FormData.fromMap(params));
    return ResultApiModel.fromJson(result);
  }

  ///Save Wish List
  static Future<ResultApiModel> requestAddWishList(params) async {
    final result = await httpManager.post(url: saveWishList, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Product
  static Future<ResultApiModel> requestSaveProduct(params) async {
    final result = await httpManager.post(
      url: saveProduct,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Remove Wish List
  static Future<ResultApiModel> requestRemoveWishList(params) async {
    final result = await httpManager.post(
      url: removeWishList,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Clear Wish List
  static Future<ResultApiModel> requestClearWishList(params) async {
    final result =
        await httpManager.post(url: clearWishList, data: params, loading: true);
    return ResultApiModel.fromJson(result);
  }

  ///Get Product List
  static Future<ResultApiModel> requestList(params) async {
    final result = await httpManager.post(
      url: list,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Tags List
  static Future<ResultApiModel> requestTags(params) async {
    final result = await httpManager.post(url: tags);
    return ResultApiModel.fromJson(result);
  }

  ///Clear Wish List
  static Future<ResultApiModel> requestDeleteProduct(params) async {
    final result = await httpManager.post(
      url: deleteProduct,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Author Product List
  static Future<ResultApiModel> requestAuthorList(params) async {
    final result = await httpManager.getTestingDomain(
      url: authorList,
      params: params,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Author Review List
  static Future<ResultApiModel> requestAuthorReview(params) async {
    final result = await httpManager.getTestingDomain(
      url: authorReview,
      params: params,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Review
  static Future<ResultApiModel> requestReview(params) async {
    final result =
        await httpManager.getTestingDomain(url: comments, params: params);
    return ResultApiModel.fromJson(result);
  }

  ///Save Review
  static Future<ResultApiModel> requestSaveReview(params) async {
    final result = await httpManager.postTestingDomain(
      url: saveComment,
      data: params,
      loading: true,
    );
    final convertResponse = {
      "success": result['code'] == null,
      "message": result['message'] ?? "save_data_success",
      "data": result
    };
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Upload image
  static Future<ResultApiModel> requestUploadImage(formData, progress) async {
    var result = await httpManager.postTestingDomain(
      url: uploadImage,
      formData: formData,
      progress: progress,
    );

    final convertResponse = {"success": result['id'] != null, "data": result};
    return ResultApiModel.fromJson(convertResponse);
  }

  ///Get booking form
  static Future<ResultApiModel> requestBookingForm(params) async {
    final result = await httpManager.post(
      url: bookingForm,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Price
  static Future<ResultApiModel> requestPrice(params) async {
    final result = await httpManager.post(
      url: calcPrice,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Order
  static Future<ResultApiModel> requestOrder(params) async {
    final result = await httpManager.post(
      url: addBooking,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Get Booking Detail
  static Future<ResultApiModel> requestBookingDetail(params) async {
    final result = await httpManager.post(url: bookingDetail, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Get Booking List
  static Future<ResultApiModel> requestBookingList(params) async {
    final result = await httpManager.post(url: bookingList, data: params);
    return ResultApiModel.fromJson(result);
  }

  ///Booking Cancel
  static Future<ResultApiModel> requestBookingCancel(params) async {
    final result = await httpManager.post(
      url: bookingCancel,
      data: params,
      loading: true,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Download file
  static Future<ResultApiModel> requestDownloadFile({
    required FileModel file,
    required progress,
    String? directory,
  }) async {
    directory ??= await UtilFile.getFilePath();
    final filePath = '$directory/${file.name}.${file.type}';
    final result = await httpManager.download(
      url: file.url,
      filePath: filePath,
      progress: progress,
    );
    return ResultApiModel.fromJson(result);
  }

  ///Singleton factory
  static final Api _instance = Api._internal();

  factory Api() {
    return _instance;
  }

  Api._internal();
}
