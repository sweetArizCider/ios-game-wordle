//
//  NombreViewController.swift
//  wordle
//
//  Created by mac on 03/12/25.
//

import UIKit

class NombreViewController: UIViewController {
    
    @IBOutlet weak var campoNombre: UITextField!
    @IBOutlet weak var botonAceptar: UIButton!
    
    var puntajeFinal: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar el campo de texto
        campoNombre.placeholder = "Ingresa tu nombre"
        campoNombre.becomeFirstResponder()
    }
    
    @IBAction func aceptarNombre(_ sender: UIButton) {
        guard let nombre = campoNombre.text, !nombre.isEmpty else {
            mostrarAlerta(titulo: "Error", mensaje: "Por favor ingresa tu nombre")
            return
        }
        
        // Agregar el record al array global
        records.append((nombre: nombre, puntaje: puntajeFinal))
        
        // Ordenar los records de mayor a menor puntaje
        records.sort { $0.puntaje > $1.puntaje }
        
        // Cerrar la vista directamente
        self.dismiss(animated: true) {
            // Notificar a ClassicModeViewController que debe reiniciarse
            if let presentingVC = self.presentingViewController as? ClassicModeViewController {
                presentingVC.debeReiniciar = true
            }
        }
    }
    
    func mostrarAlerta(titulo: String, mensaje: String, completado: (() -> Void)? = nil) {
        let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
        let accion = UIAlertAction(title: "Aceptar", style: .default) { _ in
            completado?()
        }
        alerta.addAction(accion)
        present(alerta, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Conectar el botón aceptar
        botonAceptar.addTarget(self, action: #selector(aceptarNombre(_:)), for: .touchUpInside)
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
