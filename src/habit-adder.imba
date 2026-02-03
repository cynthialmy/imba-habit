import {icons} from "./icons"
import {getIconsForCategory} from "./icons-categories"

tag habit-adder
	prop category = null

	css section bgc:white rd:lg w:100% max-width:960px mx:auto
		$spacing:20px
		d:flex fd:column ai:stretch
		p:$spacing
		.content d:flex fd:column ai:center g:16px
			.helper ta:center color:cool5 fs:sm w:100% px:0 py:12px
			.icons-row d:flex jc:center g:$spacing fw:wrap
				button pos:relative rd:12px p:0 bgc:cooler1
				button@before content:"" pb:100% d:block
				.icon-view inset:6px d:flex ja:center
				button@focus outline:0
				button@hover bgc:cooler3/50
				button@focus shadow:0 0 0 2px cooler4/25
		.empty-tip ta:center p:20px color:cool5 fs:md
		.icon-btn size:90px min-w:90px

	<self>
		<section>
			const categoryIcons = category ? getIconsForCategory(category) : null
			if !category
				<div.empty-tip>
					"Pick a focus to see moments"
			else if !categoryIcons or Object.keys(categoryIcons).length === 0
				<div.empty-tip>
					"No icons configured for this focus yet"
			else
				<div.content>
					<div.helper>
						<div style="fs:md fw:500"> "What gave you a dopamine boost today?"
						<div style="mt:6px fs:sm"> "Tap any moment that feels true. There's no right or wrong — just notice."
					<div.icons-row>
						for own name, icon of categoryIcons
							<button.icon-btn @click=emit('momentLogged', name)>
								<div.icon-view>
									<svg src=icon.svg>
