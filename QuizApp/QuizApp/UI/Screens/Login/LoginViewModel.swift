import Combine
import UIKit

class LoginViewModel: ObservableObject {

    @Published var isLoginButtonEnabled = false
    @Published var errorText = ""
    @Published var email = ""
    @Published var password = ""

    private var router: AppRouterProtocol!
    private var useCase: LoginUseCaseProtocol!

    private var cancellables = Set<AnyCancellable>()

    init(router: AppRouterProtocol, useCase: LoginUseCaseProtocol) {
        self.router = router
        self.useCase = useCase

        bindViewModel()
    }

    init() {
        bindViewModel()
    }

    private func bindViewModel() {
        $email
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.checkInputValidity()
            }
            .store(in: &cancellables)

        $password
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.checkInputValidity()
            }
            .store(in: &cancellables)
    }

    @MainActor
    func pressedLoginButton() {
        errorText = ""
        Task {
            do {
                _ = try await useCase.logIn(username: email, password: password)

                router.showHome()
            } catch let error as RequestError {
                showError(error)
            }
        }
    }

    private func showError(_ error: RequestError) {
        switch error {
        case .unauthorisedError:
            errorText = "Invalid credentials!"
        default:
            errorText = "Error logging in!"
        }
    }

    private func checkInputValidity() {
        isLoginButtonEnabled = !password.isEmpty && isValidEmail(email)
        errorText = ""
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
