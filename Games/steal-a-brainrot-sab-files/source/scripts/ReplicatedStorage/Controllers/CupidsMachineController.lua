-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
game:GetService("ContentProvider")
-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Signal = require(ReplicatedStorage.Packages.Signal)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Net = require(ReplicatedStorage.Packages.Net)
local VFX = require(ReplicatedStorage.Shared.VFX)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Animals = require(ReplicatedStorage.Shared.Animals)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals2 = require(ReplicatedStorage.Datas.Animals)
local Traits = require(ReplicatedStorage.Datas.Traits)
local v22 = Net:RemoteEvent("CupidsMachineService/CraftDone")
local v23 = Net:RemoteEvent("CupidsMachineService/Update")
local v24 = Net:RemoteEvent("CupidsMachineService/Return")
local v25 = Net:RemoteEvent("CupidsMachineService/Claim")
local v26 = Net:RemoteEvent("CupidsMachineService/Skip")
local v27 = Net:RemoteFunction("CupidsMachineService/Delivery")
local v28 = Net:RemoteFunction("CupidsMachineService/Start")
local v29 = Net:RemoteFunction("CupidsMachineService/Fetch")
local v30 = Net:RemoteEvent("ShopService/Purchase")
local LocalPlayer = Players.LocalPlayer
local CupidsMachine = LocalPlayer.PlayerGui:WaitForChild("CupidsMachine").CupidsMachine
local Left = CupidsMachine.Left
local Right = CupidsMachine.Right
local Buy = CupidsMachine.Buy
local Time = CupidsMachine.Time
local CupidsMachineTitle = CupidsMachine.Title
local Close = CupidsMachine.Header.Close
local Outputs = CupidsMachine.Outputs
local Template = Outputs.Template
local u41 = nil
local t1 = {
	OnRecipeChanged = Signal.new(),
	GetCurrentRecipe = function(_)
		return u41
	end
}

local function applyRarityStyle(p2, s1: string, p3)
	local v67 = Animals2[s1]

	if not v67 then
		return
	end

	local v68 = Rarities[v67.Rarity]

	if not v68 then
		return
	end

	if v68.GradientPreset then
		p2.TextColor3 = Color3.new(1, 1, 1)

		local v69 = Gradients.apply(p2, v68.GradientPreset)

		if p3 and v69 then
			p3:Add(v69)

			return
		end
	else
		p2.TextColor3 = v68.Color
	end
end
local function getBrainrotsInMachineForSlot(s2: string, b1: boolean?)
	local v72 = Synchronizer:Get(LocalPlayer)

	if not v72 then
		return {}
	end

	local v73 = v72:Get("AnimalPodiums")

	if not v73 then
		return {}
	end

	local t2 = {}

	for v75, v76 in v73 do
		if typeof(v76) == "table" and v76.Machine and v76.Machine.Type == "Cupids" and ((not v76.Machine.Active or b1) and s2 == v76.Index) then
			table.insert(t2, {
				Index = v76.Index,
				Podium = v75
			})
		end
	end

	return t2
end

local v45 = Trove.new()
local v46 = Trove.new()

local function update3DModel(s3: string, s4: string?, p4)
	p4:Clean()

	if not s4 then
		return nil
	end

	for _, v81 in (CollectionService:GetTagged(s3)) do
		local AnimatedModel = Animals:GetAnimatedModel(s4, "Idle")

		if AnimatedModel then
			p4:Add(AnimatedModel)

			local Size = v81.Size
			local ExtentsSize = AnimatedModel:GetExtentsSize()
			local v85 = math.min(Size.X / ExtentsSize.X, Size.Y / ExtentsSize.Y, Size.Z / ExtentsSize.Z)

			AnimatedModel:ScaleTo(AnimatedModel:GetScale() * v85)
			AnimatedModel:PivotTo(v81:GetPivot())

			if AnimatedModel.PrimaryPart then
				AnimatedModel.PrimaryPart.Anchored = false

				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = AnimatedModel.PrimaryPart
				WeldConstraint.Part1 = v81
				WeldConstraint.Parent = AnimatedModel.PrimaryPart
				p4:Add(WeldConstraint)
			end
		end
	end

	return s4
