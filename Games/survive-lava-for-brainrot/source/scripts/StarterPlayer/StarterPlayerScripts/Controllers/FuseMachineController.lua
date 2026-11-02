-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v_u_2 = game:GetService("MarketplaceService")
local v3 = game:GetService("Players")
local v_u_4 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v5 = game:GetService("SoundService")
local v6 = game:GetService("StarterPlayer")
local v7 = v_u_4.Remotes.FuseMachine
local v_u_8 = v7.PickUpBrainrot
local v_u_9 = v7.PlaceBrainrot
local v_u_10 = v7.StartFuse
local v_u_11 = v7.SkipFuse
local v_u_12 = v7.CollectResult
local v_u_13 = v7.PlaySound
local v_u_14 = v5.SFX
local v_u_15 = v_u_14.FuseIdleLoop
local v_u_16 = v_u_14.FuseOnLoop
local v_u_17 = v3.LocalPlayer
local v_u_18 = v_u_17:WaitForChild("PlayerGui"):WaitForChild("HUD"):WaitForChild("FuseMachine")
local v_u_19 = v_u_18:WaitForChild("Header"):WaitForChild("Header"):WaitForChild("CloseButton")
local v_u_20 = v_u_18:WaitForChild("Insider"):WaitForChild("Brainrots")
local v_u_21 = v_u_20:WaitForChild("BrainrotTemplate"):Clone()
local v_u_22 = v_u_18:WaitForChild("PossibleOutcomes"):WaitForChild("Brainrots")
local v_u_23 = v_u_22:WaitForChild("BrainrotTemplate"):Clone()
local v_u_24 = v_u_18:WaitForChild("BuyButton")
local v_u_25 = v_u_24:WaitForChild("Display")
local v_u_26 = v_u_18:WaitForChild("SkipButton")
local v_u_27 = v_u_26:WaitForChild("Display")
local v_u_28 = v_u_18:WaitForChild("Mutations"):WaitForChild("Content")
local v_u_29 = v_u_28:WaitForChild("MutationTemplate"):Clone()
local v_u_30 = v_u_18:WaitForChild("Traits"):WaitForChild("Content")
local v_u_31 = v_u_30:WaitForChild("TraitTemplate"):Clone()
local v32 = v_u_18:WaitForChild("FuseLuck")
local v_u_33 = v32:WaitForChild("BuyButton")
local v_u_34 = v_u_33:WaitForChild("Display")
local v_u_35 = v32:WaitForChild("Remaining")
local v_u_36 = require(v_u_4.Registries.BrainrotRegistry)
local v_u_37 = require(v_u_4.Registries.FuseMachineRegistry)
local v_u_38 = require(v_u_4.Registries.MutationRegistry)
local v_u_39 = require(v_u_4.Registries.RarityRegistry)
local v_u_40 = require(v_u_4.Registries.TraitsRegistry)
local v_u_41 = require(v_u_4.Enums.ItemTypes)
require(v_u_4.Types.ItemSchemas)
local v_u_42 = require(v_u_4.Modules.DataController)
local v_u_43 = require(v6.StarterPlayerScripts.Controllers.UIController)
require(v_u_4.Modules.CreateBrainrotModel)
require(v_u_4.Modules.GetExactBoundingBox)
local v_u_44 = require(v_u_4.Shared.FormatNumber)
local v_u_45 = require(v_u_4.Registries.UpdateConfig)
local v_u_46 = require(v_u_4.Modules.GetFuseMachineAverageTier)
require(v_u_4.Modules.GetFuseLuckMultiplierFromEntries)
local v_u_47 = require(v_u_4.Modules.GetPossibleFuseMachineBrainrots)
local v_u_48 = require(v_u_4.Modules.GetPossibleFuseMachineMutations)
local v_u_49 = require(v_u_4.Modules.GetPossibleFuseMachineTraits)
local v_u_50 = require(v_u_4.Modules.VisualizeBrainrotOnObject)
local v_u_51 = require(v_u_4.Modules.VisualizeBrainrotInViewport)
local v_u_52 = workspace:WaitForChild("GameFolder")
local v_u_53 = workspace:WaitForChild("FusionArea")
local v_u_54 = {}
local v_u_55 = {}
local v_u_56 = 99
local v_u_57 = 499
local function v_u_62(p58)
	-- upvalues: (copy) v_u_37, (copy) v_u_62
	local v59 = 1
	for _, v60 in v_u_37 do
		local v61 = v60.Value
		v59 = math.max(v59, v61)
		if v60.Value == p58 then
			return v60
		end
	end
	if v59 < p58 then
		return v_u_62(v59)
	else
		return v_u_37.Common
	end
