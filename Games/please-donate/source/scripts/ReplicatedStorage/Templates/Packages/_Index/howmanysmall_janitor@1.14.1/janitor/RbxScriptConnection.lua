-- Decompiled with the Synapse X Luau decompiler.

local v1 = {
	Connected = true
};
v1.__index = v1;
function v1.Disconnect(p1)
	if p1.Connected then
		p1.Connected = false;
		p1.Connection:Disconnect();
	end;
end;
function v1._new(p2)
	return setmetatable({
		Connection = p2
	}, v1);
end;
function v1.__tostring(p3)
	return "RbxScriptConnection<" .. tostring(p3.Connected) .. ">";
end;
return v1;
