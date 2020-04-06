//
//  MiImageViewController.swift
//  Mapas
//
//  Created by Sergio Muñoz on 03/04/2020.
//  Copyright © 2020 Sergio Muñoz. All rights reserved.
//

import UIKit

class MiImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageDetail: UIImage? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageDetail != nil {
            imageView.image = imageDetail!
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
