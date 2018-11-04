import UIKit
import RxSwift

public func executeProcedure(for description: String, procedure: () -> Void){
    print("Procedure executed for:", description)
    procedure()
}
