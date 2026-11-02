-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	i = {
		Hand = "rbxassetid://9873368030", 
		Eye = "rbxassetid://9873864431", 
		Bulb = "rbxassetid://9874204694", 
		Lighter = "rbxassetid://10006095602"
	}
};
v1.icons = {
	Default = v1.i.Hand, 
	Interact = v1.i.Hand, 
	Flashlight = v1.i.Bulb, 
	Lighter = v1.i.Lighter
};
return function(p1)
	local v2 = v1.icons[p1];
	if v2 then
		return v2;
	end;
	return v1.icons.Default;
end;
