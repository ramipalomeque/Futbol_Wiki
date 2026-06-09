enum TeamType { football, national }

abstract class Team {
  final int? id;
  final String name;
  final String country;
  final String? headCoach;
  final String? captain;
  final String logoUrl;
  final TeamType type;
  final String state;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Team({
    this.id,
    required this.name,
    required this.country,
    this.headCoach,
    this.captain,
    required this.logoUrl,
    required this.type,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap();
    Team copyWith({
    int? id,
    String? state,
    DateTime? updatedAt,
  });

  factory Team.fromMap(Map<String, dynamic> map) {
    final typeStr = map['type'] as String;

    switch (typeStr) {
      case 'football':
        return FootballTeam.fromMap(map);
      case 'national':
        return NationalTeam.fromMap(map);
      default:
        throw Exception('Unknown team type: $typeStr');
    }
  }
}

class FootballTeam extends Team {
  final String city;
  final DateTime? foundedDate;
  final int? stadiumCapacity;
  final String stadiumName;
  final int? nationalTitles;
  final int? internationalTitles;

  FootballTeam({
    super.id,
    required super.name,
    required super.country,
    super.headCoach,
    super.captain,
    required super.logoUrl,
    required this.city,
    this.foundedDate,
    this.stadiumCapacity,
    required this.stadiumName,
    this.nationalTitles,
    this.internationalTitles,
    required super.state,
    required super.createdAt,
    required super.updatedAt,
  }) : super(type: TeamType.football);

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id, // Evita enviar ID nulo a SQLite si es autoincremental
      'name': name,
      'country': country,
      'headCoach': headCoach,
      'captain': captain,
      'logoUrl': logoUrl,
      'type': type.name,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'city': city,
      'foundedDate': foundedDate?.toIso8601String(),
      'stadiumCapacity': stadiumCapacity,
      'stadiumName': stadiumName,
      'nationalTitles': nationalTitles,
      'internationalTitles': internationalTitles,
    };
  }

    @override
  FootballTeam copyWith({
    int? id,
    String? state,
    DateTime? updatedAt,
  }) {

    return FootballTeam(
      id: id ?? this.id,
      name: name,
      country: country,
      headCoach: headCoach,
      captain: captain,
      logoUrl: logoUrl,
      city: city,
      foundedDate: foundedDate,
      stadiumCapacity: stadiumCapacity,
      stadiumName: stadiumName,
      nationalTitles: nationalTitles,
      internationalTitles: internationalTitles,
      state: state ?? this.state,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory FootballTeam.fromMap(Map<String, dynamic> map) {
    return FootballTeam(
      id: map['id'] as int?,
      name: map['name'] as String,
      country: map['country'] as String,
      headCoach: map['headCoach'] as String?,
      captain: map['captain'] as String?,
      logoUrl: map['logoUrl'] as String,
      city: map['city'] as String,
      foundedDate: map['foundedDate'] != null ? DateTime.parse(map['foundedDate'] as String) : null,
      stadiumCapacity: map['stadiumCapacity'] as int?,
      stadiumName: map['stadiumName'] as String,
      nationalTitles: map['nationalTitles'] as int?,
      internationalTitles: map['internationalTitles'] as int?,
      state: map['state'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}

class NationalTeam extends Team {
  final String continent;
  final String federation;
  final int federationRanking;
  final int federationTitles;
  final int worldCupAppearances;
  final int worldCupTitles;

  NationalTeam({
    super.id,
    required super.name,
    required super.country,
    super.headCoach,
    super.captain,
    required super.logoUrl,
    required this.continent,
    required this.federation,
    required this.federationRanking,
    required this.federationTitles,
    required this.worldCupAppearances,
    required this.worldCupTitles,
    required super.state,
    required super.createdAt,
    required super.updatedAt,
  }) : super(type: TeamType.national);

  @override
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'country': country,
      'headCoach': headCoach,
      'captain': captain,
      'logoUrl': logoUrl,
      'type': type.name,
      'state': state,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'continent': continent,
      'federation': federation,
      'federationRanking': federationRanking,
      'federationTitles': federationTitles,
      'worldCupAppearances': worldCupAppearances,
      'worldCupTitles': worldCupTitles,
    };
  }

    @override
  NationalTeam copyWith({
    int? id,
    String? state,
    DateTime? updatedAt,
  }) {

    return NationalTeam(
      id: id ?? this.id,
      name: name,
      country: country,
      headCoach: headCoach,
      captain: captain,
      logoUrl: logoUrl,
      continent: continent,
      federation: federation,
      federationRanking: federationRanking,
      federationTitles: federationTitles,
      worldCupAppearances: worldCupAppearances,
      worldCupTitles: worldCupTitles,
      state: state ?? this.state,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory NationalTeam.fromMap(Map<String, dynamic> map) {
    return NationalTeam(
      id: map['id'] as int?,
      name: map['name'] as String,
      country: map['country'] as String,
      headCoach: map['headCoach'] as String?,
      captain: map['captain'] as String?,
      logoUrl: map['logoUrl'] as String,
      continent: map['continent'] as String,
      federation: map['federation'] as String,
      federationRanking: map['federationRanking'] as int,
      federationTitles: map['federationTitles'] as int,
      worldCupAppearances: map['worldCupAppearances'] as int,
      worldCupTitles: map['worldCupTitles'] as int,
      state: map['state'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
    );
  }
}
