import Foundation

protocol NewCityPresenterDelegate {
    
    func showCities(cities: [City]?)
    
    func reloadView()
    
    func showHud()
    
    func hideHud()
}