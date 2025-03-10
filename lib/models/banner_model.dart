class BannerModel{
  final String image;
  final String? title;
  final String? description;

  BannerModel({required this.image, this.title, this.description});

  factory BannerModel.fromJson(Map<String, dynamic> json){
    return BannerModel(
      image: json['name'],
      title: json['image'],
      description: json['description']
    );
  }
}