class WeatherModel {
  int id;
  String name;
  double lon;
  double lat;
  String description;
  String icon;
  int tempKel;
  int tempFahr;
  int tempCel;
  int visibility;
  double windSpeed;
  int humibity;

  WeatherModel(this.id, this.lon, this.lat, this.name, this.description,
      this.icon, this.tempKel, this.visibility, this.windSpeed, this.humibity) {
    this.tempCel = (this.tempKel - 273.0).round();
    this.tempFahr = (1.8 * (this.tempKel - 273.0) + 32.0).round();
    this.icon = 'https://openweathermap.org/img/wn/' + this.icon + '.png';
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      json['id'],
      json['coord']['lon'].toDouble(),
      json['coord']['lat'].toDouble(),
      json['name'],
      json['weather'][0]['description'],
      json['weather'][0]['icon'],
      json['main']['temp'].round(),
      json['visibility'],
      json['wind']['speed'].toDouble(),
      json['main']['humidity']);
}
