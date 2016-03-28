import Foundation
import MBProgressHUD

class NewCityViewController: BaseViewController {
    
    private var presenter: NewCityPresenterProtocol
    private var cities = [City]()
    
    private let cid = "cityCellIdentifier"
    private var tableView = UITableView()
    private var searchField = UITextField()
    
    init(presenter: NewCityPresenterProtocol) {
        self.presenter = presenter
        
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
        
        presenter.attach(self)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.attach(nil)
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupNavigationBar()
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField() {
        searchField = UITextField()
        searchField.returnKeyType = UIReturnKeyType.Done
        searchField.borderStyle = UITextBorderStyle.Line
        searchField.textAlignment = NSTextAlignment.Center
        searchField.placeholder = NSLocalizedString("city name search field", comment: "")
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
        presenter.getCitiesForString(string)
    }
}

extension NewCityViewController: NewCityPresenterDelegate {
    
    func showHud() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
    }
    
    func hideHud() {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    
    func reloadView() {
        self.searchField.text = nil
        self.cities = [City]()
        self.tableView.reloadData()
    }
    
    func showCities(cities: [City]?) {
        self.cities = [City]()
        
        if let newCities = cities {
            self.cities = newCities
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
            let city = cities[indexPath.row]
            if city.alreadyAdded { return }
            
            presenter.addCityForWeatherList(city)
        }
    }
    
}

extension NewCityViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.cities.count > 0 {
            TableViewHelpers.setRowsHidden(false, tableView: tableView, text: "")
            return 1
        } else {
            TableViewHelpers.setRowsHidden(true,
                tableView: tableView,
                text: NSLocalizedString("No cities found\nenter search text to find cities\n(enter minimum 3 letters to search", comment: ""))
            return 0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cid)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.textLabel?.textColor = UIColor.blackColor()
        
        let city = cities[indexPath.row]
        var text = city.name!
        
        if city.alreadyAdded {
            text = "\(city.name!) (\(NSLocalizedString("Already added", comment: "")))"
            cell?.textLabel?.textColor = UIColor.darkGrayColor()
        }
        cell?.textLabel?.text = text
        
        return cell!
    }
}