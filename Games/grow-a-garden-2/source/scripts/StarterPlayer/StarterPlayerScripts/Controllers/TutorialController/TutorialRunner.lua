--credit to quartz games studio
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = assert(Players.LocalPlayer)
local PlayerGui = v1:WaitForChild("PlayerGui")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local TutorialUtils = require(script.Parent.TutorialUtils)
local PlayerScripts = v1:WaitForChild("PlayerScripts")
local NotificationController = require(PlayerScripts.Controllers.NotificationController)
local v2 = if RunService:IsStudio() then print else function(...) --[[ Line: 38 ]] end
local t = {
	Variant1 = {
		Notifications = false,
		ForceTeleportGarden = false,
		ButtonHighlights = false
	},
	Variant2 = {
		Notifications = true,
		ForceTeleportGarden = false,
		ButtonHighlights = false
	},
	Variant3 = {
		Notifications = true,
		ForceTeleportGarden = true,
		ButtonHighlights = false
	},
	Variant4 = {
		Notifications = false,
		ForceTeleportGarden = true,
		ButtonHighlights = false
	},
	Variant5 = {
		Notifications = false,
		ForceTeleportGarden = false,
		ButtonHighlights = true
	},
	Variant6 = {
		Notifications = true,
		ForceTeleportGarden = false,
		ButtonHighlights = true
	},
	Variant7 = {
		Notifications = false,
		ForceTeleportGarden = false,
		ButtonHighlights = false
	},
	Variant8 = {
		Notifications = true,
		ForceTeleportGarden = false,
		ButtonHighlights = false
	},
	Variant9 = {
		Notifications = true,
		ForceTeleportGarden = true,
		ButtonHighlights = false
	},
	Variant10 = {
		Notifications = false,
		ForceTeleportGarden = true,
		ButtonHighlights = false
	},
	Variant11 = {
		Notifications = false,
		ForceTeleportGarden = false,
		ButtonHighlights = true
	},
	Variant12 = {
		Notifications = true,
		ForceTeleportGarden = false,
		ButtonHighlights = true
	}
}
local SeedShop = PlayerGui:WaitForChild("SeedShop")
local TeleportButtons = PlayerGui:WaitForChild("TeleportButtons"):WaitForChild("TeleportButtons")
local SeedsButton = TeleportButtons:WaitForChild("SeedsButton")
local GardenButton = TeleportButtons:WaitForChild("GardenButton")
local SellButton = TeleportButtons:WaitForChild("SellButton")
local Pointer = PlayerGui:WaitForChild("TutorialUI"):WaitForChild("Pointer")

local function notify(p1, p2) --[[ notify | Line: 111 | Upvalues: v2 (copy), NotificationController (copy) ]]
	if p1.Notifications then
		v2((("[Tutorial] Notifying: %*"):format(p2)))
		NotificationController:CreateNotification(p2, nil, 5)
	end
end

local function getCarrotFrame() --[[ getCarrotFrame | Line: 120 | Upvalues: SeedShop (copy) ]]
	return SeedShop.Frame.NormalShop:FindFirstChild("Carrot")
end

local function getNormalShop() --[[ getNormalShop | Line: 124 | Upvalues: SeedShop (copy) ]]
	return SeedShop.Frame.NormalShop
end

local function findSeedHotbarSlot() --[[ findSeedHotbarSlot | Line: 128 | Upvalues: PlayerGui (copy) ]]
	local BackpackGui = PlayerGui:FindFirstChild("BackpackGui")
	local v1 = if BackpackGui then BackpackGui:FindFirstChild("Backpack") else BackpackGui
	local v2 = if v1 then v1:FindFirstChild("Hotbar") else v1

	if not v2 then
		return nil, nil
	end

	for i = 1, 10 do
		local v3 = v2:FindFirstChild((tostring(i)))

		if v3 and v3:IsA("GuiObject") then
			local ToolName = v3:FindFirstChild("ToolName")

			if ToolName and (ToolName:IsA("TextLabel") and string.find(ToolName.Text, "Seed")) then
				return v3.AbsolutePosition + Vector2.new(v3.AbsoluteSize.X * 0.5, 0), v3
			end
		end
	end

	return nil, nil
end

local function createTapIcon(p1) --[[ createTapIcon | Line: 151 | Upvalues: TweenService (copy) ]]
	local Part = Instance.new("Part")

	Part.Anchored = true
	Part.CanCollide = false
	Part.CanQuery = false
	Part.CanTouch = false
	Part.Transparency = 1
	Part.Size = Vector3.new(0.001, 0.001, 0.001)
	Part.Position = p1

	local BillboardGui = Instance.new("BillboardGui")

	BillboardGui.Size = UDim2.fromScale(3, 3)
	BillboardGui.StudsOffset = Vector3.new(0, 2, 0)
	BillboardGui.AlwaysOnTop = true
	BillboardGui.Parent = Part

	local ImageLabel = Instance.new("ImageLabel")

	ImageLabel.Image = "rbxassetid://7553620727"
	ImageLabel.Size = UDim2.fromScale(1, 1)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Parent = BillboardGui

	local UIScale = Instance.new("UIScale")

	UIScale.Scale = 1
	UIScale.Parent = ImageLabel
	TweenService:Create(UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
		Scale = 1.3
	}):Play()
	Part.Parent = workspace

	return Part
end

local function getOptionText(p1) --[[ getOptionText | Line: 189 ]]
	local Text_Element = p1:FindFirstChild("Text_Element", true)

	if not Text_Element then
		return nil
	end

	local v1 = Text_Element:GetAttribute("Text")

	if type(v1) == "string" then
		return v1
	end

	return nil
end

