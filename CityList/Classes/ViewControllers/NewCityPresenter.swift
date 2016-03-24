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
        self.weatherOperation?.cancel()
        self.weatherOperation = openWeatherProvider.weatherByName(string) { [weak self] (result, error, success) -> Void in
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
                        
                        weakself.delegate?.newCityPresenter(weakself, didGetCities: newCities, forString: string, error: nil)
                    })
                } else {
                    weakself.delegate?.newCityPresenter(weakself, didGetCities: nil, forString: string, error: error)
                }
            }
        }
        
    }
    
    func addCityForWeatherList(city: City) {
        cityProvider.addCity(city) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if let cities = result where success && error == nil && cities.count > 0 {
                    weakself.delegate?.newCityPresenter(weakself, didAddCity: cities[0], error: nil)
                } else {
                    weakself.delegate?.newCityPresenter(weakself, didAddCity: city, error: error)
                }
            }
        }
    }
    
    func attach(delegate: NewCityPresenterDelegate?) {
        self.delegate = delegate
    }
}