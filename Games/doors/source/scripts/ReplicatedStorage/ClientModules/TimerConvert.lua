-- Decompiled with the Synapse X Luau decompiler.

function Format(p1)
	return string.format("%02i", p1);
end;
function convertToHMS(p2, p3, p4)
	local v1 = nil;
	local v2 = (p2 - p2 % 60) / 60;
	p2 = p2 - v2 * 60;
	local v3 = (v2 - v2 % 60) / 60;
	v1 = v2 - v3 * 60;
	if p4 then
		return Format(v3), Format(v1), Format(p2);
	end;
	if p3 then

	else
		return Format(v1) .. ":" .. Format(p2);
	end;
	return Format(v3) .. ":" .. Format(v1) .. ":" .. Format(p2);
end;
return convertToHMS;
