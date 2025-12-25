abstract class ProductCreateEvent {}

class ProductCreateRequested extends ProductCreateEvent {
  final String userId;
  final String brandId;
  final String categoryId;
  final String subCategoryId;
  final String unitId;
  final String productTypeId;

  final String name;
  final String productPrice;
  final String qty;
  final String tax1;
  final String tax1Rate;
  final String tax2;
  final String tax2Rate;
  final String tax3;
  final String tax3Rate;

  final String productData;



  ProductCreateRequested( {
    required this.userId,
    required this.brandId,
    required this.categoryId,
    required this.subCategoryId,
    required this.unitId,
    required this.productTypeId,

    required this.name,
    required this.productPrice,
    required this.qty,
    required this.tax1,
    required this.tax1Rate,
    required this.tax2,
    required this.tax2Rate,
    required this.tax3,
    required this.tax3Rate,

    required this.productData,

  });
}
