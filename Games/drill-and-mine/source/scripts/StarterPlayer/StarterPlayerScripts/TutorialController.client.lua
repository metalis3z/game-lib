--[[
	TutorialController: first-join tutorial (runs once per account; the
	server gate is TutorialService + the profile's TutorialComplete field).

	While active, the top level bar is "emptied": LevelBar + LevelSubBg (and
	the X2 strength panel) are hidden and a banner styled exactly like the
	level bar takes the slot, with ONE centered text that fills it. Steps:
	  1  "Click 4 Times"               - count 4 world clicks
	  2  "Start Mining"                - beam -> Zone 1's first (top) DoublePart;
	                                     advances when the player gets underground
	  3  "Pickup Loot"                 - beam -> nearest live loot item; on pickup
	                                     the player teleports STRAIGHT up to the
	                                     surface (loot auto-claims there)
	  4  "Sell your Loot!"             - beam -> the SellShop Scientist rig;
	                                     advances on the Sold event
	  5  "Upgrade Your Drill!"         - beam -> the DrillShop Scientist rig;
	                                     advances once a 2nd drill is owned
	Then: green "Tutorial Completed!" toast, bar restored, server marks done.

	The beam is the Build a Ring Defense tutorial arrow (template cloned from
	ReplicatedStorage.TutorialArrow): Attachment0 on the TARGET, Attachment1
	in the torso, TextureSpeed negated so the chevrons face AND flow
	player -> destination.

	The banner is its own frame directly under the GUI ScreenGui: FrameAnimator
	and SurfaceModeController own LevelReadout/TopButtons (slide + force-show
	them), so the banner must live OUTSIDE both systems. Underground the
	Surface button drops into the top slot -- the banner shifts down below it,
	mirroring the reference layout.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer

local CLICKS_REQUIRED = 4
local ZONE1_FOLDER_NAME = "DestroyPart Zone1"

local STEP_TEXT = {
	[1] = "Click 4 Times \u{1F4AA}",
	[2] = "Start Mining \u{26CF}\u{FE0F}",
	[3] = "Pickup Loot \u{1F4B0}",
	[4] = "Sell your Loot! \u{1F4B0}",
	[5] = "Upgrade Your Drill! \u{2699}\u{FE0F}",
}
local MAX_STEP = 6 -- 6 = completed

--===========================================================================
-- Gate: ask the server whether this account still needs the tutorial.
--===========================================================================
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local tutorialRemotes = Remotes:WaitForChild("Tutorial", 60)
if not tutorialRemotes then return end
local GetTutorialStatus = tutorialRemotes:WaitForChild("GetTutorialStatus", 30)
local CompleteTutorial = tutorialRemotes:WaitForChild("CompleteTutorial", 30)
if not (GetTutorialStatus and CompleteTutorial) then return end

local ok, needsTutorial = pcall(function()
	return GetTutorialStatus:InvokeServer()
end)
if not ok or needsTutorial ~= true then return end

--===========================================================================
-- UI + world references
--===========================================================================
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI", 30)
if not gui then return end
local hud = gui:WaitForChild("HUD", 30)
if not hud then return end
local readout = hud:WaitForChild("LevelReadout", 30)
if not readout then return end
local levelBar = readout:WaitForChild("LevelBar", 10)
local levelSubBg = readout:WaitForChild("LevelSubBg", 10)
local topButtons = hud:FindFirstChild("TopButtons")
local x2Panel = hud:FindFirstChild("X2DrillPanel")

local lootRemotes = Remotes:WaitForChild("RarityLoot", 30)
local PickupEvent = lootRemotes and lootRemotes:WaitForChild("Pickup", 10)
local SoldEvent = lootRemotes and lootRemotes:WaitForChild("Sold", 10)
local drillRemotes = Remotes:WaitForChild("DrillShopService", 30)
local DrillUpdateEvent = drillRemotes and drillRemotes:WaitForChild("DrillUpdate", 10)
local RequestDrillDataFunc = drillRemotes and drillRemotes:WaitForChild("RequestDrillData", 10)

local surfacePart = workspace:WaitForChild("Assets"):WaitForChild("Teleports"):WaitForChild("Surface")
local arrowTemplate = ReplicatedStorage:WaitForChild("TutorialArrow", 30)

local NotificationsController
pcall(function()
	NotificationsController = require(ReplicatedStorage.Source.Controllers.NotificationsController)
end)

--===========================================================================
-- Empty the top bar: hide the level bar + strength sub-bar + x2 panel.
-- Children only -- SurfaceModeController/FrameAnimator slide & force-show
-- the LevelReadout CONTAINER, so the container must stay untouched.
--===========================================================================
local hiddenSnapshot = {}
local function hideForTutorial()
	for _, inst in ipairs({ levelBar, levelSubBg, x2Panel }) do
		if inst then
			hiddenSnapshot[inst] = inst.Visible
			inst.Visible = false
		end
	end
end
local function restoreAfterTutorial()
	for inst, wasVisible in pairs(hiddenSnapshot) do
		if inst.Parent then
			inst.Visible = wasVisible
		end
	end
	table.clear(hiddenSnapshot)
end

--===========================================================================
-- Banner: same look as the LevelBar (dark 0.3-transparent slab, thick dark
-- stroke, 11:1 aspect) in the LevelReadout slot, one full-size green text.
--===========================================================================
local FONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy, Enum.FontStyle.Normal)
local TEXT_GREEN = Color3.fromRGB(110, 255, 60)

local surfaceBannerPos = UDim2.new(0.5, 0, readout.Position.Y.Scale, 0)

local banner = Instance.new("Frame")
banner.Name = "TutorialBanner"
banner:SetAttribute("AT_Ignore", true) -- keep AnimatedTextController away
banner.AnchorPoint = Vector2.new(0.5, 0)
banner.Position = surfaceBannerPos
banner.Size = UDim2.new(readout.Size.X.Scale, 0, readout.Size.Y.Scale * (levelBar and levelBar.Size.Y.Scale or 0.62), 0)
banner.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
banner.BackgroundTransparency = 0.3
banner.BorderSizePixel = 0
banner.ZIndex = 10

local bannerAspect = Instance.new("UIAspectRatioConstraint")
bannerAspect.AspectRatio = 11
bannerAspect.Parent = banner

local bannerStroke = Instance.new("UIStroke")
bannerStroke.Color = Color3.fromRGB(35, 35, 35)
bannerStroke.Thickness = 4
bannerStroke.Parent = banner

local bannerScale = Instance.new("UIScale")
bannerScale.Scale = 0
bannerScale.Parent = banner

local stepLabel = Instance.new("TextLabel")
stepLabel.Name = "StepText"
stepLabel.BackgroundTransparency = 1
stepLabel.AnchorPoint = Vector2.new(0.5, 0.5)
stepLabel.Position = UDim2.fromScale(0.5, 0.5)
stepLabel.Size = UDim2.fromScale(0.96, 0.82)
stepLabel.FontFace = FONT
stepLabel.Text = ""
stepLabel.TextScaled = true
stepLabel.TextColor3 = TEXT_GREEN
stepLabel.ZIndex = 11
stepLabel.Parent = banner

local labelStroke = Instance.new("UIStroke")
labelStroke.Color = Color3.fromRGB(5, 20, 5)
labelStroke.Thickness = 3
labelStroke.Parent = stepLabel

local labelScale = Instance.new("UIScale")
labelScale.Scale = 0
labelScale.Parent = stepLabel

banner.Parent = gui

-- Underground the Surface button owns the top slot (SurfaceModeController);
-- shift the banner just below it, back up when surfaced.
local function undergroundBannerPos()
	local shown = topButtons and topButtons:GetAttribute("SurfaceShownPos")
	local topY = (typeof(shown) == "UDim2" and shown.Y.Scale) or 0.065
	local sizeY = topButtons and topButtons.Size.Y.Scale or 0.12
	-- x1.25 covers SurfaceModeController's 1.2 UIScale on the button strip
	return UDim2.new(0.5, 0, topY + sizeY * 1.25 + 0.015, 0)
end
local function updateBannerPos()
	local target = player:GetAttribute("Underground") and undergroundBannerPos() or surfaceBannerPos
	TweenService:Create(banner, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = target }):Play()
end
player:GetAttributeChangedSignal("Underground"):Connect(updateBannerPos)

--===========================================================================
-- Step text transitions: whole-label collapse -> swap -> Back/Out pop,
-- the same pattern as the Ring Defense tutorial text.
--===========================================================================
local textToken
local function transitionText(newText)
	local token = {}
	textToken = token
	local function popIn()
		if textToken ~= token then return end
		stepLabel.Text = newText
		labelScale.Scale = 0
		TweenService:Create(labelScale, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	end
	if labelScale.Scale > 0.01 then
		TweenService:Create(labelScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 0 }):Play()
		task.delay(0.2, popIn)
	else
		popIn()
	end
end

--===========================================================================
-- World arrow (Ring Defense recipe): clone the template Beam between a
-- torso attachment and a target attachment; swap Att0/Att1 + negative
-- TextureSpeed so forward-facing chevrons flow player -> destination.
--===========================================================================
local activeBeam, activeSrcAtt, activeTgtAtt

local function getTorso()
	local char = player.Character
	if not char then return nil end
	return char:FindFirstChild("UpperTorso")
		or char:FindFirstChild("Torso")
		or char:FindFirstChild("HumanoidRootPart")
end

local function clearArrow()
	if activeBeam then activeBeam:Destroy() end
	if activeSrcAtt then activeSrcAtt:Destroy() end
	if activeTgtAtt then activeTgtAtt:Destroy() end
	activeBeam, activeSrcAtt, activeTgtAtt = nil, nil, nil
end

local function setArrow(targetPart)
	clearArrow()
	if not targetPart then return end
	local torso = getTorso()
	if not torso then return end
	local templateBeam = arrowTemplate and arrowTemplate:FindFirstChild("Beam")
	if not templateBeam then return end

	local srcAtt = Instance.new("Attachment")
	srcAtt.Name = "TutorialArrowSrc"
	srcAtt.Parent = torso

	local tgtAtt = Instance.new("Attachment")
	tgtAtt.Name = "TutorialArrowTgt"
	tgtAtt.Parent = targetPart

	local beam = templateBeam:Clone()
	beam.Attachment0 = tgtAtt
	beam.Attachment1 = srcAtt
	beam.TextureSpeed = -math.abs(templateBeam.TextureSpeed)
	beam.Parent = torso

	activeSrcAtt = srcAtt
	activeTgtAtt = tgtAtt
	activeBeam = beam
end

player.CharacterAdded:Connect(function()
	-- the old torso took the beam + source attachment with it; drop the
	-- orphaned target attachment and let the step watcher rebuild
	if activeTgtAtt then activeTgtAtt:Destroy() end
	activeBeam, activeSrcAtt, activeTgtAtt = nil, nil, nil
end)

--===========================================================================
-- Arrow targets per step
--===========================================================================
-- Zone 1's first layer: lowest LayerIndex still standing (falls back to the
-- highest slab if the attribute hasn't been stamped yet). Re-resolved every
-- watcher tick, so it tracks broken layers AND the zone reset re-clones.
local function firstZoneLayerPart()
	local folder = workspace:FindFirstChild(ZONE1_FOLDER_NAME)
	if not folder then return nil end
	local best, bestIdx, bestY
	for _, p in ipairs(folder:GetChildren()) do
		if p.Name == "DoublePart" and p:IsA("BasePart") then
			local idx = tonumber(p:GetAttribute("LayerIndex")) or math.huge
			if not best or idx < bestIdx or (idx == bestIdx and p.Position.Y > bestY) then
				best, bestIdx, bestY = p, idx, p.Position.Y
			end
		end
	end
	return best
end

local function nearestLootPart()
	local live = workspace:FindFirstChild("RarityLootLive")
	local char = player.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not live or not hrp then return nil end
	local best, bestDist
	for _, m in ipairs(live:GetChildren()) do
		if m:GetAttribute("RarityLootItem") then
			local p
			if m:IsA("Model") then
				p = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true)
			elseif m:IsA("BasePart") then
				p = m
			end
			if p then
				local d = (p.Position - hrp.Position).Magnitude
				if not best or d < bestDist then
					best, bestDist = p, d
				end
			end
		end
	end
	return best
