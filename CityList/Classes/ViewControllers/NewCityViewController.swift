import Foundation
import MBProgressHUD

class NewCityViewController: BaseViewController {
    
    private var mPresenter: NewCityPresenterProtocol
    private var cities = [City]()
    
    private let cid = "cityCellIdentifier"
    private var tableView = UITableView()
    private var searchField = UITextField()
    
    init(presenter: NewCityPresenterProtocol) {
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
        
        setupNavigationBar()
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField() {
        searchField = UITextField()
        searchField.textAlignment = NSTextAlignment.Center
        searchField.placeholder = NSLocalizedString("city name (min 3 letters search)", comment: "")
        searchField.delegate = self
        self.view.addSubview(searchField)
        
        searchField.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.view)
            make.height.equalTo(44)
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cid)
        
        self.view.addSubview(tableView)
        
        tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(searchField.snp_bottom)
            make.left.right.bottom.equalTo(self.view)
        }
    }
    
    private func setupNavigationBar() {
        self.title = NSLocalizedString("Add City", comment: "")
    }
    
    func searchCities(string: String) {
        mPresenter.getCitiesForString(string)
    }
}

extension NewCityViewController: NewCityPresenterDelegate {
    
    func newCityPresenter(presenter: NewCityPresenterProtocol,
        didAddCity city: City,
        error: NSError?) {
        
            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
            
            if error == nil {
                self.searchField.text = nil
                self.cities = [City]()
                self.tableView.reloadData()
            }
    }
    
    func newCityPresenter(presenter: NewCityPresenterProtocol,
        didGetCities cities: [City]?,
        forString string: String,
        error: NSError?) {
        
            if let newCities = cities where error == nil {
                self.cities = newCities
            } else {
                self.cities = [City]()
            }
            
            self.tableView.reloadData()
    }
}

extension NewCityViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate:NSString = searchField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.stringByReplacingCharactersInRange(range, withString: string)
        searchCities(txtAfterUpdate as String)
        
        return true
    }
}

extension NewCityViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row < cities.count {
            MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            
            let city = cities[indexPath.row]
            mPresenter.addCityForWeatherList(city)
        }
    }
    
}

extension NewCityViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cid)
        let city = cities[indexPath.row]
        cell?.textLabel?.text = city.name!
        
        return cell!
    }
}