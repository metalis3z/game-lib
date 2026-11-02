
local tweenService = game:GetService("TweenService")
local TweenInfoo = TweenInfo.new(5,Enum.EasingStyle.Cubic,Enum.EasingDirection.InOut)
local Decompose = tweenService:Create(script.Parent,TweenInfoo,{Transparency = 1})
local Decompose3 = tweenService:Create(script.Parent.Engine2,TweenInfoo,{Transparency = 1})
local Decompose2 = tweenService:Create(script.Parent.PointLight,TweenInfoo,{Brightness = 0})
game.Workspace.The_Rake.NPC.Changed:Connect(function()
	if game.Workspace.The_Rake.NPC.Health == 0 then
		Decompose:Play()
		Decompose2:Play()
		Decompose3:Play()
		script.Parent.Box:Destroy()
		script.Parent.Beam.Enabled = false
		script.Parent.HatAttachment.Glow.Enabled = false
		script.Parent.AimScript:Destroy()
		wait(5)
		script.Parent:Destroy()
		end
end)