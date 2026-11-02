-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = {}
game:GetService("Players")
local v2 = game:GetService("ReplicatedStorage")
local v_u_3 = game:GetService("CollectionService")
local v_u_4 = game:GetService("RunService")
local v_u_5 = require(game.ReplicatedStorage.Shared.FormatNumber)
local v_u_6 = require(v2.Registries.TraitsRegistry)
local v_u_7 = require(v2.Registries.TraitsRegistry.MoonGlowVFX)
local v_u_8 = v2.Assets.LuckyBlockModels
local v_u_9 = v2.Brainrots
local v_u_10 = v2.Events.AnimateLuckyBlock
local v_u_11 = game.Workspace:WaitForChild("GameFolder"):WaitForChild("LuckyBlocks")
local v_u_12 = {
	["item_weld_orientation"] = Vector3.new(0, 0, 0),
	["item_weld_position"] = Vector3.new(0, 0, 0)
}
function v1.OpenLuckyBlock(_, p13, p14, p_u_15, p_u_16, p_u_17, p_u_18, p_u_19, p_u_20, p_u_21, p_u_22)
	-- upvalues: (copy) v_u_8, (copy) v_u_11, (copy) v_u_4, (copy) v_u_9, (copy) v_u_5, (copy) v_u_6, (copy) v_u_7
	local v_u_23 = v_u_8[p14]:Clone()
	v_u_23.Parent = v_u_11
	v_u_23:PivotTo(p13)
	local v24 = v_u_23:GetExtentsSize().Y / 2
	local v_u_25 = 50
	local v_u_26 = 10 + v24 * 0.3
	local v_u_27 = Instance.new("Part", v_u_11)
	v_u_27.Transparency = 1
	v_u_27.CanCollide = false
	v_u_27.Anchored = true
	v_u_27:PivotTo(p13)
	local v_u_28 = Instance.new("Sound", v_u_27)
	v_u_28.RollOffMaxDistance = 200
	v_u_28.RollOffMode = Enum.RollOffMode.Linear
	v_u_28.SoundId = "rbxassetid://94886615914190"
	local v_u_29 = Instance.new("Sound", v_u_27)
	v_u_29.RollOffMaxDistance = 200
	v_u_29.RollOffMode = Enum.RollOffMode.Linear
	v_u_29.SoundId = "rbxassetid://98309872414233"
	local v30 = Instance.new("Sound", v_u_27)
	v30.RollOffMaxDistance = 200
	v30.RollOffMode = Enum.RollOffMode.Linear
	v30.SoundId = "rbxassetid://119918523167841"
	v30:Play()
	task.spawn(function()
		-- upvalues: (ref) v_u_4, (ref) v_u_25, (ref) v_u_26, (copy) v_u_23, (copy) v_u_29, (copy) p_u_16, (copy) p_u_15, (copy) p_u_17, (ref) v_u_9, (copy) p_u_19, (copy) p_u_18, (copy) p_u_20, (ref) v_u_5, (copy) p_u_21, (copy) p_u_22, (ref) v_u_6, (ref) v_u_7, (copy) v_u_28, (copy) v_u_27
		local v_u_31 = 0
		local v_u_32 = 0
		local v_u_33 = nil
		v_u_33 = v_u_4.Heartbeat:Connect(function(p34)
			-- upvalues: (ref) v_u_31, (ref) v_u_32, (ref) v_u_33, (ref) v_u_25, (ref) v_u_26, (ref) v_u_23, (ref) v_u_29, (ref) p_u_16, (ref) p_u_15, (ref) p_u_17, (ref) v_u_9, (ref) p_u_19, (ref) p_u_18, (ref) p_u_20, (ref) v_u_5, (ref) p_u_21, (ref) p_u_22, (ref) v_u_6, (ref) v_u_7, (ref) v_u_28, (ref) v_u_27
			v_u_31 = v_u_31 + p34
			while v_u_31 >= 0.003 do
				v_u_31 = v_u_31 - 0.003
				v_u_32 = v_u_32 + 1
				if v_u_32 >= 333.33333333333337 then
					v_u_33:Disconnect()
				end
				v_u_25 = v_u_25 - 0.15
				v_u_26 = v_u_26 - 0.2
				if v_u_32 > 220 then
					v_u_26 = 0
				end
				v_u_23:PivotTo(v_u_23:GetPivot() * CFrame.new(0, v_u_26 / 50, v_u_25 / 1000))
				if v_u_32 <= 220 then
					if v_u_32 == 100 then
						v_u_26 = 7.5
					elseif v_u_32 == 175 then
						v_u_26 = 5
					end
				end
				if v_u_32 >= 333.33333333333337 then
					task.wait(1)
					v_u_29:Play()
					local v_u_35 = Instance.new("NumberValue")
					v_u_35.Value = v_u_23:GetScale()
					task.delay(0.3, game.Workspace.Destroy, v_u_35)
					task.delay(1.3, game.Workspace.Destroy, v_u_23)
					v_u_35.Changed:Connect(function()
						-- upvalues: (ref) v_u_23, (copy) v_u_35
						v_u_23:ScaleTo(v_u_35.Value)
					end)
					game:GetService("TweenService"):Create(v_u_35, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
						["Value"] = v_u_23:GetScale() / 1000
					}):Play()
					local v36 = 0.005
					for v37 = 1, 30 do
						v36 = v36 + (v37 <= 20 and 0.005 or (v37 <= 29 and 0.03 or 1))
						local v38 = v37 == 30 and p_u_16 or p_u_15[(v37 - 1) % #p_u_15 + 1].Name
						local v_u_39 = v_u_9[v37 == 30 and (p_u_17 or "Normal") or "Normal"][v38]:Clone()
						v_u_39.Parent = game.Workspace
						v_u_39:PivotTo(v_u_23:GetPivot())
						for _, v40 in v_u_39:GetDescendants() do
							if v40:IsA("BasePart") then
								v40.CanCollide = false
							end
						end
						local v_u_41 = Instance.new("NumberValue")
						v_u_41.Value = v_u_39:GetScale() / 1000
						v_u_41.Changed:Connect(function()
							-- upvalues: (copy) v_u_39, (copy) v_u_41
							v_u_39:ScaleTo(v_u_41.Value)
						end)
						game:GetService("TweenService"):Create(v_u_41, TweenInfo.new(v36, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, v37 ~= 30), {
							["Value"] = v_u_39:GetScale()
						}):Play()
						task.delay(v37 == 30 and 5 or v36 * 2, game.Workspace.Destroy, v_u_39)
						task.delay(v37 == 30 and 5 or v36 * 2, game.Workspace.Destroy, v_u_41)
						if v37 == 30 then
							if v_u_39:FindFirstChildOfClass("Model") then
								for _, v42 in v_u_39:GetChildren() do
									if v42:IsA("Model") then
										v42.AnimationController:LoadAnimation(v_u_39.Animation):Play()
									end
								end
							else
								v_u_39.AnimationController:LoadAnimation(v_u_39.Animation):Play()
							end
							local v43 = game.ReplicatedStorage.Assets.BrainrotAtt:Clone()
							v43.CFrame = CFrame.new(0, v_u_39.PrimaryPart.Size.Y / 2 + 4, 0) + (v_u_9.Normal[p_u_16]:GetAttribute("AttOffset") or Vector3.new(0, 0, 0))
							v43.BillboardGui.Mutation.Text = p_u_17
							v43.BillboardGui.Mutation.Visible = p_u_17 ~= "Normal"
							v43.BillboardGui.Mutation.TextColor3 = p_u_19
							v43.BillboardGui.Rarity.Text = p_u_18
							v43.BillboardGui.Rarity.TextColor3 = p_u_20
							if p_u_17 == "Rainbow" then
								v43.BillboardGui.Mutation:AddTag("Rainbow")
							end
							if p_u_18 == "Secret" then
								v43.BillboardGui.Rarity:AddTag("Secret")
							end
							if p_u_18 == "Celestial" then
								v43.BillboardGui.Rarity:AddTag("Celestial")
							end
							if p_u_18 == "Godly" then
								v43.BillboardGui.Rarity:AddTag("Godly")
							end
							v43.BillboardGui.Title.Text = v_u_39.Name:gsub("(%u)", " %1"):gsub("^ ", "")
							v43.BillboardGui.Cash.Text = "$" .. v_u_5(p_u_21) .. "/s"
							v43.Parent = v_u_39.RootPart
							local v44 = v_u_39:FindFirstChild("Traits", true)
							if v44 then
								for _, v45 in p_u_22 do
									local v46 = v_u_6[v45]
									if v46 then
										local _ = v46.Icon
										local v47 = script.TraitIcon:Clone()
										v47.Image = v46.Icon
										v47.Visible = true
										v47.Parent = v44
										v_u_7(v_u_39)
									end
								end
							end
							task.wait(1.5)
							v_u_28:Play()
							task.wait(3.25)
							game:GetService("TweenService"):Create(v_u_41, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
								["Value"] = 0.001
							}):Play()
							v_u_27:Destroy()
						else
							task.wait(v36)
						end
					end
					return
				end
			end
		end)
	end)
