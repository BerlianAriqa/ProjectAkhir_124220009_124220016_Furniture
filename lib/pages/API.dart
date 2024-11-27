class Furniture {
  final List<Payload>? payload;
  final String? message;

  Furniture({
    this.payload,
    this.message,
  });

  Furniture.fromJson(Map<String, dynamic> json)
    : payload = (json['payload'] as List?)?.map((dynamic e) => Payload.fromJson(e as Map<String,dynamic>)).toList(),
      message = json['message'] as String?;

  Map<String, dynamic> toJson() => {
    'payload' : payload?.map((e) => e.toJson()).toList(),
    'message' : message
  };
}

class Payload {
  final String? id;
  final String? type;
  final String? name;
  final String? description;
  final String? currency;
  final int? price;
  final String? imgLink;
  int quantity;

  Payload({
    this.id,
    this.type,
    this.name,
    this.description,
    this.currency,
    this.price,
    this.imgLink,
    this.quantity = 1,
  });

  Payload.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String?,
      type = json['type'] as String?,
      name = json['name'] as String?,
      description = json['description'] as String?,
      currency = json['currency'] as String?,
      price = json['price'] as int?,
      imgLink = json['img_link'] as String?,
      quantity = json['quantity'] as int? ?? 1;  // Ensures quantity defaults to 1 if null

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type,
    'name' : name,
    'description' : description,
    'currency' : currency,
    'price' : price,
    'img_link' : imgLink,
    'quantity': quantity,
  };
}
