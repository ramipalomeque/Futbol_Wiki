class UserData {
  int? id;

  String name;
  String surname;
  int dni;
  String gender;
  DateTime birthdate;

  String email;
  int? phone;
  String? address;

  String password;

  String state;
  DateTime createdAt;
  DateTime updatedAt;

  UserData({
    this.id,
    required this.name,
    required this.surname,
    required this.dni,
    required this.gender,
    required this.birthdate,
    required this.email,
    this.phone,
    this.address,
    required this.password,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'dni': dni,
      'gender': gender,
      'birthdate': birthdate.toIso8601String(),
      'email': email,
      'phone': phone,
      'address': address,
      'password': password,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      id: map['id'],
      name: map['name'],
      surname: map['surname'],
      dni: map['dni'],
      gender: map['gender'],
      birthdate: DateTime.parse(map['birthdate']),
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      password: map['password'],
      state: map['state'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }
}