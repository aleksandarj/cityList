import Foundation

class MainAssembly: NSObject {
    
    static let sharedInstance = MainAssembly()
    
    // Data Providers
    
    func networkDatasource() -> NetworkDatasource {
        return NetworkDatasource.sharedInstance
    }
    
    func openWeatherRequestProvider() -> OpenWeatherRequestProvider {
        let openWeatherProvider = OpenWeatherRequestProvider(networkDatasource: MainAssembly.sharedInstance.networkDatasource())
        return openWeatherProvider
    }
    
    func cityDataProvider() -> CityDataProviderProtocol {
        return CityUserDefaultsProvider()
    }
    
    // City List
    
    func cityListPresenter() -> CityListPresenterProtocol {
        let presenter = CityListPresenter(cityProvider: MainAssembly.sharedInstance.cityDataProvider(),
            openWeatherProvider: MainAssembly.sharedInstance.openWeatherRequestProvider())
        return presenter
    }
    
    func cityListViewController() -> CityListViewController {
        let controller = CityListViewController(presenter: MainAssembly.sharedInstance.cityListPresenter())
        return controller
    }
    
    // City Details
    
    func cityDetailsPresenter() -> CityDetailsPresenterProtocol {
        let presenter = CityDetailsPresenter(openWeatherProvider: MainAssembly.sharedInstance.openWeatherRequestProvider())
        return presenter
    }
    
    func cityDetailsViewController(city: City) -> CityDetailsViewController {
        let presenter = MainAssembly.sharedInstance.cityDetailsPresenter()
        let controller = CityDetailsViewController(city: city, presenter: presenter)
        return controller
    }
    
    // New City
    
    func newCityPresenter() -> NewCityPresenterProtocol {
        let cityDataProvider = MainAssembly.sharedInstance.cityDataProvider()
        let openWeatherProvider = MainAssembly.sharedInstance.openWeatherRequestProvider()
        let presenter = NewCityPresenter(cityProvider: cityDataProvider, openWeatherProvider: openWeatherProvider)
        return presenter
    }
    
    func newCityViewController() -> NewCityViewController {
        let presenter = MainAssembly.sharedInstance.newCityPresenter()
        let controller = NewCityViewController(presenter: presenter)
        return controller
    }
}