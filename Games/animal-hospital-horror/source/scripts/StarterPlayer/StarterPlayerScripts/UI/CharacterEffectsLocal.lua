local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local WhiteVignette = Lib.UI.Get("Vignette"):WaitForChild("WhiteVignette")

local function ApplySpeedEffect(p1, p2) --[[ ApplySpeedEffect | Line: 5 | Upvalues: WhiteVignette (copy) ]]
	local Character = game.Players.LocalPlayer.Character

	if not Character then
		return
	end

	local Humanoid = Character:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		return
	end

	if p1 > 1 then
		WhiteVignette.ImageColor3 = Color3.new(153/255, 255/255, 255/255)
		WhiteVignette.ImageTransparency = 0.55
	end

	Humanoid.WalkSpeed = Humanoid.WalkSpeed * p1
	task.wait(p2)
	Humanoid.WalkSpeed = Humanoid.WalkSpeed / p1
	WhiteVignette.ImageTransparency = 1
end

Lib.Inject("ApplySpeedEffect", ApplySpeedEffect)
Lib.Network:BindEvents({
	ApplySpeedEffect = ApplySpeedEffect
})

return {}