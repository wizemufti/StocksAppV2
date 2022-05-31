
import SwiftUI

struct ContentView: View {
    
    @ObservedObject var stockManager = MockQuoteManager()
    @ObservedObject var newsManager = NewsDownloadManager()
    
    @State private var stocks = UserDefaultsManager.shared.savedSymbols
    @State private var searchTerm = ""
    @State private var newsOpen = false
    @State private var oldStocks = [String]()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.black
            
            VStack(alignment: .leading) {
                if newsOpen {
                    withAnimation {
                        MiniQuoteView(stockQuotes: stockManager)
                            .foregroundColor(.white)
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 100 : 0)
                            .transition(.move(edge: .top))
                    }
                } else {
                    withAnimation {
                        HeaderView(stocks: $stocks)
                            .padding(.top, 50)
                            .frame(height: newsOpen ? 0 : 100)
                            .transition(.move(edge: .top))
                    }
                }
                
                List {
                    Group {
                        SearchTextView(searchTerm: $searchTerm)
                        
                        ForEach(getQuotes()) { quote in
                            QuoteCell(quote: quote)
                        }
                    }.listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets())
                }.onAppear {
                    fetchData(for: stocks)
                    oldStocks = stocks
                }.onChange(of: stocks, perform: { value in
                    fetchData(for: stocks.difference(from: oldStocks))
                    oldStocks = stocks
                })
                .listStyle(PlainListStyle())
                .foregroundColor(.white)
            }.padding(.horizontal, 32)
            .padding(.bottom, UIScreen.main.bounds.height * 0.21)
            
            NewsSheetView(newsOpen: $newsOpen, newsManager: newsManager)
            
        }.edgesIgnoringSafeArea(.all)
    }
    
    private func getQuotes() -> [Quote] {
        return searchTerm.isEmpty ? stockManager.quotes : stockManager.quotes.filter { $0.symbol.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private func fetchData(for symbols: [String]) {
        stockManager.download(stocks: symbols) { _ in
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