end
function v_u_54.UpdateTimerText(_)
	-- upvalues: (copy) v_u_42, (copy) v_u_46, (copy) v_u_62, (copy) v_u_25, (copy) v_u_44, (copy) v_u_27, (ref) v_u_56, (copy) v_u_26, (copy) v_u_34, (ref) v_u_57, (copy) v_u_35, (ref) v_u_55
	local v63 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	if v63 then
		local v64 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.Cash)
		if v64 then
			local v65 = workspace:GetServerTimeNow()
			local v66 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
			local v67
			if v66 then
				v67 = 0
				for _ in v66.Entries do
					v67 = v67 + 1
				end
			else
				v67 = 0
			end
			local v68 = 0
			if v67 >= 4 and not (v63.Fusing or v63.Result) then
				local v69 = v_u_46(v63.Entries)
				v68 = v_u_62((math.floor(v69))).Price
				local v70 = v_u_25
				local v71
				if v68 <= v64 then
					v71 = Color3.fromRGB(255, 255, 255)
				else
					v71 = Color3.fromRGB(255, 0, 0)
				end
				v70.TextColor3 = v71
			else
				v_u_25.TextColor3 = Color3.fromRGB(255, 255, 255)
			end
			local v72
			if v63.Result then
				v72 = "Ready!"
			elseif v67 >= 4 then
				v72 = ("$%*"):format((v_u_44(v68)))
			else
				v72 = ("%*/%*"):format(v67, 4)
			end
			local v73 = v63.Result and "Ready!" or ("%*/%*"):format(v67, 4)
			if v63.Fusing then
				local v74 = v_u_46(v63.Entries)
				local v75 = v_u_62((math.floor(v74))).FuseDuration
				local v76 = v65 - v63.StartedFuse
				local v77 = v75 - v76
				local v78 = math.clamp(v77, 0, v75)
				local v79 = math.round(v78)
				local v80 = v79 / 60
				local v81 = ("%*m %*s"):format(math.floor(v80), v79 % 60)
				v72 = v75 < v76 and "Ready!" or v81
				v73 = v72
			end
			v_u_25.Text = v72
			v_u_27.Text = ("Skip! \238\128\130%*"):format((v_u_44(v_u_56)))
			v_u_26.Visible = v63.Fusing
			v_u_34.Text = ("Buy \238\128\130%*"):format((v_u_44(v_u_57)))
			if v63.FuseLuckEndTime < v65 then
				v_u_35.Visible = false
			else
				v_u_35.Visible = true
				local v82 = v_u_35
				local v83 = "%* Remaining"
				local v84 = v63.FuseLuckEndTime - v65
				local v85 = math.round(v84)
				local v86 = v85 / 60
				local v87 = math.floor(v86)
				local v88 = v85 % 60
				local v89
				if v87 < 10 then
					v89 = ("0%*"):format(v87)
				else
					v89 = tostring(v87)
				end
				local v90
				if v88 < 10 then
					v90 = ("0%*"):format(v88)
				else
					v90 = tostring(v88)
				end
				v82.Text = v83:format((("%*:%*"):format(v89, v90)))
			end
			for _, v91 in v_u_55 do
				v91:WaitForChild("TimerDisplay"):WaitForChild("SurfaceGui"):WaitForChild("Display").Text = v73
			end
		end
	else
		return
	end
