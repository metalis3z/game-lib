--> Variables
local _L = _G._L

local TableUtility
local Services
local Promise
local Signal
local User
local ProfileService
local ProfileStore
local Network
local DictionaryUtility
local ArrayUtility

--> Constants
	
------------->
local Data = {_objects = {}}
Data.__index = Data

function Data.Await(player, dontYield)
	local data = Data._objects[player]
	
	if data then
		return data
	elseif not dontYield then
		local newTrove = Trove.new()
		
		return Promise.new(function(resolve, reject)
			local data = Data._objects[player]

			if data then
				resolve(data)
				return
			end
			
			newTrove:Connect(Data.Added, function(addedData)
				if addedData._player == player then
					resolve(addedData)
				end
			end)

			newTrove:Connect(User.Removed, function(removedUser)
				if removedUser._player == player then
					reject()
				end
			end)
		end):finally(function()
			newTrove:Destroy()
		end):catch(warn):expect()
	end
end

function Data.Add(user)
	local player = user._player
	local data = Data._objects[player]
	
	if not data then
		local newData = Data.new(user)
		data = newData
	end
	
	return data
end

function Data.Remove(player)
	local data = Data._objects[player]

	if data then
		Data._objects[player] = nil
		data:Destroy()
	end
end

function Data.new(user)
	local self = setmetatable({}, Data)
	
	self._user = user
	self._player = self._user._player
	
	self._profile = nil
	self._tracker = nil
	
	self._trove = Trove.new()
	
	self:_construct()
	
	return self
end

function Data:_construct()
	self._trove:Add(function()
		if self._profile then
			self._profile:Release()
		else
			self._player:Kick()
		end
	end)
	
	local profileStore = ProfileStore:expect()
	local profile = (if Settings.data.mock and Services.RunService:IsStudio() then profileStore.Mock else profileStore):LoadProfileAsync("Player_" .. self._player.UserId, "ForceLoad")
	
	self._profile = profile
	
	if profile then
		profile:Reconcile()
		profile:ListenToRelease(function()
			self._player:Kick()
		end)

		if self._player:IsDescendantOf(Services.Players) and self._player then
			self._tracker = TableTracker.new(self._profile.Data)
			
			self._trove:Add(self._tracker:Bind({}, function(value, path)
				Network.Remote.FireAll("C_Data_Update", self._player, path, if path then TableUtility.deep.get(value, path) else value, tick())
				self._profile.Data = value
			end))
			
			Data._objects[self._player] = self
			Data.Added:Fire(self)
		else
			Data.Remove(self._player)
		end
	else
		Data.Remove(self._player)
	end
end

function Data:Get(path)
	return self._tracker:Get(path)
end

function Data:Set(path, value)
	return self._tracker:Set(path, value, path)
end

function Data:Bind(path, func)
	return self._tracker:Bind(path, func)
end

function Data:Track(path)
	return self._tracker:Track(path)
end

function Data:Destroy()
	self._trove:Destroy()
end

function Data._init()
	TableUtility = _L.Get {"Common", "Library", "Utilities", "TableUtility"}
	ArrayUtility = _L.Get {"Common", "Library", "Utilities", "ArrayUtility"}
	DictionaryUtility = _L.Get {"Common", "Library", "Utilities", "DictionaryUtility"}
	Services = _L.Get {"Common", "Library", "Services"}
	Trove = _L.Get {"Common", "Library", "Classes", "Trove"}
	Promise = _L.Get {"Common", "Library", "Classes", "Promise"}
	Signal = _L.Get {"Common", "Library", "Classes", "Signal"}
	User = _L.Get {"Server", "Modules", "Classes", "User"}
	ProfileService = _L.Get {"Server", "Library", "ProfileService"}
	Settings = _L.Get {"Common", "Modules", "Settings"}
	TableTracker = _L.Get {"Common", "Library", "Classes", "Tracker", "TableTracker"}
	Network = _L.Get {"Common", "Library", "Network"}
	
	Data.Added = Signal.new()
end

function Data._start()
	Network.Remote.Invoked("S_Data_Request", function(player)
		return DictionaryUtility.entries(DictionaryUtility.map(TableUtility.filter(Data._objects, function(k, v)
			return v._tracker ~= nil
		end), function(k, v)
			return nil, v._tracker:Get()
		end))
	end)
	
	ProfileStore = Promise.new(function(resolve, reject)
		resolve(ProfileService.GetProfileStore(Settings.data.key, Settings.data.template))
	end)
end

return Data