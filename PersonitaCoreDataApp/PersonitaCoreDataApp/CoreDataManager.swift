//
//  CoreDataManager.swift
//  PersonitaCoreDataApp
//
//  Created by Irving Alejandro Vega Lagunas on 04/10/23.
//

import Foundation
import CoreData

class CoreDataManager{
    
    let contenedor: NSPersistentContainer
    
    init(){
        contenedor = NSPersistentContainer(name: "ModeloPersonita")
        contenedor.loadPersistentStores{
            (descripcion, error) in
            
            if let error = error{
                fatalError("No se pudo cargar la base \(error.localizedDescription)")
            }
        }
    }
    
    func guardarPersonita(nombre: String){
        let personita = Personita (context: contenedor.viewContext)
        
        personita.nombre = nombre
        
        do{
            try contenedor.viewContext.save()
                print("Personita guardada")
        }catch{
            print("No se pudo guardar personita")
        }
    }
    
    func leerPersonitas() -> [Personita]{

        let lector : NSFetchRequest<Personita> = Personita.fetchRequest()
        
        do{
            return try contenedor.viewContext.fetch(lector)
        }catch{
            return []
        }
    }
    
}