end
function v_u_54.Render(_)
	-- upvalues: (copy) v_u_42, (copy) v_u_20, (copy) v_u_22, (copy) v_u_54, (copy) v_u_21, (copy) v_u_36, (copy) v_u_38, (copy) v_u_39, (copy) v_u_51, (copy) v_u_47, (copy) v_u_23, (copy) v_u_48, (copy) v_u_49, (copy) v_u_28, (copy) v_u_30, (copy) v_u_29, (copy) v_u_40, (copy) v_u_31
	local v92 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	if not v92 then
		return
	end
	for _, v93 in v_u_20:GetChildren() do
		if v93:IsA("GuiObject") and not v93.Name:match("Plus") then
			v93:Destroy()
		end
	end
	for _, v94 in v_u_22:GetChildren() do
		if v94:IsA("GuiObject") then
			v94:Destroy()
		end
	end
	local v95 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	if v95 then
		local v96 = 0
		for _ in v95.Entries do
			v96 = v96 + 1
		end
	end
	local v97 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	local v98
	if v97 then
		v98 = v97.FuseLuckEndTime >= workspace:GetServerTimeNow() and true or v97.LuckAppliedToFuse
	else
		v98 = false
	end
	v_u_54:UpdateTimerText()
	for v99 = 1, 4 do
		local v100 = v_u_21:Clone()
		v100.LayoutOrder = (v99 - 1) * 2 + 1
		local v101 = nil
		for v102 in v92.Entries do
			if (tonumber(v102:sub(6)) or 0) == v99 then
				v101 = v102
				break
			end
		end
		if v101 then
			local v103 = v92.Entries[v101]
			if v103 then
				local v104 = v103.Metadata
				local v105 = v104.Name
				local v106 = v104.Mutation
				local v107 = v105:gsub("(%u)", " %1"):gsub("^ ", "")
				local v108 = v_u_36[v105]
				if v108 then
					if v_u_38[v106] then
						local v109 = v_u_39[v108.Rarity]
						if v109 then
							v100.NameLabel.Text = v107
							v100.RarityLabel.Text = v108.Rarity
							v100.RarityLabel.TextColor3 = v109.Color
							v100.Parent = v_u_20
							if v109.Tag then
								v100.RarityLabel:AddTag(v109.Tag)
							end
							v_u_51(v105, v106, v100.Viewport)
						else
							warn((("Rarity entry not found: %*"):format(v108.Rarity)))
						end
					else
						warn((("Mutation entry not found: %*"):format(v106)))
					end
				else
					warn((("Brainrot entry not found: %*"):format(v105)))
				end
			else
				warn(("ItemEntry not found: %*"):format(v101), v92.Entries)
			end
		else
			v100.NameLabel.Visible = false
			v100.RarityLabel.Visible = false
			v100.Parent = v_u_20
		end
	end
	local v_u_110 = v_u_47(v92.Entries, v98)
	local v111 = {}
	for v112, _ in v_u_110 do
		table.insert(v111, v112)
	end
	table.sort(v111, function(p113, p114)
		-- upvalues: (copy) v_u_110
		return v_u_110[p113] > v_u_110[p114]
	end)
	for v115, v116 in v111 do
		local v117 = v116:gsub("(%u)", " %1"):gsub("^ ", "")
		local v118 = v_u_110[v116]
		local v119 = v_u_36[v116]
		if v119 then
			local v120 = v_u_39[v119.Rarity]
			if v120 then
				local v121 = v_u_23:Clone()
				v121.LayoutOrder = v115
				local v122 = v121.Percentage
				local v123 = v118 * 100
				v122.Text = ("%*%%"):format((math.round(v123)))
				v121.NameLabel.Text = v117
				v121.NameLabel.TextColor3 = v120.Color
				v121.Parent = v_u_22
				if v120.Tag then
					v121.NameLabel:AddTag(v120.Tag)
				end
				v_u_51(v116, "Normal", v121.Viewport)
			end
		end
	end
	local v124 = v_u_48(v92.Entries, v98)
	local v125 = v_u_49(v92.Entries, v98)
	for _, v126 in v_u_28:GetChildren() do
		if v126:IsA("GuiObject") and not v126.Name:match("Padding") then
			v126:Destroy()
		end
	end
	for _, v127 in v_u_30:GetChildren() do
		if v127:IsA("GuiObject") and not v127.Name:match("Padding") then
			v127:Destroy()
		end
	end
	for v128, v129 in v124 do
		local v130 = v_u_38[v128]
		if v130 then
			local v131 = v_u_29:Clone()
			v131.DisplayName.Text = v128
			v131.DisplayName.TextColor3 = v130.Color
			local v132 = v131.Percentage
			local v133 = v129 * 100
			v132.Text = ("%*%%"):format((math.round(v133)))
			v131.Parent = v_u_28
		end
	end
	for v134, v135 in v125 do
		local v136 = v_u_40[v134]
		if v136 then
			local v137 = v_u_31:Clone()
			v137.Icon.Image = v136.Icon
			v137.DisplayName.Text = v136.DisplayName
			v137.DisplayName.TextColor3 = v136.Color
			local v138 = v137.Percentage
			local v139 = v135 * 100
			v138.Text = ("%*%%"):format((math.round(v139)))
			v137.Parent = v_u_30
		end
	end
