-- LoadingScreen (LocalScript) - clean pattern, written for this reference library.
--
-- A complete ReplicatedFirst loading screen built entirely in code (no assets needed):
--   * removes Roblox's default screen right away
--   * preloads a list of containers in small batches and shows real % progress
--   * rotating tips, animated "Loading..." dots
--   * a Skip button that appears after SKIP_AFTER seconds
--   * a minimum display time so it never just flickers
--   * fades out, then announces it is done (player attribute "LoadingDone" + optional RemoteEvent)
--
-- Ideas taken from:
--   smash-egg-for-animals (code-built UI, tips, flash/fade), murder-mystery-2 (Skip after 7 s),
--   pet-rng (per-asset % bar + Skip), big-paintball (hide core UI, cap preload time),
--   rivals-modded (tell the server when the screen closes so it can spawn the character),
--   drill-and-mine (a "loading finished" signal other code can wait for).
--
-- Usage:
--   1. Put this LocalScript directly in ReplicatedFirst.
--   2. Edit CONFIG below (title, tips, containers to preload).
--   3. Other client code waits with:
--        local player = game.Players.LocalPlayer
--        if not player:GetAttribute("LoadingDone") then player:GetAttributeChangedSignal("LoadingDone"):Wait() end
--   4. Optional: create ReplicatedStorage.Remotes.LoadingDone (RemoteEvent). If it exists it is fired
--      when the screen closes; the server can then call player:LoadCharacter() (with
--      Players.CharacterAutoLoads = false) like rivals-modded does.

local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContentProvider = game:GetService("ContentProvider")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local CONFIG = {
	Title = "MY GAME",
	Tips = {
		"Tip: You can change the music volume in Settings.",
		"Tip: Invite friends for bonus rewards!",
		"Tip: Check the shop for daily deals.",
	},
	TipInterval = 3,          -- seconds between tips
	MinDisplayTime = 2.5,     -- never close sooner than this
	SkipAfter = 6,            -- Skip button shows after this many seconds (nil = never)
	MaxPreloadTime = 25,      -- stop preloading after this (the game keeps streaming anyway)
	BatchSize = 10,           -- assets per PreloadAsync call
	HideCoreGui = true,
	SkipInStudio = false,     -- set true to skip the screen while testing in Studio
	-- Paths (relative to game) of containers to preload. Missing ones are ignored.
	PreloadPaths = {
		{ "ReplicatedStorage", "UI" },
		{ "SoundService" },
	},
	Colors = {
		Background = Color3.fromRGB(18, 20, 32),
		Accent = Color3.fromRGB(255, 196, 64),
		Text = Color3.new(1, 1, 1),
		BarBack = Color3.fromRGB(40, 44, 64),
	},
}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

ReplicatedFirst:RemoveDefaultLoadingScreen()

local function finishImmediately()
	player:SetAttribute("LoadingDone", true)
end

if CONFIG.SkipInStudio and RunService:IsStudio() then
	finishImmediately()
	return
end

if CONFIG.HideCoreGui then
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, false)
end

---------------------------------------------------------------------------- UI
local function new(className: string, props: { [string]: any }, parent: Instance?)
	local inst = Instance.new(className)
	for key, value in props do
		(inst :: any)[key] = value
	end
	inst.Parent = parent
	return inst
end

local gui = new("ScreenGui", {
	Name = "LoadingScreen", IgnoreGuiInset = true, ResetOnSpawn = false, DisplayOrder = 1000,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, playerGui)

local background = new("Frame", {
	Size = UDim2.fromScale(1, 1), BackgroundColor3 = CONFIG.Colors.Background, BorderSizePixel = 0, Active = true,
}, gui)

local title = new("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.4), Size = UDim2.fromScale(0.7, 0.14),
	BackgroundTransparency = 1, Text = CONFIG.Title, TextScaled = true, Font = Enum.Font.FredokaOne,
	TextColor3 = CONFIG.Colors.Text,
}, background)
local titleScale = new("UIScale", { Scale = 0.6 }, title)

local barBack = new("Frame", {
	AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.62), Size = UDim2.fromScale(0.45, 0.03),
	BackgroundColor3 = CONFIG.Colors.BarBack, BorderSizePixel = 0,
}, background)
new("UICorner", { CornerRadius = UDim.new(1, 0) }, barBack)
new("UISizeConstraint", { MinSize = Vector2.new(200, 12) }, barBack)
local barFill = new("Frame", {
	Size = UDim2.fromScale(0, 1), BackgroundColor3 = CONFIG.Colors.Accent, BorderSizePixel = 0,
}, barBack)
new("UICorner", { CornerRadius = UDim.new(1, 0) }, barFill)

