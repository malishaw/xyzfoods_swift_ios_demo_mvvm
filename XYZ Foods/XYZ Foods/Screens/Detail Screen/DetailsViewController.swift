//
//  DetailsViewController.swift
//  XYZ Foods
//
//  Created by Malisha on 12/4/20.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var discriptionLabel: UILabel!
    
    var hotel : HotelStats?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = hotel?.name
        
        let urlString = (hotel?.image_url)!
        
        let url = URL(string: urlString)
        
        imageView.downloaded(from:url!)
        
        discriptionLabel.text = hotel?.description
        
        
        
    }
    


}
