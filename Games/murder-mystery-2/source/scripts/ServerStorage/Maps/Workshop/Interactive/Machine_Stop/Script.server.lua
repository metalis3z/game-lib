local button = script.Parent.Button
local click = button.ClickDetector
local Tube = script.Parent.Tube
local debounce = false

local function onClicked(player)
	if not debounce then
		debounce = true
		Tube.Sound:Play()
		wait(3)
		debounce = false
	end
end

click.MouseClick:connect(onClicked)