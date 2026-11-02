-- AdminClient.lua
-- LocalScript dans StarterGui
-- Ouvrir/Fermer avec H (ou le bouton ⚡ en bas à droite)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

print("[AdminClient] Démarrage...")

local AdminFolder = ReplicatedStorage:WaitForChild("AdminSystem", 60)
print("[AdminClient] AdminFolder:", AdminFolder and "TROUVE" or "INTROUVABLE - STOP")
if not AdminFolder then return end

local CheckAdmin = AdminFolder:WaitForChild("CheckAdmin")
local ExecuteCommand = AdminFolder:WaitForChild("ExecuteCommand")
local CommandResult = AdminFolder:WaitForChild("CommandResult")
local GetEvents = AdminFolder:WaitForChild("GetEvents")
local GetItems = AdminFolder:WaitForChild("GetItems")
local GetBrainrots = AdminFolder:WaitForChild("GetBrainrots")
local GetLuckyBlocks = AdminFolder:WaitForChild("GetLuckyBlocks")
local GetMutations = AdminFolder:WaitForChild("GetMutations")
local GetTraits = AdminFolder:WaitForChild("GetTraits")
local GetBrainrotData = AdminFolder:WaitForChild("GetBrainrotData")

task.wait(2)
local isAdmin = CheckAdmin:InvokeServer()
print("[AdminClient] isAdmin:", tostring(isAdmin))
if not isAdmin then print("[AdminClient] Pas admin - STOP"); return end
print("[AdminClient] Admin OK - Creation GUI...")

-- ============================================================
-- CATEGORIES & COMMANDS
-- ============================================================

local CATEGORIES = {
	{
		name = "Brainrots",
		icon = "🐾",
		color = Color3.fromRGB(94, 234, 141),
		commands = {
			{ name = "Add Brainrot", cmd = "addbrainrot", desc = "Add a brainrot to a player",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
					{ label = "Traits (comma)", key = "traits", type = "traitsmulti", optional = true },
				}
			},
			{ name = "Spawn Brainrot", cmd = "spawnbrainrot", desc = "Spawn locally in the world",
				fields = {
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
					{ label = "Traits (comma)", key = "traits", type = "traitsmulti", optional = true },
				}
			},
			{ name = "Spawn Global Brainrot", cmd = "spawnglobalbrainrot", desc = "Spawn on ALL servers",
				fields = {
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
					{ label = "Traits (comma)", key = "traits", type = "traitsmulti", optional = true },
				}
			},
			{ name = "Add Lucky Block", cmd = "addluckyblock", desc = "Give a lucky block to a player",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Lucky Block", key = "brainrot", type = "luckyblock" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
				}
			},
			{ name = "Spawn Lucky Block", cmd = "spawnluckyblock", desc = "Spawn a lucky block locally",
				fields = {
					{ label = "Lucky Block", key = "brainrot", type = "luckyblock" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
				}
			},
			{ name = "Spawn Global Lucky Block", cmd = "spawngloballuckyblock", desc = "Spawn lucky block everywhere",
				fields = {
					{ label = "Lucky Block", key = "brainrot", type = "luckyblock" },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
				}
			},
			{ name = "Spawn All Traits", cmd = "spawnbrainrotalltraits", desc = "Spawn with ALL traits",
				fields = {
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
				}
			},
			{ name = "Random Secret", cmd = "randomsecret", desc = "Spawn a random secret", fields = {} },
			{ name = "Random Spooky", cmd = "randomspooky", desc = "Spawn a random spooky", fields = {} },
			{ name = "Random Limited Global", cmd = "randomLimitedBrainrotGlobal", desc = "Spawn random limited everywhere", fields = {} },
			{ name = "Spawn Random Server", cmd = "spawnrandomserverbrainrot", desc = "Spawn random on each server",
				fields = {
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Amount", key = "amount", type = "number", default = "1" },
				}
			},
			{ name = "Brainrot Grab", cmd = "brainrotgrab", desc = "Grab a brainrot for a player",
				fields = {
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Target player", key = "player", type = "player" },
				}
			},
		}
	},
	{
		name = "Events",
		icon = "⚡",
		color = Color3.fromRGB(251, 191, 36),
		commands = {
			{ name = "Execute Event", cmd = "executeevent", desc = "Start a local event",
				fields = {
					{ label = "Event", key = "event", type = "event" },
					{ label = "Duration (s)", key = "duration", type = "number", optional = true },
				}
			},
			{ name = "Execute Global Event", cmd = "executeglobalevent", desc = "Start an event on all servers",
				fields = {
					{ label = "Event", key = "event", type = "event" },
					{ label = "Duration (s)", key = "duration", type = "number", optional = true },
				}
			},
			{ name = "Cancel Event", cmd = "cancelevent", desc = "Cancel a local event",
				fields = {
					{ label = "Event", key = "event", type = "event" },
				}
			},
			{ name = "Cancel Global Event", cmd = "cancelglobalevent", desc = "Cancel an event everywhere",
				fields = {
					{ label = "Event (empty = all)", key = "event", type = "event", optional = true },
				}
			},
			{ name = "Fuse Reveal Global", cmd = "globalfusereveal", desc = "Reveal all fusions", fields = {} },
		}
	},
	{
		name = "Players",
		icon = "👤",
		color = Color3.fromRGB(99, 179, 237),
		commands = {
			{ name = "Kick", cmd = "kick", desc = "Kick a player",
				fields = { { label = "Player", key = "player", type = "player" } }
			},
			{ name = "Ban", cmd = "ban", desc = "Ban a player",
				fields = {
					{ label = "Player name", key = "player", type = "text" },
					{ label = "Reason", key = "reason", type = "text" },
				}
			},
			{ name = "Unban", cmd = "unban", desc = "Unban a player",
				fields = { { label = "Player name", key = "player", type = "text" } }
			},
			{ name = "Set Money", cmd = "setmoney", desc = "Set money",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Amount", key = "amount", type = "number" },
				}
			},
			{ name = "Set Rebirth", cmd = "setrebirth", desc = "Set rebirth",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Rebirth", key = "rebirth", type = "number" },
				}
			},
			{ name = "Set Name", cmd = "setname", desc = "Change display name",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "New name", key = "name", type = "text" },
				}
			},
			{ name = "Add Spins", cmd = "addspins", desc = "Add divine spins",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Amount", key = "spins", type = "number" },
				}
			},
			{ name = "Add Luck", cmd = "addluck", desc = "Activate luck (1=2x, 2=4x)",
				fields = { { label = "Index (1=2x | 2=4x)", key = "luck", type = "number" } }
			},
			{ name = "End Luck", cmd = "endluck", desc = "Stop luck", fields = {} },
			{ name = "Force Speed", cmd = "forcespeed", desc = "Force speed (0 = reset)",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Speed (0 = reset)", key = "speed", type = "number" },
				}
			},
			{ name = "Steal Protection", cmd = "stealprotection", desc = "Steal protection",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "State", key = "state", type = "onoff" },
				}
			},
			{ name = "Reset Data", cmd = "resetdata", desc = "Reset data",
				fields = { { label = "Player", key = "player", type = "player" } }
			},
			{ name = "Wipe Self", cmd = "wipeself", desc = "Reset own data", fields = {} },
			{ name = "Give Item", cmd = "giveitem", desc = "Give an item",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Item", key = "item", type = "item" },
				}
			},
			{ name = "Remove Item", cmd = "removeitem", desc = "Remove an item",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Item name", key = "item", type = "text" },
				}
			},
			{ name = "Force Lucky Brainrot", cmd = "forceluckybrainrot", desc = "Force next lucky",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
				}
			},
			{ name = "Force Fuse", cmd = "forcefuse", desc = "Force fusion",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Brainrot", key = "brainrot", type = "brainrot" },
					{ label = "Mutation", key = "mutation", type = "mutation", optional = true },
					{ label = "Traits (comma)", key = "traits", type = "traitsmulti", optional = true },
				}
			},
			{ name = "Unlock Index", cmd = "unlockindex", desc = "Unlock index",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Mutation (opt.)", key = "mutation", type = "text", optional = true },
				}
			},
			{ name = "Set Base Skin", cmd = "setbaseskin", desc = "Change base skin",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Skin", key = "skin", type = "text" },
				}
			},
			{ name = "Base Position", cmd = "baseposition", desc = "Change base position",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Position (1-8)", key = "position", type = "number" },
				}
			},
			{ name = "Clear Base", cmd = "clearbase", desc = "Clear own base", fields = {} },
			{ name = "Nuke Base", cmd = "NukeBase", desc = "Nuke base (false = restore)",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Explode?", key = "explode", type = "bool", default = "true" },
				}
			},
		}
	},
	{
		name = "Announce",
		icon = "📢",
		color = Color3.fromRGB(248, 113, 113),
		commands = {
			{ name = "Announce", cmd = "announce", desc = "Local announce",
				fields = { { label = "Text", key = "text", type = "text" } }
			},
			{ name = "Global Announce", cmd = "globalannounce", desc = "Announce on all servers",
				fields = { { label = "Text", key = "text", type = "text" } }
			},
			{ name = "Rainbow Announce", cmd = "rainbowannounce", desc = "Global rainbow announce",
				fields = { { label = "Text", key = "text", type = "text" } }
			},
			{ name = "Player Announce", cmd = "playerannounce", desc = "Private announce to a player",
				fields = {
					{ label = "Player", key = "player", type = "player" },
					{ label = "Text", key = "text", type = "text" },
				}
			},
			{ name = "Start Update", cmd = "startupdate", desc = "Global update countdown",
				fields = { { label = "Time (ex: 5m 30s)", key = "time", type = "text" } }
			},
			{ name = "Stop Update", cmd = "stopupdate", desc = "Stop countdown", fields = {} },
			{ name = "Start Taco Tuesday", cmd = "starttacotueday", desc = "Taco Tuesday countdown",
				fields = { { label = "Time (ex: 5m 30s)", key = "time", type = "text" } }
			},
			{ name = "Start Poll", cmd = "startpoll", desc = "Start a global poll",
				fields = {
					{ label = "Question", key = "question", type = "text" },
					{ label = "Option 1", key = "option1", type = "text" },
					{ label = "Option 2", key = "option2", type = "text" },
					{ label = "Duration (s)", key = "duration", type = "number", default = "30", optional = true },
				}
			},
			{ name = "End Poll", cmd = "endpoll", desc = "End active poll", fields = {} },
		}
	},
	{
		name = "Brainrot Count",
		icon = "📊",
		color = Color3.fromRGB(255, 255, 255),
		isCount = true,
		commands = {}
	},
}

