import Foundation

protocol NewCityPresenter {
    
    func getCitiesForString(string: String)
    func addCityForWeatherList(city: City)
    func attach(view: NewCityView?)
    
}