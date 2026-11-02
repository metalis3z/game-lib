--credit to leon games studio
--[[
	ServerFastFlags (reconstruido)
	El original no se exportó en el dump. Implementación mínima compatible con
	la API de ClientFastFlags: los flags devuelven siempre su valor default.
	También dispara SharedFastFlags.Update a los clientes para que su
	FastFlags.Loaded se marque como cargado.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)
local SharedFastFlags = require(ReplicatedStorage.UserGenerated.FastFlags.SharedFastFlags)
local DeepCopyPureUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepCopyPureUnsafe)
local DeepFreezeUnsafe = require(ReplicatedStorage.UserGenerated.Collections.DeepFreezeUnsafe)

local flagMethods = {}
local flagMeta = table.freeze({ __index = flagMethods })

function flagMethods.Get(flag)
	return flag.Value
end
function flagMethods.GetAsync(flag)
	return flag.Value
end
function flagMethods.IsLoaded()
	return true
end

table.freeze(flagMethods)

local flags = {}

local function create(key, assertion, default)
	assert(type(key) == "string", "key")
	if flags[key] then
		return flags[key]
	end
	if type(assertion) == "function" then
		pcall(assertion, default)
	end
	local defaultValue = DeepCopyPureUnsafe(default)
	DeepFreezeUnsafe(defaultValue)
	local flag = setmetatable({
		Replicated = true,
		Changed = Bindable.new(),
		Loaded = Bindable.new(),
		Key = key,
		DefaultValue = defaultValue,
		ValueLoaded = true,
		Value = defaultValue,
	}, flagMeta)
	flags[key] = flag
	return flag
end

local loadedSignal = Bindable.new()

local module = {
	Loaded = loadedSignal,
	IsA = function(value)
		return type(value) == "table" and getmetatable(value) == flagMeta
	end,
	Assert = function(value)
		assert(type(value) == "table" and getmetatable(value) == flagMeta, "FastFlag")
		return value
	end,
	Replicated = create,
	Private = create,
	Get = function(key)
		local flag = flags[key]
		if flag then
			return flag
		end
		error(("UnknownKey: '%s'"):format(tostring(key)))
	end,
	IsLoaded = function()
		return true
	end,
}

-- Marca a los clientes como "flags cargados" (contenido vacío = defaults)
local function sendToPlayer(player)
	SharedFastFlags.UpdateRemote:FireClient(player, {}, true)
end

Players.PlayerAdded:Connect(sendToPlayer)
for _, player in Players:GetPlayers() do
	task.spawn(sendToPlayer, player)
end

return table.freeze(module)