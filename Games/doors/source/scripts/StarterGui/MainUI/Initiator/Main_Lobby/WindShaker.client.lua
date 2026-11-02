-- Decompiled with the Synapse X Luau decompiler.

local v1 = require(script:FindFirstAncestor("MainUI").Modules.WindShake);
v1:Init();
local v2, v3, v4 = ipairs(workspace.Lobby:GetDescendants());
while true do
	v2(v3, v4);
	if not v2 then
		break;
	end;
	v4 = v2;
	if v3:IsA("BasePart") and v3:GetAttribute("WindShake") then
		v1:AddObjectShake(v3);
	end;
end;
