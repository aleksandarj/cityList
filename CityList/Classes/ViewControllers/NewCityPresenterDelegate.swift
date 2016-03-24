import Foundation

protocol NewCityPresenterDelegate {
    
    func newCityPresenter(presenter: NewCityPresenterProtocol,
        didGetCities cities: [City]?,
        forString string: String,
        error: NSError?)
    
    func newCityPresenter(presenter: NewCityPresenterProtocol,
        didAddCity city: City,
        error: NSError?)
}