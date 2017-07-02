//
//  jsonstructure.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 23/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import Foundation


class JSONData {
    var country: String
    var indicename: String
    var currPrice: String
    var chg: String
    var perChg: String
    
    init?(dictionary: [String:Any]) {
        guard let country = dictionary["Country"] as? String,
            let indicename = dictionary["Indicename"] as? String,
            let currPrice = dictionary["CurrPrice"] as? String,
            let chg = dictionary["Chg"] as? String,
            let perChg = dictionary["PerChg"] as? String else {
                return nil
        }
        self.country = country
        self.indicename = indicename
        self.currPrice = currPrice
        self.chg = chg
        self.perChg = perChg
    }
}

struct JSONData1 {
    var country: String
    var indicename: String
    var zone: String
    var date : String
    var prev_close : String
    var indicesdata_oneday : String
    var indiceszone_oneday : String
    var indicesdata_onem : String
    var indiceszone_onem : String
    var indicesdata_threem : String
    var indiceszone_threem : String
    var indicesdata_oneyr : String
    var indiceszone_oneyr : String
    var indicestime_oneday : String
    var indicestime_onem : String
    var indicestime_threem : String
    var indicestime_oneyr : String
    var prev_closem : String
    var prev_closew : String
    
    var currPrice: String
    var chg: String
    var perChg: String
    
    init?(dictionary: [String:Any]) {
        guard let country = dictionary["Country"] as? String,
            let indicename = dictionary["Indicename"] as? String,
            let currPrice = dictionary["CurrPrice"] as? String,
            let chg = dictionary["Chg"] as? String,
            let perChg = dictionary["PerChg"] as? String,
            let zone = dictionary["zone"] as? String,
            let date = dictionary["date"] as? String,
            let prev_close = dictionary["prev_close"] as? String,
        
            let indicesdata_oneday = dictionary["indices_data_onedy"] as? String,
            let indiceszone_oneday = dictionary["indices_zone_onedy"] as? String,
            let indicesdata_onem = dictionary["indices_data_one_m"] as? String,
            let indiceszone_onem = dictionary["indices_zone_one_m"] as? String,
            let indicesdata_threem = dictionary["indices_data_3_m"] as? String,
            let indiceszone_threem = dictionary["indices_zone_3_m"] as? String,
            let indicesdata_oneyr = dictionary["indices_data_yr"] as? String,
            let indiceszone_oneyr = dictionary["indices_zone_yr"] as? String,
            let indicestime_oneday = dictionary["indices_time_onedy"] as? String,
        let indicestime_threem = dictionary["indices_time_3_m"] as? String,
        let indicestime_onem = dictionary["indices_time_one_m"] as? String,
        let indicestime_oneyr = dictionary["indices_time_yr"] as? String,
        let prev_closem = dictionary["prev_close_m"] as? String,
        let prev_closew = dictionary["prev_close_w"] as? String  else {
                return nil
        }
        self.country = country
        self.indicename = indicename
        self.currPrice = currPrice
        self.chg = chg
        self.perChg = perChg
        self.zone = zone
        self.date = date
        self.prev_close = prev_close
        self.indicesdata_oneday = indicesdata_oneday
        self.indiceszone_oneday = indiceszone_oneday
        self.indicesdata_onem = indicesdata_onem
        self.indiceszone_onem = indiceszone_onem
        self.indicesdata_threem = indicesdata_threem
        self.indiceszone_threem = indiceszone_threem
        self.indicesdata_oneyr = indicesdata_oneyr
        self.indiceszone_oneyr = indiceszone_oneyr
        self.indicestime_oneday = indicestime_oneday
        self.indicestime_threem = indicestime_threem
        self.indicestime_onem = indicestime_onem
        self.indicestime_oneyr = indicestime_oneyr
        self.prev_closem = prev_closem
        self.prev_closew = prev_closew
        
    }
}
struct Properties_Utils{
    var stringurl  = "http://www.appuonline.com/appu_android_app/global_stock_app/stock_list.php?continent="
    let tableviewheight  = 120
}
