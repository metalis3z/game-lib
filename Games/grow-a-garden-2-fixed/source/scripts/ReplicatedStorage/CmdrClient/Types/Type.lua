--credit to quartz games studio
local Util = require(script.Parent.Parent.Shared.Util)

return function(p1) --[[ Line: 3 | Upvalues: Util (copy) ]]
	local t = {
		Transform = function(p12) --[[ Transform | Line: 5 | Upvalues: Util (ref), p1 (copy) ]]
			return Util.MakeFuzzyFinder(p1:GetTypeNames())(p12)
		end,
		Validate = function(p1) --[[ Validate | Line: 11 ]]
			return #p1 > 0, "No type with that name could be found."
		end,
		Autocomplete = function(p1) --[[ Autocomplete | Line: 15 ]]
			return p1
		end,
		Parse = function(p1) --[[ Parse | Line: 19 ]]
			return p1[1]
		end
	}

	p1:RegisterType("type", t)
	p1:RegisterType("types", Util.MakeListableType(t))
end