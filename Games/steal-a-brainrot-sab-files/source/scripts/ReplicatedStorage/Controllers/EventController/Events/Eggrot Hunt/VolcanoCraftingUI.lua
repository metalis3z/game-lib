
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)

require(ReplicatedStorage.Shared.Animals)

local CustomRichTextController = require(ReplicatedStorage.Controllers.CustomRichTextController)
local LocalPlayer = Players.LocalPlayer

Color3.fromRGB(255, 100, 20)

local t1 = {
	Start = function(_)
		local v11 = Trove.new()
		local u12 = nil
		local u13 = nil
		local u14 = nil

		local function refresh()
			local v16 = Synchronizer:Get(LocalPlayer)
			local v17 = if not v16 then nil else v16:Get({
				"EasterEvent",
				"VolcanoMachine"
			})
			local v18 = if type(v17) ~= "table" or type(v17.Inputs) ~= "table" then nil else v17.Inputs
			local v19 = (type(v17) ~= "table" or type(v17.CraftCost) ~= "number") and 0 or v17.CraftCost
			local v20 = not v18 and 0 or #v18
			local v21 = LocalPlayer:GetAttribute("Stealing") == true
			local v22 = LocalPlayer:GetAttribute("StealingFromVolcano") == true

			if u12 then
				if v21 and v22 then
					u12.ActionText = "Return Brainrot"
					u12.Enabled = true
				elseif v21 and v20 < 3 then
					u12.ActionText = `Insert Brainrot ({ v20 }/{ 3 })`
					u12.Enabled = true
				elseif not v21 and v20 >= 3 then
					u12.ActionText = `Craft (${ NumberUtils:ToString(v19) })`
					u12.Enabled = true
				else
					u12.ActionText = `Insert Brainrot ({ v20 }/{ 3 })`
					u12.Enabled = false
				end
			end

			if u13 then
				u13.Enabled = v20 >= 1 and not v21
			end

			if u14 then
				for _, child in u14:GetChildren() do
					if child:IsA("TextLabel") then
						child:Destroy()
					end
				end

				if v18 and #v18 > 0 then
					local v25 = #v18
					local v26 = math.floor(100 / v25)
					local v27 = 100 - v26 * v25

					for v28, v29 in v18 do
						if type(v29) == "table" and type(v29.Index) == "string" then
							local v30 = v26 + (not (v28 <= v27) and 0 or 1)
							local Index = v29.Index
							local TextLabel = Instance.new("TextLabel")

							TextLabel.Name = `Slot{ v28 }`
							TextLabel.Size = UDim2.new(1, 0, 0.3333333333333333, 0)
							TextLabel.BackgroundTransparency = 1
							TextLabel.TextColor3 = Color3.new(1, 1, 1)
							TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
							TextLabel.TextStrokeTransparency = 0.3
							TextLabel.TextScaled = true
							TextLabel.Font = Enum.Font.GothamBold
							TextLabel.TextXAlignment = Enum.TextXAlignment.Center
							TextLabel.LayoutOrder = v28
							TextLabel.Parent = u14

							local UIStroke = Instance.new("UIStroke")

							UIStroke.Thickness = 3
							UIStroke.Parent = TextLabel
							CustomRichTextController.apply(TextLabel, `{ Index } - { v30 }%`, {
								attachToInstance = true
							})
						end
					end
				end
			end
		end

		Synchronizer:WaitAndCall(LocalPlayer, function(p2)
			v11:Add(p2:OnChanged({
				"EasterEvent",
				"VolcanoMachine"
			}, refresh))
			task.spawn(refresh)
		end)
		v11:Add(LocalPlayer:GetAttributeChangedSignal("Stealing"):Connect(refresh))
		v11:Add(LocalPlayer:GetAttributeChangedSignal("StealingFromVolcano"):Connect(refresh))
		v11:Add(Observers.observeTag("EggrotVolcanoInsertCraft", function(p3)
			if not p3:IsA("ProximityPrompt") then
				return nil
			end

			u12 = p3
			refresh()

			return function()
				if u12 == p3 then
					u12 = nil
				end
			end
		end, { workspace }))
		v11:Add(Observers.observeTag("EggrotVolcanoWithdraw", function(p4)
			if not p4:IsA("ProximityPrompt") then
				return nil
			end

			u13 = p4
			refresh()

			return function()
				if u13 == p4 then
					u13 = nil
				end
			end
		end, { workspace }))
		v11:Add(Observers.observeTag("EggrotVolcanoMachine", function(p5)
			local v38 = Trove.new()
			local BillboardGui = Instance.new("BillboardGui")

			BillboardGui.Name = "VolcanoContents"
			BillboardGui.AlwaysOnTop = false
			BillboardGui.Size = UDim2.fromScale(30, 6)
			BillboardGui.StudsOffset = Vector3.new(0, 10, 0)
			BillboardGui.MaxDistance = 300
			BillboardGui.Parent = p5
			v38:Add(BillboardGui)

			local Frame = Instance.new("Frame")

			Frame.Name = "Container"
			Frame.Size = UDim2.fromScale(1, 1)
			Frame.BackgroundTransparency = 1
			Frame.Parent = BillboardGui
			v38:Add(Frame)

			local UIListLayout = Instance.new("UIListLayout")

			UIListLayout.FillDirection = Enum.FillDirection.Vertical
			UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			UIListLayout.Padding = UDim.new(0.02, 0)
			UIListLayout.Parent = Frame
			u14 = Frame
			refresh()

			return function()
				v38:Destroy()

				if u14 == Frame then
					u14 = nil
				end
			end
		end, { workspace }))

		return function()
			v11:Destroy()
		end
	end
}

return table.freeze(t1)
