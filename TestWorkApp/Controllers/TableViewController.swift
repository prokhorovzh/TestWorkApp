//
//  TableViewController.swift
//  TestWorkApp
//
//  Created by Евгений Прохоров on 01.03.2021.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {

    var weather: [Weather] = []
    
    let url = "https://api.weather.yandex.ru/v2/forecast?"
    let key = "X-Yandex-API-Key:f67fb448-8c6e-4db4-8625-97e6faf42416"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let weatherCity = weather[indexPath.row]
        cell.textLabel?.text = "\(weatherCity.name ?? "No name")"
        cell.detailTextLabel?.text = "\(weatherCity.temp ?? "None")"
        return cell
    }
}

extension TableViewController {
    func alamofireGetButtonPressed() {
        AF.request(url + key)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.weather = Weather.getWeather(from: value)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
        }
    }
}
