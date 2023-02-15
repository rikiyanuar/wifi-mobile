class PelangganEntity {
  final String? id;
  final String nama;
  final String nohp;
  final String email;
  final String alamat;
  final String nik;
  final int poin;
  final List<dynamic> paket;

  PelangganEntity({
    this.id,
    required this.nama,
    required this.nohp,
    required this.email,
    required this.alamat,
    required this.nik,
    required this.poin,
    required this.paket,
  });

  factory PelangganEntity.fromJson(Map<String, dynamic> json) =>
      PelangganEntity(
        id: json["id"],
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        alamat: json["alamat"],
        nik: json["nik"],
        poin: json["poin"],
        paket: List<dynamic>.from(json["paket"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "alamat": alamat,
        "nik": nik,
        "poin": poin,
        "paket": List<dynamic>.from(paket.map((x) => x)),
      };
}
