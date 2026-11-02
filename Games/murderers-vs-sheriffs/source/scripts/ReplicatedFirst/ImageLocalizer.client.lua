-- Decompiled with the Synapse X Luau decompiler.

local v1 = {};
local u1 = nil;
local l__LocalizationService__2 = game:GetService("LocalizationService");
local l__LocalPlayer__3 = game:GetService("Players").LocalPlayer;
local u4 = nil;
local u5 = pcall(function()
	u1 = l__LocalizationService__2:GetTranslatorForPlayerAsync(l__LocalPlayer__3);
end);
local u6 = pcall(function()
	u4 = l__LocalizationService__2:GetTranslatorForLocaleAsync("en");
end);
function v1.translateByKey(p1, p2)
	local v2 = false;
	if u5 then
		local u7 = "";
		v2 = pcall(function()
			u7 = u1:FormatByKey(p1, p2);
		end);
	end;
	if u6 and not v2 then
		local u8 = "";
		v2 = pcall(function()
			u8 = u4:FormatByKey(p1, p2);
		end);
	end;
	if v2 then
		return "";
	end;
	return false;
end;
local v3 = game:GetService("CollectionService"):GetTagged("LocalizationImageKey");
local function v4(p3)
	local l__Parent__5 = p3.Parent;
	local v6 = tostring(l__Parent__5.Image);
	local v7 = v1.translateByKey(p3.Value);
	if v7 then
		local v8, v9 = pcall(function()
			l__Parent__5.Image = "rbxassetid://" .. v7;
		end);
		if not v8 then
			l__Parent__5.Image = "rbxassetid://" .. v6;
			warn(v9);
		end;
	end;
end;
game:GetService("CollectionService"):GetInstanceAddedSignal("LocalizationImageKey"):connect(v4);
for v10, v11 in pairs(v3) do
	v4(v11);
end;
