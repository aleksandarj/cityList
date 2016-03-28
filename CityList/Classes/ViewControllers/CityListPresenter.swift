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
                    weakself.getAllCities()
                }
            }
        }
    }
    
    private func getAllCities() {
        if delegate == nil { return }
        
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if success && error == nil {
                    weakself.delegate?.showCities(result)
                }
            }
        }
    }
    
    func reloadCities() {
        if delegate == nil { return }
        
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let citiesToFetch = result, weakself = self where success && error == nil && citiesToFetch.count > 0 {
                weakself.openWeatherProvider.weatherForCities(citiesToFetch) {
                    (result, error, success) -> Void in
                    var newCities = citiesToFetch
                    if let citiesWithWeather = result {
                        weakself.updateWeather(forCities: &newCities, withWeatherFromCities: citiesWithWeather)
                        weakself.delegate?.showCities(citiesToFetch)
                    }
                }
            }
        }
    }
    
    private func updateWeather(inout forCities cities: [City], withWeatherFromCities weatherCities: [City]) {
        for city in cities {
            if let i = weatherCities.indexOf({$0.openWeatherId == city.openWeatherId}) {
                let filteredCity = weatherCities[i]
                city.currentTemperature = filteredCity.currentTemperature
                city.currentHumidity = filteredCity.currentHumidity
                city.weatherDescription = filteredCity.weatherDescription
            }
        }
    }
    
    func attach(delegate: CityListPresenterDelegate?) {
        self.delegate = delegate
        self.reloadCities()
    }
    
}