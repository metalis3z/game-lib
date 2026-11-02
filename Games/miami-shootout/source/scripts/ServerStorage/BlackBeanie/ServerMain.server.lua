local tool=script.Parent
local handle=tool.Handle

local remotefunction=tool:WaitForChild("function")
local debris=game:GetService("Debris")
local char

tool.Equipped:Connect(function()
	char = script.Parent
end)

function remotefunction.OnServerInvoke(player,command,value)
	if command=="protect" then
		if value[2] then
			local currentvest=value[1]:FindFirstChild("VestArmour")
			if currentvest then
				currentvest:Destroy()
			end
			
			for i,v in pairs(value[1]:GetChildren()) do
				if v.ClassName == "Accessory" or v.Name == "Hat" or v.Name == "Beard" or v.Name == "Hair" then
					v.Handle.Transparency = 0
				end
			end	

			vest = game.ServerStorage.AccessoryHats["Black Beanie"]:Clone()
			value[1].Humanoid:AddAccessory(vest)
			
			local g = value[1]:WaitForChild("Head").Tag
			g.Enabled = true		
		end
	elseif command == "unprotect" then
			for i,v in pairs(value[1]:GetChildren()) do
				if v.ClassName == "Accessory" or v.Name == "Hat" or v.Name == "Beard" or v.Name == "Hair" then
					v.Handle.Transparency = 0
				end
			end
		vest:Remove()
		local g = value[1]:WaitForChild("Head").Tag
		g.Enabled = true
	elseif command == "drop" then
		for i,v in pairs(value[1]:GetChildren()) do
			if v.ClassName == "Accessory" or v.Name == "Hat" or v.Name == "Beard" or v.Name == "Hair" then
				v.Handle.Transparency = 0
			end
		end		
		if vest then
			vest:Destroy()
		end
		local g = value[1]:WaitForChild("Head").Tag
		g.Enabled = true	
	end
end