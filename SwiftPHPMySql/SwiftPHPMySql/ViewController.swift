//
//  ViewController.swift
//  SwiftPHPMySql
//
//  Created by HeklerLab on 7/2/17.
//  Copyright © 2017 iamaureen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //api url to post into mysql
    let URL_DB = "http://192.168.1.17/robin/createteam"
    
    // textfields declarations
    @IBOutlet weak var textFieldModule: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    
    //Button action method
    @IBAction func saveBtn(_ sender: Any) {
        // we will send a POST request to the URL. we will use NSMutableURLRequest
        //https://www.simplifiedios.net/swift-php-mysql-tutorial/ -> this is in swift 2
        //for swift 3: https://stackoverflow.com/questions/26364914/http-request-in-swift-with-post-method
        
        //create NSURL
        let requestURL = URL(string: URL_DB)
        
        //create NSMutableURLRequest
        var request = URLRequest(url: requestURL!)
        
       
        
        
        //setting the method to POST
        request.httpMethod = "POST"
        
        //getting values from text fields
        let module = textFieldModule.text
        let name = textFieldName.text
        
        print("module :: + \(module)")
        print("name ::  +  \(name)")
        
        //create postParameters 
        let postParam = "module="+module!+"&name="+name!
        
        //adding the parameters to request body
        request.httpBody = postParam.data(using: String.Encoding.utf8)
        
        //create a task to send the post request
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil else{
                print("error = \(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200{
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            print("i am here")
            
            //parsing the response - in this case webservice is returning json
            print(data)
            
            print("i am here too")
        }
        task.resume()
        
        
        
        
        
        
    }
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

