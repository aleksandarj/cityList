import Foundation

protocol CityListPresenterProtocol {
    
    func removeCity(city: City)
    func getAllCities()
    func refreshWeatherData()
    func attach(delegate: CityListPresenterDelegate?)
    
}