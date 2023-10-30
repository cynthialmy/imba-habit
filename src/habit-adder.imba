tag habit-adder

	prop name = ""

	css bgc:cool2 p:10px rd:lg 
		header fw:500 fs:xs mb:5px mt:-5px c:cool5
		section form d:flex g:5px
		button bgc:indigo5 @hover:indigo6 c:white rd:sm px:5px
		div flex:1
			input w:100% px:5px rd:sm
	
	def handleSubmit
		emit("habitAdded", name)
		name = ""

	<self>
		<header> "Add Habit"
		<section>
			<form @submit.prevent=handleSubmit>
				<div> <input type="text" bind=name placeholder="Habit Name">
				<button type="submit"> "Add"