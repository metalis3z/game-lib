waterlevel = -0.5 -- Water level, in terms of height

repeat wait() until game.Players.LocalPlayer.Character ~= nil
local char = game.Players.LocalPlayer.Character

function makeswim()
	if char:FindFirstChild("SwimForce") == nil then
		local bp = Instance.new("BodyPosition")
		bp.Name = "SwimForce"
		bp.maxForce = Vector3.new(0,85000,0)
		bp.position = Vector3.new(0,waterlevel + 5,0)
		bp.Parent = char.Torso
	end
end

makeswim()

while true do
	if char.Torso:FindFirstChild("SwimForce")==nil then
		makeswim()
	end
	if char.Torso.Position.Y < waterlevel then
		if game.Players.LocalPlayer.Data.DevilFruit.Value ~= "None" then
			game.Players.LocalPlayer.Character.Humanoid.Health = game.Players.LocalPlayer.Character.Humanoid.Health - 3
			game.Players.LocalPlayer.Character.Torso.Anchored = true
			game.Players.LocalPlayer.Character.Torso.CFrame = game.Players.LocalPlayer.Character.Torso.CFrame * CFrame.new(0, -0.3, 0)
			if game.Players.LocalPlayer.Character.Humanoid.Health == 0 then
				game.Players.LocalPlayer.Character.Torso.SwimForce:Destroy()
				game.Players.LocalPlayer.Character.Torso.Anchored = false
				return
			end
		end
	else
		if char.Torso:FindFirstChild("SwimForce") then
			local c = char.Torso:GetChildren()
			for i = 1, #c do
				if c[i].Name == "SwimForce" then
					c[i]:Destroy()
				end
			end
		end
	end
	wait(0.1)
end
		