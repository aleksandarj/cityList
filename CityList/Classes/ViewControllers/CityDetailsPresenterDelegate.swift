import Foundation

protocol CityDetailsPresenterDelegate {
    
    func cityDetailsPresenter(presenter: CityDetailsPresenterProtocol,
        didGetWeatherDetailsForCity city: City?,
        error: NSError?)
    
}