//
//  API.swift
//  Flix App
//
//  Created by Kent Brylle Canonigo on 9/16/22.
//

import Foundation

struct API {

    
    static func getMovies(completion: @escaping ([[String:Any]]?) -> Void) {
     
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                // Convert json response to dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
                // Get the array of movies
                let movies  = dataDictionary["results"] as! [[String:Any]]
                
    
                return completion(movies)
                
                }
            
            }
        
            task.resume()
        
        }
    }

    
