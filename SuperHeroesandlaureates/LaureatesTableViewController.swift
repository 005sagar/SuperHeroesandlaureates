//
//  LaureatesTableViewController.swift
//  Superheroes and Laureates
//
//  Created by Tiwari,Sagar on 4/11/19.
//  Copyright © 2019 Tiwari,Sagar. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UITableViewController {
    
    let laureatesdata = "https://www.dropbox.com/s/7dhdrygnd4khgj2/laureates.json?dl=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector:#selector(notification2(notification:)),name: NSNotification.Name("alert"), object:nil)
        
    }
    var laureates:[Laureates] = []
    @objc func notification2 (notification: Notification){
        print("mission complete for laureates")
    }
    @IBAction func reload(_sender:Any){
        fetchlaureates()
        
    }
    
    func fetchlaureates() {
        let urlSession = URLSession.shared
        let url = URL(string: laureatesdata)
        urlSession.dataTask(with: url!, completionHandler: displayLauratesTable).resume()
        
    }
    
    func displayLauratesTable(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var lauratesArray:[String: Any]!
        var lauratesObject:[[String:Any]]
        
        do{
            try lauratesObject = (JSONSerialization.jsonObject(with: data!,
                                                               options: .allowFragments) as? [[String:Any]])!
            
            for i in 0 ..< lauratesObject.count{
                
                lauratesArray = lauratesObject[i]
                
                let firstname = lauratesArray["firstname"] as? String ?? ""
                let suraname = lauratesArray ["surname"] as? String ?? ""
                let DOB = lauratesArray["born"] as? String ?? ""
                let DOD = lauratesArray["died"] as? String ?? ""
                
                laureates.append(Laureates(firstname: firstname, surname: suraname, born: DOB , died: DOD))
                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            NotificationCenter.default.post(name: NSNotification.Name("alert"), object: "Check")

        }catch {
            print(error)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return laureates.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "award", for: indexPath)
        let laureate = laureates[indexPath.row]
        cell.textLabel?.text = "\(laureate.firstname) \(laureate.surname)"
        cell.detailTextLabel?.text = "\(laureate.born) - \(laureate.died)"
        
        return cell
    }
    
    
}
