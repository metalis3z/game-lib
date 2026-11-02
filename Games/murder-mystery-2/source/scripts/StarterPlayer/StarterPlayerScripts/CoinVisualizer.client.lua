-- Decompiled with the Synapse X Luau decompiler.

while true do
	wait();
	if _G.PlayerData ~= nil then
		break;
	end;
end;
wait(0.2);
local u1 = nil;
local u2 = require(script.Weld);
local l__TweenService__3 = game:GetService("TweenService");
local u4 = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
game:GetService("RunService").Heartbeat:connect(function(p1)
	u1 = nil;
	for v2, v3 in pairs(game.Workspace:GetChildren()) do
		if v3:FindFirstChild("CoinContainer") then
			u1 = v3.CoinContainer;
		end;
	end;
	if u1 == nil then
		return;
	end;
	if u1.Parent == nil then
		u1 = nil;
		return;
	end;
	for v4, v5 in pairs(u1:GetChildren()) do
		local l__Coin__6 = v5:FindFirstChild("Coin");
		if v5.Name == "Coin_Server" and not l__Coin__6 and not v5:FindFirstChild("BagFull") and not _G.CoinBagFull then
			local v7 = game.ReplicatedStorage.CoinObjects.Coin:Clone();
			v7.Name = "Coin";
			u2(v5);
			v7.CFrame = v5.CFrame;
			v7.Parent = v5;
		elseif v5.Name == "CollectedCoin" or v5:FindFirstChild("BagFull") then
			local l__SpinningVisual__8 = v5:FindFirstChild("SpinningVisual");
			local l__BagFull__9 = v5:FindFirstChild("BagFull");
			if not l__SpinningVisual__8 and not v5:FindFirstChild("SpinComplete") and l__Coin__6 then
				local v10 = game.ReplicatedStorage.CoinObjects.SpinningVisual:Clone();
				v10.Name = "SpinningVisual";
				u2(v5);
				v10.CFrame = v5.CFrame;
				v10.Parent = v5;
				spawn(function()
					for v11, v12 in pairs(v10:GetDescendants()) do
						if v12:IsA("BasePart") or v12:IsA("Decal") then
							if v12:IsA("MeshPart") then
								v12.TextureID = "";
							end;
							l__TweenService__3:Create(v12, u4, {
								Transparency = 1
							}):Play();
						end;
					end;
					wait(0.2);
					local v13 = Instance.new("Model");
					v13.Name = "SpinComplete";
					v13.Parent = v5;
				end);
			elseif l__SpinningVisual__8 then
				local v14
				if v5:FindFirstChild("RoundEnd") or v5:FindFirstChild("BagFull") then
					v14 = 0;
				else
					v14 = 0.2;
				end;
				if not l__BagFull__9 then
					l__SpinningVisual__8.CFrame = (l__SpinningVisual__8.CFrame + Vector3.new(0, v14, 0)) * CFrame.Angles(0.5235987755982988, 0, 0);
				end;
			end;
			if l__Coin__6 then
				l__Coin__6:Destroy();
			end;
		elseif l__Coin__6 then
			l__Coin__6.CFrame = l__Coin__6.CFrame * CFrame.Angles(1.9198621771937625 * p1, 0, 0)
	    end;
	end;
end);

