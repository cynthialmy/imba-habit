import {icons} from "./icons"
import {getIconsForCategory} from "./icons-categories"

tag habit-adder
	prop category = null

	css section bgc:white rd:lg
		$spacing:10px
		ofx:scroll d:grid gtc:repeat(auto-fit, minmax(50px, 1fr))
		grid-gap:$spacing p:$spacing
		button pos:relative rd:10px p:0 bgc:cooler1
		button@before content:"" pb:100% d:block
		.icon-view inset:5px d:flex ja:center
		button@focus outline:0
		button@hover bgc:cooler3/50
		button@focus shadow:0 0 0 2px cooler4/25

	<self>
		<section>
			const categoryIcons = getIconsForCategory(category)
			for own name, icon of categoryIcons
				<button @click=emit('momentLogged', name)>
					<div.icon-view>
						<svg src=icon.svg>