class Client {
  final int id;
  final String name;
  final String email;
  final String tel;
  final String adress;

  Client({
    required this.name,
    required this.id,
    required this.email,
    required this.tel,
    required this.adress,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      adress: json['adress'],
      email: json['email'],
      tel: json['tel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
