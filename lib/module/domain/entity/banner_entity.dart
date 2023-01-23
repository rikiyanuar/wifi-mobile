class BannerEntity {
  final String banner;

  BannerEntity({required this.banner});

  factory BannerEntity.fromJson(Map<String, dynamic> json) =>
      BannerEntity(banner: json["banner"]);

  Map<String, dynamic> toJson() => {"banner": banner};
}
