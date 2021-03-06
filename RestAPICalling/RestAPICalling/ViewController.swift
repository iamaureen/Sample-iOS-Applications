//
//  ViewController.swift
//  RestAPICalling
//
//  Created by iamaureen on 6/13/17.
//  Copyright © 2017 iamaureen. All rights reserved.
//  Reference Link: https://grokswift.com/simple-rest-with-swift/

import UIKit

class ViewController: UIViewController {
    
    
    //two ways to post::
    //1) via url and 2) via json
    
    //button action for posting to api through json
    
    @IBAction func PostbyJson(_ sender: Any) {
        
        //post via json :: https://grokswift.com/simple-rest-with-swift/
        
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        
        guard let todosURL = URL(string: todosEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        
        var todosUrlRequest = URLRequest(url: todosURL)
        todosUrlRequest.httpMethod = "POST"
        let newTodo: [String: Any] = ["title": "Mau is my name", "completed": false, "userId": 1]
        //print(newTodo)
        let jsonTodo: Data
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: newTodo, options: [])
            todosUrlRequest.httpBody = jsonTodo
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: todosUrlRequest) {
            (data, response, error) in
            guard error == nil else {
                print("error calling POST on /todos/1")
                print(error)
                return
            }
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            // parse the result as JSON, since that's what the API provides
            do {
                guard let receivedTodo = try JSONSerialization.jsonObject(with: responseData,
                                                                          options: []) as? [String: Any] else {
                                                                            print("Could not get JSON from responseData as dictionary")
                                                                            return
                }
                print("The todo is: " + receivedTodo.description)
                
                guard let todoID = receivedTodo["id"] as? Int else {
                    print("Could not get todoID as int from JSON")
                    return
                }
                print("The ID is: \(todoID)")
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
        }
        task.resume()
    }
    
    //button action for posting to api through url
    @IBAction func PostAPIBtn(_ sender: Any) {
        
        
        //post via url :: reference link: https://code.bradymower.com/swift-3-apis-network-requests-json-getting-the-data-4aaae8a5efc0 (Example 7)
        
        let urlToRequest = "https://aiaas.pandorabots.com/talk/1409611535153/robinsocial"
        
        let url4 = URL(string: urlToRequest)!
        
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "input=Set name ishrat&user_key=7d387c332ebfa536b90b7820426ed63b"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(dataString)") //JSONSerialization
        }
        task.resume()
        
        
        
    }
    
    //get info using API connection
    @IBAction func GetAPIBtn(_ sender: Any) {
        
        
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        
        //guard statement lets us check that the URL we’ve provided is valid.
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        //we need URLSession to use to send the request, we can use the default shared session
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on /comments/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let todo = try JSONSerialization.jsonObject(with: responseData, options: [])
                    /*if get returns array of objects:
                     let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/"
                     this will return array of objects, in that case the next line should be
                     as? [Any] else
                     */
                    as? [String: Any] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("The todo is: " + todo.description)
                
                //    the todo object is a dictionary
                //     so we just access the title using the "title" key
                //     so check for a title and print it if we have one
                guard let todoTitle = todo["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
                
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
    }
    
    
    
    
    
    
    
}

