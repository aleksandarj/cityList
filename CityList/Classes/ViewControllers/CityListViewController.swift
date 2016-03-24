import Foundation
import SnapKit
import SVPullToRefresh

class CityListViewController: BaseViewController {
    
    private var mPresenter: CityListPresenterProtocol
    private var cities = [City]()
    
    private let cid = "cityCellIdentifier"
    private var tableView = UITableView()
    
    init(presenter: CityListPresenterProtocol) {
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
        mPresenter.getAllCities()
        if cities.count > 0 {
            mPresenter.refreshWeatherData()
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        mPresenter.attach(nil)
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.whiteColor()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cid)
        tableView.addPullToRefreshWithActionHandler {[weak self] () -> Void in
            if let weakself = self {
                weakself.mPresenter.refreshWeatherData()
            }
        }
        
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
    }
    
    private func setupNavigationBar() {
        self.title = NSLocalizedString("City List", comment: "")
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add,
            target: self,
            action: Selector("onRightBarButton"))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func onRightBarButton() {
        let newCityContorller = MainAssembly.sharedInstance.newCityViewController()
        self.navigationController?.pushViewController(newCityContorller, animated: true)
    }
}

extension CityListViewController: CityListPresenterDelegate {
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didRemoveCity city: City,
        error: NSError?) {
        
            if error == nil {
                mPresenter.getAllCities()
            }
    }
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didGetAllCities cities: [City]?,
        error: NSError?)
    {
        if let newCities = cities where error == nil {
            self.cities = newCities
            self.tableView.reloadData()
        }
    }
    
    func cityListPresenter(presenter: CityListPresenterProtocol,
        didRefreshWeatherData cities: [City]?,
        error: NSError?)
    {
        tableView.pullToRefreshView?.stopAnimating()
        
        if let newCities = cities where error == nil {
            self.cities = newCities
            self.tableView.reloadData()
        }
    }
}

extension CityListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < cities.count {
            let city = cities[indexPath.row]
            
            let cityDetails = MainAssembly.sharedInstance.cityDetailsViewController(city)
            self.navigationController?.pushViewController(cityDetails, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if (editingStyle == UITableViewCellEditingStyle.Delete) {
                let city = cities[indexPath.row]
                mPresenter.removeCity(city)
            }
    }
}

extension CityListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.cities.count > 0 {
            TableViewHelpers.setRowsHidden(false, tableView: tableView, text: "")
            return 1
        } else {
            TableViewHelpers.setRowsHidden(true,
                tableView: tableView,
                text: NSLocalizedString("No cities added\nadd cities by pressing on\nthe top plus button", comment: ""))
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cid)
        let city = cities[indexPath.row]
        
        if let name = city.name {
            var text = name
            if let temp = city.currentTemperature {
                text = "\(name), \(temp) C"
            }
            
            cell?.textLabel?.text = text
        }
        
        return cell!
    }
}