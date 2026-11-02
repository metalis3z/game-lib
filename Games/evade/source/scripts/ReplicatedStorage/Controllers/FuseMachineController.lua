-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Medal in Seliware

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("ContentProvider")
game:GetService("TweenService")
game:GetService("RunService")
local v_u_3 = game:GetService("Players")
local v_u_4 = require(v_u_1.Packages.Synchronizer)
require(v_u_1.Packages.CreateTween)
local v_u_5 = require(v_u_1.Packages.Gradients)
local v_u_6 = require(v_u_1.Packages.Observers)
local v_u_7 = require(v_u_1.Packages.Trove)
local v8 = require(v_u_1.Packages.Net)
local v_u_9 = require(v_u_1.Controllers.NotificationController)
local v_u_10 = require(v_u_1.Controllers.InterfaceController)
require(v_u_1.Controllers.AnimalController)
local v_u_11 = require(v_u_1.Controllers.SoundController)
local v_u_12 = require(v_u_1.Classes.AnimatedButton)
local v_u_13 = require(v_u_1.Datas.FuseMachineData)
local v_u_14 = require(v_u_1.Shared.Mutations)
local v_u_15 = require(v_u_1.Shared.Animals)
local v_u_16 = require(v_u_1.Datas.Mutations)
local v_u_17 = require(v_u_1.Utils.NumberUtils)
require(v_u_1.Shared.Index)
local v_u_18 = require(v_u_1.Datas.Rarities)
local v_u_19 = require(v_u_1.Datas.Animals)
local v_u_20 = require(v_u_1.Utils.TimeUtils)
require(v_u_1.Utils.MathUtils)
local v_u_21 = require(v_u_1.Datas.Traits)
require(v_u_1.Shared.Updates)
require(v_u_1.Shared.Animals)
local v_u_22 = require(v_u_1.Packages.Timer)
require(v_u_1.Packages.Spr)
local v_u_23 = require(v_u_1.Shared.VFX)
local v_u_24 = v8:RemoteEvent("ShopService/Purchase")
local v_u_25 = v_u_3.LocalPlayer
local v_u_26 = v_u_25.PlayerGui:WaitForChild("FuseMachine").FuseMachine
local v_u_27 = v_u_26.Brainrots
local v_u_28 = v_u_26.Fusions
local v_u_29 = v_u_26.FusionsOld
local v_u_30 = v_u_26.Time
local v_u_31 = v_u_26.Buy
local v_u_32 = v_u_26.Header.Close
local v_u_33 = v_u_7.new()
v_u_7.new()
local v_u_34 = nil
local v_u_35 = {}
local function v_u_41(p36)
	local v37 = {}
	for v38, v39 in p36 do
		if v39.Machine and v39.Machine.Type == "Fuse" then
			local v40 = table.clone(v39)
			v40.IndexOnPlot = v38
			table.insert(v37, v40)
		end
	end
	return v37
