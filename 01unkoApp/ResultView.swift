import SwiftUI

struct ResultView: View {
    
    @ObservedObject var resultVM = ResultViewModel()
    
    var body: some View {
        List(resultVM.results, id: \.id) { i in
            ResultRow(result: i.result, date: i.date)
        }.navigationBarTitle("うんこ結果", displayMode: .inline)

    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
