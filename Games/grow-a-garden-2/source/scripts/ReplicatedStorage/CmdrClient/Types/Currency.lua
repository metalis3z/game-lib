--credit to leon games studio
local Util = require(script.Parent.Parent.Shared.Util)

game:GetService("ReplicatedStorage")

local function getCurrencyNames() --[[ getCurrencyNames | Line: 4 ]]
	return { "IronBars", "Yen" }
end

local t = {
	Transform = function(p1) --[[ Transform | Line: 9 | Upvalues: Util (copy) ]]
		return Util.MakeFuzzyFinder({ "IronBars", "Yen" })(p1)
	end,
	Validate = function(p1) --[[ Validate | Line: 15 ]]
		return #p1 > 0, "No currency with that name could be found."
	end,
	Autocomplete = function(p1) --[[ Autocomplete | Line: 19 ]]
		return p1
	end,
	Parse = function(p1) --[[ Parse | Line: 23 ]]
		return p1[1]
	end
}

return function(p1) --[[ Line: 28 | Upvalues: t (copy) ]]
	p1:RegisterType("currencyName", t)
end