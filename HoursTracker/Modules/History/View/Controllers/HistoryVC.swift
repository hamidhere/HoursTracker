//
//  HistoryVC.swift
//  HoursTracker
//
//  Created by H A M I . on 13/09/2026.
//

import UIKit
import RswiftResources

class HistoryVC: UIViewController {
    
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calanderCV: UICollectionView! {
        didSet{
            calanderCV.delegate = self
            calanderCV.dataSource = self
            calanderCV.register(R.nib.callenderCVC)
        }
    }
    var selectedDate = Date()
    var totalSquares = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setCellsView()
        setMonthView()
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
            let rows: CGFloat = 6

            let width = calanderCV.frame.size.width / columns
            let height = calanderCV.frame.size.height / rows

            let flowLayout = calanderCV.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: width, height: height)
            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        
        calanderCV.reloadData()
    }
}
