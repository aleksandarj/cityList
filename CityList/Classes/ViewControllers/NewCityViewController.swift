import Foundation
import MBProgressHUD

class NewCityViewController: BaseViewController {
    
    private var presenter: NewCityPresenter
    private var cities = [City]()
    
    private let cid = "cityCellIdentifier"
    private var tableView = UITableView()
    private var searchField = UITextField()
    
    init(presenter: NewCityPresenter) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.attach(view: self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter.attach(view: nil)
    }
    
    private func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        setupNavigationBar()
        setupSearchField()
        setupTableView()
    }
    
    private func setupSearchField() {
        searchField = UITextField()
        searchField.returnKeyType = UIReturnKeyType.done
        searchField.borderStyle = UITextBorderStyle.line
        searchField.textAlignment = NSTextAlignment.center
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cid)
        
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
        presenter.getCitiesForString(string: string)
    }
}

extension NewCityViewController: NewCityView {
    
    func showHud() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideHud() {
        MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
    }
    
    func resetSearchField() {
        self.searchField.text = nil
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
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        searchCities(string: txtAfterUpdate as String)
        
        return true
    }
}

extension NewCityViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: IndexPath) {
        if indexPath.row < cities.count {
            let city = cities[indexPath.row]
            if city.alreadyAdded { return }
            
            presenter.addCityForWeatherList(city: city)
        }
    }
    
}

extension NewCityViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.cities.count > 0 {
            TableViewHelpers.setRowsHidden(rowsHidden: false, tableView: tableView, text: "")
            return 1
        } else {
            TableViewHelpers.setRowsHidden(rowsHidden: true,
                tableView: tableView,
                text: NSLocalizedString("No cities found\nenter search text to find cities\n(enter minimum 3 letters to search", comment: ""))
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cid)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        cell?.textLabel?.textColor = UIColor.black
        
        let city = cities[indexPath.row]
        var text = city.name!
        
        if city.alreadyAdded {
            text = "\(city.name!) (\(NSLocalizedString("Already added", comment: "")))"
            cell?.textLabel?.textColor = UIColor.darkGray
        }
        cell?.textLabel?.text = text
        
        return cell!
    }
}
