//
//  ChartViewController.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 18/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import UIKit
import Charts
import Foundation


class ChartViewController: UIViewController {
    
    var datas = [JSONData1]()

    @IBOutlet weak var scrollview: UIScrollView!

    @IBOutlet weak var daybutton: UIButton!
    @IBOutlet weak var monthbutton: UIButton!
    
    @IBOutlet weak var yearbutton: UIButton!
    @IBOutlet weak var threemonthbutton: UIButton!
    @IBOutlet weak var lineChartView: LineChartView!
    
    
    let bluecolor = UIColor(red:63.0/255.0, green:81.0/255.0, blue:181.0/255.0, alpha:1.0)
    let darkbluecolor = UIColor(red:48.0/255.0, green:63.0/255.0, blue:159.0/255.0, alpha:1.0)
    let chartcolor  = UIColor(red:128.0/255.0, green:128.0/255.0, blue:255.0/255.0, alpha:1.0)
    
    var countryPassedValue : String?
    var indicesPassedValue : String?
    var indices_appendedwithurl : String?
       
    @IBAction func yearchart(_ sender: UIButton) {
        yearbutton.backgroundColor = darkbluecolor
        daybutton.backgroundColor = bluecolor
        monthbutton.backgroundColor = bluecolor
        threemonthbutton.backgroundColor = bluecolor
        setChart(dataPoints: time_oneyr_s, Values: indices_oneyr_f)
    }
    @IBAction func threemonthchart(_ sender: UIButton) {
        yearbutton.backgroundColor = bluecolor
        daybutton.backgroundColor = bluecolor
        monthbutton.backgroundColor = bluecolor
        threemonthbutton.backgroundColor = darkbluecolor
        setChart(dataPoints: time_threem_s, Values: indices_threem_f)
    }
    @IBAction func day_chart(_ sender: UIButton) {
        yearbutton.backgroundColor = bluecolor
        daybutton.backgroundColor = darkbluecolor
        monthbutton.backgroundColor = bluecolor
        threemonthbutton.backgroundColor = bluecolor
        setChart(dataPoints: time_oneday_s, Values: indices_oneday_f)
    }
    @IBAction func month_chart(_ sender: UIButton) {
        yearbutton.backgroundColor = bluecolor
        daybutton.backgroundColor = bluecolor
        monthbutton.backgroundColor = darkbluecolor
        threemonthbutton.backgroundColor = bluecolor
        setChart(dataPoints: time_onem_s, Values: indices_onem_f)
    }

    @IBOutlet weak var currprice: UILabel!
    @IBOutlet weak var percandchange: UILabel!
  
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var timezone: UILabel!
    
    @IBOutlet weak var updatedtime: UILabel!
    
    @IBOutlet weak var prevdayclose: UILabel!
    @IBOutlet weak var prevweekclose: UILabel!
    @IBOutlet weak var prevmonthclose: UILabel!
    
    @IBOutlet weak var countryindicesname: UILabel!
    
  
    
    var stringurl = "http://www.appuonline.com/appu_android_app/global_stock_app/graph.php?indices="

    
     var indices_oneday_s = [String]()
     var indices_onem_s = [String]()
     var indices_threem_s = [String]()
     var indices_oneyr_s = [String]()
    
    var indices_oneday_f = [Double]()
    var indices_onem_f = [Double]()
    var indices_threem_f = [Double]()
    var indices_oneyr_f = [Double]()
    