end
function v1.Init(p_u_48)
	-- upvalues: (copy) v_u_10, (copy) v_u_4, (copy) v_u_12, (copy) v_u_3
	v_u_10.OnClientEvent:Connect(function(...)
		-- upvalues: (copy) p_u_48
		p_u_48:OpenLuckyBlock(...)
	end)
	local v_u_49 = 0
	v_u_4.Heartbeat:Connect(function(p50)
		-- upvalues: (ref) v_u_49, (ref) v_u_12, (ref) v_u_3
		v_u_49 = v_u_49 + p50
		local v51 = v_u_49 * 0.017453292519943295 % 6.283185307179586
		local v52 = v_u_12
		local v53 = math.deg(v51)
		v52.item_weld_orientation = Vector3.new(0, v53, 0)
		local v54 = v_u_49 * 3.141592653589793 * 0.25
		local v55 = math.sin(v54) * 0.15
		v_u_12.item_weld_position = Vector3.new(0, v55, 0)
		for _, v56 in v_u_3:GetTagged("item_weld_animation") do
			if v56:IsA("Weld") or v56:IsA("Motor6D") then
				local v57 = v56:GetAttribute("default_cframe")
				if not v57 then
					v57 = v56.C1
					v56:SetAttribute("default_cframe", v56.C1)
				end
				v56.C1 = v57 * CFrame.new(v_u_12.item_weld_position) * CFrame.Angles(0, v_u_12.item_weld_orientation.Y, 0)
			end
		end
	end)
end
return v1
