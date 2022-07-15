//
//  ViewController.swift
//  bootCamp
//
//  Created by Илья on 7/15/22.
//

import UIKit

class ViewController: UIViewController {
    private let model = Model()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        model.getData { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let services = model.services
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = services[indexPath.row].name
        contentConfig.secondaryText = services[indexPath.row].description
        let data = try? Data(contentsOf: services[indexPath.row].icon_url)
        if let imageData = data {
            contentConfig.image = UIImage(data: imageData)
        }
        cell.contentConfiguration = contentConfig
        cell.accessoryType = .disclosureIndicator
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(model.services[indexPath.row].link)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
}


