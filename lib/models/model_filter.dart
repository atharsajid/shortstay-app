import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/models/model.dart';

class FilterModel {
  final List<CategoryModel> category;
  final List<CategoryModel> feature;
  CategoryModel? area;
  CategoryModel? location;
  double? distance;
  double? minPrice;
  double? maxPrice;
  String? color;
  SortModel? sort;
  TimeOfDay? startHour;
  TimeOfDay? endHour;

  FilterModel({
    required this.category,
    required this.feature,
    this.area,
    this.location,
    this.distance,
    this.minPrice,
    this.maxPrice,
    this.color,
    this.sort,
    this.startHour,
    this.endHour,
  });

  factory FilterModel.fromDefault() {
    return FilterModel(
      category: [],
      feature: [],
      sort: Application.setting.sort.isNotEmpty
          ? Application.setting.sort.first
          : null,
      startHour: Application.setting.startHour,
      endHour: Application.setting.endHour,
    );
  }

  factory FilterModel.fromSource(source) {
    return FilterModel(
      category: List<CategoryModel>.from(source.category),
      feature: List<CategoryModel>.from(source.feature),
      area: source.area,
      location: source.location,
      distance: source.distance,
      minPrice: source.minPrice,
      maxPrice: source.maxPrice,
      color: source.color,
      sort: source.sort,
      startHour: source.startHour,
      endHour: source.endHour,
    );
  }

  FilterModel clone() {
    return FilterModel.fromSource(this);
  }
}
