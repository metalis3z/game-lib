-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("ContentProvider")
game:GetService("SoundService")
game:GetService("TweenService")
game:GetService("HttpService")
game:GetService("RunService")
game:GetService("StarterGui")

local Players = game:GetService("Players")

require(ReplicatedStorage.Packages.Serialization)

local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

require(ReplicatedStorage.Packages.CreateTween)
require(ReplicatedStorage.Packages.TopbarPlus)

local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Observers = require(ReplicatedStorage.Packages.Observers)

require(ReplicatedStorage.Packages.Moonlite)
require(ReplicatedStorage.Packages.Signal)
require(ReplicatedStorage.Packages.Squash)

local Timer = require(ReplicatedStorage.Packages.Timer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)

require(ReplicatedStorage.Controllers.NotificationController)
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)

require(ReplicatedStorage.Controllers.CharacterController)

local SoundController = require(ReplicatedStorage.Controllers.SoundController)

require(ReplicatedStorage.Controllers.ShopController)
require(ReplicatedStorage.Controllers.PlotController)

local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local VFX = require(ReplicatedStorage.Shared.VFX)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)

require(ReplicatedStorage.Shared.Updates)
require(ReplicatedStorage.Shared.Animals)

local Animals = require(ReplicatedStorage.Shared.Animals)

require(ReplicatedStorage.Shared.Index)

local Mutations = require(ReplicatedStorage.Datas.Mutations)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals2 = require(ReplicatedStorage.Datas.Animals)
local Traits = require(ReplicatedStorage.Datas.Traits)
local v21 = Net:RemoteEvent("BrainrotTraderService/Animation")
local v22 = Net:RemoteEvent("BrainrotTraderService/Update")
local v23 = Net:RemoteEvent("BrainrotTraderService/Return")
local v24 = Net:RemoteEvent("BrainrotTraderService/Trade")
local v25 = Net:RemoteFunction("BrainrotTraderService/Delivery")
local v26 = Net:RemoteFunction("BrainrotTraderService/Fetch")

Net:RemoteEvent("ShopService/Purchase")

local LocalPlayer = Players.LocalPlayer
local BrainrotTrader = LocalPlayer.PlayerGui:WaitForChild("BrainrotTrader").BrainrotTrader
local Frame = BrainrotTrader.Frame
local _ = Frame.List
local Txt1 = Frame.Header.Txt1
local Close = Frame.Header.Close

Trove.new()

local v33 = Trove.new()
local u34 = nil
local u35 = nil
local t1 = {}

local function updateTimer()
	v33:Clean()

	if not Synchronizer:Get(LocalPlayer) then
		return
	end

	Txt1.Visible = false

	local BrainrotTrader2 = workspace:FindFirstChild("BrainrotTrader")

	if not BrainrotTrader2 then
		return
	end

	local Countdown = BrainrotTrader2.Overhead.BillboardGui.Countdown

	if not Countdown then
		return
	end

	Txt1.Visible = true

	local ServerTimeNow = workspace:GetServerTimeNow()
	local v50 = math.max((u35 and u35.Refresh or 0) - ServerTimeNow, 0)
	local v51 = `Refreshes in { TimeUtils:E(v50) }`

	Countdown.Text = v51
	Txt1.Text = v51
end

local v38 = Trove.new()

local function renderBrainrotAtFrame(p1, p2)
	local v54 = Animals2[p2]

	if not v54 then
		return
	end

	local v55 = Rarities[v54.Rarity]

	p1.Title.Text = p2

	if v55.GradientPreset then
		p1.UIStroke.Color = Color3.new(1, 1, 1)
		p1.Title.TextColor3 = Color3.new(1, 1, 1)
		Gradients.apply(p1.UIStroke, v55.GradientPreset)
		Gradients.apply(p1.Title, v55.GradientPreset)
	else
		p1.UIStroke.Color = v55.Color
		p1.Title.TextColor3 = v55.Color
	end

	p1.Visible = true
	Animals:AttachOnViewportWithOptimizations(p2, p1.ViewportFrame)
end

local v40 = Trove.new()

