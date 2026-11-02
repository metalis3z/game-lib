local tool = script.Parent
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local canPlay = true

-- Configurar animação
local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://134501421854459" -- substitua com um ID válido

local sound = tool:WaitForChild("Handle"):WaitForChild("LickSound") -- Certifique-se de que o Tool tenha um Sound

local function onClick()
	if canPlay and player.Character and tool.Parent == player.Character then
		canPlay = false

		local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			local animator = humanoid:FindFirstChildOfClass("Animator")
			if not animator then
				animator = Instance.new("Animator")
				animator.Parent = humanoid
			end

			local animationTrack = animator:LoadAnimation(animation)
			animationTrack:Play()
		end

		if sound then
			sound:Play()
		end

		task.wait(3) -- espera 2 segundos
		canPlay = true
	end
end

tool.Equipped:Connect(function()
	mouse.Button1Down:Connect(onClick)
end)
