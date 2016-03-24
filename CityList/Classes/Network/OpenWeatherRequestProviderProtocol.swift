import AFNetworking

protocol OpenWeatherRequestProviderProtocol {
    
    init(networkDatasource: NetworkDatasource)
    
    func weatherForCities(var cities: [City], callback: CitiesResultBlock) -> AFHTTPRequestOperation?
    
    func weatherByName(name: String, callback: CitiesResultBlock) -> AFHTTPRequestOperation?
    
}