end

local u48 = nil
local v49 = Trove.new()
local v50 = Trove.new()
local v51 = Trove.new()
local v52 = Trove.new()
local u53 = false

local function updateSlotFrame(p5, s5: string?, b2: boolean, p6)
	p6:Clean()

	local ViewportFrame = p5:FindFirstChild("ViewportFrame")

	if ViewportFrame then
		if s5 and Animals2[s5] then
			local v92 = Animals:AttachOnViewportWithOptimizations(s5, ViewportFrame)

			if v92 then
				p6:Add(v92)
			end
		end

		ViewportFrame.ImageColor3 = if not b2 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)
	end

	local BrainrotLabel = p5:FindFirstChild("BrainrotLabel")

	if BrainrotLabel then
		BrainrotLabel.Text = s5 or "Empty"

		if s5 then
			applyRarityStyle(BrainrotLabel, s5, p6)
		else
			BrainrotLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		end
	end

	local Return = p5:FindFirstChild("Return")

	if Return then
		Return.Visible = b2

		if b2 and s5 then
			local v95 = p6:Add(AnimatedButton.new(Return))

			v95:Animate()
			p6:Add(v95.OnActivated:Connect(function()
				local v170 = getBrainrotsInMachineForSlot(s5)

				if #v170 > 0 then
					v24:FireServer(v170[1].Podium)
				end
			end))
		end
	end
end

local t3 = {
	left = {
		name = nil,
		filled = nil
	},
	right = {
		name = nil,
		filled = nil
	}
}

local function UpdateTimer()
	if CupidsMachineTitle then
		local ServerTimeNow = workspace:GetServerTimeNow()
		local v97 = math.max((u41 and u41.Refresh or 0) - ServerTimeNow, 0)

		CupidsMachineTitle.Text = `New possible match in <font color='#ffff00'>{ TimeUtils:E(v97) }</font>`
	end

	if Time then
		local v98 = Synchronizer:Get(LocalPlayer)
		local v99 = v98 and v98:Get("CupidsMachine")
		local v100 = v99 and (v99.StartTime and v99.StartTime ~= 0)
		local v101 = v99 and v99.FinishTime
		local v102 = v101 and v101 <= workspace:GetServerTimeNow()

		if v100 and not v102 then
			local ServerTimeNow = workspace:GetServerTimeNow()
			local v104 = math.max((v101 or 0) - ServerTimeNow, 0)

			Time.Text = `Matching... (<font color='#ffff00'>{ TimeUtils:E(v104) }</font>)`

			return
		end

		Time.Text = "Match Time (<font color='#ffff00'>5m</font>)"
	end
