-- <- Init -> --
local Module = {}
Module.__index = Module

-- <- Services -> --
local Client = game:GetService('ReplicatedStorage');

-- <- Modules -> --
local Initializer = require(Client.Initializer);
local Network = Initializer.Modules.Network;

-- <- Private Variables -> --
local Assets = Client.Assets

-- <- Functions -> --
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

function Module.Start()
	Network:SetConnection('PurchaseContent', 'REMOTE_FUNCTION', function(Player: Player, Item: Instance)
		return Module:Buy(Player, Item)
	end)
end

function Module:Buy(Player: Player, Item: Instance)
	local Config
	--
	if Item:IsA('ModuleScript') then
		Config = require(Item)
	elseif Item:IsA('Folder') and Item:FindFirstChild('Config') then
		Config = require(Item:FindFirstChild('Config'))
	end
	--
	local Type = GetType(tostring(Item.Name))
	--
	local Price = Config.Price
	if not Price then
		warn('No Price !') 
		return
	end
	--
	local PlayerData = Player:FindFirstChild('PlayerData')
	if not PlayerData then
		warn('No Datas !')
		return
	end
	--
	local Money = PlayerData.Stats.Currency:FindFirstChild("Money")
	if not Money then
		warn('No Currency ?') 
		return
	end
	--
	local Purchased = PlayerData:FindFirstChild('Purchased')
	if not Purchased then
		warn('No Folder Purchased') 
		return
	end
	--
	local FolderType = Purchased:FindFirstChild(Type)
	if not FolderType then
		warn('No Type Folder.')
		return 
	end
	--
	if FolderType:FindFirstChild(tostring(Item)) then
		return 'alreadyBought'
	end
	--
	if Money.Value - Price >= 0 then
		Money.Value -= Price
		--
		local NewValue = Instance.new('IntValue')
		NewValue.Name = tostring(Item)
		NewValue.Value = 0
		NewValue.Parent = FolderType
		--
		return 'success'
	end
	--
	return 'poor'
end

-- <- Return -> --
return Module