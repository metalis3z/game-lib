local tool = script.Parent
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character
local humanoid

-- Coloque o ID da animação aqui
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://91261516251308"

local animationTrack
local equipped = false

-- Som dentro da Tool (renomeie se o nome for diferente)
local sound = tool:WaitForChild("Slash")

tool.Equipped:Connect(function()
	character = player.Character or player.CharacterAdded:Wait()
	humanoid = character:WaitForChild("Humanoid")

	animationTrack = humanoid:LoadAnimation(animation)
	equipped = true
end)

tool.Unequipped:Connect(function()
	equipped = false
	if animationTrack then
		animationTrack:Stop()
	end
end)

-- Detectar clique
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not equipped or gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then

		-- Tocar animação
		if animationTrack then
			if animationTrack.IsPlaying then
				animationTrack:Stop()
			end
			animationTrack:Play()
		end

		-- Tocar som
		if sound then
			sound:Play()
		end
	end
end)
