import Foundation

class CityDetailsPresenter: CityDetailsPresenterProtocol {
    
    private var delegate: CityDetailsPresenterDelegate?
    private var openWeatherProvider: OpenWeatherRequestProviderProtocol
    
    init(openWeatherProvider: OpenWeatherRequestProviderProtocol) {
        self.openWeatherProvider = openWeatherProvider
    }
    
    func getWeatherDetails(city: City) {
        openWeatherProvider.weatherForCities([city]) {
            [weak self](result, error, success) -> Void in
            
            if let weakself = self {
                if let cities = result where success && error == nil && cities.count > 0 {
                    weakself.delegate?.cityDetailsPresenter(weakself, didGetWeatherDetailsForCity: cities[0], error: nil)
                } else {
                    weakself.delegate?.cityDetailsPresenter(weakself, didGetWeatherDetailsForCity: nil, error: error)
                }
            }
        }
    }
    
    func attach(delegate: CityDetailsPresenterDelegate?) {
        self.delegate = delegate
    }
    
}