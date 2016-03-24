import Foundation

protocol NewCityPresenterProtocol {
    
    func getCitiesForString(string: String)
    func addCityForWeatherList(city: City)
    func attach(delegate: NewCityPresenterDelegate?)
    
}