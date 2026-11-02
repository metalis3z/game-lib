--[[
	EffectsHudController -- owns the strength-effect chips on the HUD
	effects bar (PlayerGui.GUI.HUD.RightDownSide), alongside the cash-side
	chips (CashBoost / FriendBoost / RobloxPlus, which have their own
	controllers):
	  TrailBoost  -- visible while a trail is equipped; "+N%" comes from
	                 the TrailBoost player attribute (strength multiplier,
	                 e.g. 1.2 -> +20%) and the streak icon is tinted with
	                 the equipped trail's own color gradient from
	                 GameConfig.Trails.
	  X2Strength  -- visible once any strength ladder tier is owned
	                 (StrengthLadderMult attribute, StrengthLadderServer);
	                 shows the permanent multiplier ("x2" .. "x1024").
	Purely attribute-driven, no remotes: TrailShopService and
	StrengthLadderServer keep the attributes correct.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameConfig = require(ReplicatedStorage:WaitForChild("Source"):WaitForChild("Configs"):WaitForChild("GameConfig"))

local EffectsHudController = {}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local EQUIPPED_ATTR = "EquippedTrail"
local TRAIL_BOOST_ATTR = "TrailBoost"
local X2_ATTR = "StrengthLadderMult"

-- same convention as the other chip controllers: the label plus any text
-- descendants (shadow twins) all carry the same string
local function setChipText(label, text)
	if not label then
		return
	end
	label.Text = text
	for _, descendant in ipairs(label:GetDescendants()) do
		if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
			descendant.Text = text
		end
	end
end

local function buildColorSequence(colors)
	local count = #colors
	if count == 0 then
		return ColorSequence.new(Color3.new(1, 1, 1))
	end
	if count == 1 then
		return ColorSequence.new(colors[1])
	end
	local keypoints = {}
	for i, color in ipairs(colors) do
		keypoints[i] = ColorSequenceKeypoint.new((i - 1) / (count - 1), color)
	end
	return ColorSequence.new(keypoints)
end

local function findChip(name)
	local gui = playerGui:WaitForChild("GUI", 10)
	if not gui then return nil end
	local hud = gui:WaitForChild("HUD", 10)
	if not hud then return nil end
	local rds = hud:WaitForChild("RightDownSide", 10)
	if not rds then return nil end
	return rds:WaitForChild(name, 10)
end

-- ===== TrailBoost chip =====

local function initTrailChip()
	local chip = findChip("TrailBoost")
	if not chip then
		return
	end
	local button = chip:FindFirstChild("Button")
	local label = button and button:FindFirstChild("Boost")
	local icon = button and button:FindFirstChild("Icon")
	if not label then
		warn("[EffectsHudController] Boost label missing under HUD.RightDownSide.TrailBoost.Button")
		return
	end

	local function refresh()
		local equipped = player:GetAttribute(EQUIPPED_ATTR)
		local cfg = nil
		if type(equipped) == "string" and equipped ~= "" then
			cfg = GameConfig.Trails and GameConfig.Trails[equipped]
		end
		local mult = tonumber(player:GetAttribute(TRAIL_BOOST_ATTR)) or (cfg and cfg.Boost) or 1
		local pct = math.floor((mult - 1) * 100 + 0.5)
		if not cfg or pct <= 0 then
			chip.Visible = false
			return
		end

		setChipText(label, "+" .. pct .. "%")
		-- the streak icon wears the equipped trail's own colors
		if icon then
			local sequence = buildColorSequence(cfg.Colors or {})
			for _, descendant in ipairs(icon:GetDescendants()) do
				if descendant:IsA("UIGradient") then
					descendant.Color = sequence
				end
			end
		end
		chip.Visible = true
	end

	player:GetAttributeChangedSignal(EQUIPPED_ATTR):Connect(refresh)
	player:GetAttributeChangedSignal(TRAIL_BOOST_ATTR):Connect(refresh)
	refresh()
end

-- ===== X2Strength chip =====

local function initX2Chip()
	local chip = findChip("X2Strength")
	if not chip then
		return
	end
	local button = chip:FindFirstChild("Button")
	local label = button and button:FindFirstChild("Boost")
	if not label then
		warn("[EffectsHudController] Boost label missing under HUD.RightDownSide.X2Strength.Button")
		return
	end

	local function refresh()
		local mult = math.max(tonumber(player:GetAttribute(X2_ATTR)) or 1, 1)
		if mult <= 1 then
			chip.Visible = false
			return
		end
		setChipText(label, "x" .. mult)
		chip.Visible = true
	end
	player:GetAttributeChangedSignal(X2_ATTR):Connect(refresh)
	refresh()
end

function EffectsHudController.Init()
	task.spawn(initTrailChip)
	task.spawn(initX2Chip)
end

return EffectsHudController
