import Foundation

protocol Observer: AnyObject {
    func observe(event: String, object: Any?, notificationCentre: NotificationCentre)
}

class NotificationCentre {
    
    static let shared = NotificationCentre()
    
    private let syncQueue = DispatchQueue(label: "notificationCentre", attributes: .concurrent)
    private var subscribers: [String: NSHashTable<AnyObject>] = [:]
    
    private init() {}
    
    func add(_ observer: Observer, forEvent event: String) {
        syncQueue.async(flags: .barrier) {
            self.subscribers[event, default: NSHashTable.weakObjects()].add(observer)
        }
    }
    
    func remove(_ observer: Observer, forEvent event: String) {
        syncQueue.async(flags: [.barrier]) {
            self.subscribers[event]?.remove(observer)
        }
    }
    
    func post(event: String, object: Any?) {
        let subscribers = syncQueue.sync {
            self.subscribers[event]?.allObjects as? [Observer]
        }
        
        guard let subscribers = subscribers else { return }
        subscribers.forEach { $0.observe(event: event, object: object, notificationCentre: self) }
    }
    
    func hasObserver(_ observer: Observer, forEvent event: String) -> Bool {
        syncQueue.sync {
            subscribers[event]?.contains(observer) == true
        }
    }
}
