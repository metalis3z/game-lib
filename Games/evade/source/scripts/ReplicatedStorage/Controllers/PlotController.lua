-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local l_Controllers_0 = l_ReplicatedStorage_0:WaitForChild("Controllers");
local _ = require(l_Controllers_0.CharacterController);
local v5 = require(l_Controllers_0.SoundController);
local l_Packages_0 = l_ReplicatedStorage_0:WaitForChild("Packages");
local v7 = require(l_Packages_0.Observers);
local v8 = require(l_Packages_0.Trove);
local v9 = require(l_Packages_0.Net);
local _ = require(l_ReplicatedStorage_0.Shared.Updates);
local v11 = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Datas_0 = l_ReplicatedStorage_0:WaitForChild("Datas");
local v13 = require(l_Datas_0.Animals);
local l_Classes_0 = l_ReplicatedStorage_0:WaitForChild("Classes");
local v15 = require(l_Classes_0.PlotClient);
local l_Animals_0 = l_ReplicatedStorage_0:WaitForChild("Animations").Animals;
local v17 = require(l_ReplicatedStorage_0.Shared.Animals);
local v18 = require(l_ReplicatedStorage_0.Controllers.AnimationSyncController);
local v19 = v9:RemoteEvent("PlotService/Open");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v21 = nil;
local v22 = {};
local function _(v23) --[[ Line: 39 ]] --[[ Name: round ]]
	return math.floor(v23 * 100) / 100;
