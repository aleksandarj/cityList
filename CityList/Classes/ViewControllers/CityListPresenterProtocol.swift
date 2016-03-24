import Foundation

protocol CityListPresenterProtocol {
    
    func removeCity(city: City)
    func getAllCities()
    func refreshWeatherData()
    func updateWeather(inout forCities cities: [City], withWeatherFromCities weatherCities: [City])
    func attach(delegate: CityListPresenterDelegate?)
    
}