end

local function scientistPart(shopName)
	local assets = workspace:FindFirstChild("Assets")
	local map = assets and assets:FindFirstChild("Map")
	local shop = map and map:FindFirstChild(shopName)
	local rig = shop and shop:FindFirstChild("Scientist")
	if not rig then return nil end
	return rig:FindFirstChild("Torso")
		or rig:FindFirstChild("HumanoidRootPart")
		or rig:FindFirstChildWhichIsA("BasePart", true)
end

local function resolveArrowTarget(step)
	if step == 2 then
		return firstZoneLayerPart()
	elseif step == 3 then
		return nearestLootPart()
	elseif step == 4 then
		return scientistPart("SellShop")
	elseif step == 5 then
		return scientistPart("DrillShop")
	end
	return nil
end

--===========================================================================
-- Step machine
--===========================================================================
local currentStep = 0
local stepConnections = {}

local function clearStepConnections()
	for _, c in ipairs(stepConnections) do
		pcall(function() c:Disconnect() end)
	end
	table.clear(stepConnections)
end

local startStep -- forward decl

local function advanceFrom(step)
	if currentStep ~= step then return end
	startStep(step + 1)
end

local function teleportUp()
	local char = player.Character
	if char then
		-- same recipe as the Surface button (SurfaceModeController)
		char:PivotTo(CFrame.new(surfacePart.Position + Vector3.new(0, 4, 0)))
	end
