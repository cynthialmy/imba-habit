tag habit-group
	prop moments = []
	
	css
		.group tween:all 200ms ease
			d:flex g:10px g@xs:30px jc:center fw:wrap
			&.empty rd:md shadow:0 0 0 2px cooler2 py:30px
		.empty-state
			ta:center color:cool5 fs:sm

	def render
		const empty? = moments.length === 0
		<self>
			<div.group .empty=empty?>
				if empty?
					<div.empty-state> "No moments logged yet. Tap the icon grid below to start!"
				else
					for moment, i in moments
						<habit-item
							key=moment.id
							id=moment.id
							name=moment.name
							done=moment.done
						>

