--[[
	DrillSystemServer
	Stand on the top layer of a "DestroyPart <Rarity>" stack to start drilling
	(one workspace folder per rarity zone; each folder's "Luck" attribute is
	the luck multiplier shown on every layer of that stack):
	the player's owned drill rides on their back as an accessory (BackDrill,
	welded to the torso) and swaps to the hand while drilling. The drill is
	gear-like: unequipping it via the hotbar STOPS mining entirely (and
	blocks auto-start while stowed); re-equipping starts it again:
	the drill welds to the player's hand, damage ticks every 0.3s, the
	layer's on-surface health bar drains (green -> orange -> red), a crack
	image fades in, and at 0 HP the layer bursts into client-side debris
	(see DrillClient "explode"). Layers are numbered 1..N from the top;
	deeper layers have more HP.

	EVERYTHING VISUAL IS PER-PLAYER AND CLIENT-SIDE: each player digs
	their own copy of every stack (their own layer index + HP held
	server-side in stack.progress), the server never destroys or repaints
	layer parts, and only the drilling player receives hit/explode
	events. Other players see the stack intact and solid and must drill
	it themselves -- nobody can ride another player's hole down.
	Surfacing resets only YOUR progression ("resetLayers").
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

-- Held-state mutual exclusion with the brainrot/lucky carry system (one
-- pair of hands): holding the drill unequips the carried item and vice
-- versa. Required in the BACKGROUND: these pull in GameConfig, which
-- blocks at module level when content folders go missing -- that exact
-- chain once kept DrillEvent from ever being created and froze every
-- client. Until they resolve, mutual exclusion simply no-ops.
local PlayerDataService, InventoryService, PurchaseService
task.spawn(function()
	PlayerDataService = require(ServerScriptService.Source.Services.PlayerDataService)
	InventoryService = require(ServerScriptService.Source.Services.InventoryService)
	PurchaseService = require(ServerScriptService.Source.Services.PurchaseService)
end)

-- Training-pad grants go through StrengthClickServer's bindable so XP and
-- level-ups behave exactly like clicks. Resolved in the background: pads
-- simply don't pay out until both scripts are up.
local grantStrengthEvent
task.spawn(function()
	local clickServer = ServerScriptService:WaitForChild("StrengthClickServer", 60)
	grantStrengthEvent = clickServer and clickServer:WaitForChild("GrantStrength", 60)
end)

local DAMAGE_PER_TICK = 1        -- minimum damage per drilling player per tick
-- Every tick is a full HIT: (Strength + drill Power) times every strength
-- boost (trail / rebirth / x2 Strength pass) -- exactly the number the
-- player reads as "my strength". The old *TICK_SECONDS per-second split
-- made a 558-strength player hit for ~167, which read as broken.
local TICK_SECONDS = 0.3         -- one damage tick every 0.3s
local BASE_HP = 10               -- layer 1 HP; layer N = 10/15/20/... (unless MaxHP attribute set)
local HP_PER_LAYER = 5           -- extra HP per layer of depth
local PRESENCE_INTERVAL = 0.25
local GREEN = Color3.new(0.745098, 1, 0.0431373)
local ORANGE = Color3.fromRGB(255, 140, 0)
local RED = Color3.fromRGB(255, 45, 45)
local ORANGE_THRESHOLD = 0.5
local RED_THRESHOLD = 0.25
-- per-hit tick sound is played CLIENT-side by DrillClient on the "hit" event:
-- a server-side Play() on an already-Playing one-shot Sound doesn't restart on
-- clients (no replicated property delta), so the tick audio died after the
-- first few beats of a session.
-- RightHand -> drill root, computed by applying the drill animation's keyframe
-- pose to Workspace.Rig, so in-game the drill sits exactly like the rig holds it.
-- Do NOT re-capture from the rig live: it stands in its default (non-anim) pose.
local GRIP_OFFSET = CFrame.new(-1.2092437744140625, -0.8143310546875, -0.03234410285949707,
	0.9925296902656555, 0.07837126404047012, 0.0934644341468811,
	0.12197352200746536, -0.6380512714385986, -0.7602702379226685,
	0.00005169780706637539, 0.7659943699836731, -0.6428455114364624)

-- The drill anim's RightShoulder keyframe transform (the same value
-- DrillClient pins while the hold pose is active); Root / Waist / RightElbow
-- / RightWrist are identity in that pose. Used to predict where THIS
-- character's posed right hand sits in HumanoidRootPart space: GRIP_OFFSET
-- alone was captured on the default rig, so scaled R15 bodies (wider /
-- slimmer / taller avatars) carried the drill visibly off to the side
-- instead of on the body midline.
local POSE_JOINTS = {
	Root = CFrame.identity,
	Waist = CFrame.identity,
	RightShoulder = CFrame.new(0, -3.8147e-06, 0, 0.992546, 0.121869, -3.72529e-09,
		-0.0783393, 0.638022, -0.766022, -0.0933546, 0.760312, 0.642814),
	RightElbow = CFrame.identity,
	RightWrist = CFrame.identity,
}
local ARM_CHAIN = { "Root", "Waist", "RightShoulder", "RightElbow", "RightWrist" }

-- Part1's CFrame relative to Part0 under a given pose transform; supports
-- both classic Motor6D rigs and newer AnimationConstraint rigs.
local function jointPosedOffset(joint, pose)
	if joint:IsA("Motor6D") then
		return joint.C0 * pose * joint.C1:Inverse()
	end
	local a0, a1 = joint.Attachment0, joint.Attachment1
	if not (a0 and a1) then return nil end
	return a0.CFrame * pose * a1.CFrame:Inverse()
