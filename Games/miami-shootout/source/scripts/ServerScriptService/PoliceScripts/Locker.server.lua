local lockerRemote = game.ReplicatedStorage.Locka
local emsLocker = game.ReplicatedStorage.Locka2
local policeGroup = 33094763
local FBIGroup = 16377014
local esuGroup = 16383488

local emsGroup = 16508461

for i,v in pairs(game.Workspace.PDLockers:GetChildren()) do
	local prompt = v:FindFirstChild("main"):FindFirstChild("ProximityPrompt")
	prompt.Triggered:Connect(function(p)
		if p.Team == game.Teams.Police then
			game.ReplicatedStorage.server:FireClient(p,"togglelocker") 
			v:FindFirstChild("main"):FindFirstChild("open"):Play()
		end
	end)
end

for i,v in pairs(game.Workspace.EMSLockers:GetChildren()) do
	local prompt = v:FindFirstChild("main"):FindFirstChild("ProximityPrompt")
	prompt.Triggered:Connect(function(p)
		if p.Team == game.Teams.EMS then
			game.ReplicatedStorage.server:FireClient(p,"toggleemslocker") 
			v:FindFirstChild("main"):FindFirstChild("open"):Play()
		end
	end)
end

for i,v in pairs(game.ServerStorage.PoliceTools:GetChildren()) do
	if not v:FindFirstChild("Rank") then
		print("ADDED RANK TO "..v.Name)
		Instance.new("NumberValue",v).Name = "Rank"
	end
end

-- BUILD
-- Item Name; Rank Required
local policeLocker = {
	["Remington"] = 5, -- sergeant
	["M4A1"] = 6, -- lt
	["Ammo Box"] = 2, -- cadet
	["Handcuffs"] = 2, -- cadet
	["Taser"] = 2, -- cadet
	--["PDG2C"] = 3, -- officer
	["Five-Seven"] = 3,
	["Glock19"] = 2, -- cadet
	["BatteringRam"] = 4, -- sr officer
	["RiotShield"] = 3, -- officer
	["Baton"] = 2, -- cadet
	["Donut"] = 2, -- cadet
	["PepperSpray"] = 4 -- sr officer
}

local fbiLocker = {
	["M4A1"] = 2,
	["Ammo Box"] = 2,
	["Handcuffs"] = 2,
	["Taser"] = 2, 
	--["PDG2C"] = 2, 
	["Glock19"] = 2,
	["BatteringRam"] = 2,
	["RiotShield"] = 2, 
	["Baton"] = 2,
	["Donut"] = 2,
}

local esuGear = {
	["MP5"] = 3, -- not out yet
	["Hats"] = game.ServerStorage.Hats.ESU:GetChildren(),
	["RiotShield"] = 3, -- team one
	["BatteringRam"] = 3, -- team one
	["Five-Seven"] = 3, -- team one
	--["G2CNYPD"] = 3, -- team one
}

local emsGear = {
	["Medkit"] = 2, -- PB medic
	["Bandage"] = 2, -- PB medic
	["Taser"] = 3, -- paramedic
	["Glock19"] = 5, -- combat medic
	["AED"] = 4, -- SR medic
	["Stretcher"] = 2 -- PB medic
}

game.Workspace.ESUGear.ClickDetector.MouseClick:Connect(function(p)
	
	if p.Team ~= game.Teams.Police then
		return
	end
	
	if not p:IsInGroup(esuGroup) then return game.ReplicatedStorage.server:FireClient(p,"alert","You are not in ESU.") end
	if p:GetRankInGroup(esuGroup) <= 2 then return game.ReplicatedStorage.server:FireClient(p,"alert","You have not been assigned a team.") end
	
	if p.Character:FindFirstChild("PoliceVest") then return game.ReplicatedStorage.server:FireClient(p,"alert","You have a police vest on.") end
	if p.Character:FindFirstChild("FBIVest") then return game.ReplicatedStorage.server:FireClient(p,"alert","You have an FBI vest on.") end

	game.Workspace.ESUGear.equipped:Play()
	
	local rank = p:GetRankInGroup(esuGroup)
	
	for i,v in pairs(esuGear) do
		if i == "Hats" then
			for ind,hat in pairs(v) do
				if not p.Character:FindFirstChild(hat.Name) then
					p.Character.Humanoid:AddAccessory(hat:Clone())
				end
			end
		else
			
			if rank >= v and not p.Backpack:FindFirstChild(i) and game.ServerStorage.PoliceTools:FindFirstChild(i) then
				game.ServerStorage.PoliceTools:FindFirstChild(i):Clone().Parent = p.Backpack
			end
			
		end
	end
	
	if p.Character.Humanoid.MaxHealth ~= 200 then
		p.Character.Humanoid.MaxHealth = 200
		p.Character.Humanoid.Health = 200
	end
	
end)

