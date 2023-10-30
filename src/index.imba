import "./habit-group"
import "./habit-item"

imba.mount <habit-group habits=[
	{name: "Clean Up", done: true, id: 5}
	{name: "Exercise", done: false, id: 10}
	{name: "Study", done: true, id: 100}
]>