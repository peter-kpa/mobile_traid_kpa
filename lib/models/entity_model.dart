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
  String internalDocumentNumber;
  String? externalDocumentNumber;
  DateTime documentDate;
  bool posted = false;
  bool deletionMark = false;

  Document(
    this.internalDocumentNumber,
    this.externalDocumentNumber,
    this.documentDate,
    this.posted,
    this.deletionMark,
  );
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

  Warehouse({required this.id, required this.name});

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

  TradePoint({required this.id, required this.name});

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

  Organization({required this.id, required this.name});

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
