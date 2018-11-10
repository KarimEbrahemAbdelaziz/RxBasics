import UIKit
import RxSwift

public func executeProcedure(for description: String, procedure: () -> Void){
    print("\nProcedure executed for:", description)
    procedure()
}
