class CartEntity {
  final int? totalItem;
  final List<String>? idProduk;
  final List<String>? namaProduk;
  final List<int>? qtyProduk;
  final List<int>? hargaProduk;
  final int? totalQty;
  final int? subTotal;

  CartEntity({
    this.totalItem,
    this.idProduk,
    this.namaProduk,
    this.qtyProduk,
    this.hargaProduk,
    this.totalQty,
    this.subTotal,
  });

  factory CartEntity.fromJson(Map<String, dynamic> json) => CartEntity(
        totalItem: json["totalItem"],
        idProduk: json["idProduk"] == null
            ? []
            : List<String>.from(json["idProduk"]!.map((x) => x)),
        namaProduk: json["namaProduk"] == null
            ? []
            : List<String>.from(json["namaProduk"]!.map((x) => x)),
        qtyProduk: json["qtyProduk"] == null
            ? []
            : List<int>.from(json["qtyProduk"]!.map((x) => x)),
        hargaProduk: json["hargaProduk"] == null
            ? []
            : List<int>.from(json["hargaProduk"]!.map((x) => x)),
        totalQty: json["totalQty"],
        subTotal: json["subTotal"],
      );

  Map<String, dynamic> toJson() => {
        "totalItem": totalItem,
        "idProduk":
            idProduk == null ? [] : List<dynamic>.from(idProduk!.map((x) => x)),
        "namaProduk": namaProduk == null
            ? []
            : List<dynamic>.from(namaProduk!.map((x) => x)),
        "qtyProduk": qtyProduk == null
            ? []
            : List<dynamic>.from(qtyProduk!.map((x) => x)),
        "hargaProduk": hargaProduk == null
            ? []
            : List<dynamic>.from(hargaProduk!.map((x) => x)),
        "totalQty": totalQty,
        "subTotal": subTotal,
      };
}

class CartItem {
  final String? idProduk;
  final String? namaProduk;
  final int? qtyProduk;
  final int? hargaProduk;

  CartItem({
    this.idProduk,
    this.namaProduk,
    this.qtyProduk,
    this.hargaProduk,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        idProduk: json["idProduk"],
        namaProduk: json["namaProduk"],
        qtyProduk: json["qtyProduk"],
        hargaProduk: json["hargaProduk"],
      );

  Map<String, dynamic> toJson() => {
        "idProduk": idProduk,
        "namaProduk": namaProduk,
        "qtyProduk": qtyProduk,
        "hargaProduk": hargaProduk,
      };
}
