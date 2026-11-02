--credit to prince games studio
local Util = require(script.Parent.Parent.Shared.Util)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function getPackNames() --[[ getPackNames | Line: 4 | Upvalues: ReplicatedStorage (copy) ]]
	local Pack_MODULE = ReplicatedStorage:FindFirstChild("Modules"):FindFirstChild("Pack_MODULE")
	local PackData = require(Pack_MODULE:FindFirstChild("PackData"))
	local t = {}

	for k, v in pairs(PackData) do
		table.insert(t, k)
	end

	table.sort(t)

	return t
end

local t = {
	Transform = function(p1) --[[ Transform | Line: 18 | Upvalues: getPackNames (copy), Util (copy) ]]
		return Util.MakeFuzzyFinder((getPackNames()))(p1)
	end,
	Validate = function(p1) --[[ Validate | Line: 24 ]]
		return #p1 > 0, "No pack with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Autocomplete | Line: 28 ]]
		return p1
	end,
	Parse = function(p1) --[[ Parse | Line: 32 ]]
		return p1[1]
	end
}

return function(p1) --[[ Line: 37 | Upvalues: t (copy) ]]
	p1:RegisterType("packName", t)
end