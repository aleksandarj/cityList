import Foundation

class CityUserDefaultsProvider: CityDataProvider {
    
    private var defaults = NSUserDefaults.standardUserDefaults()
    
    func getAllCities(completion: CitiesResultBlock) {
        let citiesResult = decodeCities()
        completion(result: citiesResult, error: nil, success: true)
    }
    
    func deleteCity(aCity: City, completion: CitiesResultBlock?) {
        let cities = decodeCities()
        let newCities = cities.filter{$0.openWeatherId != aCity.openWeatherId}
        encodeCities(newCities)
        
        if completion != nil {
            completion!(result: newCities, error: nil, success: true)
        }
    }
    
    func addCity(aCity: City, completion: CitiesResultBlock?) {
        var newCities = decodeCities()
        newCities.append(aCity)
        encodeCities(newCities)
        
        if completion != nil {
            completion!(result: newCities, error: nil, success: true)
        }
    }
    
    private func decodeCities() -> [City] {
        var allCities = [City]()
        
        if let cityData = defaults.dataForKey(Constants.UserDefaults.cities) {
            if let cities = NSKeyedUnarchiver.unarchiveObjectWithData(cityData) as? [City] {
                allCities = cities
            }
        }
        
        return allCities
    }
    
    private func encodeCities(cities: [City])  {
        let cityData = NSKeyedArchiver.archivedDataWithRootObject(cities)
        defaults.setObject(cityData, forKey: Constants.UserDefaults.cities)
        defaults.synchronize()
    }
}