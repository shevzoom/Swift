import Foundation

protocol Observer: AnyObject {
    func observe(event: String, object: Any?, notificationCenter: NotificationCenter)
}

class NotificationCenter {
    
    static let shared = NotificationCenter()
    
    private var subscribers: [String: NSHashTable<AnyObject>] = [:]
    private init() {}
    
    func add(_ observer: Observer, forEvent event: String) {
        subscribers[event, default: NSHashTable<AnyObject>.weakObjects()].add(observer)
    }
    
    func remove(_ observer: Observer, forEvent event: String) {
        subscribers[event]?.remove(observer)
    }
    
    func post(event: String, object: Any?) {
        if let newSubscribers = subscribers[event] as? [Observer] {
            for i in newSubscribers {
                i.observe(event: event, object: object, notificationCenter: self)
            }
        }
        
    }
    
    func hasObserver(_ observer: Observer, forEvent event: String) -> Bool {
        subscribers[event]?.contains(observer) == true
    }
}



