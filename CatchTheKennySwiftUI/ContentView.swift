
import SwiftUI

struct ContentView: View {
    
    @State var score = 0
    @State var timeleft = 10.0
    @State var chosenX = 200
    @State var chosenY = 280
    @State var showAlert = false
    
    let (x1,y1) = (200,270)
    let (x2,y2) = (80,270)
    let (x3,y3) = (330,270)
    let (x4,y4) = (330,450)
    let (x5,y5) = (200,450)
    let (x6,y6) = (80,450)
    let (x7,y7) = (330,100)
    let (x8,y8) = (200,100)
    let (x9,y9) = (80,100)
    
    
    var counterTimer : Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
           
            if self.timeleft >= 0.5 {
                
               self.timeleft -= 1
                
                
            }
            
            else if self.timeleft == 0.0 {
                
                self.showAlert = true
                
            }
            
        }
        
        
        
    }
    
    
    
    var timer : Timer {
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            let tupleArray = [(self.x1,self.y1),(self.x2,self.y2),(self.x3,self.y3),(self.x4,self.y4),(self.x5,self.y5),(self.x6,self.y6),(self.x7,self.y7),(self.x8,self.y8),(self.x9,self.y9)]
            
            var previousNumber : Int?
            
            func randomNumberGen () -> Int {
             
                var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                
                    while previousNumber == randomNumber {
                         randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                    
                    
                }
                previousNumber = randomNumber
                
                return randomNumber
                
                
                
            }
            
            self.chosenX = tupleArray[randomNumberGen()].0
            self.chosenY = tupleArray[randomNumberGen()].1
            
        }
        
    }
    
    
    var body: some View {
        
        VStack{
            Spacer().frame(height: 130)
        Text("Catch The Kenny")
            .font(.largeTitle)
            HStack{
         Text("TimeLeft : ")
            .font(.title)
                Text(String(self.timeleft))
                    .font(.title)
                
            }
            HStack{
            Text("Score : ")
                .font(.title)
            Text(String(self.score))
                .font(.title)
            }
            Spacer()
        
        Image("kenny")
        .resizable()
        .frame(width: 100, height: 130)
            .position(x:CGFloat(self.chosenX) , y:CGFloat(self.chosenY))
            .gesture(TapGesture(count: 1).onEnded({ () in
                
                self.score += 1
                
                
            }))
            .onAppear {
                
                _ = self.timer
                _ = self.counterTimer
            }
         
        Spacer()
        
        }.alert(isPresented: $showAlert) {
            
            
            return Alert(title: Text("TİME OVER!"), message: Text("WANT TO PLAY AGAİN ?"), primaryButton: Alert.Button.default(Text("OK"), action: {
                self.score = 0
                self.timeleft = 10.0
                
                
            }), secondaryButton: Alert.Button.cancel())
            
            
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
