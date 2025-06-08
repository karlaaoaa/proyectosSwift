//
//  saveData.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import Foundation

struct InputData: Codable {
    var HighBP: Bool?
    var HighChol: Bool?
    var GenHlth: Int?
    var Sex: Int?
    var Diabetes: Bool?
    var Age: Int?
    var BMI: Int?
    
    func isComplete() -> Bool {
        print("🔍 [InputData] Verificando si los datos están completos...")
        
        let fields = [
            ("HighBP", HighBP != nil),
            ("HighChol", HighChol != nil),
            ("GenHlth", GenHlth != nil),
            ("Sex", Sex != nil),
            ("Diabetes", Diabetes != nil),
            ("Age", Age != nil),
            ("BMI", BMI != nil)
        ]
        
        var missingFields: [String] = []
        var completeFields: [String] = []
        
        for (fieldName, isPresent) in fields {
            if isPresent {
                completeFields.append(fieldName)
            } else {
                missingFields.append(fieldName)
            }
        }
        
        print("✅ [InputData] Campos completos (\(completeFields.count)/7): \(completeFields.joined(separator: ", "))")
        
        if !missingFields.isEmpty {
            print("❌ [InputData] Campos faltantes (\(missingFields.count)/7): \(missingFields.joined(separator: ", "))")
        }
        
        let isComplete = HighBP != nil &&
                        HighChol != nil &&
                        GenHlth != nil &&
                        Sex != nil &&
                        Diabetes != nil &&
                        Age != nil &&
                        BMI != nil
        
        print("📊 [InputData] Resultado isComplete: \(isComplete)")
        return isComplete
    }
    
    func toDictionary() -> [String: Any] {
        print("🔄 [InputData] Convirtiendo a diccionario...")
        
        var dict: [String: Any] = [:]
        
        // Log detallado de cada campo
        if let HighBP = HighBP {
            dict["HighBP"] = HighBP
            print("✅ [InputData] HighBP: \(HighBP)")
        } else {
            print("❌ [InputData] HighBP: nil (faltante)")
        }
        
        if let HighChol = HighChol {
            dict["HighChol"] = HighChol
            print("✅ [InputData] HighChol: \(HighChol)")
        } else {
            print("❌ [InputData] HighChol: nil (faltante)")
        }
        
        if let GenHlth = GenHlth {
            dict["GenHlth"] = GenHlth
            print("✅ [InputData] GenHlth: \(GenHlth)")
        } else {
            print("❌ [InputData] GenHlth: nil (faltante)")
        }
        
        if let Sex = Sex {
            dict["Sex"] = Sex
            print("✅ [InputData] Sex: \(Sex)")
        } else {
            print("❌ [InputData] Sex: nil (faltante)")
        }
        
        if let Diabetes = Diabetes {
            dict["Diabetes"] = Diabetes
            print("✅ [InputData] Diabetes: \(Diabetes)")
        } else {
            print("❌ [InputData] Diabetes: nil (faltante)")
        }
        
        if let Age = Age {
            dict["Age"] = Age
            print("✅ [InputData] Age: \(Age)")
        } else {
            print("❌ [InputData] Age: nil (faltante)")
        }
        
        if let BMI = BMI {
            dict["BMI"] = BMI
            print("✅ [InputData] BMI: \(BMI)")
        } else {
            print("❌ [InputData] BMI: nil (faltante)")
        }
        
        print("📋 [InputData] Diccionario final: \(dict)")
        print("📊 [InputData] Total de campos en diccionario: \(dict.count)/7")
        
        return dict
    }
    
    // Función adicional para debugging completo
    func debugCurrentState() {
        print("🐛 [DEBUG] Estado actual completo de InputData:")
        print("🐛 [DEBUG] HighBP: \(HighBP?.description ?? "nil")")
        print("🐛 [DEBUG] HighChol: \(HighChol?.description ?? "nil")")
        print("🐛 [DEBUG] GenHlth: \(GenHlth?.description ?? "nil")")
        print("🐛 [DEBUG] Sex: \(Sex?.description ?? "nil")")
        print("🐛 [DEBUG] Diabetes: \(Diabetes?.description ?? "nil")")
        print("🐛 [DEBUG] Age: \(Age?.description ?? "nil")")
        print("🐛 [DEBUG] BMI: \(BMI?.description ?? "nil")")
        print("🐛 [DEBUG] --------------------------------")
    }
    
    // Función para validar tipos de datos específicos
    func validateDataTypes() -> Bool {
        print("🔍 [Validation] Validando tipos de datos...")
        
        var isValid = true
        
        // Validar Age (debe ser positivo y razonable)
        if let age = Age {
            if age < 0 || age > 120 {
                print("⚠️ [Validation] Age fuera de rango válido: \(age)")
                isValid = false
            } else {
                print("✅ [Validation] Age válido: \(age)")
            }
        }
        
        // Validar BMI (debe ser positivo y razonable)
        if let bmi = BMI {
            if bmi < 10 || bmi > 70 {
                print("⚠️ [Validation] BMI fuera de rango válido: \(bmi)")
                isValid = false
            } else {
                print("✅ [Validation] BMI válido: \(bmi)")
            }
        }
        
        // Validar GenHlth (asumiendo que debe estar entre 1-5)
        if let genHlth = GenHlth {
            if genHlth < 1 || genHlth > 5 {
                print("⚠️ [Validation] GenHlth fuera de rango válido: \(genHlth)")
                isValid = false
            } else {
                print("✅ [Validation] GenHlth válido: \(genHlth)")
            }
        }
        
        // Validar Sex (asumiendo 0 o 1)
        if let sex = Sex {
            if sex != 0 && sex != 1 {
                print("⚠️ [Validation] Sex fuera de rango válido: \(sex)")
                isValid = false
            } else {
                print("✅ [Validation] Sex válido: \(sex)")
            }
        }
        
        print("📊 [Validation] Resultado de validación: \(isValid ? "✅ VÁLIDO" : "❌ INVÁLIDO")")
        return isValid
    }
}

struct MLResponse: Codable {
    let cluster: Int
}
