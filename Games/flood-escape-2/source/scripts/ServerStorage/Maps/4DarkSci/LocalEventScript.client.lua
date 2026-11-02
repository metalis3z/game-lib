local map = workspace.Multiplayer:WaitForCild("Map")
local lavaImg, lavaImg2 = map:WaitForChild("_Water1"):WaitForChild("Lava"):WaitForChild("Holder"):WaitForChild("Frame"), map:WaitForChild("_Water2"):WaitForChild("Lava"):WaitForChild("Holder"):WaitForChild("Frame")
local player = game.Players.LocalPlayer
local hum = player.Character:WaitForChild("Humanoid")
local hardwares = player.Character:WaitForChild("Hardware"):GetChildren()
for _, c in pairs(hardwares) do
		local newCol = Instance.new("Color3Value")
		newCol.Value = c.Color
		newCol.Name = "OC"
		newCol.Parent = c
end
function exproshun()
		spawn (function()
				local duration = math.random(10, 20) * 0.1
				local intensity = math.random(5, 10) * 0.1
				local snd = Instance.new("Sound")
				local vol = 0.35 * intensity
				snd.SoundId = "rbxassetid://153274423"
				snd.Pitch = math.random(90, 110) * 0.01
				snd.Volume = vol
				snd.Parent = script
				game.Debris:AddItem(snd, 3)
				snd:Play()
				local fin = tick() + duration
				while game:GetService("RunService").RenderStepped:wait() and fin - tick() > 0 and 0 < hum.Health do
						snd.Volume = vol * (fin - tick())
						hum.CameraOffset = Vector3.new(math.random(-5, 5) * 0.05 * (fin - tick()), math.random(-5, 5) * 0.05 * (fin - tick()), math.random(-5, 5) * 0.05 * (fin - tick()))
				end
				
		end)
end       

hum.Died:connect(function()
		hum.CameraOffset = Vector3.new()
end)
spawn (function()
		while wait(math.random9(3, 8)) do
				exproshun()
		end
end)
while game:GetService("RunService").Heartbeat:wait() do
		local sin, rad = math.sin, math.rad
		local t = tick()
		lavaImg.Position = UDim2.new(-(t * 0.03 - math.floor(t * 0.02)), 0, -(t * 0.02 - math.floor(t * 0.02)), 0)
		lavaImg2.Position = UDim2.new(-(t * 0.03 - math.floor(t * 0.03)), 0, -(t * 0.03 - math.floor(t * 0.03)), 0)
		local snd = game.Players.LocalPlayer.PlayerScripts.CL_MAIN_GameScript:FindFirstChild("BGM")
		if snd then
				const = 1.875
				local i = 1 - (snd.TimePosition / const - math.floor(snd.TimePosition / const))
				for _, c in pairs(map.Hardware:GetChildren()) do
						if c and c:IsA("BasePart") then
								c.Color = Color3.new(c.OC.Value.r * i, c.OC.Value.g * i, c.OC.Value.b * i)
						end
				end
		end
end