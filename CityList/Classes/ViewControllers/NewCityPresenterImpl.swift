import Foundation
import AFNetworking

class NewCityPresenterImpl: NewCityPresenter {
    
    private var view: NewCityView?
    private var cityProvider: CityDataProvider
    private var openWeatherProvider: WeatherRequestProvider
    private var weatherOperation: AFHTTPRequestOperation?
    
    init(cityProvider: CityDataProvider, openWeatherProvider: WeatherRequestProvider) {
        self.cityProvider = cityProvider
        self.openWeatherProvider = openWeatherProvider
    }
    
    func getCitiesForString(string: String) {
        if view == nil { return }
        
        self.weatherOperation?.cancel()
        self.weatherOperation = openWeatherProvider.citiesWithWeatherByName(cityName: string) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                if var newCities = result, success && error == nil {
                    weakself.cityProvider.getAllCities(completion: { (result, error, success) -> Void in
                        if let oldCities = result, success && error == nil {
                            for city in oldCities {
                                if let i = newCities.index(where: {$0.openWeatherId == city.openWeatherId}) {
                                    newCities[i].alreadyAdded = true
                                }
                            }
                        }
                        
                        weakself.view?.showCities(cities: newCities)
                    })
                } else {
                    weakself.view?.showCities(cities: nil)
                }
            }
        }
        
    }
    
    func addCityForWeatherList(city: City) {
        self.view?.showHud()
        
        cityProvider.addCity(aCity: city) { [weak self] (result, error, success) -> Void in
            if let weakself = self {
                weakself.view?.hideHud()
                if let cities = result, success && error == nil && cities.count > 0 {
                    weakself.view?.resetSearchField()
                    weakself.view?.showCities(cities: nil)
                }
            }
        }
    }
    
    func attach(view: NewCityView?) {
        self.view = view
    }
}
