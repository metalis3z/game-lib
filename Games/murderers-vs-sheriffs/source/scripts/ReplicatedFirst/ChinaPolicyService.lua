--[[VARIABLE DEFINITION ANOMALY DETECTED, DECOMPILATION OUTPUT POTENTIALLY INCORRECT]]--
-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local l__RunService__2 = game:GetService("RunService");
local v3 = false;
local v4 = Instance.new("BindableEvent");
local v5 = Instance.new("BindableEvent");
local v6 = false;
local v7 = true;
for v8, v9 in pairs(script:GetChildren()) do
	if v9:IsA("BoolValue") then
		if v9.Name == "Forced" then
			v6 = v9.Value;
		elseif v9.Name == "DisableGroupCheck" then
			v7 = not v9.Value;
		end;
	end;
end;
local u1 = {};
local function u2(p1, p2)
	for v10 = 1, p1 do
		local v11, v12 = pcall(p2);
		if v11 then
			return v12;
		end;
		wait(v10 / 2);
	end;
end;
local l__PolicyService__3 = game:GetService("PolicyService");
local l__Players__4 = game:GetService("Players");
local u5 = {};
local function v13(p3)
	if u1[p3] == nil then
		if v6 then
			local v14 = true;
		else
			v14 = u2(3, function()
				return l__PolicyService__3:GetPolicyInfoForPlayerAsync(p3).IsSubjectToChinaPolicies;
			end);
			if v7 and not v14 and p3.UserId > 0 and u2(3, function()
				return p3:IsInGroup(9170755);
			end) then
				v14 = true;
			end;
		end;
		if p3.Parent == l__Players__4 then
			if v14 == nil then
				u1[p3] = false;
			else
				u1[p3] = v14;
			end;
			u5[p3] = v14 == nil;
		end;
	end;
	return u1[p3], u5[p3];
end;
l__Players__4.PlayerRemoving:Connect(function(p4)
	u1[p4] = nil;
	u5[p4] = nil;
end);
if l__RunService__2:IsServer() then
	local v15 = v6;
	if not v15 then
		local u6 = nil;
		local u7 = v15;
		local u8 = v3;
		local u9 = false;
		u6 = l__Players__4.PlayerAdded:Connect(function(p5)
			if not u6 then
				return;
			end;
			u6:Disconnect();
			u6 = nil;
			local v16, v17 = v13(p5);
			u7 = v16;
			u8 = v17;
			u9 = true;
			if u7 then
				v4:Fire(u7, u8);
			end;
			v5:Fire(u7, u8);
		end);
		if #l__Players__4:GetPlayers() > 0 then
			local v18 = l__Players__4:GetPlayers()[1];
			if u6 then
				u6:Disconnect();
				u6 = nil;
				local v19, v20 = v13(v18);
				u7 = v19;
				u8 = v20;
				u9 = true;
				if u7 then
					v4:Fire(u7, u8);
				end;
				v5:Fire(u7, u8);
			end;
		end;
	else
		local v21 = true;
	end;
else
	local v22, v23 = v13(l__Players__4.LocalPlayer);
	v15 = v22;
	v3 = v23;
	v21 = true;
end;
function v1.IsActive(p6)
	return v15, v3;
end;
function v1.IsReady(p7)
	return v21;
end;
function v1.WaitForReady(p8)
	if v21 then
		return v15, v3;
	end;
	return v5.Event:Wait();
end;
v1.Changed = v4.Event;
function v1.IsActiveForPlayer(p9, p10)
	if typeof(p10) ~= "Instance" or not p10:IsA("Player") then
		error("bad argument #1 to 'IsActiveForPlayer' (Player expected, got " .. typeof(p10) .. ")", 2);
	end;
	return v13(p10);
end;
return v1;
