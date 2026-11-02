-- <- Init -> --
local Module = {}

-- <- Services -> --
local Datastore = game:GetService('DataStoreService');
local Client = game:GetService('ReplicatedStorage');
local Storage = game:GetService('ServerStorage');

-- <- Private Variable -> --
local StoreKey = Datastore:GetDataStore(`MeowIloveCatsAndLumeon_9`);
local StoringKey = 'froskaken3'

local Assets = Client.Assets

local LoadDatas = false

-- <- Functions -> --
local function RescursiveFind(Table, KeyLol)
	for Name, Value in pairs(Table) do
		if Name == KeyLol then
			return Value
		end
		--
		if typeof(Value) == "table" then
			return RescursiveFind(Value, KeyLol)
		end
	end
	--
	return false
end


function Module:Load(Player: Player)
	local Meow, GetAsync
	Meow, GetAsync = pcall(function()
		return StoreKey:GetAsync(`{StoringKey}_Player.UserId}`)
	end)
	local ClonedDatas = script.PlayerData:Clone()
	local leaderstats = script.leaderstats:Clone()
	if GetAsync then
		print(GetAsync)
	end
	if GetAsync then
		if not GetAsync or not GetAsync["Achievements"] then warn("Loading data failed.")
			ClonedDatas.Parent = Player
			leaderstats.Parent = Player return end
		for _, i in pairs(GetAsync["Achievements"]) do
			for v, ie in pairs(i) do
				if not ClonedDatas.Achievements:FindFirstChild(v,true) then break end
                ClonedDatas.Achievements:FindFirstChild(v,true).Value = ie
			end
		end
		for v, i in pairs(GetAsync["AchievementsData"]) do
			if not ClonedDatas.AchievementsData:FindFirstChild(v,true) then break end
			ClonedDatas.AchievementsData:FindFirstChild(v,true).Value = i
		end
		ClonedDatas.Equipped.Emotes.Value = GetAsync["Equipped"]["Emotes"]
		ClonedDatas.Equipped.Killer.Value = GetAsync["Equipped"]["Killer"]
		ClonedDatas.Equipped.Survivor.Value = GetAsync["Equipped"]["Survivor"]
		for v, i in pairs(GetAsync["Equipped"]["Skins"]) do
			if not ClonedDatas.Equipped.Skins:FindFirstChild(v,true) then break end
			ClonedDatas.Equipped.Skins:FindFirstChild(v,true).Value = i
		end
		ClonedDatas.Misc.LastSeenLog.Value = GetAsync["Misc"]["LastSeenLog"]
		for v, i in pairs(GetAsync["Purchased"]["Emotes"]) do
			local intval = Instance.new("IntValue",ClonedDatas.Purchased.Emotes)
			intval.Name = v
		end
		for v, i in pairs(GetAsync["Purchased"]["Killers"]) do
			local intval = Instance.new("NumberValue",ClonedDatas.Purchased.Killers)
			intval.Name = v
			intval.Value = i
		end
		for v, i in pairs(GetAsync["Purchased"]["Survivors"]) do
			local intval = Instance.new("NumberValue",ClonedDatas.Purchased.Survivors)
			intval.Name = v
			intval.Value = i
		end
		for v, i in pairs(GetAsync["Purchased"]["Skins"]) do
			if tonumber(i) then
				local intval = Instance.new("IntValue",ClonedDatas.Purchased.Skins)
				intval.Name = v
			end
		end
		for v, i in pairs(GetAsync["Settings"]) do
			for ve, ie in pairs(i) do
				if not ClonedDatas.Settings:FindFirstChild(ve,true) then break end
				ClonedDatas.Settings:FindFirstChild(ve,true).Value = ie
			end
		end
		for v, i in pairs(GetAsync["Stats"]) do
			for ve, ie in pairs(i) do
				if not ClonedDatas.Stats:FindFirstChild(ve,true) then break end
				ClonedDatas.Stats:FindFirstChild(ve,true).Value = ie
			end
		end
	end
	ClonedDatas.Parent = Player
	leaderstats.Parent = Player
end

function Module:Save(Player: Player)
	local SavingTable = {}
	for Index, Value in Player:GetDescendants() do 
		if Value:IsA('Folder') and (Value.Name ~= 'PlayerData' and Value.Name ~= 'leaderstats') then 
			if not SavingTable[Value.Parent.Name] and Value.Parent.Name ~= 'PlayerData' then 
				SavingTable[Value.Parent.Name] = {}
			end
			if Value.Parent.Name == 'PlayerData' then
				SavingTable[Value.Name] = {}
			else 
				SavingTable[Value.Parent.Name][Value.Name] = {}
			end
		end
	end
	for Index, Value in Player:GetDescendants() do 
		for TableName, Kitty in SavingTable do 
			if Value:IsA('ValueBase') and Value.Parent.Name == TableName then 
				Kitty[Value.Name] = Value.Value
			elseif Value:IsA('ValueBase') and Kitty[Value.Parent.Name] then 
				Kitty[Value.Parent.Name][Value.Name] = Value.Value
			end
		end
	end
	pcall(function()
		StoreKey:UpdateAsync(`{StoringKey}_Player.UserId}`, function(OldDatas)
			return SavingTable
		end)
	end)
end

-- <- Return -> --
return Module