    var time_oneday_s = [String]()
    var time_onem_s = [String]()
    var time_threem_s = [String]()
    var time_oneyr_s = [String]()

  
    func setXaxis(){
        
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        lineChartView.xAxis.forceLabelsEnabled = true
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottomInside
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelTextColor = chartcolor
        lineChartView.xAxis.labelCount = 4
      //  lineChartView.xAxis.setLabelCount(5, force: true)
        lineChartView.xAxis.xOffset = 10
        
        
    }
    func setYaxis(){
        lineChartView.leftAxis.labelPosition = YAxis.LabelPosition.insideChart
        lineChartView.leftAxis.labelTextColor = chartcolor
        lineChartView.leftAxis.gridColor = chartcolor
        lineChartView.leftAxis.labelCount = 5
        lineChartView.leftAxis.yOffset = 6
        lineChartView.setViewPortOffsets(left: 0, top: 0, right: 0, bottom: 0)
        
    }
    func setChart(){
        
        lineChartView.noDataText = ""
        lineChartView.dragEnabled = false
        lineChartView.setScaleEnabled(false)
        lineChartView.pinchZoomEnabled = false
        lineChartView.drawMarkers = true
        lineChartView.backgroundColor = bluecolor
        lineChartView.rightAxis.enabled = false
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.downloadJsonWithURL()
    }
    

    
    func setChart(dataPoints:[String]?, Values:[Double])
    {
        lineChartView.noDataText = ""
        lineChartView.backgroundColor = bluecolor

        var dataEntries : [ChartDataEntry] = []

        lineChartView.delegate = self as? ChartViewDelegate
        
        for i in 0..<dataPoints!.count{
            let DataEntry = ChartDataEntry(x: Double(i) , y : Values[i] )
            dataEntries.append(DataEntry)
        
            let  marker = XYMarkerView1( color:  NSUIColor.white,
                                         font: UIFont(name: "HelveticaNeue-Bold", size: 10)!,
                                         textColor: NSUIColor.black,
                                         insets: UIEdgeInsets(top: 2.0, left: 3.0, bottom: 2.0, right: 3.0),
                                         xAxisValueFormatter: IndexAxisValueFormatter(values : dataPoints!))
            marker.minimumSize = CGSize( width: 80.0, height :30.0)
            marker.arrowSize = CGSize(width : 5.0, height : 8.0)
            marker.chartView = lineChartView
            lineChartView.marker = marker
            
            lineChartView.marker = marker
           
        }
        
        let Linechartdataset = LineChartDataSet(values : dataEntries, label: nil)
        
        Linechartdataset.setColor(bluecolor)
        Linechartdataset.drawFilledEnabled = true
        Linechartdataset.fillColor = NSUIColor.black
        Linechartdataset.drawCirclesEnabled = false
        Linechartdataset.drawValuesEnabled = false
        
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values : dataPoints!)
        
        let Linechartdata = LineChartData(dataSet:Linechartdataset)
        
        lineChartView.data = Linechartdata
        
