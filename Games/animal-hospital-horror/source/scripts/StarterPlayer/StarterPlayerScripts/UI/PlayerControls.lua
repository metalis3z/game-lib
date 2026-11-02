local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local v1 = nil

local function ControlEnableSwitch(p1) --[[ ControlEnableSwitch | Line: 5 | Upvalues: v1 (ref) ]]
	local PlayerModule = game.Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule")

	v1 = require(PlayerModule):GetControls()

	if p1 then
		v1:Enable()
	else
		v1:Disable()
	end
end

Lib.Inject("PlayerControlsEnabled", ControlEnableSwitch)

local function Jump() --[[ Jump | Line: 18 ]]
	game.Players.LocalPlayer.Character.Humanoid.Jump = true
end

Lib.Network:BindEvents({
	ControlEnableSwitch = ControlEnableSwitch,
	Jump = Jump
})

return {}