local status = new("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0.65), Size = UDim2.fromScale(0.5, 0.04),
	BackgroundTransparency = 1, Text = "Loading", TextScaled = true, Font = Enum.Font.GothamBold,
	TextColor3 = CONFIG.Colors.Text,
}, background)

local tip = new("TextLabel", {
	AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.fromScale(0.5, 0.94), Size = UDim2.fromScale(0.8, 0.035),
	BackgroundTransparency = 1, Text = CONFIG.Tips[1] or "", TextScaled = true, Font = Enum.Font.Gotham,
	TextColor3 = CONFIG.Colors.Text, TextTransparency = 0.2,
}, background)

local skipButton = new("TextButton", {
	AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -24, 1, -24), Size = UDim2.fromOffset(120, 44),
	BackgroundColor3 = CONFIG.Colors.Accent, Text = "Skip", Font = Enum.Font.GothamBold, TextSize = 20,
	TextColor3 = CONFIG.Colors.Background, Visible = false, AutoButtonColor = true,
}, background)
new("UICorner", { CornerRadius = UDim.new(0, 10) }, skipButton)

TweenService:Create(titleScale, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()

---------------------------------------------------------------------------- state
local startTime = os.clock()
local progress = 0          -- 0..1, real progress
local shownProgress = 0     -- smoothed for display
local skipped = false
local finished = false

skipButton.Activated:Connect(function()
	skipped = true
end)

-- Animate bar, dots, tips and the Skip button every frame.
local animConnection = RunService.RenderStepped:Connect(function(dt)
	local elapsed = os.clock() - startTime
	shownProgress += (progress - shownProgress) * math.min(1, dt * 8)
	barFill.Size = UDim2.fromScale(shownProgress, 1)
	status.Text = ("Loading%s  %d%%"):format(string.rep(".", math.floor(elapsed * 2) % 4), math.floor(shownProgress * 100 + 0.5))
	if #CONFIG.Tips > 0 then
		tip.Text = CONFIG.Tips[math.floor(elapsed / CONFIG.TipInterval) % #CONFIG.Tips + 1]
	end
	if CONFIG.SkipAfter and elapsed >= CONFIG.SkipAfter and not finished then
		skipButton.Visible = true
	end
end)

---------------------------------------------------------------------------- loading work
local function resolve(path: { string }): Instance?
	-- First entry is a service name, the rest are child names (they may still be replicating).
	local ok, current = pcall(game.GetService, game, path[1])
	if not ok then
		return nil
	end
	for i = 2, #path do
		current = current:WaitForChild(path[i], 5)
		if not current then
			return nil
		end
	end
	return current
end

local function collectAssets(): { Instance }
	local list = {}
	for _, path in CONFIG.PreloadPaths do
		local container = resolve(path)
		if container then
			for _, inst in container:GetDescendants() do
				if inst:IsA("ImageLabel") or inst:IsA("ImageButton") or inst:IsA("Decal") or inst:IsA("Texture")
					or inst:IsA("Sound") or inst:IsA("Animation") or inst:IsA("MeshPart") then
					table.insert(list, inst)
				end
			end
		end
	end
	return list
end

if not game:IsLoaded() then
	game.Loaded:Wait()
end
progress = 0.1

local assets = collectAssets()
local total = #assets
local index = 1
while index <= total and not skipped and os.clock() - startTime < CONFIG.MaxPreloadTime do
	local batch = table.move(assets, index, math.min(index + CONFIG.BatchSize - 1, total), 1, {})
	pcall(ContentProvider.PreloadAsync, ContentProvider, batch)
	index += #batch
	progress = 0.1 + 0.9 * ((index - 1) / total)
end
progress = 1

-- Respect the minimum display time (unless skipped).
while not skipped and os.clock() - startTime < CONFIG.MinDisplayTime do
	task.wait()
end
finished = true
skipButton.Visible = false

---------------------------------------------------------------------------- close
local fadeInfo = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
TweenService:Create(background, fadeInfo, { BackgroundTransparency = 1 }):Play()
for _, label in { title, status, tip } do
	TweenService:Create(label, fadeInfo, { TextTransparency = 1 }):Play()
end
TweenService:Create(barBack, fadeInfo, { BackgroundTransparency = 1 }):Play()
TweenService:Create(barFill, fadeInfo, { BackgroundTransparency = 1 }):Play()
task.wait(fadeInfo.Time)

animConnection:Disconnect()
gui:Destroy()

if CONFIG.HideCoreGui then
	pcall(StarterGui.SetCoreGuiEnabled, StarterGui, Enum.CoreGuiType.All, true)
end

player:SetAttribute("LoadingDone", true)

local remotes = ReplicatedStorage:FindFirstChild("Remotes")
local doneRemote = remotes and remotes:FindFirstChild("LoadingDone")
if doneRemote and doneRemote:IsA("RemoteEvent") then
	doneRemote:FireServer()
end
