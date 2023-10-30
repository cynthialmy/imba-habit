import {nanoid} from 'nanoid'
import "./habit-group"
import "./habit-item"
import "./habit-adder"

tag dopamine-box
	prop habits = [
		{name: "Clean Up", done: true, id: nanoid()},
	]
	css div.controls mt:10px d:flex jc:space-between
		button bgc:transparent td@hover:underline fs:xs color:blue5 cursor:pointer
			
	def completeAll
		for habit in habits
			habit.done = true
	
	def resetAll
		for habit in habits
			habit.done = false
	
	def handleHabitAdded e # In Imba, UI is rerendered on every handeled event
		const newHabit = {name: e.detail, done: false, id: nanoid()}
		habits.push newHabit

	<self>
		<habit-group habits=habits>
		<div.controls>
			<button @click=completeAll> "Complete All"
			<button @click=resetAll> "Reset All"
		
		<habit-adder @habitAdded=handleHabitAdded>

imba.mount <dopamine-box>