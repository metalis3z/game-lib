local Players = game:GetService("Players")

local RiotShieldConfig = game.ReplicatedStorage:WaitForChild("RiotShieldConfig")

local EquipRemote = RiotShieldConfig:WaitForChild("EquipShield")
local aHandle = RiotShieldConfig:WaitForChild("Handle")

EquipRemote.OnServerEvent:Connect(function(player, isOn)
	local char = player.Character
	
	if isOn == true then
		local tool = char:WaitForChild("Riot Shield")
		local Handle = tool:WaitForChild("Handle")
		Handle.Transparency = 1
		
		local Weld = Instance.new("Weld")
		Weld.Parent =  char
		Weld.Name = "RiotShieldWeld"
		
		local NewHandle = aHandle:Clone()
		NewHandle.Parent = Weld
		
		Weld.Part0 = NewHandle
		Weld.Part1 = char:WaitForChild("Left Arm")

		Weld.C0 = CFrame.new(0,1,0) * CFrame.Angles(0,math.rad(0),1.55) 
		Weld.C1 = CFrame.new(-0.5,0.3,0) * CFrame.Angles(0,math.rad(90),0)
	else
		local tool = char:WaitForChild("Riot Shield")
		local Handle = tool:WaitForChild("Handle")
		Handle.Transparency = 0
		
		local Weld = char:WaitForChild("RiotShieldWeld")
		Weld:Destroy()
	end
end)