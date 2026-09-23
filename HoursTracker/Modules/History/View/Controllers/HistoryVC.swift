//
//  HistoryVC.swift
//  HoursTracker
//
//  Created by H A M I . on 13/09/2026.
//

import UIKit
import RswiftResources

// Grid sizes from the design: 60pt item height, rows drawn 64pt apart
enum CalendarGrid {
    static let itemHeight: CGFloat = 60
    static let rowSpacing: CGFloat = 4
}

// One square in the grid: its real date, and whether it belongs to the month on screen
struct CalendarDay {
    let date: Date
    let isInMonth: Bool
}


class HistoryVC: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calanderCV: UICollectionView! {
        didSet{
            calanderCV.delegate = self
            calanderCV.dataSource = self
            calanderCV.register(R.nib.callenderCVC)
        }
    }
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint?
    
    var selectedDate = Date()   // the month currently on screen
    var selectedDay: Date?      // the day the user tapped (nil = nothing selected)
    var totalSquares = [CalendarDay]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMonthView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCellsView()
    }
    

    
    @IBAction func previousMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any)
    {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }

}


extension HistoryVC {
    
    
    func setCellsView()
    {
        let columns: CGFloat = 7
        
        // Width follows the device; height is fixed by the design
        let width = (calanderCV.bounds.width / columns).rounded(.down)
        guard width > 0 else { return }
        let newSize = CGSize(width: width, height: CalendarGrid.itemHeight)
        
        let flowLayout = calanderCV.collectionViewLayout as! UICollectionViewFlowLayout
        guard flowLayout.itemSize != newSize else { return }   // runs every layout pass, so only update on change
        flowLayout.itemSize = newSize
        flowLayout.minimumLineSpacing = CalendarGrid.rowSpacing
        flowLayout.minimumInteritemSpacing = 0
    }
    
    
    //    func setMonthView()
    //    {
    //        totalSquares.removeAll()
    //
    //        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
    //        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
    //        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
    //
    //        var count: Int = 1
    //
    //        while(count <= 42)
    //        {
    //            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
    //            {
    //                totalSquares.append("")
    //            }
    //            else
    //            {
    //                totalSquares.append(String(count - startingSpaces))
    //            }
    //            count += 1
    //        }
    //
    //        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
    //            + " " + CalendarHelper().yearString(date: selectedDate)
    //
    //        calanderCV.reloadData()
    //    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let helper = CalendarHelper()
        let daysInMonth = helper.daysInMonth(date: selectedDate)
        let firstDayOfMonth = helper.firstOfMonth(date: selectedDate)
        let startingSpaces = helper.weekDay(date: firstDayOfMonth)

        // Only as many weeks as the month needs (5 or 6 rows), like the design
        let cellCount = (startingSpaces + daysInMonth + 6) / 7 * 7

        // Monday of the first row. It can fall in the previous month, e.g. 31 Aug
        let gridStart = helper.calendar.date(byAdding: .day, value: -startingSpaces, to: firstDayOfMonth)!

        for offset in 0..<cellCount
        {
            let date = helper.calendar.date(byAdding: .day, value: offset, to: gridStart)!
            let isInMonth = helper.calendar.isDate(date, equalTo: firstDayOfMonth, toGranularity: .month)
            totalSquares.append(CalendarDay(date: date, isInMonth: isInMonth))
        }
        
        monthLabel.text = helper.monthString(date: selectedDate)
            + " " + helper.yearString(date: selectedDate)
        
        updateCalendarHeight()
        calanderCV.reloadData()
    }
    func updateCalendarHeight()
    {
        let rows = CGFloat(totalSquares.count / 7)
        calendarHeightConstraint?.constant = rows * CalendarGrid.itemHeight + (rows - 1) * CalendarGrid.rowSpacing
    }
    
}
