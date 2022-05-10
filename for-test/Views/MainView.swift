import SwiftUI

struct MainView: View {
    let url = URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!
    
    var body: some View {
        AsyncImage(
            url: url,
            placeholder: { Text("Loading ...") }
        ).aspectRatio(contentMode: .fit)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
