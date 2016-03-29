import Foundation

protocol CityListPresenter {
    
    func removeCity(city: City)
    func reloadCities()
    func attach(view: CityListView?)
    
}