//
//  CharacterListVC.swift
//  StarWarsAPITest
//
//  Created by Kent Franks on 2/4/19.
//  Copyright © 2019 Kent Franks. All rights reserved.
//

import UIKit

class CharacterListVC: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    let characterListVM = CharacterListVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharactaers()
    }
    
    func fetchCharactaers() {
        spinner.startAnimating()
        characterListVM.fetchStarWarsCharacters() {
            () in
            print("characters fetched:")
            for character in self.characterListVM.starWarsCharacterArray {
                guard let name = character.name else {
                    continue
                }
                print(name)
                DispatchQueue.main.async {
                    self.spinner.stopAnimating()
                    self.charactersTableView.reloadData()
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

extension CharacterListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterListVM.starWarsCharacterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        cell.textLabel?.text = characterListVM.starWarsCharacterArray[indexPath.row].name
        return cell
    }
}
