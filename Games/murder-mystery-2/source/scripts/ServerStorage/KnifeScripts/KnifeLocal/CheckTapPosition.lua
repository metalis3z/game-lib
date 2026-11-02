-- Decompiled with the Synapse X Luau decompiler.

local l__LocalPlayer__1 = game.Players.LocalPlayer;
return function(p1)
	local v1 = type(p1) == "table" and p1[1] or p1;
	local v2 = {};
	for v3, v4 in pairs(l__LocalPlayer__1.PlayerGui.TouchGui.TouchControlFrame:GetChildren()) do
		if v4.Visible then
			table.insert(v2, v4);
		end;
	end;
	for v5, v6 in pairs(v2) do
		local l__AbsoluteSize__7 = v6.AbsoluteSize;
		local l__AbsolutePosition__8 = v6.AbsolutePosition;
		if l__AbsolutePosition__8.X <= v1.X and v1.X <= l__AbsolutePosition__8.X + math.abs(l__AbsoluteSize__7.X) and l__AbsolutePosition__8.Y <= v1.Y and v1.Y <= l__AbsolutePosition__8.Y + math.abs(l__AbsoluteSize__7.Y) then
			return nil;
		end;
	end;
	return v1;
end;
