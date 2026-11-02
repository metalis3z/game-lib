-- Decompiled with the Synapse X Luau decompiler.

return {
	make_getS = function(p1, p2)
		local u1 = p2;
		return function()
			if not u1 then
				return nil;
			end;
			u1 = nil;
			return u1;
		end;
	end, 
	init = function(p3, p4, p5, p6)
		if not p4 then
			return;
		end;
		local v1 = {
			reader = p4, 
			data = p5 and "", 
			name = p6
		};
		if not p5 or p5 == "" then
			v1.n = 0;
		else
			v1.n = #p5;
		end;
		v1.p = 0;
		return v1;
	end, 
	fill = function(p7, p8)
		local v2 = p8.reader();
		p8.data = v2;
		if not v2 or v2 == "" then
			return "EOZ";
		end;
		p8.n = #v2 - 1;
		p8.p = 1;
		return string.sub(v2, 1, 1);
	end, 
	zgetc = function(p9, p10)
		local l__n__3 = p10.n;
		local v4 = p10.p + 1;
		if not (l__n__3 > 0) then
			return p9:fill(p10);
		end;
		p10.n = l__n__3 - 1;
		p10.p = v4;
		return string.sub(p10.data, v4, v4);
	end
};
