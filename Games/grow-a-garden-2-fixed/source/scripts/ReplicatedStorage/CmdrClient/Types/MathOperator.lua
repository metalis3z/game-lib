--credit to quartz games studio
return function(p1) --[[ Line: 1 ]]
	p1:RegisterType("mathOperator", p1.Cmdr.Util.MakeEnumType("Math Operator", {
		{
			Name = "+",
			Perform = function(p1, p2) --[[ Perform | Line: 5 ]]
				return p1 + p2
			end
		},
		{
			Name = "-",
			Perform = function(p1, p2) --[[ Perform | Line: 11 ]]
				return p1 - p2
			end
		},
		{
			Name = "*",
			Perform = function(p1, p2) --[[ Perform | Line: 17 ]]
				return p1 * p2
			end
		},
		{
			Name = "/",
			Perform = function(p1, p2) --[[ Perform | Line: 23 ]]
				return p1 / p2
			end
		},
		{
			Name = "**",
			Perform = function(p1, p2) --[[ Perform | Line: 29 ]]
				return p1 ^ p2
			end
		},
		{
			Name = "%",
			Perform = function(p1, p2) --[[ Perform | Line: 35 ]]
				return p1 % p2
			end
		}
	}))
end