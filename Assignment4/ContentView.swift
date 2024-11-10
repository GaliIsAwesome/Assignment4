//
//  ContentView.swift
//  Assignment4
//
//  Created by Magali Gutierrez on 11/9/24.
//

import SwiftUI


//declaring struct for president
struct President: Identifiable, Decodable {
    var id: Int { number }
    let name: String
    let number: Int
    let startDate: String
    let endDate: String
    let nickname: String
    let politicalParty: String
    let image: String
}

struct ContentView: View {

    //array for the list
    @State private var presidents: [President] = []
    
    var body: some View {
        
       // declared variable name
        NavigationView{
            List(sortedPresidents){ president in
                NavigationLink(destination: PresidentDetailView(president: president)){
            
                HStack{
                    VStack(alignment: .leading){
                        Text(president.name)
                            .font(.subheadline)
                             //   .foregroundColor(.gray))
                        Text("Number: \(formattedOrdinal(president.number))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }//end of vstack
                }//end of Hstack
            }//end of list
        }//end of navigation
        
        .navigationTitle("U.S. Presidents")
        .onAppear{
            loadPresidentsData()
        }
   
    }//end of body view
}//end of view


private func loadPresidentsData(){
    if let loadedPresidents = loadPresidents(){
        self.presidents = loadedPresidents
    }
}


var sortedPresidents: [President] {
        presidents.sorted { $0.number < $1.number }
    }

func formattedOrdinal(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
}

func loadPresidents() -> [President]? {
    guard let url = Bundle.main.url(forResource: "presidents", withExtension: "plist") else {
        print("Failed to locate the presidents.plist file.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = PropertyListDecoder()
        let presidents = try decoder.decode([President].self, from: data)
        return presidents
    } catch {
        print("Failed to load or decode the plist data: \(error)")
        return nil
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



#Preview {
    ContentView()
}
