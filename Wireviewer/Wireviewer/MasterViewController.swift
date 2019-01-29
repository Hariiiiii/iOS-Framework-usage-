//
//  MasterViewController.swift
//  Wireviewer
//
//  Created by Harinarayanan Janardhanan on 1/21/19.
//  Copyright © 2019 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import JSONFetch

protocol SimpsonSelectionDelegate: class {
    func simpsonSelected(_ newSimpson: SimpsonsModel)
}

extension MasterViewComtroller: DataModelDelegate {
    func didRecieveDataUpdate(data: [SimpsonsModel], count : Int) {
        simpSonsData = data
        dataCount = count
        tableView.reloadData()
    }
}

extension UISplitViewController {
    func toggleMasterView() {
        let barButtonItem = self.displayModeButtonItem
        UIApplication.shared.sendAction(barButtonItem.action!, to: barButtonItem.target, from: nil, for: nil)
    }
}

class MasterViewComtroller: UITableViewController {
    var articlesData : ModelJSON?
    var simpSonsData : [SimpsonsModel] = []
    var dataCount = 0
    weak var delegate: SimpsonSelectionDelegate?
    
    var loadingBar : UIView!
    var restapi = RestAPIJsonData()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        //restapi.delegate = self
        
        //restapi.fetchData()
        
        
    }
    
    //    func fetchData() {
    //        //loadingBar = UIViewController.displaySpinner(onView: self.view)
    //        let urlString = "http://api.duckduckgo.com/?q=the+wire+characters&format=json"
    //        guard let url = URL(string: urlString) else { return }
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if error != nil {
    //                print(error!.localizedDescription)
    //            }
    //
    //            guard let data = data else { return }
    //            //Implement JSON decoding and parsing
    //            do {
    //                //Decode retrived data with JSONDecoder and assing type of Article object
    //                self.articlesData = try JSONDecoder().decode(ModelJSON.self, from: data)
    //                //Get back to the main queue
    //                DispatchQueue.main.async {
    //                    //print("data",data)
    //                    //print(type(of: self.articlesData))
    //                    //need to check for optional
    //                    self.dataCount = (self.articlesData?.RelatedTopics?.count)!
    //                    for i in 0..<self.dataCount {
    //                        //neeed to check for optional
    //                        let simsTitle = String((self.articlesData?.RelatedTopics![i].Text?.split(separator: "-").first)!)
    //                        let simsDescription = String((self.articlesData?.RelatedTopics![i].Text?.split(separator: "-").last)!)
    //                        let simsIcon = self.articlesData?.RelatedTopics![i].Icon?.URL
    //                        print("setting url data", simsIcon)
    //                        self.simpSonsData.append(SimpsonsModel(simsTitle: simsTitle, simsDescription: simsDescription, simsIcon: simsIcon!))
    //                    }
    //
    //                    self.tableView.reloadData()
    //                }
    //
    //
    //            } catch let jsonError {
    //                print(jsonError)
    //            }
    //
    //
    //            }.resume()
    //    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCount
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let simpsonTitle = simpSonsData[indexPath.row]
        //Need to check for optional
        cell.textLabel?.text = simpsonTitle.simsTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSimpson = simpSonsData[indexPath.row]
        delegate?.simpsonSelected(selectedSimpson)
        if let detailViewController = delegate as? DetailViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
            self.splitViewController?.toggleMasterView()
        }
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

