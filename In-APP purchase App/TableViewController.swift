//
//  TableViewController.swift
//  In-APP purchase App
//
//  Created by Sreenivas k on 07/05/21.
//

import UIKit
import StoreKit

class TableViewController: UITableViewController  {
    var productID="com.stevebrains.In-APP-purchase-App"
    var normalQuetes=["Love all, trust a few, do wrong to none.",
                      "You call it madness, but I call it love.",
                      "We can only learn to love by loving.",
                      "A life lived in love will never be dull.",
                      "Life is the flower for which love is the honey.",
                      "All you need is love.",
                      "True love stories never have endings."]
    let premiumQuetes=[
        "If I know what love is, it is because of you.",
        
        "I swear I couldn’t love you more than I do right now, and yet I know I will tomorrow.",
       " If you live to be a hundred, I want to live to be a hundred minus one day so I never have to live without you.",
        "A man is already halfway in love with any woman who listens to him.",
        "I love you as certain dark things are to be loved, in secret, between the shadow and the soul.",
        "Women are meant to be loved, not to be understood.",
        "You make me want to be a better man.” – Melvin Udall",
        "Thinking of you keeps me awake. Dreaming of you keeps me asleep. Being with you keeps me alive."
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        SKPaymentQueue.default().add(self)
        if getPurchaseStatus(){
            givePremiumQuotes()
        }
        
       
    }
  


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if getPurchaseStatus(){
            return normalQuetes.count
        }
        else{
        return normalQuetes.count+1
        }
    
    }
    @IBAction func RestoredPressed(_ sender: UIBarButtonItem) {
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QCell", for: indexPath)
      
        if indexPath.row<normalQuetes.count{
            cell.textLabel?.text = normalQuetes[indexPath.row]
            cell.textLabel?.numberOfLines=0
            cell.textLabel?.textColor=#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.accessoryType = .none
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
extension TableViewController:SKPaymentTransactionObserver{
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for t in transactions{
            if t.transactionState == .purchased{
                print("payment purchased")
                givePremiumQuotes()
                UserDefaults.standard.setValue(true, forKey: productID)
            }else if t.transactionState == .failed{
    
                if let error=t.error{
                    print("payment Failed")
                    print(error.localizedDescription)
                    
                }
            }
        }
    }
    func givePremiumQuotes() {
        normalQuetes.append(contentsOf: premiumQuetes)
        tableView.reloadData()
    }
    func getPurchaseStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: productID)
    }
    
}
