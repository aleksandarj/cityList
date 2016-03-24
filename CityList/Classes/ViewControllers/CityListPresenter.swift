import Foundation

class CityListPresenter: CityListPresenterProtocol {
    
    private var delegate: CityListPresenterDelegate?
    private var cityProvider: CityDataProviderProtocol
    private var openWeatherProvider: OpenWeatherRequestProviderProtocol
    
    init(cityProvider: CityDataProviderProtocol, openWeatherProvider: OpenWeatherRequestProviderProtocol) {
        self.cityProvider = cityProvider
        self.openWeatherProvider = openWeatherProvider
    }
    
    func removeCity(city: City) {
        self.cityProvider.deleteCity(city) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if success && error == nil {
                    weakself.delegate?.cityListPresenter(weakself, didGetAllCities: result, error: nil)
                } else {
                    weakself.delegate?.cityListPresenter(weakself, didGetAllCities: nil, error: error)
                }
            }
        }
    }
    
    func getAllCities() {
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if success && error == nil {
                    weakself.delegate?.cityListPresenter(weakself, didGetAllCities: result, error: nil)
                } else {
                    weakself.delegate?.cityListPresenter(weakself, didGetAllCities: nil, error: error)
                }
            }
        }
    }
    
    func refreshWeatherData() {
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let citiesToFetch = result, weakself = self where success && error == nil && citiesToFetch.count > 0 {
                weakself.openWeatherProvider.weatherForCities(citiesToFetch) {
                    (result, error, success) -> Void in
                    weakself.delegate?.cityListPresenter(weakself, didRefreshWeatherData: result, error: error)
                }
            }
        }
    }
    
    
    func attach(delegate: CityListPresenterDelegate?) {
        self.delegate = delegate
    }
    
}