//
//  ClassicModeViewController.swift
//  wordle
//
//  Created by mac on 02/12/25.
//

import UIKit

// Variable global para almacenar los records de los jugadores
var records: [(nombre: String, puntaje: Int)] = []

class ClassicModeViewController: UIViewController {
    
    //fila 1 izq a derecha
    @IBOutlet weak var campo0: UIButton!
    @IBOutlet weak var campo1: UIButton!
    @IBOutlet weak var campo2: UIButton!
    @IBOutlet weak var campo3: UIButton!
    @IBOutlet weak var campo4: UIButton!
    //fila dos
    @IBOutlet weak var campo5: UIButton!
    @IBOutlet weak var campo6: UIButton!
    @IBOutlet weak var campo7: UIButton!
    @IBOutlet weak var campo8: UIButton!
    @IBOutlet weak var campo9: UIButton!
    // fila tres
    @IBOutlet weak var campo10: UIButton!
    @IBOutlet weak var campo11: UIButton!
    @IBOutlet weak var campo12: UIButton!
    @IBOutlet weak var campo13: UIButton!
    @IBOutlet weak var campo14: UIButton!
    // fila cuatro
    @IBOutlet weak var campo15: UIButton!
    @IBOutlet weak var campo16: UIButton!
    @IBOutlet weak var campo17: UIButton!
    @IBOutlet weak var campo18: UIButton!
    @IBOutlet weak var campo19: UIButton!
    
    //teclado
    @IBOutlet weak var teclaQ: UIButton!
    @IBOutlet weak var teclaW: UIButton!
    @IBOutlet weak var teclaE: UIButton!
    @IBOutlet weak var teclaR: UIButton!
    @IBOutlet weak var teclaT: UIButton!
    @IBOutlet weak var teclaY: UIButton!
    @IBOutlet weak var teclaU: UIButton!
    @IBOutlet weak var teclaI: UIButton!
    @IBOutlet weak var teclaO: UIButton!
    @IBOutlet weak var teclaP: UIButton!
    @IBOutlet weak var teclaA: UIButton!
    @IBOutlet weak var teclaS: UIButton!
    @IBOutlet weak var teclaD: UIButton!
    @IBOutlet weak var teclaF: UIButton!
    @IBOutlet weak var teclaG: UIButton!
    @IBOutlet weak var teclaH: UIButton!
    @IBOutlet weak var teclaJ: UIButton!
    @IBOutlet weak var teclaK: UIButton!
    @IBOutlet weak var teclaL: UIButton!
    @IBOutlet weak var teclaZ: UIButton!
    @IBOutlet weak var teclaX: UIButton!
    @IBOutlet weak var teclaC: UIButton!
    @IBOutlet weak var teclaV: UIButton!
    @IBOutlet weak var teclaB: UIButton!
    @IBOutlet weak var teclaN: UIButton!
    @IBOutlet weak var teclaM: UIButton!
    @IBOutlet weak var teclaBorrar: UIButton!
    
    @IBOutlet weak var botonSubirRespuesta: UIButton!
    
    @IBOutlet weak var puntaje: UILabel!
    
    
    @IBOutlet weak var vida2: UIImageView!
    @IBOutlet weak var vida1: UIImageView!
    @IBOutlet weak var vida3: UIImageView!
    
    // Variables del juego
    var bancoPalabras: [String] = [
        "GATOS", "PERRO", "LIBRO", "PLAYA", "MONTE",
        "CIELO", "TARDE", "NOCHE", "CAMPO", "LUGAR",
        "MUNDO", "VISTA", "SALTO", "VERDE", "ROSAS",
        "MARIA", "DOLOR", "SILLA", "CURSO", "CALLE",
        "PUNTO", "LETRA", "SOLAR", "MANGO", "GLOBO",
        "FUEGO", "PIANO", "BRAZO", "FALDA", "TIGRE"
    ]
    
    var palabraActual: String = ""
    var intentoActual: Int = 0
    var posicionLetra: Int = 0
    var vidasRestantes: Int = 3
    var puntajeActual: Int = 0
    var tiempoInicio: Date?
    var palabraUsuario: String = ""
    var debeReiniciar: Bool = false
    
