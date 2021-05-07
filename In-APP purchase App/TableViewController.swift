//
//  TableViewController.swift
//  In-APP purchase App
//
//  Created by Sreenivas k on 07/05/21.
//

import UIKit
import StoreKit

class TableViewController: UITableViewController {
    var productID="com.stevebrains.In-APP-purchase-App"
    var normalQuetes=["Love all, trust a few, do wrong to none.",
                      "You call it madness, but I call it love.",
                      "We can only learn to love by loving.",
                      "A life lived in love will never be dull.",
                      "Life is the flower for which love is the honey.",
                      "All you need is love.",
                      "True love stories never have endings."]
    let premiumQuetes=["HI ,man","Bye man"]

    override func viewDidLoad() {
        super.viewDidLoad()
        

       
    }
  


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 
        return normalQuetes.count+1
    }
    @IBAction func RestoredPressed(_ sender: UIBarButtonItem) {
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QCell", for: indexPath)
      
        if indexPath.row<normalQuetes.count{
            cell.textLabel?.text = normalQuetes[indexPath.row]
            cell.textLabel?.numberOfLines=0
        }else{
            cell.textLabel?.text="Get More"
            cell.textLabel?.textColor=#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.accessoryType =    .disclosureIndicator
            
        }
       
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row==normalQuetes.count{
            print("Buy")
            buyQuotes()
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    
    func buyQuotes(){
        if SKPaymentQueue.canMakePayments(){
            let payment = SKMutablePayment()
            payment.productIdentifier=productID
            SKPaymentQueue.default().add(payment)
        }
    }
   

}