game.Workspace.RemoveRankTag.ClickDetector.MouseClick:Connect(function(p)
	
	if p:IsInGroup(16417996) and p.Team == game.Teams.Police then
		
		p.Character:FindFirstChild("Head"):FindFirstChild("POLICE_RANK").Enabled = not p.Character:FindFirstChild("Head"):FindFirstChild("POLICE_RANK").Enabled
		
		if not p.Backpack:FindFirstChild("DetectiveBadge") then
			game.ServerStorage.PoliceTools:FindFirstChild("DetectiveBadge"):Clone().Parent = p.Backpack
		end
		
	end
	
end)

local rankNames = nil
local emsRankNames = nil

local CIAGroup = 16723422

lockerRemote.OnServerEvent:Connect(function(p,itemName)
	
	if p.Team ~= game.Teams.Police then return end
	
	local item = game.ServerStorage.PoliceTools:FindFirstChild(itemName)
	if not item then return end
	
	local rankInGroup = p:GetRankInGroup(policeGroup)
	
	--rankInGroup = 1
	if p.UserId == -1 then
		rankInGroup = 255
	end
	
	if itemName == "Smoke" or itemName == "Flash" then
		local FBIMember = p:IsInGroup(FBIGroup)
		local CIAMember = p:IsInGroup(CIAGroup)
		local ESUMember = p:IsInGroup(esuGroup)
		
		if not FBIMember and not CIAMember and not ESUMember then
			return game.ReplicatedStorage.server:FireClient(p,"alert","This item requires you to be in FBI, CIA, or ESU!")
		else
			if not p.Backpack:FindFirstChild(itemName) and not p.Character:FindFirstChild(itemName) then
				item:Clone().Parent = p.Backpack
			end	
			return
		end
	end
	
	if rankInGroup >= policeLocker[itemName] then
		if not p.Backpack:FindFirstChild(itemName) and not p.Character:FindFirstChild(itemName) then
			item:Clone().Parent = p.Backpack
		end
	else
		
		if fbiLocker[itemName] then
			if p:GetRankInGroup(FBIGroup) >= fbiLocker[itemName] then
				print("has fbi, let them have it")
				if not p.Backpack:FindFirstChild(itemName) and not p.Character:FindFirstChild(itemName) then
					item:Clone().Parent = p.Backpack
				end
				return
			end
		end
		
		local rankRequired = "Unknown"
		
		if rankNames ~= nil then
			rankRequired = rankNames[policeLocker[itemName]].Name
		end
		
		return game.ReplicatedStorage.server:FireClient(p,"alert","Not a high enough rank ("..rankRequired.."+ required)!")
	end
	
end)

emsLocker.OnServerEvent:Connect(function(p,itemName)

	if p.Team ~= game.Teams.EMS then return end

	local item = game.ServerStorage.EMSTools:FindFirstChild(itemName)
	if not item then return end

	local rankInGroup = p:GetRankInGroup(emsGroup)

	--rankInGroup = 1
	if p.UserId == -1 then
		rankInGroup = 255
	end

	if rankInGroup >= emsGear[itemName] then
		if not p.Backpack:FindFirstChild(itemName) and not p.Character:FindFirstChild(itemName) then
			item:Clone().Parent = p.Backpack
		end
	else
		local rankRequired = "Unknown"

		if emsRankNames ~= nil then
			rankRequired = emsRankNames[policeLocker[itemName]].Name
		end

		return game.ReplicatedStorage.server:FireClient(p,"alert","Not a high enough rank ("..rankRequired.."+ required)!")
	end

end)

function getGroupInfo()
	local groupService = game:GetService("GroupService")

	local info = groupService:GetGroupInfoAsync(policeGroup)
	-- got info

	rankNames = info.Roles
end
getGroupInfo()

function getGroupInfo2()
	local groupService = game:GetService("GroupService")

	local info = groupService:GetGroupInfoAsync(emsGroup)
	-- got info

	emsRankNames = info.Roles
end
getGroupInfo2()