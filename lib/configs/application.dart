import 'package:listar_flutter_pro/models/model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Application {
  static bool debug = true;
  static String googleAPI = 'AIzaSyDg1evvc68xACuU2RsbBiV5uoF0vwVNM8Y';
  static String domain = 'https://shortstay.pk';
  static DeviceModel? device;
  static PackageInfo? packageInfo;
  static SettingModel setting = SettingModel.fromDefault();

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
