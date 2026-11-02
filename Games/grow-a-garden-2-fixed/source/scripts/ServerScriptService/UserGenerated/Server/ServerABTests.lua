--credit to prince games studio
--[[
	ServerABTests (reconstruido)
	El original no se exportó. API mínima compatible con ClientABTests:
	sin asignaciones — todos los GetAttribute devuelven el default.
	(GameServer es quien manda SharedABTests.Update a los clientes.)
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Bindable = require(ReplicatedStorage.UserGenerated.Concurrency.Bindable)

local EMPTY = table.freeze({})

local function GetAttributes()
	return EMPTY
end

local function GetAttribute(_player, _name, default)
	return default, false
end

local function GetAttributeAsync(_player, _name, default)
	return default, false
end

local function GetAssignmentsAsync()
	return EMPTY
end

return table.freeze({
	GetAttributes = GetAttributes,
	GetAttribute = GetAttribute,
	GetAttributeAsync = GetAttributeAsync,
	GetAssignmentsAsync = GetAssignmentsAsync,
	GetJobAttributes = GetAttributes,
	GetJobAttribute = function(name, default)
		return default, false
	end,
	GetJobAttributeAsync = function(name, default)
		return default, false
	end,
	GetJobAssignments = GetAssignmentsAsync,
	GetJobAssignmentsAsync = GetAssignmentsAsync,
	IsLoaded = function()
		return true
	end,
	Loaded = Bindable.new(),
	PlayerUpdated = Bindable.new(),
	JobUpdated = Bindable.new(),
})