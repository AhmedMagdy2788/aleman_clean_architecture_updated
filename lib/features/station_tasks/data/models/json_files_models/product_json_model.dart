// ignore_for_file: constant_identifier_names

import 'dart:convert';

import '../../../../../core/models/json_model.dart';
import '../../../domain/entities/product_entity.dart';

class ProductJSONModel extends ProductEntity implements JSONModel {
  static const String TABLENAME = "";
  static const String PRODUCT_ID = "product_id";
  static const String PRODUCTS_CATEGORY = "products_category";
  static const String PRODUCT_NAME = "product_name";
  const ProductJSONModel(
      {required super.productId,
      required super.productsCategory,
      required super.productName});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PRODUCT_ID: productId,
      PRODUCTS_CATEGORY: productsCategory,
      'product_name': productName,
    };
  }

  factory ProductJSONModel.fromMap(Map<String, dynamic> map) {
    return ProductJSONModel(
      productId: map[PRODUCT_ID].toInt() as int,
      productsCategory: map[PRODUCTS_CATEGORY] as String,
      productName: map[PRODUCT_NAME] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductJSONModel.fromJson(String source) =>
      ProductJSONModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
