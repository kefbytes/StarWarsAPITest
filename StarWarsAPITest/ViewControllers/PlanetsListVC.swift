//
//  PlanetsListVC.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/20/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import UIKit

class PlanetsListVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var planetsTitleLabel: UILabel!
    @IBOutlet weak var planetsTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // MARK: - Properties
    let planetsListVM = PlanetsListVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        planetsTitleLabel.isHidden = true
        fetchPlanets()
    }
    
    // MARK: - Fetch
    func fetchPlanets() {
        spinner.startAnimating()
        planetsListVM.fetchStarWarsPlanets {
            () in
            for planet in self.planetsListVM.starWarsPlanetsArray {
                guard let name = planet.name else {
                    continue
                }
                print(name)
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.planetsTableView.reloadData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UITableView DataSource
extension PlanetsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsListVM.starWarsPlanetsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "planetCell", for: indexPath)
        cell.textLabel?.text = planetsListVM.starWarsPlanetsArray[indexPath.row].name
        return cell
    }
}
