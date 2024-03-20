import 'package:world_country/controller/country_service.dart';
import 'package:world_country/model/country_model.dart';
import 'package:world_country/screens/details_screen.dart';
import 'package:world_country/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountrySearchScreen extends StatefulWidget {
  const CountrySearchScreen({Key? key}) : super(key: key);

  @override
  _CountrySearchScreenState createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  List<Country> _countries = [];
  List<Country> _filteredCountries = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  void _loadCountries() async {
    _countries = await CountryService().fetchCountries();
    setState(() => _filteredCountries = _countries);
  }

  void _searchCountry(String query) {
    final filteredCountries = _countries.where((country) {
      final countryNameLower = country.name.toLowerCase();
      final queryLower = query.toLowerCase();
      return countryNameLower.contains(queryLower);
    }).toList();

    setState(() => _filteredCountries = filteredCountries);
  }

  void _navigateToCountryDetails(Country country, BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return CountryDetailsScreen(
              country: country, isDarkMode: _isDarkMode);
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          _isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor:
            _isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        title: Text(
          'Country Search',
          style: TextStyle(
            color: _isDarkMode
                ? AppColors.darkTextColor
                : AppColors.lightTextColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            color: _isDarkMode ? AppColors.white : AppColors.black,
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40.0,
              child: TextFormField(
                controller: _searchController,
                onChanged: _searchCountry,
                style: TextStyle(
                  color: _isDarkMode
                      ? Colors.white // White text color in dark mode
                      : Colors.black, // Black text color in light mode
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                  labelText: 'Search the Country',
                  labelStyle: TextStyle(
                    color: _isDarkMode
                        ? AppColors.darkTextColor
                        : AppColors.lightTextColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 12.0),
                  isDense: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    color: _isDarkMode ? Colors.white : Colors.black,
                    onPressed: () {
                      _searchController.clear();
                      _searchCountry('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                return GestureDetector(
                  onTap: () => _navigateToCountryDetails(country, context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: _isDarkMode ? Colors.grey[900] : Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                _isDarkMode ? Colors.grey[900] : Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Hero(
                                      tag: country.flag,
                                      child: SvgPicture.network(
                                        country.flag,
                                        width: 50,
                                        height: 50,
                                        placeholderBuilder:
                                            (BuildContext context) => SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              _isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Flexible(
                                  child: Text(
                                    country.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: _isDarkMode
                                          ? AppColors.darkTextColor
                                          : AppColors.lightTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
