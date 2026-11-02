local Player = game.Players.LocalPlayer
local char = Player.Character

local UIS = game:GetService("UserInputService")

local stamina = 100
local isRunning = false
_G.globalRun = false

stamina = math.clamp(stamina, 0, 100)

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isRunning = true
		_G.globalRun = true
		--char.Humanoid.WalkSpeed = 20

		while stamina > 0 and isRunning do
			stamina = stamina -0.3
			script.Parent:TweenSize(UDim2.new(stamina/100, 0, 1, 0), "Out", "Linear",0)
			wait()
			if stamina <= 0 then
				char.Humanoid.WalkSpeed = 8
			end

		end
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.LeftShift then
		isRunning = false
		_G.globalRun = false
		--char.Humanoid.WalkSpeed = 8

		while stamina < 100 and not isRunning do
			stamina = stamina +1.2
			script.Parent:TweenSize(UDim2.new(stamina/100, 0, 1, 0), "Out", "Linear",0)
			wait()
			if stamina <= 0 then
				char.Humanoid.WalkSpeed = 8
			end

		end
	end
end)