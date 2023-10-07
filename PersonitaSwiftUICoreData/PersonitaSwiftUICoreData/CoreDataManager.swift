//
//  CoreDataManager.swift
//  PersonitaSwiftUICoreData
//
//  Created by Irving Alejandro Vega Lagunas on 05/10/23.
//

import Foundation
import CoreData

class CoreDataManager{
    let contenedor : NSPersistentContainer
    
    init() {
        contenedor = NSPersistentContainer(name: "ModeloPersonota")
        
        contenedor.loadPersistentStores{
            (descripcion,error) in
            
            if let error = error{
                fatalError("Se rompio \(error.localizedDescription)")
            }
        }
    }
    
    func guardarPersona(nombre: String, apellidoP: String, apellidoM: String, fechaN: Date, sexo: String){
        
        let perso = Personota(context: contenedor.viewContext)
        
        perso.nombre = nombre
        perso.apellidoP = apellidoP
        perso.apellidoM = apellidoM
        perso.fechaN = fechaN
        perso.sexo = sexo
        
        do{
            try contenedor.viewContext.save()
            print("Pelicula almacenada exitosamente")
        }catch{
            print("Error al guardar la peli \(error.localizedDescription)")
        }
        
    }
    
    func leerPersona()->[Personota]{
        let lector : NSFetchRequest<Personota> = Personota.fetchRequest()
        
        do{
            return try
            contenedor.viewContext.fetch(lector)
        }catch{
            return []
        }
        
    }
}
