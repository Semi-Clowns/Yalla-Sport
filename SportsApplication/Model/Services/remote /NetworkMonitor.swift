//
//  NetworkMonitor.swift
//  SportsApplication
//
//  Created by Mahmoud  Raafat  on 09/05/2026.
//


import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()
    
    var isConnected: Bool = false
    var connectionChanged: ((Bool) -> Void)?

    private init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            self.connectionChanged?(self.isConnected)
        }
        monitor.start(queue: queue)
    }
}
