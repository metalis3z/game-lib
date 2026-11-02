
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v6 = require(ReplicatedStorage.Packages.Net):RemoteEvent("EggrotHunt/JumpShopTutorialShown")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local TutorialArrow = script.TutorialArrow

local function FindJumpShopPart()
	for _, v13 in CollectionService:GetTagged("EggrotJumpShopPrompt") do
		if v13:IsA("ProximityPrompt") and v13.Parent and v13.Parent:IsA("BasePart") then
			return v13.Parent
		end
	end

	return nil
end

local t1 = {
	Start = function(_)
		local v15 = Trove.new()

		Synchronizer:WaitAndCall(LocalPlayer, function(p2)
			if p2:Get({
				"EasterEvent",
				"JumpShopTutorialShown"
				}) then
				return
			end

			if p2:Get({
				"EasterEvent",
				"JumpShop"
				}) ~= 0 then
				return
			end

			local u17 = false
			local u18 = false
			local v19 = Trove.new()

			v15:Add(v19)

			local function dismiss()
				if u18 then
					return
				end

				u18 = true

				local Main = PlayerGui:FindFirstChild("Main")

				if Main then
					local Tutorial = Main:FindFirstChild("Tutorial")

					if Tutorial then
						local TextLabel = Tutorial:FindFirstChild("TextLabel")

						if TextLabel and TextLabel:IsA("TextLabel") then
							TextLabel.Visible = false
						end
					end
				end

				v19:Destroy()
			end
			local function showTutorial()
				if u17 or u18 then
					return
				end

				u17 = true

				local HumanoidRootPart = (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()):WaitForChild("HumanoidRootPart", 5)

				if not HumanoidRootPart then
					dismiss()

					return
				end

				local v26 = FindJumpShopPart()

				if not v26 then
					dismiss()

					return
				end

				local clone = v19:Clone(TutorialArrow)

				clone.Start.CFrame = HumanoidRootPart.CFrame

				local WeldConstraint = Instance.new("WeldConstraint")

				WeldConstraint.Part0 = HumanoidRootPart
				WeldConstraint.Part1 = clone.Start
				WeldConstraint.Parent = clone.Start
				clone.End.CFrame = v26.CFrame
				clone.Parent = workspace

				local TextLabel = PlayerGui:WaitForChild("Main").Tutorial.TextLabel

				TextLabel.Text = "Go buy your first double jump!"
				TextLabel.Visible = true
				v6:FireServer()

				local u30 = p2:Get({
					"EasterEvent",
					"BunnyCoins"
				})

				v19:Add(p2:OnChanged({
					"EasterEvent",
					"JumpShop"
				}, function(p3)
					if type(p3) == "number" and p3 >= 1 then
						dismiss()
					end
				end))
				v19:Add(p2:OnChanged({
					"EasterEvent",
					"BunnyCoins"
				}, function(p4)
					if type(p4) == "number" and (type(u30) == "number" and p4 < u30) then
						dismiss()
					end

					u30 = p4
				end))
				v19:Add(task.delay(60, dismiss))
			end

			v15:Add(p2:OnChanged({
				"EasterEvent",
				"BunnyCoins"
			}, function(p5)
				if u17 or u18 then
					return
				end

				if type(p5) == "number" and p5 >= 25 then
					task.spawn(showTutorial)
				end
			end))
		end)

		return function()
			v15:Destroy()
		end
	end
}

return table.freeze(t1)
