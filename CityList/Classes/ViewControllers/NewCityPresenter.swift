import Foundation
import AFNetworking

class NewCityPresenter: NewCityPresenterProtocol {
    
    private var delegate: NewCityPresenterDelegate?
    private var cityProvider: CityDataProviderProtocol
    private var openWeatherProvider: OpenWeatherRequestProviderProtocol
    private var weatherOperation: AFHTTPRequestOperation?
    
    init(cityProvider: CityDataProviderProtocol, openWeatherProvider: OpenWeatherRequestProviderProtocol) {
        self.cityProvider = cityProvider
        self.openWeatherProvider = openWeatherProvider
    }
    
    func getCitiesForString(string: String) {
        if delegate == nil { return }
        
        self.weatherOperation?.cancel()
        self.weatherOperation = openWeatherProvider.citiesWithWeatherByName(string) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if var newCities = result where success && error == nil {
                    weakself.cityProvider.getAllCities({ (result, error, success) -> Void in
                        if let oldCities = result where success && error == nil {
                            for city in oldCities {
                                if let i = newCities.indexOf({$0.openWeatherId == city.openWeatherId}) {
                                    newCities[i].alreadyAdded = true
                                }
                            }
                        }
                        
                        weakself.delegate?.showCities(newCities)
                    })
                } else {
                    weakself.delegate?.showCities(nil)
                }
            }
        }
        
    }
    
    func addCityForWeatherList(city: City) {
        self.delegate?.showHud()
        
        cityProvider.addCity(city) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                weakself.delegate?.hideHud()
                if let cities = result where success && error == nil && cities.count > 0 {
                    weakself.delegate?.reloadView()
                }
            }
        }
    }
    
    func attach(delegate: NewCityPresenterDelegate?) {
        self.delegate = delegate
    }
}