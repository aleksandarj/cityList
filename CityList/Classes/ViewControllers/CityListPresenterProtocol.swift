import Foundation

protocol CityListPresenterProtocol {
    
    func removeCity(city: City)
    func reloadCities()
    func attach(delegate: CityListPresenterDelegate?)
    
}