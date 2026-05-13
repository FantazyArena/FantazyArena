//
//  Alerts.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 12/05/2026.
//

import UIKit

extension UIViewController {

    func showNoInternetAlert() {

        let alert = UIAlertController(
            title: "No Internet Connection",
            message: "Please check your connection and try again.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
    
    
    func showCommingSoonAlert() {

        let alert = UIAlertController(
            title: "OoPs",
            message: "This is Comming Soon Feature.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }
}