-- ============================================================
-- STATE
-- ============================================================
local currentCategory = 1
local currentCommand = nil
local isDragging = false
local dragOffset = Vector2.new()
local playerList = {}
local eventList = {}
local itemList = {}
local brainrotList = {}
local luckyBlockList = {}
local mutationList = {}
local traitList = {}
local activeFormFields = {}
local catButtons = {}
local cmdButtons = {}
local buildForm -- forward declaration

-- ============================================================
-- GUI SETUP - DESIGN NOIR/BLEU PREMIUM
-- ============================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AdminPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder = 999
screenGui.Parent = player.PlayerGui

local W, H = 780, 500

-- Glow extérieur bleu
local glowOuter = Instance.new("Frame")
glowOuter.Name = "GlowOuter"
glowOuter.Size = UDim2.new(0, W+20, 0, H+20)
glowOuter.Position = UDim2.new(0.5, -(W+20)/2, 0.5, -(H+20)/2)
glowOuter.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glowOuter.BackgroundTransparency = 0.7
glowOuter.BorderSizePixel = 0
glowOuter.Visible = false
glowOuter.ZIndex = 1
glowOuter.Parent = screenGui
local glowOuterC = Instance.new("UICorner")
glowOuterC.CornerRadius = UDim.new(0, 22)
glowOuterC.Parent = glowOuter

local glowInner = Instance.new("Frame")
glowInner.Size = UDim2.new(0, W+8, 0, H+8)
glowInner.Position = UDim2.new(0.5, -(W+8)/2, 0.5, -(H+8)/2)
glowInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
glowInner.BackgroundTransparency = 0.55
glowInner.BorderSizePixel = 0
glowInner.Visible = false
glowInner.ZIndex = 2
glowInner.Parent = screenGui
local glowInnerC = Instance.new("UICorner")
glowInnerC.CornerRadius = UDim.new(0, 19)
glowInnerC.Parent = glowInner

-- Main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, W, 0, H)
mainFrame.Position = UDim2.new(0.5, -W/2, 0.5, -H/2)
mainFrame.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 3
mainFrame.Parent = screenGui
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 16)
mainCorner.Parent = mainFrame

-- Bordure bleue subtile
local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(255, 255, 255)
border.Thickness = 1.5
border.Transparency = 0.85
border.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
header.BorderSizePixel = 0
header.ZIndex = 4
header.Parent = mainFrame
local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header
local headerFix = Instance.new("Frame")
headerFix.Size = UDim2.new(1, 0, 0, 16)
headerFix.Position = UDim2.new(0, 0, 1, -16)
headerFix.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
headerFix.BorderSizePixel = 0
headerFix.ZIndex = 4
headerFix.Parent = header

-- Ligne bleue header
local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 2)
headerLine.Position = UDim2.new(0, 0, 1, -2)
headerLine.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
headerLine.BorderSizePixel = 0
headerLine.ZIndex = 5
headerLine.Parent = header

-- Glow sur la ligne header
local headerLineGlow = Instance.new("Frame")
headerLineGlow.Size = UDim2.new(1, 0, 0, 8)
headerLineGlow.Position = UDim2.new(0, 0, 1, -8)
headerLineGlow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
headerLineGlow.BackgroundTransparency = 0.7
headerLineGlow.BorderSizePixel = 0
headerLineGlow.ZIndex = 4
headerLineGlow.Parent = header

-- Icone + titre
local titleIcon = Instance.new("TextLabel")
titleIcon.Size = UDim2.new(0, 36, 0, 36)
titleIcon.Position = UDim2.new(0, 12, 0.5, -18)
titleIcon.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
titleIcon.BackgroundTransparency = 0.3
titleIcon.Text = "⚡"
titleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
titleIcon.TextSize = 16
titleIcon.Font = Enum.Font.GothamBold
titleIcon.ZIndex = 5
titleIcon.Parent = header
local titleIconC = Instance.new("UICorner")
titleIconC.CornerRadius = UDim.new(0, 8)
titleIconC.Parent = titleIcon

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(0, 200, 0, 22)
titleLbl.Position = UDim2.new(0, 56, 0, 8)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "ADMIN PANEL"
titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLbl.TextSize = 15
titleLbl.Font = Enum.Font.GothamBold
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex = 5
titleLbl.Parent = header

local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(0, 300, 0, 14)
subLbl.Position = UDim2.new(0, 57, 0, 30)
subLbl.BackgroundTransparency = 1
subLbl.Text = "Steal a Brainrot  ·  " .. player.Name
subLbl.TextColor3 = Color3.fromRGB(80, 80, 80)
subLbl.TextSize = 10
subLbl.Font = Enum.Font.Gotham
subLbl.TextXAlignment = Enum.TextXAlignment.Left
subLbl.ZIndex = 5
subLbl.Parent = header

-- Bouton fermer
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.BackgroundTransparency = 0.3
closeBtn.BorderSizePixel = 0
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 180, 180)
closeBtn.TextSize = 12
closeBtn.Font = Enum.Font.GothamBold
closeBtn.ZIndex = 5
closeBtn.Parent = header
local closeBtnCorner = Instance.new("UICorner")
closeBtnCorner.CornerRadius = UDim.new(0, 7)
closeBtnCorner.Parent = closeBtn

-- Content container
local content = Instance.new("Frame")
content.Size = UDim2.new(1, 0, 1, -50)
content.Position = UDim2.new(0, 0, 0, 50)
content.BackgroundTransparency = 1
content.ZIndex = 3
content.Parent = mainFrame

-- ─── SIDEBAR ────────────────────────────────────────────────
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, -10)
sidebar.Position = UDim2.new(0, 5, 0, 5)
sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 4
sidebar.Parent = content
local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 12)
sidebarCorner.Parent = sidebar
local sidebarStroke = Instance.new("UIStroke")
sidebarStroke.Color = Color3.fromRGB(255, 255, 255)
sidebarStroke.Thickness = 1
sidebarStroke.Transparency = 0.9
sidebarStroke.Parent = sidebar

local sidebarPad = Instance.new("UIPadding")
sidebarPad.PaddingTop = UDim.new(0, 6)
sidebarPad.PaddingBottom = UDim.new(0, 6)
sidebarPad.PaddingLeft = UDim.new(0, 5)
sidebarPad.PaddingRight = UDim.new(0, 5)
sidebarPad.Parent = sidebar

local sidebarLayout = Instance.new("UIListLayout")
sidebarLayout.Padding = UDim.new(0, 3)
sidebarLayout.Parent = sidebar

-- ─── CMD LIST ───────────────────────────────────────────────
local cmdPanel = Instance.new("Frame")
cmdPanel.Size = UDim2.new(0, 210, 1, -10)
cmdPanel.Position = UDim2.new(0, 150, 0, 5)
cmdPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
cmdPanel.BorderSizePixel = 0
cmdPanel.ZIndex = 4
cmdPanel.Parent = content
local cmdPanelCorner = Instance.new("UICorner")
cmdPanelCorner.CornerRadius = UDim.new(0, 12)
cmdPanelCorner.Parent = cmdPanel
local cmdStroke = Instance.new("UIStroke")
cmdStroke.Color = Color3.fromRGB(255, 255, 255)
cmdStroke.Thickness = 1
cmdStroke.Transparency = 0.9
cmdStroke.Parent = cmdPanel

local cmdPanelTitle = Instance.new("TextLabel")
cmdPanelTitle.Size = UDim2.new(1, -12, 0, 32)
cmdPanelTitle.Position = UDim2.new(0, 10, 0, 0)
cmdPanelTitle.BackgroundTransparency = 1
cmdPanelTitle.Text = "COMMANDS"
cmdPanelTitle.TextColor3 = Color3.fromRGB(80, 80, 80)
cmdPanelTitle.TextSize = 9
cmdPanelTitle.Font = Enum.Font.GothamBold
cmdPanelTitle.TextXAlignment = Enum.TextXAlignment.Left
cmdPanelTitle.ZIndex = 5
cmdPanelTitle.Parent = cmdPanel

local cmdScroll = Instance.new("ScrollingFrame")
cmdScroll.Size = UDim2.new(1, -8, 1, -38)
cmdScroll.Position = UDim2.new(0, 4, 0, 34)
cmdScroll.BackgroundTransparency = 1
cmdScroll.BorderSizePixel = 0
cmdScroll.ScrollBarThickness = 2
cmdScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
cmdScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
cmdScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
cmdScroll.ZIndex = 4
cmdScroll.Parent = cmdPanel

local cmdScrollPad = Instance.new("UIPadding")
cmdScrollPad.PaddingTop = UDim.new(0, 3)
cmdScrollPad.PaddingBottom = UDim.new(0, 3)
cmdScrollPad.PaddingLeft = UDim.new(0, 3)
cmdScrollPad.PaddingRight = UDim.new(0, 3)
cmdScrollPad.Parent = cmdScroll

local cmdScrollLayout = Instance.new("UIListLayout")
cmdScrollLayout.Padding = UDim.new(0, 3)
cmdScrollLayout.Parent = cmdScroll

