class TagihanEntity {
  final String bulan;
  final int tahun;
  final int nominal;
  final bool isLunas;
  final String tglLunas;

  TagihanEntity({
    required this.bulan,
    required this.tahun,
    required this.nominal,
    required this.isLunas,
    required this.tglLunas,
  });

  factory TagihanEntity.fromJson(Map<String, dynamic> json) => TagihanEntity(
        bulan: json["bulan"],
        tahun: json["tahun"],
        nominal: json["nominal"],
        isLunas: json["isLunas"],
        tglLunas: json["tglLunas"],
      );

  Map<String, dynamic> toJson() => {
        "bulan": bulan,
        "tahun": tahun,
        "nominal": nominal,
        "isLunas": isLunas,
        "tglLunas": tglLunas,
      };
}
