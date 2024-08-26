import SwiftUI

struct ContentView: View {
    var body: some View {
        WebViewControllerWrapper()
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
