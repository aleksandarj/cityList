import Foundation

class City: NSObject, NSCoding {
    
    var openWeatherId: String?
    var name: String?
    var currentTemperature: Float?
    var currentHumidity: Float?
    var weatherDescription: String?
    var alreadyAdded = false
    
    required init(openWeatherId: String,
        name: String,
        currentTemperature: Float?,
        currentHumidity: Float?,
        weatherDescription: String?) {
            self.openWeatherId = openWeatherId
            self.name = name
            self.currentTemperature = currentTemperature
            self.currentHumidity = currentHumidity
            self.weatherDescription = weatherDescription
            super.init()
    }
    
    convenience init(json: [String : AnyObject]) {
        self.init(
            openWeatherId: String(json[Constants.CityJson.cityId] as! Int),
            name: json[Constants.UserDefaults.name] as! String,
            currentTemperature: json[Constants.CityJson.main]![Constants.CityJson.temperature] as? Float,
            currentHumidity: json[Constants.CityJson.main]![Constants.CityJson.humidity] as? Float,
            weatherDescription: json[Constants.CityJson.weather]![0][Constants.CityJson.description] as? String)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.openWeatherId = aDecoder.decodeObjectForKey(Constants.UserDefaults.openWeatherId) as? String
        self.name = aDecoder.decodeObjectForKey(Constants.UserDefaults.name) as? String
        self.currentTemperature = aDecoder.decodeObjectForKey(Constants.UserDefaults.currentTemperature) as? Float
        self.currentHumidity = aDecoder.decodeObjectForKey(Constants.UserDefaults.currentHumidity) as? Float
        self.weatherDescription = aDecoder.decodeObjectForKey(Constants.UserDefaults.weatherDescription) as? String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let anOpenWeatherId = openWeatherId as? AnyObject {
            aCoder.encodeObject(anOpenWeatherId, forKey: Constants.UserDefaults.openWeatherId)
        }
        
        if let aName = name as? AnyObject {
            aCoder.encodeObject(aName, forKey: Constants.UserDefaults.name)
        }
        
        if let aCurrentTemperature = currentTemperature {
            aCoder.encodeObject(aCurrentTemperature, forKey: Constants.UserDefaults.currentTemperature)
        }
        
        if let aCurrentHumidity = currentHumidity as? AnyObject {
            aCoder.encodeObject(aCurrentHumidity, forKey: Constants.UserDefaults.currentHumidity)
        }
        
        if let aWeatherDescription = weatherDescription as? AnyObject {
            aCoder.encodeObject(aWeatherDescription, forKey: Constants.UserDefaults.weatherDescription)
        }
    }
}