end
function v_u_54.UpdateModels(_)
	-- upvalues: (copy) v_u_42, (ref) v_u_55, (copy) v_u_50
	local v140 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	if not v140 then
		return
	end
	local v141 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
	local v142
	if v141 then
		v142 = 0
		for _ in v141.Entries do
			v142 = v142 + 1
		end
	else
		v142 = 0
	end
	for _, v143 in v_u_55 do
		local v144 = v143:WaitForChild("Places")
		local v145 = v143:WaitForChild("Brainrots")
		local v146 = v143:WaitForChild("Result")
		local v147 = v146:WaitForChild("CollectAttachment"):WaitForChild("CollectPrompt")
		local v148 = v143:WaitForChild("UIButton"):WaitForChild("Main")
		local v149 = v146:WaitForChild("FuseOnLoop")
		local v150 = v148:WaitForChild("FuseIdleLoop")
		if v140.Fusing then
			if not v149.IsPlaying then
				v149:Play()
			end
		elseif v149.IsPlaying then
			v149:Stop()
		end
		if v142 > 0 then
			if not v150.IsPlaying then
				v150:Play()
			end
		elseif v150.IsPlaying then
			v150:Stop()
		end
		for _, v151 in v144:GetChildren() do
			local v152 = v151:WaitForChild("PlacePrompt", 3)
			if v152 then
				local v153 = v151:WaitForChild("Top", 3)
				if v153 then
					local v154 = v151:WaitForChild("Bottom", 3)
					if v154 then
						local v155 = v151.Name
						local v156 = ("Place%*"):format(v155)
						local v157 = v145:FindFirstChild(v155)
						if v157 then
							v157:Destroy()
						end
						local v158 = v140.Entries[v156]
						if v158 then
							for _, v159 in v153:GetDescendants() do
								if v159:IsA("ParticleEmitter") then
									v159.Enabled = true
								end
							end
							for _, v160 in v154:GetDescendants() do
								if v160:IsA("Beam") then
									v160.Enabled = true
								end
							end
							local v161 = v158.Metadata.Name:gsub("(%u)", " %1"):gsub("^ ", "")
							v152.ActionText = "Pick Up"
							v152.ObjectText = v161
							v152.Enabled = not v140.Fusing
							local v162 = v_u_50(v158.Metadata.Name, v158.Metadata.Mutation, 3, v151)
							if v162 then
								v162.Name = v155
								v162.Parent = v145
								if not v157 then
									local v163 = v151:WaitForChild("PlaceEffect", 3)
									if v163 then
										for _, v164 in v163:GetDescendants() do
											if v164:IsA("ParticleEmitter") then
												v164:Emit(v164:GetAttribute("EmitCount") or 1)
											end
										end
									end
								end
							end
						else
							v152.ActionText = "Place"
							v152.ObjectText = ("Slot %*"):format(v155)
							for _, v165 in v153:GetDescendants() do
								if v165:IsA("ParticleEmitter") then
									v165.Enabled = false
								end
							end
							for _, v166 in v154:GetDescendants() do
								if v166:IsA("Beam") then
									v166.Enabled = false
								end
							end
							v152.Enabled = not v140.Fusing
						end
					else
						warn("Could not find place bottom attachment", v151)
					end
				else
					warn("Could not find place top attachment", v151)
				end
			else
				warn("Could not find place prompt", v151)
			end
		end
		local v167 = v145:FindFirstChild("Result")
		if v167 then
			v167:Destroy()
		end
		v147.Enabled = v140.Result ~= nil
		if v140.Result then
			local v168 = v140.ResultMetadata or {}
			v147.ObjectText = v140.Result:gsub("(%u)", " %1"):gsub("^ ", "")
			local v169 = v_u_50(v140.Result, v168.Mutation or "Normal", 5, v146)
			v169.Name = "Result"
			v169.Parent = v145
			if v167 then
				goto l63
			end
			local v170 = v146:WaitForChild("PlaceEffect", 3)
			if v170 then
				for _, v171 in v170:GetDescendants() do
					if v171:IsA("ParticleEmitter") then
						v171:Emit(v171:GetAttribute("EmitCount") or 1)
					end
				end
				goto l63
			end
		else
			::l63::
			local v172 = v146:WaitForChild("TopBeamsFx", 3)
			local v173 = v146:WaitForChild("BottomFx", 3)
			if v172 and v173 then
				for _, v174 in v172:GetDescendants() do
					if v174:IsA("Beam") or v174:IsA("ParticleEmitter") then
						v174.Enabled = v140.Fusing
					end
				end
				for _, v175 in v173:GetDescendants() do
					if v175:IsA("Beam") or v175:IsA("ParticleEmitter") then
						v175.Enabled = v140.Fusing
					end
				end
			end
		end
	end
