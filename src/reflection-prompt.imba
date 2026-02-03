import {icons} from "./icons"

tag reflection-prompt
	prop moments = []
	prop reflectionSelected = null

	css .overlay
		inset:0 pos:fixed bgc:black/50 d:flex ja:center ai:center z:10
		.modal
			bgc:white rd:lg p:30px d:vflex g:20px max-width:500px
			.title fw:bold fs:xl color:cooler4 ta:center
			.subtitle ta:center color:cool5 fs:md
			.moments-grid
				d:grid gtc:repeat(auto-fit, minmax(60px, 1fr)) g:15px
				button
					pos:relative d:vflex ja:center ai:center
					bgc:cooler2 rd:10px p:0 tween:all 200ms ease
					size:60px
					&@hover bgc:cooler3
					&.selected bgc:emerald5
					svg c:cool5
					&.selected svg c:white
			.footer
				d:flex g:10px
				button bgc:cooler4 c:white rd:md px:15px py:10px fs:md
					&@hover bgc:cooler5

	<self>
		<div.overlay>
			<div.modal>
				<div.title>
					"Looking back — which moment mattered most today?"
				<div.subtitle>
					"Don't overthink it. Just pick one."
				<div.moments-grid>
					for moment in moments
						<button
							@click=emit('reflectionAnswer', moment.id)
							.selected=(moment.id === reflectionSelected)
						>
							<svg src=icons[moment.name]..svg>
				<div.footer>
					<button @click=emit('reflectionComplete', reflectionSelected)>
						"Continue"
