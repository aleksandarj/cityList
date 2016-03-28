import Foundation

class CityDetailsPresenter: CityDetailsPresenterProtocol {
    
    private var delegate: CityDetailsPresenterDelegate?
    private var openWeatherProvider: OpenWeatherRequestProviderProtocol
    private var city: City
    
    init(openWeatherProvider: OpenWeatherRequestProviderProtocol, city: City) {
        self.openWeatherProvider = openWeatherProvider
        self.city = city
    }
    
    func getWeatherDetails(city: City) {
        if delegate == nil { return }
        
        openWeatherProvider.weatherForCities([city]) {
            [weak self](result, error, success) -> Void in
            
            if let weakself = self {
                if let cities = result where success && error == nil && cities.count > 0 {
                    weakself.delegate?.showCity(cities[0])
                }
            }
        }
    }
    
    func attach(delegate: CityDetailsPresenterDelegate?) {
        self.delegate = delegate
        self.getWeatherDetails(self.city)
    }
    
}