local function findOptionInBillboard(p1) --[[ findOptionInBillboard | Line: 200 | Upvalues: PlayerGui (copy) ]]
	local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI")

	if not Billboard_UI then
		return nil
	end

	local Objects = Billboard_UI:FindFirstChild("Objects")

	if not Objects then
		return nil
	end

	for v2, v3 in Objects:GetChildren() do
		local v1

		if v3:IsA("GuiObject") then
			local Text_Element = v3:FindFirstChild("Text_Element", true)

			if Text_Element then
				local v4 = Text_Element:GetAttribute("Text")

				v1 = if type(v4) == "string" then v4 else nil
			else
				v1 = nil
			end

			if v1 and string.find(v1, p1, 1, true) then
				return v3
			end
		end
	end

	return nil
end

local function isBillboardOpen() --[[ isBillboardOpen | Line: 221 | Upvalues: PlayerGui (copy) ]]
	local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI")

	if not Billboard_UI then
		return false
	end

	local Objects = Billboard_UI:FindFirstChild("Objects")

	return if Objects == nil then false else #Objects:GetChildren() > 1
end

local function waitForDialogueOption(p1, p2) --[[ waitForDialogueOption | Line: 230 | Upvalues: PlayerGui (copy), v2 (copy), findOptionInBillboard (copy) ]]
	local sum = 0
	local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI")
	local v1

	if Billboard_UI then
		local Objects = Billboard_UI:FindFirstChild("Objects")

		v1 = if Objects == nil then false elseif #Objects:GetChildren() > 1 then true else false
	else
		v1 = false
	end

	local v22 = nil

	while not (p2 and p2()) do
		local v3
		local v4 = findOptionInBillboard(p1)

		if v4 then
			return v4
		end

		local Billboard_UI2 = PlayerGui:FindFirstChild("Billboard_UI")

		if Billboard_UI2 then
			local Objects = Billboard_UI2:FindFirstChild("Objects")

			v3 = if Objects == nil then false elseif #Objects:GetChildren() > 1 then true else false
		else
			v3 = false
		end

		if v3 then
			v1 = true
			v22 = nil
		elseif v1 and v22 then
			if os.clock() - v22 > 1 then
				v2((("[Tutorial] Billboard closed while waiting for \"%*\""):format(p1)))

				return nil
			end
		elseif v1 then
			v22 = os.clock()
		end

		sum = sum + 0.1

		if sum >= 2 then
			sum = 0

			local Billboard_UI3 = PlayerGui:FindFirstChild("Billboard_UI")

			if Billboard_UI3 then
				local Objects = Billboard_UI3:FindFirstChild("Objects")

				if Objects then
					local t = {}

					for v7, v8 in Objects:GetChildren() do
						local v6

						if v8:IsA("GuiObject") then
							local Text_Element = v8:FindFirstChild("Text_Element", true)

							if Text_Element then
								local v9 = Text_Element:GetAttribute("Text")

								v6 = if type(v9) == "string" then v9 else nil
							else
								v6 = nil
							end
						else
							v6 = nil
						end

						table.insert(t, (("%*=%*"):format(v8.Name, v6 or "nil")))
					end

					v2((("[Tutorial] Searching for \"%*\", available: [%*]"):format(p1, (table.concat(t, ", ")))))
				else
					v2((("[Tutorial] Searching for \"%*\", no Objects container"):format(p1)))
				end
			else
				v2((("[Tutorial] Searching for \"%*\", no Billboard_UI"):format(p1)))
			end
		end

		task.wait(0.1)
	end

	v2((("[Tutorial] shouldStop fired while waiting for \"%*\""):format(p1)))

	return nil
end

local function highlightDialogueOption(p1, p2) --[[ highlightDialogueOption | Line: 283 | Upvalues: TweenService (copy), Pointer (copy) ]]
	local UIStroke = Instance.new("UIStroke")

	UIStroke.Thickness = 99999
	UIStroke.Color = Color3.new(0/255, 0/255, 0/255)
	UIStroke.Transparency = 1
	UIStroke.Parent = p1
	TweenService:Create(UIStroke, TweenInfo.new(0.3), {
		Transparency = 0.5
	}):Play()

	local v1 = Pointer:Clone()

	v1.Image = "rbxassetid://7553620727"
	v1.ImageTransparency = 0
	v1.Visible = true
	v1.AnchorPoint = Vector2.new(0.5, 0)
	v1.Position = UDim2.fromScale(0.5, 0.5)
	v1.SizeConstraint = Enum.SizeConstraint.RelativeYY
	v1.Size = if p2 then p2 else UDim2.fromScale(1.5, 1.5)
	v1.Parent = p1

	local v3 = v1:FindFirstChildWhichIsA("UIScale")
	local v4 = if v3 then v3.Scale else 1
	local v5 = if v3 then TweenService:Create(v3, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
	Scale = v4 * 1.1
}) else nil

	if v5 then
		v5:Play()
	end

	return function() --[[ Line: 328 | Upvalues: v5 (copy), v1 (copy), UIStroke (copy) ]]
		if v5 then
			v5:Cancel()
		end

		v1:Destroy()
		UIStroke:Destroy()
	end
end

