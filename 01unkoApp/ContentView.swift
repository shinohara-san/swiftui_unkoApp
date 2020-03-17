import SwiftUI

struct ContentView: View {
    
    @State var isError = false
    @State var showModal = false
    @State var selectedResult = 0
    let results = ["-----","朝両方した", "朝チョコのみ", "朝こつのみ", "朝両方なし", "朝行けてない", "夕両方した", "夕チョコのみ", "夕こつのみ", "夕両方なし", "夕行けてない"]
    
    @ObservedObject var resultVM = ResultViewModel()
    
    var body: some View {
        
        NavigationView {
            ZStack { Color.gray.edgesIgnoringSafeArea(.all)
                VStack {
//                    NavigationLink(destination: ResultView()) {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        HStack {
                            Text("うんこ情報")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
                            Image(systemName: "tortoise").foregroundColor(.white).font(.largeTitle)
                        }.sheet(isPresented: $showModal) {
                            ResultView()
                        }
                    }
                       
//                    }
//                    .padding(.vertical)
                    Image("IMG_8878").resizable().aspectRatio(contentMode: .fit).cornerRadius(15).frame(width: 400.0)
                    
                    Text(selectedResult > 0 ? results[selectedResult] + "?" : "結果を選んでください").foregroundColor(.white).font(.title).frame(width: 300.0, height: 60.0)
                    Picker(selection: $selectedResult, label: Text("結果")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding(.leading)) {
                            ForEach(0..<results.count){ index in
                                Text(self.results[index]).foregroundColor(.white).tag(index)
                            }
                    }
                    .frame(height: 150.0)
                    Button(action: {
                        if self.selectedResult > 0 {
                            self.isError = true
                        } else {
                            return
                        }
                        
                        self.resultVM.addMessage(result: self.results[self.selectedResult])
                        
                    }) {
                        HStack{
                            Text("送信")
                            Image(systemName: "paperplane")
                            
                        }.font(.title)
                            .padding(.horizontal, 100)
                            .padding([.top, .bottom], 9)
                            .background(Color.pink)
                            .foregroundColor(Color.white).cornerRadius(15)
                        
                    }.alert(isPresented: $isError, content: {
                        Alert(title: Text("完了"), message:
                            Text(results[selectedResult]), dismissButton: .default(Text("OK"), action: {}))
                    })
               
                }.padding(.bottom, 50)
                
            }
        }.edgesIgnoringSafeArea(.top)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
