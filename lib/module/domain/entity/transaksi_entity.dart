class TransaksiEntity {
  final String pelangganId;
  final String status;
  final int totalQty;
  final int subTotal;
  final List<String> namaProduk;
  final List<int> qtyProduk;
  final List<int> hargaProduk;
  final List<String> idProduk;
  final String tanggal;
  final int poinUsed;
  final int cashUsed;
  final String nama;
  final String? id;

  TransaksiEntity({
    required this.pelangganId,
    required this.status,
    required this.totalQty,
    required this.subTotal,
    required this.namaProduk,
    required this.qtyProduk,
    required this.hargaProduk,
    required this.idProduk,
    required this.tanggal,
    required this.poinUsed,
    required this.cashUsed,
    required this.nama,
    this.id,
  });

  factory TransaksiEntity.fromJson(Map<String, dynamic> json) =>
      TransaksiEntity(
        pelangganId: json["pelangganId"],
        status: json["status"],
        totalQty: json["totalQty"],
        subTotal: json["subTotal"],
        namaProduk: List<String>.from(json["namaProduk"].map((x) => x)),
        qtyProduk: List<int>.from(json["qtyProduk"].map((x) => x)),
        hargaProduk: List<int>.from(json["hargaProduk"].map((x) => x)),
        idProduk: List<String>.from(json["idProduk"].map((x) => x)),
        tanggal: json["tanggal"],
        poinUsed: json["poinUsed"],
        cashUsed: json["cashUsed"],
        nama: json["nama"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "pelangganId": pelangganId,
        "status": status,
        "totalQty": totalQty,
        "subTotal": subTotal,
        "namaProduk": List<dynamic>.from(namaProduk.map((x) => x)),
        "qtyProduk": List<dynamic>.from(qtyProduk.map((x) => x)),
        "hargaProduk": List<dynamic>.from(hargaProduk.map((x) => x)),
        "idProduk": List<dynamic>.from(idProduk.map((x) => x)),
        "tanggal": tanggal,
        "poinUsed": poinUsed,
        "cashUsed": cashUsed,
        "nama": nama,
        "id": id,
      };
}
