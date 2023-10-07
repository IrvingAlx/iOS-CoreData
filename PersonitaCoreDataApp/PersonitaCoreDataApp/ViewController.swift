//
//  ViewController.swift
//  PersonitaCoreDataApp
//
//  Created by Irving Alejandro Vega Lagunas on 04/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textVista: UITextView!
    @IBOutlet weak var textNombre: UITextField!
    
    let coreDataManager = CoreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mostrar()
    }

    @IBAction func Guardar(_ sender: Any) {
        let nombre: String = textNombre.text ?? ""
        
        if  (!nombre.isEmpty){
            coreDataManager.guardarPersonita(nombre: nombre)
        }else{
            print("No se puede almacenar un nombre vacio")
        }
        textNombre.text = ""
        mostrar()
    }
    
    func mostrar(){
        
        let personitas : [Personita] = coreDataManager.leerPersonitas()
        
        textVista.text = ""
        for personita in personitas {
            textVista.text.append((personita.nombre ?? "") + "\n")
        }
    
    }
    
}
