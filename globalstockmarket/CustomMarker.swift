//
//  CustomMarker.swift
//  globalstockmarket
//
//  Created by Samarth Kejriwal on 28/06/17.
//  Copyright © 2017 Samarth Kejriwal. All rights reserved.
//

import Foundation

import Charts

open class XYMarkerView1: BalloonMarker
{
    open var xAxisValueFormatter: IAxisValueFormatter?
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter)
    {
        super.init(color: color, font: font, textColor: textColor, insets: insets)
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabel(xAxisValueFormatter!.stringForValue(entry.x, axis: nil) + ", " + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!)
    }
    
}
