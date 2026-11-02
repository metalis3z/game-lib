--[[
	UISounds  (client ModuleScript, e.g. ReplicatedStorage/Shared/UISounds)

	Gives every GuiButton in PlayerGui a hover and click sound, including
	buttons created later. Sounds are preloaded, slightly pitch-varied so
	repeated clicks do not sound robotic, and routed to an optional SoundGroup
	so your SFX volume slider controls them.

	Per-button attributes (set them in Studio or from code):
	  NoSound    = true                     -> this button stays silent
	  ClickSound = "Open"                   -> use a registered sound name instead of "Click"
	  HoverSound = false                    -> no hover sound on this button

	Ideas taken from:
	  - drill-and-mine        UIClickSound: DescendantAdded hook, attribute guard, preload, prompts click too
	  - smash-egg-for-animals UIEffects: pitch variation, hover + click, fallback sound if an asset fails
	  - pass-the-bomb         SoundManager: hover + click on every button

	Usage (from a LocalScript):
		local UISounds = require(ReplicatedStorage.Shared.UISounds)
		UISounds.Start({
			Click = "rbxassetid://1234567890",
			Hover = "rbxassetid://2345678901",
			SoundGroup = SoundService:FindFirstChild("SFX"),
			IncludePrompts = true, -- also click when a ProximityPrompt is triggered
		})
		UISounds.Register("Open", "rbxassetid://3456789012", 0.45)
		UISounds.Play("Open") -- play any registered sound manually
]]

local ContentProvider = game:GetService("ContentProvider")
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")

local FALLBACK_CLICK = "rbxasset://sounds/clickfast.wav" -- ships with the Roblox client
local HOVER_MIN_INTERVAL = 0.05 -- stops hover spam when the mouse sweeps across a grid
local PITCH_JITTER = 0.04

local UISounds = {}

local folder: Folder? = nil
local soundGroup: SoundGroup? = nil
local templates: { [string]: Sound } = {}
local bound = setmetatable({}, { __mode = "k" }) -- buttons already hooked
local lastHover = 0
local started = false

local function getFolder(): Folder
	if not folder then
		local f = Instance.new("Folder")
		f.Name = "UISounds"
		f.Parent = SoundService
		folder = f
	end
	return folder :: Folder
end

function UISounds.Register(name: string, soundId: string, volume: number?)
	local sound = Instance.new("Sound")
	sound.Name = name
	sound.SoundId = soundId
	sound.Volume = volume or 0.5
	sound.SoundGroup = soundGroup
	sound.Parent = getFolder()
	templates[name] = sound

	task.spawn(function()
		pcall(function()
			ContentProvider:PreloadAsync({ sound })
		end)
		if not sound.IsLoaded and name == "Click" then
			sound.SoundId = FALLBACK_CLICK
		end
	end)
end

function UISounds.Play(name: string)
	local template = templates[name]
	if not template then
		return
	end
	local sound = template:Clone()
	sound.PlaybackSpeed = 1 + (math.random() * 2 - 1) * PITCH_JITTER
	sound.Parent = getFolder()
	sound:Play()
	sound.Ended:Once(function()
		sound:Destroy()
	end)
	task.delay(5, function() -- safety net if Ended never fires
		if sound.Parent then
			sound:Destroy()
		end
	end)
end

local function hook(instance: Instance)
	if not instance:IsA("GuiButton") or bound[instance] then
		return
	end
	bound[instance] = true

	local canHover = UserInputService.MouseEnabled
	instance.MouseEnter:Connect(function()
		if not canHover or instance:GetAttribute("NoSound") or instance:GetAttribute("HoverSound") == false then
			return
		end
		local now = os.clock()
		if now - lastHover < HOVER_MIN_INTERVAL then
			return
		end
		lastHover = now
		UISounds.Play("Hover")
	end)

	instance.Activated:Connect(function()
		if instance:GetAttribute("NoSound") then
			return
		end
		local custom = instance:GetAttribute("ClickSound")
		UISounds.Play(if typeof(custom) == "string" and templates[custom] then custom else "Click")
	end)
end

export type StartOptions = {
	Click: string?,
	Hover: string?,
	ClickVolume: number?,
	HoverVolume: number?,
	SoundGroup: SoundGroup?,
	IncludePrompts: boolean?,
}

function UISounds.Start(options: StartOptions?)
	if started then
		return
	end
	started = true
	local opts = options or {}
	soundGroup = opts.SoundGroup

	UISounds.Register("Click", opts.Click or FALLBACK_CLICK, opts.ClickVolume or 0.4)
	if opts.Hover then
		UISounds.Register("Hover", opts.Hover, opts.HoverVolume or 0.12)
	end

	local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
	for _, descendant in ipairs(playerGui:GetDescendants()) do
		hook(descendant)
	end
	playerGui.DescendantAdded:Connect(hook)

	if opts.IncludePrompts then
		ProximityPromptService.PromptTriggered:Connect(function()
			UISounds.Play("Click")
		end)
	end
end

return UISounds
