-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local v2 = game["Run Service"];
local l__UserInputService__3 = game:GetService("UserInputService");
local v4 = {};
local u1 = {};
local u2 = require(script.Parent.Parent);
local l__LocalPlayer__3 = game.Players.LocalPlayer;
local l__TweenService__4 = game:GetService("TweenService");
function v4.update(p1)
	u1 = {};
	if u2.dead == true then
		p1 = false;
	end;
	for v5, v6 in pairs(game.Players:GetChildren()) do
		local v7, v8 = pcall(function()
			if v6.Character and v6 ~= l__LocalPlayer__3 then
				local v9 = {};
				for v10, v11 in pairs(v6.Character:GetDescendants()) do
					if v11:IsA("BasePart") and v11.Transparency < 1 then
						table.insert(v9, v11);
					end;
				end;
				table.insert(u1, { v6.Character, v9 });
			end;
		end);
		if v8 then
			warn(v8);
		end;
	end;
	local v12, v13 = pcall(function()
		for v14, v15 in pairs(u1) do
			local v16 = v15[1];
			local v17 = v15[2];
			local v18 = v15[2][1];
			if v18 then
				print(tostring(v18)) -- COmment
				if v18:GetAttribute("Hidden") ~= true and p1 == true then
					for v19, v20 in pairs(v17) do
						l__TweenService__4:Create(v20, TweenInfo.new(0.6), {
							LocalTransparencyModifier = 0.7
						}):Play();
					end;
					v18:SetAttribute("Hidden", true);
				elseif v18:GetAttribute("Hidden") == true and p1 == false then
					for v21, v22 in pairs(v17) do
						l__TweenService__4:Create(v22, TweenInfo.new(0.6), {
							LocalTransparencyModifier = 0
						}):Play();
					end;
					v18:SetAttribute("Hidden", false);
				end;
			end;
			wait();
		end;
	end);
	if v13 then
		warn(v13);
	end;
end;
v4.update(true);
game.Players.PlayerAdded:Connect(v4.update);
game.Players.PlayerRemoving:Connect(v4.update);
for v23, v24 in pairs(game.Players:GetChildren()) do
	v24.CharacterAdded:Connect(v4.update);
end;
return v4;
