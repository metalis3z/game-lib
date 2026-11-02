local module = {}

local Colors = {
	Color3.fromRGB(71, 102, 79),
	Color3.fromRGB(102, 97, 72),
	Color3.fromRGB(72, 97, 102),
	Color3.fromRGB(73, 70, 102),
	Color3.fromRGB(91, 72, 102),
	Color3.fromRGB(48, 72, 102),
	Color3.fromRGB(102, 101, 68),
	Color3.fromRGB(80, 102, 72),
	Color3.fromRGB(102, 67, 67),
}

local ValidFigures = {
	1,
	2,
	3,
	4,
	5,
	6,
	7,
	8,
	9
}

function module:SettingHintBook(v)
	
	local random_element_pos = math.random(1, #Colors)
	local RandomTable = Colors[random_element_pos]
	
	local randomC = Colors[random_element_pos]
	
	v.Cover1.Color = randomC
	v.Cover2.Color = randomC
	
	module:SetLiveHintBook(v, randomC)
	table.remove(Colors, random_element_pos)
end

function module:SetLiveHintBook(v, color)
	local ID = v:GetAttribute("ID")
	local number = math.random(0, 9)
	
	local random_element_pos = math.random(1, #ValidFigures)
	local RandomTable = ValidFigures[random_element_pos]

	local randomC = ValidFigures[random_element_pos]
	
	local FigureNumber = randomC
	
	game.ServerScriptService.Handler:SetAttribute("Number"..ID, number)
	game.ServerScriptService.Handler:SetAttribute("Figure"..ID, FigureNumber)
	
	v.ActivateEventPrompt.MaxActivationDistance = 6
	v.ActivateEventPrompt.RequiresLineOfSight = false
	
	v.ActivateEventPrompt.Triggered:Connect(function(plr)
		local newbook = game.ServerStorage.HintBook:Clone()
		newbook:SetAttribute("Figure", randomC)
		newbook:SetAttribute("Number", number)
		newbook:SetAttribute("Color", color)
		newbook.Parent = plr.Character
		
		v:Destroy()
	end)
	
	table.remove(ValidFigures, random_element_pos)
end

return module