local function updateMutationList()
	v40:Clean()

	if not u35 then
		return
	end

	local v56 = Synchronizer:Get(LocalPlayer)

	if not v56 then
		return
	end

	local v57 = v56:Get("BrainrotTrader.Info")

	if not v57 then
		return
	end

	local t2 = {}

	for v59, v60 in v57 do
		local Mutations2 = v60.Mutations
		local Traits2 = v60.Traits

		Mutations2.Normal = nil

		if next(Mutations2) or next(Traits2) then
			local v63 = u35 and (u35.List[v59] and u35.List[v59].Name)

			if v63 then
				local v64 = Animals2[v63]

				if v64 and tonumber(string.match(v59, "(%d+)")) then
					local v65 = Rarities[v64.Rarity]
					local n1 = 0

					for _, v68 in Mutations2 do
						n1 += v68
					end

					local n2 = 0

					for _, v71 in Traits2 do
						n2 += v71
					end

					local v72 = v65.Weight * 10 + #u35.List[v59].Recipe * 5 + n2 / 10 + n1 / 10
					local clone = v40:Clone(BrainrotTrader.Odds.UIListLayout.Template)

					table.insert(t2, {
						frame = clone,
						score = v72
					})
					clone.Header.Title.Text = v63 or "???"

					for v74, v75 in Mutations2 do
						local v76 = Mutations[v74]

						if v76 then
							local clone2 = v40:Clone(clone.ScrollingFrame.UIListLayout.Template)

							clone2.Name = v74
							clone2.LayoutOrder = -v75
							clone2.Vector.Image = v76.Icon or ""
							clone2.Title.Text = if not v76.UseRichText then v76.DisplayText else v76.DisplayWithRichText
							clone2.Title.RichText = v76.UseRichText

							if v76.GradientPreset then
								clone2.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
								Gradients.apply(clone2.Title, v76.GradientPreset)
							else
								clone2.Title.TextColor3 = v76.MainColor
							end

							local _, fraction = math.modf(v75)

							clone2.Chance.Text = `{ string.format(fraction ~= 0 and "%.2f" or "%d", v75) }%`
							clone2.Visible = true
							clone2.Parent = clone.ScrollingFrame
						end
					end

					for v80, v81 in Traits2 do
						local v82 = Traits[v80]

						if v82 then
							local clone3 = v40:Clone(clone.ScrollingFrame.UIListLayout.Template)

							clone3.Name = v80
							clone3.LayoutOrder = -v81
							clone3.Vector.Image = v82.Icon or ""
							clone3.Title.Text = v82.DisplayWithRichText
							clone3.Title.TextColor3 = v82.Color
							clone3.Title.RichText = true

							local _, fraction = math.modf(v81)

							clone3.Chance.Text = `{ string.format(fraction ~= 0 and "%.2f" or "%d", v81) }%`
							clone3.Visible = true
							clone3.Parent = clone.ScrollingFrame
						end
					end
				end
			end
		end
	end

	table.sort(t2, function(p3, p4)
		return p3.score < p4.score
	end)

	for i = math.max(#t2 - 4, 1), #t2 do
		local frame = t2[i].frame

		frame.LayoutOrder = -i
		frame.Parent = if not (i > #t2 - 2) then BrainrotTrader.Odds else BrainrotTrader.Odds2
	end
end
local updateListVersion = 0
local function updateList()
	updateListVersion += 1
	local myVersion = updateListVersion
	v38:Clean()

	if not u35 then
		return
	end

	local v88 = Synchronizer:Get(LocalPlayer)

	if not v88 then
		return
	end

	local List = Frame.List

	for v90, v91 in u35.List do
		local num = tonumber(string.match(v90, "(%d+)"))

		if num then
			local v93 = Animals2[v91.Name]

			if v93 then
				local _ = Rarities[v93.Rarity]
				local Name = v91.Name
				local v96 = Animals2[Name]
				local v97 = List.UIListLayout[v91.Template or "Normal"]

				if not v97 or not v97:FindFirstChild("Spacer") then
					warn(`[BrainrotTrader] Template "{v91.Template or "Normal"}" is missing or malformed (no Spacer) - skipping entry {v90}`)
					continue
				end

				local clone = v38:Clone(v97);

				if myVersion ~= updateListVersion then return end

				({})[num] = clone
				clone.Visible = true
				clone.LayoutOrder = ((Animals:GetGeneration(v91.Name) or 0) - 1) * 2

				local clone4 = v38:Clone(List.UIListLayout.Dropdown)

				clone4.LayoutOrder = clone.LayoutOrder + 1
				clone4.Size = UDim2.fromScale(0.973, 0)
				clone4.Visible = false
				clone4.Parent = List
				clone.Spacer.DropRate.Text = `${ NumberUtils:ToString(Animals:GetGeneration(Name)) }/s`
				clone.Spacer.Txt.Text = Name
				renderBrainrotAtFrame(clone.Spacer.Brainrot, Name)
				if myVersion ~= updateListVersion or not clone.Parent and not clone:FindFirstChild("Spacer") then return end
				if v96 then
					local v100 = Rarities[v96.Rarity]

					if v100.GradientPreset then
						clone.Spacer.Txt.TextColor3 = Color3.new(1, 1, 1)
						Gradients.apply(clone.Spacer.Txt, v100.GradientPreset)
					else
						clone.Spacer.Txt.TextColor3 = v100.Color
					end
				end

				clone.Parent = List

				local function setExpanded(p5)
					if p5 then
						clone4.Visible = true
						Spr.target(clone4, 0.9, 6, {
							Size = UDim2.fromScale(0.973, 0.192)
						})

						return
					end

					Spr.target(clone4, 1, 6, {
						Size = UDim2.fromScale(0.973, 0)
					})
					Spr.completed(clone4, function()
						if clone4.Size.Y.Scale < 0.01 then
							clone4.Visible = false
						end
					end)
				end

				local t3 = {}

				for v103, v104 in v91.Recipe do
					local v105 = Animals2[v104]

					if v105 then
						local v106 = Rarities[v105.Rarity]
						local clone5 = v38:Clone(clone.Spacer.List.UIListLayout.Template)

						clone5.LayoutOrder = v106.Weight * 100 + v103
						clone5.Title.Text = v104
						clone5.Title.TextColor3 = Color3.new(1, 1, 1)

						if v106.GradientPreset then
							clone5.UIStroke.Color = Color3.new(1, 1, 1)
							v38:Add(Gradients.apply(clone5.UIStroke, v106.GradientPreset))
						else
							clone5.UIStroke.Color = v106.Color
						end

						clone5.Visible = true
						clone5.Return.Visible = false
						clone5.ViewportFrame.ImageColor3 = Color3.new(0, 0, 0)

						local v108 = Animals:AttachOnViewportWithOptimizations(v104, clone5.ViewportFrame, true)

						if myVersion ~= updateListVersion then return end

						if v108 then
							v38:Add(v108)
						end

						clone5.Parent = clone.Spacer.List

						if not t3[v104] then
							t3[v104] = {}
						end

						table.insert(t3[v104], clone5)

						local v109 = v38:Add(AnimatedButton.new(clone5.Return))

						v109:Animate()
						v38:Add(v109.OnActivated:Connect(function()
							for v116, v117 in (v88:Get("AnimalPodiums")) do
								if type(v117) == "table" and v117.Index == v104 and v117.Machine and v117.Machine.Type == "BrainrotTrader" and not v117.Machine.Active then
									v23:FireServer(v116)

									return
								end
							end
						end))
					end
				end

				local function updateBrainrotFrame()
					local t4 = {}

					for _, v120 in (v88:Get("AnimalPodiums")) do
						if type(v120) == "table" and v120.Machine and v120.Machine.Type == "BrainrotTrader" and not v120.Machine.Active then
							t4[v120.Index] = (t4[v120.Index] or 0) + 1
						end
					end

					local v121 = true

					for v122, v123 in t3 do
						local v124 = t4[v122] or 0

						for v125, v126 in v123 do
							local v127 = v125 <= v124

							v126.Return.Visible = v127
							v126.ViewportFrame.ImageColor3 = if not v127 then Color3.new(0, 0, 0) else Color3.new(1, 1, 1)

							if not v127 then
								v121 = false
							end
						end
					end

					setExpanded(v121)
					clone4.Spacer.Spawn.Interactable = v121
					clone4.Spacer.Spawn.BackgroundColor3 = if not v121 then Color3.fromRGB(127, 127, 127) else Color3.fromRGB(81, 158, 86)
				end

				v38:Add(v88:OnChanged("AnimalAddedOrRemoved", updateBrainrotFrame))
				v38:Add(task.spawn(updateBrainrotFrame))

				local v111 = AnimatedButton.new(clone4.Spacer.Spawn)

				v38:Add(v111)
				v111:Animate()
				v38:Add(v111.OnActivated:Connect(function()
					v24:FireServer(v90, Name)
					InterfaceController:Toggle("BrainrotTrader", false)
				end))
			end
		end
	end
end

function t1.Start(_)
	BrainrotTrader.Visible = false
	u34 = InterfaceController:Register("BrainrotTrader", BrainrotTrader, "TopQuint")
	u34:AttachCloseButton(Close)
	u34:Close()
	Synchronizer:WaitAndCall(LocalPlayer, function(p7)
		local function update()
			task.spawn(updateTimer)
		end

		p7:OnChanged("BrainrotTrader", update)
		p7:OnChanged("BrainrotTrader.Id", update)
		task.spawn(update)
	end)
	Timer.Simple(1, function()
		task.spawn(updateTimer)
	end)
	Observers.observeTag("BrainrotTraderPrompt", function(p8)
		local v131 = Trove.new()

		local function updatePrompt()
			if not Synchronizer:Wait(LocalPlayer) then
				return
			end

			p8.ActionText = "View"
			p8.ObjectText = "Brainrot Trader"
		end

		v131:Add(task.spawn(function()
			local v150 = Synchronizer:Wait(LocalPlayer)

			if not v150 then
				return
			end

			v150:OnChanged("BrainrotTrader", updatePrompt)
			v131:Add(Timer.Simple(1, updatePrompt))
			task.spawn(updatePrompt)
		end))
		v131:Add(p8.Triggered:Connect(function()
			if not Synchronizer:Get(LocalPlayer) then
				return
			end

			InterfaceController:Toggle("BrainrotTrader")
		end))

		return function()
			v131:Destroy()
		end
	end)
	Observers.observeTag("BrainrotTrader", function(p9)
		local v134 = Trove.new()

		for _, v136 in p9.Hitboxes:GetChildren() do
			v134:Add(v136.Touched:Connect(function(part)
				if part.Name ~= "HumanoidRootPart" then
					return
				end

				local player = Players:GetPlayerFromCharacter(part.Parent)

				if not player or player ~= LocalPlayer then
					return
				end

				if player:GetAttribute("StealingIndex") then
					local v153, _, _ = v25:InvokeServer(v136)

					if not v153 then
						return
					end

					task.spawn(function()
						SoundController:PlaySound(ReplicatedStorage.Sounds.Sfx["Fuse Machine"].Deposit)
					end)
					updateTimer()
				end
			end))
		end

		return function()
			v134:Destroy()
		end
	end)
	Observers.observeTag("BrainrotTraderNPC", function(p10)
		local v138 = Trove.new()
		local Animator = p10.Humanoid.Animator
		local v140 = Animator:LoadAnimation(script.Idle)

		v138:Add(function()
			v140:Stop(0)
			v140:Destroy()
		end)

		local v141 = v140

		v141.Priority = Enum.AnimationPriority.Idle
		v141.Looped = true
		v141:Play()

		local v142 = Animator:LoadAnimation(script.IdleToAction)

		v138:Add(function()
			v142:Stop(0)
			v142:Destroy()
		end)

		local v143 = v142

		v143.Priority = Enum.AnimationPriority.Action

		local v144 = Animator:LoadAnimation(script.ActionIdle)

		v138:Add(function()
			v144:Stop(0)
			v144:Destroy()
		end)

		local v145 = v144

		v145.Priority = Enum.AnimationPriority.Movement
		v145.Looped = true

		local v146 = Animator:LoadAnimation(script.ActionToIdle)

		v138:Add(function()
			v146:Stop(0)
			v146:Destroy()
		end)

		local v147 = v146

		v147.Priority = Enum.AnimationPriority.Action
		v138:Add(v143.Stopped:Connect(function()
			v145:Play()
		end))
		v138:Add(v145.Stopped:Connect(function()
			v147:Play()
		end))
		v138:Add(v21.OnClientEvent:Connect(function(_: string, s2: string)
			local v158 = script.SpawnEffects:FindFirstChild(s2) or script.SpawnEffects.Secret

			if not v158 then
				return
			end

			v143:Play()
			task.wait(0.5)

			local v159 = p10:GetPivot() * CFrame.new(0, 3.5, -3)

			task.spawn(function()
				local s2_2 = ReplicatedStorage.Sounds.Sfx.Merchant:FindFirstChild(s2) or ReplicatedStorage.Sounds.Sfx.Merchant.Secret

				if s2_2 then
					SoundController:PlaySound(s2_2, v159.Position)
				end
			end)

			local clone = v158:Clone()

			clone:PivotTo(v159)
			clone.Parent = workspace
			VFX.emit(clone)
			task.wait(2.5)
			v145:Stop()
		end))

		return v138:WrapClean()
	end, { workspace })
	v22.OnClientEvent:Connect(function(p11)
		u35 = p11
		updateList()
		updateMutationList()
	end)
	u35 = v26:InvokeServer() or u35
	task.spawn(updateList)
	Synchronizer:WaitAndCall(LocalPlayer, function(p12)
		p12:OnChanged("BrainrotTrader.Info", updateMutationList)
		task.spawn(updateMutationList)
		updateList()
	end)
end

return t1
