import Foundation

class CityListPresenterImpl: CityListPresenter {
    
    private var view: CityListView?
    private var cityProvider: CityDataProvider
    private var openWeatherProvider: WeatherRequestProvider
    
    init(cityProvider: CityDataProvider, openWeatherProvider: WeatherRequestProvider) {
        self.cityProvider = cityProvider
        self.openWeatherProvider = openWeatherProvider
    }
    
    func removeCity(city: City) {
        self.cityProvider.deleteCity(aCity: city) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if success && error == nil {
                    weakself.getAllCities()
                }
            }
        }
    }
    
    private func getAllCities() {
        if view == nil { return }
        
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if success && error == nil {
                    weakself.view?.showCities(cities: result)
                }
            }
        }
    }
    
    func reloadCities() {
        if view == nil { return }
        
        self.cityProvider.getAllCities { [weak self] (result, error, success) -> Void in
            if let citiesToFetch = result, let weakself = self, success && error == nil && citiesToFetch.count > 0 {
//                weakself.openWeatherProvider.weatherForCities(citiesToFetch) {
//                    (result, error, success) -> Void in
//                    var newCities = citiesToFetch
//                    if let citiesWithWeather = result {
//                        weakself.updateWeather(forCities: &newCities, withWeatherFromCities: citiesWithWeather)
//                        weakself.view?.showCities(cities: citiesToFetch)
//                    }
//                }
            }
        }
    }
    
    private func updateWeather( forCities cities: inout [City], withWeatherFromCities weatherCities: [City]) {
        for city in cities {
            if let i = cities.index(where: {$0.openWeatherId == city.openWeatherId}) {
                let filteredCity = weatherCities[i]
                city.currentTemperature = filteredCity.currentTemperature
                city.currentHumidity = filteredCity.currentHumidity
                city.weatherDescription = filteredCity.weatherDescription
            }
        }
    }
    
    func attach(view: CityListView?) {
        self.view = view
        self.reloadCities()
    }
    
}