local function waitForDialogueOptionAndHighlight(p1, p2, p3) --[[ waitForDialogueOptionAndHighlight | Line: 337 | Upvalues: v2 (copy), waitForDialogueOption (copy), highlightDialogueOption (copy), PlayerGui (copy) ]]
	v2((("[Tutorial] waitForDialogueOptionAndHighlight: searching for \"%*\""):format(p1)))

	local v1 = waitForDialogueOption(p1, p3)

	if not v1 then
		return false
	end

	v2((("[Tutorial] Found \"%*\" -> %*, highlighting"):format(p1, (v1:GetFullName()))))

	local v22 = highlightDialogueOption(v1, p2)

	while v1.Parent do
		local v3

		if p3 and p3() then
			v2((("[Tutorial] shouldStop fired while highlighting \"%*\""):format(p1)))

			break
		end

		local Text_Element = v1:FindFirstChild("Text_Element", true)

		if Text_Element then
			local v4 = Text_Element:GetAttribute("Text")

			v3 = if type(v4) == "string" then v4 else nil
		else
			v3 = nil
		end

		if not (v3 and string.find(v3, p1, 1, true)) then
			break
		end

		task.wait(0.1)
	end

	v22()

	if p3 and p3() then
		return true
	end

	task.wait(0.3)

	local Billboard_UI = PlayerGui:FindFirstChild("Billboard_UI")
	local v5

	if Billboard_UI then
		local Objects = Billboard_UI:FindFirstChild("Objects")

		v5 = if Objects == nil then false elseif #Objects:GetChildren() > 1 then true else false
	else
		v5 = false
	end

	if v5 then
		v2((("[Tutorial] \"%*\" step complete, advancing"):format(p1)))

		return true
	end

	v2((("[Tutorial] Billboard closed during \"%*\" without clicking, restarting"):format(p1)))

	return false
end

local function focusButtonAndWait(p1) --[[ focusButtonAndWait | Line: 380 | Upvalues: TutorialUtils (copy) ]]
	local v1 = TutorialUtils.focusObject(p1)
	local v2 = TutorialUtils.pointToUI(function() --[[ Line: 382 | Upvalues: p1 (copy) ]]
		return p1.AbsolutePosition + p1.AbsoluteSize * 0.5
	end)

	p1.Activated:Wait()
	v2()
	v1(0.2)
	task.wait(0.3)
end

local function distanceFromCharacter(p1) --[[ distanceFromCharacter | Line: 393 | Upvalues: v1 (copy) ]]
	local Character = v1.Character
	local v12 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character

	if v12 then
		return (v12.Position - p1).Magnitude
	end

	return 0
end

local function navigateToSeedShop(p1) --[[ navigateToSeedShop | Line: 402 | Upvalues: TutorialUtils (copy), v1 (copy), focusButtonAndWait (copy), SeedsButton (copy), RunService (copy) ]]
	local identity = CFrame.identity

	if not p1.ButtonHighlights then
		local v12 = TutorialUtils.observeTag("Tutorial_SeedShopNPC", function(p1) --[[ Line: 431 | Upvalues: identity (ref) ]]
			identity = p1.CFrame

			return nil
		end, { workspace })
		local v2 = TutorialUtils.createArrow(v1, identity)
		local v3 = RunService.PreRender:Connect(function() --[[ Line: 437 | Upvalues: v2 (copy), identity (ref) ]]
			v2.move(identity)
		end)

		TutorialUtils.waitUntilDistance(function() --[[ Line: 441 | Upvalues: identity (ref) ]]
			return identity.Position
		end, 15)

		return function() --[[ Line: 445 | Upvalues: v3 (copy), v2 (copy), v12 (copy) ]]
			v3:Disconnect()
			v2.destroy()
			v12()
		end
	end

	local v4 = TutorialUtils.observeTag("Tutorial_SeedShopNPC", function(p1) --[[ Line: 406 | Upvalues: identity (ref) ]]
		identity = p1.CFrame

		return nil
	end, { workspace })
	local Position = identity.Position
	local Character = v1.Character
	local v5 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local v7, v8

	if not ((if v5 then (v5.Position - Position).Magnitude else 0) > 15) then
		v7 = TutorialUtils.createArrow(v1, identity)
		v8 = RunService.PreRender:Connect(function() --[[ Line: 416 | Upvalues: v7 (copy), identity (ref) ]]
			v7.move(identity)
		end)
		TutorialUtils.waitUntilDistance(function() --[[ Line: 420 | Upvalues: identity (ref) ]]
			return identity.Position
		end, 15)

		return function() --[[ Line: 424 | Upvalues: v8 (copy), v7 (copy), v4 (copy) ]]
			v8:Disconnect()
			v7.destroy()
			v4()
		end
	end

	focusButtonAndWait(SeedsButton)
	v7 = TutorialUtils.createArrow(v1, identity)
	v8 = RunService.PreRender:Connect(function() --[[ Line: 416 | Upvalues: v7 (copy), identity (ref) ]]
		v7.move(identity)
	end)
	TutorialUtils.waitUntilDistance(function() --[[ Line: 420 | Upvalues: identity (ref) ]]
		return identity.Position
	end, 15)

	return function() --[[ Line: 424 | Upvalues: v8 (copy), v7 (copy), v4 (copy) ]]
		v8:Disconnect()
		v7.destroy()
		v4()
	end
end

local function navigateToPlot(p1, p2, p3) --[[ navigateToPlot | Line: 452 | Upvalues: TutorialUtils (copy), focusButtonAndWait (copy), GardenButton (copy), v1 (copy) ]]
	if p1.ButtonHighlights or p1.ForceTeleportGarden then
		if not TutorialUtils.isInsidePlot(p2) then
			focusButtonAndWait(GardenButton)
		end

		if TutorialUtils.isInsidePlot(p2) then
			return function() --[[ Line: 461 ]] end
		end

		local v2 = TutorialUtils.createArrow(v1, CFrame.new(p3))

		while not TutorialUtils.isInsidePlot(p2) do
			task.wait(0.1)
		end

		return function() --[[ Line: 470 | Upvalues: v2 (copy) ]]
			v2.destroy()
		end
	end

	local v3 = TutorialUtils.createArrow(v1, CFrame.new(p3))

	while not TutorialUtils.isInsidePlot(p2) do
		task.wait(0.1)
	end

	return function() --[[ Line: 481 | Upvalues: v3 (copy) ]]
		v3.destroy()
	end
