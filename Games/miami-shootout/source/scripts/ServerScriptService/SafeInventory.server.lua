local dataStore = game:GetService("DataStoreService"):GetDataStore("InvDataStore2")
local remote = game:GetService("ReplicatedStorage"):WaitForChild("Inventory")

local mps = game:GetService("MarketplaceService")
local doubleSafes = {}
local cache = require(game.ServerScriptService.ProfileCache)

game.Players.PlayerAdded:Connect(function(p)
	
	if mps:UserOwnsGamePassAsync(p.UserId,107203007) then
		doubleSafes[p] = true
	end
	
end)

local debounces = {}

function saveData(plr)
	local findFolder = plr:FindFirstChild("InvData")
	if findFolder then
		local saveTable = {}
		for i, v in pairs(findFolder:GetChildren())do
			saveTable[#saveTable + 1] = v.Name
		end
		cache[plr].Data.safeItemsF = saveTable
	end
end

game.Players.PlayerAdded:Connect(function(plr)
	
	--local folder = Instance.new("Folder", plr)
	--folder.Name = "InvData"
	
	--local getData = cache[plr].safeItems
	--local success = true
	
	--for i, v in pairs(getData) do
	--	local x = Instance.new("IntValue", folder)
	--	x.Name = v
	--end
	
	
end)

game:BindToClose(function()
	--for i, plr in pairs(game.Players:GetChildren())do
	--	saveData(plr)
	--end
end)

game.Players.PlayerRemoving:Connect(function(plr)
	--saveData(plr)
end)

local col = game:GetService("CollectionService")
_G.combatTimers = {}

local combatTimer = 10

local function GetDistance(p1,p2)
	local Distance = (p1.Position - p2.Position).magnitude
	return Distance
end

local verif = {}
local lastDb = {}

local blacklist = {"ARPBeam","Flash","Smoke","G22Drum","G19Beam","G22Switch","SMakarovE","Remington","MP5","G22Switch","Woods",".","M4A1","PDG2C","Handcuffs","BatteringRam","Taser","Baton","Machete"}

remote.OnServerEvent:Connect(function(plr, val, itemName, location, safeModel, toolExact)
	
	if game.PrivateServerOwnerId ~= 0 then
		return game.ReplicatedStorage.server:FireClient(plr,"alert","Disabled in VIP server.")
	end
	
	if table.find(blacklist,itemName) and plr.Team ~= game.Teams.Police then
		for i,v in pairs(plr:FindFirstChild("InvData"):GetChildren()) do
			if table.find(blacklist,v.Name) then
				v:Destroy()
			end
		end
		if plr.Character:FindFirstChild(itemName) then
			plr.Character:FindFirstChild(itemName):Destroy()
		end
		for i,v in pairs(plr.Backpack:GetChildren()) do
			if table.find(blacklist,v.Name) then
				v:Destroy()
			end
		end
		--if toolExact and (toolExact:IsA("Tool") and (toolExact.Parent == plr.Backpack or toolExact:IsDescendantOf(plr.Character))) then toolExact:Destroy() end
		return print("BLACKLIST")
	end
	
	if lastDb[plr] == itemName then
		print("LAST DB")
		print(lastDb[plr])
		print(itemName)
		return 
	end
	
	--[[
	if toolExact.Name ~= itemName and location == "Backpack" then 
		return print("probably safe exploiting #1")
	end
	if not toolExact:IsA("Tool") and location == "Backpack" then 
		return print("probably safe exploiting #2")
	end
	if (toolExact.Parent ~= plr.Backpack and not toolExact:IsDescendantOf(plr.Character)) and location == "Backpack" then 
		return print("probably safe exploiting #3")
	end
	--]]
	
	local found = game:GetService("ReplicatedStorage"):WaitForChild("Items"):FindFirstChild(itemName)
	lastDb[plr] = itemName
	delay(2,function()
		lastDb[plr] = nil
	end)
	
	if safeModel then
		local distanceBetweenTheTwo = GetDistance(plr.Character.PrimaryPart,safeModel:FindFirstChild("ChestClicker"))
	
		if distanceBetweenTheTwo > 7 then
			return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe (too far away)!")
		end
	else
		return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe!")
	end	
	
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		local human = plr.Character:FindFirstChild("Humanoid")
		
		if col:HasTag(plr,"cuffed") then
			return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe while handcuffed!")
		end
		--if col:HasTag(human,"combat") then
		if _G.combatTimers[human] then
			local timeLeft = string.gsub(tostring(math.round(_G.combatTimers[human] - time())),"-","")
			if tonumber(timeLeft) <= tonumber(combatTimer) then return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe while in combat ("..timeLeft.."/"..combatTimer.." seconds left)!") end
		end	--else
				--return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe while in combat!")
			--end
		--end
		if human.Health == 0 then
			return game.ReplicatedStorage.server:FireClient(plr,"alert","Can't access safe while dead!")
		end
	end	
		
	if val == "Change" then
		if location == "Backpack" and not debounces[plr.UserId] then
			if not found then return end

			local playerMax = 15
			
			if doubleSafes[plr] then
				playerMax = 32
			end

			local INVENTORY = plr:WaitForChild("InvData"):GetChildren()

			if #INVENTORY >= playerMax then
				return game.ReplicatedStorage.server:FireClient(plr,"alert","Your safe is full! ("..#INVENTORY.."/"..playerMax..")")
			end
			
			debounces[plr.UserId] = true
			delay(1.5,function()
				debounces[plr.UserId] = false
			end)
			local find = plr.Backpack:FindFirstChild(itemName)
			if find and not find:FindFirstChild("Rank") then
				if verif[find] then
					return print("anti dupe")
				end
				verif[find] = true
				find:Destroy()
				print("YIELD")
				repeat wait() until not find.Parent
				print("SUCCESS")
				local x = Instance.new("IntValue", plr:WaitForChild("InvData"))
				x.Name = itemName
			end
		elseif location == "Inv" and not debounces[plr.UserId] then
			debounces[plr.UserId] = true
			delay(1.5,function()
				debounces[plr.UserId] = false
			end)
			local find = game:GetService("ReplicatedStorage"):WaitForChild("Items"):FindFirstChild(itemName)
			if find and not table.find(blacklist,find.Name) then
				local get = plr:WaitForChild("InvData"):FindFirstChild(itemName)
				if not get then return end
				get:Destroy()
				print("YIELD")
				repeat wait() until not get.Parent
				print("SUCCESS")
				find:Clone().Parent = plr.Backpack
			end
		end
	end
end)