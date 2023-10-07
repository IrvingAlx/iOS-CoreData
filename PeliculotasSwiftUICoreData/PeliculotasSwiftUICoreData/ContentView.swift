//
//  ContentView.swift
//  PeliculotasSwiftUICoreData
//
//  Created by Irving Alejandro Vega Lagunas on 05/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let coreDataManager = CoreDataManager()

    @State private var pelicula: [Peliculotas] = [Peliculotas]()
    @State private var titulo : String = ""
    @State private var director : String = ""
    @State private var fecha = Date()
    @State private var duracion = 0.0
    @State private var genero = 0
    @State private var clasificacion = 0

    let generoPicker = ["Drama","Comedia","Ciencia Ficción","Terrror","Suspenso","Infantil"]
    let clasificacionPicker = ["A","AA","B","B15","C"]
    
    private func mostrar(){
        pelicula = coreDataManager.leerPelis()
    }
    
    private var dateFormatter: DateFormatter{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
    }
    
    func formatDate(date: Date) -> String{
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
        
    }
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "movieclapper.fill")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                Text("Mis peliculas Favoritas")
                    .font(.title3)
                    .bold()
                Image(systemName: "popcorn.fill")
                    .imageScale(.large)
                    .foregroundStyle(.yellow)
            }
            .padding()
            TextField("Titulo,", text:$titulo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            TextField("Director", text: $director)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Picker(selection: $genero, label: Text("Seleciona una opcion")){
                ForEach(generoPicker.indices, id: \.self){
                    Text(self.generoPicker[$0]).tag($0)
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())

            Picker(selection: $clasificacion, label: Text("Seleciona una opcion")){
                ForEach(clasificacionPicker.indices, id: \.self){
                    Text(self.clasificacionPicker[$0]).tag($0)
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())

            Text("Duracion: \(String(format: "%.0f", duracion)) minutos")
                .padding(.bottom,20)
            Slider(value: $duracion, in : 0...300, step: 1)
                .padding([.leading, .trailing],20)
                
            DatePicker("Selecciona una fecha",selection: $fecha,displayedComponents: .date)
                .datePickerStyle(CompactDatePickerStyle())
                .padding()
                
            Button("Guardar"){
                if (!titulo.isEmpty && !director.isEmpty){
                    coreDataManager.guardarPeli(titulo: titulo, director: director, fecha: fecha, genero: generoPicker[genero], duracion: duracion, clasificacion: clasificacionPicker[clasificacion])
                    mostrar()
                }
                titulo=""
                director=""
            }
            .padding()

            List{
                ForEach (pelicula, id: \.self){
                    pelicula in
                    Text(pelicula.titulo ?? "")
                    Text("\t" + (pelicula.director ?? ""))
                    Text("\t" + (pelicula.genero ?? ""))
                    Text("\t" + (pelicula.clasificacion ?? ""))
                    Text("\t \(String(format: "%.0f", pelicula.duracion)) minutos")
                    Text("\t \(dateFormatter.string(from: pelicula.fecha ?? Date()))")
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
