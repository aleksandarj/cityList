import Foundation
import UIKit

class CityDetailsViewController: BaseViewController {
    
    private var mPresenter: CityDetailsPresenterProtocol
    
    private let temperatureLabel = UILabel()
    private let humidityLabel = UILabel()
    private let descriptionLabel = UILabel()

    required init(presenter: CityDetailsPresenterProtocol) {
        mPresenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        mPresenter.attach(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        mPresenter.attach(nil)
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupLabels()
    }
    
    
    func updateForCity(newCity: City) {
        self.title = newCity.name ?? NSLocalizedString("City Details", comment: "")
        
        if let temperature = newCity.currentTemperature {
            let tempText = String(temperature)
            temperatureLabel.text = "Temperature: \(tempText) C"
        } else {
            temperatureLabel.text = "Temperature: NaN"
        }
        
        if let humidity = newCity.currentHumidity {
            let humidityText = String(humidity)
            humidityLabel.text = "Humidity: \(humidityText)"
        } else {
            humidityLabel.text = "Humidity: NaN"
        }
        
        let desc = (newCity.weatherDescription ?? "")!
        descriptionLabel.text = "Description: \(desc)"
    }
    
    private func setupLabels() {
        descriptionLabel.numberOfLines = 0
        
        self.view.addSubview(temperatureLabel)
        self.view.addSubview(humidityLabel)
        self.view.addSubview(descriptionLabel)
        
        temperatureLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        humidityLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(temperatureLabel.snp_bottom)
            make.height.equalTo(44)
        }
        
        descriptionLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(humidityLabel.snp_bottom)
            make.height.equalTo(44)
        }
    }
}

extension CityDetailsViewController: CityDetailsPresenterDelegate {
    
    func showCity(city: City?) {
        if let newCity = city {
            updateForCity(newCity)
        }
    }
    
}