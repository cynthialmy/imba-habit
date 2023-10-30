import {nanoid} from 'nanoid'
import {persistData, loadData, clearData} from './persist'
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
	prop habits = loadData() || []
	prop showAdder = false
	prop allDone? = false

	def persist
		persistData(habits)
			
	def toggleAdder
		showAdder = !showAdder
	
	def resetAll
		for habit in habits
			habit.done = false
		allDone? = false
		persist()
	
	def handleHabitAdded e # In Imba, UI is rerendered on every handeled event
		console.log e
		const newHabit = {name: e.detail, done: false, id: nanoid()}
		habits.push newHabit
		persist()

	def deleteItem e
		const idToDelete = e.detail
		# filter function returns a new array, where every item that returns true is kept
		habits = habits.filter do(h) h.id !== idToDelete # Imba's do() is like JS's arrow function
		persist()

	def toggleItem e
		const idToToggle = e.detail
		let remaining = 0
		for habit in habits
			if habit.id === idToToggle
				habit.done = !habit.done
			remaining++ unless habit.done
		if remaining === 0
			allDone? = true
			setTimeout(&, 500) do
				resetAll()
				imba.commit()
		persist()
	
	def handleClearData
		clearData()
		habits = []
		allDone? = false

	css .container inset:0px d:vflex jc:center ai:stretch
		.congrats fs:lg fw:bold color:cooler4 ta:center mt:20px 
		.panel-area d:vflex ja:center flg:1 mt:0 mb:$panel-space pt:$panel-space
			.controls mt:20px d:flex g:10px
				button bgc:transparent td@hover:underline fs:xs color:cooler4 cursor:pointer
		.chooser-area tween:$default-tween h:0 pos:relative of:hidden
			&.on h:100%
			.chooser inset:0 mx:$panel-space ofy:scroll bgc:cooler2 rdt:10px

	def setup
		if habits.length === 0
			showAdder = true

	<self>
		<div.container>
			if allDone?
				<div.congrats> "Congrates! You filled your Dopamine Box!!"
			<div.panel-area>
				<habit-group 
					@deleteItem=deleteItem 
					@toggleItem=toggleItem
					habits=habits
				>

				<div.controls>
					<button @click=toggleAdder> "Toggle"
					<button @click=resetAll> "Reset All"
					<button @click=handleClearData> "Clear Data"
		
			<div.chooser-area .on=showAdder>
				<div.chooser>
					<habit-adder @habitAdded=handleHabitAdded>

imba.mount <dopamine-box>