end
local function UpdateMutationsAndTraits()
	for _, v106 in CupidsMachine.Lists.Mutations.ScrollingFrame:GetChildren() do
		if v106:IsA("Frame") and v106.Name ~= "Template" then
			v106:Destroy()
		end
	end

	for _, v108 in CupidsMachine.Lists.Traits.ScrollingFrame:GetChildren() do
		if v108:IsA("Frame") and v108.Name ~= "Template" then
			v108:Destroy()
		end
	end

	local v109 = Synchronizer:Get(LocalPlayer)

	if not v109 then
		CupidsMachine.Lists.Mutations.Visible = false
		CupidsMachine.Lists.Traits.Visible = false

		return
	end

	local v110 = v109:Get("AnimalPodiums")

	if not v110 then
		CupidsMachine.Lists.Mutations.Visible = false
		CupidsMachine.Lists.Traits.Visible = false

		return
	end

	local t4 = {}
	local t5 = {}

	for _, v114 in v110 do
		if typeof(v114) == "table" and v114.Machine and v114.Machine.Type == "Cupids" then
			if v114.Mutation then
				t4[v114.Mutation] = (t4[v114.Mutation] or 0) + 15
			end

			if typeof(v114.Traits) == "table" then
				for _, v116 in v114.Traits do
					t5[v116] = (t5[v116] or 0) + 1
				end
			end
		end
	end

	local v117 = false

	for v118, v119 in t4 do
		local v120 = Mutations[v118]

		if v120 then
			local clone = CupidsMachine.Lists.Mutations.ScrollingFrame.Template:Clone()

			clone.Name = v118
			clone.LayoutOrder = -v119
			clone.Vector.Image = v120.Icon or ""
			clone.Title.Text = if not v120.UseRichText then v120.DisplayText else v120.DisplayWithRichText
			clone.Title.RichText = v120.UseRichText

			if v120.GradientPreset then
				clone.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
				Gradients.apply(clone.Title, v120.GradientPreset)
			else
				clone.Title.TextColor3 = v120.MainColor
			end

			local _, fraction = math.modf(v119)

			clone.Chance.Text = `{ string.format(fraction ~= 0 and "%.2f" or "%d", v119) }%`
			clone.Visible = true
			clone.Parent = CupidsMachine.Lists.Mutations.ScrollingFrame
			v117 = true
		end
	end

	CupidsMachine.Lists.Mutations.Visible = v117

	local v124 = false

	for v125, v126 in t5 do
		local v127 = Traits[v125]

		if v127 then
			local v128 = math.clamp(v126 / 4, 0, 1) * 40
			local clone = CupidsMachine.Lists.Traits.ScrollingFrame.Template:Clone()

			clone.Name = v125
			clone.LayoutOrder = -v128
			clone.Vector.Image = v127.Icon or ""
			clone.Title.Text = v127.DisplayWithRichText
			clone.Title.TextColor3 = v127.Color
			clone.Title.RichText = true

			local _, fraction = math.modf(v128)

			clone.Chance.Text = `{ string.format(fraction ~= 0 and "%.2f" or "%d", v128) }%`
			clone.Visible = true
			clone.Parent = CupidsMachine.Lists.Traits.ScrollingFrame
			v124 = true
		end
	end

	CupidsMachine.Lists.Traits.Visible = v124
end

local u58 = true

local function UpdateSurfaceGuis()
	local CupidsMachine2 = workspace:FindFirstChild("CupidsMachine")
	local v133 = CupidsMachine2 and CupidsMachine2:FindFirstChild("ResultText")

	if v133 and u58 then
		local Fail = v133:FindFirstChild("Fail")
		local Match = v133:FindFirstChild("Match")
		local Waiting = v133:FindFirstChild("Waiting")
		local Matching = v133:FindFirstChild("Matching")

		if Fail and Match and Waiting then
			Fail.Enabled = false
			Match.Enabled = false
			Waiting.Enabled = false
			Matching.Enabled = false

			if isCrafting and not isFinished then
				Matching.Enabled = true

				return
			end

			if leftFilled and rightFilled then
				Match.Enabled = true

				return
			end

			Waiting.Enabled = true
		end
	end
