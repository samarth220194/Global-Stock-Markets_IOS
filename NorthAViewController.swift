//
//  NorthAViewController.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 20/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import Foundation


class northacell : UITableViewCell {
    
    @IBOutlet weak var Country: UILabel!
    @IBOutlet weak var Indicename: UILabel!
    @IBOutlet weak var CurrPrice: UILabel!
    @IBOutlet weak var Chg: UILabel!
    @IBOutlet weak var PerChg: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var countryFlag: UIImageView!
}

class NorthAViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,IndicatorInfoProvider {
    
    
    
    @IBOutlet var tableview: UITableView!
  
    var refreshControl = UIRefreshControl()
    
    var datas = [JSONData]()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.downloadJsonWithURL()
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        
        return IndicatorInfo(title : "N.AMERICA")
    }
    
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
    
    func refresh(){
        self.downloadJsonWithURL()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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

        let task = URLSession.shared.dataTask(with: URL(string: Properties_Utils().stringurl + "North%20America" )!) { (data, response, error) in
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
        // #warning Incomplete implementation, return the number of rows
        return  datas.count
    }
    
    //setting data on the table view cell
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "northacell", for: indexPath) as! northacell
        
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
        { cell.Chg?.textColor = UIColor.green
            cell.PerChg?.textColor = UIColor.green
            cell.arrow?.image = UIImage(named : "arrowup")
        }

        
        cell.Chg?.text = String(format : "%.2f" , abs(Chgfloat))
        cell.PerChg?.text = "(" + String(format : "%.2f" , abs(perchgfloat)) + "%)"
        
        
        if cell.Country!.text! == "Canada"{
            cell.countryFlag?.image = UIImage(named : "canada")
        }
        else if cell.Country!.text! == "MEXICO"{
            cell.countryFlag?.image = UIImage(named : "mexico")
        }
        else if cell.Country!.text! == "New York"{
            cell.countryFlag?.image = UIImage(named : "newyork")
        }
        else if cell.Country!.text! == "US"{
            cell.countryFlag?.image = UIImage(named : "unitedstates")
        }
        else{
            cell.countryFlag?.image = UIImage(named : "unknown")
        }
        
        return cell
    }

}
