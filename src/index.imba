import {nanoid} from 'nanoid'
import {persistData, loadData, clearData} from './persist'
import {categories, getIconsForCategory} from './icons-categories'
import "./habit-group"
import "./habit-item"
import "./habit-adder"
import "./reflection-prompt"

global css
	@root
		$panel-space:30px @lt-sm:15px
		$icon-radius:15px @lt-sm:8px
		$icon-space:10px @lt-sm:5px
		$icon-size:70px @lt-sm:44px
		$default-speed:350ms
		$default-ease:ease
		$default-tween:all $default-speed $default-ease
	body bgc:#F9FAFC font-family:'Nunito', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif

tag dopamine-box
	prop moments = loadData() || []
	prop currentScreen = "category-select" # category-select | logging | reflection | summary
	prop selectedCategory = null
	prop showAdder = false
	prop reflectionSelected = null
	prop allDone? = false

	def persist
		persistData(moments)

	def selectCategory category
		selectedCategory = category
		currentScreen = "logging"
		showAdder = true

	def handleMomentLogged e
		const newMoment = {name: e.detail, done: false, id: nanoid(), category: selectedCategory}
		moments.push newMoment
		persist()

	def handleReflectionAnswer e
		reflectionSelected = e.detail

	def handleReflectionComplete e
		currentScreen = "summary"
		allDone? = true
		reflectionSelected = null

	def getDominantCategory
		const categoryCounts = {}
		for moment in moments
			categoryCounts[moment.category] ||= 0
			categoryCounts[moment.category] += 1

		let dominantCategory = selectedCategory
		let maxCount = 0
		for own category, count of categoryCounts
			if count > maxCount
				maxCount = count
				dominantCategory = category
		dominantCategory

	def addCategory
		currentScreen = "category-select"

	def continueLogging
		currentScreen = "logging"
		showAdder = true

	def resetAll
		moments = []
		currentScreen = "category-select"
		selectedCategory = null
		showAdder = false
		reflectionSelected = null
		allDone? = false
		persist()

	def endDay
		if moments.length > 0
			currentScreen = "reflection"
		else
			currentScreen = "summary"
			allDone? = true

	def deleteItem e
		const idToDelete = e.detail
		moments = moments.filter do(m) m.id !== idToDelete
		persist()

	def toggleItem e
		const idToToggle = e.detail
		for moment in moments
			if moment.id === idToToggle
				moment.done = !moment.done
		persist()

	def handleClearData
		clearData()
		moments = []
		currentScreen = "category-select"
		selectedCategory = null
		allDone? = false

	css .container inset:0px d:vflex jc:center ai:center of:auto py:40px
		.header fs:xl fw:600 color:cooler4 ta:center mt:40px mb:10px
		.description ta:center color:cool5 fs:md mb:20px mx:20px lh:1.6
		.category-selector
			d:flex fd:column g:15px ai:center mt:20px
			.category-btn
				bgc:white bd:2px solid cooler3 rd:lg px:20px py:12px
				cursor:pointer fs:md fw:500 color:cooler4 tween:all 200ms ease
				min-width:200px ta:center w:250px
				&@hover bgc:cooler1 bd-color:cooler4
				&.selected bgc:cooler4 c:white bd-color:cooler4
		.panel-area d:vflex ja:center mt:0 mb:0 pt:$panel-space
			.session-header
				d:flex ai:center jc:center g:10px mb:20px
				.category-badge bgc:cooler2 rd:md px:15px py:8px fw:500 fs:md color:cooler4
				.session-hint fs:sm color:cool5
			.controls mt:20px d:flex g:10px jc:center fw:wrap
				button bgc:cooler4 c:white rd:md px:12px py:8px fs:sm cursor:pointer
					&@hover bgc:cooler5
				button bgc:transparent bd:1px solid cooler3 color:cooler4 rd:md px:12px py:8px fs:sm cursor:pointer
					&@hover bgc:cooler1
		.summary-section
			d:vflex ai:center g:20px mt:40px px:20px
			.summary-title fw:bold fs:xl color:cooler4 ta:center
			.summary-category bgc:cooler2 rd:lg px:30px py:20px fs:lg fw:500 color:cooler4 ta:center
			.moments-breakdown
				bgc:cooler1 rd:lg px:20px py:15px w:100% max-width:400px
				.breakdown-title fw:500 color:cooler4 mb:10px fs:md
				.breakdown-item d:flex jc:between ai:center mb:8px
					.category-name color:cool5 fs:md
					.count bgc:cooler4 c:white rd:md px:8px py:2px fw:bold fs:sm
			.summary-subtitle ta:center color:cool5 fs:md mb:10px
			.button-group d:flex g:10px
				button bgc:cooler4 c:white rd:md px:20px py:12px cursor:pointer
					&@hover bgc:cooler5
				button bgc:transparent bd:1px solid cooler4 color:cooler4 rd:md px:20px py:12px cursor:pointer
					&@hover bgc:cooler1
		.chooser-area tween:$default-tween pos:relative of:hidden
			max-height:0
			&.on
				max-height:none
			.chooser mx:$panel-space bgc:cooler2 rdt:10px p:12px mt:40px mb:40px

	def getCategoryLabel cat
		const label = categories[cat]?.label || "Unknown"
		label

	def getCategoryCount cat
		moments.filter(do |m| m.category === cat).length

	def getDefaultScreen
		if moments.length === 0
			"category-select"
		else
			"logging"

	def setup
		if moments.length === 0
			currentScreen = "category-select"
		else if currentScreen === "category-select"
			currentScreen = "logging"
		if currentScreen === "logging" and !selectedCategory
			selectedCategory = Object.keys(categories)[0]
			showAdder = true

	<self>
		<div.container>
			if currentScreen === "category-select"
				<div.header>
					if moments.length === 0
						"Dopamine Box"
					else
						"Choose today's focus"
				<div.description>
					if moments.length === 0
						<div> "A tiny daily space to notice what made you feel good today."
						<div style="mt:8px fs:sm"> "Log small moments — not habits, not goals. Just things that gave you a lift."
					else
						"You can add another focus or continue logging moments for the current one."
				<div.category-selector>
					for own key, category of categories
						<button.category-btn
							@click=selectCategory(key)
							.selected=(key === selectedCategory)
						>
							category.label

			else if currentScreen === "logging"
				<div.panel-area>
					<div.session-header>
						<div.category-badge>
							if selectedCategory
								getCategoryLabel(selectedCategory)
							else
								"Select a category"
						<div.session-hint>
							if moments.length === 0
								"What gave you a dopamine boost today? Tap any moment that feels true."
							else if moments.length === 1
								"Nice. Small moments count."
							else if moments.length <= 3
								"Want to keep going, or reflect on what mattered most?"
							else
								moments.length + " moments captured. Ready to reflect?"
					<div.description style="ta:center color:cool5 fs:sm mx:20px">
						"Add quick moments below, then end your day to reflect on what mattered most."

					<habit-group
						@deleteItem=deleteItem
						@toggleItem=toggleItem
						moments=moments
					>

					<div.controls>
						<button @click=addCategory> "➕ Add Different Focus"
						<button @click=endDay> "✨ End Day & Reflect"
						<button @click=handleClearData> "Clear Data"

				<div.chooser-area .on=showAdder>
					<div.chooser>
						<habit-adder
							@momentLogged=handleMomentLogged
							category=selectedCategory
						>

			else if currentScreen === "reflection"
				<reflection-prompt
					moments=moments
					reflectionSelected=reflectionSelected
					@reflectionAnswer=handleReflectionAnswer
					@reflectionComplete=handleReflectionComplete
				>

			else if currentScreen === "summary" and allDone?
				<div.summary-section>
					<div.summary-title> "That's today's dopamine."

					let categoryNames = {}
					for own key, cat of categories
						categoryNames[key] = cat.label

					let dominantCategory = getDominantCategory()
					if dominantCategory and moments.length > 0
						<div.summary-category>
							"Most of your positive moments came from " + getCategoryLabel(dominantCategory) + "."

					<div.moments-breakdown>
						<div.breakdown-title> "Moments by category"
						for own key, cat of categories
							const count = getCategoryCount(key)
							if count > 0
								<div.breakdown-item>
									<div.category-name> categoryNames[key]
									<div.count> count

					<div.description style="ta:center color:cool5 fs:sm mx:20px mb:20px">
						"You logged " + moments.length + " moment" + (moments.length !== 1 ? "s" : "") + " today"

					<div.button-group>
						<button @click=resetAll> "🌅 Start a new day"
						<div style="ta:center color:cool5 fs:sm mt:8px w:100%"> "(You can come back anytime.)"



imba.mount <dopamine-box>
