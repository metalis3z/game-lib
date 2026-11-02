local module = {}

local DataStore = game:GetService("DataStoreService"):GetDataStore("Aeternus")
local ServerUtil = require(game.ServerScriptService.Server.Modules.ServerUtil)
local HTTP = game:GetService("HttpService")

local safecall = ServerUtil.SafeCall
local ValueMap = {
	["boolean"] = "BoolValue",
	["string"]  = "StringValue",
	["BrickColor"] = "BrickColorValue",
	["Color3"]  = "Color3Value",
	["CFrame"]  = "CFrameValue",
	["Ray"]     = "RayValue",
	["Vector3"] = "Vector3Value",
	["number"] = "IntValue",
}

local function formatBytes(bytes)
	local units = {"B", "KB", "MB", "GB", "TB", "PB"}
	local size = bytes
	local unitIndex = 1

	while size >= 1024 and unitIndex < #units do
		size = size / 1024
		unitIndex = unitIndex + 1
	end

	if unitIndex == 1 then
		return string.format("%d %s", size, units[unitIndex])
	else
		return string.format("%.2f %s", size, units[unitIndex])
	end
end

local function GetValueBaseFromValue(val)
	if typeof(val) == "string" and #string.split(val, "NumVal") == 2 and tonumber(string.split(val, "NumVal")[1]) then
		return "NumberValue"
	elseif ValueMap[typeof(val)] then
		return ValueMap[typeof(val)]
	else
		return "StringValue", true
	end
end

local function GetTableFromFolder(Folder : Folder)
	local result = {}

	for _, v in ipairs(Folder:GetChildren()) do
		if v:IsA("Folder") then
			result[v.Name] = GetTableFromFolder(v)
		elseif v:IsA("ValueBase") then
			if v:IsA("NumberValue") and ((Folder.Parent and Folder.Parent.Name == "Purchased") or Folder.Name == "AchievementsData") then
				result[v.Name] = tostring(v.Value).."NumVal"
			else
				result[v.Name] = v.Value
			end
		end
	end

	return result
end

local DefaultEquipped = GetTableFromFolder(script.Template.Equipped)

local function ApplyDataToFolder(Data, Folder)
	for valueName, value in pairs(Data) do
		local matching = Folder:FindFirstChild(valueName)
		if matching then
			if typeof(value) == "table" and matching:IsA("Folder") then
				ApplyDataToFolder(value, matching)
			elseif typeof(value) ~= "table" and matching:IsA("ValueBase") then
				matching.Value = value
			end
		elseif Folder.Parent.Name == "Purchased" or Folder.Name == "AchievementsData" then
			local valueBase, unknownType = GetValueBaseFromValue(value)
			if valueBase == "NumberValue" then
				value = tonumber(string.split(value, "NumVal")[1])
			end
			if unknownType then
				warn(`[PLAYERDATA] Value type '{typeof(value)}' does not have a recognised ValueBase. Defaulting to StringValue.`)
				value = tostring(value)
			end
			local newValue = Instance.new(valueBase)
			newValue.Name = valueName
			newValue.Value = value
			newValue.Parent = Folder
		else
			warn(`[PLAYERDATA] Loading error: Could not apply value '{value}' to missing instance '{valueName}' in '{Folder:GetFullName()}'`)
		end
	end
end


module.LoadData = function(_, Player: Player)
	local _, Data = safecall(function()
		return DataStore:GetAsync("Data_"..Player.UserId)
	end)
	local PlayerData = script.Template:Clone()
	PlayerData.Name = "PlayerData"
	PlayerData.Parent = game.ServerStorage.Assets.Miscellaneous.TemporaryData
	if Data then
		if game["Run Service"]:IsStudio() then
			print(Data)
			print(`\n\n[PLAYERDATA] Loading {Player.Name}'s data\nSize: {formatBytes(HTTP:JSONEncode(Data):len())}`)
		end
		if not Data or not Data["Achievements"] then warn("[PLAYERDATA] Loading data failed.")
			PlayerData.Parent = Player
			return
		end
		safecall(ApplyDataToFolder, Data, PlayerData)
		PlayerData.Parent = Player
	else
		PlayerData.Parent = Player
	end
end

module.SaveData = function(_, Player: Player)
	if not Player:FindFirstChild("PlayerData") then warn(`[PLAYERDATA] Saving error: PlayerData not found for player {Player}`) return end
	local userID = Player.UserId
	local pData = Player:FindFirstChild("PlayerData"):Clone()
	pData.Parent = game.ServerStorage.Assets.Miscellaneous.TemporaryData
	safecall(function()
		for _, equipped : Instance in pairs(pData.Equipped:GetChildren()) do
			if equipped:IsA("StringValue") and (equipped.Name == "Killer" or equipped.Name == "Survivor") then
				local purchasedFolder = pData.Purchased:FindFirstChild(equipped.Name.."s")
				if not purchasedFolder then continue end
				if not purchasedFolder:FindFirstChild(equipped.Value) then
					equipped.Value = DefaultEquipped[equipped.Name]
				end
			elseif equipped:IsA("Folder") and equipped.Name == "Skins" then
				for _, skin : StringValue in pairs(equipped:GetChildren()) do
					if not skin:IsA("StringValue") then continue end
					if not pData.Purchased.Skins:FindFirstChild(skin.Value) then
						skin.Value = ""
					end
				end
			end
		end
	end)
	
	local ToSave = GetTableFromFolder(pData)
	if game["Run Service"]:IsStudio() then
		print(ToSave)
		print(`\n\n[PLAYERDATA] Saving {Player.Name}'s data\nSize: {formatBytes(HTTP:JSONEncode(ToSave):len())}`)
	end
	safecall(function()
		DataStore:UpdateAsync("Data_"..userID, function(OldDatas)
			return ToSave
		end)
	end)
	pData:Destroy()
end

return module