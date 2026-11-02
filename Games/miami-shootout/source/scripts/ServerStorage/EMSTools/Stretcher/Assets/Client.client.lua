local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local tool = script.Parent.Parent
local idle = script.Parent.Idle

local folder = game.Workspace.PoliceCars

function togglePrompts(value)
	
	for i,v in pairs(folder:GetDescendants()) do
		if v.Name == "StretcherSeat" then
			v:FindFirstChild("Attachment"):FindFirstChild("ProximityPrompt").Enabled = value
		end
	end
	
end

local humanoid = character:WaitForChild("Humanoid")
local animation = humanoid:LoadAnimation(idle)

tool.Equipped:Connect(function()
	animation:Play()
	togglePrompts(true)
end)

tool.Unequipped:Connect(function()
	animation:Stop()
	togglePrompts(false)
end)