    var camposBotones: [[UIButton]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicializar el arreglo de botones por fila
        camposBotones = [
            [campo0, campo1, campo2, campo3, campo4],
            [campo5, campo6, campo7, campo8, campo9],
            [campo10, campo11, campo12, campo13, campo14],
            [campo15, campo16, campo17, campo18, campo19]
        ]
        
        configurarJuego()
    }
    
    // MARK: - Configuración del juego
    func configurarJuego() {
        // Seleccionar palabra aleatoria
        palabraActual = bancoPalabras.randomElement() ?? "GATOS"
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        puntajeActual = 0
        vidasRestantes = 3
        
        // Mostrar todas las vidas
        vida1.isHidden = false
        vida2.isHidden = false
        vida3.isHidden = false
        
        // Actualizar puntaje
        puntaje.text = "0"
        
        // Limpiar todos los campos
        limpiarCampos()
        reiniciarTeclado()
    }
    
    func limpiarCampos() {
        for fila in camposBotones {
            for boton in fila {
                boton.setTitle("", for: .normal)
                boton.backgroundColor = UIColor.white
            }
        }
        palabraUsuario = ""
        posicionLetra = 0
    }
    
    func reiniciarTeclado() {
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        for tecla in teclas {
            tecla?.backgroundColor = UIColor.systemGray6
            tecla?.isEnabled = true
        }
    }
    
    // MARK: - Acciones del teclado
    @IBAction func teclaPresionada(_ sender: UIButton) {
        guard intentoActual < 4, posicionLetra < 5 else { return }
        
        let letra = sender.currentTitle ?? ""
        camposBotones[intentoActual][posicionLetra].setTitle(letra, for: .normal)
        palabraUsuario += letra
        posicionLetra += 1
    }
    
    @IBAction func borrarLetra(_ sender: UIButton) {
        guard posicionLetra > 0 else { return }
        
        posicionLetra -= 1
        camposBotones[intentoActual][posicionLetra].setTitle("", for: .normal)
        palabraUsuario.removeLast()
    }
    
    @IBAction func subirRespuesta(_ sender: UIButton) {
        // Validar que se hayan ingresado 5 letras
        guard palabraUsuario.count == 5 else {
            mostrarAlerta(titulo: "Incompleto", mensaje: "Debes ingresar 5 letras")
            return
        }
        
        verificarPalabra()
    }
    
    // MARK: - Verificación de palabra
    func verificarPalabra() {
        var aciertos = 0
        var palabraActualArray = Array(palabraActual)
        var palabraUsuarioArray = Array(palabraUsuario)
        var letrasUsadas = [Bool](repeating: false, count: 5)
        
        // Primera pasada: verificar letras en posición correcta (verde)
        for i in 0..<5 {
            if palabraUsuarioArray[i] == palabraActualArray[i] {
                camposBotones[intentoActual][i].backgroundColor = UIColor(hex: "#C6FFB6")
                aciertos += 1
                letrasUsadas[i] = true
                cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor(hex: "#C6FFB6"))
            }
        }
        