end

local function navigateToSteven(p1) --[[ navigateToSteven | Line: 486 | Upvalues: TutorialUtils (copy), v1 (copy), focusButtonAndWait (copy), SellButton (copy), RunService (copy) ]]
	local identity = CFrame.identity

	if not p1.ButtonHighlights then
		local v12 = TutorialUtils.observeTag("Tutorial_SellNPC", function(p1) --[[ Line: 515 | Upvalues: identity (ref) ]]
			identity = p1.CFrame

			return nil
		end, { workspace })
		local v2 = TutorialUtils.createArrow(v1, identity)
		local v3 = RunService.PreRender:Connect(function() --[[ Line: 521 | Upvalues: v2 (copy), identity (ref) ]]
			v2.move(identity)
		end)

		TutorialUtils.waitUntilDistance(function() --[[ Line: 525 | Upvalues: identity (ref) ]]
			return identity.Position
		end, 15)

		return function() --[[ Line: 529 | Upvalues: v3 (copy), v2 (copy), v12 (copy) ]]
			v3:Disconnect()
			v2.destroy()
			v12()
		end
	end

	local v4 = TutorialUtils.observeTag("Tutorial_SellNPC", function(p1) --[[ Line: 490 | Upvalues: identity (ref) ]]
		identity = p1.CFrame

		return nil
	end, { workspace })
	local Position = identity.Position
	local Character = v1.Character
	local v5 = if Character then Character:FindFirstChild("HumanoidRootPart") else Character
	local v7, v8

	if not ((if v5 then (v5.Position - Position).Magnitude else 0) > 15) then
		v7 = TutorialUtils.createArrow(v1, identity)
		v8 = RunService.PreRender:Connect(function() --[[ Line: 500 | Upvalues: v7 (copy), identity (ref) ]]
			v7.move(identity)
		end)
		TutorialUtils.waitUntilDistance(function() --[[ Line: 504 | Upvalues: identity (ref) ]]
			return identity.Position
		end, 15)

		return function() --[[ Line: 508 | Upvalues: v8 (copy), v7 (copy), v4 (copy) ]]
			v8:Disconnect()
			v7.destroy()
			v4()
		end
	end

	focusButtonAndWait(SellButton)
	v7 = TutorialUtils.createArrow(v1, identity)
	v8 = RunService.PreRender:Connect(function() --[[ Line: 500 | Upvalues: v7 (copy), identity (ref) ]]
		v7.move(identity)
	end)
	TutorialUtils.waitUntilDistance(function() --[[ Line: 504 | Upvalues: identity (ref) ]]
		return identity.Position
	end, 15)

	return function() --[[ Line: 508 | Upvalues: v8 (copy), v7 (copy), v4 (copy) ]]
		v8:Disconnect()
		v7.destroy()
		v4()
	end
end

