import UIKit
import RxSwift

public func executeProcedure(for description: String, procedure: () -> Void){
    print("\nProcedure executed for:", description)
    procedure()
}

public extension Int {
    func isPrime() -> Bool {
        guard self > 1 else { return false }
        
        var isPrimeFlag = true
        
        for index in 2..<self {
            if self % index == 0 {
                isPrimeFlag = false
            }
        }
        
        return isPrimeFlag
    }
}
