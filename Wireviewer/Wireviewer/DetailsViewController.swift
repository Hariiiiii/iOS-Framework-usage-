//
//  DetailsViewController.swift
//  Wireviewer
//
//  Created by Harinarayanan Janardhanan on 1/21/19.
//  Copyright © 2019 Harinarayanan Janardhanan. All rights reserved.
//

import UIKit
import JSONFetch

extension DetailViewController: ImageModelDelegate {
    func didRecieveImageUpdate(image: UIImage) {
        self.imageIcon.image = image
    }
    
    
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var simpsonTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var titleDescription: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    private let imageModel = RestAPIJsonData()
    
    var simpsons : SimpsonsModel? {
        didSet {
            refreshUI()
            imageModel.imageDelegate = self
            imageModel.fetchImage(image: simpsons?.simsIcon)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 10
        
        imageIcon.clipsToBounds = true
        imageIcon.layer.cornerRadius = 10
        
    }
    
    func refreshUI() {
        loadViewIfNeeded()
        //optional unwrap needed
        simpsonTitle.text = simpsons?.simsTitle
        titleDescription.text = simpsons?.simsDescription
        print(simpsons?.simsTitle)
        print(simpsons?.simsDescription)
        print(simpsons?.simsIcon)
        //need to check for optional
        //fetchImage(icon : (simpsons?.simsIcon)!)
    }
    
    //    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    //        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    //    }
    //
    //    func fetchImage() {
    //        //need to check for optional
    ////        guard let icon = simpsons?.simsIcon else{
    ////            return
    ////        }
    //        if let icon = simpsons?.simsIcon {
    //            print("url", icon)
    //            if icon == "" {
    //                self.imageIcon.image = UIImage(named: "error")
    //                return
    //            }
    //
    //        getData(from: URL(string : icon)!) { data, response, error in
    //            guard let data = data, error == nil else { return }
    //            //need to check for optional
    //            print(response?.suggestedFilename ?? URL(string: icon)!.lastPathComponent)
    //            print("Download Finished")
    //            DispatchQueue.main.async() {
    //                self.imageIcon.image = UIImage(data: data)
    //            }
    //        }
    //        }
    //        else{
    //            return
    //        }
    //    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension DetailViewController: SimpsonSelectionDelegate {
    func simpsonSelected(_ newSimpson: SimpsonsModel) {
        simpsons = newSimpson
    }
}
