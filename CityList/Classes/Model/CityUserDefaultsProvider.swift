import Foundation

class CityUserDefaultsProvider: CityDataProvider {
    
    private var defaults = UserDefaults.standard
    
    func getAllCities(completion: CitiesResultBlock) {
        let citiesResult = decodeCities()
        completion(citiesResult, nil, true)
    }
    
    func deleteCity(aCity: City, completion: CitiesResultBlock?) {
        let cities = decodeCities()
        let newCities = cities.filter{$0.openWeatherId != aCity.openWeatherId}
        encodeCities(cities: newCities)
        
        if completion != nil {
            completion!(newCities, nil, true)
        }
    }
    
    func addCity(aCity: City, completion: CitiesResultBlock?) {
        var newCities = decodeCities()
        newCities.append(aCity)
        encodeCities(cities: newCities)
        
        if completion != nil {
            completion!(newCities, nil, true)
        }
    }
    
    private func decodeCities() -> [City] {
        var allCities = [City]()
        
        if let cityData = defaults.data(forKey: Constants.UserDefaults.cities) {
            if let cities = NSKeyedUnarchiver.unarchiveObject(with: cityData) as? [City] {
                allCities = cities
            }
        }
        
        return allCities
    }
    
    private func encodeCities(cities: [City])  {
        let cityData = NSKeyedArchiver.archivedData(withRootObject: cities)
        defaults.set(cityData, forKey: Constants.UserDefaults.cities)
        defaults.synchronize()
    }
}
