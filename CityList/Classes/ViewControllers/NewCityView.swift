import Foundation

protocol NewCityView {
    
    func showCities(cities: [City]?)
    
    func resetSearchField()
    
    func showHud()
    
    func hideHud()
}