end

local function ownedDrillCount(payload)
	if type(payload) ~= "table" or type(payload.OwnedDrills) ~= "table" then return 0 end
	local n = 0
	for _ in pairs(payload.OwnedDrills) do n += 1 end
	return n
end

local stepHandlers = {}

function stepHandlers.step1()
	-- mirror StrengthClickClient's click filter so only clicks that actually
	-- grant Strength count toward the 4
	local clicks = 0
	local conn = UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		if player:GetAttribute("Underground") then return end
		if player:GetAttribute("OnTrainingPad") then return end
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			clicks += 1
			if clicks >= CLICKS_REQUIRED then
				advanceFrom(1)
			end
		end
	end)
	table.insert(stepConnections, conn)
end

function stepHandlers.step2()
	-- "in the first zone" = underground (below the TPBack slab)
	if player:GetAttribute("Underground") then
		advanceFrom(2)
		return
	end
	local conn = player:GetAttributeChangedSignal("Underground"):Connect(function()
		if player:GetAttribute("Underground") then
			advanceFrom(2)
		end
	end)
	table.insert(stepConnections, conn)
end

function stepHandlers.step3()
	local fired = false
	local function onPickedUp()
		if fired or currentStep ~= 3 then return end
		fired = true
		teleportUp() -- straight up to the surface; the loot auto-claims there
		advanceFrom(3)
	end
	if PickupEvent then
		local conn = PickupEvent.OnClientEvent:Connect(function(who)
			if who == player then onPickedUp() end
		end)
		table.insert(stepConnections, conn)
	end
	-- fallback gate: the server bumps LootCarried on every pickup
	local attrConn = player:GetAttributeChangedSignal("LootCarried"):Connect(function()
		if (tonumber(player:GetAttribute("LootCarried")) or 0) > 0 then onPickedUp() end
	end)
	table.insert(stepConnections, attrConn)
	if (tonumber(player:GetAttribute("LootCarried")) or 0) > 0 then onPickedUp() end
