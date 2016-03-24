import Foundation

protocol CityDetailsPresenterProtocol {
    
    func getWeatherDetails(city: City)
    func attach(delegate: CityDetailsPresenterDelegate?)
    
}