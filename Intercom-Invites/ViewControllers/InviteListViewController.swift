import Foundation
import UIKit

class InviteListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var invitedCustomersArray = [Customer]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        invitedCustomersCollectionView.delegate = self
        invitedCustomersCollectionView.dataSource = self
        invitedCustomersCollectionView.register(InvitedCustomerCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        invitedCustomersCollectionView.backgroundColor = .systemGray6
        topView.roundCorners(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 70)

        addSubviews()
    }

    /// view for custom navbar
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.primaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    /// image view for intercom logo
    let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "intercom-logo-white")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    /// button for back navigation
    let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.backward")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /// button for exporting output.txt file
    let exportButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.down")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .semibold)
        button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(exportButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    /// collection view for invited customers
    let invitedCustomersCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 22, bottom: 20, right: 22)
        layout.itemSize = CGSize(width: Constants.screenWidth - 40, height: 120)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        return collectionView
    }()


    func addSubviews() {
        view.addSubview(topView)
        topView.addSubview(backButton)
        topView.addSubview(logoView)
        topView.addSubview(exportButton)
        view.addSubview(invitedCustomersCollectionView)

        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalToConstant: Constants.screenHeight / 6),

            backButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 18),

            logoView.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            logoView.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            logoView.widthAnchor.constraint(equalToConstant: 50.0),
            logoView.heightAnchor.constraint(equalToConstant: 50.0),

            exportButton.centerYAnchor.constraint(equalTo: topView.centerYAnchor),
            exportButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -18),

            invitedCustomersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            invitedCustomersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            invitedCustomersCollectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            invitedCustomersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return invitedCustomersArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! InvitedCustomerCollectionViewCell

        let name = invitedCustomersArray[indexPath.row].name
        cell.nameLabel.text = "Name: \(name)"
        let userId = String(invitedCustomersArray[indexPath.row].userId)
        cell.userIdLabel.text = "User ID: \(userId)"

        return cell
    }

    /// converts invitedCustomersDestArray of Customer into array of Strings
    /// and writes the result to output.txt file
    func createInvitedCustomerOutputTxt() {
        var customersStringsArray = [String]()
        for customer in invitedCustomersArray {
            let customerString = "Customer Name: \(customer.name) - User ID: \(customer.userId)"
            customersStringsArray.append(customerString)
        }
        let joined = customersStringsArray.joined(separator: "\n")
        let url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("output.txt")
        let data = Data(joined.utf8)
        do {
            try data.write(to: url, options: .atomic)
        } catch {
            print(error)
        }
    }

    @objc func backButtonTapped(_ sender: Any) {
      self.dismiss(animated: true)
    }

    @objc func exportButtonTapped(_ sender: Any) {
      createInvitedCustomerOutputTxt()
    }

}
