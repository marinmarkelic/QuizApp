import UIKit

private let categories = [
    Category(name: .sport),
    Category(name: .politics),
    Category(name: .youtube),
    Category(name: .animals)
]

let sportQuizes = [
    Quiz(id: 1,
         name: "Football",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[0],
         difficulty: .easy,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Olympics",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[0],
         difficulty: .medium,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "NBA",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[0],
         difficulty: .hard,
         imageUrl: "",
         numberOfQuestions: 0)
]

let politicsQuizes = [
    Quiz(id: 1,
         name: "Presidents",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[1],
         difficulty: .easy,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Ideologies",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[1],
         difficulty: .medium,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Quiz 3",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[1],
         difficulty: .hard,
         imageUrl: "",
         numberOfQuestions: 0)
]

let youtubeQuizes = [
    Quiz(id: 1,
         name: "Youtubers",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[2],
         difficulty: .easy,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Channels",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[2],
         difficulty: .medium,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Quiz 3",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[2],
         difficulty: .hard,
         imageUrl: "",
         numberOfQuestions: 0)
]

let animalsQuizes = [
    Quiz(id: 1,
         name: "Name the animal",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[3],
         difficulty: .easy,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "Mammals",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[3],
         difficulty: .medium,
         imageUrl: "",
         numberOfQuestions: 0),
    Quiz(id: 1,
         name: "NBA",
         description: "Quiz description that can usually span over multiple lines",
         category: categories[3],
         difficulty: .hard,
         imageUrl: "",
         numberOfQuestions: 0)
]