end
local v_u_42 = nil
local v_u_43 = v_u_7.new()
local function v_u_59()
	-- upvalues: (copy) v_u_4, (copy) v_u_25, (copy) v_u_43, (copy) v_u_41, (copy) v_u_13, (copy) v_u_27, (copy) v_u_19, (copy) v_u_18, (copy) v_u_16, (copy) v_u_5, (copy) v_u_12, (copy) v_u_9, (copy) v_u_15
	local v44 = v_u_4:Get(v_u_25)
	if v44 then
		v_u_43:Clean()
		local v45 = v_u_41(v44:Get("AnimalPodiums"))
		if v45 then
			for v46 = 1, v_u_13.FuseSlots do
				local v_u_47 = v45[v46]
				if v_u_47 and v_u_47 ~= "Empty" then
					local v48 = v_u_19[v_u_47.Index]
					local v49 = v_u_18[v48.Rarity]
					local v50 = v_u_43:Clone(v_u_27.Template)
					v50.Name = ("%*.%*"):format(v48.DisplayName, v46)
					v50.LayoutOrder = v46
					v50.BrainrotName.Text = v48.DisplayName
					if v_u_47.Mutation then
						local v51 = v_u_16[v_u_47.Mutation]
						local v52 = v50.Mutation
						local v53
						if v51.UseRichText then
							v53 = v51.DisplayWithRichText
						else
							v53 = v51.DisplayText
						end
						v52.Text = v53
						v50.Mutation.RichText = v51.UseRichText
						if v51.GradientPreset then
							v50.Mutation.TextColor3 = Color3.fromRGB(255, 255, 255)
							v_u_5.apply(v50.Mutation, v51.GradientPreset)
						else
							v50.Mutation.TextColor3 = v51.MainColor
						end
					end
					v50.Rarity.Text = v48.Rarity
					if v49.GradientPreset then
						v50.Rarity.TextColor3 = Color3.fromRGB(255, 255, 255)
						v_u_5.apply(v50.Rarity, v49.GradientPreset)
					else
						v50.Rarity.TextColor3 = v49.Color
					end
					v50.Visible = true
					v50.Parent = v_u_27
					local v54 = v_u_12.new(v50.Return)
					v_u_43:Add(v54)
					v54:Animate()
					v_u_43:Add(v54.OnActivated:Connect(function()
						-- upvalues: (ref) v_u_13, (copy) v_u_47, (ref) v_u_9
						local v55, v56 = v_u_13.Remotes.RemoveBrainrot:InvokeServer(v_u_47.IndexOnPlot)
						if not v55 then
							v_u_9:Error(v56 or "Something went wrong!")
						end
					end))
					local v57 = v_u_15:AttachOnViewport(v48.DisplayName, v50.ViewportFrame, true, v_u_47.Mutation and v_u_47.Mutation or nil)
					if v57 then
						v_u_43:Add(v57)
					end
				else
					local v58 = v_u_43:Clone(v_u_27.Template)
					v58.Name = ("Empty.%*"):format(v46)
					v58.LayoutOrder = v46
					v58.Visible = true
					v58.BrainrotName.Text = "Empty"
					v58.BrainrotName.TextColor3 = Color3.fromRGB(255, 112, 112)
					v58.Return:Destroy()
					v58.Rarity:Destroy()
					v58.Mutation:Destroy()
					v58.ViewportFrame:Destroy()
					v58.Parent = v_u_27
				end
			end
		end
	else
		return
	end
end
local function v_u_92()
	-- upvalues: (copy) v_u_4, (copy) v_u_25, (copy) v_u_28, (copy) v_u_29, (copy) v_u_26, (copy) v_u_16, (copy) v_u_5, (copy) v_u_21, (copy) v_u_18, (copy) v_u_19, (copy) v_u_15
	local v60 = v_u_4:Get(v_u_25)
	if v60 then
		v_u_28.Visible = false
		v_u_29.Visible = false
		v_u_26.PossibleFusions.Visible = false
		for _, v61 in v_u_28:GetChildren() do
			if v61:IsA("Frame") and v61.Name ~= "Template" then
				v61:Destroy()
			end
		end
		for _, v62 in v_u_29:GetChildren() do
			if v62:IsA("TextLabel") and v62.Name ~= "Template" then
				v62:Destroy()
			end
		end
		for _, v63 in v_u_26.Lists.Mutations.ScrollingFrame:GetChildren() do
			if v63:IsA("Frame") and v63.Name ~= "Template" then
				v63:Destroy()
			end
		end
		for _, v64 in v_u_26.Lists.Traits.ScrollingFrame:GetChildren() do
			if v64:IsA("Frame") and v64.Name ~= "Template" then
				v64:Destroy()
			end
		end
		local v65 = v60:Get("FuseMachine.OutputRarityOdds")
		local v66 = v60:Get("FuseMachine.OutputTraitsOdds") or {}
		local v67 = v60:Get("FuseMachine.OutputMutationOdds") or {}
		if v65 then
			local v68 = false
			for v69, v70 in v67 do
				local v71 = v_u_16[v69]
				if v71 then
					local v72 = v_u_26.Lists.Mutations.ScrollingFrame.Template:Clone()
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
						v_u_5.apply(v72.Title, v71.GradientPreset)
					else
						v72.Title.TextColor3 = v71.MainColor
					end
					local _, v75 = math.modf(v70)
					v72.Chance.Text = ("%*%%"):format((string.format(v75 == 0 and "%d" or "%.2f", v70)))
					v72.Visible = true
					v72.Parent = v_u_26.Lists.Mutations.ScrollingFrame
					v68 = true
				end
			end
			v_u_26.Lists.Mutations.Visible = v68
			local v76 = false
			for v77, v78 in v66 do
				local v79 = v_u_21[v77]
				if v79 then
					local v80 = v_u_26.Lists.Traits.ScrollingFrame.Template:Clone()
					v80.Name = v77
					v80.LayoutOrder = -v78
					v80.Vector.Image = v79.Icon or ""
					v80.Title.Text = v79.DisplayWithRichText
					v80.Title.TextColor3 = v79.Color
					v80.Title.RichText = true
					local _, v81 = math.modf(v78)
					v80.Chance.Text = ("%*%%"):format((string.format(v81 == 0 and "%d" or "%.2f", v78)))
					v80.Visible = true
					v80.Parent = v_u_26.Lists.Traits.ScrollingFrame
					v76 = true
				end
			end
			v_u_26.Lists.Traits.Visible = v76
			local v82 = false
			for v83, v84 in table.clone(v65) do
				if v84 ~= 0 then
					if v_u_18[v83] then
						v82 = true
						local v85 = v_u_18[v83]
						local v86 = v_u_29.Template:Clone()
						v86.Name = v83
						local _, v87 = math.modf(v84)
						v86.Text = ("%* (%*%%)"):format(v83, (string.format(v87 == 0 and "%d" or "%.2f", v84)))
						if v85.GradientPreset then
							v86.TextColor3 = Color3.fromRGB(255, 255, 255)
							v_u_5.apply(v86, v85.GradientPreset)
						else
							v86.TextColor3 = v85.Color
						end
						v86.LayoutOrder = -v84
						v86.Visible = true
						v86.Parent = v_u_29
					elseif v_u_19[v83] then
						local v88 = v_u_19[v83]
						local v89 = v_u_18[v88.Rarity]
						local v90 = v_u_28.Template:Clone()
						v90.Name = ("%*.%*"):format(v83, v88.Rarity)
						v90.BrainrotName.Text = v83
						local _, v91 = math.modf(v84)
						v90.Weight.Text = ("%*%%"):format((string.format(v91 == 0 and "%d" or "%.2f", v84)))
						if v89.GradientPreset then
							v90.Weight.TextColor3 = Color3.fromRGB(255, 255, 255)
							v_u_5.apply(v90.Weight, v89.GradientPreset)
						else
							v90.Weight.TextColor3 = v89.Color
						end
						v90.LayoutOrder = -v84
						v90.Visible = true
						v90.Parent = v_u_28
						v_u_15:AttachOnViewport(v88.DisplayName, v90.ViewportFrame, true, nil)
					end
				end
			end
			v_u_28.Visible = not v82
			v_u_29.Visible = v82
			v_u_26.PossibleFusions.Visible = true
		end
	else
		return
	end
