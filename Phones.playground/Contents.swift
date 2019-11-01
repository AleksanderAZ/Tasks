import Cocoa

struct Phone {
    var name: String
    var price: Int
}

extension Phone : Equatable {
    static func == (left: Phone, right: Phone) -> Bool {
        let isName =  (left.name == right.name)
        let isPrice = (left.price == right.price)
        return isName && isPrice
    }
}
protocol SetProtocol {
    var count: Int  { get }
    
    func insert(_ phone: Phone)
    func remove(_ phone: Phone)
}

class Set: SetProtocol  {
    private var items = [Phone]()

    var count: Int  {
        get {
            return self.items.count
        }
    }
    
    init(_ items: [Phone]) {
        self.items = items
    }
    
    func insert(_ phone: Phone) {
        if (!(self.items.contains(phone))) {
            self.items.append(phone)
        }
    }
    
    func remove(_ phone: Phone) {
        if let index = self.items.firstIndex(of: phone) {
            self.items.remove(at: index)
        }
    }
}

let fiveS = Phone(name: "5S", price: 100)
let sixS = Phone(name: "6S", price: 300)
let xS = Phone(name: "xS", price: 300)

let phoneArray = [fiveS, sixS, xS]

let phoneSet = Set(phoneArray)

phoneSet.insert(fiveS)
phoneSet.insert(sixS)
phoneSet.insert(xS)
phoneSet.insert(xS)

phoneSet.count == 3

phoneSet.remove(fiveS)

phoneSet.count == 2
