-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = p1;
	local k
	while true do
		local v2, v3 = string.gsub(v1, "^(-?%d+)(%d%d%d)", "%1,%2");
		k = v3;
		v1 = v2;
		if k == 0 then
			break;
		end;	
	end;
	return v1;
end;
