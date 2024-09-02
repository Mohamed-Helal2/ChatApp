class HomeModel {
  String? photo;
  final String name;
  final String? status;
  final String email;
  final bool online;

  HomeModel(
      {required this.email,
      required this.name,
      required this.photo,
      required this.status,
      required this.online});
  factory HomeModel.fromjson(homedata) {
    return HomeModel(
        photo: homedata['photo'],
        name: homedata['name'],
        status: homedata['status'],
        email: homedata['email'],
        online: homedata['online']);
  }
}
