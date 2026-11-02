-- Created and Fixed by BUILDG Studios

local module = {
	Flashlight = {
		CanUsing = true,
		Durability = 45 or 90,
		DurabilityMax = 90,
		Interactable = true,
		ToolOffset = Vector3.new(0, 0.5, 0)
	},
	Vitamins = {
		CanUsing = false,
		Durability = 3 or 2,
		DurabilityMax = 3,
		Interactable = true,
		ToolOffset = Vector3.new(0, 0.15, 0)
	},
	Lighter = {
		CanUsing = true,
		Durability = 60 or 30,
		DurabilityMax = 60,
		Interactable = true,
		ToolOffset = Vector3.new(0, 0.5, 0)
	},
	Lockpick = {
		CanUsing = true,
		Durability = 2 or 3,
		DurabilityMax = 3,
		Interactable = false,
		ToolOffset = Vector3.new(0, 0.2, 0)
	},
	Candle = {
		CanUsing = false,
		Durability = 139 or 150,
		DurabilityMax = 150,
		Interactable = false,
		ToolOffset = Vector3.new(0, 0.1, 0)
	},
	Crucifix = {
		CanUsing = false,
		EternityDurability = 3 or 1,
		EternityDurabilityMax = 3,
		Interactable = false,
		ToolOffset = Vector3.new(0, 0, 0)
	},
	StarVial = {
		CanUsing = false,
		Durability = 1 or 5,
		DurabilityMax = 5,
		Interactable = true,
		ToolOffset = Vector3.new(0, 0.15, 0)
	},
	BigStarVial = {
		CanUsing = false,
		Interactable = true,
		ToolOffset = Vector3.new(0, 0.15, 0)
	},
	CuriousCrucifix = {
		CanUsing = false,
		EternityDurability = 3 or 1,
		EternityDurabilityMax = 3,
		Interactable = false,
		ToolOffset = Vector3.new(0, 0, 0)
	},
}

return module
