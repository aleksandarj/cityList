import Foundation

typealias CitiesResultBlock = (_ result: [City]?, _ error: NSError?, _ success: Bool) -> Void

protocol CityDataProvider {
    
    func getAllCities(completion: CitiesResultBlock)
    
    func deleteCity(aCity: City, completion: CitiesResultBlock?)
    
    func addCity(aCity: City, completion: CitiesResultBlock?)
    
}
