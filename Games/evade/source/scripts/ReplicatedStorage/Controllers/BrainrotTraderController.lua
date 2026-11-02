---------------------------------------------------
-- Saved by Angelus Decompiles | With Script + GUI
-- Discord: https://discord.gg/nDWm6PkFrT
---------------------------------------------------

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
game:GetService("ProximityPromptService")
local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
game:GetService("SoundService")
game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")
local v_u_2 = game:GetService("Players")
require(v_u_1.Packages.Serialization)
local v_u_3 = require(v_u_1.Packages.Synchronizer)
require(v_u_1.Packages.CreateTween)
require(v_u_1.Packages.TopbarPlus)
local v_u_4 = require(v_u_1.Packages.Gradients)
local v_u_5 = require(v_u_1.Packages.Observers)
require(v_u_1.Packages.Moonlite)
require(v_u_1.Packages.Signal)
require(v_u_1.Packages.Squash)
local v_u_6 = require(v_u_1.Packages.Timer)
local v_u_7 = require(v_u_1.Packages.Trove)
local v_u_8 = require(v_u_1.Packages.Spr)
local v9 = require(v_u_1.Packages.Net)
require(v_u_1.Controllers.NotificationController)
require(v_u_1.Controllers.NewPlayersController)
local v_u_10 = require(v_u_1.Controllers.InterfaceController)
require(v_u_1.Controllers.CharacterController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
require(v_u_1.Controllers.ShopController)
require(v_u_1.Controllers.PlotController)
local v_u_12 = require(v_u_1.Utils.NumberUtils)
local v_u_13 = require(v_u_1.Utils.TimeUtils)
local v_u_14 = require(v_u_1.Shared.VFX)
local v_u_15 = require(v_u_1.Classes.AnimatedButton)
require(v_u_1.Shared.Updates)
require(v_u_1.Shared.Animals)
local v_u_16 = require(v_u_1.Shared.Animals)
require(v_u_1.Shared.Index)
local v_u_17 = require(v_u_1.Datas.Mutations)
local v_u_18 = require(v_u_1.Datas.Rarities)
local v_u_19 = require(v_u_1.Datas.Animals)
local v_u_20 = require(v_u_1.Datas.Traits)
local v_u_21 = v9:RemoteEvent("BrainrotTraderService/Animation")
local v_u_22 = v9:RemoteEvent("BrainrotTraderService/Update")
local v_u_23 = v9:RemoteEvent("BrainrotTraderService/Return")
local v_u_24 = v9:RemoteEvent("BrainrotTraderService/Trade")
local v_u_25 = v9:RemoteFunction("BrainrotTraderService/Delivery")
local v_u_26 = v9:RemoteFunction("BrainrotTraderService/Fetch")
v9:RemoteEvent("ShopService/Purchase")
local v_u_27 = v_u_2.LocalPlayer
local v_u_28 = v_u_27.PlayerGui:WaitForChild("BrainrotTrader").BrainrotTrader
local v_u_29 = v_u_28.Frame
local _ = v_u_29.List
local v_u_30 = v_u_29.Header.Txt1
local v_u_31 = v_u_29.Header.Close
v_u_7.new()
v_u_7.new()
local v_u_32 = nil
local v_u_33 = nil
local v_u_34 = false
local v35 = {}
local function v_u_37()
	-- upvalues: (copy) v_u_3, (copy) v_u_27, (ref) v_u_34
	local v36 = v_u_3:Get(v_u_27)
	if v36 then
		if v_u_34 then
			return
		elseif workspace:FindFirstChild("BrainrotTrader") then
			if v36:Get("BrainrotTrader") then
				workspace:GetServerTimeNow()
				v_u_34 = true
				task.wait(2)
				v_u_34 = false
			end
		else
			return
		end
	else
		return
	end
end
local v_u_38 = v_u_7.new()
local function v_u_44()
	-- upvalues: (copy) v_u_38, (copy) v_u_3, (copy) v_u_27, (copy) v_u_30, (ref) v_u_33, (copy) v_u_13
	v_u_38:Clean()
	if v_u_3:Get(v_u_27) then
		v_u_30.Visible = false
		local v39 = workspace:FindFirstChild("BrainrotTrader")
		if v39 then
			local v40 = v39.Overhead.BillboardGui.Countdown
			if v40 then
				v_u_30.Visible = true
				local v41 = workspace:GetServerTimeNow()
				local v42 = (v_u_33 and v_u_33.Refresh or 0) - v41
				local v43 = ("Refreshes in %*"):format((v_u_13:E((math.max(v42, 0)))))
				v40.Text = v43
				v_u_30.Text = v43
			end
		else
			return
		end
	else
		return
	end
end
local v_u_45 = v_u_7.new()
local function v_u_50(p46, p47)
	-- upvalues: (copy) v_u_19, (copy) v_u_18, (copy) v_u_4, (copy) v_u_16
	local v48 = v_u_19[p47]
	if v48 then
		local v49 = v_u_18[v48.Rarity]
		p46.Title.Text = p47
		if v49.GradientPreset then
			p46.UIStroke.Color = Color3.new(1, 1, 1)
			p46.Title.TextColor3 = Color3.new(1, 1, 1)
			v_u_4.apply(p46.UIStroke, v49.GradientPreset)
			v_u_4.apply(p46.Title, v49.GradientPreset)
		else
			p46.UIStroke.Color = v49.Color
			p46.Title.TextColor3 = v49.Color
		end
		p46.Visible = true
		v_u_16:AttachOnViewportWithOptimizations(p47, p46.ViewportFrame)
	end
end
local v_u_51 = v_u_7.new()
local function v_u_87()
	-- upvalues: (copy) v_u_51, (ref) v_u_33, (copy) v_u_3, (copy) v_u_27, (copy) v_u_19, (copy) v_u_18, (copy) v_u_28, (copy) v_u_17, (copy) v_u_4, (copy) v_u_20
	v_u_51:Clean()
	if v_u_33 then
		local v52 = v_u_3:Get(v_u_27)
		if v52 then
			local v53 = v52:Get("BrainrotTrader.Info")
			if v53 then
				local v54 = {}
				for v55, v56 in v53 do
					local v57 = v56.Mutations
					local v58 = v56.Traits
					v57.Normal = nil
					if next(v57) or next(v58) then
						local v59 = v_u_33 and v_u_33.List[v55]
						if v59 then
							v59 = v_u_33.List[v55].Name
						end
						if v59 then
							local v60 = v_u_19[v59]
							if v60 then
								local v61 = string.match
								if tonumber(v61(v55, "(%d+)")) then
									local v62 = v_u_18[v60.Rarity]
									local v63 = 0
									for _, v64 in v57 do
										v63 = v63 + v64
									end
									local v65 = 0
									for _, v66 in v58 do
										v65 = v65 + v66
									end
									local v67 = v62.Weight * 10 + #v_u_33.List[v55].Recipe * 5 + v65 / 10 + v63 / 10
									local v68 = v_u_51:Clone(v_u_28.Odds.UIListLayout.Template)
									table.insert(v54, {
										["frame"] = v68,
										["score"] = v67
									})
									v68.Header.Title.Text = v59 or "???"
									for v69, v70 in v57 do
										local v71 = v_u_17[v69]
										if v71 then
											local v72 = v_u_51:Clone(v68.ScrollingFrame.UIListLayout.Template)
											v72.Name = v69
											v72.LayoutOrder = -v70
											v72.Vector.Image = v71.Icon or ""
											local v73 = v72.Title
											local v74
											if v71.UseRichText then
												v74 = v71.DisplayWithRichText
											else
												v74 = v71.DisplayText
											end
											v73.Text = v74
											v72.Title.RichText = v71.UseRichText
											if v71.GradientPreset then
												v72.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
												v_u_4.apply(v72.Title, v71.GradientPreset)
											else
												v72.Title.TextColor3 = v71.MainColor
											end
											local _, v75 = math.modf(v70)
											v72.Chance.Text = ("%*%%"):format((string.format(v75 == 0 and "%d" or "%.2f", v70)))
											v72.Visible = true
											v72.Parent = v68.ScrollingFrame
										end
									end
									for v76, v77 in v58 do
										local v78 = v_u_20[v76]
										if v78 then
											local v79 = v_u_51:Clone(v68.ScrollingFrame.UIListLayout.Template)
											v79.Name = v76
											v79.LayoutOrder = -v77
											v79.Vector.Image = v78.Icon or ""
											v79.Title.Text = v78.DisplayWithRichText
											v79.Title.TextColor3 = v78.Color
											v79.Title.RichText = true
											local _, v80 = math.modf(v77)
											v79.Chance.Text = ("%*%%"):format((string.format(v80 == 0 and "%d" or "%.2f", v77)))
											v79.Visible = true
											v79.Parent = v68.ScrollingFrame
										end
									end
								end
							end
						end
					end
				end
				table.sort(v54, function(p81, p82)
					return p81.score < p82.score
				end)
				local v83 = #v54 - 4
				for v84 = math.max(v83, 1), #v54 do
					local v85 = v54[v84].frame
					v85.LayoutOrder = -v84
					local v86
					if #v54 - 2 < v84 then
						v86 = v_u_28.Odds2
					else
						v86 = v_u_28.Odds
					end
					v85.Parent = v86
				end
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_129()
	-- upvalues: (copy) v_u_45, (ref) v_u_33, (copy) v_u_3, (copy) v_u_27, (copy) v_u_29, (copy) v_u_19, (copy) v_u_18, (copy) v_u_16, (copy) v_u_50, (copy) v_u_12, (copy) v_u_4, (copy) v_u_8, (copy) v_u_15, (copy) v_u_23, (copy) v_u_24, (copy) v_u_10
	v_u_45:Clean()
	if v_u_33 then
		local v_u_88 = v_u_3:Get(v_u_27)
		if v_u_88 then
			local v89 = v_u_29.List
			local v90 = {}
			for v_u_91, v92 in v_u_33.List do
				local v93 = string.match
				local v94 = tonumber(v93(v_u_91, "(%d+)"))
				if v94 then
					local v95 = v_u_19[v92.Name]
					if v95 then
						local _ = v_u_18[v95.Rarity]
						local v_u_96 = v92.Name
						local v97 = v_u_19[v_u_96]
						local v98 = v_u_45:Clone(v89.UIListLayout[v92.Template or "Normal"])
						v90[v94] = v98
						v98.Visible = true
						v98.LayoutOrder = ((v_u_16:GetGeneration(v92.Name) or 0) - 1) * 2
						local v_u_99 = v_u_45:Clone(v89.UIListLayout.Dropdown)
						v_u_99.LayoutOrder = v98.LayoutOrder + 1
						v_u_99.Size = UDim2.fromScale(0.973, 0)
						v_u_99.Visible = false
						v_u_99.Parent = v89
						v_u_50(v98.Spacer.Brainrot, v_u_96)
						v98.Spacer.DropRate.Text = ("$%*/s"):format((v_u_12:ToString(v_u_16:GetGeneration(v_u_96))))
						v98.Spacer.Txt.Text = v_u_96
						if v97 then
							local v100 = v_u_18[v97.Rarity]
							if v100.GradientPreset then
								v98.Spacer.Txt.TextColor3 = Color3.new(1, 1, 1)
								v_u_4.apply(v98.Spacer.Txt, v100.GradientPreset)
							else
								v98.Spacer.Txt.TextColor3 = v100.Color
							end
						end
						v98.Parent = v89
						local function v_u_102(p101)
							-- upvalues: (copy) v_u_99, (ref) v_u_8
							if p101 then
								v_u_99.Visible = true
								v_u_8.target(v_u_99, 0.9, 6, {
									["Size"] = UDim2.fromScale(0.973, 0.192)
								})
							else
								v_u_8.target(v_u_99, 1, 6, {
									["Size"] = UDim2.fromScale(0.973, 0)
								})
								v_u_8.completed(v_u_99, function()
									-- upvalues: (ref) v_u_99
									if v_u_99.Size.Y.Scale < 0.01 then
										v_u_99.Visible = false
									end
								end)
							end
						end
						local v_u_103 = {}
						for v104, v_u_105 in v92.Recipe do
							local v106 = v_u_19[v_u_105]
							if v106 then
								local v107 = v_u_18[v106.Rarity]
								local v108 = v_u_45:Clone(v98.Spacer.List.UIListLayout.Template)
								v108.LayoutOrder = v107.Weight * 100 + v104
								v108.Title.Text = v_u_105
								v108.Title.TextColor3 = Color3.new(1, 1, 1)
								if v107.GradientPreset then
									v108.UIStroke.Color = Color3.new(1, 1, 1)
									v_u_45:Add(v_u_4.apply(v108.UIStroke, v107.GradientPreset))
								else
									v108.UIStroke.Color = v107.Color
								end
								v108.Visible = true
								v108.Return.Visible = false
								v108.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)
								local v109 = v_u_16:AttachOnViewportWithOptimizations(v_u_105, v108.ViewportFrame, true)
								if v109 then
									v_u_45:Add(v109)
								end
								v108.Parent = v98.Spacer.List
								if not v_u_103[v_u_105] then
									v_u_103[v_u_105] = {}
								end
								local v110 = v_u_103[v_u_105]
								table.insert(v110, v108)
								local v111 = v_u_45:Add(v_u_15.new(v108.Return))
								v111:Animate()
								v_u_45:Add(v111.OnActivated:Connect(function()
									-- upvalues: (copy) v_u_88, (copy) v_u_105, (ref) v_u_23
									for v112, v113 in v_u_88:Get("AnimalPodiums") do
										if type(v113) == "table" and (v113.Index == v_u_105 and (v113.Machine and (v113.Machine.Type == "BrainrotTrader" and not v113.Machine.Active))) then
											v_u_23:FireServer(v112)
											return
										end
									end
								end))
							end
						end
						local function v127()
							-- upvalues: (copy) v_u_88, (copy) v_u_103, (copy) v_u_102, (copy) v_u_99
							local v114 = {}
							for _, v115 in v_u_88:Get("AnimalPodiums") do
								if type(v115) == "table" and (v115.Machine and (v115.Machine.Type == "BrainrotTrader" and not v115.Machine.Active)) then
									v114[v115.Index] = (v114[v115.Index] or 0) + 1
								end
							end
							local v116 = true
							for v117, v118 in v_u_103 do
								local v119 = v114[v117] or 0
								for v120, v121 in v118 do
									local v122 = v120 <= v119
									v121.Return.Visible = v122
									local v123 = v121.ViewportFrame
									local v124
									if v122 then
										v124 = Color3.new(1, 1, 1)
									else
										v124 = Color3.new(0, 0, 0)
									end
									v123.ImageColor3 = v124
									if not v122 then
										v116 = false
									end
								end
							end
							v_u_102(v116)
							v_u_99.Spacer.Spawn.Interactable = v116
							local v125 = v_u_99.Spacer.Spawn
							local v126
							if v116 then
								v126 = Color3.fromRGB(81, 158, 86)
							else
								v126 = Color3.fromRGB(127, 127, 127)
							end
							v125.BackgroundColor3 = v126
						end
						v_u_45:Add(v_u_88:OnChanged("AnimalAddedOrRemoved", v127))
						v_u_45:Add(task.spawn(v127))
						local v128 = v_u_15.new(v_u_99.Spacer.Spawn)
						v_u_45:Add(v128)
						v128:Animate()
						v_u_45:Add(v128.OnActivated:Connect(function()
							-- upvalues: (ref) v_u_24, (copy) v_u_91, (copy) v_u_96, (ref) v_u_10
							v_u_24:FireServer(v_u_91, v_u_96)
							v_u_10:Toggle("BrainrotTrader", false)
						end))
					end
				end
			end
		end
	else
		return
	end
