class BannerEntity {
  final String banner;
  final String url;

  BannerEntity({
    required this.banner,
    required this.url,
  });

  factory BannerEntity.fromJson(Map<String, dynamic> json) =>
      BannerEntity(banner: json["banner"], url: json["url"] ?? '');

  Map<String, dynamic> toJson() => {"banner": banner, "url": url};
}
