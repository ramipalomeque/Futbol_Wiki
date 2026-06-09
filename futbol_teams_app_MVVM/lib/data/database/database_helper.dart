import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:futbol_teams_app/domain/class_user.dart';
import 'package:futbol_teams_app/domain/class_futbol_team.dart';

import 'package:futbol_teams_app/data/lists/list_users.dart';
import 'package:futbol_teams_app/data/lists/list_futbol_teams.dart';
import 'package:futbol_teams_app/data/lists/list_national_teams.dart';  

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null)  return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {

    final dbPath = await getDatabasesPath();

    final path = join(dbPath, 'futbol_app.db');

    return await openDatabase(
      path,
      version: 1,

      onCreate: (db, version) async {

        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            surname TEXT NOT NULL,
            dni INTEGER UNIQUE NOT NULL,
            gender TEXT NOT NULL,
            birthdate TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL,
            phone INTEGER,
            address TEXT,
            password TEXT NOT NULL,
            state TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE teams(
            id INTEGER PRIMARY KEY,
            name TEXT,
            country TEXT,
            headCoach TEXT,
            captain TEXT,
            logoUrl TEXT,
            type TEXT,
            state TEXT,
            createdAt TEXT,
            updatedAt TEXT,

            city TEXT,
            foundedDate TEXT,
            stadiumCapacity INTEGER,
            stadiumName TEXT,
            nationalTitles INTEGER,
            internationalTitles INTEGER,

            continent TEXT,
            federation TEXT,
            federationRanking INTEGER,
            federationTitles INTEGER,
            worldCupAppearances INTEGER,
            worldCupTitles INTEGER
          )
        ''');

        for (final user in ListUsers().users) {
          await db.insert('users', user.toMap());
        }

        for (final team in NationalTeamsData().nationalTeams) {
          await db.insert('teams', team.toMap());
        }

        for (final team in FutbollTeamData().futballTeams) {
          await db.insert('teams', team.toMap());
        }
        
      },
    );
  }

  Future<int> insertUser(UserData user) async {

    final db = await database;

    return await db.insert(
      'users',
      user.toMap(),
    );
  }

  Future<List<UserData>> getUsers() async {

    final db = await database;

    final List<Map<String, dynamic>> maps =
        await db.query('users');

    return List.generate( maps.length,(i) => UserData.fromMap(maps[i]),);
  }

  Future<int> updateUser(UserData user) async {
    final db = await database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<UserData?> getUserById(int id) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return UserData.fromMap(result.first);
  }

  Future<UserData?> getUserByEmail(String email) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return UserData.fromMap(result.first);
  }

  Future<int?> userExistsByEmail(String email) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return result.first['id'] as int;
  }

  Future<bool> userExistsByDni(int dni) async {
    final db = await database;

    final result = await db.query(
      'users',
      where: 'dni = ?',
      whereArgs: [dni],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  //** Futbol Teams Methods  **/
  Future<List<Team>> getAllTeams() async {
    final db = await database;

    final maps = await db.query('teams');

    return maps.map((map) => Team.fromMap(map)).toList();
  }

  Future<List<Team>> getTeams({String state = 'active'}) async {
    final db = await database;

    final maps = await db.query(
      'teams',
      where: 'state = ?',
      whereArgs: [state],
    );

    return maps.map((map) => Team.fromMap(map)).toList();
  }

  Future<List<Team>> getFootballTeams() async {
    final db = await database;

    final maps = await db.query(
      'teams',
      where: 'state = ? AND type = ?',
      whereArgs: ['active', 'football'],
    );

    return maps.map((map) => Team.fromMap(map)).toList();
  }

  Future<List<Team>> getNationalTeams() async {
    final db = await database;

    final maps = await db.query(
      'teams',
      where: 'state = ? AND type = ?',
      whereArgs: ['active', 'national'],
    );

    return maps.map((map) => Team.fromMap(map)).toList();
  }
  
  Future<int> insertTeam(Team team) async {
    final db = await database;
    return await db.insert(
      'teams',
      team.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTeam(Team team) async {
    final db = await database;
    return await db.update(
      'teams',
      team.toMap(),
      where: 'id = ?',
      whereArgs: [team.id],
    );
  }

  Future<int> deleteTeam(int id) async {
    final db = await database;

    return await db.update(
      'teams',
      {
        'state': 'deleted',
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Team?> teamExists(String name, String country) async {
    final db = await database;

    final result = await db.query(
      'teams',
      where: 'LOWER(name) = ? AND LOWER(country) = ?',
      whereArgs: [
        name.toLowerCase(),
        country.toLowerCase(),
      ],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Team.fromMap(result.first);
  }

  Future<Team?> getTeamById(int id) async {
    final db = await database;

    final result = await db.query(
      'teams',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;

    return Team.fromMap(result.first);
  }
}