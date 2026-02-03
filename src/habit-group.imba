tag habit-group
	prop moments = []

	css
		.group tween:all 200ms ease
			d:flex g:10px jc:center fw:wrap
			@xs g:16px
			@lt-sm g:8px
			&.empty rd:md shadow:0 0 0 2px cooler2 py:30px
			@lt-sm py:20px
		.empty-state
			ta:center color:cool5 fs:md mx:20px lh:1.4
			@lt-sm fs:sm mx:12px

	def render
		const empty? = moments.length === 0
		<self>
			<div.group .empty=empty?>
				if empty?
					<div.empty-state> "No moments logged yet. Tap an icon below to add a small win. Click again to mark done; Alt+Click to delete."
				else
					for moment, i in moments
						<habit-item
							key=moment.id
							id=moment.id
							name=moment.name
							done=moment.done
						>
