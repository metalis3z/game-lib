-- Please don't edit anything in this script unless you know how to code :)
-- Created by devTools

--Checking if everything has been moved yet
model = nil

if script.Parent.Name == "Uniform Exchange - READ INSTRUCTIONS" then
	model = script.Parent
	script.Parent = game.ReplicatedStorage
end
if model ~= nil then
	if model:findFirstChild("Hats") then
		model:findFirstChild("Hats").Parent = game.ReplicatedStorage
	end
	if model:findFirstChild("USM Exchange") then
		model:findFirstChild("USM Exchange").Parent = game.StarterGui
	end
	if model:findFirstChild("ModelImage") then
		model:findFirstChild("ModelImage"):Destroy()
	end
	model:Destroy()
	model = nil
end

--To put the uniform on
script.Wear.OnServerEvent:connect(function(plr,args,coveronly)
	--Make sure player is loaded in
	repeat wait() until plr:HasAppearanceLoaded()
	
	--Remove packages
	if plr.Character:findFirstChildOfClass("CharacterMesh") then
		for i,v in pairs(plr.Character:GetChildren()) do
			if v:isA("CharacterMesh") then
				v:Destroy()
			end
		end
	end
	
	--Remove current covers
	for i,v in pairs(plr.Character:GetChildren()) do
		if (v:isA("Model") and v.Name == "CurrHats") then
			v:Destroy()
		end
	end
	--Remove Cover GUI
	if plr.PlayerGui:findFirstChild("UniformGui") then plr.PlayerGui.UniformGui:Destroy() end
	--Put on new hats
	if args[4] then
		local newHats = args[4]:clone()
		newHats.Parent = plr.Character
		newHats.Name = "CurrHats"
		newHats.Middle.Anchored = true
		for o,p in pairs(newHats:GetChildren()) do
			for q,w in pairs(p:GetChildren()) do
				if w:isA("Weld") then
					w:Destroy()
				end
			end
		end
		if newHats.Middle:findFirstChildOfClass("Decal") then
			newHats.Middle:findFirstChildOfClass("Decal"):Destroy()
		end
		for j,k in pairs(newHats:GetChildren()) do
			if k:isA("Part") or k:isA("UnionOperation") or k:isA("MeshPart") then
				local W = Instance.new("Weld")
				W.Part0 = newHats.Middle
				W.Part1 = k
				local CJ = CFrame.new(newHats.Middle.Position)
				local C0 = newHats.Middle.CFrame:inverse()*CJ
				local C1 = k.CFrame:inverse()*CJ
				W.C0 = C0
				W.C1 = C1
				W.Parent = newHats.Middle
				newHats.Middle.Transparency = 1
			end
			local Y = Instance.new("Weld")
			Y.Part0 = plr.Character.Head
			Y.Part1 = newHats.Middle
			Y.C0 = CFrame.new(0, 0, 0)
			Y.Parent = Y.Part0
		end
		for o,p in pairs(newHats:GetChildren()) do
			p.Anchored = false
			p.CanCollide = false
		end
		--Add new Cover GUI
		script.UniformGui:clone().Parent = plr.PlayerGui
	end
	--Put on clothes
	if coveronly == "no" then
		if plr.Character:findFirstChildOfClass("Shirt") then
			plr.Character.Shirt.ShirtTemplate = args[2]
		else
			local shirt = Instance.new("Shirt",plr.Character)
			shirt.ShirtTemplate = args[2]
		end
		if plr.Character:findFirstChildOfClass("Pants") then
			plr.Character.Pants.PantsTemplate = args[3]
		else
			local pants = Instance.new("Pants",plr.Character)
			pants.PantsTemplate = args[3]
		end
	end
end)

