class PelangganEntity {
  final String nama;
  final String nohp;
  final String email;
  final String alamat;
  final String nik;
  final List<dynamic> paket;

  PelangganEntity({
    required this.nama,
    required this.nohp,
    required this.email,
    required this.alamat,
    required this.nik,
    required this.paket,
  });

  factory PelangganEntity.fromJson(Map<String, dynamic> json) =>
      PelangganEntity(
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        alamat: json["alamat"],
        nik: json["nik"],
        paket: List<dynamic>.from(json["paket"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "alamat": alamat,
        "nik": nik,
        "paket": List<dynamic>.from(paket.map((x) => x)),
      };
}
