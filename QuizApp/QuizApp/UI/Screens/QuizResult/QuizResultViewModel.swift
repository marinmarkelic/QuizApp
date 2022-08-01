import Combine

class QuizResultViewModel {

    private let result: Result

    private let router: AppRouterProtocol
    private let useCase: SolvingQuizUseCase

    init(result: Result, router: AppRouterProtocol, useCase: SolvingQuizUseCase) {
        self.result = result
        self.router = router
        self.useCase = useCase

        setText()
        endQuiz()
    }

    private func endQuiz() {
        Task {
            do {
                let request = QuizEndRequest(id: useCase.sessionID, numberOfCorrectQuestions: 2)
                let response = try await useCase.endQuiz(with: QuizEndRequestModel(request))
                print(response)
            } catch let err {
                print(err)
            }
        }
    @Published var text: String = ""

    private func setText() {
        text = "\(result.correctQuestions)/\(result.totalQuestions)"
    }

    func exitQuiz() {
        router.showHome()
    }

}
