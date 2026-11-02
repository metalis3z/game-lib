local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_Debris_0 = game:GetService("Debris");
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Util);
local v7 = require(l_ReplicatedStorage_0.Modules.Sounds);
local _ = TweenInfo.new(2.5, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, -1, true);
local v9 = Random.new();
local v10 = l_RunService_0:IsStudio();
local l_2025_MASQUERADE_0 = l_ReplicatedStorage_0.Assets.EventStorage["2025_MASQUERADE"];
local l_script_FullName_0 = script:GetFullName();
local l_Candies_0 = l_2025_MASQUERADE_0.Candies;
local l_SFX_0 = l_2025_MASQUERADE_0.SFX;
local l_VFX_0 = l_2025_MASQUERADE_0.VFX;
local _ = table.insert;
local _ = table.remove;
local l_clear_0 = table.clear;
local l_random_0 = math.random;
local l_sin_0 = math.sin;
local l_new_0 = Instance.new;
local v22 = {
	Name = "Masquerade", 
	CurrencyInstances = {}, 
	Connections = {}
};
v22.Init = function(_)
	if l_Candies_0 then
		l_ContentProvider_0:PreloadAsync(l_Candies_0:GetDescendants(), function(_, _)
			if not v10 then
				return;
			else
				return;
			end;
		end);
		l_Candies_0 = l_Candies_0:GetChildren();
	end;
	v5:SetConnection("ReplicateCandySpawnAsync", "REMOTE_EVENT", function(v26)
		v22:ReplicateCandySpawn(v26);
	end);
	v5:SetConnection("ReplicateCandyDespawnAsync", "REMOTE_EVENT", function()
		v22:ReplicateCandyDespawnAsync();
	end);
end;
v22.__checkAndCreateHeartbeat = function(_)
	if v22.Connections.OnHeartbeat then
		return;
	else
		v22.Connections.OnHeartbeat = l_RunService_0.Heartbeat:Connect(function(_)
			for v29, v30 in v22.CurrencyInstances do
				local v31 = v29 and v29.PrimaryPart;
				if v31 then
					local v32 = v30 + l_sin_0(time() * 2.5) * 0.75;
					v31.CFrame = CFrame.new(v31.Position.X, v32, v31.Position.Z) * CFrame.Angles(0, math.rad(v31.Orientation.Y + 0.15), 0);
				end;
			end;
		end);
		return;
	end;
end;
v22.ReplicateCandySpawn = function(v33, v34)
	local spawnPosition = Vector3.new(v34.X, v34.Y, v34.Z);
	local v35 = l_new_0("Part");
	v35.Size = Vector3.new(1, 1, 1);
	v35.CanCollide = false;
	v35.Anchored = true;
	v35.Transparency = 1;
	v35.Position = spawnPosition;
	local v36 = l_VFX_0.Idle:Clone();
	v36.Parent = v35;
	local v37 = v7:Play(l_SFX_0.Candy_Near, {
		Parent = v35, 
		Volume = 0.25
	});
	local v38 = l_Candies_0[l_random_0(#l_Candies_0)]:Clone();
	v38:PivotTo(CFrame.new(spawnPosition));
	for _, v40 in (v38:GetChildren()) do
		if v40:IsA("BasePart") then
			local v41 = l_new_0("WeldConstraint");
			v41.Part0 = v40;
			v41.Part1 = v35;
			v41.Parent = v40;
			v40.CanTouch = false;
			v40.CanQuery = false;
			v40.CanCollide = false;
			v40.Anchored = false;
		end;
	end;
	local v42 = false;
	v6:ApplyUnsafeTouched(v35, false, function(v43, v44)
		if v42 then
			return;
		else
			v42 = true;
			local l_Parent_0 = v44.Parent;
			if not (l_Parent_0 and l_Parent_0:FindFirstChildOfClass("Humanoid")) then
				v42 = false;
				return;
			else
				local l_status_0, l_result_0 = pcall(function()
					local positionTable = {
						X = spawnPosition.X,
						Y = spawnPosition.Y,
						Z = spawnPosition.Z
					};
					if v5:FireServerConnection("CollectCurrencyAsync", "REMOTE_FUNCTION", positionTable) then
						v43.Disconnect();
						v22.CurrencyInstances[v38] = nil;
						for _, v47 in (v38:GetChildren()) do
							v47.Transparency = 1;
						end;
						v37:Destroy();
						v36:Destroy();
						local v48 = l_VFX_0.Collect:Clone();
						v48.Parent = v35;
						for _, v50 in (v48:GetChildren()) do
							v50:Emit(v50:GetAttribute("EmitCount") or 1);
						end;
						v7:Play(l_SFX_0.Candy_Collect, {
							Parent = l_Parent_0 and l_Parent_0.PrimaryPart, 
							Volume = 0.25, 
							PlaybackSpeed = v9:NextNumber(0.995, 1.005)
						});
						l_Debris_0:AddItem(v38, 2.5);
					end;
				end);
				if not l_status_0 then
					warn((("[%*]: Failed to properly invoke CollectCurrencyAsync due to: %*"):format(l_script_FullName_0, l_result_0)));
				end;
				v42 = false;
				return;
			end;
		end;
	end);
	v35.Parent = v38;
	local l_CurrencyLocations_0 = workspace.Map.Ingame:FindFirstChild("CurrencyLocations");
	if not l_CurrencyLocations_0 then
		l_CurrencyLocations_0 = Instance.new("Folder");
		l_CurrencyLocations_0.Name = "CurrencyLocations";
		l_CurrencyLocations_0.Parent = workspace.Map.Ingame;
	end;
	v38.PrimaryPart = v35;
	v38.Parent = l_CurrencyLocations_0;
	v22.CurrencyInstances[v38] = v35.Position.Y;
	v33:__checkAndCreateHeartbeat();
end;
v22.ReplicateCandyDespawnAsync = function(_)
	local l_CurrencyLocations_1 = workspace.Map.Ingame:FindFirstChild("CurrencyLocations");
	if l_CurrencyLocations_1 then
		l_CurrencyLocations_1:ClearAllChildren();
		l_CurrencyLocations_1:Destroy();
	end;
	l_clear_0(v22.CurrencyInstances);
	if v22.Connections.OnHeartbeat then
		v22.Connections.OnHeartbeat:Disconnect();
		v22.Connections.OnHeartbeat = nil;
	end;
end;
return v22;