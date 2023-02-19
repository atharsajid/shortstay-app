import 'package:listar_flutter_pro/models/model.dart';

class ProductModel {
  final int id;
  final String title;
  final ImageModel image;
  final String videoURL;
  final CategoryModel? category;
  final String createDate;
  final String dateEstablish;
  final double rate;
  final num numRate;
  final String rateText;
  final String status;
  bool favorite;
  final String address;
  final String zipCode;
  final String phone;
  final String fax;
  final String email;
  final String website;
  final String description;
  final String color;
  final String icon;
  final List<CategoryModel> tags;
  final String priceMin;
  final String priceMax;
  final CategoryModel? country;
  final CategoryModel? city;
  final CategoryModel? state;
  final UserModel? author;
  final List<ImageModel> galleries;
  final List<CategoryModel> features;
  final List<ProductModel> related;
  final List<ProductModel> latest;
  final List<OpenTimeModel> openHours;
  final List<IconModel> socials;
  final List<FileModel> attachments;
  final LocationModel? location;
  final String link;
  final bool bookingUse;

  ProductModel({
    required this.id,
    required this.title,
    required this.image,
    required this.videoURL,
    this.category,
    required this.createDate,
    required this.dateEstablish,
    required this.rate,
    required this.numRate,
    required this.rateText,
    required this.status,
    required this.favorite,
    required this.address,
    required this.zipCode,
    required this.phone,
    required this.fax,
    required this.email,
    required this.website,
    required this.description,
    required this.color,
    required this.icon,
    required this.tags,
    required this.priceMin,
    required this.priceMax,
    this.country,
    this.city,
    this.state,
    this.author,
    required this.galleries,
    required this.features,
    required this.related,
    required this.latest,
    required this.openHours,
    required this.socials,
    this.location,
    required this.attachments,
    required this.link,
    required this.bookingUse,
  });

  factory ProductModel.fromJson(
    Map<String, dynamic> json, {
    SettingModel? setting,
  }) {
    List<ImageModel> galleries = [];
    List<CategoryModel> features = [];
    List<OpenTimeModel> openHours = [];
    List<IconModel> socials = [];
    List<FileModel> attachments = [];
    List<CategoryModel> tags = [];
    UserModel? author;
    CategoryModel? category;
    LocationModel? location;
    CategoryModel? country;
    CategoryModel? state;
    CategoryModel? city;
    String status = '';
    String videoURL = '';
    String address = '';
    String phone = '';
    String email = '';
    String website = '';
    String dateEstablish = '';
    String priceMin = '';
    String priceMax = '';

    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }

    if (json['category'] != null) {
      category = CategoryModel.fromJson(json['category']);
    }

    if (json['location'] != null && json['location']['country'] != null) {
      country = CategoryModel.fromJson(json['location']['country']);
    }

    if (json['location'] != null && json['location']['state'] != null) {
      state = CategoryModel.fromJson(json['location']['state']);
    }

    if (json['location'] != null && json['location']['city'] != null) {
      city = CategoryModel.fromJson(json['location']['city']);
    }

    if (json['latitude'] != null && setting?.useViewMap == true) {
      location = LocationModel.fromJson({
        "name": json['post_title'] ?? "",
        "latitude": json['latitude'] ?? "",
        "longitude": json['longitude'] ?? ""
      });
    }

    if (setting?.useViewGalleries == true && json['galleries'] != null) {
      galleries = List.from(json['galleries'] ?? []).map((item) {
        return ImageModel.fromJson(item);
      }).toList();
    }

    if (setting?.useViewStatus == true) {
      status = json['status'] ?? '';
    }

    if (setting?.useViewVideo == true) {
      videoURL = json['video_url'] ?? '';
    }

    if (setting?.useViewAddress == true) {
      address = json['address'] ?? '';
    }

    if (setting?.useViewPhone == true) {
      phone = json['phone'] ?? '';
    }

    if (setting?.useViewEmail == true) {
      email = json['email'] ?? '';
    }

    if (setting?.useViewWebsite == true) {
      website = json['website'] ?? '';
    }

    if (setting?.useViewDateEstablish == true) {
      dateEstablish = json['date_establish'] ?? '';
    }

    if (setting?.useViewPrice == true) {
      priceMin = json['price_min'] ?? '';
      priceMax = json['price_max'] ?? '';
    }

    if (setting?.useViewFeature == true) {
      features = List.from(json['features'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }

    final listRelated = List.from(json['related'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    final listLatest = List.from(json['lastest'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    if (setting?.useViewOpenHours == true) {
      openHours = List.from(json['opening_hour'] ?? []).map((item) {
        return OpenTimeModel.fromJson(item);
      }).toList();
    }

    if (setting?.useViewTags == true) {
      tags = List.from(json['tags'] ?? []).map((item) {
        return CategoryModel.fromJson(item);
      }).toList();
    }

    if (setting?.useViewAttachment == true) {
      attachments = List.from(json['attachments'] ?? []).map((item) {
        return FileModel.fromJson(item);
      }).toList();
    }

    if (setting?.useViewSocial == true && json['social_network'] is Map) {
      socials = json['social_network'].entries.map<IconModel>((entry) {
        return IconModel(
          title: entry.key,
          value: entry.value,
        );
      }).toList();
    }

    return ProductModel(
      id: int.tryParse(json['ID'].toString()) ?? 0,
      title: json['post_title'] ?? '',
      image: ImageModel.fromJson(json['image']),
      videoURL: videoURL,
      category: category,
      createDate: json['post_date'] ?? '',
      dateEstablish: dateEstablish,
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      numRate: json['rating_count'] ?? 0,
      rateText: json['post_status'] ?? '',
      status: status,
      favorite: json['wishlist'] ?? false,
      address: address,
      zipCode: json['zip_code'] ?? '',
      phone: phone,
      fax: json['fax'] ?? '',
      email: email,
      website: website,
      description: json['post_excerpt'] ?? '',
      color: json['color'] ?? '',
      icon: json['icon'] ?? '',
      tags: tags,
      priceMin: priceMin,
      priceMax: priceMax,
      country: country,
      state: state,
      city: city,
      features: features,
      author: author,
      galleries: galleries,
      related: listRelated,
      latest: listLatest,
      openHours: openHours,
      socials: socials,
      location: location,
      attachments: attachments,
      link: json['guid'] ?? '',
      bookingUse: json['booking_use'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "post_title": title,
      "image": {
        "id": 0,
        "full": {},
        "thumb": {},
      },
    };
  }
}