end
local function UpdateAll()
	v49:Clean()
	v50:Clean()

	local v138 = Synchronizer:Get(LocalPlayer)

	if not v138 then
		return
	end

	local v139 = u41 and u41.Recipe

	UpdateTimer()

	local v140 = v139 and v139.Recipe[1] or nil
	local v141 = v139 and v139.Recipe[2] or nil
	local v142 = v138:Get("CupidsMachine")
	local v143 = v142 and (v142.StartTime and v142.StartTime ~= 0)
	local v144 = false
	local v145 = false

	if v140 then
		v144 = #getBrainrotsInMachineForSlot(v140, v143) >= 1
	end

	if v141 then
		if v141 == v140 then
			v145 = #getBrainrotsInMachineForSlot(v141, v143) >= 2
		else
			v145 = #getBrainrotsInMachineForSlot(v141, v143) >= 1
		end
	end

	local v146 = v142 and v142.FinishTime

	if v146 then
		if not (v146 <= workspace:GetServerTimeNow()) then
		end
	end

	if (v140 ~= t3.left.name or v144 ~= t3.left.filled) and not u53 then
		t3.left.name = v140
		t3.left.filled = v144
		updateSlotFrame(Left, v140, v144, v51)
		update3DModel("CupidsMachineLeft", if not v144 then nil else v140, v45)
	end

	if (v141 ~= t3.right.name or v145 ~= t3.right.filled) and not u53 then
		t3.right.name = v141
		t3.right.filled = v145
		updateSlotFrame(Right, v141, v145, v52)
		update3DModel("CupidsMachineRight", if not v145 then nil else v141, v46)
	end

	Buy.Visible = false

	if v139 and v144 and v145 and not v143 then
		Buy.Visible = true

		local Price = Buy:FindFirstChild("Price")

		if Price then
			Price.Text = `${ NumberUtils:ToString(v139.Cost) }`
		end

		local v148 = v50:Add(AnimatedButton.new(Buy))

		v148:Animate()
		v50:Add(v148.OnActivated:Connect(function()
			if v28:InvokeServer(v139.Name) then
				InterfaceController:SetState("CupidsMachine", false)
			end
		end))
	end

	if Outputs and Template then
		for _, v150 in Outputs:GetChildren() do
			if v150:IsA("Frame") and v150 ~= Template then
				v150:Destroy()
			end
		end

		Template.Visible = false

		if u41 and u41.Recipe ~= nil and u41.Outputs then
			for v151, v152 in u41.Outputs do
				local clone = Template:Clone()

				clone.Name = `Output_{ v151 }`
				clone.Visible = true

				local BrainrotLabel = clone:FindFirstChild("BrainrotLabel")
				local ViewportFrame = clone:FindFirstChild("ViewportFrame")
				local Vector = clone:FindFirstChild("Vector")
				local Weight = clone:FindFirstChild("Weight")

				if Vector then
					Vector.Visible = v152.Name == "Nothing"
				end

				if v152.Name == "Nothing" then
					if BrainrotLabel then
						BrainrotLabel.Text = "Nothing"
					end

					if ViewportFrame then
						for _, v159 in ViewportFrame:GetChildren() do
							if v159:IsA("Model") or v159:IsA("BasePart") then
								v159:Destroy()
							end
						end

						ViewportFrame.ImageTransparency = 1
					end
				else
					if BrainrotLabel then
						BrainrotLabel.Text = v152.Name
						applyRarityStyle(BrainrotLabel, v152.Name, v49)
					end

					if ViewportFrame then
						ViewportFrame.ImageTransparency = 0

						local v160 = Animals:AttachOnViewportWithOptimizations(v152.Name, ViewportFrame)

						if v160 then
							v49:Add(v160)
						end
					end
				end

				if Weight then
					local Chance = v152.Chance

					if Chance == math.floor(Chance) then
						Weight.Text = `{ Chance }%`
					else
						Weight.Text = string.format("%.2f%%", Chance)
					end
				end

				clone.Parent = Outputs
			end
		end
	end

	UpdateMutationsAndTraits()
	UpdateSurfaceGuis()
end

local t6 = {
	isFinished = nil,
	isCrafting = nil
}

local function CheckForUpdateAll()
	local v162 = Synchronizer:Get(LocalPlayer)

	if not v162 then
		return
	end

	local v163 = v162:Get("CupidsMachine")
	local v164 = v163 and (v163.StartTime and v163.StartTime ~= 0)
	local v165 = v163 and v163.FinishTime
	local v166 = v165 and v165 <= workspace:GetServerTimeNow()

	if v166 ~= t6.isFinished or v164 ~= t6.isCrafting then
		t6.isCrafting = v164
		t6.isFinished = v166
		UpdateAll()
	end
end

