import 'package:futbol_teams_app/domain/class_user.dart';

class ListUsers {
  List<UserData> users = [
    UserData(id: null, name: 'Ramiro', surname: 'Palomeque', dni: 12345678, gender: 'M', birthdate: DateTime(1997, 2, 9), email: 'ramiro@example.com', password: '123', state: "Active", createdAt: DateTime(16,5,2026), updatedAt:DateTime(16,5,2026)),
    UserData(id: null, name: 'Maria', surname: 'Gomez', dni: 87654321, gender: 'F', birthdate: DateTime(1995, 5, 15), email: 'maria@example.com', password: '456', state: "Active", createdAt: DateTime(16,5,2026), updatedAt:DateTime(16,5,2026)),
    UserData(id: null, name: 'Juan', surname: 'Perez', dni: 11223344, gender: 'M', birthdate: DateTime(1990, 8, 20), email: 'a', password: 'a', state: "Active", createdAt: DateTime(16,5,2026), updatedAt:DateTime(16,5,2026)),
    UserData(name: 'Matias', surname: 'Perez', dni: 1234, gender: 'M', birthdate: DateTime(1990,12,12), email: 'b', password: 'b', state: 'active', createdAt: DateTime(16,5,2026), updatedAt:DateTime(16,5,2026)), 
  ];
}