end
local v_u_93 = v_u_12.new(v_u_31)
v_u_93:Animate()
local function v_u_100()
	-- upvalues: (copy) v_u_4, (copy) v_u_25, (copy) v_u_33, (copy) v_u_31, (copy) v_u_17, (copy) v_u_93, (copy) v_u_13, (copy) v_u_9
	local v94 = v_u_4:Get(v_u_25)
	if v94 then
		local v95 = v94:Get("FuseMachine.Cost")
		local v96 = v94:Get("FuseMachine.FinishTime")
		if v96 then
			v96 = v96 <= workspace:GetServerTimeNow()
		end
		v_u_33:Clean()
		v_u_31.Visible = false
		if v95 then
			local v97 = v94:Get("FuseMachine.StartTime")
			if not v97 or (v97 == 0 or v96) then
				v_u_31.Price.Text = ("$%*"):format((v_u_17:ToString(v95)))
				v_u_31.Visible = true
				v_u_33:Add(v_u_93.OnActivated:Connect(function()
					-- upvalues: (ref) v_u_13, (ref) v_u_9, (ref) v_u_33
					local v98, v99 = v_u_13.Remotes.ConfirmFusion:InvokeServer()
					if v98 then
						v_u_33:Clean()
					else
						v_u_9:Error(v99 or "Something went wrong!")
					end
				end))
			end
		else
			return
		end
	else
		return
	end
