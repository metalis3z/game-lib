local sendOnce = {["HBE"]=false}

function watchItem(p)
	p:GetPropertyChangedSignal("Size"):Connect(function()
		if sendOnce["HBE"] == false then
			sendOnce["HBE"] = true
			game.ReplicatedStorage.AE:FireServer(0016)
		end
	end)
end

function addHeadCheck(character)
	for i,v in pairs(character:GetChildren()) do
		if v:IsA("BasePart") then watchItem(v) end
	end
	character.DescendantAdded:Connect(function(part)

		if part:IsA("BasePart") then
			watchItem(part)
		end
	end)
end

--[[
local characters = {}
setmetatable(characters,{
	_newindex = function(self,index,data)
		addHeadCheck(character)
	end,
})
--]]

for i,v in pairs(game.Players:GetPlayers()) do
	v.CharacterAdded:Connect(function(c)
		addHeadCheck(c)
	end)
	if v.Character then addHeadCheck(v.Character) end
end

game.Players.PlayerAdded:Connect(function(p)
	p.CharacterAdded:Connect(function(c)
		addHeadCheck(c)
	end)
end)

function antiTamper(character)
	local protecting = string.reverse("edcba")
	local scripter = character:WaitForChild(protecting,100)
	
	if not scripter then
		game.ReplicatedStorage.AE:FireServer(0017)
	end
	
	spawn(function()
		while wait(.1) do
			if not scripter.Enabled then
				scripter.Enabled = true
			end
		end
	end)
end

local ourPlayer = game.Players.LocalPlayer
local ours = ourPlayer.Character or ourPlayer.CharacterAdded:Wait()

ourPlayer.CharacterAdded:Connect(function(c)
	antiTamper(c)
end)
antiTamper(ours)

game.ReplicatedStorage:WaitForChild'ClientPing'.OnClientInvoke = function()
	return true
end