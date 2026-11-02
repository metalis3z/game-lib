local character = script.Parent
local player = game.Players:GetPlayerFromCharacter(character)

function checkBackpack(backpack)
	
	for i,v in pairs(character:GetChildren()) do
		if v.Name == "GUNBACKPACK" and v:IsA("Accessory") then
			v:Destroy()
		end
	end
	
	--if not backpack:FindFirstChild("M4A1") and not backpack:FindFirstChild("Draco") and not backpack:FindFirstChild("ARPistol") and not backpack:FindFirstChild("Remington") then return end
	
	if backpack:FindFirstChild("M4A1") then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("M4A1Back")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"

		character:FindFirstChild("Humanoid"):AddAccessory(clon)

		return
	end
	
	--[[
	if backpack:FindFirstChild("ARPDrum") then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("ARDrumBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"

		character:FindFirstChild("Humanoid"):AddAccessory(clon)

		return
	end
	--]]
	
	if backpack:FindFirstChild("Draco") then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("DracoBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"

		character:FindFirstChild("Humanoid"):AddAccessory(clon)
		
		return
	end
	if backpack:FindFirstChild("ARPistol") then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("ARPistolBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"

		character:FindFirstChild("Humanoid"):AddAccessory(clon)
		
       return
	end
	if backpack:FindFirstChild("Remington") then
		local bak = game.ServerStorage.BacksideGuns:FindFirstChild("RemingtonBack")
		local clon = bak:Clone()
		clon.Name = "GUNBACKPACK"
		
		character:FindFirstChild("Humanoid"):AddAccessory(clon)
		
		return
	end
end

function back()
	local backpack = player.Backpack
	-- in order
	checkBackpack(backpack)
end

player.Backpack.ChildAdded:Connect(back)
player.Backpack.ChildRemoved:Connect(back)