class HomeMenuItem {
  String title, subtitle, teamsOrigin, emoji;

  HomeMenuItem({
    required this.title,
    required this.subtitle,
    required this.teamsOrigin,
    required this.emoji,
  });
}

final List<HomeMenuItem> homeMenuItems = [
  HomeMenuItem(
    title: 'National Teams',
    subtitle: 'List only National Teams',
    teamsOrigin: 'Nationals',
    emoji: '🌍',
  ),
  HomeMenuItem(
    title: 'Futbol Teams',
    subtitle: 'List all Football Teams',
    teamsOrigin: 'All',
    emoji: '⚽',
  ),
  HomeMenuItem(
    title: 'Argentina',
    subtitle: 'List Teams from Argentina',
    teamsOrigin: 'Argentina',
    emoji: '🇦🇷',
  ),
  HomeMenuItem(
    title: 'Brazil',
    subtitle: 'List Teams from Brazil',
    teamsOrigin: 'Brazil',
    emoji: '🇧🇷',
  ),
  HomeMenuItem(
    title: 'Spain',
    subtitle: 'List Teams from Spain',
    teamsOrigin: 'Spain',
    emoji: '🇪🇸',
  ),
  HomeMenuItem(
    title: 'England',
    subtitle: 'List Teams from England',
    teamsOrigin: 'England',
    emoji: '🇬🇧',
  ),
  HomeMenuItem(
    title: 'France',
    subtitle: 'List Teams from France',
    teamsOrigin: 'France',
    emoji: '🇫🇷',
  ),
  HomeMenuItem(
    title: 'Germany',
    subtitle: 'List Teams from Germany',
    teamsOrigin: 'Germany',
    emoji: '🇩🇪',
  ),
  HomeMenuItem(
    title: 'Italy',
    subtitle: 'List Teams from Italy',
    teamsOrigin: 'Italy',
    emoji: '🇮🇹',
  ),
  
];
