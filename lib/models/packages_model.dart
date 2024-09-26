class Package {
  String name;
  num revision;
  String deliveryTime;
  num regularPrice;
  num? discountPrice;
  List<ExtraField> extraFields;

  Package({
    required this.name,
    required this.revision,
    required this.deliveryTime,
    required this.regularPrice,
    required this.discountPrice,
    required this.extraFields,
  });
}

class ExtraField {
  dynamic id;
  String name;
  FieldType type;

  String basicValue;
  String standardValue;
  String premiumValue;

  ExtraField({
    required this.id,
    required this.name,
    this.type = FieldType.CHECK,
    this.basicValue = "on",
    this.standardValue = "on",
    this.premiumValue = "on",
  });

  Map toJson() => {
        "id": id,
        "checkbox_or_numeric_select":
            type == FieldType.CHECK ? "checkbox" : "numeric",
        "check_numeric_title": name,
        "basic_check_numeric": basicValue,
        "standard_check_numeric": standardValue,
        "premium_check_numeric": premiumValue,
      };

  ExtraField copyWith({
    dynamic id,
    String? name,
    FieldType? type,
    String? basicValue,
    String? standardValue,
    String? premiumValue,
  }) {
    return ExtraField(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      basicValue: basicValue ?? this.basicValue,
      standardValue: standardValue ?? this.standardValue,
      premiumValue: premiumValue ?? this.premiumValue,
    );
  }
}

enum FieldType { CHECK, QUANTITY }
