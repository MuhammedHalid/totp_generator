class password {
  int? id;
  String? name;
  String? secret;

  password({this.id, this.name, this.secret});

  password.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    secret = json['secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['secret'] = this.secret;
    return data;
  }
  
}
