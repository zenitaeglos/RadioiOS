//
//  RadioPlayViewController.swift
//  RadMag
//
//  Created by Alejandro Martinez Montero on 23/03/2019.
//  Copyright © 2019 Alejandro Martinez Montero. All rights reserved.
//

import UIKit

class RadioPlayViewController: UIViewController {
    
    var dataToDisplay: RadioDescription?

    @IBOutlet weak var radioName: UILabel!
    @IBOutlet weak var radioImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(dataToDisplay?.url ?? "nil asdasdasdasd")
        print("data to display")
        radioName.text = dataToDisplay?.name
        let url = URL(string: (dataToDisplay?.favicon)!)
        if let myUrl = url {
            let data = try? Data(contentsOf: myUrl)
            if let imageData = data {
                radioImage.image = UIImage(data: imageData)
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
