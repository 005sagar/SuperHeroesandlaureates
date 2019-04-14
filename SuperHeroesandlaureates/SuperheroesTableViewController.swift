//
//  SuperHeroesTableViewController.swift
//  Superheroes and Laureates
//
//  Created by Tiwari,Sagar on 4/11/19.
//  Copyright © 2019 Tiwari,Sagar. All rights reserved.
//

import UIKit
class SuperHeroesTableViewController: UITableViewController {
    
    let superherodata = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector:#selector(superHeroNotification(notification:)),name: NSNotification.Name("alert"), object:nil)
    }
    @objc func superHeroNotification (notification: Notification){
        print("Mission complete for superhero")
    }
    var arrayofsuperHeroes: [Members] = []
    

    @IBAction func reoladdata(_ sender: Any) {
        fetchSuperHeroes()
        tableView.reloadData()
    }
    
    func fetchSuperHeroes(){
        let urlSession = URLSession.shared
        let url = URL(string: superherodata)
        urlSession.dataTask(with: url!, completionHandler: displaysuperhero).resume()
    }
    
    func displaysuperhero(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        
        do {
            let decoder:JSONDecoder = JSONDecoder()
            arrayofsuperHeroes = try decoder.decode(Superhero.self, from: data!).members
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            NotificationCenter.default.post(name: NSNotification.Name("alert"), object: "Check")
        } catch {
            print(error)
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayofsuperHeroes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hero", for: indexPath)
        
        let superHero = arrayofsuperHeroes[indexPath.row]
        cell.textLabel?.text = "\(superHero.name) (aka: \(superHero.secretIdentity))"
        var powerList = ""
        for i in superHero.powers{
            powerList += "\(String(i))  "
        }
        cell.detailTextLabel?.text = "\(powerList)"
        return cell
    }
    
   
}

