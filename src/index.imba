import {nanoid} from 'nanoid'
import "./habit-group"
import "./habit-item"
import "./habit-adder"

global css
	@root
		$panel-space:30px @lt-sm:15px
		$icon-radius:15px @lt-sm:8px
		$icon-space:10px @lt-sm:5px
		$icon-size:70px @lt-sm:44px
		$default-speed:350ms
		$default-ease:ease
		$default-tween:all $default-speed $default-ease
	body bgc:#F9FAFC

tag dopamine-box
	prop habits = [{name: "emotions_dizzy", done: true, id: nanoid()}]
	prop showAdder = true
			
	def toggleAdder
		showAdder = !showAdder
	
	def resetAll
		for habit in habits
			habit.done = false
	
	def handleHabitAdded e # In Imba, UI is rerendered on every handeled event
		console.log e
		const newHabit = {name: e.detail, done: false, id: nanoid()}
		habits.push newHabit

	css .container inset:0px d:vflex jc:center ai:stretch
		.panel-area d:vflex ja:center flg:1 mt:0 mb:$panel-space pt:$panel-space
			.controls mt:20px d:flex g:10px
				button bgc:transparent td@hover:underline fs:xs color:blue5 cursor:pointer
		.chooser-area tween:$default-tween h:0 pos:relative of:hidden
			&.on h:100%
			.chooser inset:0 mx:$panel-space ofy:scroll bgc:cooler2 rdt:10px

	<self>
		<div.container>
			<div.panel-area>
				<habit-group habits=habits>

				<div.controls>
					<button @click=toggleAdder> "Toggle"
					<button @click=resetAll> "Reset All"
		
			<div.chooser-area .on=showAdder>
				<div.chooser>
					<habit-adder @habitAdded=handleHabitAdded>

imba.mount <dopamine-box>