-- ─── FORM PANEL ─────────────────────────────────────────────
local formPanel = Instance.new("Frame")
formPanel.Size = UDim2.new(1, -370, 1, -10)
formPanel.Position = UDim2.new(0, 365, 0, 5)
formPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
formPanel.BorderSizePixel = 0
formPanel.ZIndex = 4
formPanel.Parent = content
local formPanelCorner = Instance.new("UICorner")
formPanelCorner.CornerRadius = UDim.new(0, 12)
formPanelCorner.Parent = formPanel
local formStroke = Instance.new("UIStroke")
formStroke.Color = Color3.fromRGB(255, 255, 255)
formStroke.Thickness = 1
formStroke.Transparency = 0.9
formStroke.Parent = formPanel

local formScroll = Instance.new("ScrollingFrame")
formScroll.Size = UDim2.new(1, -8, 1, -8)
formScroll.Position = UDim2.new(0, 4, 0, 4)
formScroll.BackgroundTransparency = 1
formScroll.BorderSizePixel = 0
formScroll.ScrollBarThickness = 2
formScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
formScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
formScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
formScroll.ZIndex = 4
formScroll.Parent = formPanel

local formScrollPad = Instance.new("UIPadding")
formScrollPad.PaddingTop = UDim.new(0, 10)
formScrollPad.PaddingBottom = UDim.new(0, 10)
formScrollPad.PaddingLeft = UDim.new(0, 10)
formScrollPad.PaddingRight = UDim.new(0, 10)
formScrollPad.Parent = formScroll

local formScrollLayout = Instance.new("UIListLayout")
formScrollLayout.Padding = UDim.new(0, 7)
formScrollLayout.Parent = formScroll

-- ─── NOTIF FRAME ─────────────────────────────────────────────
local notifHolder = Instance.new("Frame")
notifHolder.Size = UDim2.new(0, 320, 0, 400)
notifHolder.Position = UDim2.new(1, -332, 1, -410)
notifHolder.BackgroundTransparency = 1
notifHolder.Parent = screenGui

local notifLayout = Instance.new("UIListLayout")
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 8)
notifLayout.Parent = notifHolder

-- ─── HUD BUTTON ──────────────────────────────────────────────
local hudBtn = Instance.new("TextButton")
hudBtn.Size = UDim2.new(0, 42, 0, 42)
hudBtn.Position = UDim2.new(1, -54, 0, 12)
hudBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
hudBtn.BorderSizePixel = 0
hudBtn.Text = "⚡"
hudBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hudBtn.TextSize = 18
hudBtn.Font = Enum.Font.GothamBold
hudBtn.Parent = screenGui
local hudCorner = Instance.new("UICorner")
hudCorner.CornerRadius = UDim.new(0, 12)
hudCorner.Parent = hudBtn
local hudStroke = Instance.new("UIStroke")
hudStroke.Color = Color3.fromRGB(255, 255, 255)
hudStroke.Thickness = 1.5
hudStroke.Parent = hudBtn

-- ============================================================
-- HELPERS
-- ============================================================

local function showNotif(text, success)
	local notif = Instance.new("Frame")
	notif.Size = UDim2.new(0, 320, 0, 64)
	notif.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
	notif.BorderSizePixel = 0
	notif.BackgroundTransparency = 0
	notif.ClipsDescendants = true
	notif.Parent = notifHolder

	local nc = Instance.new("UICorner")
	nc.CornerRadius = UDim.new(0, 12)
	nc.Parent = notif

	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1
	stroke.Transparency = 0.7
	stroke.Parent = notif

	-- Barre latérale blanche/grise
	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 3, 0.6, 0)
	bar.Position = UDim2.new(0, 0, 0.2, 0)
	bar.BackgroundColor3 = success and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 80, 85)
	bar.BorderSizePixel = 0
	bar.Parent = notif
	local barc = Instance.new("UICorner")
	barc.CornerRadius = UDim.new(0, 3)
	barc.Parent = bar

	-- Icone cercle
	local iconBg = Instance.new("Frame")
	iconBg.Size = UDim2.new(0, 32, 0, 32)
	iconBg.Position = UDim2.new(0, 14, 0.5, -16)
	iconBg.BackgroundColor3 = success and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(20, 20, 20)
	iconBg.BackgroundTransparency = success and 0.85 or 0.5
	iconBg.BorderSizePixel = 0
	iconBg.Parent = notif
	local iconBgC = Instance.new("UICorner")
	iconBgC.CornerRadius = UDim.new(1, 0)
	iconBgC.Parent = iconBg

	local icon = Instance.new("TextLabel")
	icon.Size = UDim2.new(1, 0, 1, 0)
	icon.BackgroundTransparency = 1
	icon.Text = success and "✓" or "✕"
	icon.TextColor3 = success and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 128)
	icon.TextSize = 14
	icon.Font = Enum.Font.GothamBold
	icon.Parent = iconBg

	-- Texte principal
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0, 220, 0, 18)
	label.Position = UDim2.new(0, 56, 0, 12)
	label.BackgroundTransparency = 1
	label.Text = success and "Command executed" or "Command failed"
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextSize = 13
	label.Font = Enum.Font.GothamBold
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = notif

	-- Sous-texte
	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(0, 240, 0, 16)
	sub.Position = UDim2.new(0, 56, 0, 34)
	sub.BackgroundTransparency = 1
	sub.Text = tostring(text)
	sub.TextColor3 = Color3.fromRGB(120, 120, 130)
	sub.TextSize = 10
	sub.Font = Enum.Font.Gotham
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.TextTruncate = Enum.TextTruncate.AtEnd
	sub.Parent = notif

	-- Barre de progression en bas
	local progressBg = Instance.new("Frame")
	progressBg.Size = UDim2.new(1, 0, 0, 2)
	progressBg.Position = UDim2.new(0, 0, 1, -2)
	progressBg.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	progressBg.BorderSizePixel = 0
	progressBg.Parent = notif

	local progress = Instance.new("Frame")
	progress.Size = UDim2.new(1, 0, 1, 0)
	progress.BackgroundColor3 = success and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(70, 70, 75)
	progress.BorderSizePixel = 0
	progress.Parent = progressBg
	local progressC = Instance.new("UICorner")
	progressC.CornerRadius = UDim.new(0, 2)
	progressC.Parent = progress

	-- Animation entrée depuis la droite
	notif.Position = UDim2.new(1, 10, 0, 0)
	TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	-- Progress bar animation
	TweenService:Create(progress, TweenInfo.new(3.5, Enum.EasingStyle.Linear), {
		Size = UDim2.new(0, 0, 1, 0)
	}):Play()

	task.delay(3.5, function()
		if notif and notif.Parent then
			TweenService:Create(notif, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {
				Position = UDim2.new(1, 10, 0, 0),
				BackgroundTransparency = 1
			}):Play()
			task.wait(0.3)
			if notif and notif.Parent then notif:Destroy() end
		end
	end)
end

local activeDropOverlay = nil

