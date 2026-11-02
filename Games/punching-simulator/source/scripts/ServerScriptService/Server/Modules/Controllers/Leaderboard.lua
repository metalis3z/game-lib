--> Variables
local _L = _G._L

local Services
local Maid
local Network
local Audio
local TableUtility
local Leaderboards

--> Constants

------------->
local Leaderboard = {_objects = {}}
Leaderboard.__index = Leaderboard

function Leaderboard._init()
	Services = _L.Get {"Common", "Library", "Services"}
	Maid = _L.Get {"Common", "Library", "Classes", "Maid"} 
	Network = _L.Get {"Common", "Library", "Network"}
	Audio = _L.Get {"Common", "Library", "Audio"}
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	Leaderboards = _L.Get {"Server", "Modules", "Databases", "Leaderboards"}
	NumberUtils = _L.Get {"Common", "Library", "Utilities", "NumberUtility"}
end

function Leaderboard._start()
	task.spawn(function()
		for _, leaderboardInstance in pairs(_L.Map.Leaderboards:GetChildren()) do
			local leaderboardName = leaderboardInstance.Name
			Leaderboard.new({ instance = leaderboardInstance, name = leaderboardName })
		end
		
		task.spawn(function()
			while task.wait(5) do
				for _, leaderboard in pairs(Leaderboard._objects) do
					leaderboard:Update()
				end

				task.wait(60)
			end
		end)
	end)
end

function Leaderboard.new(props)
	local self = setmetatable({}, Leaderboard)
	
	self._instance = props.instance
	self._name = props.name
	
	self._info = Leaderboards[self._name]
	self._data = Services.DataStoreService:GetOrderedDataStore("Leaderboard_"..self._name)
	
	self._maid = Maid.new()
	
	self:_construct()

	return self
end

function Leaderboard:_construct()
	Leaderboard._objects[self._instance] = self

	self._maid:GiveTask(function()
		Leaderboard._objects[self._instance] = nil
	end)
	
	self:_setup()
end

function Leaderboard:_setup()
end

function Leaderboard:_update_visual()
	for _, child in pairs(self._instance.Screen.SurfaceGui.ScrollingFrame:GetChildren()) do
		if child:IsA("Frame") then
			child:Destroy()
		end
	end
	
	local sortedData

	local success, result = pcall(function()
		sortedData = self._data:GetSortedAsync(false, 50)
	end)

	if not success then
		warn(result)
	end

	if sortedData then
		local page = sortedData:GetCurrentPage()

		for rank, data in pairs(page) do
			local userId = data.key
			local value = data.value
			local retrievedValue = math.round(value ~= 0 and (1.0000001^value) or 0)

			local newCellTemplate = _L.Assets.UI.Leaderboard.CellTemplate:Clone()

			newCellTemplate.Parent = self._instance.Screen.SurfaceGui.ScrollingFrame
			newCellTemplate.Name = tostring(rank)
			newCellTemplate.Rank.TextLabel.Text = "#".. tostring(rank)

			local success, result = pcall(function()
				return Services.UserService:GetUserInfosByUserIdsAsync({tonumber(userId)})
			end)

			if rank == 1  then
				newCellTemplate.Rank.ImageColor3 = Color3.fromRGB(255, 215, 0)
			elseif rank == 2  then
				newCellTemplate.Rank.ImageColor3 = Color3.fromRGB(165, 165, 165)
			elseif rank == 3  then
				newCellTemplate.Rank.ImageColor3 = Color3.fromRGB(205, 127, 50)
			else
				newCellTemplate.Rank.ImageColor3 = Color3.fromRGB(0, 171, 221)
			end

			if success and result and result[1] and result[1].Username then
				newCellTemplate.User.TextLabel.Text = result[1].Username
			else
				newCellTemplate.User.TextLabel.Text = "???"
			end

			newCellTemplate.Value.TextLabel.Text = if self._info.format_callback then self._info.format_callback(retrievedValue) else NumberUtils.short(retrievedValue)
		end
	end
end

function Leaderboard:Update()
	for player, client in pairs(Network.Bindable.Invoke("S_Client_GetAll") or {}) do
		task.spawn(function()
			local success, result = pcall(function()
				self._data:UpdateAsync(player.UserId, function(oldValue)
					local value = self._info.grab_callback(client)
					local storedValue = value ~= 0 and math.floor(math.log(value) / math.log(1.0000001)) or 0
					return math.floor(storedValue)
				end)
			end)

			if not success then
				warn(result)
			end
		end)
	end

	self:_update_visual()
end

function Leaderboard:Destroy()
	self._maid:Destroy()
end

return Leaderboard