        lineChartView.data?.notifyDataChanged()
        lineChartView.notifyDataSetChanged()
        lineChartView.invalidateIntrinsicContentSize()
        
    }
    
    func refresh(){
        self.downloadJsonWithURL()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollview.contentSize = CGSize(width : self.view.frame.width, height : self.view.frame.height+100)
        
        lineChartView.noDataText = ""
        lineChartView.backgroundColor = bluecolor
        
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "refresh"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(ChartViewController.refresh), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        self.navigationItem.setRightBarButtonItems([item1], animated: true)

        
        timezone.isHidden = false
        updatedtime.isHidden = false
        daybutton.backgroundColor = darkbluecolor

        self.title = indicesPassedValue
        
               
        currprice.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        indices_appendedwithurl = indicesPassedValue?.lowercased()
        indices_appendedwithurl = indices_appendedwithurl?.replacingOccurrences(of: " ", with: "_")
        indices_appendedwithurl = indices_appendedwithurl?.replacingOccurrences(of: "/", with: "_")
        indices_appendedwithurl = indices_appendedwithurl?.replacingOccurrences(of: "&", with: "_")

        
        stringurl = stringurl + indices_appendedwithurl!
        
   //     print(stringurl)
        
        
            countryindicesname?.text = countryPassedValue! + " - " + indicesPassedValue!
         
        self.downloadJsonWithURL()
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func downloadJsonWithURL() {
        
        if !Reachability().connectedToNetwork()
        {
            let alert = Reachability().show_alertBox()
            self.present(alert, animated: true, completion: nil)
        }

        let task = URLSession.shared.dataTask(with: URL(string: stringurl)!) { (data, response, error) in
            if error != nil {
                //  print(error?.localizedDescription)
                return
            }
            if let contdata = (try? JSONSerialization.jsonObject(with: data!, options: [])) as? [String:Any] {
                
                if let arrJSON = contdata["data"] as? [[String:Any]] {
                    self.datas = arrJSON.flatMap(JSONData1.init)
                    
                    
                    DispatchQueue.main.async {
                       self.setdataforchart()
                       // print(self.datas[0].currPrice)
                    }
                   
                }
                
            }
            
        }
        
        task.resume()
        
    }
    
    func setdataforchart()
    {
     
        let date = Date() //  user's local time
        
        if !datas[0].zone.characters.contains(":")
        {
            datas[0].zone = datas[0].zone + ":00"
        }
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        format.timeZone = TimeZone(abbreviation : datas[0].zone)
        
        let date_parsed1 = format.date(from: datas[0].date)
        
        
        
        var seconds = Calendar.current.dateComponents([.second], from: date, to: date_parsed1!).second ?? 0

        seconds = abs(seconds)
        
        
        let min  = seconds/60
        let hours = seconds/3600
        
        
        if seconds == 0 {self.updatedtime.text? = "now"}
        else if seconds>0 && seconds<60{self.updatedtime.text? = "\(seconds) secs ago" }
        else if seconds >= 60 && seconds<120 {self.updatedtime.text? = "1 min ago"}
        else if seconds > 120 && seconds < 3600 {self.updatedtime.text? = "\(min) mins ago"}
        else if seconds>=3600 && seconds<7200 {self.updatedtime.text? = "1 hour ago"}
        else if seconds>7200 && hours<24 {self.updatedtime.text? = "\(hours) hours ago"}
        else if hours >= 24 && hours<48 {self.updatedtime.text? = "1 day ago"}
        else{ self.updatedtime.text? = "\(hours/24) days ago"}
        
        
         self.timezone.text? = self.datas[0].zone
         self.prevdayclose.text? = String(format : "%.2f" , Float(self.datas[0].prev_close)!)
         self.prevmonthclose.text? = String(format : "%.2f" , Float(self.datas[0].prev_closem)!)
         self.prevweekclose.text? = String(format : "%.2f" , Float(self.datas[0].prev_closew)!)
       
        if Float(self.datas[0].chg)! < 0 {
            arrow.image = UIImage(named : "arrowdown")
        }else if Float(self.datas[0].chg)! >= 0{
            arrow.image = UIImage(named : "arrowup")
        }
        
        self.datas[0].perChg = self.datas[0].perChg.replacingOccurrences(of: "-", with: "")
        self.datas[0].chg = self.datas[0].chg.replacingOccurrences(of: "-", with: "")
        
        self.percandchange?.text = "(" + "\(String(format: "%.2f", Float(self.datas[0].perChg)!))" + "%) " + "\(String(format: "%.2f", Float(self.datas[0].chg)!))"
        
        self.currprice?.text = String(format: "%.2f", Float(self.datas[0].currPrice)!)
        

         indices_oneday_s = self.datas[0].indicesdata_oneday.components(separatedBy: ",")
         time_oneday_s = self.datas[0].indicestime_oneday.components(separatedBy: ",")
         indices_onem_s = self.datas[0].indicesdata_onem.components(separatedBy: ",")
         time_onem_s = self.datas[0].indicestime_onem.components(separatedBy: ",")
         indices_threem_s = self.datas[0].indicesdata_threem.components(separatedBy: ",")
         time_threem_s = self.datas[0].indicestime_threem.components(separatedBy: ",")
         indices_oneyr_s = self.datas[0].indicesdata_oneyr.components(separatedBy: ",")
         time_oneyr_s = self.datas[0].indicestime_oneyr.components(separatedBy: ",")
         
         let inputFormatter = DateFormatter()
         inputFormatter.dateFormat = "yyyy-MM-dd"
         
         for i in 0..<time_oneday_s.count{
         time_oneday_s[i] = time_oneday_s[i].replacingOccurrences(of: ".", with: ":")
         }
         for i in 0..<time_onem_s.count{
         
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "dd MMM"
         let showDate = inputFormatter.date(from: time_onem_s[i])
         time_onem_s[i] = outputFormatter.string(from: showDate!)
         }
         
         for i in 0..<time_threem_s.count{
         
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "dd MMM"
         let showDate = inputFormatter.date(from: time_threem_s[i])
         time_threem_s[i] = outputFormatter.string(from: showDate!)
         }
         for i in 0..<time_oneyr_s.count{
         
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "dd MMM yy"
         let showDate = inputFormatter.date(from: time_oneyr_s[i])
         time_oneyr_s[i] = outputFormatter.string(from: showDate!)
         }
         
         
         for val in indices_oneday_s{
         indices_oneday_f.append(Double(val)!)
         }
         for val in indices_onem_s{
         indices_onem_f.append(Double(val)!)
         }
         for val in indices_threem_s{
         indices_threem_f.append(Double(val)!)
         }
         for val in indices_oneyr_s{
         indices_oneyr_f.append(Double(val)!)
         }
         setChart()
         setXaxis()
         setYaxis()
        
        if daybutton.backgroundColor  == darkbluecolor
        {
            setChart(dataPoints: time_oneday_s, Values: indices_oneday_f)
        }
        else if monthbutton.backgroundColor == darkbluecolor{
            
            setChart(dataPoints: time_onem_s, Values: indices_onem_f)
        }
        else if monthbutton.backgroundColor == darkbluecolor{
            
            setChart(dataPoints: time_threem_s, Values: indices_threem_f)
        }
        else if monthbutton.backgroundColor == darkbluecolor{
            
            setChart(dataPoints: time_oneyr_s, Values: indices_oneyr_f)
        }
    }
}
