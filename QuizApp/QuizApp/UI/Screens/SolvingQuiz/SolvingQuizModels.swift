import UIKit

struct QuizStartRequest {

    let id: Int

}

extension QuizStartRequestModel {

    init(_ request: QuizStartRequest) {
        id = request.id
    }

}

struct QuizStartResponse {

    let questions: [Question]
    let sessionId: String

}

extension QuizStartResponse {

    static var empty = QuizStartResponse(questions: [], sessionId: "")

    init(_ model: QuizStartResponse, id: Int, selectedAnswerId: Int) {
        questions = model.questions.map { $0.id == id ? Question($0, selectedAnswerId: selectedAnswerId) : $0 }
        sessionId = model.sessionId
    }

}

struct Question {

    let id: Int
    let answers: [Answer]
    let correctAnswerId: Int
    let question: String

}

extension Question {

    init(_ model: Question, selectedAnswerId: Int) {
        id = model.id
        answers = model.answers.map {
            if selectedAnswerId == model.correctAnswerId {
                return Answer(
                    $0,
                    color: $0.id == model.correctAnswerId ? .correctAnswerColor : .white.withAlphaComponent(0.3))
            } else {
                if $0.id == selectedAnswerId {
                    return Answer($0, color: .incorrectAnswerColor)
                } else if $0.id == model.correctAnswerId {
                    return Answer($0, color: .correctAnswerColor)
                } else {
                    return Answer($0, color: .white.withAlphaComponent(0.3))
                }
            }
        }
        self.correctAnswerId = model.correctAnswerId
        question = model.question
    }

}

struct Answer {

    let id: Int
    let answer: String
    let color: UIColor

}

extension Answer {

    init(_ model: Answer, color: UIColor) {
        id = model.id
        answer = model.answer
        self.color = color
    }

}

extension QuizStartResponse: Equatable {

    init(_ response: QuizStartResponseModel) {
        questions = response.questions.map { Question($0) }
        sessionId = response.sessionId
    }

}

extension Question: Equatable {

    init(_ question: QuestionModel) {
        answers = question.answers.map { Answer($0) }
        correctAnswerId = question.correctAnswerId
        id = question.id
        self.question = question.question
    }

}

extension Answer: Equatable {

    init(_ answer: AnswerModel) {
        self.answer = answer.answer
        id = answer.id
        color = .white.withAlphaComponent(0.3)
    }

}

struct QuizEndRequest {

    let id: String
    let numberOfCorrectQuestions: Int

}

extension QuizEndRequestModel {

    init(_ model: QuizEndRequest) {
        id = model.id
        numberOfCorrectQuestions = model.numberOfCorrectQuestions
    }

}
