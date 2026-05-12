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
            let isActuallyConnected = path.status == .satisfied
                && (path.usesInterfaceType(.wifi)
                || path.usesInterfaceType(.cellular)
                || path.usesInterfaceType(.wiredEthernet))
            
            self.isConnected = isActuallyConnected
            self.connectionChanged?(isActuallyConnected)
        }
        monitor.start(queue: queue)
    }
}
