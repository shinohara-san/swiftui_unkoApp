import Foundation
import Firebase

//Firebaseのみ読み書きはここ

struct resultDataType: Identifiable {
    var id: String
    var result: String
    var date: String
}

class ResultViewModel: ObservableObject {
    @Published var results = [resultDataType]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("results").order(by: "date", descending: true).addSnapshotListener { (snap, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let snap = snap {
                for i in snap.documentChanges{
                    if i.type == .added {
                        let id = i.document.documentID
                        let result = i.document.get("result") as! String
                        let timestamp: Timestamp = i.document.get("date") as! Timestamp
                        let dateValue = timestamp.dateValue()
                        let f = DateFormatter()
                           f.locale = Locale(identifier: "ja_JP")
                           f.dateStyle = .long
                           f.timeStyle = .medium
                           let date = f.string(from: dateValue)
                        self.results.append(resultDataType(id: id, result: result, date: date))
//                        self.results.append(resultDataType(id: id, result: result))
                    }
                }
            }
        }
    }
    
    func addMessage(result: String){
        let data = [
            "result":result,
            "date": Date()
            ] as [String : Any]
        
        let db = Firestore.firestore()
               db.collection("results").addDocument(data: data){ error in
                   if let error = error {
                       print(error.localizedDescription)
                       return
                   }
                   print("success")
               }
        
    }
}
