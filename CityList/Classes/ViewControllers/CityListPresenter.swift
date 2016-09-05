import Foundation

protocol CityListPresenter {
    
    func removeCity(city: City)
    func reloadCities()
    func attach(view: CityListView?)
    
    // commit 1
    
    // commit 2
}