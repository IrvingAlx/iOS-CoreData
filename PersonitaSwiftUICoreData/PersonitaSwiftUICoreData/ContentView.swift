//
//  ContentView.swift
//  PersonitaSwiftUICoreData
//
//  Created by Irving Alejandro Vega Lagunas on 05/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    let coreDataManager = CoreDataManager()

    @State private var personas: [Personota] = [Personota]()
    @State private var nombre : String = ""
    @State private var apellidoPaterno : String = ""
    @State private var apellidoMaterno : String = ""
    @State private var fechaNacimiento = Date()
    @State private var sexo : String = ""
    @State private var sexoSeleccionado = 0
    
    let opciones = ["Hombre","Mujer"]
    
    private func mostrar(){
        personas = coreDataManager.leerPersona()
    }
    
    private var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }
    
    var body: some View {
        VStack {
            HStack{
                Text("Personitas App")
                    .font(.title3)
                    .bold()
                    .padding()
            }
            
            TextField("Nombre: ", text:$nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido Paterno: ", text: $apellidoPaterno)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Apellido Materno: ", text: $apellidoMaterno)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker(selection: $sexoSeleccionado, label: Text("Seleciona una opcion")){
                ForEach(opciones.indices, id: \.self){
                    Text(self.opciones[$0]).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            DatePicker("Selecciona una fecha",selection: $fechaNacimiento,displayedComponents: .date)
                .datePickerStyle(WheelDatePickerStyle())
                .padding()
            
            Button("Guardar"){
                if (!nombre.isEmpty && !apellidoPaterno.isEmpty){
                    coreDataManager.guardarPersona(nombre: nombre, apellidoP: apellidoPaterno, apellidoM: apellidoMaterno, fechaN: fechaNacimiento, sexo: opciones[sexoSeleccionado])
                    mostrar()
                }
                nombre=""
                apellidoPaterno=""
                apellidoMaterno=""
            }
            List {
                ForEach(personas, id: \.self) { persona in
                    Text(persona.nombre ?? "")
                    Text("\t" + (persona.apellidoP ?? ""))
                    Text("\t" + (persona.apellidoM ?? ""))
                    Text("\t" + (persona.sexo ?? ""))
                    Text("\t \(dateFormatter.string(from: persona.fechaN ?? Date()))")
                }
            }
            
        }
        .padding()
        .onAppear(perform: {
            mostrar()
        })
    }
    
}

#Preview {
    ContentView()
}
