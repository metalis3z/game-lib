local v1 = {
	i = {
		Hand = "rbxassetid://9873368030", 
		Eye = "rbxassetid://9873864431", 
		Bulb = "rbxassetid://9874204694", 
		Hide = "rbxassetid://10058643663", 
		Loot = "rbxassetid://10058798678", 
		Skip = "rbxassetid://10325961736", 
		Heal = "rbxassetid://10374289023", 
		Coins = "rbxassetid://10482297351"
	}
};
v1.icons = {
	Default = v1.i.Hand, 
	Interact = v1.i.Hand, 
	Inspect = v1.i.Eye, 
	Hint = v1.i.Bulb, 
	Hide = v1.i.Hide, 
	Loot = v1.i.Loot, 
	Collect = v1.i.Coins, 
	Skip = v1.i.Skip, 
	Heal = v1.i.Heal, 
	Donate = "rbxassetid://11329560072", 
	EnterSecret = "rbxassetid://11724086482", 
	Dialogue = "rbxassetid://11837250484", 
	Transport = "rbxassetid://11869222311"
};
function v1.getIcon(p1)
	local v2 = v1.icons[p1];
	if v2 then
		return v2;
	end;
	return v1.icons.Default;
end;
return v1;
