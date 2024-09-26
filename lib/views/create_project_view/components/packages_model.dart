class PackageForView {
  String name;
  num revision;
  String deliveryTime;
  num regularPrice;
  num? discountPrice;
  List<ExtraFieldForView> extraFields;

  PackageForView({
    required this.name,
    required this.revision,
    required this.deliveryTime,
    required this.regularPrice,
    required this.discountPrice,
    required this.extraFields,
  });
}

class ExtraFieldForView {
  dynamic id;
  String name;
  FieldType0 type;
  bool checked;
  num quantity;

  ExtraFieldForView({
    required this.id,
    required this.name,
    required this.type,
    required this.checked,
    required this.quantity,
  });
}

enum FieldType0 { CHECK, QUANTITY }
