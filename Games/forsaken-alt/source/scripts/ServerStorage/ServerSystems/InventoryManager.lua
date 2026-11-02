-- <- Init -> --
local Module = {}

-- <- Services -> --
local Client = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local Initializer = require(Client.Initializer);
local Network = Initializer.Modules.Network;
local Util = Initializer.Modules.Util;

-- <- Private Variables -> --
local Assets = Client.Assets

-- <- Function -> --
function GetType(Name: string)
	for Index, Value in Assets:GetChildren() do 
		if Value:IsA('Folder') then
			for _, Value2 in Value:GetChildren() do 
				if Value2.Name == Name then
					return Value.Name
				end
			end
		end
	end
	--
	for Index, Value in Assets:FindFirstChild('Skins'):GetDescendants() do 
		if Value.Name == Name then 
			return 'Skins'
		end
	end
	--
	return 'None'
end

function GetFolder(Name: string)
	for Index, Value in Assets:GetChildren() do 
		if Value:IsA('Folder') then
			for _, Value2 in Value:GetChildren() do 
				if Value2.Name == Name then
					return Value
				end
			end
		end
	end
	--
	for Index, Value in Assets:FindFirstChild('Skins'):GetDescendants() do 
		if Value.Name == Name then 
			return Value
		end
	end
end

function Module.Start()
	Network:SetConnection('EquipContent', 'REMOTE_EVENT', function(Player: Player, Item: string, ...)
		local StringItem = tostring(Item)
		local Type = GetType(StringItem)
		if Type == 'None' then
			return 
		end
		--
		local PlayerData = Player:FindFirstChild('PlayerData')
		if not PlayerData then 
			return
		end
		--
		local Equipped = PlayerData:FindFirstChild('Equipped')
		if not Equipped then 
			return 
		end
		--
		local Purchased = PlayerData:FindFirstChild('Purchased')
		if not Purchased then
			return 
		end
		--
		if Type == 'Emotes' then
			local Place = {...}
			Place = Place[1]
			--
			local Emotes = Equipped:FindFirstChild('Emotes')
			if not Emotes then
				return 
			end
			--
			local SlippedString = string.split(Emotes.Value, '|')
			--
			SlippedString[Place] = StringItem
			--
			Emotes.Value = table.concat(SlippedString, '|')
		elseif Type == 'Skins' then
			local SkinFolder = GetFolder(StringItem)
			if not SkinFolder then
				return 
			end
			--
			local ActualActor = SkinFolder.Parent
			if not ActualActor then
				return
			end
			--
			local EquippedValue = Equipped:FindFirstChild('Skins')
			if not EquippedValue then
				return
			end
			--
			local PurchasedSkins = Purchased:FindFirstChild('Skins')
			if not PurchasedSkins then 
				return
			end
			--
			local ActorValueSkin = EquippedValue:FindFirstChild(tostring(ActualActor))
			--
			if not PurchasedSkins:FindFirstChild(StringItem) then
				return 
			end
			--
			if ActorValueSkin.Value == StringItem then
				ActorValueSkin.Value = ''
			else 
				ActorValueSkin.Value = StringItem
			end
		elseif (Type == 'Killers' or 'Survivors') then 
			local EquippedValue = (Type == 'Killers' and Equipped:FindFirstChild('Killer')) or Equipped:FindFirstChild('Survivor')
			if not EquippedValue then
				return
			end
			--
			local PurchasedActors = (Type == 'Killers' and Purchased:FindFirstChild('Killers')) or Purchased:FindFirstChild('Survivors')
			if not PurchasedActors then 
				return
			end
			--
			if PurchasedActors:FindFirstChild(StringItem) then 
				EquippedValue.Value = StringItem
			end
		end
	end)
end

-- <- Return -> --
return Module