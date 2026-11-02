-- --This file Was Made By FaypleStudios 
--Our Discord Server , https://discord.gg/Cv4J9mEUfj
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local Animals = require(ReplicatedStorage.Shared.Animals)
local Index = require(ReplicatedStorage.Shared.Index)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Gradients = require(ReplicatedStorage.Packages.Gradients)
local Updates = require(ReplicatedStorage.Shared.Updates)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Spr = require(ReplicatedStorage.Packages.Spr)
local Net = require(ReplicatedStorage.Packages.Net)
local Rarities = require(ReplicatedStorage.Datas.Rarities)
local Animals2 = require(ReplicatedStorage.Datas.Animals)
local Index2 = require(ReplicatedStorage.Datas.Index)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local v20 = Net:RemoteEvent("BaseIndexService/Claim")

local function renderBrainrotAtFrame(p1, s1: string)
	local v27 = Animals2[s1]

	if not v27 then
		return
	end

	local v28 = Rarities[v27.Rarity]

	p1.Title.Text = s1
	p1.RarityLabel.Text = v27.Rarity

	if v28.GradientPreset then
		p1.RarityLabel.TextColor3 = Color3.new(1, 1, 1)
		Gradients.apply(p1.RarityLabel, v28.GradientPreset)
	else
		p1.RarityLabel.TextColor3 = v28.Color
	end

	p1.Visible = true
	Animals:AttachOnViewportWithOptimizations(s1, p1.ViewportFrame)
end

return {
	Register = function(_: {[any]: any}, t2: {[any]: any})
		local v33 = Trove.new()

		v33:Add(task.spawn(function()
			local t2ScreenGuiName = PlayerGui:WaitForChild(t2.ScreenGuiName)
			local FramePath = t2.FramePath

			for match in string.gmatch(FramePath, "[^%.]+") do
				t2ScreenGuiName = t2ScreenGuiName[match]
			end

			local v44 = t2ScreenGuiName

			v44.Visible = false

			local v45 = InterfaceController:Get(t2.ScreenGuiName)
			local v46 = v45 or InterfaceController:Register(t2.ScreenGuiName, v44, "TopQuint")

			if not v45 then
				v46:AttachCloseButton(v44.Main.Header.Close)
			end

			v46:Close()

			local v47 = Synchronizer:Wait(LocalPlayer)

			if not v47 then
				return
			end

			local v48 = v33:Extend()

			local function updateBrainrots()
				v48:Clean()

				local List = v44.Main.Content.Holder.List

				for _, v74 in List:GetChildren() do
					if v74:IsA("GuiObject") and v74.Name ~= "Template" then
						v74:Destroy()
					end
				end

				local List2 = Animals:GetList("Generation", true)
				local v76 = assert(Index2[t2.IndexName].Index)

				for i = 1, #List2 do
					local v78 = List2[i]

					if v76[v78] and Animals2[v78] then
						local clone = v48:Clone(v44.Main.Content.Holder.List.Template)

						clone.Name = v78
						clone.LayoutOrder = i
						renderBrainrotAtFrame(clone, v78)
						clone.Visible = true

						local ViewportFrame = clone.ViewportFrame
						local IndexName = t2.IndexName

						local function updateAnimal()
							local v97 = v47:Get({
								"Index",
								v78
							})
							local v98 = v97 ~= nil and v97[IndexName] or nil

							clone.Title.Visible = v98
							ViewportFrame.ImageColor3 = not v98 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
						end

						v48:Add(v47:OnChanged({
							"Index",
							v78
						}, updateAnimal, true))
						task.spawn(updateAnimal)
						clone.Parent = List
					end
				end
			end

			updateBrainrots()

			local SkinName = t2.SkinName
			local t2Id = t2.Id

			local function updateProgress()
				local v83, v84, v85 = Index:GetIndexAnimals(LocalPlayer, t2.IndexName)

				assert(v83, v84, v85)
				v44.Main.Content.Base.AmountLabel.Text = `{ v83 }/{ v84 }`
				v44.Main.Content.Base.Claim.Label.Text = not v47:Get(`UnlockedBaseSkins.{ SkinName }`) and "Claim" or "Claimed"
				Spr.target(v44.Main.Content.Base.Claim, 1, 5, {
					BackgroundColor3 = if not (v84 <= v83) or v47:Get(`UnlockedBaseSkins.{ SkinName }`) then Color3.fromRGB(112, 112, 112) else Color3.fromRGB(81, 158, 86)
				})
			end

			v33:Add(v44.Main.Content.Base.Claim.Activated:Connect(function()
				v20:FireServer(t2Id)
			end))
			v33:Add(v47:OnChanged("AnimalAddedOrRemoved", updateProgress))
			v33:Add(v47:OnDictionaryInserted("UnlockedBaseSkins", updateProgress))
			v33:Add(v47:OnDictionaryRemoved("UnlockedBaseSkins", updateProgress))
			v33:Add(Updates.OnUpdateEnabled:Connect(function()
				updateBrainrots()
				updateProgress()
			end))
			v33:Add(Updates.OnUpdateDisabled:Connect(function()
				updateBrainrots()
				updateProgress()
			end))
			updateProgress()
		end))
		v33:Add(Observers.observeTag(t2.PromptTag, function(p2)
			local connection = p2.Triggered:Connect(function()
				if not Synchronizer:Get(LocalPlayer) then
					return
				end

				InterfaceController:Toggle(t2.ScreenGuiName)
			end)

			return function()
				connection:Disconnect()
			end
		end))

		if t2.MotorTag then
			local MotorTag = t2.MotorTag

			v33:Add(Observers.observeTag(MotorTag, function(p3)
				local u56 = os.clock() + 15
				local n2 = nil
				local n1 = nil
				local elapsed = os.clock()
				local connection = RunService.PostSimulation:Connect(function()
					local elapsed2 = os.clock()

					p3.Transform = CFrame.new(0, math.sin(elapsed2 * 2) * 0.25, 0)

					if elapsed2 > u56 then
						n1 = 0
						u56 = elapsed2 + 15
					elseif n1 ~= nil then
						local v87 = elapsed2 - elapsed

						n1 += v87

						local v88 = n1 / 2
						local Value = TweenService:GetValue(v88, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
						local v90 = p3

						v90.Transform = v90.Transform * CFrame.Angles(0, Value * 3 * 3.141592653589793 * 2, 0)

						if v88 > 0.75 and not n2 then
							n2 = 0
						end

						if n1 >= 2 then
							n1 = nil
						end
					end

					if n2 ~= nil then
						n2 += elapsed2 - elapsed

						local v91 = if n1 == nil then 1 - math.clamp(n2 / 2, 0, 1) else math.clamp((n1 / 2 - 0.5) / 0.5, 0, 1)
						local v92 = elapsed2 * 14
						local v93 = 0.04 * v91
						local v94 = 0.025 * v91
						local v95 = CFrame.new(math.noise(v92, 0, 0) * v93, math.noise(0, v92, 0) * v93, 0) * CFrame.Angles(math.noise(v92, v92, 0) * v94, 0, math.noise(0, v92, v92) * v94)
						local v96 = p3

						v96.Transform = v96.Transform * v95

						if n1 == nil and n2 >= 2 then
							n2 = nil
						end
					end

					elapsed = elapsed2
				end)

				return function()
					connection:Disconnect()
					p3.Transform = CFrame.identity
				end
			end))
		end

		return v33
	end
}
