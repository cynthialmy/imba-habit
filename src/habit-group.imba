tag habit-group
	prop habits = []
	
	css .group tween:all 200ms ease
		d:flex g:10px g@xs:30px jc:center
	
	<self>
		<div.group>
			for habit, i in habits
				<habit-item
					key=habit.id
					id=habit.id
					name=habit.name
					done=habit.done
				>

