// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../../core/models/server_model.dart';
import '../../../domain/entities/product_entity.dart';

class ProductServerModel extends ProductEntity implements ServerModel {
  static const String ENDPOINT = "Products";
  static const String PRODUCT_ID = "id";
  static const String PRODUCT_NAME = "product_Name";
  static const String PRODUCTS_CATEGORY = "products_Category";
  const ProductServerModel({
    required super.productId,
    required super.productName,
    required super.productsCategory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PRODUCT_ID: productId,
      PRODUCT_NAME: productName,
      PRODUCTS_CATEGORY: productsCategory,
    };
  }

  factory ProductServerModel.fromMap(Map<String, dynamic> map) {
    return ProductServerModel(
      productId: map[PRODUCT_ID].toInt() as int,
      productName: map[PRODUCT_NAME] as String,
      productsCategory: map[PRODUCTS_CATEGORY] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductServerModel.fromJson(String source) =>
      ProductServerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ProductsCategoryServerModel extends ProductsCategoryEnitity
    implements ServerModel {
  static const String ENDPOINT = "Mainproducts";
  static const String CATEGORY_ID = "categoryId";
  static const String CATEGORY_NAME = "products_Category";
  const ProductsCategoryServerModel({
    required super.categoryId,
    required super.categoryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CATEGORY_ID: categoryId,
      CATEGORY_NAME: categoryName,
    };
  }

  factory ProductsCategoryServerModel.fromMap(Map<String, dynamic> map) {
    return ProductsCategoryServerModel(
      categoryId: map[CATEGORY_ID].toInt() as int,
      categoryName: map[CATEGORY_NAME] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductsCategoryServerModel.fromJson(String source) =>
      ProductsCategoryServerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ProductSalePriceServerModel extends ProductSalePriceEnitity
    implements ServerModel {
  static const String ENDPOINT = "Tblproductssalesprices";
  static const String DATE = "date";
  static const String PRODUCT_NAME = "product_Name";
  static const String PRODUCT_SALE_PRICE = "product_Selling_Price";
  const ProductSalePriceServerModel({
    required super.date,
    required super.productName,
    required super.productSalePrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: DateFormat("yyyy-MM-dd").format(date),
      PRODUCT_NAME: productName,
      PRODUCT_SALE_PRICE: productSalePrice,
    };
  }

  factory ProductSalePriceServerModel.fromMap(Map<String, dynamic> map) {
    dynamic salePrice = map[PRODUCT_SALE_PRICE];
    if (salePrice.runtimeType == int) {
      int value = salePrice;
      salePrice = value.toDouble();
    }
    return ProductSalePriceServerModel(
      date: DateFormat("yyyy-MM-dd").parse(map[DATE]),
      productName: map[PRODUCT_NAME] as String,
      productSalePrice: salePrice as double,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductSalePriceServerModel.fromJson(String source) =>
      ProductSalePriceServerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ProductPurchasePriceServerModel extends ProductPurchasePriceEnitity
    implements ServerModel {
  static const String ENDPOINT = "Tblproductsbuyprices";
  static const String DATE = "date";
  static const String PRODUCT_NAME = "product_Name";
  static const String PRODUCT_PURCHASE_PRICE = "product_Purchase_Price";
  const ProductPurchasePriceServerModel({
    required super.date,
    required super.productName,
    required super.productPurchasePrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: DateFormat("yyyy-MM-dd").format(date),
      PRODUCT_NAME: productName,
      PRODUCT_PURCHASE_PRICE: productPurchasePrice,
    };
  }

  factory ProductPurchasePriceServerModel.fromMap(Map<String, dynamic> map) {
    dynamic purchasePrice = map[PRODUCT_PURCHASE_PRICE];
    if (purchasePrice.runtimeType == int) {
      int value = purchasePrice;
      purchasePrice = value.toDouble();
    }
    return ProductPurchasePriceServerModel(
      date: DateFormat("yyyy-MM-dd").parse(map[DATE]),
      productName: map[PRODUCT_NAME] as String,
      productPurchasePrice: purchasePrice as double,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductPurchasePriceServerModel.fromJson(String source) =>
      ProductPurchasePriceServerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class ProductCommissionServerModel extends ProductCommissionEnitity
    implements ServerModel {
  static const String ENDPOINT = "Tblproductscommissions";
  static const String DATE = "date";
  static const String PRODUCT_NAME = "product_Name";
  static const String PRODUCT_COMMISSION = "product_Commission";
  const ProductCommissionServerModel({
    required super.date,
    required super.productName,
    required super.commission,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: DateFormat("yyyy-MM-dd").format(date),
      PRODUCT_NAME: productName,
      PRODUCT_COMMISSION: commission,
    };
  }

  factory ProductCommissionServerModel.fromMap(Map<String, dynamic> map) {
    return ProductCommissionServerModel(
      date: DateFormat("yyyy-MM-dd").parse(map[DATE]),
      productName: map[PRODUCT_NAME] as String,
      commission: map[PRODUCT_COMMISSION] as double,
    );
  }

  @override
  Map<String, dynamic> toJson() => toMap();
  // @override
  // String toJson() => json.encode(toMap());

  factory ProductCommissionServerModel.fromJson(String source) =>
      ProductCommissionServerModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