end
local v_u_101 = v_u_7.new()
local function v_u_112()
	-- upvalues: (copy) v_u_101, (copy) v_u_4, (copy) v_u_25, (copy) v_u_30, (copy) v_u_18, (copy) v_u_19, (copy) v_u_13, (copy) v_u_20, (copy) v_u_41
	v_u_101:Clean()
	local v102 = v_u_4:Get(v_u_25)
	if v102 then
		v_u_30.Visible = false
		local v103 = v102:Get("FuseMachine.FinishTime")
		local v104 = workspace:FindFirstChild("FuseMachine")
		if v104 then
			local v105 = v104.Overhead.BillboardGui.Countdown
			if v105 then
				if v103 then
					v_u_30.Visible = true
					if v103 - workspace:GetServerTimeNow() < 0 then
						v_u_30.Text = "Fusion Time (<font color=\"#ffff00\">0s</font>)"
						v105.Text = "READY"
					else
						local v106 = v_u_20:E(v103 - workspace:GetServerTimeNow())
						v_u_30.Text = ("Fusion Time (<font color=\"#ffff00\">%*</font>)"):format(v106)
						v105.Text = v106
					end
				else
					local v107 = v102:Get("FuseMachine.OutputRarityOdds")
					if v107 then
						local v108 = "Common"
						for v109, v110 in v107 do
							if v110 > 0 then
								if v_u_18[v109] then
									if v_u_18[v109].Weight > v_u_18[v108].Weight then
										v108 = v109
									end
								else
									local v111 = v_u_19[v109]
									if v111 and v111.Price then
										if v_u_18[v111.Rarity].Weight > v_u_18[v108].Weight then
											v108 = v111.Rarity
										end
									else
										warn((("Failed to find AnimalsData for %*"):format(v109)))
									end
								end
							end
						end
						v_u_30.Text = ("Fusion Time (<font color=\"#ffff00\">%*</font>)"):format((v_u_20:E(v_u_13.FuseTime[v108])))
						v_u_30.Visible = true
					else
						v_u_30.Text = "Fusion Time (<font color=\"#ffff00\">0s</font>)"
					end
					v105.Text = ("%*/%*"):format(#v_u_41(v102:Get("AnimalPodiums")), v_u_13.FuseSlots)
					return
				end
			else
				return
			end
		else
			return
		end
	else
		return
	end
end
local function v_u_117()
	-- upvalues: (copy) v_u_4, (copy) v_u_25, (copy) v_u_35, (copy) v_u_26
	local v113 = v_u_4:Get(v_u_25)
	if v113 then
		local v114 = v113:Get("FuseMachine")
		local v115 = v114.StartTime
		if v115 then
			v115 = v114.StartTime ~= 0
		end
		local v116
		if v115 then
			v116 = v114.FuseLuckMultiplier > 1
		else
			v116 = v_u_35:GetLuck() > 1
		end
		v_u_26.LuckyIcon.Visible = v116
		v_u_26.LuckBlur.Visible = v116
		v_u_26.Fusions.LuckUIStroke.Enabled = v116
	end
end
function v_u_35.GetLuck(_)
	-- upvalues: (copy) v_u_1
	return v_u_1:GetAttribute("FuseMachineLuck") or 1
end
function v_u_35.OnLuckChanged(p_u_118, p_u_119)
	-- upvalues: (copy) v_u_1
	return v_u_1:GetAttributeChangedSignal("FuseMachineLuck"):Connect(function()
		-- upvalues: (copy) p_u_119, (copy) p_u_118
		p_u_119(p_u_118:GetLuck())
	end)
end
function v_u_35.Start(p_u_120)
	-- upvalues: (copy) v_u_2, (ref) v_u_34, (copy) v_u_10, (copy) v_u_26, (copy) v_u_32, (ref) v_u_42, (copy) v_u_59, (copy) v_u_100, (copy) v_u_92, (copy) v_u_112, (copy) v_u_117, (copy) v_u_14, (copy) v_u_4, (copy) v_u_25, (copy) v_u_22, (copy) v_u_6, (copy) v_u_7, (copy) v_u_13, (copy) v_u_9, (copy) v_u_24, (copy) v_u_3, (copy) v_u_11, (copy) v_u_1, (copy) v_u_23, (copy) v_u_19, (copy) v_u_18
	task.spawn(pcall, function()
		-- upvalues: (ref) v_u_2
		v_u_2:PreloadAsync(script:GetChildren())
	end)
	v_u_34 = v_u_10:Register("FuseMachine", v_u_26, "TopQuint")
	v_u_34:AttachCloseButton(v_u_32)
	v_u_34:Close()
	v_u_42 = function()
		-- upvalues: (ref) v_u_59, (ref) v_u_100, (ref) v_u_92, (ref) v_u_112, (ref) v_u_117
		task.spawn(v_u_59)
		task.spawn(v_u_100)
		task.spawn(v_u_92)
		task.spawn(v_u_112)
		task.spawn(v_u_117)
	end
	p_u_120:OnLuckChanged(v_u_117)
	v_u_14.watch(v_u_92)
	v_u_4:WaitAndCall(v_u_25, function(p121)
		-- upvalues: (ref) v_u_42
		p121:OnChanged("FuseMachine", v_u_42)
		p121:OnChanged("FuseMachine.Cost", v_u_42)
		p121:OnChanged("FuseMachine.OutputRarityOdds", v_u_42)
		p121:OnChanged("FuseMachine.OutputTraitsOdds", v_u_42)
		p121:OnChanged("FuseMachine.OutputMutationOdds", v_u_42)
		p121:OnChanged("FuseMachine.FuseLuckMultiplier", v_u_42)
		task.spawn(v_u_42)
	end)
	v_u_22.Simple(1, function()
		-- upvalues: (ref) v_u_112, (ref) v_u_100
		v_u_112()
		v_u_100()
	end)
	v_u_6.observeTag("FuseMachinePrompt", function(p_u_122)
		-- upvalues: (ref) v_u_7, (ref) v_u_4, (ref) v_u_25, (ref) v_u_22, (ref) v_u_13, (ref) v_u_9, (ref) v_u_42, (ref) v_u_24, (ref) v_u_10
		local v_u_123 = v_u_7.new()
		local function v_u_127()
			-- upvalues: (ref) v_u_4, (ref) v_u_25, (copy) p_u_122
			local v124 = v_u_4:Wait(v_u_25)
			if v124 then
				local v125 = v124:Get("FuseMachine.StartTime")
				local v126 = v124:Get("FuseMachine.FinishTime")
				if v126 and (v126 ~= 0 and v126 <= workspace:GetServerTimeNow()) then
					p_u_122.ActionText = "Claim"
					return
				elseif v125 and v125 ~= 0 then
					if (v124:Get("FuseMachine.InstantReveals") or 0) >= 1 then
						p_u_122.ActionText = "Reveal Now (FREE)"
					else
						p_u_122.ActionText = "Reveal Now"
					end
				else
					p_u_122.ActionText = "Santa\'s Fuse"
					return
				end
			else
				return
			end
		end
		v_u_123:Add(task.spawn(function()
			-- upvalues: (ref) v_u_4, (ref) v_u_25, (copy) v_u_127, (copy) v_u_123, (ref) v_u_22
			local v128 = v_u_4:Wait(v_u_25)
			if v128 then
				v128:OnChanged("FuseMachine", v_u_127)
				v128:OnChanged("FuseMachine.Cost", v_u_127)
				v128:OnChanged("FuseMachine.OutputRarityOdds", v_u_127)
				v_u_123:Add(v_u_22.Simple(1, v_u_127))
				task.spawn(v_u_127)
			end
		end))
		v_u_123:Add(p_u_122.Triggered:Connect(function()
			-- upvalues: (ref) v_u_4, (ref) v_u_25, (ref) v_u_13, (ref) v_u_9, (ref) v_u_42, (ref) v_u_24, (ref) v_u_10
			local v129 = v_u_4:Get(v_u_25)
			if v129 then
				local v130 = v129:Get("FuseMachine.StartTime")
				local v131 = v129:Get("FuseMachine.FinishTime")
				if v131 and (v131 ~= 0 and v131 <= workspace:GetServerTimeNow()) then
					local v132, v133 = v_u_13.Remotes.ClaimBrainrot:InvokeServer()
					if not v132 then
						v_u_9:Error(v133 or "Something went wrong!")
						return
					end
					if v_u_42 then
						v_u_42()
						return
					end
				else
					if v130 and v130 ~= 0 then
						if (v129:Get("FuseMachine.InstantReveals") or 0) >= 1 then
							v_u_13.Remotes.RevealNow:FireServer()
						else
							v_u_24:FireServer(v_u_13.RevealNowProductId)
						end
					end
					v_u_10:Toggle("FuseMachine")
				end
			end
		end))
		return function()
			-- upvalues: (copy) v_u_123
			v_u_123:Destroy()
		end
	end)
	v_u_6.observeTag("FuseMachine", function(p134)
		-- upvalues: (ref) v_u_7, (ref) v_u_3, (ref) v_u_25, (ref) v_u_13, (ref) v_u_11, (ref) v_u_1, (ref) v_u_23, (ref) v_u_42, (copy) p_u_120
		local v_u_135 = v_u_7.new()
		for _, v_u_136 in p134.Hitboxes:GetChildren() do
			v_u_135:Add(v_u_136.Touched:Connect(function(p137)
				-- upvalues: (ref) v_u_3, (ref) v_u_25, (ref) v_u_13, (copy) v_u_136, (ref) v_u_11, (ref) v_u_1, (ref) v_u_23, (ref) v_u_42
				if p137.Name == "HumanoidRootPart" then
					local v138 = v_u_3:GetPlayerFromCharacter(p137.Parent)
					if v138 and v138 == v_u_25 then
						if v138:GetAttribute("StealingIndex") then
							if not v_u_13.Remotes.Delivery:InvokeServer(v_u_136) then
								return
							end
							task.spawn(function()
								-- upvalues: (ref) v_u_11, (ref) v_u_1
								v_u_11:PlaySound(v_u_1.Sounds.Sfx["Fuse Machine"].Deposit)
							end)
							local v139 = workspace:FindFirstChild("FuseMachine")
							if v139 then
								v_u_23.emit(v139.Vfx.emitfuse)
							end
							v_u_42()
						end
					end
				else
					return
				end
			end))
		end
		local v_u_140 = p134.Overhead.LuckGui
		local function v142(p141)
			-- upvalues: (copy) v_u_140
			v_u_140.Enabled = p141 > 1
		end
		v_u_135:Add(p_u_120:OnLuckChanged(v142))
		task.defer(v142, p_u_120:GetLuck())
		return function()
			-- upvalues: (copy) v_u_135
			v_u_135:Destroy()
		end
	end)
	v_u_13.Remotes.FuseAnimation.OnClientEvent:Connect(function(animalName, _, _)
		local fuseMachine = workspace:FindFirstChild("FuseMachine")
		if not fuseMachine then return end

		local trove = v_u_7.new()
		local rig = fuseMachine.Rig

		local doorOpenAnim = rig.AnimationController.Animator:LoadAnimation(v_u_1.Animations.FuseMachine.DoorOpen)
		local doorCloseAnim = rig.AnimationController.Animator:LoadAnimation(v_u_1.Animations.FuseMachine.DoorClose)
		local leverDownAnim = rig.AnimationController.Animator:LoadAnimation(v_u_1.Animations.FuseMachine.LeverDown)
		local leverUpAnim = rig.AnimationController.Animator:LoadAnimation(v_u_1.Animations.FuseMachine.LeverUp)

		trove:Add(function()
			doorOpenAnim:Stop()
			doorOpenAnim:Destroy()
			doorCloseAnim:Stop()
			doorCloseAnim:Destroy()
			leverDownAnim:Stop()
			leverDownAnim:Destroy()
			leverUpAnim:Stop()
			leverUpAnim:Destroy()
		end)

		local animalData = v_u_19[animalName]
		if not animalData then
			warn("[FuseAnimation] Animal not found:", animalName)
			trove:Destroy()
			return
		end

		leverDownAnim:Play()
		trove:Add(leverDownAnim:GetMarkerReachedSignal("Freeze"):Once(function()
			leverDownAnim:AdjustSpeed(0)
		end))

		task.spawn(function()
			local raritySound = v_u_1.Sounds.Sfx["Fuse Machine"]:FindFirstChild(animalData.Rarity)
			if raritySound then
				v_u_11:PlaySound(raritySound, fuseMachine:GetPivot().Position)
			end
		end)

		doorOpenAnim:Play()
		trove:Add(doorOpenAnim:GetMarkerReachedSignal("Freeze"):Once(function()
			doorOpenAnim:AdjustSpeed(0)
		end))

		task.delay(1, function()
			local rarityVfx = fuseMachine.Vfx:FindFirstChild(animalData.Rarity)
			if rarityVfx then
				v_u_23.enable(rarityVfx)
			end
		end)

		task.wait(3)

		local rarityVfx = fuseMachine.Vfx:FindFirstChild(animalData.Rarity)
		if rarityVfx then
			v_u_23.disable(rarityVfx)
		end

		task.wait(1)

		leverUpAnim:Play()
		leverDownAnim:Stop(0)
		doorCloseAnim:Play()

		local timeout = 2
		while doorCloseAnim.Length == 0 and timeout > 0 do
			timeout = timeout - task.wait()
		end

		doorOpenAnim:Stop(0)
		task.wait(2)

		trove:Destroy()
	end)
	v_u_13.Remotes.ForceUpdate.OnClientEvent:Connect(function()
		-- upvalues: (ref) v_u_42
		v_u_42()
	end)
end
return v_u_35