import RxSwift

executeProcedure(for: "Map") {
    
    Observable.of(1, 2, 3)
        .map({ (value) -> Int in
            return value * value
        })
        .subscribe(onNext: {
            print($0)
        })
        .dispose()
    
}
