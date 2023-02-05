class ProdukEntity {
  final String nama;
  final int harga;
  final String satuan;
  final String foto;
  final String deskripsi;
  final String? id;

  ProdukEntity({
    required this.nama,
    required this.harga,
    required this.satuan,
    required this.foto,
    required this.deskripsi,
    this.id,
  });

  factory ProdukEntity.fromJson(Map<String, dynamic> json) => ProdukEntity(
        nama: json["nama"],
        harga: json["harga"],
        satuan: json["satuan"],
        foto: json["foto"],
        deskripsi: json["deskripsi"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "harga": harga,
        "satuan": satuan,
        "foto": foto,
        "deskripsi": deskripsi,
        "id": id,
      };
}
