import SwiftUI

struct ResultRow: View {
    
    var result = ""
    var date = ""
    
    var body: some View {
        HStack{
            Text(date)
            Text(result)
        }
    }
}

struct ResultRow_Previews: PreviewProvider {
    static var previews: some View {
        ResultRow(result: "朝チョコした", date: "1/1")
    }
}
