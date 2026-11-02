-- Decompiled with the Synapse X Luau decompiler.

return function(p1)
	local v1 = newproxy(true);
	getmetatable(v1).__tostring = function()
		return p1;
	end;
	return v1;
end;
