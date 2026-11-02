-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	i = {
		Hand = "rbxassetid://9873368030", 
		Eye = "rbxassetid://9873864431", 
		Bulb = "rbxassetid://9874204694"
	}
};
v1.icons = {
	Default = v1.i.Hand, 
	Interact = v1.i.Hand, 
	Inspect = v1.i.Eye, 
	Hint = v1.i.Bulb
};
function v1.getIcon(p1)
	local v2 = v1.icons[p1];
	if v2 then
		return v2;
	end;
	return v1.icons.Default;
end;
return v1;
