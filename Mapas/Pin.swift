//
//  Pin.swift
//  Mapas
//
//  Created by Sergio Muñoz on 03/04/2020.
//  Copyright © 2020 Sergio Muñoz. All rights reserved.
//

import Foundation
import MapKit

class Pin:  NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var thumbImage: UIImage?
    var coordenate : CLLocationCoordinate2D?

    init(num: Int, coordinate: CLLocationCoordinate2D) {
        self.title = "Pin \(num)"
        //self.subtitle = "Un bonito lugar"
        self.coordinate = coordinate
        
        if (num % 2 == 0) {
            self.thumbImage = UIImage(named: "alicante1_thumb.jpg")!
        } else {
            self.thumbImage = UIImage(named: "alicante2_thumb.jpeg")!
        }
        super.init()
        
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: self.coordinate.latitude, longitude: self.coordinate.longitude)
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(location,
                    completionHandler: { (placemarks, error) in
            if error == nil {
                let firstLocation = (placemarks?[0])! as CLPlacemark
                self.subtitle = firstLocation.country
            }
            else {
             // An error occurred during geocoding.
                print("error con reverseGeocodeLocation:" + error!.localizedDescription)
            }
        })
        
    }
    
}