return function(p1) --[[ Line: 536 | Upvalues: t (copy), v2 (copy), TutorialUtils (copy), NotificationController (copy), navigateToSeedShop (copy), SeedShop (copy), RunService (copy), navigateToPlot (copy), v1 (copy), findSeedHotbarSlot (copy), createTapIcon (copy), navigateToSteven (copy), PlayerGui (copy), waitForDialogueOptionAndHighlight (copy), Networking (copy) ]]
	local v12 = t[p1]

	if not v12 then
		v2((("[TutorialRunner] Unknown variant \"%*\", falling back to Variant1"):format(p1)))
		v12 = t.Variant1
	end

	workspace:SetAttribute("InTutorial", true)

	local ok, result = xpcall(function() --[[ Line: 545 | Upvalues: TutorialUtils (ref), v2 (ref), p1 (copy), v12 (ref), NotificationController (ref), navigateToSeedShop (ref), SeedShop (ref), RunService (ref), navigateToPlot (ref), v1 (ref), findSeedHotbarSlot (ref), createTapIcon (ref), navigateToSteven (ref), PlayerGui (ref), waitForDialogueOptionAndHighlight (ref), Networking (ref) ]]
		local v13 = false

		for v22, v3 in TutorialUtils.getTools() do
			if v3:GetAttribute("FruitName") then
				v13 = true

				break
			end
		end

		local v4 = TutorialUtils.getPlayerPlot()
		local v5 = if v4 then v4:FindFirstChild("Plants") else v4
		local v6 = if v5 then #v5:GetChildren() else 0
		local v7 = if v6 > 0 then true else false
		local v8 = TutorialUtils.hasSeed()
		local v9 = 1

		if v13 then
			v9 = 8
		elseif v7 then
			v9 = 7
		elseif v8 then
			v9 = 4
		end

		v2((("[Tutorial] %* starting at step %* (fruit=%*, plants=%*, seed=%*, plot=%*)"):format(p1, v9, v13, v6, v8, v4 ~= nil)))

		if v9 <= 3 then
			v2("[Tutorial] Step 1: Navigate to seed shop")

			if v12.Notifications then
				v2("[Tutorial] Notifying: Head to the Seed Shop!")
				NotificationController:CreateNotification("Head to the Seed Shop!", nil, 5)
			end

			repeat
				if TutorialUtils.hasSeed() then
					break
				end

				local v17 = navigateToSeedShop(v12)

				while not SeedShop.Enabled do
					RunService.PreRender:Wait()
				end

				if v12.Notifications then
					v2("[Tutorial] Notifying: Buy a Carrot Seed!")
					NotificationController:CreateNotification("Buy a Carrot Seed!", nil, 5)
				end

				local v18 = false
				local v19 = "carrot"
				local v20 = nil
				local v21 = nil
				local NormalShop = SeedShop.Frame.NormalShop

				local function isCarrotSelected() --[[ isCarrotSelected | Line: 595 | Upvalues: NormalShop (copy) ]]
					return NormalShop.Sheckles_Shelf.Visible and NormalShop.Sheckles_Shelf.LayoutOrder == 4
				end

				if NormalShop.Sheckles_Shelf.Visible and (if NormalShop.Sheckles_Shelf.LayoutOrder == 4 then true else false) then
					v19 = "buy"
				end

				while true do
					if not SeedShop.Enabled or v18 then
						break
					end

					if v19 == "carrot" then
						v20 = TutorialUtils.focusObject(function() --[[ Line: 606 | Upvalues: SeedShop (ref) ]]
							local Carrot = SeedShop.Frame.NormalShop:FindFirstChild("Carrot")

							if Carrot then
								local Main_Frame = Carrot.Main_Frame

								return {
									Position = Main_Frame.AbsolutePosition,
									Size = Main_Frame.AbsoluteSize
								}
							end

							return nil
						end)
						v21 = TutorialUtils.pointToUI(function() --[[ Line: 615 | Upvalues: SeedShop (ref) ]]
							local Carrot = SeedShop.Frame.NormalShop:FindFirstChild("Carrot")

							if Carrot then
								local Main_Frame = Carrot.Main_Frame

								return Main_Frame.AbsolutePosition + Main_Frame.AbsoluteSize * 0.5
							end

							return nil
						end)

						while SeedShop.Enabled do
							if NormalShop.Sheckles_Shelf.Visible and (if NormalShop.Sheckles_Shelf.LayoutOrder == 4 then true else false) then
								break
							end

							RunService.PreRender:Wait()
						end

						if v21 then
							v21()
							v21 = nil
						end

						if v20 then
							v20(0.2)
							v20 = nil
						end

						if not SeedShop.Enabled then
							break
						end

						v19 = "buy"
					end

					if v19 == "buy" then
						v20 = TutorialUtils.focusObject(function() --[[ Line: 647 | Upvalues: NormalShop (copy) ]]
							if NormalShop.Sheckles_Shelf.Visible then
								local BuyButton = NormalShop.Sheckles_Shelf.Main_Frame.Buttons.BuyButton

								return {
									Position = BuyButton.AbsolutePosition,
									Size = BuyButton.AbsoluteSize
								}
							end

							return nil
						end)
						v21 = TutorialUtils.pointToUI(function() --[[ Line: 654 | Upvalues: NormalShop (copy) ]]
							if NormalShop.Sheckles_Shelf.Visible then
								local BuyButton = NormalShop.Sheckles_Shelf.Main_Frame.Buttons.BuyButton

								return BuyButton.AbsolutePosition + BuyButton.AbsoluteSize * 0.5
							end

							return nil
						end)

						while SeedShop.Enabled and not TutorialUtils.hasSeed() do
							task.wait(0.1)
						end

						if v21 then
							v21()
							v21 = nil
						end

						if v20 then
							v20(0.2)
							v20 = nil
						end

						if TutorialUtils.hasSeed() then
							v18 = true
						end

						break
					end
				end

				if v21 then
					v21()
				end

				if v20 then
					v20(0)
				end

				v17()
			until v18

			if SeedShop.Enabled then
				local ExitButton = SeedShop.Frame.Header.ExitButton
				local v24 = TutorialUtils.pointToUI(function() --[[ Line: 700 | Upvalues: SeedShop (ref), ExitButton (copy) ]]
					if SeedShop.Enabled then
						return ExitButton.AbsolutePosition + ExitButton.AbsoluteSize * 0.5
					end

					return nil
				end)

				while SeedShop.Enabled do
					task.wait(0.1)
				end

				v24()
			end
		end

		local v25, v26, v27, v28, _, v29, v30, v31, v32, v33, v34, v35, v36, v37, v38, v39, v40, v41, v42, v43, v44, v45, v46, v47, v48, v49, v50, v51

		if v9 <= 6 then
			v2("[Tutorial] Step 4: Navigate to plot")

			if v12.Notifications then
				v2("[Tutorial] Notifying: Go to your Garden!")
				NotificationController:CreateNotification("Go to your Garden!", nil, 5)
			end

			local v52

			while true do
				v52 = TutorialUtils.getPlayerPlot()

				if v52 then
					break
				end

				task.wait(0.5)
			end

			local v53 = v52
			local v54 = assert(v53:FindFirstChild("SpawnPoint"))

			assert(v54:IsA("BasePart"), "SpawnPoint must be a BasePart")

			local Position = v54.Position
			local v56 = assert(v53:FindFirstChild("Plants"))

			assert(v56:IsA("Folder"), "Plants must be a Folder")

			local v58 = false
			local v59 = v56.ChildAdded:Connect(function() --[[ Line: 739 | Upvalues: v58 (ref) ]]
				v58 = true
			end)

			if #v56:GetChildren() > 0 then
				v58 = true
			end

			if not v58 then
				navigateToPlot(v12, v53, Position)()
			end

			v59:Disconnect()

			if not v58 then
				if v12.Notifications then
					v2("[Tutorial] Notifying: Plant your seed!")
					NotificationController:CreateNotification("Plant your seed!", nil, 5)
				end

				local function isSeedEquipped() --[[ isSeedEquipped | Line: 757 | Upvalues: v1 (ref) ]]
					local Character = v1.Character
					local v12 = if Character then Character:FindFirstChildWhichIsA("Tool") else nil

					return if v12 == nil then false else v12:GetAttribute("SeedTool") ~= nil
				end

				local Character = v1.Character
				local v60 = if Character then Character:FindFirstChildWhichIsA("Tool") else nil

				if not (if v60 == nil then false else v60:GetAttribute("SeedTool") ~= nil) then
					local v62 = TutorialUtils.pointToUI(function() --[[ Line: 764 | Upvalues: findSeedHotbarSlot (ref) ]]
						return findSeedHotbarSlot()
					end)

					TutorialUtils.waitUntilSeedEquipped()
					v62()
				end

				v58 = if #v56:GetChildren() > 0 then true else false

				if v58 then
					if v9 <= 7 then
						v2("[Tutorial] Step 7: Wait for growth")

						if v12.Notifications then
							v2("[Tutorial] Notifying: Wait for your crop to grow...")
							NotificationController:CreateNotification("Wait for your crop to grow...", nil, 5)
						end

						while true do
							v25 = TutorialUtils.getPlayerPlot()

							if v25 then
								break
							end

							task.wait(0.5)
						end

						v26 = assert(v25:FindFirstChild("Plants"))
						v27 = v1.UserId
						v28 = function() --[[ findPlantModel | Line: 854 | Upvalues: v26 (copy), v27 (copy) ]]
							for v1, v2 in v26:GetChildren() do
								if v2:IsA("Model") then
									return v2
								end
							end

							for v3, v4 in workspace:GetDescendants() do
								if v4:IsA("Model") and (v4:GetAttribute("UserId") == v27 and v4:GetAttribute("SeedName") ~= nil) then
									return v4
								end
							end

							return nil
						end
						_ = function() --[[ hasHarvestedFruitNow | Line: 877 | Upvalues: TutorialUtils (ref) ]]
							for v1, v2 in TutorialUtils.getTools() do
								if v2:GetAttribute("FruitName") then
									return true
								end
							end

							return false
						end
						v29 = nil

						while true do
							v30 = v28()

							if v30 then
								v29 = v30

								break
							end

							v31 = false

							for v63, v64 in TutorialUtils.getTools() do
								if v64:GetAttribute("FruitName") then
									v31 = true

									break
								end
							end

							if v31 then
								break
							end

							task.wait(0.2)
						end

						while v29 and v29:IsDescendantOf(workspace) do
							v32 = false

							for v65, v66 in TutorialUtils.getTools() do
								if v66:GetAttribute("FruitName") then
									v32 = true

									break
								end
							end

							if v32 then
								break
							end

							v33 = v29:GetAttribute("Age")
							v34 = v29:GetAttribute("MaxAge")

							if typeof(v33) == "number" and (typeof(v34) == "number" and v34 <= v33) or v29:FindFirstChild("HarvestPrompt", true) then
								break
							end

							task.wait(0.2)

							if v29 and not v29:IsDescendantOf(workspace) then
								v35 = v28()

								if v35 then
									v29 = v35
								else
									continue
								end
							end
						end

						if v29 and not v29:IsDescendantOf(workspace) then
							v36 = v28()

							if v36 then
								v29 = v36
							end
						end

						v37 = if v29 == nil then false else v29:IsDescendantOf(workspace)

						if v29 and v37 then
							v38 = false

							for v67, v68 in TutorialUtils.getTools() do
								if v68:GetAttribute("FruitName") then
									v38 = true

									break
								end
							end

							if v38 then
								v2("[Tutorial] Step 8: Navigate to Steven")

								if v12.Notifications then
									v2("[Tutorial] Notifying: Go sell your crop!")
									NotificationController:CreateNotification("Go sell your crop!", nil, 5)
								end

								v39 = navigateToSteven(v12)
								v40 = v1:WaitForChild("leaderstats"):WaitForChild("Sheckles")
								v41 = v40.Value
								v42 = v41 < v40.Value
								v43 = v40.Changed:Connect(function() --[[ Line: 995 | Upvalues: v40 (copy), v41 (copy), v42 (ref) ]]
									if not (v41 < v40.Value) then
										return
									end

									v42 = true
								end)
								v2("[Tutorial] Step 9: Highlight Sell Inventory option until a sale lands")
								v44 = function() --[[ isSaleDone | Line: 1003 | Upvalues: v42 (ref) ]]
									return v42
								end

								while not v42 do
									while true do
										v45 = PlayerGui:FindFirstChild("Billboard_UI")

										if v45 then
											v46 = v45:FindFirstChild("Objects")
											v47 = if v46 == nil then false elseif #v46:GetChildren() > 1 then true else false
										else
											v47 = false
										end

										if v47 or v42 then
											break
										end

										task.wait(0.1)
									end

									if v42 then
										break
									end

									waitForDialogueOptionAndHighlight("Sell Inventory!", nil, v44)
								end

								v43:Disconnect()
								v2("[Tutorial] Sale detected, completing tutorial")
								v39()
								Networking.Tutorial.Complete:Fire()

								return
							end

							if v12.Notifications then
								v2("[Tutorial] Notifying: Harvest your crop!")
								NotificationController:CreateNotification("Harvest your crop!", nil, 5)
							end

							v48 = function() --[[ getPlantTarget | Line: 950 | Upvalues: v29 (ref) ]]
								local v1 = v29.PrimaryPart or (v29:FindFirstChild("HarvestPart") or v29:FindFirstChildWhichIsA("BasePart"))

								if v1 and v1:IsA("BasePart") then
									return v1.CFrame
								end

								return v29:GetPivot()
							end
							v49 = TutorialUtils.createArrow(v1, v48())
							v50 = RunService.PreRender:Connect(function() --[[ Line: 962 | Upvalues: v29 (ref), v49 (copy), v48 (copy) ]]
								if v29:IsDescendantOf(workspace) then
									v49.move(v48())
								end
							end)

							while v29 and v29:IsDescendantOf(workspace) do
								v51 = false

								for v69, v70 in TutorialUtils.getTools() do
									if v70:GetAttribute("FruitName") then
										v51 = true

										break
									end
								end

								if v51 then
									break
								end

								task.wait(0.2)
							end

							v50:Disconnect()
							v49.destroy()
						end
					end

					v2("[Tutorial] Step 8: Navigate to Steven")

					if v12.Notifications then
						v2("[Tutorial] Notifying: Go sell your crop!")
						NotificationController:CreateNotification("Go sell your crop!", nil, 5)
					end

					v39 = navigateToSteven(v12)
					v40 = v1:WaitForChild("leaderstats"):WaitForChild("Sheckles")
					v41 = v40.Value
					v42 = v41 < v40.Value
					v43 = v40.Changed:Connect(function() --[[ Line: 995 | Upvalues: v40 (copy), v41 (copy), v42 (ref) ]]
						if not (v41 < v40.Value) then
							return
						end

						v42 = true
					end)
					v2("[Tutorial] Step 9: Highlight Sell Inventory option until a sale lands")
					v44 = function() --[[ isSaleDone | Line: 1003 | Upvalues: v42 (ref) ]]
						return v42
					end

					while not v42 do
						while true do
							v45 = PlayerGui:FindFirstChild("Billboard_UI")

							if v45 then
								v46 = v45:FindFirstChild("Objects")
								v47 = if v46 == nil then false elseif #v46:GetChildren() > 1 then true else false
							else
								v47 = false
							end

							if v47 or v42 then
								break
							end

							task.wait(0.1)
						end

						if v42 then
							break
						end

						waitForDialogueOptionAndHighlight("Sell Inventory!", nil, v44)
					end

					v43:Disconnect()
					v2("[Tutorial] Sale detected, completing tutorial")
					v39()
					Networking.Tutorial.Complete:Fire()

					return
				end

				local v71 = v56.ChildAdded:Connect(function() --[[ Line: 775 | Upvalues: v58 (ref) ]]
					v58 = true
				end)
				local v72 = v54.CFrame * CFrame.new(10, -5, -30)

				while not v58 do
					local v73

					if TutorialUtils.isInsidePlot(v53) then
						local Character2 = v1.Character
						local v74 = if Character2 then Character2:FindFirstChildWhichIsA("Tool") else nil

						if if v74 == nil then false else v74:GetAttribute("SeedTool") ~= nil then
							local v76 = createTapIcon(v72.Position)

							while not v58 and TutorialUtils.isInsidePlot(v53) do
								local Character3 = v1.Character
								local v77 = if Character3 then Character3:FindFirstChildWhichIsA("Tool") else nil

								if not (if v77 == nil then false else v77:GetAttribute("SeedTool") ~= nil) then
									break
								end

								task.wait(0.1)
							end

							v76:Destroy()

							local Character3 = v1.Character
							local v79 = if Character3 then Character3:FindFirstChildWhichIsA("Tool") else nil
							local v80 = if v79 == nil then false else v79:GetAttribute("SeedTool") ~= nil

							if v80 or not TutorialUtils.isInsidePlot(v53) then
								if v58 then
									break
								end

								v73 = TutorialUtils.createArrow(v1, CFrame.new(Position))

								while not (v58 or TutorialUtils.isInsidePlot(v53)) do
									task.wait(0.1)
								end

								v73.destroy()
							end

							continue
						end

						local v81 = TutorialUtils.pointToUI(function() --[[ Line: 784 | Upvalues: findSeedHotbarSlot (ref) ]]
							return findSeedHotbarSlot()
						end)

						while true do
							local Character3 = v1.Character
							local v82 = if Character3 then Character3:FindFirstChildWhichIsA("Tool") else nil
							local v83 = if v82 == nil then false else v82:GetAttribute("SeedTool") ~= nil

							if v83 or (v58 or not TutorialUtils.isInsidePlot(v53)) then
								break
							end

							task.wait(0.1)
						end

						v81()

						continue
					end

					if v58 then
						break
					end

					v73 = TutorialUtils.createArrow(v1, CFrame.new(Position))

					while not (v58 or TutorialUtils.isInsidePlot(v53)) do
						task.wait(0.1)
					end

					v73.destroy()
				end

				v71:Disconnect()
			end
		end

		if v9 <= 7 then
			v2("[Tutorial] Step 7: Wait for growth")

			if v12.Notifications then
				v2("[Tutorial] Notifying: Wait for your crop to grow...")
				NotificationController:CreateNotification("Wait for your crop to grow...", nil, 5)
			end

			while true do
				v25 = TutorialUtils.getPlayerPlot()

				if v25 then
					break
				end

				task.wait(0.5)
			end

			v26 = assert(v25:FindFirstChild("Plants"))
			v27 = v1.UserId
			v28 = function() --[[ findPlantModel | Line: 854 | Upvalues: v26 (copy), v27 (copy) ]]
				for v1, v2 in v26:GetChildren() do
					if v2:IsA("Model") then
						return v2
					end
				end

				for v3, v4 in workspace:GetDescendants() do
					if v4:IsA("Model") and (v4:GetAttribute("UserId") == v27 and v4:GetAttribute("SeedName") ~= nil) then
						return v4
					end
				end

				return nil
			end
			_ = function() --[[ hasHarvestedFruitNow | Line: 877 | Upvalues: TutorialUtils (ref) ]]
				for v1, v2 in TutorialUtils.getTools() do
					if v2:GetAttribute("FruitName") then
						return true
					end
				end

				return false
			end
			v29 = nil

			while true do
				v30 = v28()

				if v30 then
					v29 = v30

					break
				end

				v31 = false

				for v63, v64 in TutorialUtils.getTools() do
					if v64:GetAttribute("FruitName") then
						v31 = true

						break
					end
				end

				if v31 then
					break
				end

				task.wait(0.2)
			end

			while v29 and v29:IsDescendantOf(workspace) do
				v32 = false

				for v65, v66 in TutorialUtils.getTools() do
					if v66:GetAttribute("FruitName") then
						v32 = true

						break
					end
				end

				if v32 then
					break
				end

				v33 = v29:GetAttribute("Age")
				v34 = v29:GetAttribute("MaxAge")

				if typeof(v33) == "number" and (typeof(v34) == "number" and v34 <= v33) or v29:FindFirstChild("HarvestPrompt", true) then
					break
				end

				task.wait(0.2)

				if v29 and not v29:IsDescendantOf(workspace) then
					v35 = v28()

					if v35 then
						v29 = v35
					else
						continue
					end
				end
			end

			if v29 and not v29:IsDescendantOf(workspace) then
				v36 = v28()

				if v36 then
					v29 = v36
				end
			end

			v37 = if v29 == nil then false else v29:IsDescendantOf(workspace)

			if v29 and v37 then
				v38 = false

				for v67, v68 in TutorialUtils.getTools() do
					if v68:GetAttribute("FruitName") then
						v38 = true

						break
					end
				end

				if v38 then
					v2("[Tutorial] Step 8: Navigate to Steven")

					if v12.Notifications then
						v2("[Tutorial] Notifying: Go sell your crop!")
						NotificationController:CreateNotification("Go sell your crop!", nil, 5)
					end

					v39 = navigateToSteven(v12)
					v40 = v1:WaitForChild("leaderstats"):WaitForChild("Sheckles")
					v41 = v40.Value
					v42 = v41 < v40.Value
					v43 = v40.Changed:Connect(function() --[[ Line: 995 | Upvalues: v40 (copy), v41 (copy), v42 (ref) ]]
						if not (v41 < v40.Value) then
							return
						end

						v42 = true
					end)
					v2("[Tutorial] Step 9: Highlight Sell Inventory option until a sale lands")
					v44 = function() --[[ isSaleDone | Line: 1003 | Upvalues: v42 (ref) ]]
						return v42
					end

					while not v42 do
						while true do
							v45 = PlayerGui:FindFirstChild("Billboard_UI")

							if v45 then
								v46 = v45:FindFirstChild("Objects")
								v47 = if v46 == nil then false elseif #v46:GetChildren() > 1 then true else false
							else
								v47 = false
							end

							if v47 or v42 then
								break
							end

							task.wait(0.1)
						end

						if v42 then
							break
						end

						waitForDialogueOptionAndHighlight("Sell Inventory!", nil, v44)
					end

					v43:Disconnect()
					v2("[Tutorial] Sale detected, completing tutorial")
					v39()
					Networking.Tutorial.Complete:Fire()

					return
				end

				if v12.Notifications then
					v2("[Tutorial] Notifying: Harvest your crop!")
					NotificationController:CreateNotification("Harvest your crop!", nil, 5)
				end

				v48 = function() --[[ getPlantTarget | Line: 950 | Upvalues: v29 (ref) ]]
					local v1 = v29.PrimaryPart or (v29:FindFirstChild("HarvestPart") or v29:FindFirstChildWhichIsA("BasePart"))

					if v1 and v1:IsA("BasePart") then
						return v1.CFrame
					end

					return v29:GetPivot()
				end
				v49 = TutorialUtils.createArrow(v1, v48())
				v50 = RunService.PreRender:Connect(function() --[[ Line: 962 | Upvalues: v29 (ref), v49 (copy), v48 (copy) ]]
					if v29:IsDescendantOf(workspace) then
						v49.move(v48())
					end
				end)

				while v29 and v29:IsDescendantOf(workspace) do
					v51 = false

					for v69, v70 in TutorialUtils.getTools() do
						if v70:GetAttribute("FruitName") then
							v51 = true

							break
						end
					end

					if v51 then
						break
					end

					task.wait(0.2)
				end

				v50:Disconnect()
				v49.destroy()
			end
		end

		v2("[Tutorial] Step 8: Navigate to Steven")

		if v12.Notifications then
			v2("[Tutorial] Notifying: Go sell your crop!")
			NotificationController:CreateNotification("Go sell your crop!", nil, 5)
		end

		v39 = navigateToSteven(v12)
		v40 = v1:WaitForChild("leaderstats"):WaitForChild("Sheckles")
		v41 = v40.Value
		v42 = v41 < v40.Value
		v43 = v40.Changed:Connect(function() --[[ Line: 995 | Upvalues: v40 (copy), v41 (copy), v42 (ref) ]]
			if not (v41 < v40.Value) then
				return
			end

			v42 = true
		end)
		v2("[Tutorial] Step 9: Highlight Sell Inventory option until a sale lands")
		v44 = function() --[[ isSaleDone | Line: 1003 | Upvalues: v42 (ref) ]]
			return v42
		end

		while not v42 do
			while true do
				v45 = PlayerGui:FindFirstChild("Billboard_UI")

				if v45 then
					v46 = v45:FindFirstChild("Objects")
					v47 = if v46 == nil then false elseif #v46:GetChildren() > 1 then true else false
				else
					v47 = false
				end

				if v47 or v42 then
					break
				end

				task.wait(0.1)
			end

			if v42 then
				break
			end

			waitForDialogueOptionAndHighlight("Sell Inventory!", nil, v44)
		end

		v43:Disconnect()
		v2("[Tutorial] Sale detected, completing tutorial")
		v39()
		Networking.Tutorial.Complete:Fire()
	end, debug.traceback)

	workspace:SetAttribute("InTutorial", nil)

	if not ok then
		warn((("[TutorialRunner] Tutorial flow errored: %*"):format(result)))
	end
end