local holdAnim = 11265286747


repeat wait() until game.Players.LocalPlayer.Character
local lp = game.Players.LocalPlayer
local sp = script.Parent

local anim = Instance.new("Animation")
anim.AnimationId = "rbxassetid://" .. holdAnim
local holdtrack = lp.Character.Humanoid:LoadAnimation(anim)



sp.Equipped:connect(function()
	holdtrack:Play()
end)

sp.Unequipped:connect(function()
	holdtrack:Stop()
end)