function t1.Start(p7)
	Synchronizer:Wait(LocalPlayer)
	CupidsMachine.Visible = false
	u48 = InterfaceController:Register("CupidsMachine", CupidsMachine, "TopQuint")

	if Close then
		u48:AttachCloseButton(Close)
	end

	u48:Close()
	v23.OnClientEvent:Connect(function(p8)
		if type(p8) ~= "table" then return end
		u41 = p8
		p7.OnRecipeChanged:Fire(u41)
		task.spawn(UpdateAll)
	end)
	v22.OnClientEvent:Connect(function(s6: string?, t7: {[any]: any}?)
		u53 = true
		InterfaceController:SetState("CupidsMachine", false)

		if t7 then
			local v174 = t7[1]
			local v175 = t7[2]

			if v174 then
				update3DModel("CupidsMachineLeft", v174, v45)
			end

			if v175 then
				update3DModel("CupidsMachineRight", v175, v46)
			end
		end

		local CupidsMachine3 = workspace:FindFirstChild("CupidsMachine")

		if not CupidsMachine3 then
			u53 = false

			return
		end

		local AnimatedMesh = CupidsMachine3:FindFirstChild("AnimatedMesh")

		if not AnimatedMesh then
			u53 = false

			return
		end

		local AnimationController = AnimatedMesh:FindFirstChildWhichIsA("AnimationController")

		if not AnimationController then
			u53 = false

			return
		end

		local Animator = AnimationController:FindFirstChildWhichIsA("Animator")

		if not Animator then
			u53 = false

			return
		end

		local v180 = not s6 and "Fail" or "Success"
		local v181 = AnimatedMesh:FindFirstChild(v180)

		if v181 and v181:IsA("Animation") then
			local v182 = Animator:LoadAnimation(v181)

			v182.Priority = Enum.AnimationPriority.Action
			v182:Play(0)

			local n1 = 5

			while v182.Length == 0 and n1 > 0 do
				n1 -= task.wait()
			end

			if v180 == "Success" then
				VFX.emit(AnimatedMesh)

				for _, v185 in AnimatedMesh:GetDescendants() do
					if v185:IsA("Trail") then
						v185.Enabled = true
					end
				end
			end
		end

		task.spawn(function()
			local v216 = ReplicatedStorage.Sounds.Sfx:FindFirstChild("Cupids Machine")
			local v217 = v216 and v216:FindFirstChild(v180)

			if v217 then
				SoundController:PlaySound(v217, CupidsMachine3:GetPivot().Position)
			end
		end)

		local v186 = v180 ~= "Success" and 4.7 or 7.5
		local ResultText = CupidsMachine3:FindFirstChild("ResultText")

		if ResultText then
			local Fail = ResultText:FindFirstChild("Fail")
			local Match = ResultText:FindFirstChild("Match")
			local Waiting = ResultText:FindFirstChild("Waiting")
			local Matching = ResultText:FindFirstChild("Matching")

			if Fail and Match and Waiting then
				u58 = false
				Fail.Enabled = false
				Match.Enabled = false
				Waiting.Enabled = false
				Matching.Enabled = false
				task.delay(4.6, function()
					Fail.Enabled = not s6
					Match.Enabled = s6 ~= nil
					task.delay(3, function()
						u58 = true
						UpdateSurfaceGuis()
					end)
				end)
			end
		end

		task.delay(v186, function()
			for _, v219 in AnimatedMesh:GetDescendants() do
				if v219:IsA("Trail") then
					v219.Enabled = true
				end
			end
		end)
		task.delay(v186, function()
			u53 = false
			UpdateAll()
		end)
	end)
	u41 = v29:InvokeServer() or u41
	p7.OnRecipeChanged:Fire(u41)
	Synchronizer:WaitAndCall(LocalPlayer, function(p9)
		local function update()
			task.spawn(UpdateAll)
		end

		p9:OnChanged("CupidsMachine", update)
		p9:OnChanged("CupidsMachine.Brainrot", update)
		p9:OnChanged("CupidsMachine.StartTime", update)
		p9:OnChanged("CupidsMachine.FinishTime", update)
		p9:OnChanged("AnimalAddedOrRemoved", update)
		task.spawn(update)
	end)
	Timer.Simple(1, function()
		CheckForUpdateAll()
		UpdateTimer()
	end)
	Observers.observeTag("CupidsMachinePrompt", function(p10)
		local v195 = Trove.new()

		local function updatePrompt()
			local v220 = Synchronizer:Wait(LocalPlayer)

			if not v220 then
				return
			end

			local v221 = v220:Get("CupidsMachine.StartTime")
			local v222 = v220:Get("CupidsMachine.FinishTime")
			local v223 = v222 and (v222 ~= 0 and v222 <= workspace:GetServerTimeNow())
			local v224 = v221 and (v221 ~= 0 and not v223)

			if u53 then
				p10.Enabled = false

				return
			end

			if v223 then
				p10.Enabled = true
				p10.ActionText = "Claim"

				return
			end

			if v224 then
				p10.Enabled = true

				if (v220:Get("CupidsMachine.InstantSkips") or 0) >= 1 then
					p10.ActionText = "Reveal Now (FREE)"

					return
				end

				p10.ActionText = "Reveal Now"

				return
			end

			p10.Enabled = true
			p10.ActionText = "Cupid's Machine"
		end

		v195:Add(task.spawn(function()
			local v225 = Synchronizer:Wait(LocalPlayer)

			if not v225 then
				return
			end

			v225:OnChanged("CupidsMachine.Brainrot", updatePrompt)
			v225:OnChanged("CupidsMachine.StartTime", updatePrompt)
			v225:OnChanged("CupidsMachine.FinishTime", updatePrompt)
			v195:Add(Timer.Simple(1, updatePrompt))
			task.spawn(updatePrompt)
		end))
		v195:Add(p10.Triggered:Connect(function()
			if u53 then
				return
			end

			local v226 = Synchronizer:Get(LocalPlayer)

			if not v226 then
				return
			end

			local v227 = v226:Get("CupidsMachine.StartTime")
			local v228 = v226:Get("CupidsMachine.FinishTime")

			if v228 and v228 ~= 0 and v228 <= workspace:GetServerTimeNow() then
				v25:FireServer()

				return
			end

			if v227 and v227 ~= 0 then
				if (v226:Get("CupidsMachine.InstantSkips") or 0) >= 1 then
					v26:FireServer()

					return
				end

				v30:FireServer(3532165598)

				return
			end

			InterfaceController:Toggle("CupidsMachine")
		end))

		return function()
			v195:Destroy()
		end
	end)
	Observers.observeTag("CupidsMachineTimerLabel", function(p11)
		local v198 = Trove.new()

		local function updateTimerLabel()
			local v229 = Synchronizer:Get(LocalPlayer)

			if not v229 then
				p11.Text = ""

				return
			end

			local ServerTimeNow = workspace:GetServerTimeNow()
			local v231 = v229:Get("CupidsMachine.StartTime")
			local v232 = v229:Get("CupidsMachine.FinishTime")
			local v233 = v232 and (v232 ~= 0 and v232 <= ServerTimeNow)
			local v234 = v231 and (v231 ~= 0 and not v233)

			if v233 then
				p11.Text = "READY"

				return
			end

			if v234 then
				local v235 = math.max((v232 or 0) - ServerTimeNow, 0)

				p11.Text = TimeUtils:E(v235)

				return
			end

			math.max((u41 and u41.Refresh or 0) - ServerTimeNow, 0)
			local v260 = v229:Get("AnimalPodiums")
			local v261 = 0
			if v260 then
				for _, v262 in v260 do
					if typeof(v262) == "table" and v262.Machine and v262.Machine.Type == "Cupids" then
						v261 += 1
					end
				end
			end
			p11.Text = `{v261}/2`
		end

		v198:Add(task.spawn(function()
			local v236 = Synchronizer:Wait(LocalPlayer)

			if not v236 then
				return
			end

			v236:OnChanged("CupidsMachine.Brainrot", updateTimerLabel)
			v236:OnChanged("CupidsMachine.StartTime", updateTimerLabel)
			v236:OnChanged("CupidsMachine.FinishTime", updateTimerLabel)
			v236:OnChanged("AnimalPodiums", updateTimerLabel)
			v236:OnChanged("AnimalAddedOrRemoved", updateTimerLabel)
			v198:Add(Timer.Simple(1, updateTimerLabel))
			task.spawn(updateTimerLabel)
		end))

		return function()
			v198:Destroy()
		end
	end)

	local n2 = 1

	Observers.observeTag("CupidsMachineLeftBrainrotStatus", function(p12)
		local v203 = Trove.new()

		local function updateStatus()
			local v240 = Synchronizer:Get(LocalPlayer)

			if not v240 then
				p12.Text = "ADD BRAINROT..."

				return
			end

			local v241 = u41 and u41.Recipe
			local v242 = v241 and v241.Recipe[n2] or nil

			if not v242 then
				p12.Text = "ADD BRAINROT..."

				return
			end

			local v243 = v240:Get("CupidsMachine")
			local v244 = v243 and (v243.StartTime and v243.StartTime ~= 0)

			p12.Text = if not (#getBrainrotsInMachineForSlot(v242, v244) > 0) or v244 then not v244 and "ADD BRAINROT..." or "MATCHING..." else "WAITING..."
		end

		v203:Add(task.spawn(function()
			local v245 = Synchronizer:Wait(LocalPlayer)

			if not v245 then
				return
			end

			v245:OnChanged("CupidsMachine.Brainrot", updateStatus)
			v245:OnChanged("CupidsMachine.StartTime", updateStatus)
			v245:OnChanged("CupidsMachine.FinishTime", updateStatus)
			v245:OnChanged("AnimalPodiums", updateStatus)
			v245:OnChanged("AnimalAddedOrRemoved", updateStatus)
			v203:Add(Timer.Simple(1, updateStatus))
			task.spawn(updateStatus)
		end))

		return function()
			v203:Destroy()
		end
	end)

	local n3 = 2

	Observers.observeTag("CupidsMachineRightBrainrotStatus", function(p13)
		local v206 = Trove.new()

		local function updateStatus()
			local v246 = Synchronizer:Get(LocalPlayer)

			if not v246 then
				p13.Text = "ADD BRAINROT..."

				return
			end

			local v247 = u41 and u41.Recipe
			local v248 = v247 and v247.Recipe[n3] or nil

			if not v248 then
				p13.Text = "ADD BRAINROT..."

				return
			end

			local v249 = v246:Get("CupidsMachine")
			local v250 = v249 and (v249.StartTime and v249.StartTime ~= 0)

			local v252 = v247 and v247.Recipe[1]
			local v253 = if v252 == v248 then 2 else 1
			local v254 = #getBrainrotsInMachineForSlot(v248, v250)
			p13.Text = if not (v254 >= v253) or v250 then not v250 and "ADD BRAINROT..." or "MATCHING..." else "WAITING..."
		end

		v206:Add(task.spawn(function()
			local v251 = Synchronizer:Wait(LocalPlayer)

			if not v251 then
				return
			end

			v251:OnChanged("CupidsMachine.Brainrot", updateStatus)
			v251:OnChanged("CupidsMachine.StartTime", updateStatus)
			v251:OnChanged("CupidsMachine.FinishTime", updateStatus)
			v251:OnChanged("AnimalPodiums", updateStatus)
			v251:OnChanged("AnimalAddedOrRemoved", updateStatus)
			v206:Add(Timer.Simple(1, updateStatus))
			task.spawn(updateStatus)
		end))

		return function()
			v206:Destroy()
		end
	end)
	Observers.observeTag("CupidsMachine", function(p14)
		local v209 = Trove.new()
		local AnimatedMesh = p14:FindFirstChild("AnimatedMesh")
		local v211 = AnimatedMesh and AnimatedMesh:FindFirstChildWhichIsA("AnimationController")
		local v212 = v211 and v211:FindFirstChildWhichIsA("Animator")

		if AnimatedMesh and (v211 and v212) then
			local Idle = AnimatedMesh:FindFirstChild("Idle")

			if Idle and Idle:IsA("Animation") then
				local v214 = v212:LoadAnimation(Idle)

				v214.Priority = Enum.AnimationPriority.Idle
				v214.Looped = true
				v214:Play()
				v209:Add(function()
					v214:Stop()
					v214:Destroy()
				end)
			end
		end

		local DeliveryHitbox = p14:FindFirstChild("DeliveryHitbox")

		if DeliveryHitbox and DeliveryHitbox:IsA("BasePart") then
			v209:Add(DeliveryHitbox.Touched:Connect(function(part)
				if part.Name ~= "HumanoidRootPart" then
					return
				end

				local player = Players:GetPlayerFromCharacter(part.Parent)

				if not player or player ~= LocalPlayer then
					return
				end

				if player:GetAttribute("StealingIndex") then
					if not v27:InvokeServer(DeliveryHitbox) then
						return
					end

					task.spawn(function()
						SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx["Fuse Machine"].Deposit)
					end)
					task.spawn(UpdateAll)
				end
			end))
		end

		return function()
			v209:Destroy()
		end
	end)
end

return t1