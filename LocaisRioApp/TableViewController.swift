//
//  TableViewController.swift
//  LocaisRioApp
//
//  Created by Ramon dos Santos on 14/05/17.
//  Copyright © 2017 Ebix American Latin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    final let urlString = "http://demo3842168.mockable.io/LocaisRioApp/API/Places"
    
    @IBOutlet weak var _tableView: UITableView!
    //@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var placeArray = [Place]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.downloadJsonWithURL()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //mostrar a pagina de login, caso o usuário não esteja logado.
    override func viewDidAppear(_ animated: Bool) {
        
        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        
        if(!isUserLoggedIn) {
            self.performSegue(withIdentifier: "loginView", sender: self)
        }
    }
    
    //botão sair.
    @IBAction func logoutTappedBotton(_ sender: AnyObject) {
        
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        UserDefaults.standard.synchronize()
        
        self.performSegue(withIdentifier: "loginView", sender: self)
    }
    
    
    // MARK: - Table view data source
    
    func downloadJsonWithURL()
    {
        let url = NSURL(string: urlString)
        URLSession.shared.dataTask(with: (url as? URL)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                print(jsonObj!.value(forKey: "places") as Any)
                
                if let placeArray = jsonObj!.value(forKey:"places") as? NSArray {
                    for place in placeArray {
                        if let placeDict = place as? NSDictionary {
                            
                            let nameStr: String = {
                                if let name = placeDict.value(forKey: "name") {
                                    return name as! String
                                }
                                return "dummy name"
                            }()
                            
                            let districtStr: String = {
                                if let district = placeDict.value(forKey: "district") {
                                    return district as! String
                                }
                                return "dummy district"
                            }()
                            
                            let imgStr: String = {
                                if let img = placeDict.value(forKey: "image") {
                                    return img as! String
                                }
                                return "dummy image"
                            }()
                            
                            let descriptionStr: String = {
                                if let description = placeDict.value(forKey: "description") {
                                    return description as! String
                                }
                                return "dummy description"
                            }()
                            
                            self.placeArray.append(Place(name: nameStr, district: districtStr, img: imgStr, description: descriptionStr))
                            
                            OperationQueue.main.addOperation({
                                self.tableView.reloadData()
                            })
                        }
                    }
                }
            }
        }).resume()
    }
    
    func downloadJsonWithTask() {
        let url = NSURL(string: urlString)
        var downloadTask = URLRequest(url: (url as? URL)!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 20)
        
        downloadTask.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: downloadTask, completionHandler: {(data, response, error) -> Void in
            
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            print(jsonData as Any)
            
        }).resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return placeArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let place = placeArray[indexPath.row]
        let imgURL = NSURL(string: place.imageStr)
        
        cell.nameLabel.text = place.name
        cell.districtLabel.text = place.district
        
        if imgURL != nil {
            let data = NSData(contentsOf: (imgURL as? URL)!)
            cell.imgView.image = UIImage(data: data as! Data)
        }
        
        return cell
    }
    
    
    //mostra a próxima tela detalhada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let place = placeArray[indexPath.row]
        
        vc.nameString = place.name
        vc.descriptionString = place.descript
        vc.imageString = place.imageStr
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //método para visualizar o mapa
    @IBAction func showMap() {
        let vcMap = MapViewController(nibName: "MapViewController", bundle: nil)
        self.navigationController!.pushViewController(vcMap, animated: true)
    }
    
    
    
}
