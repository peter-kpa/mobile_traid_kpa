class TabularSectionLine {
  Map<String, String> typeNames;
  Map<String, dynamic> tabularSectionLine;

  TabularSectionLine({
    required this.typeNames,
    required this.tabularSectionLine,
  });

  void stuff() {}
}

abstract class TabularSection {
  Map<String, String> typeNames;
  Map<int, TabularSectionLine>? tabularSectionLines;

  TabularSection({
    required this.typeNames,
    this.tabularSectionLines,
  });
}

abstract class Document {
  String? internalDocumentNumber;
  String? externalDocumentNumber;
  DateTime? documentDate;
  bool posted = false;
  bool deletionMark = false;
}

class GoodsTabularSection extends TabularSection {
  GoodsTabularSection({
    tabularSectionLines,
  }) : super(
          typeNames: {
            'product': 'Product',
            'quantity': 'double',
            'price': 'double',
            'sum': 'double',
          },
          tabularSectionLines: null,
        );
}

abstract class Reference {
  String id;
  String name;

  Reference(this.id, this.name);
}

class Warehouse implements Reference {
  @override
  String id = '';

  @override
  String name = '';

  Warehouse({required id, required name});

  factory Warehouse.fromJson(Map<String, dynamic> json) {
    return Warehouse(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class TradePoint implements Reference {
  @override
  String id = '';

  @override
  String name = '';

  TradePoint({required id, required name});

  factory TradePoint.fromJson(Map<String, dynamic> json) {
    return TradePoint(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

class Organization implements Reference {
  @override
  String id = '';

  @override
  String name = '';

  Organization({required id, required name});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}

// class Manager implements Reference {
//   @override
//   String id = '';

//   @override
//   String name = '';

//   Manager({required id, required name});

//   factory Manager.fromJson(Map<String, dynamic> json) {
//     return Manager(
//       id: json['id'] as String,
//       name: json['name'] as String,
//     );
//   }
// }
