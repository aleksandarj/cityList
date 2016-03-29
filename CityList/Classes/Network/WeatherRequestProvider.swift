import AFNetworking

protocol WeatherRequestProvider {
    func weatherForCities(var cities: [City], callback: CitiesResultBlock) -> AFHTTPRequestOperation?
    
    func citiesWithWeatherByName(cityName: String, callback: CitiesResultBlock) -> AFHTTPRequestOperation?
    
}