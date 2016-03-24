import Foundation

struct Constants {
    
    struct Network {
        
        static let openWeatherAppId = "7f96be097b134cbd7d4d871f61c2a802"
        static let appIdParam = "&APPID=%@"
        static let baseUrl = "http://api.openweathermap.org/data/2.5"
        static let weatherByName = "weather?q=%@&units=metric"
        static let find = "find?q=%@&type=like&units=metric"
        static let weatherForCities = "group?id=%@&units=metric"
        
    }
    
    struct UserDefaults {
        
        static let cities = "cities"
        static let openWeatherId = "openWeatherId"
        static let name = "name"
        static let currentTemperature = "currentTemperature"
        static let currentHumidity = "currentHumidity"
        static let weatherDescription = "weatherDescription"
        
    }
    
    struct CityJson {
        
        static let list = "list"
        static let cityId = "id"
        static let weather = "weather"
        static let main = "main"
        static let description = "description"
        static let temperature = "temp"
        static let humidity = "humidity"
        
    }
    
}