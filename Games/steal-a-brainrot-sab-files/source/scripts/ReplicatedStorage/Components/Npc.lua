

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Packages = ReplicatedStorage:WaitForChild("Packages")
local Component = require(Packages.Component)
local Trove = require(Packages.Trove)
local Controllers = ReplicatedStorage:WaitForChild("Controllers")
local DialogController = require(Controllers.DialogController)
local Utils = ReplicatedStorage:WaitForChild("Utils")
local StringUtils = require(Utils.StringUtils)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear)
local _ = Players.LocalPlayer
local v13 = Component.new({
	Tag = "Npc"
})

function v13.Construct(p1)
	p1.Collector = Trove.new()
	p1.Hightlight = Instance.new("Highlight")
	p1.Hightlight.FillTransparency = 1
	p1.Hightlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	p1.Hightlight.OutlineTransparency = 1
	p1.Hightlight.DepthMode = Enum.HighlightDepthMode.Occluded
	p1.Hightlight.Parent = p1.Instance
	p1.ProximityPrompt = Instance.new("ProximityPrompt", p1.Instance)
	p1.ProximityPrompt.ActionText = "Talk"
	p1.ProximityPrompt.ObjectText = p1.Instance:GetAttribute("PromptObjectText") or ""
	p1.ShownTween = TweenService:Create(p1.Hightlight, tweenInfo, {
		OutlineTransparency = 0
	})
	p1.HiddenTween = TweenService:Create(p1.Hightlight, tweenInfo, {
		OutlineTransparency = 1
	})
	p1.DialogText = DialogController:GetDialogText()
	p1.DialogText.Parent = p1.Instance.PrimaryPart

	if p1.Instance:GetAttribute("IdlePath") then
		local v15 = StringUtils:ReadPath(ReplicatedStorage, p1.Instance:GetAttribute("IdlePath"))
		local v16 = p1.Instance:WaitForChild("Humanoid"):WaitForChild("Animator"):LoadAnimation(v15)

		v16.Looped = true
		v16:Play()
	end
end
function v13.Start(p2)
	p2.Collector:Add(p2.ProximityPrompt.Triggered:Connect(function()
		DialogController:StartDialog(p2.Instance:GetAttribute("Dialog"), p2.Instance:GetAttribute("Index"), p2.DialogText)
	end))
	p2.Collector:Add(p2.ProximityPrompt.PromptShown:Connect(function()
		p2.ShownTween:Play()
	end))
	p2.Collector:Add(p2.ProximityPrompt.PromptHidden:Connect(function()
		p2.HiddenTween:Play()
	end))
end
function v13.Stop(p3)
	p3.Collector:Destroy()
end

return v13
