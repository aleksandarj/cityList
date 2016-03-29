import Foundation
import AFNetworking

class OpenWeatherRequestProvider: WeatherRequestProvider {
    
    private let networkDatasource: NetworkDatasource
    
    required init(networkDatasource: NetworkDatasource) {
        self.networkDatasource = networkDatasource
    }
    
    func weatherForCities(var cities: [City], callback: CitiesResultBlock) -> AFHTTPRequestOperation? {
        if cities.count > 0 {
            var ids = cities[0].openWeatherId!
            cities.removeFirst()
            for city in cities {
                ids += ",\(city.openWeatherId!)"
            }
        
            let endpoint = String(format: Constants.Network.weatherForCities, arguments: [ids])
            let url = networkDatasource.addAppIdToUrlString(endpoint)
            
            return networkDatasource.GET(url,
                parameters: nil,
                success: { (operation, responseObject) -> () in
                    if let responseObject = responseObject[Constants.CityJson.list] as? [[String : AnyObject]] {
                        var cities = [City]()
                        
                        for json in responseObject {
                            let city = City(json: json)
                            cities.append(city)
                        }
                        
                        callback(result: cities, error: nil, success: true)
                    } else if let responseObject = responseObject as? [String : AnyObject] {
                        var cities = [City]()
                        let city = City(json: responseObject)
                        cities.append(city)
                        
                        callback(result: cities, error: nil, success: true)
                    }
                },
                failure: { (operation, error) -> () in
                    callback(result: nil, error: error, success: false)
            })
        }
        
        callback(result: nil, error: nil, success: false)
        
        return nil
    }
    
    private func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
        Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    func citiesWithWeatherByName(cityName: String, callback: CitiesResultBlock) -> AFHTTPRequestOperation? {
//        let encodedName = name.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        // for some reason open weather doesn't accept white spaces even when encoded with url encoding (%20 used)
        // just in case i trimm the search keyword from all the special characters

        let trimmedName = removeSpecialCharsFromString(cityName)
        
        if trimmedName.characters.count > 2 {
            let endpoint = String(format: Constants.Network.find, arguments: [trimmedName])
            let url = networkDatasource.addAppIdToUrlString(endpoint)
            
            return networkDatasource.GET(url,
                parameters: nil,
                success: { (operation, responseObject) -> () in
                    if let responseObject = responseObject[Constants.CityJson.list] as? [[String : AnyObject]] {
                        
                        var cities = [City]()
                        
                        for json in responseObject {
                            let city = City(json: json)
                            cities.append(city)
                        }
                        
                        callback(result: cities, error: nil, success: true)
                    } else if let responseObject = responseObject as? [String : AnyObject] {
                        var cities = [City]()
                        let city = City(json: responseObject)
                        cities.append(city)
                        
                        callback(result: cities, error: nil, success: true)
                    }
                },
                failure: { (operation, error) -> () in
                    callback(result: nil, error: error, success: false)
            })
        }
        
        callback(result: nil, error: nil, success: false)
        
        return nil
    }
}