local function makeMultiDropdown(placeholder, options)
	local selected = {}
	local isOpen = false
	local myOverlay = nil

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	btn.BorderSizePixel = 0
	btn.Text = ""
	local btnC = Instance.new("UICorner")
	btnC.CornerRadius = UDim.new(0, 9)
	btnC.Parent = btn

	local btnTxt = Instance.new("TextLabel")
	btnTxt.Size = UDim2.new(1, -36, 1, 0)
	btnTxt.Position = UDim2.new(0, 10, 0, 0)
	btnTxt.BackgroundTransparency = 1
	btnTxt.Text = placeholder
	btnTxt.TextColor3 = Color3.fromRGB(100, 100, 100)
	btnTxt.TextSize = 11
	btnTxt.Font = Enum.Font.Gotham
	btnTxt.TextXAlignment = Enum.TextXAlignment.Left
	btnTxt.TextTruncate = Enum.TextTruncate.AtEnd
	btnTxt.Parent = btn

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 24, 1, 0)
	arrow.Position = UDim2.new(1, -28, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "▾"
	arrow.TextColor3 = Color3.fromRGB(70, 70, 70)
	arrow.TextSize = 11
	arrow.Font = Enum.Font.Gotham
	arrow.Parent = btn

	local function updateBtnText()
		if #selected == 0 then
			btnTxt.Text = placeholder
			btnTxt.TextColor3 = Color3.fromRGB(100, 100, 100)
		else
			btnTxt.Text = table.concat(selected, ", ")
			btnTxt.TextColor3 = Color3.fromRGB(94, 234, 141)
		end
	end

	local function closeOverlay()
		isOpen = false
		if myOverlay and myOverlay.Parent then
			myOverlay:Destroy()
		end
		myOverlay = nil
		if activeDropOverlay == myOverlay then activeDropOverlay = nil end
	end

	local function openOverlay()
		-- Fermer tout overlay existant
		if activeDropOverlay and activeDropOverlay.Parent then
			activeDropOverlay:Destroy()
			activeDropOverlay = nil
		end
		isOpen = true

		local absPos = btn.AbsolutePosition
		local absSize = btn.AbsoluteSize
		local h = math.min(#options, 8) * 30 + 46

		local overlay = Instance.new("Frame")
		overlay.Size = UDim2.new(0, absSize.X, 0, h)
		overlay.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
		overlay.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
		overlay.BorderSizePixel = 0
		overlay.ZIndex = 200
		overlay.ClipsDescendants = true
		overlay.Parent = screenGui
		local oc = Instance.new("UICorner")
		oc.CornerRadius = UDim.new(0, 9)
		oc.Parent = overlay

		myOverlay = overlay
		activeDropOverlay = overlay

		-- Barre de recherche
		local searchBox = Instance.new("TextBox")
		searchBox.Size = UDim2.new(1, -12, 0, 30)
		searchBox.Position = UDim2.new(0, 6, 0, 6)
		searchBox.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		searchBox.BorderSizePixel = 0
		searchBox.PlaceholderText = "🔍 Search..."
		searchBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)
		searchBox.Text = ""
		searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
		searchBox.TextSize = 11
		searchBox.Font = Enum.Font.Gotham
		searchBox.ClearTextOnFocus = false
		searchBox.ZIndex = 202
		searchBox.Parent = overlay
		local sc = Instance.new("UICorner")
		sc.CornerRadius = UDim.new(0, 7)
		sc.Parent = searchBox
		local sp = Instance.new("UIPadding")
		sp.PaddingLeft = UDim.new(0, 8)
		sp.Parent = searchBox

		local dropScroll = Instance.new("ScrollingFrame")
		dropScroll.Size = UDim2.new(1, 0, 1, -42)
		dropScroll.Position = UDim2.new(0, 0, 0, 42)
		dropScroll.BackgroundTransparency = 1
		dropScroll.BorderSizePixel = 0
		dropScroll.ScrollBarThickness = 2
		dropScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
		dropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		dropScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		dropScroll.ZIndex = 201
		dropScroll.Parent = overlay

		local dLayout = Instance.new("UIListLayout")
		dLayout.Padding = UDim.new(0, 2)
		dLayout.Parent = dropScroll
		local dPad = Instance.new("UIPadding")
		dPad.PaddingTop = UDim.new(0, 4)
		dPad.PaddingBottom = UDim.new(0, 4)
		dPad.PaddingLeft = UDim.new(0, 4)
		dPad.PaddingRight = UDim.new(0, 4)
		dPad.Parent = dropScroll

		local function buildOptions(filter)
			for _, c in ipairs(dropScroll:GetChildren()) do
				if c:IsA("TextButton") then c:Destroy() end
			end
			local fl = filter:lower()
			for _, opt in ipairs(options) do
				if fl == "" or opt:lower():find(fl, 1, true) then
					local isSel = table.find(selected, opt) ~= nil

					local ob = Instance.new("TextButton")
					ob.Size = UDim2.new(1, 0, 0, 28)
					ob.BackgroundColor3 = isSel and Color3.fromRGB(20, 20, 20) or Color3.fromRGB(18, 18, 18)
					ob.BackgroundTransparency = 0.2
					ob.BorderSizePixel = 0
					ob.Text = ""
					ob.ZIndex = 202
					ob.Parent = dropScroll
					local obc = Instance.new("UICorner")
					obc.CornerRadius = UDim.new(0, 6)
					obc.Parent = ob

					local check = Instance.new("TextLabel")
					check.Size = UDim2.new(0, 20, 1, 0)
					check.Position = UDim2.new(0, 6, 0, 0)
					check.BackgroundTransparency = 1
					check.Text = isSel and "✓" or ""
					check.TextColor3 = Color3.fromRGB(94, 234, 141)
					check.TextSize = 11
					check.Font = Enum.Font.GothamBold
					check.ZIndex = 203
					check.Parent = ob

					local optTxt = Instance.new("TextLabel")
					optTxt.Size = UDim2.new(1, -30, 1, 0)
					optTxt.Position = UDim2.new(0, 26, 0, 0)
					optTxt.BackgroundTransparency = 1
					optTxt.Text = opt
					optTxt.TextColor3 = isSel and Color3.fromRGB(94, 234, 141) or Color3.fromRGB(210, 210, 210)
					optTxt.TextSize = 11
					optTxt.Font = Enum.Font.Gotham
					optTxt.TextXAlignment = Enum.TextXAlignment.Left
					optTxt.ZIndex = 203
					optTxt.Parent = ob

					ob.MouseButton1Click:Connect(function()
						local idx = table.find(selected, opt)
						if idx then
							table.remove(selected, idx)
							ob.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
							check.Text = ""
							optTxt.TextColor3 = Color3.fromRGB(210, 210, 210)
						else
							table.insert(selected, opt)
							ob.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
							check.Text = "✓"
							optTxt.TextColor3 = Color3.fromRGB(94, 234, 141)
						end
						updateBtnText()
						-- Ne PAS fermer
					end)
				end
			end
		end

		buildOptions("")
		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			buildOptions(searchBox.Text)
		end)

		task.wait()
		searchBox:CaptureFocus()
	end

	btn.MouseButton1Click:Connect(function()
		if isOpen then
			closeOverlay()
		else
			openOverlay()
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if isOpen and myOverlay and myOverlay.Parent then
				local mousePos = UserInputService:GetMouseLocation()
				local op = myOverlay.AbsolutePosition
				local os = myOverlay.AbsoluteSize
				local inOverlay = mousePos.X >= op.X and mousePos.X <= op.X + os.X
					and mousePos.Y >= op.Y and mousePos.Y <= op.Y + os.Y
				local inBtn = mousePos.X >= btn.AbsolutePosition.X and mousePos.X <= btn.AbsolutePosition.X + btn.AbsoluteSize.X
					and mousePos.Y >= btn.AbsolutePosition.Y and mousePos.Y <= btn.AbsolutePosition.Y + btn.AbsoluteSize.Y
				if not inOverlay and not inBtn then
					closeOverlay()
				end
			end
		end
	end)

	local wrapper = {
		frame = btn,
		getValue = function() return #selected > 0 and selected or nil end,
		reset = function()
			selected = {}
			updateBtnText()
		end,
	}

	return wrapper
end

local function makeDropdown(placeholder, options)
	local selected = nil
	local isOpen = false
	local justSelected = false

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 36)
	btn.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	btn.BorderSizePixel = 0
	btn.Text = ""
	local btnC = Instance.new("UICorner")
	btnC.CornerRadius = UDim.new(0, 9)
	btnC.Parent = btn

	local btnTxt = Instance.new("TextLabel")
	btnTxt.Size = UDim2.new(1, -36, 1, 0)
	btnTxt.Position = UDim2.new(0, 10, 0, 0)
	btnTxt.BackgroundTransparency = 1
	btnTxt.Text = placeholder
	btnTxt.TextColor3 = Color3.fromRGB(100, 100, 100)
	btnTxt.TextSize = 12
	btnTxt.Font = Enum.Font.Gotham
	btnTxt.TextXAlignment = Enum.TextXAlignment.Left
	btnTxt.TextTruncate = Enum.TextTruncate.AtEnd
	btnTxt.Parent = btn

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 24, 1, 0)
	arrow.Position = UDim2.new(1, -28, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = "▾"
	arrow.TextColor3 = Color3.fromRGB(70, 70, 70)
	arrow.TextSize = 11
	arrow.Font = Enum.Font.Gotham
	arrow.Parent = btn

	local function closeOverlay()
		if activeDropOverlay and activeDropOverlay.Parent then
			activeDropOverlay:Destroy()
			activeDropOverlay = nil
		end
		isOpen = false
	end

	local function openOverlay()
		closeOverlay()
		isOpen = true

		local absPos = btn.AbsolutePosition
		local absSize = btn.AbsoluteSize
		local h = math.min(#options, 8) * 30 + 46 -- +46 pour la searchbar

		local overlay = Instance.new("Frame")
		overlay.Size = UDim2.new(0, absSize.X, 0, h)
		overlay.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
		overlay.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
		overlay.BorderSizePixel = 0
		overlay.ZIndex = 200
		overlay.ClipsDescendants = true
		overlay.Parent = screenGui
		local oc = Instance.new("UICorner")
		oc.CornerRadius = UDim.new(0, 9)
		oc.Parent = overlay

		activeDropOverlay = overlay

		-- Barre de recherche
		local searchBox = Instance.new("TextBox")
		searchBox.Size = UDim2.new(1, -12, 0, 30)
		searchBox.Position = UDim2.new(0, 6, 0, 6)
		searchBox.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
		searchBox.BorderSizePixel = 0
		searchBox.PlaceholderText = "🔍 Search..."
		searchBox.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)
		searchBox.Text = ""
		searchBox.TextColor3 = Color3.fromRGB(220, 220, 220)
		searchBox.TextSize = 11
		searchBox.Font = Enum.Font.Gotham
		searchBox.ClearTextOnFocus = false
		searchBox.ZIndex = 202
		searchBox.Parent = overlay
		local sc = Instance.new("UICorner")
		sc.CornerRadius = UDim.new(0, 7)
		sc.Parent = searchBox
		local sp = Instance.new("UIPadding")
		sp.PaddingLeft = UDim.new(0, 8)
		sp.Parent = searchBox

		local dropScroll = Instance.new("ScrollingFrame")
		dropScroll.Size = UDim2.new(1, 0, 1, -42)
		dropScroll.Position = UDim2.new(0, 0, 0, 42)
		dropScroll.BackgroundTransparency = 1
		dropScroll.BorderSizePixel = 0
		dropScroll.ScrollBarThickness = 2
		dropScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
		dropScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
		dropScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
		dropScroll.ZIndex = 201
		dropScroll.Parent = overlay

		local dLayout = Instance.new("UIListLayout")
		dLayout.Padding = UDim.new(0, 2)
		dLayout.Parent = dropScroll
		local dPad = Instance.new("UIPadding")
		dPad.PaddingTop = UDim.new(0, 4)
		dPad.PaddingBottom = UDim.new(0, 4)
		dPad.PaddingLeft = UDim.new(0, 4)
		dPad.PaddingRight = UDim.new(0, 4)
		dPad.Parent = dropScroll

		local optButtons = {}

		local function buildOptions(filter)
			for _, c in ipairs(dropScroll:GetChildren()) do
				if c:IsA("TextButton") then c:Destroy() end
			end
			local filtered = {}
			local fl = filter:lower()
			for _, opt in ipairs(options) do
				if fl == "" or opt:lower():find(fl, 1, true) then
					table.insert(filtered, opt)
				end
			end
			for _, opt in ipairs(filtered) do
				local ob = Instance.new("TextButton")
				ob.Size = UDim2.new(1, 0, 0, 28)
				ob.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				ob.BackgroundTransparency = 0.4
				ob.BorderSizePixel = 0
				ob.Text = opt
				ob.TextColor3 = Color3.fromRGB(210, 210, 210)
				ob.TextSize = 11
				ob.Font = Enum.Font.Gotham
				ob.TextXAlignment = Enum.TextXAlignment.Left
				ob.ZIndex = 202
				ob.Parent = dropScroll
				local obc = Instance.new("UICorner")
				obc.CornerRadius = UDim.new(0, 6)
				obc.Parent = ob
				local obp = Instance.new("UIPadding")
				obp.PaddingLeft = UDim.new(0, 8)
				obp.Parent = ob
				ob.MouseEnter:Connect(function()
					TweenService:Create(ob, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
				end)
				ob.MouseLeave:Connect(function()
					TweenService:Create(ob, TweenInfo.new(0.1), {BackgroundTransparency = 0.4}):Play()
				end)
				ob.MouseButton1Click:Connect(function()
					justSelected = true
					selected = opt
					btnTxt.Text = opt
					btnTxt.TextColor3 = Color3.fromRGB(230, 245, 255)
					closeOverlay()
					task.wait(0.1)
					justSelected = false
				end)
			end
		end

		buildOptions("")

		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			buildOptions(searchBox.Text)
		end)

		task.wait()
		searchBox:CaptureFocus()
	end

	btn.MouseButton1Click:Connect(function()
		if isOpen then
			closeOverlay()
		else
			openOverlay()
		end
	end)

	-- Fermer si on clique ailleurs
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			if justSelected then return end
			if isOpen and activeDropOverlay then
				local mousePos = UserInputService:GetMouseLocation()
				local overlayPos = activeDropOverlay.AbsolutePosition
				local overlaySize = activeDropOverlay.AbsoluteSize
				local inBounds = mousePos.X >= overlayPos.X and mousePos.X <= overlayPos.X + overlaySize.X
					and mousePos.Y >= overlayPos.Y and mousePos.Y <= overlayPos.Y + overlaySize.Y
				local inBtn = mousePos.X >= btn.AbsolutePosition.X and mousePos.X <= btn.AbsolutePosition.X + btn.AbsoluteSize.X
					and mousePos.Y >= btn.AbsolutePosition.Y and mousePos.Y <= btn.AbsolutePosition.Y + btn.AbsoluteSize.Y
				if not inBounds and not inBtn then
					closeOverlay()
				end
			end
		end
	end)

	local wrapper = {
		frame = btn,
		getValue = function() return selected end,
		setValue = function(v)
			selected = v
			btnTxt.Text = v or placeholder
			btnTxt.TextColor3 = v and Color3.fromRGB(230, 245, 255) or Color3.fromRGB(100, 100, 100)
		end,
		reset = function()
			selected = nil
			btnTxt.Text = placeholder
			btnTxt.TextColor3 = Color3.fromRGB(100, 100, 100)
		end,
		updateOptions = function(newList)
			options = newList
		end,
	}

	return wrapper
