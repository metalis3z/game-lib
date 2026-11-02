--> Variables
local _L = _G._L

local Network
local Pool

--> Constants

---------->
return {
	{
		name = "Punch",
		idle_animation = "punch_idle",
		click_animation = {"punch_left", "punch_right"},
		click_audio = {name = "Swing1"},
		cooldown = 0.35,
		effect = "Punch"
	},
	
	{
		name = "Fireball",
		idle_animation = nil,
		click_animation = {"punch_right"},
		click_audio = {name = {"Whoosh1", "Whoosh2"}},
		cooldown = 1.5,
		effect = "Fireball"
	}
}