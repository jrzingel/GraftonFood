//
//  MenuController.swift
//  GraftonFood
//
//  Created by James on 7/08/21.
//

import Foundation
import UIKit

// View Controller for settings scene
class MenuController: UITableViewController {
    @IBOutlet weak var lunch: UILabel!
    @IBOutlet weak var lunchTreat: UILabel!
    @IBOutlet weak var lunchVeg: UILabel!
    @IBOutlet weak var dinnerA: UILabel!
    @IBOutlet weak var dinnerB: UILabel!
    @IBOutlet weak var dinnerVeg: UILabel!
    @IBOutlet weak var dinnerDesert: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // do any additional stuff
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


class CellController: UITableViewCell {
}

