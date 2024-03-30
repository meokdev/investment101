import SwiftUI
import WebKit

struct ContentView: View {
    @State private var unit: Int = 1
    @State private var type: String = "Article" // Default to "Article"
    @State private var result: String = "Response will appear here..."

    var body: some View {
        VStack {
            Spacer()
            Picker("Type", selection: $type) {
                Text("Article").tag("Article")
                Text("Question").tag("Question")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: type) { _ in
                fetchData()
            }
            Picker("Unit", selection: $unit) {
                ForEach(1...5, id: \.self) { number in
                    Text("\(number)").tag(number)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .onChange(of: unit) { _ in
                fetchData()
            }

            

            // Conditional rendering based on the type
            if type == "Article" {
                DocWebView(html: result)
                    .frame(minHeight: 300)
            } else {
                ScrollView {
                    Text(result)
                        .padding()
                }
            }

            Spacer()
        }
        .onAppear(perform: fetchData)
    }

    func fetchData() {
        guard let url = URL(string: "http://127.0.0.1:5000/get_data?type=\(type.lowercased())&unit=\(unit)") else {
            DispatchQueue.main.async {
                self.result = "Invalid URL"
            }
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(APIResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.result = decodedResponse.content ?? "No content"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.result = "Failed to decode response"
                    }
                }
            } else if error != nil {
                DispatchQueue.main.async {
                    self.result = "Network error"
                }
            }
        }.resume()
    }
}

struct DocWebView: UIViewRepresentable {
    var html: String
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(html, baseURL: nil)
    }
}

struct APIResponse: Codable {
    var status: String
    var content: String?
}

struct doc_view: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
