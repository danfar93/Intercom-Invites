import UIKit

class HomeViewController: UIViewController {

    var allCustomersArray = [Customer]()
    var invitedCustomersArray = [Customer]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    /// image view for intercom invites logo
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Intercom-Invites")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// button for getting invite list
    let getInviteListButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Constants.primaryColor
        button.titleLabel?.font = UIFont(name: Constants.appFontBold, size: 18)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Get Invite List", for: .normal)
        button.layer.cornerRadius = 26
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(getInviteListTapped), for: .touchUpInside)
        return button
    }()

    func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(getInviteListButton)

        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),

            getInviteListButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            getInviteListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            getInviteListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            getInviteListButton.heightAnchor.constraint(equalToConstant: Constants.buttonHeight)
        ])
    }

    /// converts customers.txt to a string and seperates by line
    /// - Parameter filename: the filename to convert to an array of strings
    func convertTxtFileToCustomerLinesArray(filename: String)  {
        var customerFileString = String()
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                customerFileString = try String(contentsOfFile: path, encoding: .utf8)
                let customerLinesArray = customerFileString.components(separatedBy: .newlines)
                for customerLine in customerLinesArray {
                    try convertEachLinetoJsonObject(customerLine: customerLine)
                }
            } catch {
                print(error)
            }
        }
    }

    /// converts each line of customers.txt to JSON Objects and adds customers to allCustomersArray & invitedCustomersArray
    /// - Parameter customerLine: each line from the customer.txt file
    func convertEachLinetoJsonObject(customerLine: String) throws {
        let data = Data(customerLine.utf8)

        do {
            let customer = try JSONDecoder().decode(Customer.self, from: data)
            self.allCustomersArray.append(customer)
            if customerInviteValidator(customer: customer) {
                self.invitedCustomersArray.append(customer)
            }
        } catch let error as NSError {
            throw(error)
        }
    }

    /// validates each customer using haversine formula & distance validator
    /// - Parameter customer: a customer object
    /// - Returns: Bool
    func customerInviteValidator(customer: Customer) -> Bool {
        let haversineFormula = HaversineFormula()
        let validator = DistanceValidator()

        // use haversine formula to calculate distance
        let lat = Double(customer.latitude)!
        let long = Double(customer.longitude)!
        let distanceFromIntercom = haversineFormula.calculateDistanceUsingHaversine(customerLat: lat, customerLong: long)

        // use distance from haversine formula
        let isCustomerEligible = validator.isCustomerEligibleForInvite(distance: distanceFromIntercom)
        return isCustomerEligible
    }

    @objc func getInviteListTapped(_ sender: Any) {
        convertTxtFileToCustomerLinesArray(filename: "customers")
        let vc = InviteListViewController()
        vc.invitedCustomersArray = invitedCustomersArray.sorted(by: { $0.userId < $1.userId })
        self.present(vc, animated: true)
    }
}


