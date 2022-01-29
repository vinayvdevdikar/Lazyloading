/*
Created by Vinay Devdikar on 22/01/22.
 
Abstract:
List Item View Controller.
*/

import UIKit

class ListScreenController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50.0
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var spinerView: UIActivityIndicatorView = {
        let activity =  UIActivityIndicatorView()
        activity.style = .medium
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        return activity
    }()

    private let configurator: ListScreenConfigurator = ListScreenConfiguratorImpl()
    var listOfRecipes: [RecipeUIModel] = []
    var router: ListScreenRouter?
    var interactor: ListScreenInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        setUpUIComponent()
        registerCell()
        spinerView.startAnimating()
        interactor?.fetchAllRecipies()
    }
    
    private func registerCell() {
        tableView.register(ListItemTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    deinit {
        router = nil
        interactor = nil
    }
    
    //MARK:- UI Setup Methods
    
    private func setUpUIComponent() {
        view.addSubview(tableView)
        view.addSubview(spinerView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:
                                            view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo:
                                                view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo:
                                                    view.safeAreaLayoutGuide.trailingAnchor),
            spinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        view.backgroundColor = Theme.colors.backgroundColor
    }
    
    private func shwoErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Something went wrong please try again.",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Try Again",
                                      style: UIAlertAction.Style.default, handler: { _ in
            self.spinerView.startAnimating()
            self.interactor?.fetchAllRecipies()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListScreenController: ListViewControllerInterface {
    
    func recipesDidLoadSuccessfully(with recipes: [RecipeUIModel]) {
        self.listOfRecipes = recipes
        DispatchQueue.main.async { [weak self] in
            self?.spinerView.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    func recipesDidFail(with error: RecipesError) {
        self.listOfRecipes = []
        DispatchQueue.main.async { [weak self] in
            self?.spinerView.stopAnimating()
            self?.shwoErrorAlert()
        }
    }
}

extension ListScreenController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(ListItemTableViewCell.self)
        cell.accessibilityTraits = .button
        cell.selectionStyle = .none
        let item = listOfRecipes[indexPath.row]
        let isLastRow = listOfRecipes.count - 1 == indexPath.row
        
        guard let finalUrl = URL(string: item.imageUrl),
                let placeholder = UIImage(named: "placeholder") else {
            return cell
        }
        
        cell.update(viewModel: .init(title: item.name,
                                     message: item.headline,
                                     image: placeholder,
                                     prepTime: item.prepmin),
                    isLastCell: isLastRow)
        
        ImageCache.publicCache.load(url: finalUrl as NSURL) { (image) in
            if let img = image, img != placeholder {
                cell.updateImage(with: img)
            }else {
                cell.updateImage(with: placeholder)
            }
        }
        return cell
    }
}

extension ListScreenController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