        // Segunda pasada: verificar letras en posición incorrecta (amarillo)
        for i in 0..<5 {
            if palabraUsuarioArray[i] != palabraActualArray[i] {
                var encontrada = false
                for j in 0..<5 where !letrasUsadas[j] {
                    if palabraUsuarioArray[i] == palabraActualArray[j] {
                        camposBotones[intentoActual][i].backgroundColor = UIColor(hex: "#FFEEB6")
                        letrasUsadas[j] = true
                        encontrada = true
                        cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor(hex: "#FFEEB6"))
                        break
                    }
                }
                
                // Si no se encontró, pintar de gris y deshabilitar
                if !encontrada {
                    camposBotones[intentoActual][i].backgroundColor = UIColor(hex: "#C4C4C4")
                    cambiarColorTecla(letra: String(palabraUsuarioArray[i]), color: UIColor(hex: "#C4C4C4"))
                }
            }
        }
        
        // Verificar si ganó
        if aciertos == 5 {
            juegoGanado()
        } else {
            intentoActual += 1
            posicionLetra = 0
            palabraUsuario = ""
            
            // Verificar si perdió todos los intentos
            if intentoActual >= 4 {
                perderVida()
            }
        }
    }
    
    func cambiarColorTecla(letra: String, color: UIColor) {
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        let colorVerde = UIColor(hex: "#C6FFB6")
        let colorAmarillo = UIColor(hex: "#FFEEB6")
        let colorGris = UIColor(hex: "#C4C4C4")
        
        for tecla in teclas {
            if tecla?.currentTitle == letra {
                // Solo cambiar a verde si está verde, mantener verde sobre amarillo
                if color == colorVerde {
                    tecla?.backgroundColor = color
                } else if tecla?.backgroundColor != colorVerde {
                    tecla?.backgroundColor = color
                    // Deshabilitar la tecla si es gris
                    if color == colorGris {
                        tecla?.isEnabled = false
                    }
                }
                break
            }
        }
    }
    
    // MARK: - Lógica de juego
    func juegoGanado() {
        calcularPuntaje()
        
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        let mensaje = "¡Felicidades! Adivinaste en \(intentoActual + 1) intentos.\nTiempo: \(tiempoTranscurrido)s\nPuntaje: \(puntajeActual)"
        
        mostrarAlerta(titulo: "¡Victoria!", mensaje: mensaje) {
            self.irAPantallaDeNombre()
        }
    }
    
    func perderVida() {
        vidasRestantes -= 1
        
        switch vidasRestantes {
        case 2:
            vida1.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe quedan 2 vidas") {
                self.reiniciarIntento()
            }
        case 1:
            vida2.isHidden = true
            mostrarAlerta(titulo: "Palabra incorrecta", mensaje: "La palabra era: \(palabraActual)\nTe queda 1 vida") {
                self.reiniciarIntento()
            }
        case 0:
            vida3.isHidden = true
            mostrarAlerta(titulo: "Game Over", mensaje: "Perdiste todas tus vidas.\nPuntaje final: \(puntajeActual)") {
                self.irAPantallaDeNombre()
            }
        default:
            break
        }
    }
    
    func reiniciarIntento() {
        // Cambiar a una nueva palabra
        let palabraAnterior = palabraActual
        repeat {
            palabraActual = bancoPalabras.randomElement() ?? "GATOS"
        } while palabraActual == palabraAnterior
        
        intentoActual = 0
        posicionLetra = 0
        palabraUsuario = ""
        tiempoInicio = Date()
        
        // Limpiar campos y reiniciar teclado
        limpiarCampos()
        reiniciarTeclado()
    }
    
    func calcularPuntaje() {
        let tiempoTranscurrido = Int(Date().timeIntervalSince(tiempoInicio ?? Date()))
        
        // Puntos base por intentos (menos intentos = más puntos)
        let puntosPorIntentos = (4 - intentoActual) * 50
        
        // Puntos por tiempo (más rápido = más puntos)
        let puntosPorTiempo = max(0, 100 - tiempoTranscurrido)
        
        let puntosGanados = puntosPorIntentos + puntosPorTiempo
        puntajeActual += puntosGanados
        
        puntaje.text = "\(puntajeActual)"
    }
    
    func irAPantallaDeNombre() {
        debeReiniciar = true
        performSegue(withIdentifier: "NombreFlechaClassic", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NombreFlechaClassic" {
            if let destino = segue.destination as? NombreViewController {
                destino.puntajeFinal = puntajeActual
            }
        }
    }
    
    // MARK: - Alertas
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
        
        // Si viene de guardar el nombre, reiniciar el juego
        if debeReiniciar {
            configurarJuego()
            debeReiniciar = false
        }
        
        // Conectar acciones de las teclas
        let teclas = [
            teclaQ, teclaW, teclaE, teclaR, teclaT,
            teclaY, teclaU, teclaI, teclaO, teclaP,
            teclaA, teclaS, teclaD, teclaF, teclaG,
            teclaH, teclaJ, teclaK, teclaL, teclaZ,
            teclaX, teclaC, teclaV, teclaB, teclaN, teclaM
        ]
        
        for tecla in teclas {
            tecla?.addTarget(self, action: #selector(teclaPresionada(_:)), for: .touchUpInside)
        }
        
        teclaBorrar.addTarget(self, action: #selector(borrarLetra(_:)), for: .touchUpInside)
        botonSubirRespuesta.addTarget(self, action: #selector(subirRespuesta(_:)), for: .touchUpInside)
    }

}

// MARK: - Extensión UIColor para colores hex
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
