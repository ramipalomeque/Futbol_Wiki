import 'package:flutter_riverpod/legacy.dart';
import 'package:futbol_teams_app/domain/class_user.dart';
import 'package:futbol_teams_app/data/database/database_helper.dart';

final usersProvider =
    StateNotifierProvider<UsersNotifier, List<UserData>>(
  (ref) => UsersNotifier(),
);

class UsersNotifier extends StateNotifier<List<UserData>> {

  final DatabaseHelper dbHelper = DatabaseHelper();

 UsersNotifier() : super([]);

  Future<void> loadUsers() async {
    final users = await dbHelper.getUsers();

    state = users;
  }

  Future<bool> addUser(UserData user) async {

    final existsEmail = await dbHelper.userExistsByEmail(user.email);

    final existsDni = await dbHelper.userExistsByDni(user.dni);

    if (existsEmail != null || existsDni) return false;
    
    await dbHelper.insertUser(user);
    await loadUsers();
    return true;
  }

  Future<bool> editUser(UserData updatedUser) async {

    final result = await dbHelper.updateUser(updatedUser);

    if (result == 0) {return false;}

    await loadUsers();

    return true;
  }

  Future<bool> deleteUser(int id) async {

    final result = await dbHelper.deleteUser(id);

    if (result == 0) { return false;}

    await loadUsers();

    return true;
  }
  
  Future<UserData?> getUserById(int id) async {
    return await dbHelper.getUserById(id);
  }

  int getUsersCount() => state.length;
}