end

local function makeInput(placeholder, isNum)
	local tb = Instance.new("TextBox")
	tb.Size = UDim2.new(1, 0, 0, 36)
	tb.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
	tb.BorderSizePixel = 0
	tb.PlaceholderText = placeholder
	tb.PlaceholderColor3 = Color3.fromRGB(70, 70, 70)
	tb.Text = ""
	tb.TextColor3 = Color3.fromRGB(225, 240, 255)
	tb.TextSize = 12
	tb.Font = Enum.Font.Gotham
	tb.ClearTextOnFocus = false
	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(0, 9)
	tc.Parent = tb
	local tp = Instance.new("UIPadding")
	tp.PaddingLeft = UDim.new(0, 10)
	tp.Parent = tb
	tb.Focused:Connect(function()
		TweenService:Create(tb, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
	end)
	tb.FocusLost:Connect(function()
		TweenService:Create(tb, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(12, 12, 12)}):Play()
	end)
	return tb
end

local function makeBtn(text, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 40)
	b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	b.BorderSizePixel = 0
	b.Text = text
	b.TextColor3 = Color3.fromRGB(8, 8, 8)
	b.TextSize = 12
	b.Font = Enum.Font.GothamBold
	local bc = Instance.new("UICorner")
	bc.CornerRadius = UDim.new(0, 10)
	bc.Parent = b
	b.MouseEnter:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.1), {BackgroundTransparency = 0.1}):Play()
	end)
	b.MouseLeave:Connect(function()
		TweenService:Create(b, TweenInfo.new(0.1), {BackgroundTransparency = 0}):Play()
	end)
	return b
end

local function makeLbl(text, size, color, bold)
	local l = Instance.new("TextLabel")
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = color or Color3.fromRGB(180, 200, 220)
	l.TextSize = size or 12
	l.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
	l.TextXAlignment = Enum.TextXAlignment.Left
	return l
end

-- ============================================================
-- BUILD CATEGORY SIDEBAR
-- ============================================================

local function buildSidebar()
	for _, c in ipairs(sidebar:GetChildren()) do
		if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
	end
	catButtons = {}

	for i, cat in ipairs(CATEGORIES) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 44)
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0.97
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.Parent = sidebar
		local bc = Instance.new("UICorner")
		bc.CornerRadius = UDim.new(0, 10)
		bc.Parent = btn

		-- Indicateur gauche
		local ind = Instance.new("Frame")
		ind.Size = UDim2.new(0, 2, 0.55, 0)
		ind.Position = UDim2.new(0, 3, 0.225, 0)
		ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ind.BorderSizePixel = 0
		ind.BackgroundTransparency = 1
		ind.Parent = btn
		local indc = Instance.new("UICorner")
		indc.CornerRadius = UDim.new(1, 0)
		indc.Parent = ind

		-- Icon bg
		local iconBg = Instance.new("Frame")
		iconBg.Size = UDim2.new(0, 26, 0, 26)
		iconBg.Position = UDim2.new(0, 10, 0.5, -13)
		iconBg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		iconBg.BackgroundTransparency = 0.92
		iconBg.BorderSizePixel = 0
		iconBg.Parent = btn
		local iconBgC = Instance.new("UICorner")
		iconBgC.CornerRadius = UDim.new(0, 7)
		iconBgC.Parent = iconBg

		local iconL = Instance.new("TextLabel")
		iconL.Size = UDim2.new(1, 0, 1, 0)
		iconL.BackgroundTransparency = 1
		iconL.Text = cat.icon
		iconL.TextSize = 13
		iconL.Font = Enum.Font.GothamBold
		iconL.Parent = iconBg

		local nameL = Instance.new("TextLabel")
		nameL.Size = UDim2.new(1, -46, 1, 0)
		nameL.Position = UDim2.new(0, 42, 0, 0)
		nameL.BackgroundTransparency = 1
		nameL.Text = cat.name
		nameL.TextColor3 = Color3.fromRGB(120, 120, 120)
		nameL.TextSize = 11
		nameL.Font = Enum.Font.Gotham
		nameL.TextXAlignment = Enum.TextXAlignment.Left
		nameL.Parent = btn

		table.insert(catButtons, { btn = btn, ind = ind, nameL = nameL, iconBg = iconBg, color = cat.color })

		local idx = i
		btn.MouseEnter:Connect(function()
			if idx ~= currentCategory then
				TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.93}):Play()
			end
		end)
		btn.MouseLeave:Connect(function()
			if idx ~= currentCategory then
				TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.97}):Play()
			end
		end)
		btn.MouseButton1Click:Connect(function()
			selectCategory(idx)
		end)
	end
end

-- ============================================================
-- BUILD CMD LIST
-- ============================================================

