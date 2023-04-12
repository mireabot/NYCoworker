import Network
import SwiftUI

public class NetworkMonitor: ObservableObject {
    private let networkMonitor = NWPathMonitor()
    private let workQueue = DispatchQueue(label: "Monitor")
    public var isConnected = false
    
    public init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run(body: {
                    self.objectWillChange.send()
                })
            }
        }
        networkMonitor.start(queue: workQueue)
    }
}
