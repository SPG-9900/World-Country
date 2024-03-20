import 'package:world_country/model/country_model.dart';
import 'package:world_country/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;
  final bool isDarkMode;

  const CountryDetailsScreen(
      {Key? key, required this.country, required this.isDarkMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? AppColors.darkBackground : AppColors.lightBackground,
        title: Text(
          country.name,
          style: TextStyle(
            color:
                isDarkMode ? AppColors.darkTextColor : AppColors.lightTextColor,
          ),
        ),
        automaticallyImplyLeading: true, // Set to true by default
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? AppColors.white : AppColors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Hero(
                    tag: country.flag,
                    child: SvgPicture.network(
                      country.flag,
                      width: 200,
                      height: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildDetailItem('Currencies:', country.currenciesString),
              _buildDetailItem('Languages:', country.languagesString),
              _buildDetailItem('map:', country.maps),
              _buildDetailItem('Timezones:', country.timezonesString),
              _buildDetailItem('Continents:', country.continentsString),
              _buildDetailItem('Start of Week:', country.startOfWeek),
              _buildDetailItem('Area:', '${country.area} square kilometers'),
              _buildDetailItem('Population:', '${country.population}'),
              _buildDetailItem(
                  'Independent:', country.independent ? 'Yes' : 'No'),
              _buildDetailItem('Region:', country.region),
              _buildDetailItem('Subregion:', country.subregion),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    IconData iconData;
    switch (label) {
      case 'Currencies:':
        iconData = Icons.attach_money;
        break;
      case 'Languages:':
        iconData = Icons.language;
        break;
      case 'map:':
        iconData = Icons.map;
        break;
      case 'Timezones:':
        iconData = Icons.access_time;
        break;
      case 'Continents:':
        iconData = Icons.public;
        break;
      case 'Start of Week:':
        iconData = Icons.calendar_today;
        break;
      case 'Area:':
        iconData = Icons.square_foot;
        break;
      case 'Population:':
        iconData = Icons.people;
        break;
      case 'Independent:':
        iconData = Icons.security;
        break;
      case 'Region:':
        iconData = Icons.location_on;
        break;
      case 'Subregion:':
        iconData = Icons.location_city;
        break;
      default:
        iconData = Icons.error_outline;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.grey, // Using AppColors for consistency
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            iconData,
            size: 20,
            color: AppColors.black,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: isDarkMode
                      ? AppColors.darkTextColor
                      : AppColors.lightTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
