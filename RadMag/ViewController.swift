//
//  ViewController.swift
//  RadMag
//
//  Created by Alejandro Martinez Montero on 15/03/2019.
//  Copyright © 2019 Alejandro Martinez Montero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct RadioJson: Codable {
        let name: String
        let url: String
        let favicon: String
        let homepage: String
        let country: String
        
    }
    
    var radioList: [RadioDescription] = []
    var radioToSendToViewController: RadioDescription?

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var radioTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
    }

    
    @IBAction func buttonSearch(_ sender: Any) {
        radioList.removeAll()
        var radioApi: String = "http://www.radio-browser.info/webservice/json/stations/byname/"
        
        if let optionalRadioText = radioTextField.text {
            radioApi += optionalRadioText
        }
        else {
            return
        }
        
        let url = URL(string: radioApi)

        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do {
                // Json to Array
                let name = try JSONDecoder().decode([RadioJson].self, from: data!)
                for radio in name {
                    let radioDescription = RadioDescription(name: radio.name, url: radio.url, favicon: radio.favicon, homepage: radio.homepage, country: radio.country)
                    self.radioList.append(radioDescription)
                }
                
                DispatchQueue.main.async {
                    print("main.async")
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
        }.resume()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var selectedIndex = tableView.indexPathForSelectedRow
        
        if let index = selectedIndex?.row {
            radioToSendToViewController = radioList[index]
            
        }
        else {
            return
        }
        let nextViewController = segue.destination as? RadioPlayViewController
        nextViewController?.dataToDisplay = radioToSendToViewController
    }
 
    
}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radioList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let radio = radioList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RadioCell") as! RadiosTableViewCell
        
        cell.radioName.text = radio.name
        //cell.radioImage.image = UIImage(data: radio.favicon)
        let url = URL(string: radio.favicon)
        if let myUrl = url {
            let data = try? Data(contentsOf: myUrl)
            if let imageData = data {
                cell.radioImage.image = UIImage(data: imageData)
            }
        }
        
        cell.radioCountry.text = radio.country
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