end;
return {
	GetMyPlot = function(_) --[[ Line: 45 ]] --[[ Name: GetMyPlot ]]
		-- upvalues: v21 (ref)
		return v21;
	end, 
	Start = function(_) --[[ Line: 49 ]] --[[ Name: Start ]]
		-- upvalues: v19 (copy), v22 (copy), v13 (copy), v8 (copy), v5 (copy), v11 (copy), l_ReplicatedStorage_0 (copy), v17 (copy), l_Animals_0 (copy), v18 (copy), l_TweenService_0 (copy), v7 (copy), v15 (copy), l_LocalPlayer_0 (copy), v21 (ref)
		v19.OnClientEvent:Connect(function(v27, v28, v29, v30, v31, v32) --[[ Line: 50 ]]
			-- upvalues: v22 (ref), v13 (ref), v8 (ref), v5 (ref), v11 (ref), l_ReplicatedStorage_0 (ref), v17 (ref), l_Animals_0 (ref), v18 (ref), l_TweenService_0 (ref)
			local v33 = v22[v27];
			if not v33 then
				return;
			else
				local l_FirstChild_0 = v33.PlotModel.AnimalPodiums:FindFirstChild(v28);
				if not l_FirstChild_0 then
					return;
				else
					while l_FirstChild_0:GetAttribute("DeferDisplay") and l_FirstChild_0:IsDescendantOf(workspace) do
						task.wait(0.1);
					end;
					if not l_FirstChild_0:IsDescendantOf(workspace) then
						return;
					else
						l_FirstChild_0:SetAttribute("DeferDisplay", v30);
						task.spawn(v33.UpdateAnimalPodiums, v33);
						local l_Spawn_0 = l_FirstChild_0.Base.Spawn;
						local v37 = v8.new();

						if v29 == "Coffin Tung Tung Tung Sahur" then
							local v_CoffinModel = l_ReplicatedStorage_0.Models.Animals:FindFirstChild(v29);
							if not v_CoffinModel then
								return;
							end

							local v_CoffinClone = v37:Clone(v_CoffinModel);

							for _, v_Part in v_CoffinClone:GetChildren() do
								if v_Part:IsA("MeshPart") and string.find(v_Part.Name, "Plane.003_col", 1, true) then
									v_Part.Transparency = 1;
								end
							end

							v_CoffinClone.PrimaryPart.Anchored = true;
							v_CoffinClone.Parent = workspace.CurrentCamera;
							v_CoffinClone:PivotTo(l_Spawn_0:GetPivot());

							if v31 then
								v37:Add(v17:ApplyMutation(v_CoffinClone, v29, v31));
							end
							if v32 then
								v37:Add(v17:ApplyTraits(v_CoffinClone, v29, v32));
							end

							for _, v_Trail in v_CoffinClone:GetDescendants() do
								if v_Trail:IsA("Trail") then
									v_Trail:Destroy();
								end
							end

							local v_AnimController = v_CoffinClone:FindFirstChildOfClass("AnimationController") or v37:Add(Instance.new("AnimationController", v_CoffinClone));
							local v_Animator = v_AnimController:FindFirstChildOfClass("Animator") or v37:Add(Instance.new("Animator", v_AnimController));
							local v_UnboxAnim = v_Animator:LoadAnimation(l_ReplicatedStorage_0.Controllers.CoffinDanceTungTungTungSahurController.Unbox);
							v_UnboxAnim.Looped = false;
							v_UnboxAnim:Play(0);

							v5:PlaySound("Sounds.Sfx.Tung Tung Coffin", l_Spawn_0.CFrame.Position + Vector3.new(0, 3, 0), false);

							v37:Add(function()
								v_UnboxAnim:Stop(0);
								v_UnboxAnim:Destroy();
							end);

							local v_AnimFinished = false;
							local v_CurrentThread = coroutine.running();

							local function v_FinishAnimation()
								v_AnimFinished = true;
								if coroutine.status(v_CurrentThread) == "suspended" then
									task.spawn(v_CurrentThread);
								end
							end

							v_UnboxAnim.Stopped:Once(v_FinishAnimation);
							local v_TimeoutTask = task.delay(15, v_FinishAnimation);

							if not v_AnimFinished then
								coroutine.yield();
							end

							if coroutine.status(v_TimeoutTask) == "suspended" then
								pcall(task.cancel, v_TimeoutTask);
							end

							local v_SmokeEffect = v11.copy(v11.Library.Misc.Smoke, l_Spawn_0.CFrame + Vector3.new(0, 3, 0));
							v11.rescale(v_SmokeEffect, 3);
							v11.emit(v_SmokeEffect);

							task.delay(5, function()
								v_SmokeEffect:Destroy();
							end);

							v5:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", l_Spawn_0.CFrame.Position + Vector3.new(0, 3, 0), false);
							v37:Clean();
							l_FirstChild_0:SetAttribute("DeferDisplay", nil);
							v33:UpdateAnimalPodiums();
							return;
						end

						local v34 = v13[v29];
						if not v34 or not v34.LuckyBlock then
							return;
						end

						v5:PlaySound("Sounds.Sfx.Lucky Blocks.SpinStart", l_Spawn_0.CFrame.Position + Vector3.new(0, 3, 0, 0));
						local v38 = v37:Add(v11.copy(v11.Library.Misc.LuckyBlockUnbox, l_Spawn_0.CFrame + Vector3.new(0, 3, 0, 0)));
						v11.emit(v38);
						local l_Animals_1 = v34.LuckyBlock.Animals;
						local v40 = {};
						local v41 = 0;
						for _, v43 in l_Animals_1 do
							if not v43.IsEnabled or v43.IsEnabled() then
								local l_Name_0 = v43.Name;
								local l_FirstChild_1 = l_ReplicatedStorage_0.Models.Animals:FindFirstChild(l_Name_0);
								if l_FirstChild_1 then
									local v46 = v37:Clone(l_FirstChild_1);
									v46.PrimaryPart.Anchored = true;
									v46.Parent = workspace.CurrentCamera;
									for _, v48 in v46:GetDescendants() do
										if v48:IsA("ParticleEmitter") then
											v48:Destroy();
										end;
									end;
									if v31 then
										v37:Add(v17:ApplyMutation(v46, l_Name_0, v31));
									end;
									if v32 then
										v37:Add(v17:ApplyTraits(v46, l_Name_0, v32));
									end;
									for _, v50 in v46:GetDescendants() do
										if v50:IsA("Trail") then
											v50:Destroy();
										end;
									end;
									local v51 = v46:FindFirstChildOfClass("AnimationController") or v37:Add(Instance.new("AnimationController", v46));
									local v52 = v51:FindFirstChildOfClass("Animator") or v37:Add(Instance.new("Animator", v51));
									local l_l_Animals_0_FirstChild_0 = l_Animals_0:FindFirstChild(l_Name_0);
									local v54 = l_l_Animals_0_FirstChild_0 and l_l_Animals_0_FirstChild_0:FindFirstChild("Idle");
									if v54 and v52 then
										local v55 = v52:LoadAnimation(v54);
										v55.Looped = true;
										v55:Play();
										local v56 = v18:Add(v55);
										v37:Add(function() --[[ Line: 139 ]]
											-- upvalues: v56 (copy), v55 (copy)
											v56();
											v55:Stop(0);
											v55:Destroy();
										end);
									end;
									table.insert(v40, v46);
									if l_Name_0 == v30 then
										v41 = #v40;
									end;
								end;
							end;
						end;
						local v57 = v37:Add(Instance.new("NumberValue"));
						v57.Value = 0;
						v37:Add(v57.Changed:Connect(function(v58) --[[ Line: 155 ]]
							-- upvalues: l_Spawn_0 (copy), v40 (copy)
							local l_l_Spawn_0_Pivot_0 = l_Spawn_0:GetPivot();
							for v60, v61 in v40 do
								local v62 = math.sin(math.clamp((v58 - (v60 - 1)) % #v40 * 0.5, 0, 1) * 3.141592653589793);
								local l_v61_Attribute_0 = v61:GetAttribute("DefaultScale");
								if l_v61_Attribute_0 == nil then
									l_v61_Attribute_0 = v61:GetScale();
									v61:SetAttribute("DefaultScale", l_v61_Attribute_0);
								end;
								v61:PivotTo(l_l_Spawn_0_Pivot_0);
								v61:ScaleTo((math.clamp(l_v61_Attribute_0 * v62 * 1.01, 0.001, l_v61_Attribute_0)));
							end;
						end));
						local v64 = #v40 * 12 + v41;
						local v65 = v37:Add(l_TweenService_0:Create(v57, TweenInfo.new(6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
							Value = v64
						}));
						v65:Play();
						task.wait(v65.TweenInfo.Time * 0.82);
						v57.Value = v64;
						v65:Cancel();
						v37:Clean();
						v5:PlaySound("Sounds.Sfx.Lucky Blocks.SpinEnd", l_Spawn_0.CFrame.Position + Vector3.new(0, 3, 0, 0));
						l_FirstChild_0:SetAttribute("DeferDisplay", nil);
						v33:UpdateAnimalPodiums();
						return;
					end;
				end;
			end;
		end);
		v7.observeTag("Plot", function(v66) --[[ Line: 191 ]]
			-- upvalues: v8 (ref), v15 (ref), v22 (ref), l_LocalPlayer_0 (ref), v21 (ref)
			local v67 = v8.new();
			v67:Add(task.spawn(function() --[[ Line: 194 ]]
				-- upvalues: v66 (copy), v15 (ref), v22 (ref), l_LocalPlayer_0 (ref), v21 (ref), v67 (copy)
				while not v66:GetAttribute("Loaded") do
					task.wait();
				end;
				local v68 = v15.new(v66);
				local l_v68_UID_0 = v68:GetUID();
				v22[l_v68_UID_0] = v68;
				if v68:GetOwner() == l_LocalPlayer_0 then
					v21 = v68;
				end;
				v67:Add(v68);
				v67:Add(function() --[[ Line: 208 ]]
					-- upvalues: v22 (ref), l_v68_UID_0 (copy)
					v22[l_v68_UID_0] = nil;
				end);
			end));
			return v67:WrapClean();
		end);
	end
};