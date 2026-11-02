local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.Packages.Net);
local v4 = require(l_ReplicatedStorage_0.UserGenerated.Lang.Janitor);
local v5 = require(l_ReplicatedStorage_0.Shared.FlashShared);
local v6 = require(l_ReplicatedStorage_0.UserGenerated.Lang.WCall);
local l_Parent_0 = script.Parent;
local v8 = if l_Parent_0.Parent:IsA("Model") then l_Players_0:GetPlayerFromCharacter(l_Parent_0.Parent) else l_Parent_0.Parent.Parent;
if v8 ~= l_Players_0.LocalPlayer then
	return;
else
	assert(v8 and v8:IsA("Player"));
	local v9 = v8.Character or v8.CharacterAdded:Wait();
	local v10 = assert(v9:WaitForChild("HumanoidRootPart", 5));
	local v11 = assert(v9:WaitForChild("Humanoid", 5));
	local _ = assert(v11:WaitForChild("Animator", 5));
	local v13 = v3:RemoteFunction("Tools/Flash/Activate");
	local l_Ghost_0 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Flash Teleport"):WaitForChild("Ghost");
	local v15 = nil;
	local function _()
		local l_l_Parent_0_Attribute_0 = l_Parent_0:GetAttribute("CooldownUntil");
		if l_l_Parent_0_Attribute_0 and workspace:GetServerTimeNow() < l_l_Parent_0_Attribute_0 then
			return true;
		else
			return false;
		end;
	end;
	local v18 = false;
	l_Parent_0.Activated:Connect(function()
		if not v10.Parent then
			return;
		elseif v11.Health <= 0 then
			return;
		elseif v8:GetAttribute("Stealing") then
			return;
		elseif v10.Anchored then
			return "Anchored";
		elseif not v10.Parent then
			return;
		else
			local l_v8_Attribute_0 = v8:GetAttribute("RagdollEndTime");
			if l_v8_Attribute_0 and workspace:GetServerTimeNow() < l_v8_Attribute_0 then
				return;
			elseif not v5.Enabled:Get() then
				return;
			else
				local l_l_Parent_0_Attribute_1 = l_Parent_0:GetAttribute("CooldownUntil");
				if if l_l_Parent_0_Attribute_1 then workspace:GetServerTimeNow() < l_l_Parent_0_Attribute_1 else false then
					return;
				elseif v18 then
					return;
				else
					v18 = true;
					if v15 and v15.Result.Valid then
						v6(function()
							local v21, v22 = v13:InvokeServer(v15.Params, v15.Result);
							if not v21 then
								warn("Tools/Flash/Activate", v22);
							end;
						end);
					else
						l_Parent_0.Handle.ErrorSound:Play();
					end;
					v18 = false;
					return;
				end;
			end;
		end;
	end);
	local v23 = Color3.fromRGB(0, 200, 255);
	local v24 = Color3.fromRGB(255, 0, 0);
	local v25 = false;
	local v26 = v4.new();
	l_Parent_0.Equipped:Connect(function()
		if v25 then
			return;
		else
			v25 = true;
			v26 = v4.new();
			local v27 = v26:Add(l_Ghost_0:Clone());
			v26:Add(l_RunService_0.RenderStepped:Connect(function(_)
				local l_l_Parent_0_Attribute_2 = l_Parent_0:GetAttribute("CooldownUntil");
				if if l_l_Parent_0_Attribute_2 then workspace:GetServerTimeNow() < l_l_Parent_0_Attribute_2 else false then
					v27.Parent = nil;
				else
					v27.Parent = workspace;
				end;
				local v30 = false;
				l_l_Parent_0_Attribute_2 = v5.BuildComputeParams(v8, workspace.CurrentCamera.CFrame);
				if l_l_Parent_0_Attribute_2 then
					local v31 = v5.Compute(l_l_Parent_0_Attribute_2);
					v30 = v31.Valid;
					v27:PivotTo(v31.CFrame);
					v15 = {
						Params = l_l_Parent_0_Attribute_2, 
						Result = v31
					};
				else
					v15 = nil;
				end;
				local v32 = v30 and v23 or v24;
				for _, v34 in ipairs(v27:GetDescendants()) do
					if v34:IsA("BasePart") then
						v34.Color = v32;
					end;
				end;
			end));
			return;
		end;
	end);
	l_Parent_0.Unequipped:Connect(function()
		if not v25 then
			return;
		else
			v25 = false;
			v26:Destroy();
			return;
		end;
	end);
	return;
end;