script.UniActions.OnServerEvent:connect(function(plr,action)
	local hat = plr.Character.CurrHats:FindFirstChild("Hat")
	if hat == nil then
		for i,v in pairs(plr.Character.CurrHats:GetChildren()) do
			if v.Name ~= "Middle" and v.Name ~= "Logo" then
				hat = v
			end
		end
	end
	
	if action == "toggle" then
		--Checks if the hat is on or not and adjusts accordingly to toggle it
		if hat.Transparency == 0 then
			if hat:findFirstChildOfClass("Texture") or hat:findFirstChildOfClass("Decal") then
				for i,v in pairs(hat:GetChildren()) do
					if v:isA("Texture") or v:isA("Decal") then
						v.Transparency = 1
					end
				end
			end
			for i,v in pairs(hat.Parent:GetChildren()) do
				if (v:isA("Part") or v:isA("UnionOperation") or v:isA("MeshPart")) and v.Name ~= "Middle" and v.Name ~= "Logo" then
					v.Transparency = 1
				end
				if v:findFirstChildOfClass("Texture") or v:findFirstChildOfClass("Decal") then
					for j,k in pairs(v:GetChildren()) do
						if k:isA("Texture") or k:isA("Decal") then						
							k.Transparency = 1
						end
					end
				end
			end
		else
			if hat:findFirstChildOfClass("Texture") or hat:findFirstChildOfClass("Decal") then
				for i,v in pairs(hat:GetChildren()) do
					if v:isA("Texture") or v:isA("Decal") then
						v.Transparency = 0
					end
				end
			end
			for i,v in pairs(hat.Parent:GetChildren()) do
				if (v:isA("Part") or v:isA("UnionOperation") or v:isA("MeshPart")) and v.Name ~= "Middle" and v.Name ~= "Logo" and v.Name ~= "Bill" then
					v.Transparency = 0
				elseif (v:isA("Part") or v:isA("UnionOperation") or v:isA("MeshPart")) and v.Name == "Bill" then 
					v.Transparency = 0.001 
				end
				if v:findFirstChildOfClass("Texture") or v:findFirstChildOfClass("Decal") then
					for j,k in pairs(v:GetChildren()) do
						if k:isA("Texture") or k:isA("Decal") then						
							k.Transparency = 0
						end
					end
				end
			end
		end
	elseif action == "remove uniform" then
		local origHumDesc = game:GetService("Players"):GetHumanoidDescriptionFromUserId(plr.UserId)
		local humAccessories = {}
		
		for i,v in next, string.split(origHumDesc.BackAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.FaceAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.FrontAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.HairAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.HatAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.NeckAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.ShouldersAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		for i,v in next, string.split(origHumDesc.WaistAccessory,",") do if v ~= "" and v ~= nil then table.insert(humAccessories,v) end end
		
		for i,v in next, plr.Character:GetChildren() do
			if v:IsA("Shirt") or v:IsA("Pants") or v:IsA("ShirtGraphic") or v:IsA("Accessory") then
				v:Destroy()
			end
		end
		
		for i,v in next, humAccessories do
			local hat = game:GetService("InsertService"):LoadAsset(tonumber(v))
			plr.Character.Humanoid:AddAccessory(hat:FindFirstChildOfClass("Accessory"))
		end
		
		if origHumDesc.Shirt ~= 0 then
			local shirt = game:GetService("InsertService"):LoadAsset(origHumDesc.Shirt)
			shirt.Shirt.Parent = plr.Character
		end
		if origHumDesc.Pants ~= 0 then
			local pants = game:GetService("InsertService"):LoadAsset(origHumDesc.Pants)
			pants.Pants.Parent = plr.Character
		end
		if origHumDesc.GraphicTShirt ~= 0 then
			local tshirt = game:GetService("InsertService"):LoadAsset(origHumDesc.GraphicTShirt)
			if tshirt:findFirstChild("Shirt Graphic") then
				tshirt["Shirt Graphic"].Parent = plr.Character
			end
		end
		
		if plr.PlayerGui:findFirstChild("UniformGui") then plr.PlayerGui.UniformGui:Destroy() end
		if plr.Character:findFirstChild("CurrHats") then plr.Character.CurrHats:Destroy() end
	elseif action == "remove hats" then
		for i,v in pairs(plr.Character:GetChildren()) do
			if v:isA("Accessory") then
				v:Destroy()
			end
		end
	elseif action == "remove tshirt" then
		if plr.Character:FindFirstChildOfClass("ShirtGraphic") then
			plr.Character:FindFirstChildOfClass("ShirtGraphic"):Destroy()
		end
	end
end)

--Created by devTools