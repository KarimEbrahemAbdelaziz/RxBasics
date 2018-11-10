import RxSwift

//MARK:- Transforming Operators

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

executeProcedure(for: "FlatMap and FlatMapLatest") {
    let disposeBag = DisposeBag()
    
    struct GamePlayer {
        let playerScore: Variable<Int>
    }
    
    let alex = GamePlayer(playerScore: Variable(10))
    let gemma = GamePlayer(playerScore: Variable(20))
    
    let currentPlayer = Variable(alex)
    
    currentPlayer.asObservable()
        .flatMapLatest{ $0.playerScore.asObservable() }
        .subscribe(onNext:{
            print($0)
        })
        .disposed(by: disposeBag)
    
    currentPlayer.value.playerScore.value = 11
    alex.playerScore.value = 12
    
    currentPlayer.value = gemma
    
    alex.playerScore.value = 13
    gemma.playerScore.value = 21
    
}

executeProcedure(for: "Scan") {
    
    Observable.of(10, 20, 30)
        .scan(2, accumulator: { (addition, value) -> Int in
            return value + addition
        })
        .subscribe(onNext: {
            print($0)
        })
        .dispose()
    
}

executeProcedure(for: "Reduce") {
    
    Observable.of(10, 20, 30)
        .reduce(0, accumulator: +)
        .subscribe(onNext: {
            print($0)
        })
        .dispose()

}

executeProcedure(for: "Buffer") {
    
    Observable.of(10, 20, 30, 40, 50, 60)
        .buffer(timeSpan: 0.0, count: 3, scheduler: MainScheduler.instance)
        .subscribe(onNext: {
            print($0)
            print(type(of: $0))
        })
        .dispose()
    
}

//MARK:- Filtering Operators

executeProcedure(for: "Filter") {
    let disposeBag = DisposeBag()
    
    let numbers = Observable.generate(initialState: 1, condition: { $0 < 101 }, iterate: { $0 + 1})
    numbers
        .filter {
            $0.isPrime()
        }
        .toArray()
        .subscribe({
            print( $0 )
        })
        .disposed(by: disposeBag)
    
}