end

-- Walk THIS character's HRP -> RightHand joint chain under the hold pose:
-- returns the posed hand CFrame in HRP space plus the drill-root target
-- recentered onto the body midline (X = 0). The character's own joint
-- offsets carry its body scaling, so the result adapts to any avatar
-- proportions. nil when a joint is missing (R6 / still assembling) -- the
-- caller falls back to the plain default-rig hand grip.
local function computeCenteredGrip(character)
	local joints = {}
	for _, d in character:GetDescendants() do
		if (d:IsA("Motor6D") or d:IsA("AnimationConstraint")) and POSE_JOINTS[d.Name] then
			joints[d.Name] = d
		end
	end
	local handInHRP = CFrame.identity
	for _, name in ARM_CHAIN do
		local joint = joints[name]
		if not joint then return nil end
		local rel = jointPosedOffset(joint, POSE_JOINTS[name])
		if not rel then return nil end
		handInHRP = handInHRP * rel
	end
	local drillInHRP = handInHRP * GRIP_OFFSET
	local p = drillInHRP.Position
	return handInHRP, CFrame.new(0, p.Y, p.Z) * drillInHRP.Rotation
end

-- Created FIRST, before any workspace waits below: clients WaitForChild
-- this remote, and the template wait loop once stalled forever (drill
-- models moved into a folder) -- which starved every client of the event
-- and froze the main client script.
local drillEvent = ReplicatedStorage:FindFirstChild("DrillEvent")
if not drillEvent then
	drillEvent = Instance.new("RemoteEvent")
	drillEvent.Name = "DrillEvent"
	drillEvent.Parent = ReplicatedStorage
end

-- Training ore pads: "gain" popups + "denied" messages (see TrainingPadClient
-- and the pad listener in StrengthClickClient). Created just as early for the
-- same reason as DrillEvent.
local trainingPadRemote = ReplicatedStorage:FindFirstChild("TrainingPadRemote")
if not trainingPadRemote then
	trainingPadRemote = Instance.new("RemoteEvent")
	trainingPadRemote.Name = "TrainingPadRemote"
	trainingPadRemote.Parent = ReplicatedStorage
end

-- All "DestroyPart*" folders (DestroyPart Common, DestroyPart Uncommon, ...).
-- Each folder's "Luck" attribute is shown as "x<Luck> Luck" on every layer.
local function getDestroyFolders()
	local folders = {}
	for _, child in workspace:GetChildren() do
		if child:IsA("Folder") and child.Name:sub(1, 11) == "DestroyPart" then
			table.insert(folders, child)
		end
	end
	return folders
end
local destroyFolders = getDestroyFolders()
while #destroyFolders == 0 do
	task.wait(0.5)
	destroyFolders = getDestroyFolders()
end
-- Drill catalog: ReplicatedStorage.Drills holds "Drill<N> - <Name>" models
-- (Drill1 - Wood, Drill2 - Blue, ...). The old exact "Drill1" name is gone,
-- so WaitForChild on it would hang the whole system forever.
local function getDefaultDrillTemplate()
	-- catalog lives in ReplicatedStorage.Drills (moved out of workspace
	-- 2026-07-16); workspace fallbacks kept so a Team Create reorganization
	-- can't kill the drill system
	local drills = ReplicatedStorage:FindFirstChild("Drills") or workspace:FindFirstChild("Drills")
	local direct = drills and drills:FindFirstChild("Drill1 - Wood")
	return direct
		or workspace:FindFirstChild("Drill1 - Wood", true)
		or workspace:FindFirstChild("Drill1", true)
end
local drillTemplate = getDefaultDrillTemplate()
while not drillTemplate do
	task.wait(0.5)
	drillTemplate = getDefaultDrillTemplate()
end

-- The drill this player has equipped. DrillShopService mirrors the
-- profile's SelectedDrill into a player attribute (model name in
-- ReplicatedStorage.Drills); until the profile loads -- or if the model was
-- renamed/removed -- fall back to the starter Wood drill.
local function getPlayerDrillTemplate(player)
	local selected = player:GetAttribute("SelectedDrill")
	if type(selected) == "string" and selected ~= "" then
		local drills = ReplicatedStorage:FindFirstChild("Drills") or workspace:FindFirstChild("Drills")
		local model = (drills and drills:FindFirstChild(selected))
			or workspace:FindFirstChild(selected, true)
		if model and model:IsA("Model") then
			return model
		end
	end
	return drillTemplate
end

-- ===== Drill attachment =====

local function getDrillRoot(model)
	local best, bestVol
	for _, p in model:GetDescendants() do
		if p:IsA("BasePart") then
			local v = p.Size.X * p.Size.Y * p.Size.Z
			if not bestVol or v > bestVol then
				best, bestVol = p, v
			end
		end
	end
	return best
end

-- Shared clone builder for the hand drill and the back accessory:
-- strip broken template joints, weld every part to the root with rigid
-- classic Welds (WeldConstraints intermittently failed to latch on these
-- tiny massless parts, silently dropping pieces), welds created BEFORE
-- unanchoring so nothing can fall even for a single physics step.
local function buildDrillClone(template)
	local clone = template:Clone()
	local root = getDrillRoot(clone)
	for _, d in clone:GetDescendants() do
		if d:IsA("JointInstance") or d:IsA("WeldConstraint") then
			d:Destroy() -- template welds are broken (nil Part1)
		end
	end
	for _, p in clone:GetDescendants() do
		if p:IsA("BasePart") then
			p.CanCollide = false
			p.CanQuery = false
			p.CanTouch = false
			p.Massless = true
			if p ~= root then
				local w = Instance.new("Weld")
				w.Part0 = root
				w.Part1 = p
				w.C0 = root.CFrame:ToObjectSpace(p.CFrame)
				w.Parent = root
			end
		end
	end
	for _, p in clone:GetDescendants() do
		if p:IsA("BasePart") then
			p.Anchored = false
		end
	end
	return clone, root
