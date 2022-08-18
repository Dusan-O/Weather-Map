//
//  AlertHelper.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation
import UIKit

class AlertHelper {
    
    static let shared = AlertHelper()
    
    func addCity(_ controller: UIViewController, completion: ((String) -> Void)?) {
        let alert = UIAlertController(title: "Ajouter une ville", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Nom de ville"
        }
        let ok = UIAlertAction(title: "Valider", style: .default) { action in
            if let tf = alert.textFields?.first {
                if let text = tf.text, text != "" {
                    UDHelper.shared.addDatas(text)
                    completion?(text)
                }
            }
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        controller.present(alert, animated: true, completion: nil)
    }
    
    func allCities(_ controller: UIViewController, completion: ((String) -> Void)?) {
        let alert = UIAlertController(title: "Choisissez une ville", message: nil, preferredStyle: .actionSheet)
        let array = UDHelper.shared.getCities()
        array.forEach { city in
            let act = UIAlertAction(title: city, style: .default) { action in
                completion?(city)
            }
            alert.addAction(act)
        }
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        alert.addAction(cancel)
        controller.present(alert, animated: true, completion: nil)
    }
    
}

