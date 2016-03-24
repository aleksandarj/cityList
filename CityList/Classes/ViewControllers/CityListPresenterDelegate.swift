import Foundation

protocol CityListPresenterDelegate {
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didRemoveCity city: City,
        error: NSError?)
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didGetAllCities cities: [City]?,
        error: NSError?)
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didRefreshWeatherData cities: [City]?,
        error: NSError?)
    
}
