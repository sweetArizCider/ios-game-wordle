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
        
        // Configurar la apariencia de los botones
        configurarBotones()
        
        // Actualizar los records al cargar la vista
        actualizarRecords()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Actualizar los records cada vez que aparece la vista
        actualizarRecords()
    }
    
    // MARK: - Configuración
    func configurarBotones() {
        let botones = [top1, top2, top3, top4, top5]
        
        for boton in botones {
            boton?.contentHorizontalAlignment = .left
            boton?.titleLabel?.numberOfLines = 1
            boton?.titleLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    // MARK: - Actualizar Records
    func actualizarRecords() {
        let botones = [top1, top2, top3, top4, top5]
        
        // Limpiar todos los botones primero
        for i in 0..<botones.count {
            if i < records.count {
                // Mostrar el record en formato: "Posición. Nombre - Puntaje pts"
                let record = records[i]
                let texto = "\(i + 1). \(record.nombre) - \(record.puntaje) pts"
                botones[i]?.setTitle(texto, for: .normal)
                botones[i]?.isEnabled = true
            } else {
                // Si no hay suficientes records, mostrar mensaje vacío
                botones[i]?.setTitle("\(i + 1). ---", for: .normal)
                botones[i]?.isEnabled = false
            }
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