end

function stepHandlers.step4()
	if not SoldEvent then advanceFrom(4) return end
	local conn = SoldEvent.OnClientEvent:Connect(function()
		advanceFrom(4)
	end)
	table.insert(stepConnections, conn)
end

function stepHandlers.step5()
	if DrillUpdateEvent then
		local conn = DrillUpdateEvent.OnClientEvent:Connect(function(payload)
			if ownedDrillCount(payload) >= 2 then
				advanceFrom(5)
			end
		end)
		table.insert(stepConnections, conn)
	end
	-- already own a 2nd drill (bought ahead of the step)? complete right away
	task.spawn(function()
		if not RequestDrillDataFunc then return end
		local invoked, payload = pcall(function()
			return RequestDrillDataFunc:InvokeServer()
		end)
		if invoked and currentStep == 5 and ownedDrillCount(payload) >= 2 then
			advanceFrom(5)
		end
	end)
end

local function finishTutorial()
	clearStepConnections()
	clearArrow()
	restoreAfterTutorial()
	CompleteTutorial:FireServer()
	if NotificationsController then
		NotificationsController.Send("Green", "Tutorial Completed!", 3)
	end
	-- collapse the banner out, then drop it entirely
	TweenService:Create(bannerScale, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 0 }):Play()
	task.delay(0.3, function()
		banner:Destroy()
	end)
end

startStep = function(step)
	clearStepConnections()
	clearArrow()
	currentStep = step

	if step >= MAX_STEP then
		finishTutorial()
		return
	end

	transitionText(STEP_TEXT[step] or "")

	-- Arrow watcher: retries while the target/torso streams in, swaps when
	-- the target changes (nearest loot, broken layers) and rebuilds after a
	-- respawn (CharacterAdded nils activeBeam).
	local watchedStep = step
	task.spawn(function()
		local lastTarget
		while currentStep == watchedStep do
			local target = resolveArrowTarget(watchedStep)
			if target and (target ~= lastTarget or not activeBeam) then
				setArrow(target)
				if activeBeam then lastTarget = target end
			elseif not target and activeBeam then
				clearArrow()
				lastTarget = nil
			end
			task.wait(0.4)
		end
	end)

	local handler = stepHandlers["step" .. step]
	if handler then handler() end
end

--===========================================================================
-- Boot
--===========================================================================
hideForTutorial()
updateBannerPos()
TweenService:Create(bannerScale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
startStep(1)