end
function v_u_54.RigModel(_, p176)
	-- upvalues: (copy) v_u_16, (copy) v_u_15, (copy) v_u_43, (copy) v_u_18, (copy) v_u_54, (copy) v_u_12, (copy) v_u_42, (copy) v_u_17, (copy) v_u_8, (copy) v_u_41, (copy) v_u_9
	local v177 = p176:WaitForChild("UIButton")
	local v178 = p176:WaitForChild("Places")
	local v179 = p176:WaitForChild("Result")
	v_u_16:Clone().Parent = v179
	v_u_15:Clone().Parent = v177.Main
	local v180 = Instance.new("ProximityPrompt")
	v180.ActionText = "Open"
	v180.ObjectText = "Fuse Machine"
	v180.HoldDuration = 0
	v180.MaxActivationDistance = 7
	v180.RequiresLineOfSight = false
	v180.Parent = v177.Main
	v180.Triggered:Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if not v_u_43:IsFrameOpen(v_u_18) then
			v_u_43:OpenFrame(v_u_18)
		end
		v_u_54:Render()
	end)
	local v181 = Instance.new("Attachment")
	v181.Name = "CollectAttachment"
	v181.Position = Vector3.new(0, 2, 0)
	v181.Parent = v179
	local v182 = Instance.new("ProximityPrompt")
	v182.Name = "CollectPrompt"
	v182.ActionText = "Collect"
	v182.ObjectText = "Brainrot"
	v182.HoldDuration = 0
	v182.MaxActivationDistance = 7
	v182.RequiresLineOfSight = false
	v182.Enabled = false
	v182.Parent = v181
	v182.Triggered:Connect(function()
		-- upvalues: (ref) v_u_12
		v_u_12:FireServer()
	end)
	for _, v183 in v178:GetChildren() do
		local v_u_184 = v183.Name
		local v_u_185 = ("Place%*"):format(v_u_184)
		local v186 = Instance.new("ProximityPrompt")
		v186.Name = "PlacePrompt"
		v186.ActionText = "Place"
		v186.ObjectText = ("Slot %*"):format(v183.Name)
		v186.HoldDuration = 0
		v186.MaxActivationDistance = 7
		v186.RequiresLineOfSight = false
		v186.Parent = v183
		v186.Triggered:Connect(function()
			-- upvalues: (ref) v_u_42, (ref) v_u_17, (copy) v_u_185, (ref) v_u_8, (copy) v_u_184, (ref) v_u_43, (ref) v_u_41, (ref) v_u_9
			local v187 = v_u_42:GetPlayerDataAsync()
			if v187 then
				local v188 = v_u_17.Character
				if v188 then
					if v187.FuseMachine.Entries[v_u_185] then
						v_u_8:FireServer(v_u_184)
						return
					else
						local v189 = v188:FindFirstChildWhichIsA("Tool")
						if v189 then
							local v190 = v189:GetAttribute("UUID")
							if v190 then
								local v191 = v187.Inventory.Entries[v190]
								if v191 then
									if v191.Type == v_u_41.Brainrot then
										v_u_9:FireServer(v_u_184, v190)
									else
										v_u_43:ShowNotification("Equip a brainrot to place!", {
											["Color"] = Color3.new(1, 0, 0),
											["Sound"] = "Error"
										})
									end
								else
									v_u_43:ShowNotification("Equip a brainrot to place!", {
										["Color"] = Color3.new(1, 0, 0),
										["Sound"] = "Error"
									})
									return
								end
							else
								v_u_43:ShowNotification("Equip a brainrot to place!", {
									["Color"] = Color3.new(1, 0, 0),
									["Sound"] = "Error"
								})
								return
							end
						else
							v_u_43:ShowNotification("Equip a brainrot to place!", {
								["Color"] = Color3.new(1, 0, 0),
								["Sound"] = "Error"
							})
							return
						end
					end
				else
					return
				end
			else
				return
			end
		end)
	end
