//
//  ViewController.swift
//  EliqDrinkApp
//
//  Created by Amila Prasad on 2022-08-21.
//

import UIKit
import Combine
import SwiftUI

class DrinksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = DrinksViewModel()
    private var cancellables : Set<AnyCancellable> = []
    private var selectedDrink : SelectedDrink?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib(nibName: "DrinkItemTableViewCell", bundle: nil), forCellReuseIdentifier: "DrinkItemTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        // Refresh List Navigation Button
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(reloadData))
        
        self.setupBinders()
        viewModel.getDrinks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func setupBinders(){
        
        // Alert message subscriber
        viewModel.$alertMessage
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { message in
                if let message = message {
                    self.showAlert(message: message)
                }
            }).store(in: &cancellables)
        
        // Drinks list subscriber
        viewModel.$drinks
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { drinks in
                self.tableView.reloadData()
            }).store(in: &cancellables)
        
        // loader subscriber
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { isLoading in
                if let isLoading = isLoading {
                    self.activityIndicator.isHidden = !isLoading
                }
            }).store(in: &cancellables)
        
    }
    
    // Common method to display alert message
    // Subscribed to $alertMessage in view model
    func showAlert( message: String) {
        let dialogMessage = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    // MARK: - Actions
    
    @objc func reloadData() {
        viewModel.getDrinks()
    }
    
    
    // MARK: - TableView Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DrinkItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "DrinkItemTableViewCell") as! DrinkItemTableViewCell
        cell.configure(drink: viewModel.drinks[indexPath.row])
        return cell
    }
    
    
    // MARK: - TableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDrink = SelectedDrink(id: viewModel.drinks[indexPath.row].idDrink)
        let swiftUIControler = UIHostingController(rootView: DrinkDetailView(selectedDrink: selectedDrink!))
        self.navigationController?.pushViewController(swiftUIControler, animated: true)
    }
}

