import Foundation

class MainAssembly: NSObject {
    
    static let sharedInstance = MainAssembly()
    
    func errorHandler() -> ErrorManager {
        return ErrorManager.sharedInstance
    }
    
    // Data Providers
    
    func networkDatasource() -> NetworkDatasource {
        return NetworkDatasource.sharedInstance
    }
    
    func weatherRequestProvider() -> WeatherRequestProvider {
        let openWeatherProvider = OpenWeatherRequestProvider(networkDatasource: MainAssembly.sharedInstance.networkDatasource())
        return openWeatherProvider
    }
    
    func cityDataProvider() -> CityDataProvider {
        return CityUserDefaultsProvider()
    }
    
    // City List
    
    func cityListPresenter() -> CityListPresenter {
        let presenter = CityListPresenterImpl(cityProvider: MainAssembly.sharedInstance.cityDataProvider(),
            openWeatherProvider: MainAssembly.sharedInstance.weatherRequestProvider())
        return presenter
    }
    
    func cityListViewController() -> CityListViewController {
        let controller = CityListViewController(presenter: MainAssembly.sharedInstance.cityListPresenter())
        return controller
    }
    
    // City Details
    
    func cityDetailsPresenter(city: City) -> CityDetailsPresenter {
        let presenter = CityDetailsPresenterImpl(openWeatherProvider: MainAssembly.sharedInstance.weatherRequestProvider(), city: city)
        return presenter
    }
    
    func cityDetailsViewController(city: City) -> CityDetailsViewController {
        let presenter = MainAssembly.sharedInstance.cityDetailsPresenter(city)
        let controller = CityDetailsViewController(presenter: presenter)
        return controller
    }
    
    // New City
    
    func newCityPresenter() -> NewCityPresenter {
        let cityDataProvider = MainAssembly.sharedInstance.cityDataProvider()
        let openWeatherProvider = MainAssembly.sharedInstance.weatherRequestProvider()
        let presenter = NewCityPresenterImpl(cityProvider: cityDataProvider, openWeatherProvider: openWeatherProvider)
        return presenter
    }
    
    func newCityViewController() -> NewCityViewController {
        let presenter = MainAssembly.sharedInstance.newCityPresenter()
        let controller = NewCityViewController(presenter: presenter)
        return controller
    }
}