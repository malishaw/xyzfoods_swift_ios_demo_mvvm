//
//  ViewController.swift
//  XYZ Foods
//
//  Created by Maheesha on 12/3/20.
//

import SideMenu
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    @IBOutlet weak var tableView: UITableView!
    
    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DemoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "DemoTableViewCell")
        
        
        
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        downloadJson {
            self.tableView.reloadData()
            print("success")
        }
        
     
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func didTapMenu(){
        present(menu!, animated: true)
    }
    
    var hotels = [HotelStats]()
    
    func downloadJson(completed: @escaping () -> ()){
        
        let url = baseUrl
        
        URLSession.shared.dataTask(with: url!){
            (data,response, error) in
            if error == nil {
                do {
                    self.hotels = try JSONDecoder().decode([HotelStats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }catch{
                    print("JSON Error")
                }
            }
        }.resume()
    }
    
    //Table view func
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotels.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = UITableViewCell(style: .default, reuseIdentifier:nil)
//
//        cell.textLabel?.text=hotels[indexPath.row].name.capitalized
//        cell.imageView?.downloaded(from: "https://thenews.org/wp-content/uploads/2019/04/Popeyes_.jpg")
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoTableViewCell" , for: indexPath) as! DemoTableViewCell
        
        cell.cellLable?.text = hotels[indexPath.row].name.capitalized
        cell.cellImageView.backgroundColor = .red
        cell.cellImageView.downloaded(from: hotels[indexPath.row].image_url)
        
//        cell.imageView?.downloaded(from: "https://thenews.org/wp-content/uploads/2019/04/Popeyes_.jpg")
//        cell.textLabel?.text = hotels[indexPath.row].name.capitalized
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier:"showDetails", sender:self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailsViewController{
            destination.hotel = hotels[(tableView.indexPathForSelectedRow?.row)!]
        }

    }
    
}


class MenuListController : UITableViewController{
    var items = ["Home", "Branch Locator"]
    var  darkColor = UIColor(
        red: 33/255.0,
        green: 33/255.0,
        blue: 33/255.0,
        alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath)-> UITableViewCell{
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
    cell.textLabel?.text = items[indexPath.row]
    cell.textLabel?.textColor = .white
    cell.backgroundColor = darkColor
    return cell
}
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath .row) {
        case 0:
           
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController") as! ViewController
             self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
           
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mapViewController") as! MapViewController
             self.navigationController?.pushViewController(vc, animated: true)
            
    
        default:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeViewController") as! ViewController
             self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
   
}
