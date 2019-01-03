import Foundation

class CityDetailsPresenterImpl: CityDetailsPresenter {
    
    private var view: CityDetailsView?
    private var openWeatherProvider: WeatherRequestProvider
    private var city: City
    
    init(openWeatherProvider: WeatherRequestProvider, city: City) {
        self.openWeatherProvider = openWeatherProvider
        self.city = city
    }
    
    func getWeatherDetails(city: City) {
        if view == nil { return }
        
//        openWeatherProvider.weatherForCities([city]) {
//            [weak self](result, error, success) -> Void in
//            
//            if let weakself = self {
//                if let cities = result, success && error == nil && cities.count > 0 {
//                    weakself.view?.showCity(city: cities[0])
//                }
//            }
//        }
    }
    
    func attach(view: CityDetailsView?) {
        self.view = view
        self.getWeatherDetails(city: self.city)
    }
    
}
