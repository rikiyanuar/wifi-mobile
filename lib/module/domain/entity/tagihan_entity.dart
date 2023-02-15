class TagihanEntity {
  final int nominal;
  final String status;
  final String tglBayar;
  final String tglTagihan;
  final String jatuhTempo;
  final String? id;

  TagihanEntity({
    required this.nominal,
    required this.status,
    required this.tglBayar,
    required this.tglTagihan,
    required this.jatuhTempo,
    this.id,
  });

  factory TagihanEntity.fromJson(Map<String, dynamic> json) => TagihanEntity(
        nominal: json["nominal"],
        status: json["status"],
        tglBayar: json["tglBayar"],
        tglTagihan: json["tglTagihan"],
        jatuhTempo: json["jatuhTempo"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "nominal": nominal,
        "status": status,
        "tglBayar": tglBayar,
        "tglTagihan": tglTagihan,
        "jatuhTempo": jatuhTempo,
        "id": id,
      };
}
