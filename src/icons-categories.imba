import {icons} from "./icons"

export const categories = {
	"calm": {
		label: "🌱 Calm & Rest"
		color: "cooler5"
		iconIds: [
			"emotions_calm"
			"emotions_sleepy"
			"places_forest"
			"places_forest_persons"
			"body_eye"
		]
	}
	"achievement": {
		label: "💪 Achievement"
		color: "orange5"
		iconIds: [
			"symbols_award_trophy"
			"symbols_chart_line"
			"symbols_i_note_action"
			"symbols_i_exam_multiple_choice"
			"people_exercise_weights"
		]
	}
	"social": {
		label: "🤝 Social"
		color: "pink5"
		iconIds: [
			"symbols_communication"
			"symbols_community_meeting"
			"people_forum"
			"emotions_happy"
			"emotions_ok"
		]
	}
	"creativity": {
		label: "🎨 Creativity"
		color: "purple5"
		iconIds: [
			"symbols_i_note_action"
			"objects_desktop_app"
			"devices_mobile"
			"people_child_cognition"
			"symbols_peace"
		]
	}
}

export def getIconsForCategory categoryKey
	const categoryData = categories[categoryKey]
	if !categoryData
		return []
	
	let result = {}
	for iconId in categoryData.iconIds
		if icons[iconId]
			result[iconId] = icons[iconId]
	result
