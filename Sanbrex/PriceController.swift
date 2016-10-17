//
//  PriceController.swift
//  Sanbrex
//
//  Created by Motivator on 17/10/2016.
//  Copyright © 2016 Motivator. All rights reserved.
//

import Foundation
import UIKit


class PriceController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
// MARK: Properties

    var dataItems : Array<Dictionary<String, AnyObject>> = []
    var timer:Timer? = nil
    
    var instrumentType: Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        makeGet()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector:  #selector(PriceController.makeGet), userInfo: nil, repeats: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK NETWORK
    
    
    func loadData(url:String) {
//        afnetworkin
    }
    
    func makeGet() {
//        let urlString = "https://api-fxpractice.oanda.com/v1/prices?instruments=EUR_USD%2CUSD_JPY%2C"
        
//        var urlString = "https://api-fxpractice.oanda.com/v1/prices?instruments=XAU_USD%2CXAU_AUD%2CXAU_CAD%2CXAU_EUR%2CXAU_JPY%2C"
        
        
        var urlString = "https://api-fxpractice.oanda.com/v1/prices?"
        
        switch instrumentType {
        case 1:
            urlString += "instruments=XAU_USD%2CXAU_AUD%2CXAU_CAD%2CXAU_EUR%2CXAU_JPY%2C"
        case 2:
            urlString += "instruments=XAG_USD%2CXAG_AUD%2CXAG_CAD%2CXAG_EUR%2CXAG_JPY%2C"
        case 3:
            urlString += "instruments=XPT_USD%2CXPT_AUD%2CXPT_CAD%2CXPT_EUR%2CXPT_JPY%2C"
        case 4:
            urlString += "instruments=XPD_USD%2CXPD_AUD%2CXPD_CAD%2CXPD_EUR%2CXPD_JPY%2C"
        default:
            urlString += "instruments=XAU_USD%2CXAU_AUD%2CXAU_CAD%2CXAU_EUR%2CXAU_JPY%2C"
        }
        
        
        let key: String = "Bearer 6986fad0861347474e64aab947c4548a-0923d9b9d65f93a1058db63def3e9740"
      
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
 
        
       
        
        manager.requestSerializer.setValue(key, forHTTPHeaderField: "Authorization")
        manager.requestSerializer.setValue("6986fad0861347474e64aab947c4548a-0923d9b9d65f93a1058db63def3e9740", forHTTPHeaderField: "5680579")
//         [manager.requestSerializer setValue:some_value forHTTPHeaderField:@"some_field"];
        manager.get(urlString, parameters: nil, success:
            {
                requestOperation, response in
                
//                let dic:Dictionary = ["":""]
////                dic(value(forKey: "pice"))
                var prices:Dictionary = response as! Dictionary<String, AnyObject>
              
                
//                var items : Array = prices["prices"] as! Array<Dictionary<String,String>>
                
                self.dataItems = prices["prices"] as! Array<Dictionary<String, AnyObject>>
                print(self.dataItems)
                self.tableView.reloadData()
                
                
            
            },
                     failure:
            {
                requestOperation, error in
                print(error)
                print(error.localizedDescription)
                
        })
    }
    
    
    //MARK DATA SOURCE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataItems.count
    }
    
    
    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!) -> UITableViewCell! {
        

        
var cell: PriceCell
        
//        var cell: PriceCell =  (tableView.dequeueReusableCell(withIdentifier: "PriceCell") as? PriceCell)!
//        if  cell == nil {
            cell  = Bundle.main.loadNibNamed("PriceCell", owner: nil, options: nil)?[0] as! PriceCell
//        }
       
        let item = self.dataItems[indexPath.row]
        
        let country=item["instrument"] as! String
//        country.contains("USD")
       
        if country.contains("USD") {
            cell.countryName.text = "USD"
            cell.countryImage.image = UIImage(named: "USA1")
        }else if country.contains("AUD") {
            cell.countryName.text = "AUD"
            cell.countryImage.image = UIImage(named: "AUS1")
        }else if country.contains("CAD") {
            cell.countryName.text = "CAD"
            cell.countryImage.image = UIImage(named: "ENG1")
        }else if country.contains("JPY") {
            cell.countryName.text = "JPY"
            cell.countryImage.image = UIImage(named: "JPY1")
        }else if country.contains("EUR") {
            cell.countryName.text = "EUR"
            cell.countryImage.image = UIImage(named: "ENG1")
        }
        
    
//       cell.countryName.text = "iqbal"
        let once = item["bid"] as! Double
//        print(once)
//        NSString(stringwi)
        cell.lbl2.text = String(format: "$%.2f", "", once)
        cell.lbl1.text = String(format: "$%.2f", "", once/28.349)
        return cell
    }
    
    //MARK ACTIONS
    
    @IBAction func Pladium(_ sender: AnyObject) {
        instrumentType = 4
        self.makeGet()
    }
    @IBAction func Platinum(_ sender: AnyObject) {
        instrumentType = 3
        self.makeGet()
    }
    @IBAction func silver(_ sender: AnyObject) {
        instrumentType = 2
        self.makeGet()
    }
    @IBAction func gold(_ sender: AnyObject) {
        
//        var button = sender as! UIButton
//        button.isSelected = true;
        instrumentType = 1
        self.makeGet()
    }
    
}
