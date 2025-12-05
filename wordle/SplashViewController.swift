//
//  SplashViewController.swift
//  wordle
//
//  Created by mac on 05/12/25.
//

import UIKit
class SplashViewController: UIViewController {

    @IBOutlet weak var imgSplash: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Tamaño inicial normal
        imgSplash.transform = CGAffineTransform(scaleX: 1, y: 1)
        
        // Primer latido (crece)
        UIView.animate(withDuration: 0.6) {
            self.imgSplash.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        } completion: { fin in
            
            // Segundo movimiento (regresa a tamaño normal)
            UIView.animate(withDuration: 0.6) {
                self.imgSplash.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: { fin2 in
                
                // Seguir a la siguiente pantalla
                self.performSegue(withIdentifier: "sgSplash", sender: nil)
            }
        }
    }
}