local function buildCmdList(catIdx)
	for _, c in ipairs(cmdScroll:GetChildren()) do
		if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
	end
	cmdButtons = {}

	local cat = CATEGORIES[catIdx]
	if not cat then return end

	cmdPanelTitle.Text = cat.icon .. "  " .. string.upper(cat.name)
	cmdPanelTitle.TextColor3 = Color3.fromRGB(200, 200, 200)

	for i, cmd in ipairs(cat.commands) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, 0, 0, 52)
		btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0.97
		btn.BorderSizePixel = 0
		btn.Text = ""
		btn.Parent = cmdScroll
		local bc = Instance.new("UICorner")
		bc.CornerRadius = UDim.new(0, 10)
		bc.Parent = btn

		-- Accent gauche
		local acc = Instance.new("Frame")
		acc.Size = UDim2.new(0, 2, 0.5, 0)
		acc.Position = UDim2.new(0, 3, 0.25, 0)
		acc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		acc.BorderSizePixel = 0
		acc.BackgroundTransparency = 1
		acc.Parent = btn
		local accc = Instance.new("UICorner")
		accc.CornerRadius = UDim.new(1, 0)
		accc.Parent = acc

		local nl = Instance.new("TextLabel")
		nl.Size = UDim2.new(1, -14, 0, 20)
		nl.Position = UDim2.new(0, 12, 0, 9)
		nl.BackgroundTransparency = 1
		nl.Text = cmd.name
		nl.TextColor3 = Color3.fromRGB(220, 220, 220)
		nl.TextSize = 11
		nl.Font = Enum.Font.GothamBold
		nl.TextXAlignment = Enum.TextXAlignment.Left
		nl.Parent = btn

		local dl = Instance.new("TextLabel")
		dl.Size = UDim2.new(1, -14, 0, 14)
		dl.Position = UDim2.new(0, 12, 0, 31)
		dl.BackgroundTransparency = 1
		dl.Text = cmd.desc
		dl.TextColor3 = Color3.fromRGB(60, 60, 60)
		dl.TextSize = 9
		dl.Font = Enum.Font.Gotham
		dl.TextXAlignment = Enum.TextXAlignment.Left
		dl.Parent = btn

		table.insert(cmdButtons, { btn = btn, acc = acc, nl = nl })

		local cIdx = i
		btn.MouseEnter:Connect(function()
			if cIdx ~= currentCommand then
				TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.92}):Play()
				TweenService:Create(acc, TweenInfo.new(0.12), {BackgroundTransparency = 0.6}):Play()
			end
		end)
		btn.MouseLeave:Connect(function()
			if cIdx ~= currentCommand then
				TweenService:Create(btn, TweenInfo.new(0.12), {BackgroundTransparency = 0.97}):Play()
				TweenService:Create(acc, TweenInfo.new(0.12), {BackgroundTransparency = 1}):Play()
			end
		end)
		btn.MouseButton1Click:Connect(function()
			if currentCommand then
				local old = cmdButtons[currentCommand]
				if old then
					TweenService:Create(old.btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.97, BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(old.acc, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
					old.nl.TextColor3 = Color3.fromRGB(220, 220, 220)
				end
			end
			currentCommand = cIdx
			TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.88, BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(acc, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
			nl.TextColor3 = Color3.fromRGB(255, 255, 255)
			buildForm(cat, cmd)
		end)
	end
end

-- ============================================================
-- BUILD FORM
-- ============================================================

buildForm = function(cat, cmd)
	for _, c in ipairs(formScroll:GetChildren()) do
		if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
	end
	activeFormFields = {}

	-- Refresh lists
	playerList = {}
	for _, p in ipairs(Players:GetPlayers()) do table.insert(playerList, p.Name) end
	local ok1, ev = pcall(function() return GetEvents:InvokeServer() end)
	eventList = (ok1 and ev) and ev or {}
	local ok2, it = pcall(function() return GetItems:InvokeServer() end)
	itemList = (ok2 and it) and it or {}
	local ok3, br = pcall(function() return GetBrainrots:InvokeServer() end)
	brainrotList = (ok3 and br) and br or {}
	local ok4, lb = pcall(function() return GetLuckyBlocks:InvokeServer() end)
	luckyBlockList = (ok4 and lb) and lb or {}
	local ok5, mu = pcall(function() return GetMutations:InvokeServer() end)
	mutationList = (ok5 and mu) and mu or {"Normal"}
	local ok6, tr = pcall(function() return GetTraits:InvokeServer() end)
	traitList = (ok6 and tr) and tr or {}

	local lo = 0

	for _, field in ipairs(cmd.fields) do
		local widget
		if field.type == "player" then
			widget = makeDropdown("Select a player...", #playerList > 0 and playerList or {"(no player)"})
		elseif field.type == "event" then
			widget = makeDropdown("Select an event...", #eventList > 0 and eventList or {"(no event)"})
		elseif field.type == "item" then
			widget = makeDropdown("Select an item...", #itemList > 0 and itemList or {"(no item)"})
		elseif field.type == "brainrot" then
			widget = makeDropdown("Select a brainrot...", #brainrotList > 0 and brainrotList or {"(loading...)"})
		elseif field.type == "luckyblock" then
			widget = makeDropdown("Select a lucky block...", #luckyBlockList > 0 and luckyBlockList or {"(loading...)"})
		elseif field.type == "mutation" then
			widget = makeDropdown("Select a mutation...", #mutationList > 0 and mutationList or {"Normal"})
		elseif field.type == "traitsmulti" then
			widget = makeMultiDropdown("Select traits...", #traitList > 0 and traitList or {"(loading...)"})
		elseif field.type == "onoff" then
			widget = makeDropdown("On / Off", {"On", "Off"})
		elseif field.type == "bool" then
			widget = makeDropdown("true / false", {"true", "false"})
		elseif field.type == "number" then
			widget = makeInput(field.label .. (field.default and (" — default: " .. field.default) or ""))
		elseif field.type == "traits" then
			widget = makeInput("Ex: Fireworks, Speed, Taco")
		else
			widget = makeInput(field.label)
		end

		if field.default and type(widget) == "table" and widget.setValue then widget.setValue(field.default) end
		if field.default and type(widget) ~= "table" and widget:IsA("TextBox") then widget.Text = field.default end

		-- Le widget peut être une table (dropdown) ou une Instance (TextBox)
		local widgetFrame
		if type(widget) == "table" then
			widgetFrame = widget.frame
		else
			widgetFrame = widget
		end
		widgetFrame.Size = UDim2.new(1, 0, 0, 36)
		widgetFrame.LayoutOrder = lo; lo += 1
		widgetFrame.Parent = formScroll

		table.insert(activeFormFields, { field = field, widget = widget })
	end

	-- Spacer
	local sp2 = Instance.new("Frame")
	sp2.Size = UDim2.new(1, 0, 0, 6)
	sp2.BackgroundTransparency = 1
	sp2.LayoutOrder = lo; lo += 1
	sp2.Parent = formScroll

	-- Execute button
	local execBtn = makeBtn("▶  Execute  —  " .. cmd.name, cat.color)
	execBtn.LayoutOrder = lo
	execBtn.Parent = formScroll

	execBtn.MouseButton1Click:Connect(function()
		local args = {}
		local valid = true

		for _, entry in ipairs(activeFormFields) do
			local f = entry.field
			local w = entry.widget
			local value

			if type(w) == "table" and w.getValue then
				value = w.getValue()
			elseif typeof(w) == "Instance" and w:IsA("TextBox") then
				value = w.Text ~= "" and w.Text or nil
			end

			if not value and not f.optional then
				showNotif("Required field missing: " .. f.label, false)
				valid = false
				break
			end

			if value then
				if f.type == "number" then
					local n = tonumber(value)
					if not n then
						showNotif("Invalid numeric value: " .. f.label, false)
						valid = false
						break
					end
					args[f.key] = n
				elseif f.type == "traitsmulti" then
					args[f.key] = value -- déjà une table {trait1, trait2, ...}
				elseif f.type == "traits" then
					local t = {}
					for part in string.gmatch(value, "([^,]+)") do
						local trimmed = part:match("^%s*(.-)%s*$")
						if trimmed ~= "" then table.insert(t, trimmed) end
					end
					args[f.key] = #t > 0 and t or nil
				elseif f.type == "bool" then
					args[f.key] = value == "true"
				else
					args[f.key] = value
				end
			end
		end

		if valid then
			-- Flash feedback
			TweenService:Create(execBtn, TweenInfo.new(0.08), {BackgroundTransparency = 0.5}):Play()
			task.delay(0.08, function()
				if execBtn and execBtn.Parent then
					TweenService:Create(execBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
				end
			end)
			ExecuteCommand:FireServer(cmd.cmd, args)
		end
	end)
end

-- ============================================================
-- SELECT CATEGORY
-- ============================================================

function selectCategory(idx)
	currentCategory = idx
	currentCommand = nil

	for i, cb in ipairs(catButtons) do
		if i == idx then
			TweenService:Create(cb.btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.88, BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(cb.ind, TweenInfo.new(0.15), {BackgroundTransparency = 0}):Play()
			cb.nameL.TextColor3 = Color3.fromRGB(255, 255, 255)
			cb.nameL.Font = Enum.Font.GothamBold
			if cb.iconBg then
				TweenService:Create(cb.iconBg, TweenInfo.new(0.15), {BackgroundTransparency = 0.75}):Play()
			end
		else
			TweenService:Create(cb.btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.97, BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(cb.ind, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
			cb.nameL.TextColor3 = Color3.fromRGB(120, 120, 120)
			cb.nameL.Font = Enum.Font.Gotham
			if cb.iconBg then
				TweenService:Create(cb.iconBg, TweenInfo.new(0.15), {BackgroundTransparency = 0.92}):Play()
			end
		end
	end

	buildCmdList(idx)

	-- Clear form
	for _, c in ipairs(formScroll:GetChildren()) do
		if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
	end
	activeFormFields = {}

	local cat = CATEGORIES[idx]

	if cat and cat.isList then
		-- Afficher la liste des traits
		local ok, tr = pcall(function() return GetTraits:InvokeServer() end)
		local traits = (ok and tr) and tr or {}

		local title = makeLbl("✨  LISTE DES TRAITS  (" .. #traits .. ")", 13, Color3.fromRGB(250, 204, 21), true)
		title.Size = UDim2.new(1, 0, 0, 28)
		title.LayoutOrder = 0
		title.Parent = formScroll

		-- Case "Tous les traits" avec bouton copier
		local allFrame = Instance.new("Frame")
		allFrame.Size = UDim2.new(1, 0, 0, 54)
		allFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
		allFrame.BorderSizePixel = 0
		allFrame.LayoutOrder = 1
		allFrame.Parent = formScroll
		local allC = Instance.new("UICorner")
		allC.CornerRadius = UDim.new(0, 8)
		allC.Parent = allFrame

		local allTxt = Instance.new("TextBox")
		allTxt.Size = UDim2.new(1, -90, 1, -12)
		allTxt.Position = UDim2.new(0, 8, 0, 6)
		allTxt.BackgroundTransparency = 1
		allTxt.Text = table.concat(traits, ", ")
		allTxt.TextColor3 = Color3.fromRGB(210, 210, 210)
		allTxt.TextSize = 10
		allTxt.Font = Enum.Font.Gotham
		allTxt.TextXAlignment = Enum.TextXAlignment.Left
		allTxt.TextWrapped = true
		allTxt.MultiLine = true
		allTxt.ClearTextOnFocus = false
		allTxt.Parent = allFrame

		local copyAllBtn = Instance.new("TextButton")
		copyAllBtn.Size = UDim2.new(0, 76, 0, 30)
		copyAllBtn.Position = UDim2.new(1, -82, 0.5, -15)
		copyAllBtn.BackgroundColor3 = Color3.fromRGB(250, 204, 21)
		copyAllBtn.BorderSizePixel = 0
		copyAllBtn.Text = "📋 Tout"
		copyAllBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
		copyAllBtn.TextSize = 11
		copyAllBtn.Font = Enum.Font.GothamBold
		copyAllBtn.Parent = allFrame
		local copyAllC = Instance.new("UICorner")
		copyAllC.CornerRadius = UDim.new(0, 7)
		copyAllC.Parent = copyAllBtn
		copyAllBtn.MouseButton1Click:Connect(function()
			allTxt:CaptureFocus()
			allTxt.SelectionStart = 1
			allTxt.CursorPosition = #allTxt.Text + 1
			copyAllBtn.Text = "✓ Copié!"
			copyAllBtn.BackgroundColor3 = Color3.fromRGB(94, 234, 141)
			task.delay(1.5, function()
				if copyAllBtn and copyAllBtn.Parent then
					copyAllBtn.Text = "📋 Tout"
					copyAllBtn.BackgroundColor3 = Color3.fromRGB(250, 204, 21)
				end
			end)
		end)

		local sep = Instance.new("Frame")
		sep.Size = UDim2.new(1, 0, 0, 1)
		sep.BackgroundColor3 = Color3.fromRGB(25, 32, 55)
		sep.BorderSizePixel = 0
		sep.LayoutOrder = 2
		sep.Parent = formScroll

		for i, traitName in ipairs(traits) do
			local row = Instance.new("Frame")
			row.Size = UDim2.new(1, 0, 0, 30)
			row.BackgroundColor3 = i % 2 == 0 and Color3.fromRGB(16, 20, 36) or Color3.fromRGB(13, 16, 28)
			row.BorderSizePixel = 0
			row.LayoutOrder = i + 2
			row.Parent = formScroll
			local rc = Instance.new("UICorner")
			rc.CornerRadius = UDim.new(0, 6)
			rc.Parent = row

			local dot = Instance.new("TextLabel")
			dot.Size = UDim2.new(0, 20, 1, 0)
			dot.Position = UDim2.new(0, 6, 0, 0)
			dot.BackgroundTransparency = 1
			dot.Text = "•"
			dot.TextColor3 = Color3.fromRGB(250, 204, 21)
			dot.TextSize = 14
			dot.Font = Enum.Font.GothamBold
			dot.Parent = row

			local lbl = Instance.new("TextLabel")
			lbl.Size = UDim2.new(1, -80, 1, 0)
			lbl.Position = UDim2.new(0, 24, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Text = traitName
			lbl.TextColor3 = Color3.fromRGB(220, 220, 220)
			lbl.TextSize = 11
			lbl.Font = Enum.Font.Gotham
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.Parent = row

			local copyBtn = Instance.new("TextButton")
			copyBtn.Size = UDim2.new(0, 60, 0, 22)
			copyBtn.Position = UDim2.new(1, -66, 0.5, -11)
			copyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			copyBtn.BorderSizePixel = 0
			copyBtn.Text = "📋 Copier"
			copyBtn.TextColor3 = Color3.fromRGB(180, 200, 235)
			copyBtn.TextSize = 10
			copyBtn.Font = Enum.Font.Gotham
			copyBtn.Parent = row
			local copyC = Instance.new("UICorner")
			copyC.CornerRadius = UDim.new(0, 6)
			copyC.Parent = copyBtn

			-- TextBox invisible pour copier
			local hiddenTb = Instance.new("TextBox")
			hiddenTb.Size = UDim2.new(0, 1, 0, 1)
			hiddenTb.Position = UDim2.new(0, -999, 0, 0)
			hiddenTb.BackgroundTransparency = 1
			hiddenTb.Text = traitName
			hiddenTb.TextTransparency = 1
			hiddenTb.ClearTextOnFocus = false
			hiddenTb.Parent = row

			copyBtn.MouseButton1Click:Connect(function()
				hiddenTb:CaptureFocus()
				hiddenTb.SelectionStart = 1
				hiddenTb.CursorPosition = #hiddenTb.Text + 1
				copyBtn.Text = "✓"
				copyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				copyBtn.TextColor3 = Color3.fromRGB(94, 234, 141)
				task.delay(1.5, function()
					if copyBtn and copyBtn.Parent then
						copyBtn.Text = "📋 Copier"
						copyBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
						copyBtn.TextColor3 = Color3.fromRGB(180, 200, 235)
					end
				end)
			end)
		end
	else
		local ph = makeLbl("← Select a command", 13, Color3.fromRGB(70, 70, 70))
		ph.Size = UDim2.new(1, 0, 0, 30)
		ph.TextXAlignment = Enum.TextXAlignment.Center
		ph.LayoutOrder = 0
		ph.Parent = formScroll
	end

	-- Brainrot Count panel
	if cat and cat.isCount then
		for _, c in ipairs(formScroll:GetChildren()) do
			if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
		end

		local loadingLbl = makeLbl("Loading brainrot data...", 12, Color3.fromRGB(100, 100, 100))
		loadingLbl.Size = UDim2.new(1, 0, 0, 24)
		loadingLbl.TextXAlignment = Enum.TextXAlignment.Center
		loadingLbl.LayoutOrder = 0
		loadingLbl.Parent = formScroll

		task.spawn(function()
			local ok, data = pcall(function() return GetBrainrotData:InvokeServer() end)
			if not ok or not data then
				if loadingLbl and loadingLbl.Parent then
					loadingLbl.Text = "Failed to load data."
				end
				return
			end
			if loadingLbl and loadingLbl.Parent then loadingLbl:Destroy() end

			-- Trier les rarités
			local RARITY_ORDER = {"Secret", "Mythic", "OG", "Legendary", "Epic", "Rare", "Uncommon", "Common"}
			local lo = 0
			local selectedRarity = nil
			local selectedBrainrot = nil

			local showRarities
			local showRarity
			local showBrainrotDetail

			local function clearForm()
				for _, c in ipairs(formScroll:GetChildren()) do
					if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end
				end
				lo = 0
			end

			showBrainrotDetail = function(brainrot)
				clearForm()

				-- Back button
				local backBtn = Instance.new("TextButton")
				backBtn.Size = UDim2.new(1, 0, 0, 30)
				backBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				backBtn.BorderSizePixel = 0
				backBtn.Text = "← Back to " .. selectedRarity
				backBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
				backBtn.TextSize = 11
				backBtn.Font = Enum.Font.Gotham
				backBtn.LayoutOrder = lo; lo += 1
				backBtn.Parent = formScroll
				local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(0,8); bbc.Parent = backBtn

				-- Titre
				local titleLbl = makeLbl(brainrot.displayName, 15, Color3.fromRGB(255,255,255), true)
				titleLbl.Size = UDim2.new(1, 0, 0, 26)
				titleLbl.LayoutOrder = lo; lo += 1
				titleLbl.Parent = formScroll

				-- Total
				local total = 0
				for _, n in pairs(brainrot.counts) do total += n end
				local totalLbl = makeLbl("Total in server: " .. total, 11, Color3.fromRGB(180,180,180))
				totalLbl.Size = UDim2.new(1, 0, 0, 18)
				totalLbl.LayoutOrder = lo; lo += 1
				totalLbl.Parent = formScroll

				-- Séparateur
				local sep = Instance.new("Frame")
				sep.Size = UDim2.new(1, 0, 0, 1)
				sep.BackgroundColor3 = Color3.fromRGB(30,30,30)
				sep.BorderSizePixel = 0
				sep.LayoutOrder = lo; lo += 1
				sep.Parent = formScroll

				if total == 0 then
					local none = makeLbl("None in any player base.", 11, Color3.fromRGB(60,60,60))
					none.Size = UDim2.new(1, 0, 0, 20)
					none.LayoutOrder = lo; lo += 1
					none.Parent = formScroll
				else
					-- Trier mutations
					local mutList = {}
					for mut, count in pairs(brainrot.counts) do
						table.insert(mutList, {mut = mut, count = count})
					end
					table.sort(mutList, function(a, b) return a.count > b.count end)

					for _, entry in ipairs(mutList) do
						local row = Instance.new("Frame")
						row.Size = UDim2.new(1, 0, 0, 30)
						row.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
						row.BorderSizePixel = 0
						row.LayoutOrder = lo; lo += 1
						row.Parent = formScroll
						local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0,7); rc.Parent = row

						local mutLbl = Instance.new("TextLabel")
						mutLbl.Size = UDim2.new(0.7, 0, 1, 0)
						mutLbl.Position = UDim2.new(0, 10, 0, 0)
						mutLbl.BackgroundTransparency = 1
						mutLbl.Text = entry.mut
						mutLbl.TextColor3 = Color3.fromRGB(200, 200, 200)
						mutLbl.TextSize = 11
						mutLbl.Font = Enum.Font.Gotham
						mutLbl.TextXAlignment = Enum.TextXAlignment.Left
						mutLbl.Parent = row

						local countLbl = Instance.new("TextLabel")
						countLbl.Size = UDim2.new(0.3, -10, 1, 0)
						countLbl.Position = UDim2.new(0.7, 0, 0, 0)
						countLbl.BackgroundTransparency = 1
						countLbl.Text = "x" .. entry.count
						countLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
						countLbl.TextSize = 12
						countLbl.Font = Enum.Font.GothamBold
						countLbl.TextXAlignment = Enum.TextXAlignment.Right
						countLbl.Parent = row

						local rp = Instance.new("UIPadding")
						rp.PaddingRight = UDim.new(0, 10)
						rp.Parent = countLbl
					end
				end

				backBtn.MouseButton1Click:Connect(function()
					showRarity(selectedRarity)
				end)
			end

			showRarity = function(rarity)
				selectedRarity = rarity
				clearForm()
				local rarityData = data[rarity] or {}

				-- Back button
				local backBtn = Instance.new("TextButton")
				backBtn.Size = UDim2.new(1, 0, 0, 30)
				backBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				backBtn.BorderSizePixel = 0
				backBtn.Text = "← Back to rarities"
				backBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
				backBtn.TextSize = 11
				backBtn.Font = Enum.Font.Gotham
				backBtn.LayoutOrder = lo; lo += 1
				backBtn.Parent = formScroll
				local bbc = Instance.new("UICorner"); bbc.CornerRadius = UDim.new(0,8); bbc.Parent = backBtn

				local titleLbl = makeLbl(rarity .. "  (" .. #rarityData .. ")", 14, Color3.fromRGB(255,255,255), true)
				titleLbl.Size = UDim2.new(1, 0, 0, 24)
				titleLbl.LayoutOrder = lo; lo += 1
				titleLbl.Parent = formScroll

				for _, brainrot in ipairs(rarityData) do
					local total = 0
					for _, n in pairs(brainrot.counts) do total += n end

					local btn = Instance.new("TextButton")
					btn.Size = UDim2.new(1, 0, 0, 32)
					btn.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
					btn.BackgroundTransparency = 0
					btn.BorderSizePixel = 0
					btn.Text = ""
					btn.LayoutOrder = lo; lo += 1
					btn.Parent = formScroll
					local bc2 = Instance.new("UICorner"); bc2.CornerRadius = UDim.new(0,8); bc2.Parent = btn

					local nameLbl = Instance.new("TextLabel")
					nameLbl.Size = UDim2.new(0.75, 0, 1, 0)
					nameLbl.Position = UDim2.new(0, 10, 0, 0)
					nameLbl.BackgroundTransparency = 1
					nameLbl.Text = brainrot.displayName
					nameLbl.TextColor3 = total > 0 and Color3.fromRGB(220,220,220) or Color3.fromRGB(60,60,60)
					nameLbl.TextSize = 11
					nameLbl.Font = Enum.Font.Gotham
					nameLbl.TextXAlignment = Enum.TextXAlignment.Left
					nameLbl.Parent = btn

					local countLbl2 = Instance.new("TextLabel")
					countLbl2.Size = UDim2.new(0.25, -10, 1, 0)
					countLbl2.Position = UDim2.new(0.75, 0, 0, 0)
					countLbl2.BackgroundTransparency = 1
					countLbl2.Text = total > 0 and ("x"..total) or "—"
					countLbl2.TextColor3 = total > 0 and Color3.fromRGB(255,255,255) or Color3.fromRGB(40,40,40)
					countLbl2.TextSize = 11
					countLbl2.Font = Enum.Font.GothamBold
					countLbl2.TextXAlignment = Enum.TextXAlignment.Right
					countLbl2.Parent = btn
					local rp2 = Instance.new("UIPadding"); rp2.PaddingRight = UDim.new(0,8); rp2.Parent = countLbl2

					btn.MouseEnter:Connect(function()
						TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22,22,22)}):Play()
					end)
					btn.MouseLeave:Connect(function()
						TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(14,14,14)}):Play()
					end)
					local br = brainrot
					btn.MouseButton1Click:Connect(function()
						selectedBrainrot = br
						showBrainrotDetail(br)
					end)
				end

				backBtn.MouseButton1Click:Connect(function()
					showRarities()
				end)
			end

			showRarities = function()
				clearForm()
				-- Titre + refresh
				local headerRow = Instance.new("Frame")
				headerRow.Size = UDim2.new(1, 0, 0, 28)
				headerRow.BackgroundTransparency = 1
				headerRow.LayoutOrder = lo; lo += 1
				headerRow.Parent = formScroll

				local titleLbl2 = Instance.new("TextLabel")
				titleLbl2.Size = UDim2.new(1, -70, 1, 0)
				titleLbl2.BackgroundTransparency = 1
				titleLbl2.Text = "📊  BRAINROT COUNT"
				titleLbl2.TextColor3 = Color3.fromRGB(255, 255, 255)
				titleLbl2.TextSize = 13
				titleLbl2.Font = Enum.Font.GothamBold
				titleLbl2.TextXAlignment = Enum.TextXAlignment.Left
				titleLbl2.Parent = headerRow

				local refreshBtn = Instance.new("TextButton")
				refreshBtn.Size = UDim2.new(0, 62, 0, 22)
				refreshBtn.Position = UDim2.new(1, -64, 0.5, -11)
				refreshBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				refreshBtn.BorderSizePixel = 0
				refreshBtn.Text = "↻ Refresh"
				refreshBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
				refreshBtn.TextSize = 10
				refreshBtn.Font = Enum.Font.Gotham
				refreshBtn.Parent = headerRow
				local rbc = Instance.new("UICorner"); rbc.CornerRadius = UDim.new(0, 7); rbc.Parent = refreshBtn
				local rbs = Instance.new("UIStroke"); rbs.Color = Color3.fromRGB(255,255,255); rbs.Thickness = 1; rbs.Transparency = 0.85; rbs.Parent = refreshBtn

				refreshBtn.MouseButton1Click:Connect(function()
					refreshBtn.Text = "Loading..."
					refreshBtn.TextColor3 = Color3.fromRGB(100, 100, 100)
					task.spawn(function()
						local ok2, newData = pcall(function() return GetBrainrotData:InvokeServer() end)
						if ok2 and newData then
							data = newData
						end
						showRarities()
					end)
				end)

				for _, rarity in ipairs(RARITY_ORDER) do
					local rarityData = data[rarity]
					if rarityData and #rarityData > 0 then
						local total = 0
						for _, br in ipairs(rarityData) do
							for _, n in pairs(br.counts) do total += n end
						end

						local btn = Instance.new("TextButton")
						btn.Size = UDim2.new(1, 0, 0, 38)
						btn.BackgroundColor3 = Color3.fromRGB(14, 14, 14)
						btn.BorderSizePixel = 0
						btn.Text = ""
						btn.LayoutOrder = lo; lo += 1
						btn.Parent = formScroll
						local bc3 = Instance.new("UICorner"); bc3.CornerRadius = UDim.new(0,10); bc3.Parent = btn
						local bs = Instance.new("UIStroke"); bs.Color = Color3.fromRGB(255,255,255); bs.Thickness = 1; bs.Transparency = 0.9; bs.Parent = btn

						local rarLbl = Instance.new("TextLabel")
						rarLbl.Size = UDim2.new(0.6, 0, 1, 0)
						rarLbl.Position = UDim2.new(0, 12, 0, 0)
						rarLbl.BackgroundTransparency = 1
						rarLbl.Text = rarity
						rarLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
						rarLbl.TextSize = 12
						rarLbl.Font = Enum.Font.GothamBold
						rarLbl.TextXAlignment = Enum.TextXAlignment.Left
						rarLbl.Parent = btn

						local subLbl2 = Instance.new("TextLabel")
						subLbl2.Size = UDim2.new(0.4, -12, 1, 0)
						subLbl2.Position = UDim2.new(0.6, 0, 0, 0)
						subLbl2.BackgroundTransparency = 1
						subLbl2.Text = #rarityData .. " types  ·  x" .. total
						subLbl2.TextColor3 = Color3.fromRGB(100, 100, 100)
						subLbl2.TextSize = 10
						subLbl2.Font = Enum.Font.Gotham
						subLbl2.TextXAlignment = Enum.TextXAlignment.Right
						subLbl2.Parent = btn
						local rp3 = Instance.new("UIPadding"); rp3.PaddingRight = UDim.new(0,10); rp3.Parent = subLbl2

						btn.MouseEnter:Connect(function()
							TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(22,22,22)}):Play()
						end)
						btn.MouseLeave:Connect(function()
							TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(14,14,14)}):Play()
						end)
						local r = rarity
						btn.MouseButton1Click:Connect(function()
							showRarity(r)
						end)
					end
				end
			end

			showRarities()
		end)
	end
end

-- ============================================================
-- TOGGLE PANEL
-- ============================================================

local function togglePanel()
	local visible = not mainFrame.Visible

	if visible then
		mainFrame.Visible = true
		glowOuter.Visible = true
		glowInner.Visible = true
		mainFrame.Size = UDim2.new(0, W, 0, 0)
		mainFrame.BackgroundTransparency = 1
		TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, W, 0, H),
			BackgroundTransparency = 0
		}):Play()
	else
		TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
			Size = UDim2.new(0, W, 0, 0),
			BackgroundTransparency = 1
		}):Play()
		task.delay(0.22, function()
			mainFrame.Visible = false
			glowOuter.Visible = false
			glowInner.Visible = false
		end)
	end
end

-- ============================================================
-- INPUT & DRAG
-- ============================================================

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.H then
		togglePanel()
	end
end)

closeBtn.MouseButton1Click:Connect(togglePanel)
hudBtn.MouseButton1Click:Connect(togglePanel)

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = true
		dragOffset = Vector2.new(
			mouse.X - mainFrame.AbsolutePosition.X,
			mouse.Y - mainFrame.AbsolutePosition.Y
		)
	end
end)
header.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		isDragging = false
	end
