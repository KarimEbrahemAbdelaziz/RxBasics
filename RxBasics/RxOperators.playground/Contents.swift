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
