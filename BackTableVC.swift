//
//  BackTableVC.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 20/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import UIKit

class slidemenucell : UITableViewCell{
    
    @IBOutlet weak var slidelabel: UILabel!
    
    @IBOutlet weak var images: UIImageView!
}

class BackTableVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var TableArray = [String]()
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var stockmarketimage: UIImageView!
    
    
    
    override func viewDidLoad() {
      
        TableArray = ["Share" , "Feedback" , "Rate Us"]
        stockmarketimage.image = UIImage(named : "global_stock_market")
        
        tableview.delegate = self
        tableview.dataSource = self
        
        tableview.tableFooterView = UIView()
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 100
          super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  TableArray.count
    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! slidemenucell
        
        cell.slidelabel?.text = TableArray[indexPath.row]
        if TableArray[indexPath.row] == "Share"
        {
            cell.images?.image = UIImage(named : "shareit")
            
        }
        else if TableArray[indexPath.row] == "Feedback"
        {
            cell.images?.image = UIImage(named : "feedback")
            
        }
        else if TableArray[indexPath.row] == "Rate Us"
            {
                cell.images?.image = UIImage(named : "rateus")
                
        }
        
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
