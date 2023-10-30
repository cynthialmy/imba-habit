import {icons} from "./icons"

tag habit-item
	prop name = "Untitled"
	prop done = false
	prop id

	css button fs:xxs c:cooler4 @hover:blue5 bgc:transparent px:0
		.item tween:all 200ms ease
		c:cool5 fw:500
		fs:xs rd:md p:5px
		size:70px @xs:90px
		bgc:cooler2
		d:vflex g:5px ja:center
		bgc:cooler2
		&.done bgc:emerald5 c:white

	<self>
		<button.item 
			@click.alt=emit("deleteItem", id) 
			@click=emit("toggleItem", id)
			.done=done 
		>

			<svg src=icons[name]..svg>