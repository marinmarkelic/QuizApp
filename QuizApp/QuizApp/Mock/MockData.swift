import UIKit

public let sportColor = UIColor(red: 242 / 255, green: 201 / 255, blue: 76 / 255, alpha: 1)
public let politicsColor = UIColor(red: 86 / 255, green: 204 / 255, blue: 242 / 255, alpha: 1)
public let youtubeColor = UIColor(red: 242 / 255, green: 24 / 255, blue: 24 / 255, alpha: 1)
public let animalsColor = UIColor(red: 117 / 255, green: 74 / 255, blue: 21 / 255, alpha: 1)

private let categories = [
    Category(name: "Sport", color: sportColor),
    Category(name: "Politics", color: politicsColor),
    Category(name: "Youtube", color: youtubeColor),
    Category(name: "Animals", color: animalsColor)
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
         difficulty: .normal,
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
         difficulty: .normal,
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
         difficulty: .normal,
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
         difficulty: .normal,
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
