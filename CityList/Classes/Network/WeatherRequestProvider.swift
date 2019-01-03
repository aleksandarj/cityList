import AFNetworking

protocol WeatherRequestProvider {
    func weatherForCities(_ cities: inout [City], callback: CitiesResultBlock) -> AFHTTPRequestOperation?

    func citiesWithWeatherByName(cityName: String, callback: CitiesResultBlock) -> AFHTTPRequestOperation?
    
}
