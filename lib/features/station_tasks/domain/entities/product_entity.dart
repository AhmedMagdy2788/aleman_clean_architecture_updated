import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int productId;
  final String productName;
  final String productsCategory;
  const ProductEntity({
    required this.productId,
    required this.productName,
    required this.productsCategory,
  });

  ProductEntity copyWith({
    int? productId,
    String? productName,
    String? productsCategory,
  }) {
    return ProductEntity(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productsCategory: productsCategory ?? this.productsCategory,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        productId,
        productName,
        productsCategory,
      ];
}

class ProductsCategoryEnitity extends Equatable {
  final int categoryId;
  final String categoryName;
  const ProductsCategoryEnitity(
      {required this.categoryId, required this.categoryName});

  ProductsCategoryEnitity copyWith({
    int? categoryId,
    String? categoryName,
  }) {
    return ProductsCategoryEnitity(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [categoryId, categoryName];
}

class ProductSalePriceEnitity extends Equatable {
  final DateTime date;
  final String productName;
  final double productSalePrice;
  const ProductSalePriceEnitity({
    required this.date,
    required this.productName,
    required this.productSalePrice,
  });

  ProductSalePriceEnitity copyWith({
    DateTime? date,
    int? productId,
    String? productName,
    double? productSalePrice,
  }) {
    return ProductSalePriceEnitity(
      date: date ?? this.date,
      productName: productName ?? this.productName,
      productSalePrice: productSalePrice ?? this.productSalePrice,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        date,
        productName,
        productSalePrice,
      ];
}

class ProductPurchasePriceEnitity extends Equatable {
  final DateTime date;
  final String productName;
  final double productPurchasePrice;
  const ProductPurchasePriceEnitity({
    required this.date,
    required this.productName,
    required this.productPurchasePrice,
  });

  ProductPurchasePriceEnitity copyWith({
    DateTime? date,
    String? productName,
    double? productPurchasePrice,
  }) {
    return ProductPurchasePriceEnitity(
      date: date ?? this.date,
      productName: productName ?? this.productName,
      productPurchasePrice: productPurchasePrice ?? this.productPurchasePrice,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        date,
        productName,
        productPurchasePrice,
      ];
}

class ProductCommissionEnitity extends Equatable {
  final DateTime date;
  final String productName;
  final double commission;
  const ProductCommissionEnitity({
    required this.date,
    required this.productName,
    required this.commission,
  });

  ProductCommissionEnitity copyWith({
    DateTime? date,
    String? productName,
    double? commission,
  }) {
    return ProductCommissionEnitity(
      date: date ?? this.date,
      productName: productName ?? this.productName,
      commission: commission ?? this.commission,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        date,
        productName,
        commission,
      ];
}

class EditingProductDetailsDto extends Equatable {
  final int? productId;
  final String productName;
  final String categoryName;
  final DateTime date;
  final double productPurchasePrice;
  final double productSalePrice;

  const EditingProductDetailsDto({
    this.productId,
    required this.productName,
    required this.categoryName,
    required this.date,
    required this.productPurchasePrice,
    required this.productSalePrice,
  });

  EditingProductDetailsDto copyWith({
    int? productId,
    String? productName,
    String? categoryName,
    DateTime? date,
    double? productPurchasePrice,
    double? productSalePrice,
  }) {
    return EditingProductDetailsDto(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      categoryName: categoryName ?? this.categoryName,
      date: date ?? this.date,
      productPurchasePrice: productPurchasePrice ?? this.productPurchasePrice,
      productSalePrice: productSalePrice ?? this.productSalePrice,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        productId,
        productName,
        categoryName,
        date,
        productPurchasePrice,
        productSalePrice,
      ];
}