end

-- Every catalog drill is authored with its root part at this orientation --
-- EXCEPT Drill25 Crystal (root yawed 45) and Drill28 Plasma Core (fully
-- tilted cube root). The hand grip and the back weld position the ROOT, so
-- an off-family root tilted the whole model diagonally in hand/on the back.
-- The delta re-expresses this drill's root against the standard catalog
-- orientation so every model hangs exactly like the family does.
local ROOT_REF_ROTATION = CFrame.fromOrientation(0, math.rad(90), math.rad(180))
local function rootOrientationDelta(root)
	return ROOT_REF_ROTATION:Inverse() * (root.CFrame - root.CFrame.Position)
end

local function attachDrill(player, character)
	local hand = character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm")
	if not hand then return end
	if character:FindFirstChild("EquippedDrill") then return end

	local clone, root = buildDrillClone(getPlayerDrillTemplate(player))
	clone.Name = "EquippedDrill"
	local motor = Instance.new("Motor6D")
	motor.Name = "DrillGrip"
	motor.Part0 = hand
	motor.Part1 = root
	-- center the drill on the body midline for this character's proportions
	-- (still riding the hand so the walk bob carries it for other players):
	-- hand * C0 = HRP * centered under the hold pose
	local handInHRP, centered = computeCenteredGrip(character)
	if handInHRP and centered then
		motor.C0 = handInHRP:Inverse() * centered
	else
		motor.C0 = GRIP_OFFSET
	end
	-- root.CFrame still holds the template-world value here (nothing has
	-- moved the clone yet), which is exactly what the delta needs
	motor.C0 = motor.C0 * rootOrientationDelta(root)
	motor.Parent = hand
	-- the drilling loop sound is client-owned (see DrillClient): a server-side
	-- Play() could die on the client and never come back because the server's
	-- own IsPlaying stayed true -- silence for the rest of the session
	clone.Parent = character
end

local function removeDrill(character)
	local drill = character and character:FindFirstChild("EquippedDrill")
	if drill then drill:Destroy() end
	local hand = character and character:FindFirstChild("RightHand")
	local motor = hand and hand:FindFirstChild("DrillGrip")
	if motor then motor:Destroy() end
end

-- ===== Back accessory =====
-- The owned drill rides on the player's back while not drilling: flipped
-- 180 (bit down) with a 20-degree side tilt, body up between the
-- shoulders, tip across the lower back -- per the user's spec, verified
-- visually on Workspace.Rig. Root frame in torso space. Swapped out for
-- the hand drill during sessions; the smooth back->hand equip animation
-- will replace the swap later.
local BACK_OFFSET = CFrame.new(0, 0.5, 1.1) * CFrame.Angles(0, 0, math.rad(200))

local function removeBackDrill(character)
	local back = character and character:FindFirstChild("BackDrill")
	if back then back:Destroy() end
end

local function attachBackDrill(player, character)
	if not character or not character.Parent then return end
	if character:FindFirstChild("BackDrill") then return end
	if character:FindFirstChild("EquippedDrill") then return end -- drilling: hand drill owns the visual
	local torso = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
	if not torso then return end
	local clone, root = buildDrillClone(getPlayerDrillTemplate(player))
	clone.Name = "BackDrill"
	local weld = Instance.new("Weld")
	weld.Name = "BackDrillWeld"
	weld.Part0 = torso
	weld.Part1 = root
	-- same off-family root correction as the hand grip (Crystal/Plasma Core)
	weld.C0 = BACK_OFFSET * rootOrientationDelta(root)
	weld.Parent = root
	clone.Parent = character
end

-- ===== Layer GUI (on-surface bar + crack) =====

local function getLayerGui(part)
	local refs = {}
	local progGui = part:FindFirstChild("FrontProgressSurfaceGui")
	local bgGui = part:FindFirstChild("FrontBackgroundSurfaceGui")
	if progGui then
		local bgFrame = progGui:FindFirstChild("BackgroundFrame")
		-- the label lives inside the LuckRow (icon + "x1 Luck" text)
		local luckRow = progGui:FindFirstChild("LuckRow")
		refs.nameLabel = (luckRow and luckRow:FindFirstChild("NameLabel")) or progGui:FindFirstChild("NameLabel")
		if bgFrame then
			refs.progressFrame = bgFrame:FindFirstChild("ProgressFrame")
			refs.hpLabel = bgFrame:FindFirstChild("TextLabel")
		end
	end
	refs.crackImage = bgGui and bgGui:FindFirstChild("ImageLabel")
	return refs
end

