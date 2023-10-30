tag habit-group
	prop habits = []
	
	css .group tween:all 200ms ease
		bgc:#fff  p:10px rd:lg
		d:flex g:10px g@xs:30px jc:center
		shadow:0 5px 15px black/20
	
	css div.controls mt:10px d:flex jc:space-between
		button bgc:transparent td@hover:underline fs:xs color:blue5 cursor:pointer
			
	def completeAll
		for habit in habits
			habit.done = true
	
	def resetAll
		for habit in habits
			habit.done = false
	
	def deleteItem index
		habits.splice(index, 1)
		
	<self>
		<div.group>
			for habit, i in habits
				<habit-item
					$key=habit.id
					bind:name=habit.name
					bind:done=habit.done
					@deleteItem=deleteItem(i)
				>
		<div.controls>
			<button @click=completeAll> "Complete All"
			<button @click=resetAll> "Reset All"