end)

RunService.RenderStepped:Connect(function()
	if isDragging and mainFrame.Visible then
		local vp = workspace.CurrentCamera.ViewportSize
		local nx = math.clamp(mouse.X - dragOffset.X, 0, vp.X - mainFrame.AbsoluteSize.X)
		local ny = math.clamp(mouse.Y - dragOffset.Y, 0, vp.Y - mainFrame.AbsoluteSize.Y)
		mainFrame.Position = UDim2.new(0, nx, 0, ny)
		glowOuter.Position = UDim2.new(0, nx - 10, 0, ny - 10)
		glowInner.Position = UDim2.new(0, nx - 4, 0, ny - 4)
	end
end)

-- ============================================================
-- COMMAND RESULT
-- ============================================================

CommandResult.OnClientEvent:Connect(function(success, message)
	showNotif(tostring(message), success == true)
end)

-- ============================================================
-- HUD PULSE ANIMATION
-- ============================================================

task.spawn(function()
	while true do
		TweenService:Create(hudBtn, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		TweenService:Create(hudStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0}):Play()
		task.wait(1.5)
		TweenService:Create(hudBtn, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
		TweenService:Create(hudStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.5}):Play()
		task.wait(1.5)
	end
end)

-- ============================================================
-- INIT
-- ============================================================

print("[AdminClient] buildSidebar...")
buildSidebar()
print("[AdminClient] selectCategory...")
selectCategory(1)
print("[AdminClient] INIT TERMINÉ ✅")