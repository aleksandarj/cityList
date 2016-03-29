import Foundation

typealias CitiesResultBlock = (result: [City]?, error: NSError?, success: Bool) -> Void

protocol CityDataProvider {
    
    func getAllCities(completion: CitiesResultBlock)
    
    func deleteCity(aCity: City, completion: CitiesResultBlock?)
    
    func addCity(aCity: City, completion: CitiesResultBlock?)
    
}