import {icons} from "./icons"
import {getIconsForCategory} from "./icons-categories"

tag habit-adder
	prop category = null

	css section bgc:white rd:lg w:100% max-width:960px mx:auto min-w:0
		$spacing:20px
		d:flex fd:column ai:stretch
		p:$spacing
		@lt-sm p:12px rd:12px
		.content d:flex fd:column ai:center g:16px min-w:0 w:100%
			@lt-sm g:12px
			.helper ta:center color:cool5 fs:sm w:100% min-w:0 px:0 py:12px overflow-wrap:break-word word-break:break-word box-sizing:border-box
			@lt-sm fs:xs py:8px px:4px
			.helper > *
				min-w:0 overflow-wrap:break-word word-break:break-word
			.icons-row d:flex jc:center g:$spacing fw:wrap
				@lt-sm g:12px
				button pos:relative rd:12px p:0 bgc:cooler1
				button@before content:"" pb:100% d:block
				.icon-view inset:6px d:flex ja:center
				button@focus outline:0
				button@hover bgc:cooler3/50
				button@focus shadow:0 0 0 2px cooler4/25
		.empty-tip ta:center p:20px color:cool5 fs:md
		@lt-sm p:16px fs:sm
		.icon-btn size:90px min-w:90px
		@lt-sm size:72px min-w:72px rd:10px

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
						<div style="mt:6px fs:sm"> "Tap any moment that feels true. There's no right or wrong, just notice."
					<div.icons-row>
						for own name, icon of categoryIcons
							<button.icon-btn @click=emit('momentLogged', name)>
								<div.icon-view>
									<svg src=icon.svg>
