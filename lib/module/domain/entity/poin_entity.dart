class PoinEntity {
  final String tanggal;
  final int nominal;

  PoinEntity({
    required this.tanggal,
    required this.nominal,
  });

  factory PoinEntity.fromJson(Map<String, dynamic> json) => PoinEntity(
        tanggal: json["tanggal"],
        nominal: json["nominal"],
      );

  Map<String, dynamic> toJson() => {
        "tanggal": tanggal,
        "nominal": nominal,
      };
}
