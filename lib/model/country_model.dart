class Country {
  final String name;
  final String flag;
  final String maps;
  final Map<String, dynamic> currencies;
  final Map<String, dynamic> languages;
  final List<String> timezones;
  final List<String> continents;
  final String startOfWeek;
  final double area;
  final int population;
  final String region;
  final String subregion;
  final bool independent;

  Country({
    required this.name,
    required this.flag,
    required this.maps,
    required this.currencies,
    required this.languages,
    required this.timezones,
    required this.continents,
    required this.startOfWeek,
    required this.area,
    required this.population,
    required this.region,
    required this.subregion,
    required this.independent,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      flag: json['flags']['svg'],
      maps: json['maps'] != null ? json['maps']['googleMaps'] : '',
      currencies: json['currencies'] ?? {},
      languages: json['languages'] ?? {},
      timezones: List<String>.from(json['timezones'] ?? []),
      continents: List<String>.from(json['continents'] ?? []),
      startOfWeek: json['startOfWeek'] ?? "",
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      population: json['population'] ?? 0,
      region: json['region'] ?? "",
      subregion: json['subregion'] ?? "",
      independent: json['independent'] != "monarchy",
    );
  }

  String get currenciesString => currencies.entries
      .map((e) => "${e.value['name']} (${e.value['symbol']})")
      .join(', ');

  String get languagesString =>
      languages.entries.map((e) => "${e.value}").join(', ');

  String get timezonesString => timezones.join(', ');
  String get continentsString => continents.join(', ');
}
