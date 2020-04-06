//
//  ViewController.swift
//  Mapas
//
//  Created by Sergio Muñoz on 03/04/2020.
//  Copyright © 2020 Sergio Muñoz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    enum TipoMapa: Int {
        case mapa = 0
        case satelite
    }
    
    var numPins : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userTrackingButton = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.leftBarButtonItem = userTrackingButton
    }

    @IBOutlet weak var mapView: MKMapView!{
        didSet {
            mapView.mapType = .standard
            mapView.delegate = self
            let alicanteLocation =
                CLLocationCoordinate2D(latitude: 38.3453,
                                       longitude: -0.4831)
            let initialLocation =
                CLLocation(latitude: alicanteLocation.latitude,
                           longitude: alicanteLocation.longitude)
            centerMapOnLocation(mapView: mapView, loc: initialLocation)
        }
    }
    
    @IBAction func seleccion(_ sender: UISegmentedControl) {
        let tipoMapa = TipoMapa(rawValue: sender.selectedSegmentIndex)!
        switch (tipoMapa) {
            case .mapa:
                mapView.mapType = MKMapType.standard
            case .satelite:
                mapView.mapType = MKMapType.satellite
        }
    }
    
    func centerMapOnLocation(mapView: MKMapView, loc: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion =
            MKCoordinateRegion(center: loc.coordinate,
                               latitudinalMeters: regionRadius * 4.0, longitudinalMeters: regionRadius * 4.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @IBAction func addAnotacion(_ sender: Any) {
        self.numPins += 1
        let pin = Pin(num: self.numPins, coordinate: mapView.centerCoordinate)
       mapView.addAnnotation(pin)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("Devolviendo vista para anotación: \(annotation)")
        var view  : MKPinAnnotationView?
        if annotation.isKind(of: Pin.self){
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view?.pinTintColor = UIColor.red
            view?.animatesDrop = true
            view?.canShowCallout = true
            
            let pin = annotation as! Pin
            let thumbnailImageView = UIImageView(frame: CGRect(x:0, y:0, width: 59, height: 59))
            thumbnailImageView.image = pin.thumbImage
            view?.leftCalloutAccessoryView = thumbnailImageView
            view?.rightCalloutAccessoryView = UIButton(type:UIButton.ButtonType.detailDisclosure)
        }else{
            view = nil
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        performSegue(withIdentifier: "DetalleImagen", sender: view)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetalleImagen" {
            if let pin = (sender as? MKAnnotationView)?.annotation as? Pin {
                if let vc = segue.destination as? MiImageViewController {
                    vc.imageDetail = pin.thumbImage
                }
            }
        }
    }
    
    
}

