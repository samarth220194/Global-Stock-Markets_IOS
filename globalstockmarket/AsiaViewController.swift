//
//  AsiaViewController.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 14/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import UIKit
import  Foundation
import XLPagerTabStrip

class AsiaCell: UITableViewCell {
   
    @IBOutlet weak var countryFlag: UIImageView!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var PerChg: UILabel!
    @IBOutlet weak var Chg: UILabel!
    @IBOutlet weak var CurrPrice: UILabel!
    @IBOutlet weak var Country: UILabel!
    @IBOutlet weak var Indicename: UILabel!
}


class AsiaViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,IndicatorInfoProvider{
    
    var refreshControl = UIRefreshControl()

    var datas = [JSONData]()
    
    @IBOutlet var tableview: UITableView!
    
    
  
    override func viewDidLoad() {
        if #available(iOS 10.0, *) {
            tableview.refreshControl = refreshControl
        } else {
            tableview.addSubview(refreshControl)
        }
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(AsiaViewController.refresh), for: UIControlEvents.valueChanged)
        
        
        super.viewDidLoad()
        
        tableview.estimatedRowHeight = CGFloat(Properties_Utils().tableviewheight)
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.downloadJsonWithURL()
        tableview.dataSource=self
        tableview.delegate=self
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.downloadJsonWithURL()
    }
    
    func refresh(){
        self.downloadJsonWithURL()
    }

    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title : "ASIA")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "detailedchart")
        {
            if let indexpath = tableview.indexPathForSelectedRow
            {
                let vc = segue.destination as! ChartViewController
                
                vc.countryPassedValue = datas[indexpath.row].country
                vc.indicesPassedValue = datas[indexpath.row].indicename
                }
        }
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
      // MARK: - Table view data source
    
    
    
   
    func downloadJsonWithURL() {
        
        if !Reachability().connectedToNetwork()
        {
            
            let alert = Reachability().show_alertBox()
            self.present(alert, animated: true, completion: nil)
            self.refreshControl.endRefreshing()
            return
        }

        
        let task = URLSession.shared.dataTask(with: URL(string: Properties_Utils().stringurl + "Asia")!) { (data, response, error) in
            if error != nil {
              //  print(error?.localizedDescription)
                return
            }
            if let contdata = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any] {
               
                if let arrJSON = contdata["data"] as? [[String:Any]] {
                    self.datas = arrJSON.flatMap(JSONData.init)
                
                        //Reload tableView and endRefreshing the refresh control
                        DispatchQueue.main.async {
                        self.tableview.reloadData()
                        self.refreshControl.endRefreshing()
                        }
                }
            }
        }
        
        task.resume()
        
    }
    

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AsiaCell", for: indexPath) as! AsiaCell
      
    
        cell.Indicename?.text = datas[indexPath.row].indicename
        cell.Indicename.font = UIFont.boldSystemFont(ofSize: 19.0)
        cell.Country?.text = datas[indexPath.row].country
        cell.CurrPrice?.text = datas[indexPath.row].currPrice
 
        let curpricefloat : Double = Double(datas[indexPath.row].currPrice)!
        cell.CurrPrice?.text = String(format: "%.2f", curpricefloat)
        
        let Chgfloat : Double = Double(datas[indexPath.row].chg)!
        let perchgfloat : Double = Double(datas[indexPath.row].perChg)!
        
       
        
        
        if Chgfloat < 0 {
            
            cell.Chg?.textColor = UIColor.red
            cell.PerChg?.textColor = UIColor.red
            cell.arrow?.image = UIImage(named : "arrowdown")
        } else
        {
            cell.Chg?.textColor = UIColor.green
            cell.PerChg?.textColor = UIColor.green
            cell.arrow?.image = UIImage(named : "arrowup")
        }
        cell.PerChg?.text = "(" + String(format: "%.2f", abs(perchgfloat)) + "%)"
        cell.Chg?.text = String(format: "%.2f", abs(Chgfloat))
        
       
        if cell.Country!.text! == "China"{
            cell.countryFlag?.image = UIImage(named : "china")
        }
        else if cell.Country!.text! == "East Israel"{
            cell.countryFlag?.image = UIImage(named : "israel")
        }
        else if cell.Country!.text! == "Hong Kong (China)"{
            cell.countryFlag?.image = UIImage(named : "hongkong")
        }
        else if cell.Country!.text! == "India"{
            cell.countryFlag?.image = UIImage(named : "india")
        }
        else if cell.Country!.text! == "Indonesia"{
            cell.countryFlag?.image = UIImage(named : "indonesia")
        }
        else if cell.Country!.text! == "Japan"{
            cell.countryFlag?.image = UIImage(named : "japan")
        }
        else if cell.Country!.text! == "Malaysia "{
            cell.countryFlag?.image = UIImage(named : "maaysia")
        }
        else if cell.Country!.text! == "Saudi Arabia"{
            cell.countryFlag?.image = UIImage(named : "saudiarabia")
        }
        else if cell.Country!.text! == "South Korea"{
            cell.countryFlag?.image = UIImage(named : "southkorea")
        }
        else if cell.Country!.text! == "Taiwan"{
            cell.countryFlag?.image = UIImage(named : "taiwan")
        }
        else if cell.Country!.text! == "Thailand"{
            cell.countryFlag?.image = UIImage(named : "thailand")
        }
        else if cell.Country!.text! == "Turkey"{
            cell.countryFlag?.image = UIImage(named : "turkey")
        }
        else{
        cell.countryFlag?.image = UIImage(named : "unknown")
        }
        
        
        return cell
    }
    
   
}
