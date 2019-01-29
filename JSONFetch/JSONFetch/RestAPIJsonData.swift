//
//  RestAPIJsonData.swift
//  simpsons
//
//  Created by Harinarayanan Janardhanan on 1/19/19.
//  Copyright © 2019 Harinarayanan Janardhanan. All rights reserved.
//

import Foundation
import UIKit

public protocol DataModelDelegate: class {
    func didRecieveDataUpdate(data: [SimpsonsModel], count : Int)
}

public protocol ImageModelDelegate: class {
    func didRecieveImageUpdate(image : UIImage)
}
public class RestAPIJsonData{
    
    public init() {}
    
    public weak var delegate: DataModelDelegate?
    public weak var imageDelegate : ImageModelDelegate?
    public func fetchData(url : String) {
        //loadingBar = UIViewController.displaySpinner(onView: self.view)
        var articlesData : ModelJSON?
        //var MasterViewObject = MasterViewComtroller()
        var simpSonsData : [SimpsonsModel] = []
        print("inside Fetch")
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                articlesData = try JSONDecoder().decode(ModelJSON.self, from: data)
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print("data",data)
                    //print(type(of: self.articlesData))
                    //need to check for optional
                    let dataCount = (articlesData?.RelatedTopics?.count)!
                    //MasterViewObject.tableView.reloadData()
                    for i in 0..<dataCount {
                        //neeed to check for optional
                        let simsTitle = String((articlesData?.RelatedTopics![i].Text?.split(separator: "-").first)!)
                        let simsDescription = String((articlesData?.RelatedTopics![i].Text?.split(separator: "-").last)!)
                        let simsIcon = articlesData?.RelatedTopics![i].Icon?.URL
                        print("setting url data", simsIcon)
                        simpSonsData.append(SimpsonsModel(simsTitle: simsTitle, simsDescription: simsDescription, simsIcon: simsIcon!))
                    }
                    self.delegate?.didRecieveDataUpdate(data: simpSonsData, count : dataCount)
                    //MasterViewObject.tableView.reloadData()
                }
                
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
    
    
    public func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    public func fetchImage(image : String!) {
        //need to check for optional
        //        guard let icon = simpsons?.simsIcon else{
        //            return
        //        }
        if let icon = image {
            print("url", icon)
            if icon == "" {
                //self.imageIcon.image = UIImage(named: "error")
                imageDelegate?.didRecieveImageUpdate(image : UIImage(named: "error")!)
                return
            }
            
            getData(from: URL(string : icon)!) { data, response, error in
                guard let data = data, error == nil else { return }
                //need to check for optional
                print(response?.suggestedFilename ?? URL(string: icon)!.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() {
                    //self.imageIcon.image = UIImage(data: data)
                    self.imageDelegate?.didRecieveImageUpdate(image : UIImage(data: data)!)
                }
            }
        }
        else{
            return
        }
    }
    
}