-- 2500000000000 -> "2.5T" (health bars go into the trillions in late zones)
local HP_SUFFIXES = { "", "K", "M", "B", "T", "Qd", "Qn", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td" }
local function formatHP(n)
	n = math.floor(n + 0.5)
	if n < 1000 then return tostring(n) end
	local mag = math.floor(math.log10(n) / 3)
	if mag > #HP_SUFFIXES - 1 then mag = #HP_SUFFIXES - 1 end
	local scaled = n / 1000 ^ mag
	local s
	if scaled >= 10 then s = string.format("%.1f", scaled) else s = string.format("%.2f", scaled) end
	s = s:gsub("%.?0+$", "")
	return s .. HP_SUFFIXES[mag + 1]
end

-- REGISTRATION-TIME INIT ONLY: the per-tick bar/crack drain moved
-- CLIENT-side (DrillClient's "hit" handler drains its own SurfaceGui) --
-- these server tweens replicated a property delta to every client on
-- every step of every damage tick.
local function updateLayerGui(layer)
	local frac = math.clamp(layer.hp / layer.maxHP, 0, 1)
	local color = GREEN
	if frac <= RED_THRESHOLD then
		color = RED
	elseif frac <= ORANGE_THRESHOLD then
		color = ORANGE
	end
	local ti = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	if layer.gui.progressFrame then
		TweenService:Create(layer.gui.progressFrame, ti, {
			Size = UDim2.new(frac, 0, 1, 0),
			BackgroundColor3 = color,
		}):Play()
	end
	if layer.gui.hpLabel then
		layer.gui.hpLabel.Text = formatHP(math.max(layer.hp, 0)) .. "/" .. formatHP(layer.maxHP)
	end
	if layer.gui.crackImage then
		-- crack fades in as the layer takes damage (Kick Door style)
		TweenService:Create(layer.gui.crackImage, ti, { ImageTransparency = frac }):Play()
	end
end

-- ===== Destruction FX =====

-- PER-PLAYER destruction: the server never destroys (or even touches)
-- the layer part -- only the drilling player's client hides its local
-- copy, kills its own collision and bursts the debris (see DrillClient
-- "explode"). Everyone else keeps seeing -- and standing on -- the
-- intact layer. `color` is the layer's original color so debris never
-- inherits a locally-mid-flash color.
local function explodeLayerFor(player, part, color)
	drillEvent:FireClient(player, "explode", part, color or part.Color)
end

-- ===== Stack registration =====

local function worldHalfExtents(part)
	local cf = part.CFrame
	local half = part.Size / 2
	local x = math.abs(cf.RightVector.X) * half.X + math.abs(cf.UpVector.X) * half.Y + math.abs(cf.LookVector.X) * half.Z
	local y = math.abs(cf.RightVector.Y) * half.X + math.abs(cf.UpVector.Y) * half.Y + math.abs(cf.LookVector.Y) * half.Z
	local z = math.abs(cf.RightVector.Z) * half.X + math.abs(cf.UpVector.Z) * half.Y + math.abs(cf.LookVector.Z) * half.Z
	return Vector3.new(x, y, z)
end

local stacks = {}

local drillHeld = {} -- [player] = true while the hotbar drill slot is held
-- [player] = true after they unequipped the drill DURING a session via the
-- hotbar toggle. The drill is gear-like: no drill in hand = no mining. The
-- flag both ends the current sessions AND blocks the presence loop from
-- auto-starting new ones until the drill is re-equipped. Sticky while they
-- walk between stacks; cleared on respawn and on leave.
local drillStowed = {}

-- defined with the drilling sessions further down; forward-declared because
-- the hotbar toggle handler above them ends sessions on unequip
local stopDrilling

local function playerHasSession(player)
	for _, stack in stacks do
		if stack.drillers[player] then return true end
	end
	return false
end

local function playerHasPadSession(player)
	for _, stack in stacks do
		if stack.trainingPad and stack.drillers[player] then return true end
	end
	return false
end

-- One pair of hands: force-release whatever the player is holding -- the
-- custom equipped item (lucky block / loot item, playerData.EquippedItem)
-- AND any equipped claimed-loot Tool. Used when the drill takes the hands:
-- the hotbar hold toggle and drilling sessions (stand-on-stack mining).
local function releaseHeldItems(player)
	if PlayerDataService and InventoryService then
		local playerData = PlayerDataService.GetPlayerData(player)
		if playerData and (playerData.EquippedItem or "") ~= "" then
			playerData.EquippedItem = ""
			InventoryService.PushUpdateForPlayer(player)
		end
	end
	local character = player.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	if humanoid and character:FindFirstChildOfClass("Tool") then
		humanoid:UnequipTools()
	end
end

-- Single source of truth for the drill visual: hand drill while a zone
-- session is active OR the hotbar drill is held, back accessory
-- otherwise. The "Drilling" attribute only flips during real sessions;
-- clients key the bit spin AND the drilling loop sound off it.
local function syncDrillVisual(player, character)
	if not character or not character.Parent then return end
	local drilling = playerHasSession(player) and not drillStowed[player]
	if drilling or drillHeld[player] then
		removeBackDrill(character)
		attachDrill(player, character)
		local drill = character:FindFirstChild("EquippedDrill")
		if drill then
			drill:SetAttribute("Drilling", drilling)
		end
	else
		removeDrill(character)
		attachBackDrill(player, character)
	end
end

local function setDrillHeld(player, held)
	held = held == true
	if (drillHeld[player] == true) == held then return end
	drillHeld[player] = held or nil
	if held then
		-- holding the drill force-unequips a carried brainrot / lucky block /
		-- loot tool; the Heartbeat poll below releases the drill on the
		-- reverse path
		releaseHeldItems(player)
	end
	local character = player.Character
	if character then
		syncDrillVisual(player, character)
	end
	drillEvent:FireClient(player, held and "hold" or "unhold")
end

drillEvent.OnServerEvent:Connect(function(player, action)
	if action == "toggleHold" then
		if playerHasSession(player) then
			-- unequipping mid-session stows the drill and STOPS the mining
			-- outright (drills are gear-like: no drill in hand, no drilling);
			-- the flag keeps the presence loop from instantly restarting the
			-- session while they keep standing on the stack
			drillStowed[player] = true
			for _, stack in stacks do
				if stack.drillers[player] then
					stopDrilling(stack, player)
				end
			end
			setDrillHeld(player, false) -- clears a manual hold + fires "unhold"
		elseif drillStowed[player] then
			-- re-equip: the hand drill comes back out, and if they're still
			-- standing on a stack the presence loop restarts the session
			-- within a beat
			drillStowed[player] = nil
			setDrillHeld(player, true)
		else
			setDrillHeld(player, not drillHeld[player])
		end
	end
end)

local function registerStacks()
	local groups = {}
	local groupLuck = {}
	for folderIndex, folder in destroyFolders do
		local luck = folder:GetAttribute("Luck")
		for _, p in folder:GetChildren() do
			-- Only parts carrying the on-surface health bar are drillable
			-- layers. The zone folders also hold the bare boundary walls;
			-- registering those made them invisible 1-layer stacks -- their
			-- detection strip overlaps the platform edge, so walking across
			-- it started a phantom wall session whose stop then stripped the
			-- drill from the still-active platform session (and two seconds
			-- of standing there silently exploded the wall).
			if p:IsA("BasePart") and p:FindFirstChild("FrontProgressSurfaceGui") then
				local key = folderIndex .. "|" .. math.floor(p.Position.X / 8 + 0.5) .. "_" .. math.floor(p.Position.Z / 8 + 0.5)
				groups[key] = groups[key] or {}
				groupLuck[key] = luck
				table.insert(groups[key], p)
			end
		end
	end
	for key, parts in groups do
		local luck = groupLuck[key]
		table.sort(parts, function(a, b) return a.Position.Y > b.Position.Y end)
		local layers = {}
		for i, part in parts do
			local maxHP = part:GetAttribute("MaxHP") or (BASE_HP + (i - 1) * HP_PER_LAYER)
			part:SetAttribute("LayerIndex", i)
			local gui = getLayerGui(part)
			if gui.nameLabel then gui.nameLabel.Text = "x" .. (luck or i) .. " Luck" end
			local layer = { part = part, hp = maxHP, maxHP = maxHP, gui = gui, origColor = part.Color }
			updateLayerGui(layer)
			layers[i] = layer
		end
		if #layers > 0 then
			table.insert(stacks, {
				layers = layers,
				drillers = {},   -- [player] = { character = ... }
				-- [player] = { current = layer index, hp = remaining } --
				-- every player digs this stack independently; there is no
				-- shared "current layer" anymore
				progress = {},
				tickAccum = 0,
			})
		end
	end
end

-- ===== Training ore pads (Workspace.Spawn) =====
-- The numbered spawn pads (1..8 + 1000) are registered as one-layer stacks
-- with infinite HP: standing on one starts a normal drilling session (drill
-- to hand, pose, hit flash/sway/tick sound -- identical reaction to a zone
-- layer) but the pad never breaks. Each tick grants Strength * the pad's
-- StrengthMult attribute instead of dealing damage. Pads are gated by the
-- RebirthsRequired attribute (leaderstats Rebirths), except pads carrying a
-- GamepassId attribute (x15 / x25 / x100) which are GAMEPASSES (converted
-- from dev products 2026-07-16, user: own forever): the pad key
-- "TrainingPadX<mult>" doubles as the GameConfig.Shop.Passes config key,
-- so GamepassService mirrors ownership into OwnsGamepass_<key>. Buyers of
-- the old dev products keep access via the legacy "<key>Owned" profile flag.
local PAD_CLICKS_PER_SEC = 2    -- AFK "clicks"/sec: gain per second = mult * this
local PAD_PAY_SECONDS = 0.5     -- payout interval: exactly mult per payout, so every
                                -- beat grants >= 1 (a 0.3s tick banked mult*0.6 and the
                                -- fractional carry skipped every ~10th beat -- felt like
                                -- the pad randomly stopping)
local PAD_DENY_COOLDOWN = 3     -- seconds between "Requires N Rebirths" popups
local PAD_PROMPT_COOLDOWN = 8   -- seconds between purchase prompts on the Robux pads
local PAD_EDGE_INSET = 2.2      -- active zone matches the inset outline ring (see pad Decor build)

local padDeniedAt = {} -- [player] = { [padPart] = clock }
local padPromptAt = {} -- [player] = clock

local function getRebirths(player)
	local ls = player:FindFirstChild("leaderstats")
	local rb = ls and ls:FindFirstChild("Rebirths")
	return (rb and rb.Value) or 0
end

local function padDeny(player, padPart, message)
	local now = os.clock()
	local map = padDeniedAt[player]
	if not map then
		map = {}
		padDeniedAt[player] = map
	end
	if map[padPart] and now - map[padPart] < PAD_DENY_COOLDOWN then return end
	map[padPart] = now
	trainingPadRemote:FireClient(player, "denied", message)
end

local function ownsRobuxPad(player, pad)
	if player:GetAttribute(pad.key) then return true end
	-- gamepass ownership: GamepassService mirrors the Shop.Passes entry whose
	-- config key == pad.key (set on join query AND on purchase finished)
	if player:GetAttribute("OwnsGamepass_" .. pad.key) then
		player:SetAttribute(pad.key, true)
		return true
	end
	-- legacy: dev-product buyers from before the gamepass conversion
	if PlayerDataService then
		local data = PlayerDataService.GetPlayerData(player)
		if data and data[pad.key .. "Owned"] then
			player:SetAttribute(pad.key, true)
			return true
		end
	end
	return false
end

local function promptRobuxPad(player, pad)
	local now = os.clock()
	if padPromptAt[player] and now - padPromptAt[player] < PAD_PROMPT_COOLDOWN then return end
	padPromptAt[player] = now
	if not pad.gamepassId or pad.gamepassId == 0 or not PurchaseService then
		padDeny(player, pad.part, "Coming soon!")
		return
	end
	-- No grant callback needed: GamepassService's PromptGamePassPurchaseFinished
	-- handler flips OwnsGamepass_<pad.key> (the pad key IS the Shop.Passes
	-- config key), which ownsRobuxPad reads on the next check.
	PurchaseService.PromptGamePass(player, pad.gamepassId, pad.key)
end

local function canUsePad(stack, player)
	local pad = stack.trainingPad
	if pad.gamepassId ~= nil then
		if ownsRobuxPad(player, pad) then return true end
		promptRobuxPad(player, pad)
		return false
	end
	if getRebirths(player) >= pad.rebirths then return true end
	padDeny(player, pad.part, "Requires " .. pad.rebirths .. " Rebirth" .. (pad.rebirths == 1 and "" or "s") .. "!")
	return false
end

local function registerTrainingPads()
	local spawnModel = workspace:FindFirstChild("Spawn")
	if not spawnModel then return end
	-- each training area is ONE Model in Spawn.LdbsArea (user-renamed from
	-- TrainingAreas; both names are accepted here so a rename never silently
	-- unregisters every pad) (gameplay
	-- attributes on the model, ZonePart + Border + Ore inside) so the user
	-- can select/scale a whole area as a unit. Bare attribute-carrying parts
	-- directly in Spawn still register as a legacy fallback. Dedupe by name
	-- so a stray duplicate attribute can never double-register a zone.
	local candidates = {}
	local areasFolder = spawnModel:FindFirstChild("LdbsArea") or spawnModel:FindFirstChild("TrainingAreas")
	if areasFolder then
		for _, area in areasFolder:GetChildren() do
			table.insert(candidates, area)
		end
	end
	for _, child in spawnModel:GetChildren() do
		if child:IsA("BasePart") then
			table.insert(candidates, child)
		end
	end
	local seenPads = {}
	for _, inst in candidates do
		if inst:GetAttribute("StrengthMult") and not seenPads[inst.Name] then
			seenPads[inst.Name] = true
			-- the ZonePart slab is the drillable surface: detection, hit
			-- flash, vibration and tick sound all target it. Fallback to the
			-- bare part with the inset margin if the slab is missing.
			local zonePart
			if inst:IsA("Model") then
				zonePart = inst:FindFirstChild("ZonePart", true)
			else
				local decorRoot = spawnModel:FindFirstChild("TrainingPadDecor")
				local decorFolder = decorRoot and decorRoot:FindFirstChild("Pad" .. inst.Name)
				zonePart = decorFolder and decorFolder:FindFirstChild("ZonePart")
			end
			local surfacePart = zonePart or (inst:IsA("BasePart") and inst or nil)
			if surfacePart then
				local layer = { part = surfacePart, hp = math.huge, maxHP = math.huge, gui = {}, origColor = surfacePart.Color }
				local padInfo = {
					part = surfacePart,
					margin = zonePart and 0 or -PAD_EDGE_INSET,
					mult = tonumber(inst:GetAttribute("StrengthMult")) or 1,
					rebirths = tonumber(inst:GetAttribute("RebirthsRequired")) or 0,
					gamepassId = tonumber(inst:GetAttribute("GamepassId")), -- nil unless it's a Robux pad
					key = "TrainingPadX" .. tostring(tonumber(inst:GetAttribute("StrengthMult")) or 1),
				}
				table.insert(stacks, {
					layers = { layer },
					drillers = {},
					tickAccum = 0,
					trainingPad = padInfo,
				})
				-- Robux pads prompt on touching ANY part of the pad (ore
				-- crystals, border, base -- not just standing on the drill
				-- surface): walking up and brushing the pile offers the pass
				-- immediately. promptRobuxPad's cooldown keeps it from spamming.
				if padInfo.gamepassId and inst:IsA("Model") then
					for _, d in inst:GetDescendants() do
						if d:IsA("BasePart") then
							d.Touched:Connect(function(hit)
								local character = hit and hit:FindFirstAncestorOfClass("Model")
								local toucher = character and Players:GetPlayerFromCharacter(character)
								if not toucher then return end
								if ownsRobuxPad(toucher, padInfo) then return end
								promptRobuxPad(toucher, padInfo)
							end)
						end
					end
				end
			end
		end
	end
end

-- ===== Drilling sessions =====

local function startDrilling(stack, player, character, humanoid)
	if stack.drillers[player] then return end
	-- movement stays free: the client freezes the body pose for the
	-- "not moving" illusion while the player walks around the platform
	stack.drillers[player] = { character = character }
	if stack.trainingPad then
		-- clicking grants nothing while a pad is paying out (see StrengthClickServer)
		player:SetAttribute("OnTrainingPad", true)
	end
	-- mining takes both hands: stepping onto a stack auto-swaps any held
	-- item (equipped lucky block / loot item / loot tool) for the drill,
	-- like a native hotbar would
	releaseHeldItems(player)
	syncDrillVisual(player, character)
	-- stowed players never reach here (presence-loop gate), so the session
	-- always announces itself
	drillEvent:FireClient(player, "start")
end

function stopDrilling(stack, player)
	local session = stack.drillers[player]
	if not session then return end
	stack.drillers[player] = nil
	if stack.trainingPad and not playerHasPadSession(player) then
		player:SetAttribute("OnTrainingPad", nil)
	end
	-- Only tear down when the player has no session left on ANY stack:
	-- overlapping detection volumes must not yank an active session's drill.
	if playerHasSession(player) then return end
	local character = player.Character
	if character then
		syncDrillVisual(player, character) -- tool still equipped keeps the hand drill
	end
	drillEvent:FireClient(player, "stop")
end

local function isOnLayer(character, layer, xzMargin)
	-- zone layers keep the forgiving 1.5-stud skirt (drilling walls from the
	-- side); training pads pass 0 so exactly-adjacent pads never overlap --
	-- no double payouts or neighbour denial popups from a shared seam.
	xzMargin = xzMargin or 1.5
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return false end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return false end
	local half = worldHalfExtents(layer.part)
	local pos = layer.part.Position
	local d = hrp.Position - pos
	if math.abs(d.X) > half.X + xzMargin or math.abs(d.Z) > half.Z + xzMargin then return false end
	local surfaceY = pos.Y + half.Y
	return hrp.Position.Y > surfaceY - 5 and hrp.Position.Y < surfaceY + 18
end

-- ===== Per-player layer progression =====
-- Each player's own position inside a zone stack: which layer THEY are
-- on and how much HP it has left FOR THEM. Created lazily on first
-- damage; wiped by resetPlayerProgress when they surface.
local function progressFor(stack, player)
	local prog = stack.progress[player]
	if not prog then
		prog = { current = 1, hp = stack.layers[1].maxHP }
		stack.progress[player] = prog
	end
	return prog
end

-- the layer THIS player currently drills on this stack (pads: always
-- the single infinite layer; nil once they dug through the whole stack)
local function layerForPlayer(stack, player)
	if stack.trainingPad then return stack.layers[1] end
	local prog = stack.progress[player]
	return stack.layers[prog and prog.current or 1]
end

-- per-hit reaction: tick sound + white flash + sway/vibration + health
-- bar / crack drain + bit-tip debris -- all client-side (DrillClient's
-- "hit" handler) and PER-PLAYER: only the driller gets the event, so
-- two players on the same stack each see nothing but their own
-- progress and FX.
local function playHitReaction(player, layer, hp, maxHP)
	local character = player.Character
	drillEvent:FireClient(player, "hit", layer.part, character and { character } or {}, layer.origColor, hp, maxHP)
end

local presenceAccum = 0
RunService.Heartbeat:Connect(function(dt)
	presenceAccum += dt
	local doPresence = presenceAccum >= PRESENCE_INTERVAL
	if doPresence then presenceAccum = 0 end

	if doPresence then
		-- equipping a brainrot / lucky block while holding the drill
		-- releases the drill (one pair of hands)
		for _, plr in Players:GetPlayers() do
			if playerHasSession(plr) then
				-- an active drilling session owns the hands: any item equipped
				-- MID-session (number key while standing on the stack) is
				-- auto-released so the drill stays out
				releaseHeldItems(plr)
			elseif drillHeld[plr] and PlayerDataService then
				local pd = PlayerDataService.GetPlayerData(plr)
				if pd and (pd.EquippedItem or "") ~= "" then
					setDrillHeld(plr, false)
				end
			end
		end
	end

	for _, stack in stacks do
		if doPresence then
			-- start sessions for players standing on THEIR current layer
			-- (per-player progression) -- with the drill in hand: a stowed
			-- drill (hotbar unequip) means no mining and no pad purchase
			-- prompts until re-equipped
			for _, player in Players:GetPlayers() do
				local character = player.Character
				local layer = character and layerForPlayer(stack, player)
				if layer and character and not stack.drillers[player] and not drillStowed[player] and isOnLayer(character, layer, stack.trainingPad and stack.trainingPad.margin or nil) then
					local humanoid = character:FindFirstChildOfClass("Humanoid")
					if humanoid and humanoid.Health > 0
						and (not stack.trainingPad or canUsePad(stack, player)) then
						startDrilling(stack, player, character, humanoid)
					end
				end
			end
			-- end sessions for players who left / died / respawned / dug
			-- through the bottom of their own stack
			for player, session in stack.drillers do
				local character = player.Character
				local layer = layerForPlayer(stack, player)
				if not character or character ~= session.character or not layer or not isOnLayer(character, layer, stack.trainingPad and stack.trainingPad.margin or nil) then
					stopDrilling(stack, player)
				end
			end
		end

		-- damage tick
		local drillerCount = 0
		for _ in stack.drillers do drillerCount += 1 end
		if drillerCount > 0 then
			if stack.trainingPad then
				-- ore pad: payout and reaction are ONE beat -- every audible/
				-- visible tick grants Strength. One "click" worth (mult) per
				-- beat; mult >= 1 so no beat can floor to zero, fractional
				-- mults (x1.5) alternate 1/2 via the carry.
				stack.padPayAccum = (stack.padPayAccum or 0) + dt
				if stack.padPayAccum >= PAD_PAY_SECONDS then
					stack.padPayAccum -= PAD_PAY_SECONDS
					local mult = stack.trainingPad.mult
					for plr, session in stack.drillers do
						-- pads simulate clicks, so each simulated click is worth the
						-- same as a manual one: (1 + drill Power) * trail boost *
						-- rebirth StrengthMultiplier * strength ladder tier (all
						-- CUMULATE, mirroring StrengthClickServer), times the pad's
						-- own multiplier
						local trailBoost = math.max(tonumber(plr:GetAttribute("TrailBoost")) or 1, 1)
						local drillFactor = 1 + math.max(tonumber(plr:GetAttribute("DrillPower")) or 0, 0)
						local rebirthBoost = math.max(tonumber(plr:GetAttribute("StrengthMultiplier")) or 1, 1)
						local passBoost = math.max(tonumber(plr:GetAttribute("StrengthLadderMult")) or 1, 1)
						session.gainAccum = (session.gainAccum or 0) + mult * PAD_PAY_SECONDS * PAD_CLICKS_PER_SEC * drillFactor * trailBoost * rebirthBoost * passBoost
						local whole = math.floor(session.gainAccum)
						if whole >= 1 and grantStrengthEvent then
							session.gainAccum -= whole
							grantStrengthEvent:Fire(plr, whole)
							trainingPadRemote:FireClient(plr, "gain", whole)
						end
					end
					for plr in stack.drillers do
						playHitReaction(plr, stack.layers[1], math.huge, math.huge)
					end
				end
			else
				stack.tickAccum += dt
				if stack.tickAccum >= TICK_SECONDS then
					stack.tickAccum -= TICK_SECONDS
					-- PER-PLAYER damage: every driller chews through their
					-- OWN copy of the stack (own layer index + hp), and only
					-- they see the hit FX / bar drain / destruction
					for plr in stack.drillers do
						local prog = progressFor(stack, plr)
						local layer = stack.layers[prog.current]
						if layer then
							local strength = tonumber(plr:GetAttribute("Strength")) or 0
							-- flat bonus from the equipped drill (set by DrillShopService)
							local drillPower = tonumber(plr:GetAttribute("DrillPower")) or 0
							-- same strength boosts the pad payout applies (all CUMULATE):
							-- trail * rebirth StrengthMultiplier * strength ladder tier
							local trailBoost = math.max(tonumber(plr:GetAttribute("TrailBoost")) or 1, 1)
							local rebirthBoost = math.max(tonumber(plr:GetAttribute("StrengthMultiplier")) or 1, 1)
							local passBoost = math.max(tonumber(plr:GetAttribute("StrengthLadderMult")) or 1, 1)
							prog.hp -= math.max(DAMAGE_PER_TICK, (strength + drillPower) * trailBoost * rebirthBoost * passBoost)
							playHitReaction(plr, layer, prog.hp, layer.maxHP)
							if prog.hp <= 0 then
								explodeLayerFor(plr, layer.part, layer.origColor)
								prog.current += 1
								local nextLayer = stack.layers[prog.current]
								if nextLayer then
									prog.hp = nextLayer.maxHP
								else
									-- dug through the whole stack: session over
									stopDrilling(stack, plr)
								end
							end
						end
					end
				end
			end
		else
			stack.tickAccum = 0
			stack.padPayAccum = 0
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	drillHeld[player] = nil
	drillStowed[player] = nil
	padDeniedAt[player] = nil
	padPromptAt[player] = nil
	for _, stack in stacks do
		stack.drillers[player] = nil
	end
end)

-- ===== Back accessory on spawn =====

local function waitForTorso(character)
	for _ = 1, 100 do
		local t = character:FindFirstChild("UpperTorso") or character:FindFirstChild("Torso")
		if t then return t end
		if not character.Parent then return nil end
		task.wait(0.1)
	end
	return nil
end

local function equipBackOnSpawn(player, character)
	-- fresh character never spawns holding the drill; this also tells the
	-- client to clear the hotbar highlight if the player died while holding.
	-- A stowed drill doesn't survive death either: respawning goes back to
	-- the default walk-on-and-mine behavior.
	drillStowed[player] = nil
	setDrillHeld(player, false)
	task.spawn(function()
		if waitForTorso(character) and character.Parent then
			syncDrillVisual(player, character)
		end
	end)
end

local function onPlayerAdded(player)
	player.CharacterAdded:Connect(function(character)
		equipBackOnSpawn(player, character)
	end)
	-- Equipping a different drill in the shop: tear down whichever visual
	-- exists (back accessory or hand drill) and rebuild from the new
	-- template. syncDrillVisual re-attaches in the correct place because
	-- session/held state is untouched.
	player:GetAttributeChangedSignal("SelectedDrill"):Connect(function()
		local character = player.Character
		if not character then return end
		removeDrill(character)
		removeBackDrill(character)
		syncDrillVisual(player, character)
	end)
	if player.Character then
		equipBackOnSpawn(player, player.Character)
	end
end

Players.PlayerAdded:Connect(onPlayerAdded)
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end

registerStacks()
registerTrainingPads()

-- ===== Per-player zone reset (back to surface) =====
-- Destruction is per-player and purely client-side, so a "reset" is now
-- just: wipe THAT player's progression on every zone stack and tell
-- THEIR client to restore its locally-hidden layers / drained bars.
-- Fires when a player who was underground returns to the surface (same
-- Y threshold SurfaceModeController uses). The old global
-- destroy-and-reclone snapshot machinery is gone -- server-side layer
-- parts never change at all.
local UNDERGROUND_Y = -4 -- keep in sync with SurfaceModeController

local function resetPlayerProgress(player)
	for _, stack in stacks do
		if not stack.trainingPad then
			-- never yank the layer out from under an active session
			if stack.drillers[player] then
				stopDrilling(stack, player)
			end
			stack.progress[player] = nil
		end
	end
	drillEvent:FireClient(player, "resetLayers")
end

local wasUnderground = {} -- [player] = true while their HRP sits below UNDERGROUND_Y

local surfaceCheckAccum = 0
RunService.Heartbeat:Connect(function(dt)
	surfaceCheckAccum += dt
	if surfaceCheckAccum < 0.5 then return end
	surfaceCheckAccum = 0
	for _, plr in Players:GetPlayers() do
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local under = hrp.Position.Y < UNDERGROUND_Y
			if wasUnderground[plr] and not under then
				resetPlayerProgress(plr)
			end
			wasUnderground[plr] = under or nil
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	wasUnderground[player] = nil
	for _, stack in stacks do
		if stack.progress then
			stack.progress[player] = nil
		end
	end
end)
