-- Reference copy for study. Game: Punching Simulator (punching-simulator)
-- Original: ReplicatedStorage/Common/Library/Classes/Pool.lua  (43 lines)
-- What it does: Minimal object pool: get() reuses a returned instance or clones the template, back() puts one back.

--> Variables
local _L = _G._L

--> Constants

------------->
local Pool = {_objects = {}}
Pool.__index = Pool

function Pool.new(props)
	local self = setmetatable({}, Pool)
	
	self._name = props.name
	self._template = props.template
	
	self._instances = {}
	
	return self
end

function Pool:get()
	local instance = self._instances[1]
	
	if instance then
		table.remove(self._instances, 1)
	end
	
	return instance or self._template:Clone()
end

function Pool:back(instance)
	if not table.find(self._instances, instance) then
		table.insert(self._instances, instance)
	end
end

function Pool._init()
end

function Pool._start()
end

return Pool
