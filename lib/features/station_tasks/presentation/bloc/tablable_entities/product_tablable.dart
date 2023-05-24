// ignore_for_file: constant_identifier_names

import '../../../../../core/entities/tablable_entity.dart';
import '../../../domain/entities/product_entity.dart';

class ProductTableDataSouce extends TableDataSource<ProductEntity> {
  ProductTableDataSouce(List<ProductEntity> equatableDataList)
      : super(dataList: [], title: ProductTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(ProductTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[ProductTablable.PRODUCT_ID] = int;
    columns[ProductTablable.PRODUCT_NAME] = String;
    columns[ProductTablable.PRODUCTS_CATEGORY] = String;
    return columns;
  }
}

class ProductTablable extends TablableEntity<ProductEntity> {
  static const String TABLENAME = 'Products';
  static const String PRODUCT_ID = "Id";
  static const String PRODUCT_NAME = "Name";
  static const String PRODUCTS_CATEGORY = "Category";

  ProductTablable(ProductEntity product) : super(product);

  @override
  get id => entity.productId;

  @override
  bool selected = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      PRODUCT_ID: entity.productId,
      PRODUCT_NAME: entity.productName,
      PRODUCTS_CATEGORY: entity.productsCategory,
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();
}

class ProductsCategoryTableDataSouce
    extends TableDataSource<ProductsCategoryEnitity> {
  ProductsCategoryTableDataSouce(
      List<ProductsCategoryEnitity> equatableDataList)
      : super(dataList: [], title: ProductsCategoryTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(ProductsCategoryTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[ProductsCategoryTablable.CATEGORY_ID] = int;
    columns[ProductsCategoryTablable.CATEGORY_NAME] = String;
    return columns;
  }
}

class ProductsCategoryTablable extends TablableEntity<ProductsCategoryEnitity> {
  static const String TABLENAME = 'Products Categories';
  static const String CATEGORY_ID = "Id";
  static const String CATEGORY_NAME = "Category Name";

  ProductsCategoryTablable(ProductsCategoryEnitity productsCategoryEnitity)
      : super(productsCategoryEnitity);

  @override
  get id => entity.categoryId;

  @override
  bool selected = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      CATEGORY_ID: entity.categoryId,
      CATEGORY_NAME: entity.categoryName,
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();
}

class ProductSalePriceTableDataSouce
    extends TableDataSource<ProductSalePriceEnitity> {
  ProductSalePriceTableDataSouce(
      List<ProductSalePriceEnitity> equatableDataList)
      : super(dataList: [], title: ProductSalePriceTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(ProductSalePriceTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[ProductSalePriceTablable.DATE] = DateTime;
    columns[ProductSalePriceTablable.PRODUCT_NAME] = String;
    columns[ProductSalePriceTablable.PRODUCT_SALE_PRICE] = double;
    return columns;
  }
}

class ProductSalePriceTablable extends TablableEntity<ProductSalePriceEnitity> {
  static const String TABLENAME = 'Products Sales Prices';
  static const String DATE = "Date";
  static const String PRODUCT_NAME = "Product Name";
  static const String PRODUCT_SALE_PRICE = "Sale Price";

  ProductSalePriceTablable(ProductSalePriceEnitity productsCategoryEnitity)
      : super(productsCategoryEnitity);

  @override
  get id => [entity.date, entity.productName];

  @override
  bool selected = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: entity.date,
      PRODUCT_NAME: entity.productName,
      PRODUCT_SALE_PRICE: entity.productSalePrice,
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();
}

class ProductPurchasePriceTableDataSouce
    extends TableDataSource<ProductPurchasePriceEnitity> {
  ProductPurchasePriceTableDataSouce(
      List<ProductPurchasePriceEnitity> equatableDataList)
      : super(dataList: [], title: ProductPurchasePriceTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(ProductPurchasePriceTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[ProductPurchasePriceTablable.DATE] = DateTime;
    columns[ProductPurchasePriceTablable.PRODUCT_NAME] = String;
    columns[ProductPurchasePriceTablable.PRODUCT_PURCHASE_PRICE] = double;
    return columns;
  }
}

class ProductPurchasePriceTablable
    extends TablableEntity<ProductPurchasePriceEnitity> {
  static const String TABLENAME = 'Products Purchase Prices';
  static const String DATE = "Date";
  static const String PRODUCT_NAME = "Product Name";
  static const String PRODUCT_PURCHASE_PRICE = "Purchase Price";

  ProductPurchasePriceTablable(
      ProductPurchasePriceEnitity productsCategoryEnitity)
      : super(productsCategoryEnitity);

  @override
  get id => [entity.date, entity.productName];

  @override
  bool selected = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: entity.date,
      PRODUCT_NAME: entity.productName,
      PRODUCT_PURCHASE_PRICE: entity.productPurchasePrice,
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();
}

class ProductCommissionTableDataSouce
    extends TableDataSource<ProductCommissionEnitity> {
  ProductCommissionTableDataSouce(
      List<ProductCommissionEnitity> equatableDataList)
      : super(dataList: [], title: ProductCommissionTablable.TABLENAME) {
    for (var element in equatableDataList) {
      super.dataList.add(ProductCommissionTablable(element));
    }
  }

  @override
  Map<String, Type> get columns {
    final columns = <String, Type>{};
    columns[ProductCommissionTablable.DATE] = DateTime;
    columns[ProductCommissionTablable.PRODUCT_NAME] = String;
    columns[ProductCommissionTablable.PRODUCT_COMMISSION] = double;
    return columns;
  }
}

class ProductCommissionTablable
    extends TablableEntity<ProductCommissionEnitity> {
  static const String TABLENAME = 'Products Sales Prices';
  static const String DATE = "Date";
  static const String PRODUCT_NAME = "Product Name";
  static const String PRODUCT_COMMISSION = "Commission";

  ProductCommissionTablable(ProductCommissionEnitity productsCategoryEnitity)
      : super(productsCategoryEnitity);

  @override
  get id => [entity.date, entity.productName];

  @override
  bool selected = false;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DATE: entity.date,
      PRODUCT_NAME: entity.productName,
      PRODUCT_COMMISSION: entity.commission,
    };
  }

  @override
  Map<String, dynamic> toJson() => toMap();
}
