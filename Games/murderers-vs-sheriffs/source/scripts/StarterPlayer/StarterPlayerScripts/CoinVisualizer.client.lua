local l_ProfileData_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("ProfileData"));
task.wait(0.2);
local l_CoinCollected_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinCollected");
local l_CoinsStarted_0 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Gameplay"):WaitForChild("CoinsStarted");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_TweenService_0 = game:GetService("TweenService");
local v6 = TweenInfo.new(0.266, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0);
local v11 = {};
local function spinCollectedCoin(coin, deltaTime)
	if not coin:GetAttribute("IsSetup") then
		for _, desc in pairs(coin:GetDescendants()) do
			if desc:IsA("BasePart") or desc:IsA("Decal") then
				l_TweenService_0:Create(desc, v6, {
					Transparency = 1
				}):Play()
			end
		end
		l_TweenService_0:Create(coin, v6, {
			Transparency = 1
		}):Play()
		coin:SetAttribute("IsSetup", true)
	end
	local shouldFlyUp = coin:GetAttribute("Collected") and not coin:GetAttribute("RoundEnd")
	local heightIncrement = shouldFlyUp and 14 or 0
	local rotationAmount = 31.41592653589793 * deltaTime
	coin.CFrame = (coin.CFrame + Vector3.new(0, heightIncrement * deltaTime, 0)) * CFrame.Angles(0, rotationAmount, 0)
end

local function UpdateCoins(v23) --[[ Line: 62 ]] --[[ Name: UpdateCoins ]]
	for _, v25 in (l_CollectionService_0:GetTagged("CoinVisual")) do
		local v26 = v11[v25:GetAttribute("CoinID")];
		local v27 = not v25:GetAttribute("Collected") and not v26;
		if v25:GetAttribute("Delete") then
			v25:Destroy();
		else
			if v27 then
				local v29 = 1.9201414298740815 * v23;
				v25.CFrame = v25.CFrame * CFrame.Angles(0, v29, 0);
			else
				spinCollectedCoin(v25, v23);
			end;
		end;
	end;
end;
local function onCoinVisualSpawned(v31)
	if v11[v31:GetAttribute("CoinID")] then
		for _, v33 in pairs(v31:GetDescendants()) do
			if v33:IsA("BasePart") or v33:IsA("Decal") then
				v33.Transparency = 1;
			end;
		end;
		v31:SetAttribute("Delete", true);
	end;
end;
local function onCoinCollected(v35, v36, v37, _)
	if v37 <= v36 then
		v11[v35] = true;
		task.spawn(function() --[[ Line: 107 ]]
			task.wait(0.5);
			local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("CoinVisual");
			for _, v41 in pairs(l_l_CollectionService_0_Tagged_0) do
				if v41:GetAttribute("CoinID") == v35 then
					v41:SetAttribute("Delete", true);
				end;
			end;
		end);
	end;
end;
local function onCoinsStarted()
	v11 = {};
end;
l_CoinsStarted_0.OnClientEvent:Connect(onCoinsStarted);
l_CoinCollected_0.OnClientEvent:Connect(onCoinCollected);
l_CollectionService_0:GetInstanceAddedSignal("CoinVisual"):Connect(onCoinVisualSpawned);
l_RunService_0.PreSimulation:Connect(UpdateCoins);