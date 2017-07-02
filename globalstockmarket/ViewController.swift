//
//  ViewController.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 14/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class ViewController: ButtonBarPagerTabStripViewController {
    
    
   // @IBOutlet weak var Open: UIBarButtonItem!
    
    var indexnumber : Int = 0
    
    let bluecolor = UIColor(red:63.0/255.0, green:81.0/255.0, blue:181.0/255.0, alpha:1.0)
    
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        
        let africa = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "africa")
        let europe = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "europe")
        let aussie = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "australia")
        let asia = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "asia")
         let namerica = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "namerica")
        let samerica = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "samerica")
        
        
        
        return [asia, namerica, europe, samerica,aussie,africa]
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
  
    override func viewDidLoad() {
        
        
      //  print(indexnumber)
        self.title = "GLOBAL STOCK MARKETS"
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = bluecolor
       
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        
       
       // Open.target = self.revealViewController()
       // Open.action = #selector(SWRevealViewController.revealToggle(_:))
        
       // self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
       
        // change selected bar color
        
        settings.style.buttonBarBackgroundColor = bluecolor
        settings.style.buttonBarItemBackgroundColor = bluecolor
        settings.style.selectedBarBackgroundColor = .white
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarMinimumLineSpacing = 1.0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .white
            newCell?.label.textColor = .white
            
        }

        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

