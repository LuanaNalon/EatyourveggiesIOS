
import UIKit
import os.log
import Firebase

class FavoriteVegetableTableViewController: UITableViewController{
    let db = Firestore.firestore()
    
    var user = Auth.auth().currentUser?.uid
    
    var vegetables = [Vegetable]()

    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredVegetables: [Vegetable] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadMyFavoriteVegetablesFromWeb()

    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /***Zona de pesquisa*/
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Vegetables"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        //*************************
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
       // storeDataDummy()s
        loadMyFavoriteVegetablesFromWeb()
        
       // loadSampleVegetables()
        
    }

    private func loadMyFavoriteVegetablesFromWeb() {
        self.vegetables = []
        var myFavoriteVegetables = [String]()
        self.db.collection("users").document(user!).getDocument{ (document, error) in
            if let document = document, document.exists {
                
                if document.data()?["myFavoriteVegetables"]  == nil   {
                    myFavoriteVegetables = [""]
                }
                else{
                
                myFavoriteVegetables = document.data()!["myFavoriteVegetables"]! as! [String]
                
                self.db.collection("vegetables").getDocuments() { (querySnapshot, err)   in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                            
                                let batchID = document.get("batchID") as! String
                                let name = document.get("name") as! String
                                let origin = document.get("origin") as! String
                                let cultivation = document.get("cultivation") as! String
                                let weight = document.get("weight") as! String
                                let hDate = document.get("hDate") as! String
                                let eDate = document.get("eDate") as! String
                                let localization = document.get("localization") as! String
                                let temperature = document.get("temperature") as! String
                                let humidity = document.get("humidity") as! String
                                let co2 = document.get("co2") as! String
                                let tilt = document.get("tilt") as! String
                                let shock = document.get("shock") as! String
                                let photo = UIImage(named: name)

                                guard let vegetable = Vegetable(batchID: batchID, name: name, photo: photo, origin: origin,
                                    cultivation: cultivation,
                                    weight: weight,
                                    hDate: hDate,
                                    eDate: eDate,
                                    localization: localization,
                                    temperature: temperature,
                                    humidity: humidity,
                                    co2: co2,
                                    tilt: tilt,
                                    shock: shock) else {
                                    fatalError("Unable to instantiate vegetable")
                                }
                                self.vegetables += [vegetable]
                                print("Nivel 1: ",self.vegetables.count)
                                
                            }
                            
                            self.vegetables = self.vegetables.filter { myFavoriteVegetables.contains($0.batchID) }
                            self.tableView.reloadData()
                        }
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
        
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredVegetables.count
        }
        
        return vegetables.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "VegetableTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? VegetableTableViewCell else {
            fatalError("The dequeued cell is not an instance of VegetableTableViewCell.")
        }
        
        // Fetches the appropriate vegetable for the data source layout.
        let vegetable:Vegetable
        
        if isFiltering {
            vegetable = filteredVegetables[indexPath.row]
        } else {
            vegetable = vegetables[indexPath.row]
        }
        
        cell.nameLabel.text = vegetable.name
        cell.photoImageView.image = vegetable.photo
        
        cell.buyButtonAction = { [unowned self] in
             
            let alert = UIAlertController(title: "Add to my purchesed vegetables!", message: "Added  \(vegetable.name)", preferredStyle: .alert)
             let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
             alert.addAction(okAction)
                   
             self.present(alert, animated: true, completion: nil)
            
            buyVegetable(batchID: vegetable.batchID,position: indexPath)
            
           }
        
        return cell
    }
    private func buyVegetable(batchID: String, position: IndexPath){
        db.collection("users").document(String(user!)).updateData(["myPurchasedVegetables": FieldValue.arrayUnion([batchID])])
               removeFavoriteFromList(batchID: batchID, position: position)
        tableView.reloadData()
        
    }
    private func removeFavoriteFromList(batchID: String, position: IndexPath){
        
        db.collection("users").document(user!).updateData(["myFavoriteVegetables": FieldValue.arrayRemove([vegetables[position.row].batchID])
        ])
        
        
        self.vegetables.remove(at: position.row)
        
        tableView.deleteRows(at: [position], with: .fade)
       
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            removeFavoriteFromList(batchID: "String", position: indexPath)
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding a new vegetable.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            guard let vegetableDetailsViewController = segue.destination as? VegetableDetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedVegetableCell = sender as? VegetableTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            guard let indexPath = tableView.indexPath(for: selectedVegetableCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedVegetable = vegetables[indexPath.row]
            vegetableDetailsViewController.vegetable = selectedVegetable
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    
    
    
    
    
    
    @IBAction func unwindToVegetableList(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? VegetableDetailsViewController,
           let vegetable = sourceViewController.vegetable {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing vegetable.
                vegetables[selectedIndexPath.row] = vegetable
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new vegetable.
                let newIndexPath = IndexPath(row: vegetables.count, section: 0)
                vegetables.append(vegetable)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
    }
    
    
    func filterContentForSearchText(_ searchText: String,
                                    category: String? = nil) {
        filteredVegetables = vegetables.filter { (vegetable: Vegetable) -> Bool in
            return vegetable.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
}
extension FavoriteVegetableTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let category = "vategory"
        filterContentForSearchText(searchBar.text!, category: category)
    }
}

extension FavoriteVegetableTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = "vategory"
        filterContentForSearchText(searchBar.text!, category: category)
    }
}
