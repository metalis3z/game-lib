local tool = script.Parent
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local character
local humanoid

-- Animação
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://91261516251308"

local animationTrack
local equipped = false

-- Som
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

-- Clique
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not equipped or gameProcessed then
		return
	end

	if input.UserInputType == Enum.UserInputType.MouseButton1 
		or input.UserInputType == Enum.UserInputType.Touch then

		-- ▶️ Toca animação
		if animationTrack then
			if animationTrack.IsPlaying then
				animationTrack:Stop()
			end
			animationTrack:Play()
		end

		-- 🔊 Toca som
		if sound then
			sound:Play()
		end

		-- ✨ Ativa partícula
		if particle then
			particle.Enabled = true

			-- Desativar depois de 0.3s (pode ajustar)
			task.delay(0.3, function()
				particle.Enabled = false
			end)
		end
	end
end)
