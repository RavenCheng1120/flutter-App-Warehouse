// create table
const String tablePlan = 'plans';

class PlanFields {
  static final List<String> values = [
    id,
    productType,
    category,
    productName,
    size,
    number,
    totalCost,
    pricing,
    manufacturer,
    createDate
  ];

  static const String id = '_id';
  static const String productType = 'productType';
  static const String category = 'category';
  static const String productName = 'productName';
  static const String size = 'size';
  static const String number = 'number';
  static const String totalCost = 'totalCost';
  static const String pricing = 'pricing';
  static const String manufacturer = 'manufacturer';
  static const String createDate = 'createDate';
}

// create model
class PlanModel {
  final int? id;
  final String productType;
  final String category;
  final String productName;
  final String size;
  final int number;
  final int totalCost;
  final int pricing;
  final String manufacturer;
  final DateTime createDate;

  const PlanModel({
    this.id,
    required this.productType,
    required this.productName,
    required this.category,
    required this.size,
    required this.number,
    required this.totalCost,
    required this.pricing,
    required this.manufacturer,
    required this.createDate,
  });

  PlanModel copy({
    int? id,
    String? productType,
    String? category,
    String? productName,
    String? size,
    int? number,
    int? totalCost,
    int? pricing,
    String? manufacturer,
    DateTime? createDate,
  }) =>
      PlanModel(
        id: id ?? this.id,
        productType: productType ?? this.productType,
        productName: productName ?? this.productName,
        category: category ?? this.category,
        size: size ?? this.size,
        number: number ?? this.number,
        totalCost: totalCost ?? this.totalCost,
        pricing: pricing ?? this.pricing,
        manufacturer: manufacturer ?? this.manufacturer,
        createDate: createDate ?? this.createDate,
      );

  static PlanModel fromJson(Map<String, Object?> json) => PlanModel(
        id: json[PlanFields.id] as int?,
        productType: json[PlanFields.productType] as String,
        productName: json[PlanFields.productName] as String,
        category: json[PlanFields.category] as String,
        size: json[PlanFields.size] as String,
        number: json[PlanFields.number] as int,
        totalCost: json[PlanFields.totalCost] as int,
        pricing: json[PlanFields.pricing] as int,
        manufacturer: json[PlanFields.manufacturer] as String,
        createDate: DateTime.parse(json[PlanFields.createDate] as String),
      );

  Map<String, Object?> toJson() => {
        PlanFields.id: id,
        PlanFields.productType: productType,
        PlanFields.productName: productName,
        PlanFields.category: category,
        PlanFields.size: size,
        PlanFields.number: number,
        PlanFields.totalCost: totalCost,
        PlanFields.pricing: pricing,
        PlanFields.manufacturer: manufacturer,
        PlanFields.createDate: createDate.toIso8601String(),
      };
}
