//
//  RecordsViewController.swift
//  wordle
//
//  Created by mac on 03/12/25.
//

import UIKit

class RecordsViewController: UIViewController {
    
    @IBOutlet weak var top1: UIButton!
    @IBOutlet weak var top2: UIButton!
    @IBOutlet weak var top3: UIButton!
    @IBOutlet weak var top4: UIButton!
    @IBOutlet weak var top5: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cargarRecords()
        configurarBotones()
        actualizarRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cargarRecords()
        actualizarRecords()
    }
    
    func configurarBotones() {
        let botones = [top1, top2, top3, top4, top5]
        
        for boton in botones {
            boton?.contentHorizontalAlignment = .center
            boton?.titleLabel?.numberOfLines = 1
            boton?.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }

    func actualizarRecords() {
        let botones = [top1, top2, top3, top4, top5]
        for i in 0..<botones.count {
            if i < records.count {
                let record = records[i]
                let texto = "\(i + 1). \(record.nombre) - \(record.puntaje) pts"
                botones[i]?.setTitle(texto, for: .normal)
                botones[i]?.isEnabled = true
            } else {
                botones[i]?.setTitle("\(i + 1). ---", for: .normal)
                botones[i]?.isEnabled = false
            }
        }
    }


}
