--------|     Setting     |--------

--------|     Library     |--------
local _L = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"))
while (not _L.Loaded) do  game:GetService("RunService").Heartbeat:Wait()  end

--------|    Reference    |--------

--------|    Variables    |--------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


function Update()
	--- Grab states
	local touchEnabled = _L.Services.UserInputService.TouchEnabled
	local keyboardEnabled = _L.Services.UserInputService.KeyboardEnabled
	local mouseEnabled = _L.Services.UserInputService.MouseEnabled
	local gamepadEnabled =  _L.Services.UserInputService.GamepadEnabled
	local gryoEnabled = _L.Services.UserInputService.GyroscopeEnabled
	local meterEnabled = _L.Services.UserInputService.AccelerometerEnabled
	local vrEnabled = _L.Services.UserInputService.VREnabled
	local isTV = game:GetService("GuiService"):IsTenFootInterface()

	--- Vars
	local console = false
	local mobile = false
	local desktop = false
	local vr = false

	--- Platform logic
	if gamepadEnabled then
		--- Console (for sure)
		console = true

	elseif isTV and (not mouseEnabled) then
		--- Console (maybeee)
		console = true

	elseif vrEnabled then
		--- VR (for sure)
		vr = true
		desktop = _L.Settings.SupportsVR or false

	elseif touchEnabled and (not mouseEnabled) then
		--- Mobile (for sure)
		mobile = true

	elseif gryoEnabled or meterEnabled then
		--- Mobile (maybe)
		mobile = true

	else
		--- Desktop (if all else)
		desktop = true
	end

	--- Variable logic
	_L.Variables.Desktop = desktop
	_L.Variables.Mobile = mobile
	_L.Variables.Console = console
	_L.Variables.VR = vr

end


-----------------------------------------------------------------------------------------------------------------------


_L.Services.UserInputService.GamepadConnected:Connect(Update)
_L.Services.UserInputService.GamepadDisconnected:Connect(Update)


while true do
	Update()
	wait(3)
end