end
function v_u_54.Init(_)
	-- upvalues: (ref) v_u_55, (copy) v_u_1, (copy) v_u_54, (copy) v_u_19, (copy) v_u_43, (copy) v_u_18, (copy) v_u_24, (copy) v_u_42, (copy) v_u_11, (copy) v_u_10, (copy) v_u_26, (copy) v_u_33, (copy) v_u_2, (copy) v_u_17, (copy) v_u_13, (copy) v_u_14, (ref) v_u_56, (ref) v_u_57, (copy) v_u_45, (copy) v_u_52, (copy) v_u_4, (copy) v_u_53
	v_u_55 = v_u_1:GetTagged("FuseMachine")
	for _, v192 in v_u_55 do
		v_u_54:RigModel(v192)
	end
	v_u_1:GetInstanceAddedSignal("FuseMachine"):Connect(function(p193)
		-- upvalues: (ref) v_u_55, (ref) v_u_54
		if not table.find(v_u_55, p193) then
			local v194 = v_u_55
			table.insert(v194, p193)
			v_u_54:RigModel(p193)
			v_u_54:UpdateModels()
		end
	end)
	v_u_19.Activated:Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18
		v_u_43:CloseFrame(v_u_18)
	end)
	v_u_24.Activated:Connect(function()
		-- upvalues: (ref) v_u_42, (ref) v_u_11, (ref) v_u_10
		local v195 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
		if v195 then
			if v195.Fusing then
				if not v195.Result then
					v_u_11:FireServer()
				end
			else
				v_u_10:FireServer()
			end
		else
			return
		end
	end)
	v_u_26.Activated:Connect(function()
		-- upvalues: (ref) v_u_11
		v_u_11:FireServer()
	end)
	v_u_33.Activated:Connect(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_17
		v_u_2:PromptProductPurchase(v_u_17, 3540252946)
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.FuseMachine.Entries["*"]):Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if v_u_43:IsFrameOpen(v_u_18) then
			v_u_54:Render()
		end
		v_u_54:UpdateModels()
		v_u_54:UpdateTimerText()
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.FuseMachine.Result):Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if v_u_43:IsFrameOpen(v_u_18) then
			v_u_54:Render()
		end
		v_u_54:UpdateModels()
		v_u_54:UpdateTimerText()
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.FuseMachine.ResultMetadata):Connect(function()
		-- upvalues: (ref) v_u_54
		v_u_54:UpdateModels()
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.FuseMachine.Fusing):Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if v_u_43:IsFrameOpen(v_u_18) then
			v_u_54:Render()
		end
		v_u_54:UpdateModels()
		v_u_54:UpdateTimerText()
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.FuseMachine.FuseLuckEndTime):Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if v_u_43:IsFrameOpen(v_u_18) then
			v_u_54:Render()
		end
	end)
	v_u_42:GetPathSignal(v_u_42.PathBuilder.Cash):Connect(function()
		-- upvalues: (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		if v_u_43:IsFrameOpen(v_u_18) then
			v_u_54:UpdateTimerText()
		end
	end)
	v_u_13.OnClientEvent:Connect(function(p196)
		-- upvalues: (ref) v_u_14
		local v197 = v_u_14:FindFirstChild(p196)
		if v197 then
			v197:Play()
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_42, (ref) v_u_43, (ref) v_u_18, (ref) v_u_54
		while true do
			repeat
				task.wait(1)
				local v198 = v_u_42:GetValueFromPathAsync(v_u_42.PathBuilder.FuseMachine)
			until v198 and (v_u_43:IsFrameOpen(v_u_18) or v198.Fusing)
			v_u_54:UpdateTimerText()
		end
	end)
	v_u_54:UpdateModels()
	v_u_54:UpdateTimerText()
	pcall(function()
		-- upvalues: (ref) v_u_2, (ref) v_u_56, (ref) v_u_57
		local v199 = v_u_2:GetProductInfoAsync(3539059645, Enum.InfoType.Product)
		if v199 then
			v_u_56 = v199.PriceInRobux
		end
		local v200 = v_u_2:GetProductInfoAsync(3540252946, Enum.InfoType.Product)
		if v200 then
			v_u_57 = v200.PriceInRobux
		end
	end)
	task.spawn(function()
		-- upvalues: (ref) v_u_45, (ref) v_u_55, (ref) v_u_52, (ref) v_u_4, (ref) v_u_53
		while true do
			local v201 = workspace:GetServerTimeNow()
			local v202 = v_u_45.UpdateName ~= "FuseMachine" and true or v_u_45.UpdateTime <= v201
			for _, v203 in v_u_55 do
				local v204
				if v202 then
					v204 = v_u_52
				else
					v204 = v_u_4
				end
				v203.Parent = v204
			end
			local v205 = v_u_53
			local v206
			if v202 then
				v206 = v_u_52
			else
				v206 = v_u_4
			end
			v205.Parent = v206
			task.wait(1)
		end
	end)
end
return v_u_54
