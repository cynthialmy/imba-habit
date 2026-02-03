import {icons} from "./icons"
import {getIconsForCategory} from "./icons-categories"

tag habit-adder
	prop category = null

	css section bgc:white rd:lg w:100% max-width:960px mx:auto
		$spacing:12px
		ofx:scroll d:grid gtc:repeat(auto-fit, minmax(90px, 1fr))
		grid-gap:$spacing p:$spacing
		button pos:relative rd:12px p:0 bgc:cooler1
		button@before content:"" pb:100% d:block
		.icon-view inset:6px d:flex ja:center
		button@focus outline:0
		button@hover bgc:cooler3/50
		button@focus shadow:0 0 0 2px cooler4/25
		.empty-tip ta:center p:20px color:cool5 fs:sm
		.helper ta:center color:cool5 fs:xs mb:8px

	<self>
		<section>
				<div.helper>
					"Tap an icon to log a moment for this focus."
			const categoryIcons = category ? getIconsForCategory(category) : null
			if !category
				<div.empty-tip>
					"Pick a focus to see moments"
			else if !categoryIcons or Object.keys(categoryIcons).length === 0
				<div.empty-tip>
					"No icons configured for this focus yet"
			else
				for own name, icon of categoryIcons
					<button @click=emit('momentLogged', name)>
						<div.icon-view>
							<svg src=icon.svg>