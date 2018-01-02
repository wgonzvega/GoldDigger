//
//  ViewController.swift
//  Gold Digger
//
//  Created by Walter Gonzalez on 1/1/18.
//  Copyright © 2018 Walter Gonzalez. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    
    var activeProduct : SKProduct?
    
    @IBOutlet weak var nameOutlet: UILabel!
    @IBOutlet weak var resultOutlet: UILabel!
    
    @IBAction func buyAction(_ sender: Any) {
        if let activeProduct = activeProduct {
            print("Buying...")
            let payment = SKPayment(product: activeProduct)
            SKPaymentQueue.default().add(payment)
            
        }
        
        
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch (transaction.transactionState) {
            case .purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                resultOutlet.text = "You got some Gold"
            case .failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                print("Something went wrong")
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        SKPaymentQueue.default().add(self)
        let productIDs : Set<String> = ["com.HomeDev.GoldDigger1.gold"]
        let productRequest = SKProductsRequest(productIdentifiers: productIDs)
        productRequest.delegate = self
        productRequest.start()
        
    }
    
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("Products Loaded")
        
        for product in response.products {
            print("Product: \(product.productIdentifier) \(product.localizedTitle) \(product.price.floatValue)")
            activeProduct = product
            nameOutlet.text = product.localizedTitle
        }
    }
  


}