end
function v35.Start(_)
	-- upvalues: (copy) v_u_28, (ref) v_u_32, (copy) v_u_10, (copy) v_u_31, (copy) v_u_3, (copy) v_u_27, (copy) v_u_44, (copy) v_u_6, (copy) v_u_37, (copy) v_u_5, (copy) v_u_7, (copy) v_u_2, (copy) v_u_25, (copy) v_u_11, (copy) v_u_1, (copy) v_u_21, (copy) v_u_14, (copy) v_u_22, (ref) v_u_33, (copy) v_u_129, (copy) v_u_87, (copy) v_u_26
	v_u_28.Visible = false
	v_u_32 = v_u_10:Register("BrainrotTrader", v_u_28, "TopQuint")
	v_u_32:AttachCloseButton(v_u_31)
	v_u_32:Close()
	v_u_3:WaitAndCall(v_u_27, function(p130)
		-- upvalues: (ref) v_u_44
		local function v131()
			-- upvalues: (ref) v_u_44
			task.spawn(v_u_44)
		end
		p130:OnChanged("BrainrotTrader", v131)
		p130:OnChanged("BrainrotTrader.Id", v131)
		task.spawn(v131)
	end)
	v_u_6.Simple(1, function()
		-- upvalues: (ref) v_u_37, (ref) v_u_44
		task.spawn(v_u_37)
		task.spawn(v_u_44)
	end)
	v_u_5.observeTag("BrainrotTraderPrompt", function(p_u_132)
		-- upvalues: (ref) v_u_7, (ref) v_u_3, (ref) v_u_27, (ref) v_u_6, (ref) v_u_10
		local v_u_133 = v_u_7.new()
		local function v_u_134()
			-- upvalues: (ref) v_u_3, (ref) v_u_27, (copy) p_u_132
			if v_u_3:Wait(v_u_27) then
				p_u_132.ActionText = "View"
				p_u_132.ObjectText = "Brainrot Trader"
			end
		end
		v_u_133:Add(task.spawn(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_27, (copy) v_u_134, (copy) v_u_133, (ref) v_u_6
			local v135 = v_u_3:Wait(v_u_27)
			if v135 then
				v135:OnChanged("BrainrotTrader", v_u_134)
				v_u_133:Add(v_u_6.Simple(1, v_u_134))
				task.spawn(v_u_134)
			end
		end))
		v_u_133:Add(p_u_132.Triggered:Connect(function()
			-- upvalues: (ref) v_u_3, (ref) v_u_27, (ref) v_u_10
			if v_u_3:Get(v_u_27) then
				v_u_10:Toggle("BrainrotTrader")
			end
		end))
		return function()
			-- upvalues: (copy) v_u_133
			v_u_133:Destroy()
		end
	end)
	v_u_5.observeTag("BrainrotTrader", function(p136)
		-- upvalues: (ref) v_u_7, (ref) v_u_2, (ref) v_u_27, (ref) v_u_25, (ref) v_u_11, (ref) v_u_1, (ref) v_u_44
		local v_u_137 = v_u_7.new()
		for _, v_u_138 in p136.Hitboxes:GetChildren() do
			v_u_137:Add(v_u_138.Touched:Connect(function(p139)
				-- upvalues: (ref) v_u_2, (ref) v_u_27, (ref) v_u_25, (copy) v_u_138, (ref) v_u_11, (ref) v_u_1, (ref) v_u_44
				if p139.Name == "HumanoidRootPart" then
					local v140 = v_u_2:GetPlayerFromCharacter(p139.Parent)
					if v140 and v140 == v_u_27 then
						if v140:GetAttribute("StealingIndex") then
							local v141, _, _ = v_u_25:InvokeServer(v_u_138)
							if not v141 then
								return
							end
							task.spawn(function()
								-- upvalues: (ref) v_u_11, (ref) v_u_1
								v_u_11:PlaySound(v_u_1.Sounds.Sfx["Fuse Machine"].Deposit)
							end)
							v_u_44()
						end
					end
				else
					return
				end
			end))
		end
		return function()
			-- upvalues: (copy) v_u_137
			v_u_137:Destroy()
		end
	end)
	v_u_5.observeTag("BrainrotTraderNPC", function(p_u_142)
		-- upvalues: (ref) v_u_7, (ref) v_u_21, (ref) v_u_1, (ref) v_u_11, (ref) v_u_14
		local v143 = v_u_7.new()
		local v144 = p_u_142.Humanoid.Animator
		local v_u_145 = v144:LoadAnimation(script.Idle)
		v143:Add(function()
			-- upvalues: (copy) v_u_145
			v_u_145:Stop(0)
			v_u_145:Destroy()
		end)
		v_u_145.Priority = Enum.AnimationPriority.Idle
		v_u_145.Looped = true
		v_u_145:Play()
		local v_u_146 = v144:LoadAnimation(script.IdleToAction)
		v143:Add(function()
			-- upvalues: (copy) v_u_146
			v_u_146:Stop(0)
			v_u_146:Destroy()
		end)
		v_u_146.Priority = Enum.AnimationPriority.Action
		local v_u_147 = v144:LoadAnimation(script.ActionIdle)
		v143:Add(function()
			-- upvalues: (copy) v_u_147
			v_u_147:Stop(0)
			v_u_147:Destroy()
		end)
		v_u_147.Priority = Enum.AnimationPriority.Movement
		v_u_147.Looped = true
		local v_u_148 = v144:LoadAnimation(script.ActionToIdle)
		v143:Add(function()
			-- upvalues: (copy) v_u_148
			v_u_148:Stop(0)
			v_u_148:Destroy()
		end)
		v_u_148.Priority = Enum.AnimationPriority.Action
		v143:Add(v_u_146.Stopped:Connect(function()
			-- upvalues: (copy) v_u_147
			v_u_147:Play()
		end))
		v143:Add(v_u_147.Stopped:Connect(function()
			-- upvalues: (copy) v_u_148
			v_u_148:Play()
		end))
		v143:Add(v_u_21.OnClientEvent:Connect(function(_, p_u_149)
			-- upvalues: (copy) v_u_146, (copy) p_u_142, (ref) v_u_1, (ref) v_u_11, (ref) v_u_14, (copy) v_u_147
			local v150 = script.SpawnEffects:FindFirstChild(p_u_149) or script.SpawnEffects.Rare
			if v150 then
				v_u_146:Play()
				task.wait(0.5)
				local v_u_151 = p_u_142:GetPivot() * CFrame.new(0, 3.5, -3)
				task.spawn(function()
					-- upvalues: (ref) v_u_1, (copy) p_u_149, (ref) v_u_11, (copy) v_u_151
					local v152 = v_u_1.Sounds.Sfx.Merchant:FindFirstChild(p_u_149)
					if v152 then
						v_u_11:PlaySound(v152, v_u_151.Position)
					end
				end)
				local v153 = v150:Clone()
				v153:PivotTo(v_u_151)
				v153.Parent = workspace
				v_u_14.emit(v153)
				task.wait(2.5)
				v_u_147:Stop()
			end
		end))
		return v143:WrapClean()
	end, { workspace })
	v_u_22.OnClientEvent:Connect(function(p154)
		-- upvalues: (ref) v_u_33, (ref) v_u_129, (ref) v_u_87
		v_u_33 = p154
		v_u_129()
		v_u_87()
	end)
	v_u_33 = v_u_26:InvokeServer() or v_u_33
	task.spawn(v_u_129)
	v_u_3:WaitAndCall(v_u_27, function(p155)
		-- upvalues: (ref) v_u_87, (ref) v_u_129
		p155:OnChanged("BrainrotTrader.Info", v_u_87)
		task.spawn(v_u_87)
		v_u_129()
	end)
end
return v35
