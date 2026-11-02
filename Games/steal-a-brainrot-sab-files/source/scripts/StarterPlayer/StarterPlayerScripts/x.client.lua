

local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService  = game:GetService("UserInputService")
local TweenService      = game:GetService("TweenService")
local RunService        = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse  = player:GetMouse()
print("[AdminClient] Démarrage...")

local AdminFolder = ReplicatedStorage:WaitForChild("AdminSystem", 60)
if not AdminFolder then return end

local CheckAdmin      = AdminFolder:WaitForChild("CheckAdmin")
local ExecuteCommand  = AdminFolder:WaitForChild("ExecuteCommand")
local CommandResult   = AdminFolder:WaitForChild("CommandResult")
local GetEvents       = AdminFolder:WaitForChild("GetEvents")
local GetItems        = AdminFolder:WaitForChild("GetItems")
local GetBrainrots    = AdminFolder:WaitForChild("GetBrainrots")
local GetLuckyBlocks  = AdminFolder:WaitForChild("GetLuckyBlocks")
local GetMutations    = AdminFolder:WaitForChild("GetMutations")
local GetTraits       = AdminFolder:WaitForChild("GetTraits")
local GetBrainrotData = AdminFolder:WaitForChild("GetBrainrotData")
local GetBaseSkins    = AdminFolder:FindFirstChild("GetBaseSkins")

task.wait(2)
local isAdmin = CheckAdmin:InvokeServer()
if not isAdmin then return end

-- ============================================================
-- CATEGORIES
-- ============================================================
local CATEGORIES = {
	{ name="Spawn",      icon="⚡", color=Color3.fromRGB(255,200,50),
		commands={
			{ name="Add Brainrot",          cmd="addbrainrot",             desc="Add a brainrot to a player",         fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}}},
			{ name="Spawn Brainrot",        cmd="spawnbrainrot",           desc="Spawn locally in the world",         fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}}},
			{ name="Spawn Global",          cmd="spawnglobalbrainrot",     desc="Spawn on ALL servers",               fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"},{label="Traits",key="traits",type="traitsmulti",optional=true}}},
			{ name="Add Lucky Block",       cmd="addluckyblock",           desc="Give a lucky block to a player",     fields={{label="Player",key="player",type="player"},{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
			{ name="Spawn Lucky Block",     cmd="spawnluckyblock",         desc="Spawn a lucky block locally",        fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
			{ name="Spawn Global Lucky",    cmd="spawngloballuckyblock",   desc="Spawn lucky blocks everywhere",      fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Amount",key="amount",type="number",default="1"},{label="Mutation",key="mutation",type="mutation",optional=true}}},
			{ name="Spawn All Traits",      cmd="spawnbrainrotalltraits",  desc="Spawn with all traits",              fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
			{ name="Random Secret",         cmd="randomsecret",            desc="Spawn a random secret",              fields={}},
			{ name="Random Spooky",         cmd="randomspooky",            desc="Spawn a random spooky",              fields={}},
			{ name="Random Limited Global", cmd="randomLimitedBrainrotGlobal",desc="Spawn random limited everywhere", fields={}},
			{ name="Spawn Random Server",   cmd="spawnrandomserverbrainrot",desc="Spawn random on each server",       fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Amount",key="amount",type="number",default="1"}}},
			{ name="Brainrot Grab",         cmd="brainrotgrab",            desc="Grab a brainrot for a player",       fields={{label="Brainrot",key="brainrot",type="brainrot"},{label="Target player",key="player",type="player"}}},
		}},
	{ name="Joueurs",    icon="👤", color=Color3.fromRGB(100,200,255),
		commands={
			{ name="Kick",                  cmd="kick",              desc="Kick a player",              fields={{label="Player",key="player",type="player"}}},
			{ name="Ban",                   cmd="ban",               desc="Ban a player",               fields={{label="Player name",key="player",type="text"},{label="Reason",key="reason",type="text"}}},
			{ name="Unban",                 cmd="unban",             desc="Unban a player",             fields={{label="Player name",key="player",type="text"}}},
			{ name="Set Money",             cmd="setmoney",          desc="Set money",                  fields={{label="Player",key="player",type="player"},{label="Amount",key="amount",type="number"}}},
			{ name="Set Rebirth",           cmd="setrebirth",        desc="Set rebirth",                fields={{label="Player",key="player",type="player"},{label="Rebirth",key="rebirth",type="number"}}},
			{ name="Set Name",              cmd="setname",           desc="Change display name",        fields={{label="Player",key="player",type="player"},{label="New name",key="name",type="text"}}},
			{ name="Add Spins",             cmd="addspins",          desc="Add divine spins",           fields={{label="Player",key="player",type="player"},{label="Amount",key="spins",type="number"}}},
			{ name="Add Luck",              cmd="addluck",           desc="Activate luck (1=2x,2=4x)", fields={{label="Index (1=2x|2=4x)",key="luck",type="number"}}},
			{ name="End Luck",              cmd="endluck",           desc="Stop luck",                  fields={}},
			{ name="Add Lucky Block (Player)",cmd="addluckyblock",   desc="Give lucky block to player", fields={{label="Player",key="player",type="player"},{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
		}},
	{ name="Events",     icon="🗓️", color=Color3.fromRGB(120,180,255),
		commands={
			{ name="Execute Event",        cmd="executeevent",      desc="Start a local event",        fields={{label="Event",key="event",type="event"},{label="Duration (s)",key="duration",type="number",optional=true}}},
			{ name="Execute Global Event", cmd="executeglobalevent",desc="Start event on all servers", fields={{label="Event",key="event",type="event"},{label="Duration (s)",key="duration",type="number",optional=true}}},
			{ name="Cancel Event",         cmd="cancelevent",       desc="Cancel a local event",       fields={{label="Event",key="event",type="event"}}},
			{ name="Cancel Global Event",  cmd="cancelglobalevent", desc="Cancel event everywhere",    fields={{label="Event (empty=all)",key="event",type="event",optional=true}}},
			{ name="Fuse Reveal Global",   cmd="globalfusereveal",  desc="Reveal all fusions",         fields={}},
		}},
	{ name="Modération", icon="🛡️", color=Color3.fromRGB(255,100,100),
		commands={
			{ name="Hit Protection",        cmd="hitprotection",    desc="Hit protection on/off",      fields={{label="Player",key="player",type="player"},{label="State",key="state",type="onoff"}}},
			{ name="Steal Protection",      cmd="stealprotection",  desc="Steal protection on/off",    fields={{label="Player",key="player",type="player"},{label="State",key="state",type="onoff"}}},
			{ name="Reset Data Player",     cmd="resetdata",        desc="⚠ Reset player data",        fields={{label="Player name",key="player",type="text"}}},
			{ name="Reset Data + Base",     cmd="resetdatafull",    desc="⚠ Reset data + clear base",  fields={{label="Player name",key="player",type="text"}}},
			{ name="Wipe Self",             cmd="wipeself",         desc="Reset your own data",        fields={}},
		}},
	{ name="Force TP",   icon="🔀", color=Color3.fromRGB(180,100,255),
		commands={
			{ name="Force Speed",           cmd="forcespeed",       desc="Force speed (0=reset)",      fields={{label="Player",key="player",type="player"},{label="Speed (0=reset)",key="speed",type="number"}}},
			{ name="Base Position",         cmd="baseposition",     desc="Change base position",       fields={{label="Player",key="player",type="player"},{label="Position (1-8)",key="position",type="number"}}},
			{ name="Nuke Base",             cmd="NukeBase",         desc="Nuke base (false=restore)",  fields={{label="Player",key="player",type="player"},{label="Explode?",key="explode",type="bool",default="true"}}},
			{ name="Clear Base",            cmd="clearbase",        desc="Clear own base",             fields={}},
		}},
	{ name="Annonces",   icon="📢", color=Color3.fromRGB(255,180,50), isAnnounce=true, commands={}},
	{ name="Give",       icon="🎁", color=Color3.fromRGB(80,200,120),
		commands={
			{ name="Give Item",             cmd="giveitem",         desc="Give an item",               fields={{label="Player",key="player",type="player"},{label="Item",key="item",type="item"}}},
			{ name="Remove Item",           cmd="removeitem",       desc="Remove an item",             fields={{label="Player",key="player",type="player"},{label="Item name",key="item",type="text"}}},
			{ name="Force Lucky Brainrot",  cmd="forceluckybrainrot",desc="Force next lucky",          fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"}}},
			{ name="Force Fuse",            cmd="forcefuse",        desc="Force fusion",               fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Traits",key="traits",type="traitsmulti",optional=true}}},
			{ name="Unlock Index",          cmd="unlockindex",      desc="Unlock index",               fields={{label="Player",key="player",type="player"},{label="Mutation (opt.)",key="mutation",type="text",optional=true}}},
			{ name="Set Base Skin",         cmd="setbaseskin",      desc="Change base skin",           fields={{label="Player",key="player",type="player"},{label="Skin",key="skin",type="skin"}}},
		}},
	{ name="Troll",      icon="😈", color=Color3.fromRGB(255,80,80),
		commands={
			{ name="Morph Brainrot",        cmd="morphbrainrot",    desc="Transforme un joueur en brainrot",    fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true}}},
			{ name="Morph Player",          cmd="morph",            desc="Morphe en un autre joueur",           fields={{label="Player",key="player",type="player"},{label="Pseudo Roblox cible",key="user",type="text"}}},
		}},
	{ name="Items",      icon="🎒", color=Color3.fromRGB(255,160,60),
		commands={
			{ name="Give Item",             cmd="giveitem",         desc="Give an item to a player",   fields={{label="Player",key="player",type="player"},{label="Item",key="item",type="item"}}},
			{ name="Remove Item",           cmd="removeitem",       desc="Remove an item",             fields={{label="Player",key="player",type="player"},{label="Item name",key="item",type="text"}}},
		}},
	{ name="Bases",      icon="🏠", color=Color3.fromRGB(100,220,180),
		commands={
			{ name="Clear Base",            cmd="clearbase",        desc="Clear own base",             fields={}},
			{ name="Nuke Base",             cmd="NukeBase",         desc="Nuke base",                  fields={{label="Player",key="player",type="player"},{label="Explode?",key="explode",type="bool",default="true"}}},
			{ name="Base Position",         cmd="baseposition",     desc="Change base position",       fields={{label="Player",key="player",type="player"},{label="Position (1-8)",key="position",type="number"}}},
			{ name="Set Base Skin",         cmd="setbaseskin",      desc="Change base skin",           fields={{label="Player",key="player",type="player"},{label="Skin",key="skin",type="skin"}}},
		}},
	{ name="Stats",      icon="📊", color=Color3.fromRGB(255,255,255), isCount=true, commands={}},
	{ name="RANDOM",     icon="🎲", color=Color3.fromRGB(255,100,200),
		commands={
			{ name="Random Secret",         cmd="randomsecret",    desc="Spawn a random secret",       fields={}},
			{ name="Random Spooky",         cmd="randomspooky",    desc="Spawn a random spooky",       fields={}},
			{ name="Random Limited Global", cmd="randomLimitedBrainrotGlobal",desc="Random limited everywhere",fields={}},
		}},
	{ name="LuckyBlock", icon="🎰", color=Color3.fromRGB(255,220,50),
		commands={
			{ name="Spawn Lucky Block",     cmd="spawnluckyblock",       desc="Spawn locally",          fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
			{ name="Spawn Global Lucky",    cmd="spawngloballuckyblock", desc="Spawn everywhere",       fields={{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Amount",key="amount",type="number",default="1"},{label="Mutation",key="mutation",type="mutation",optional=true}}},
			{ name="Add Lucky Block",       cmd="addluckyblock",         desc="Give to player",         fields={{label="Player",key="player",type="player"},{label="Lucky Block",key="brainrot",type="luckyblock"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Amount",key="amount",type="number",default="1"}}},
		}},
	{ name="Fuse",       icon="⚗️", color=Color3.fromRGB(120,200,255),
		commands={
			{ name="Force Fuse",            cmd="forcefuse",        desc="Force fusion result",        fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"},{label="Mutation",key="mutation",type="mutation",optional=true},{label="Traits",key="traits",type="traitsmulti",optional=true}}},
			{ name="Fuse Reveal Global",    cmd="globalfusereveal", desc="Reveal all fusions",        fields={}},
			{ name="Force Lucky Brainrot",  cmd="forceluckybrainrot",desc="Force next lucky",         fields={{label="Player",key="player",type="player"},{label="Brainrot",key="brainrot",type="brainrot"}}},
		}},
}

-- STATE
local currentCategory = 1
local currentCommand  = nil
local isDragging      = false
local dragOffset      = Vector2.new()
local guiVisible      = false
local toggleDebounce  = false
local playerList={} local eventList={} local itemList={}
local brainrotList={} local luckyBlockList={} local mutationList={} local traitList={}
local skinList={}
local activeFormFields={} local sidebarBtns={} local cmdButtons={}
local buildForm
local openSpawnPage
local openSkinPage
local openItemPage   -- ★ forward declaration page items
local spawnPage
local skinPage
local itemPage       -- ★ forward declaration

-- COULEURS
local BG     = Color3.fromRGB(10, 10, 14)
local BG2    = Color3.fromRGB(16, 16, 22)
local BG3    = Color3.fromRGB(22, 22, 32)
local BG4    = Color3.fromRGB(28, 28, 40)
local ORANGE = Color3.fromRGB(255, 140, 0)
local BORDER = Color3.fromRGB(60, 60, 80)
local TEXT   = Color3.fromRGB(240, 240, 255)
local TEXT2  = Color3.fromRGB(160, 160, 200)
local TEXT3  = Color3.fromRGB(80, 80, 110)
local GOLD   = Color3.fromRGB(255, 200, 50)
local GREEN  = Color3.fromRGB(50, 200, 100)
local RED    = Color3.fromRGB(220, 60, 60)
local TEAL   = Color3.fromRGB(50, 200, 180)
local AMBER  = Color3.fromRGB(255, 160, 60)

local function mkC(p,r) local c=Instance.new("UICorner");c.CornerRadius=UDim.new(0,r or 8);c.Parent=p end
local function mkS(p,col,tr,th) local s=Instance.new("UIStroke");s.Color=col or BORDER;s.Transparency=tr or 0.5;s.Thickness=th or 1;s.Parent=p end
local function mkP(p,l,r,t,b) local pad=Instance.new("UIPadding");pad.PaddingLeft=UDim.new(0,l or 0);pad.PaddingRight=UDim.new(0,r or 0);pad.PaddingTop=UDim.new(0,t or 0);pad.PaddingBottom=UDim.new(0,b or 0);pad.Parent=p end

-- SCREEN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name="AdminPanel"; screenGui.ResetOnSpawn=false
screenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
screenGui.DisplayOrder=999; screenGui.Parent=player.PlayerGui

local W, H = 780, 480

local mainFrame = Instance.new("Frame")
mainFrame.Name="MainFrame"; mainFrame.Size=UDim2.new(0,W,0,H)
mainFrame.Position=UDim2.new(0.5,-W/2,0.5,-H/2)
mainFrame.BackgroundColor3=BG; mainFrame.BackgroundTransparency=0.45
mainFrame.BorderSizePixel=0; mainFrame.Visible=false
mainFrame.ClipsDescendants=true; mainFrame.ZIndex=3
mainFrame.Parent=screenGui; mkC(mainFrame,12); mkS(mainFrame,ORANGE,0.0,2)

-- SIDEBAR
local sidebar = Instance.new("Frame")
sidebar.Size=UDim2.new(0,148,1,0); sidebar.BackgroundColor3=BG2
sidebar.BackgroundTransparency=0.42; sidebar.BorderSizePixel=0
sidebar.ZIndex=4; sidebar.Parent=mainFrame

local sideDiv=Instance.new("Frame"); sideDiv.Size=UDim2.new(0,1,1,0); sideDiv.Position=UDim2.new(1,-1,0,0)
sideDiv.BackgroundColor3=ORANGE; sideDiv.BackgroundTransparency=0.3; sideDiv.BorderSizePixel=0; sideDiv.ZIndex=5; sideDiv.Parent=sidebar

local sideHeader=Instance.new("Frame"); sideHeader.Size=UDim2.new(1,0,0,72)
sideHeader.BackgroundColor3=BG; sideHeader.BackgroundTransparency=0.55; sideHeader.BorderSizePixel=0; sideHeader.ZIndex=5; sideHeader.Parent=sidebar

local logoBox=Instance.new("Frame"); logoBox.Size=UDim2.new(0,34,0,34); logoBox.Position=UDim2.new(0,10,0,10)
logoBox.BackgroundColor3=ORANGE; logoBox.BackgroundTransparency=0.0; logoBox.BorderSizePixel=0; logoBox.ZIndex=6; logoBox.Parent=sideHeader; mkC(logoBox,8)
local logoLbl=Instance.new("TextLabel"); logoLbl.Size=UDim2.new(1,0,1,0); logoLbl.BackgroundTransparency=1
logoLbl.Text="⚡"; logoLbl.TextSize=18; logoLbl.Font=Enum.Font.GothamBold; logoLbl.TextColor3=Color3.fromRGB(10,10,10); logoLbl.ZIndex=7; logoLbl.Parent=logoBox

local gameTitle=Instance.new("TextLabel"); gameTitle.Size=UDim2.new(1,-54,0,18); gameTitle.Position=UDim2.new(0,52,0,12)
gameTitle.BackgroundTransparency=1; gameTitle.Text="STEAL A BRAINROT"; gameTitle.TextColor3=TEXT; gameTitle.TextSize=10
gameTitle.Font=Enum.Font.GothamBold; gameTitle.TextXAlignment=Enum.TextXAlignment.Left; gameTitle.ZIndex=6; gameTitle.Parent=sideHeader

local gameSubTitle=Instance.new("TextLabel"); gameSubTitle.Size=UDim2.new(1,-54,0,14); gameSubTitle.Position=UDim2.new(0,52,0,30)
gameSubTitle.BackgroundTransparency=1; gameSubTitle.Text="ADMIN PANEL BY SERVAT"; gameSubTitle.TextColor3=ORANGE; gameSubTitle.TextSize=8
gameSubTitle.Font=Enum.Font.GothamBold; gameSubTitle.TextXAlignment=Enum.TextXAlignment.Left; gameSubTitle.ZIndex=6; gameSubTitle.Parent=sideHeader

local sideHeaderDiv=Instance.new("Frame"); sideHeaderDiv.Size=UDim2.new(1,0,0,1); sideHeaderDiv.Position=UDim2.new(0,0,1,-1)
sideHeaderDiv.BackgroundColor3=ORANGE; sideHeaderDiv.BackgroundTransparency=0.5; sideHeaderDiv.BorderSizePixel=0; sideHeaderDiv.ZIndex=6; sideHeaderDiv.Parent=sideHeader

local sideScroll=Instance.new("ScrollingFrame"); sideScroll.Size=UDim2.new(1,0,1,-72); sideScroll.Position=UDim2.new(0,0,0,72)
sideScroll.BackgroundTransparency=1; sideScroll.BorderSizePixel=0; sideScroll.ScrollBarThickness=2; sideScroll.ScrollBarImageColor3=ORANGE
sideScroll.CanvasSize=UDim2.new(0,0,0,0); sideScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; sideScroll.ZIndex=5; sideScroll.Parent=sidebar
local sideLayout=Instance.new("UIListLayout"); sideLayout.Padding=UDim.new(0,2); sideLayout.Parent=sideScroll; mkP(sideScroll,4,4,6,6)

-- ZONE DROITE
local rightZone=Instance.new("Frame"); rightZone.Size=UDim2.new(1,-148,1,0); rightZone.Position=UDim2.new(0,148,0,0)
rightZone.BackgroundTransparency=1; rightZone.ZIndex=3; rightZone.Parent=mainFrame

local rightHeader=Instance.new("Frame"); rightHeader.Size=UDim2.new(1,0,0,44)
rightHeader.BackgroundColor3=BG2; rightHeader.BackgroundTransparency=0.52; rightHeader.BorderSizePixel=0; rightHeader.ZIndex=5; rightHeader.Parent=rightZone

local rightHeaderDiv=Instance.new("Frame"); rightHeaderDiv.Size=UDim2.new(1,0,0,1); rightHeaderDiv.Position=UDim2.new(0,0,1,-1)
rightHeaderDiv.BackgroundColor3=BORDER; rightHeaderDiv.BackgroundTransparency=0.4; rightHeaderDiv.BorderSizePixel=0; rightHeaderDiv.ZIndex=6; rightHeaderDiv.Parent=rightHeader

local catTitleLbl=Instance.new("TextLabel"); catTitleLbl.Size=UDim2.new(1,-50,1,0); catTitleLbl.Position=UDim2.new(0,16,0,0)
catTitleLbl.BackgroundTransparency=1; catTitleLbl.Text="⚡  SPAWN"; catTitleLbl.TextColor3=TEXT; catTitleLbl.TextSize=13
catTitleLbl.Font=Enum.Font.GothamBold; catTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; catTitleLbl.ZIndex=6; catTitleLbl.Parent=rightHeader

local closeBtn=Instance.new("TextButton"); closeBtn.Size=UDim2.new(0,28,0,28); closeBtn.Position=UDim2.new(1,-36,0.5,-14)
closeBtn.BackgroundColor3=Color3.fromRGB(180,40,40); closeBtn.BackgroundTransparency=0.1; closeBtn.BorderSizePixel=0
closeBtn.Text="✕"; closeBtn.TextColor3=TEXT; closeBtn.TextSize=13; closeBtn.Font=Enum.Font.GothamBold; closeBtn.ZIndex=7; closeBtn.Parent=rightHeader; mkC(closeBtn,6)

local rightBody=Instance.new("Frame"); rightBody.Size=UDim2.new(1,0,1,-44); rightBody.Position=UDim2.new(0,0,0,44)
rightBody.BackgroundTransparency=1; rightBody.ZIndex=3; rightBody.Parent=rightZone

local cmdListPanel=Instance.new("Frame"); cmdListPanel.Size=UDim2.new(0,220,1,0)
cmdListPanel.BackgroundColor3=BG2; cmdListPanel.BackgroundTransparency=0.52; cmdListPanel.BorderSizePixel=0; cmdListPanel.ZIndex=4; cmdListPanel.Parent=rightBody

local cmdDiv=Instance.new("Frame"); cmdDiv.Size=UDim2.new(0,1,1,0); cmdDiv.Position=UDim2.new(1,-1,0,0)
cmdDiv.BackgroundColor3=BORDER; cmdDiv.BackgroundTransparency=0.5; cmdDiv.BorderSizePixel=0; cmdDiv.ZIndex=5; cmdDiv.Parent=cmdListPanel

local cmdScroll=Instance.new("ScrollingFrame"); cmdScroll.Size=UDim2.new(1,0,1,0)
cmdScroll.BackgroundTransparency=1; cmdScroll.BorderSizePixel=0; cmdScroll.ScrollBarThickness=2; cmdScroll.ScrollBarImageColor3=ORANGE
cmdScroll.CanvasSize=UDim2.new(0,0,0,0); cmdScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y; cmdScroll.ZIndex=4; cmdScroll.Parent=cmdListPanel
local cmdLayout=Instance.new("UIListLayout"); cmdLayout.Padding=UDim.new(0,1); cmdLayout.Parent=cmdScroll; mkP(cmdScroll,4,4,6,6)

local formPanel=Instance.new("Frame"); formPanel.Size=UDim2.new(1,-220,1,0); formPanel.Position=UDim2.new(0,220,0,0)
formPanel.BackgroundColor3=BG; formPanel.BackgroundTransparency=0.42; formPanel.BorderSizePixel=0; formPanel.ZIndex=4; formPanel.Parent=rightBody

local selectHint=Instance.new("TextLabel"); selectHint.Size=UDim2.new(1,0,1,0); selectHint.BackgroundTransparency=1
selectHint.Text="← Sélectionne une commande"; selectHint.TextColor3=TEXT3; selectHint.TextSize=13; selectHint.Font=Enum.Font.Gotham; selectHint.ZIndex=5; selectHint.Parent=formPanel

local formScroll=Instance.new("ScrollingFrame"); formScroll.Size=UDim2.new(1,-8,1,-8); formScroll.Position=UDim2.new(0,4,0,4)
formScroll.BackgroundTransparency=1; formScroll.BorderSizePixel=0; formScroll.ScrollBarThickness=2; formScroll.ScrollBarImageColor3=ORANGE
formScroll.CanvasSize=UDim2.new(0,0,0,0); formScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
formScroll.Visible=false; formScroll.ZIndex=4; formScroll.Parent=formPanel
local fLayout=Instance.new("UIListLayout"); fLayout.Padding=UDim.new(0,8); fLayout.Parent=formScroll; mkP(formScroll,14,14,14,14)

-- NOTIF
local notifHolder=Instance.new("Frame"); notifHolder.Size=UDim2.new(0,300,0,400); notifHolder.Position=UDim2.new(1,-312,1,-410)
notifHolder.BackgroundTransparency=1; notifHolder.Parent=screenGui
local notifLayout=Instance.new("UIListLayout"); notifLayout.VerticalAlignment=Enum.VerticalAlignment.Bottom; notifLayout.Padding=UDim.new(0,6); notifLayout.Parent=notifHolder

-- HUD BUTTON
local hudSG=Instance.new("ScreenGui"); hudSG.Name="AdminHudBtn"; hudSG.ResetOnSpawn=false
hudSG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; hudSG.DisplayOrder=9999; hudSG.Parent=player.PlayerGui
local hudBtn=Instance.new("TextButton"); hudBtn.Size=UDim2.new(0,42,0,42); hudBtn.Position=UDim2.new(1,-54,1,-54)
hudBtn.BackgroundColor3=BG2; hudBtn.BackgroundTransparency=0.35; hudBtn.BorderSizePixel=0; hudBtn.Text="⚡"; hudBtn.TextColor3=ORANGE
hudBtn.TextSize=18; hudBtn.Font=Enum.Font.GothamBold; hudBtn.Parent=hudSG; mkC(hudBtn,10); mkS(hudBtn,ORANGE,0.0,2)
hudBtn.MouseEnter:Connect(function() TweenService:Create(hudBtn,TweenInfo.new(0.1),{BackgroundColor3=BG4}):Play() end)
hudBtn.MouseLeave:Connect(function() TweenService:Create(hudBtn,TweenInfo.new(0.1),{BackgroundColor3=BG2}):Play() end)

-- ============================================================
-- HELPERS UI
-- ============================================================
local function showNotif(text,success)
	local notif=Instance.new("Frame"); notif.Size=UDim2.new(0,280,0,56)
	notif.BackgroundColor3=BG2; notif.BackgroundTransparency=0.28; notif.BorderSizePixel=0; notif.ClipsDescendants=true; notif.Parent=notifHolder
	mkC(notif,10); mkS(notif,success and GREEN or RED,0.3,1)
	local bar=Instance.new("Frame"); bar.Size=UDim2.new(0,3,0.65,0); bar.Position=UDim2.new(0,0,0.175,0)
	bar.BackgroundColor3=success and GREEN or RED; bar.BackgroundTransparency=0; bar.BorderSizePixel=0; bar.Parent=notif; mkC(bar,2)
	local iconBg=Instance.new("Frame"); iconBg.Size=UDim2.new(0,28,0,28); iconBg.Position=UDim2.new(0,10,0.5,-14)
	iconBg.BackgroundColor3=success and GREEN or RED; iconBg.BackgroundTransparency=0.6; iconBg.BorderSizePixel=0; iconBg.Parent=notif; mkC(iconBg,14)
	local icon=Instance.new("TextLabel"); icon.Size=UDim2.new(1,0,1,0); icon.BackgroundTransparency=1
	icon.Text=success and "✓" or "✕"; icon.TextColor3=TEXT; icon.TextSize=13; icon.Font=Enum.Font.GothamBold; icon.Parent=iconBg
	local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(0,190,0,16); lbl.Position=UDim2.new(0,46,0,10)
	lbl.BackgroundTransparency=1; lbl.Text=success and "Commande exécutée" or "Commande échouée"
	lbl.TextColor3=TEXT; lbl.TextSize=12; lbl.Font=Enum.Font.GothamBold; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.Parent=notif
	local sub=Instance.new("TextLabel"); sub.Size=UDim2.new(0,200,0,12); sub.Position=UDim2.new(0,46,0,30)
	sub.BackgroundTransparency=1; sub.Text=tostring(text); sub.TextColor3=TEXT3; sub.TextSize=9
	sub.Font=Enum.Font.Gotham; sub.TextXAlignment=Enum.TextXAlignment.Left; sub.TextTruncate=Enum.TextTruncate.AtEnd; sub.Parent=notif
	local prog=Instance.new("Frame"); prog.Size=UDim2.new(1,0,0,2); prog.Position=UDim2.new(0,0,1,-2)
	prog.BackgroundColor3=success and GREEN or RED; prog.BackgroundTransparency=0; prog.BorderSizePixel=0; prog.Parent=notif
	notif.Position=UDim2.new(1,10,0,0)
	TweenService:Create(notif,TweenInfo.new(0.25,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
	TweenService:Create(prog,TweenInfo.new(3.2,Enum.EasingStyle.Linear),{Size=UDim2.new(0,0,0,2)}):Play()
	task.delay(3.2,function()
		if notif and notif.Parent then
			TweenService:Create(notif,TweenInfo.new(0.2,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(1,10,0,0),BackgroundTransparency=1}):Play()
			task.wait(0.25); if notif and notif.Parent then notif:Destroy() end
		end
	end)
end

local activeDropOverlay=nil

local function makeDropdown(placeholder,options)
	local selected=nil; local isOpen=false; local justSelected=false
	local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,36)
	btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.0; btn.BorderSizePixel=0; btn.Text=""; mkC(btn,6); mkS(btn,BORDER,0.4,1)
	local btnTxt=Instance.new("TextLabel"); btnTxt.Size=UDim2.new(1,-32,1,0); btnTxt.Position=UDim2.new(0,10,0,0)
	btnTxt.BackgroundTransparency=1; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3; btnTxt.TextSize=11
	btnTxt.Font=Enum.Font.Gotham; btnTxt.TextXAlignment=Enum.TextXAlignment.Left; btnTxt.TextTruncate=Enum.TextTruncate.AtEnd; btnTxt.Parent=btn
	local arrow=Instance.new("TextLabel"); arrow.Size=UDim2.new(0,22,1,0); arrow.Position=UDim2.new(1,-24,0,0)
	arrow.BackgroundTransparency=1; arrow.Text="▾"; arrow.TextColor3=TEXT3; arrow.TextSize=10; arrow.Font=Enum.Font.Gotham; arrow.Parent=btn
	local function closeOv()
		if activeDropOverlay and activeDropOverlay.Parent then activeDropOverlay:Destroy(); activeDropOverlay=nil end; isOpen=false
	end
	local function openOv()
		closeOv(); isOpen=true
		local ap=btn.AbsolutePosition; local as=btn.AbsoluteSize; local h=math.min(#options,8)*30+42
		local ov=Instance.new("Frame"); ov.Size=UDim2.new(0,as.X,0,h); ov.Position=UDim2.new(0,ap.X,0,ap.Y+as.Y+3)
		ov.BackgroundColor3=BG2; ov.BackgroundTransparency=0.0; ov.BorderSizePixel=0; ov.ZIndex=200; ov.ClipsDescendants=true
		ov.Parent=screenGui; mkC(ov,8); mkS(ov,ORANGE,0.3,1); activeDropOverlay=ov
		local sb=Instance.new("TextBox"); sb.Size=UDim2.new(1,-10,0,30); sb.Position=UDim2.new(0,5,0,6)
		sb.BackgroundColor3=BG3; sb.BackgroundTransparency=0.0; sb.BorderSizePixel=0
		sb.PlaceholderText="🔍 Rechercher..."; sb.PlaceholderColor3=TEXT3; sb.Text=""
		sb.TextColor3=TEXT; sb.TextSize=11; sb.Font=Enum.Font.Gotham; sb.ClearTextOnFocus=false; sb.ZIndex=202; sb.Parent=ov; mkC(sb,6); mkS(sb,BORDER,0.5,1); mkP(sb,8,0,0,0)
		local ds=Instance.new("ScrollingFrame"); ds.Size=UDim2.new(1,0,1,-42); ds.Position=UDim2.new(0,0,0,42)
		ds.BackgroundTransparency=1; ds.BorderSizePixel=0; ds.ScrollBarThickness=2; ds.ScrollBarImageColor3=ORANGE
		ds.CanvasSize=UDim2.new(0,0,0,0); ds.AutomaticCanvasSize=Enum.AutomaticSize.Y; ds.ZIndex=201; ds.Parent=ov
		local dl=Instance.new("UIListLayout"); dl.Padding=UDim.new(0,1); dl.Parent=ds; mkP(ds,3,3,2,2)
		local function buildOpts(filter)
			for _,c in ipairs(ds:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
			local fl=filter:lower()
			for _,opt in ipairs(options) do
				if fl=="" or opt:lower():find(fl,1,true) then
					local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,28)
					ob.BackgroundColor3=BG3; ob.BackgroundTransparency=0.2; ob.BorderSizePixel=0
					ob.Text=opt; ob.TextColor3=TEXT2; ob.TextSize=11; ob.Font=Enum.Font.Gotham
					ob.TextXAlignment=Enum.TextXAlignment.Left; ob.ZIndex=202; ob.Parent=ds; mkC(ob,5); mkP(ob,10,0,0,0)
					ob.MouseEnter:Connect(function() TweenService:Create(ob,TweenInfo.new(0.08),{BackgroundColor3=BG4,BackgroundTransparency=0,TextColor3=TEXT}):Play() end)
					ob.MouseLeave:Connect(function() TweenService:Create(ob,TweenInfo.new(0.08),{BackgroundColor3=BG3,BackgroundTransparency=0.2,TextColor3=TEXT2}):Play() end)
					ob.MouseButton1Click:Connect(function()
						justSelected=true; selected=opt; btnTxt.Text=opt; btnTxt.TextColor3=TEXT
						closeOv(); task.wait(0.08); justSelected=false
					end)
				end
			end
		end
		buildOpts(""); sb:GetPropertyChangedSignal("Text"):Connect(function() buildOpts(sb.Text) end)
		task.wait(); sb:CaptureFocus()
	end
	btn.MouseButton1Click:Connect(function() if isOpen then closeOv() else openOv() end end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			if justSelected then return end
			if isOpen and activeDropOverlay then
				local mp=UserInputService:GetMouseLocation()
				local op=activeDropOverlay.AbsolutePosition; local os2=activeDropOverlay.AbsoluteSize
				local inB=mp.X>=btn.AbsolutePosition.X and mp.X<=btn.AbsolutePosition.X+btn.AbsoluteSize.X and mp.Y>=btn.AbsolutePosition.Y and mp.Y<=btn.AbsolutePosition.Y+btn.AbsoluteSize.Y
				local inBounds=mp.X>=op.X and mp.X<=op.X+os2.X and mp.Y>=op.Y and mp.Y<=op.Y+os2.Y
				if not inBounds and not inB then closeOv() end
			end
		end
	end)
	return { frame=btn, getValue=function() return selected end,
	setValue=function(v) selected=v; btnTxt.Text=v or placeholder; btnTxt.TextColor3=v and TEXT or TEXT3 end,
	reset=function() selected=nil; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3 end,
	updateOptions=function(nl) options=nl end }
end

local function makeMultiDropdown(placeholder,options)
	local selected={}; local isOpen=false; local myOv=nil
	local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,36)
	btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.0; btn.BorderSizePixel=0; btn.Text=""; mkC(btn,6); mkS(btn,BORDER,0.4,1)
	local btnTxt=Instance.new("TextLabel"); btnTxt.Size=UDim2.new(1,-32,1,0); btnTxt.Position=UDim2.new(0,10,0,0)
	btnTxt.BackgroundTransparency=1; btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3; btnTxt.TextSize=11
	btnTxt.Font=Enum.Font.Gotham; btnTxt.TextXAlignment=Enum.TextXAlignment.Left; btnTxt.TextTruncate=Enum.TextTruncate.AtEnd; btnTxt.Parent=btn
	local arrow=Instance.new("TextLabel"); arrow.Size=UDim2.new(0,22,1,0); arrow.Position=UDim2.new(1,-24,0,0)
	arrow.BackgroundTransparency=1; arrow.Text="▾"; arrow.TextColor3=TEXT3; arrow.TextSize=10; arrow.Font=Enum.Font.Gotham; arrow.Parent=btn
	local function upd() if #selected==0 then btnTxt.Text=placeholder; btnTxt.TextColor3=TEXT3 else btnTxt.Text=table.concat(selected,", "); btnTxt.TextColor3=TEXT end end
	local function closeOv() isOpen=false; if myOv and myOv.Parent then myOv:Destroy() end; myOv=nil end
	local function openOv()
		if activeDropOverlay and activeDropOverlay.Parent then activeDropOverlay:Destroy(); activeDropOverlay=nil end
		isOpen=true; local ap=btn.AbsolutePosition; local as=btn.AbsoluteSize; local h=math.min(#options,8)*30+42
		local ov=Instance.new("Frame"); ov.Size=UDim2.new(0,as.X,0,h); ov.Position=UDim2.new(0,ap.X,0,ap.Y+as.Y+3)
		ov.BackgroundColor3=BG2; ov.BackgroundTransparency=0.0; ov.BorderSizePixel=0; ov.ZIndex=200; ov.ClipsDescendants=true
		ov.Parent=screenGui; mkC(ov,8); mkS(ov,ORANGE,0.3,1); myOv=ov; activeDropOverlay=ov
		local sb=Instance.new("TextBox"); sb.Size=UDim2.new(1,-10,0,30); sb.Position=UDim2.new(0,5,0,6)
		sb.BackgroundColor3=BG3; sb.BackgroundTransparency=0.0; sb.BorderSizePixel=0
		sb.PlaceholderText="🔍 Rechercher..."; sb.PlaceholderColor3=TEXT3; sb.Text=""
		sb.TextColor3=TEXT; sb.TextSize=11; sb.Font=Enum.Font.Gotham; sb.ClearTextOnFocus=false; sb.ZIndex=202; sb.Parent=ov; mkC(sb,6); mkS(sb,BORDER,0.5,1); mkP(sb,8,0,0,0)
		local ds=Instance.new("ScrollingFrame"); ds.Size=UDim2.new(1,0,1,-42); ds.Position=UDim2.new(0,0,0,42)
		ds.BackgroundTransparency=1; ds.BorderSizePixel=0; ds.ScrollBarThickness=2; ds.ScrollBarImageColor3=ORANGE
		ds.CanvasSize=UDim2.new(0,0,0,0); ds.AutomaticCanvasSize=Enum.AutomaticSize.Y; ds.ZIndex=201; ds.Parent=ov
		local dl=Instance.new("UIListLayout"); dl.Padding=UDim.new(0,1); dl.Parent=ds; mkP(ds,3,3,2,2)
		local function buildOpts(filter)
			for _,c in ipairs(ds:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
			local fl=filter:lower()
			for _,opt in ipairs(options) do
				if fl=="" or opt:lower():find(fl,1,true) then
					local isSel=table.find(selected,opt)~=nil
					local ob=Instance.new("TextButton"); ob.Size=UDim2.new(1,0,0,28)
					ob.BackgroundColor3=isSel and BG4 or BG3; ob.BackgroundTransparency=isSel and 0.0 or 0.2
					ob.BorderSizePixel=0; ob.Text=""; ob.ZIndex=202; ob.Parent=ds; mkC(ob,5)
					local chk=Instance.new("TextLabel"); chk.Size=UDim2.new(0,18,1,0); chk.Position=UDim2.new(0,6,0,0)
					chk.BackgroundTransparency=1; chk.Text=isSel and "✓" or ""; chk.TextColor3=GOLD; chk.TextSize=10; chk.Font=Enum.Font.GothamBold; chk.ZIndex=203; chk.Parent=ob
					local otxt=Instance.new("TextLabel"); otxt.Size=UDim2.new(1,-24,1,0); otxt.Position=UDim2.new(0,22,0,0)
					otxt.BackgroundTransparency=1; otxt.Text=opt; otxt.TextColor3=isSel and TEXT or TEXT2
					otxt.TextSize=11; otxt.Font=Enum.Font.Gotham; otxt.TextXAlignment=Enum.TextXAlignment.Left; otxt.ZIndex=203; otxt.Parent=ob
					ob.MouseButton1Click:Connect(function()
						local idx=table.find(selected,opt)
						if idx then table.remove(selected,idx); ob.BackgroundTransparency=0.2; chk.Text=""; otxt.TextColor3=TEXT2
						else table.insert(selected,opt); ob.BackgroundTransparency=0.0; chk.Text="✓"; otxt.TextColor3=TEXT end; upd()
					end)
				end
			end
		end
		buildOpts(""); sb:GetPropertyChangedSignal("Text"):Connect(function() buildOpts(sb.Text) end)
		task.wait(); sb:CaptureFocus()
	end
	btn.MouseButton1Click:Connect(function() if isOpen then closeOv() else openOv() end end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType==Enum.UserInputType.MouseButton1 then
			if isOpen and myOv and myOv.Parent then
				local mp=UserInputService:GetMouseLocation(); local op=myOv.AbsolutePosition; local os2=myOv.AbsoluteSize
				local inO=mp.X>=op.X and mp.X<=op.X+os2.X and mp.Y>=op.Y and mp.Y<=op.Y+os2.Y
				local inB=mp.X>=btn.AbsolutePosition.X and mp.X<=btn.AbsolutePosition.X+btn.AbsoluteSize.X and mp.Y>=btn.AbsolutePosition.Y and mp.Y<=btn.AbsolutePosition.Y+btn.AbsoluteSize.Y
				if not inO and not inB then closeOv() end
			end
		end
	end)
	return { frame=btn, getValue=function() return #selected>0 and selected or nil end, reset=function() selected={}; upd() end }
end

local function makeInput(ph)
	local tb=Instance.new("TextBox"); tb.Size=UDim2.new(1,0,0,36)
	tb.BackgroundColor3=BG3; tb.BackgroundTransparency=0.0; tb.BorderSizePixel=0
	tb.PlaceholderText=ph; tb.PlaceholderColor3=TEXT3; tb.Text=""; tb.TextColor3=TEXT
	tb.TextSize=11; tb.Font=Enum.Font.Gotham; tb.ClearTextOnFocus=false; mkC(tb,6); mkS(tb,BORDER,0.4,1); mkP(tb,10,0,0,0)
	tb.Focused:Connect(function() TweenService:Create(tb,TweenInfo.new(0.1),{BackgroundColor3=BG4}):Play() end)
	tb.FocusLost:Connect(function() TweenService:Create(tb,TweenInfo.new(0.1),{BackgroundColor3=BG3}):Play() end)
	return tb
end

local function makeExecBtn(text,col)
	local b=Instance.new("TextButton"); b.Size=UDim2.new(1,0,0,42)
	b.BackgroundColor3=col or ORANGE; b.BackgroundTransparency=0.05; b.BorderSizePixel=0
	b.Text="⚡  "..text; b.TextColor3=Color3.fromRGB(10,10,10); b.TextSize=13; b.Font=Enum.Font.GothamBold; mkC(b,8)
	b.MouseEnter:Connect(function() TweenService:Create(b,TweenInfo.new(0.08),{BackgroundTransparency=0}):Play() end)
	b.MouseLeave:Connect(function() TweenService:Create(b,TweenInfo.new(0.08),{BackgroundTransparency=0.05}):Play() end)
	return b
end

local function makeLbl(text,size,color,bold)
	local l=Instance.new("TextLabel"); l.BackgroundTransparency=1; l.Text=text
	l.TextColor3=color or TEXT2; l.TextSize=size or 11
	l.Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham; l.TextXAlignment=Enum.TextXAlignment.Left; return l
end

-- ============================================================
-- HELPER : construire une carte visuelle pour la grille
-- Cherche l'image dans un folder de RS par nom
-- ============================================================
local ItemsFolder = nil
local SkinsFolder = nil
task.spawn(function()
	local RS = game:GetService("ReplicatedStorage")
	-- Items
	ItemsFolder = RS:FindFirstChild("Items") or RS:FindFirstChild("ShopItems") or RS:FindFirstChild("ItemsFolder")
	-- Skins
	SkinsFolder = RS:FindFirstChild("Skins") or RS:FindFirstChild("BaseSkins") or RS:FindFirstChild("BaseSkinsFolder")
	-- Models brainrots
end)
local AnimalModels = nil
task.spawn(function()
	local RS = game:GetService("ReplicatedStorage")
	local modelsFolder = RS:FindFirstChild("Models") or RS:FindFirstChild("Animals") or RS:FindFirstChild("Brainrots")
	if modelsFolder then
		AnimalModels = modelsFolder:FindFirstChild("Animals") or modelsFolder:FindFirstChild("Brainrots") or modelsFolder
	end
end)

-- Fonction générique : ajoute l'image dans une zone à partir d'un folder + nom
local function fillImageZone(imgZone, folder, itemName, accentColor, fallbackIcon)
	local found = false
	if folder then
		local ref = folder:FindFirstChild(itemName)
		if not ref then
			for _,child in ipairs(folder:GetChildren()) do
				if child.Name:lower()==itemName:lower() then ref=child; break end
			end
		end
		if ref then
			-- Cherche ImageLabel, Decal, StringValue "Image"/"ImageId", ou Model
			local imgLbl = ref:FindFirstChildWhichIsA("ImageLabel",true)
			local decal  = ref:FindFirstChildWhichIsA("Decal",true)
			local imgVal = ref:FindFirstChild("Image") or ref:FindFirstChild("ImageId") or ref:FindFirstChild("Thumbnail")
			if imgLbl then
				local c=imgLbl:Clone(); c.Size=UDim2.new(1,0,1,0); c.Position=UDim2.new(0,0,0,0)
				c.BackgroundTransparency=1; c.ScaleType=Enum.ScaleType.Fit; c.ZIndex=imgZone.ZIndex+1; c.Parent=imgZone; found=true
			elseif decal then
				local img=Instance.new("ImageLabel"); img.Size=UDim2.new(1,0,1,0); img.BackgroundTransparency=1
				img.Image=decal.Texture; img.ScaleType=Enum.ScaleType.Fit; img.ZIndex=imgZone.ZIndex+1; img.Parent=imgZone; found=true
			elseif imgVal and imgVal:IsA("StringValue") and imgVal.Value~="" then
				local img=Instance.new("ImageLabel"); img.Size=UDim2.new(1,0,1,0); img.BackgroundTransparency=1
				img.Image=imgVal.Value; img.ScaleType=Enum.ScaleType.Fit; img.ZIndex=imgZone.ZIndex+1; img.Parent=imgZone; found=true
			elseif ref:IsA("Model") then
				local vp=Instance.new("ViewportFrame"); vp.Size=UDim2.new(1,0,1,0); vp.BackgroundTransparency=1
				vp.Ambient=Color3.fromRGB(180,180,220); vp.LightColor=Color3.fromRGB(255,248,230)
				vp.LightDirection=Vector3.new(-1,-2,-1); vp.ZIndex=imgZone.ZIndex+1; vp.Parent=imgZone
				local vpCam=Instance.new("Camera"); vpCam.Parent=vp; vp.CurrentCamera=vpCam
				task.spawn(function()
					local ok,clone=pcall(function() return ref:Clone() end)
					if ok and clone and vp and vp.Parent then
						for _,s in ipairs(clone:GetDescendants()) do
							if s:IsA("Script") or s:IsA("LocalScript") then s.Disabled=true end
							if s:IsA("ParticleEmitter") or s:IsA("Trail") or s:IsA("Beam") then s.Enabled=false end
						end
						clone.Parent=vp
						local cf,sz; pcall(function() cf,sz=clone:GetBoundingBox() end)
						if cf and sz then
							local d=math.max(sz.X,sz.Y,sz.Z)
							vpCam.CFrame=CFrame.new(cf.Position+Vector3.new(d*0.4,d*0.3,d*0.9),cf.Position)
						else vpCam.CFrame=CFrame.new(Vector3.new(0,4,10),Vector3.new(0,2,0)) end
					end
				end)
				found=true
			end
		end
	end
	if not found then
		-- Placeholder : icône + initiale
		local ico=Instance.new("TextLabel"); ico.Size=UDim2.new(1,0,0.55,0); ico.Position=UDim2.new(0,0,0.08,0)
		ico.BackgroundTransparency=1; ico.Text=fallbackIcon or "📦"; ico.TextSize=28; ico.Font=Enum.Font.Gotham
		ico.ZIndex=imgZone.ZIndex+1; ico.Parent=imgZone
		local ini=Instance.new("TextLabel"); ini.Size=UDim2.new(1,0,0.32,0); ini.Position=UDim2.new(0,0,0.62,0)
		ini.BackgroundTransparency=1; ini.Text=string.sub(itemName,1,1):upper()
		ini.TextColor3=accentColor or AMBER; ini.TextSize=15; ini.Font=Enum.Font.GothamBold
		ini.ZIndex=imgZone.ZIndex+1; ini.Parent=imgZone
	end
end

-- ============================================================
-- BUILD SIDEBAR
-- ============================================================
local function buildSidebar()
	for _,c in ipairs(sideScroll:GetChildren()) do if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end end
	sidebarBtns={}
	for i,cat in ipairs(CATEGORIES) do
		local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,38)
		btn.BackgroundColor3=BG2; btn.BackgroundTransparency=0.5; btn.BorderSizePixel=0; btn.Text=""
		btn.ZIndex=6; btn.Parent=sideScroll; mkC(btn,6)
		local accent=Instance.new("Frame"); accent.Size=UDim2.new(0,3,0.6,0); accent.Position=UDim2.new(0,0,0.2,0)
		accent.BackgroundColor3=cat.color or ORANGE; accent.BackgroundTransparency=1; accent.BorderSizePixel=0; accent.Parent=btn; mkC(accent,2)
		local iconLbl=Instance.new("TextLabel"); iconLbl.Size=UDim2.new(0,24,1,0); iconLbl.Position=UDim2.new(0,10,0,0)
		iconLbl.BackgroundTransparency=1; iconLbl.Text=cat.icon; iconLbl.TextSize=14; iconLbl.Font=Enum.Font.Gotham; iconLbl.TextColor3=TEXT3; iconLbl.ZIndex=7; iconLbl.Parent=btn
		local nameLbl=Instance.new("TextLabel"); nameLbl.Size=UDim2.new(1,-42,1,0); nameLbl.Position=UDim2.new(0,36,0,0)
		nameLbl.BackgroundTransparency=1; nameLbl.Text=cat.name; nameLbl.TextSize=11; nameLbl.Font=Enum.Font.Gotham; nameLbl.TextColor3=TEXT3
		nameLbl.TextXAlignment=Enum.TextXAlignment.Left; nameLbl.ZIndex=7; nameLbl.Parent=btn
		table.insert(sidebarBtns,{btn=btn,accent=accent,iconLbl=iconLbl,nameLbl=nameLbl})
		local idx=i
		btn.MouseEnter:Connect(function() if idx~=currentCategory then TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundTransparency=0.2}):Play(); TweenService:Create(nameLbl,TweenInfo.new(0.1),{TextColor3=TEXT2}):Play() end end)
		btn.MouseLeave:Connect(function() if idx~=currentCategory then TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundTransparency=0.5}):Play(); TweenService:Create(nameLbl,TweenInfo.new(0.1),{TextColor3=TEXT3}):Play() end end)
		btn.MouseButton1Click:Connect(function() selectCategory(idx) end)
	end
end

local function setActiveSidebar(idx)
	for i,data in ipairs(sidebarBtns) do
		local cat=CATEGORIES[i]
		if i==idx then
			data.btn.BackgroundColor3=BG4; data.btn.BackgroundTransparency=0.0; data.accent.BackgroundTransparency=0.0
			data.nameLbl.TextColor3=TEXT; data.nameLbl.Font=Enum.Font.GothamBold; data.iconLbl.TextColor3=cat.color or ORANGE
		else
			data.btn.BackgroundColor3=BG2; data.btn.BackgroundTransparency=0.5; data.accent.BackgroundTransparency=1.0
			data.nameLbl.TextColor3=TEXT3; data.nameLbl.Font=Enum.Font.Gotham; data.iconLbl.TextColor3=TEXT3
		end
	end
end

-- ============================================================
-- BUILD CMD LIST
-- ============================================================
local function buildCmdList(catIdx)
	for _,c in ipairs(cmdScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	cmdButtons={}
	local cat=CATEGORIES[catIdx]; if not cat then return end
	catTitleLbl.Text=cat.icon.."  "..string.upper(cat.name)
	for i,cmd in ipairs(cat.commands) do
		local isRed=cat.name=="Modération" and (cmd.cmd=="resetdata" or cmd.cmd=="resetdatafull")
		local btn=Instance.new("TextButton"); btn.Size=UDim2.new(1,0,0,50)
		btn.BackgroundColor3=isRed and Color3.fromRGB(30,10,10) or BG3; btn.BackgroundTransparency=0.1
		btn.BorderSizePixel=0; btn.Text=""; btn.ZIndex=5; btn.Parent=cmdScroll; mkC(btn,6)
		local accent=Instance.new("Frame"); accent.Size=UDim2.new(0,3,0.5,0); accent.Position=UDim2.new(0,0,0.25,0)
		accent.BackgroundColor3=isRed and RED or (cat.color or ORANGE); accent.BackgroundTransparency=0.4; accent.BorderSizePixel=0; accent.Parent=btn; mkC(accent,2)
		local nl=Instance.new("TextLabel"); nl.Size=UDim2.new(1,-12,0,20); nl.Position=UDim2.new(0,10,0,8)
		nl.BackgroundTransparency=1; nl.Text=cmd.name; nl.TextColor3=isRed and Color3.fromRGB(255,150,150) or TEXT2
		nl.TextSize=11; nl.Font=Enum.Font.GothamBold; nl.TextXAlignment=Enum.TextXAlignment.Left; nl.Parent=btn
		local dl=Instance.new("TextLabel"); dl.Size=UDim2.new(1,-12,0,12); dl.Position=UDim2.new(0,10,0,29)
		dl.BackgroundTransparency=1; dl.Text=cmd.desc; dl.TextColor3=TEXT3; dl.TextSize=9; dl.Font=Enum.Font.Gotham; dl.TextXAlignment=Enum.TextXAlignment.Left; dl.Parent=btn
		table.insert(cmdButtons,{btn=btn,accent=accent,nl=nl,isRed=isRed})
		local cIdx=i; local catRef=cat; local cmdRef=cmd
		btn.MouseEnter:Connect(function() if cIdx~=currentCommand then TweenService:Create(btn,TweenInfo.new(0.08),{BackgroundTransparency=0.0}):Play(); TweenService:Create(accent,TweenInfo.new(0.08),{BackgroundTransparency=0.1}):Play() end end)
		btn.MouseLeave:Connect(function() if cIdx~=currentCommand then TweenService:Create(btn,TweenInfo.new(0.08),{BackgroundTransparency=0.1}):Play(); TweenService:Create(accent,TweenInfo.new(0.08),{BackgroundTransparency=0.4}):Play() end end)
		btn.MouseButton1Click:Connect(function()
			if currentCommand then
				local old=cmdButtons[currentCommand]
				if old then TweenService:Create(old.btn,TweenInfo.new(0.1),{BackgroundTransparency=0.1}):Play(); TweenService:Create(old.accent,TweenInfo.new(0.1),{BackgroundTransparency=0.4}):Play(); old.nl.TextColor3=old.isRed and Color3.fromRGB(255,150,150) or TEXT2 end
			end
			currentCommand=cIdx
			TweenService:Create(btn,TweenInfo.new(0.1),{BackgroundTransparency=0.0,BackgroundColor3=BG4}):Play()
			TweenService:Create(accent,TweenInfo.new(0.1),{BackgroundTransparency=0.0}):Play()
			nl.TextColor3=TEXT
			local SPAWN_CMDS={spawnbrainrot=true,spawnglobalbrainrot=true,spawnbrainrotalltraits=true}
			local LUCKY_CMDS={spawnluckyblock=true,spawngloballuckyblock=true}
			local EVENT_CMDS={executeevent=true,executeglobalevent=true}
			local ITEM_CMDS={giveitem=true,removeitem=true}
			if cmdRef.cmd=="setbaseskin" then
				if spawnPage then spawnPage.Visible=false end
				if itemPage then itemPage.Visible=false end
				openSkinPage(catRef,cmdRef)
			elseif ITEM_CMDS[cmdRef.cmd] then
				if spawnPage then spawnPage.Visible=false end
				if skinPage then skinPage.Visible=false end
				openItemPage(catRef,cmdRef)
			elseif SPAWN_CMDS[cmdRef.cmd] then
				if skinPage then skinPage.Visible=false end
				if itemPage then itemPage.Visible=false end
				openSpawnPage("brainrot")
			elseif LUCKY_CMDS[cmdRef.cmd] then
				if skinPage then skinPage.Visible=false end
				if itemPage then itemPage.Visible=false end
				openSpawnPage("luckyblock")
			elseif EVENT_CMDS[cmdRef.cmd] then
				if skinPage then skinPage.Visible=false end
				if itemPage then itemPage.Visible=false end
				openSpawnPage("event")
			else
				if spawnPage then spawnPage.Visible=false end
				if skinPage then skinPage.Visible=false end
				if itemPage then itemPage.Visible=false end
				buildForm(catRef,cmdRef)
			end
		end)
	end
end

-- ============================================================
-- BUILD FORM
-- ============================================================
buildForm = function(cat,cmd)
	for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
	activeFormFields={}; selectHint.Visible=false; formScroll.Visible=true
	playerList={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(playerList,p.Name) end
	local ok1,ev=pcall(function() return GetEvents:InvokeServer() end); eventList=(ok1 and ev) and ev or {}
	local ok2,it=pcall(function() return GetItems:InvokeServer() end); itemList=(ok2 and it) and it or {}
	local ok3,br=pcall(function() return GetBrainrots:InvokeServer() end); brainrotList=(ok3 and br) and br or {}
	local ok4,lb=pcall(function() return GetLuckyBlocks:InvokeServer() end); luckyBlockList=(ok4 and lb) and lb or {}
	local ok5,mu=pcall(function() return GetMutations:InvokeServer() end); mutationList=(ok5 and mu) and mu or {"Normal"}
	local ok6,tr=pcall(function() return GetTraits:InvokeServer() end); traitList=(ok6 and tr) and tr or {}
	local hdr=Instance.new("Frame"); hdr.Size=UDim2.new(1,0,0,46)
	hdr.BackgroundColor3=BG3; hdr.BackgroundTransparency=0.2; hdr.BorderSizePixel=0; hdr.LayoutOrder=0; hdr.Parent=formScroll; mkC(hdr,8); mkS(hdr,cat.color or ORANGE,0.6,1)
	local htit=makeLbl("⚡  "..cmd.name,13,TEXT,true); htit.Size=UDim2.new(1,-16,0,20); htit.Position=UDim2.new(0,12,0,6); htit.Parent=hdr
	local hdesc=makeLbl(cmd.desc,10,TEXT3); hdesc.Size=UDim2.new(1,-16,0,14); hdesc.Position=UDim2.new(0,12,0,27); hdesc.Parent=hdr
	local isDataDanger=cat.name=="Modération" and (cmd.cmd=="resetdata" or cmd.cmd=="resetdatafull")
	if isDataDanger then
		local wb=Instance.new("Frame"); wb.Size=UDim2.new(1,0,0,32); wb.BackgroundColor3=RED
		wb.BackgroundTransparency=0.6; wb.BorderSizePixel=0; wb.LayoutOrder=1; wb.Parent=formScroll; mkC(wb,6)
		local wt=makeLbl("⚠  Action irréversible",10,Color3.fromRGB(255,150,150),true); wt.Size=UDim2.new(1,-16,1,0); wt.Position=UDim2.new(0,10,0,0); wt.Parent=wb
	end
	local lo=isDataDanger and 2 or 1
	for _,field in ipairs(cmd.fields) do
		local lbl=makeLbl(field.label..(field.optional and "  (optionnel)" or ""),9,TEXT3)
		lbl.Size=UDim2.new(1,0,0,14); lbl.LayoutOrder=lo; lo+=1; lbl.Parent=formScroll
		local widget
		if     field.type=="player"      then widget=makeDropdown("Sélectionner un joueur...",#playerList>0 and playerList or {"(aucun joueur)"})
		elseif field.type=="event"       then widget=makeDropdown("Sélectionner un event...",#eventList>0 and eventList or {"(aucun event)"})
		elseif field.type=="item"        then widget=makeDropdown("Sélectionner un item...",#itemList>0 and itemList or {"(aucun item)"})
		elseif field.type=="brainrot"    then widget=makeDropdown("Sélectionner un brainrot...",#brainrotList>0 and brainrotList or {"(chargement...)"})
		elseif field.type=="luckyblock"  then widget=makeDropdown("Sélectionner un lucky block...",#luckyBlockList>0 and luckyBlockList or {"(chargement...)"})
		elseif field.type=="mutation"    then widget=makeDropdown("Mutation...",#mutationList>0 and mutationList or {"Normal"})
		elseif field.type=="traitsmulti" then widget=makeMultiDropdown("Traits...",#traitList>0 and traitList or {"(chargement...)"})
		elseif field.type=="onoff"       then widget=makeDropdown("On / Off",{"On","Off"})
		elseif field.type=="bool"        then widget=makeDropdown("true / false",{"true","false"})
		elseif field.type=="number"      then widget=makeInput(field.label..(field.default and ("  (défaut: "..field.default..")") or ""))
		else                                  widget=makeInput(field.label) end
		if field.default and type(widget)=="table" and widget.setValue then widget.setValue(field.default) end
		if field.default and type(widget)~="table" and widget:IsA("TextBox") then widget.Text=field.default end
		local wf=type(widget)=="table" and widget.frame or widget
		wf.Size=UDim2.new(1,0,0,36); wf.LayoutOrder=lo; lo+=1; wf.Parent=formScroll
		table.insert(activeFormFields,{field=field,widget=widget})
	end
	local sp=Instance.new("Frame"); sp.Size=UDim2.new(1,0,0,4); sp.BackgroundTransparency=1; sp.LayoutOrder=lo; lo+=1; sp.Parent=formScroll
	local execBtn=makeExecBtn("EXÉCUTER  —  "..string.upper(cmd.name), isDataDanger and RED or ORANGE)
	execBtn.LayoutOrder=lo; execBtn.Parent=formScroll
	execBtn.MouseButton1Click:Connect(function()
		local args={}; local valid=true
		for _,entry in ipairs(activeFormFields) do
			local f=entry.field; local w=entry.widget; local value
			if type(w)=="table" and w.getValue then value=w.getValue()
			elseif typeof(w)=="Instance" and w:IsA("TextBox") then value=w.Text~="" and w.Text or nil end
			if not value and not f.optional then showNotif("Champ requis : "..f.label,false); valid=false; break end
			if value then
				if f.type=="number" then local n=tonumber(value); if not n then showNotif("Nombre invalide : "..f.label,false); valid=false; break end; args[f.key]=n
				elseif f.type=="traitsmulti" then args[f.key]=value
				elseif f.type=="traits" then local t={}; for part in string.gmatch(value,"([^,]+)") do local tr=part:match("^%s*(.-)%s*$"); if tr~="" then table.insert(t,tr) end end; args[f.key]=#t>0 and t or nil
				elseif f.type=="bool" then args[f.key]=value=="true"
				else args[f.key]=value end
			end
		end
		if valid then
			TweenService:Create(execBtn,TweenInfo.new(0.06),{BackgroundTransparency=0.5}):Play()
			task.delay(0.1,function() if execBtn and execBtn.Parent then TweenService:Create(execBtn,TweenInfo.new(0.1),{BackgroundTransparency=0.05}):Play() end end)
			ExecuteCommand:FireServer(cmd.cmd,args)
		end
	end)
end

-- ============================================================
-- SELECT CATEGORY
-- ============================================================
local function closePanel()
	if toggleDebounce then return end; toggleDebounce=true; guiVisible=false
	TweenService:Create(mainFrame,TweenInfo.new(0.18,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0,W,0,0),BackgroundTransparency=1}):Play()
	task.delay(0.22,function() if mainFrame and mainFrame.Parent then mainFrame.Visible=false end; toggleDebounce=false end)
end

function selectCategory(idx)
	currentCategory=idx; currentCommand=nil
	setActiveSidebar(idx); buildCmdList(idx)
	for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end
	activeFormFields={}; selectHint.Visible=true; formScroll.Visible=false
	if spawnPage then spawnPage.Visible=false end
	if skinPage  then skinPage.Visible=false end
	if itemPage  then itemPage.Visible=false end
	local cat=CATEGORIES[idx]

	if cat and cat.isAnnounce then
		selectHint.Visible=false; formScroll.Visible=true
		local sectLbl=makeLbl("📢  ANNONCES",13,Color3.fromRGB(255,180,50),true); sectLbl.Size=UDim2.new(1,0,0,22); sectLbl.LayoutOrder=0; sectLbl.Parent=formScroll
		local titleLbl=makeLbl("Titre (optionnel) :",9,TEXT3); titleLbl.Size=UDim2.new(1,0,0,14); titleLbl.LayoutOrder=1; titleLbl.Parent=formScroll
		local titleBox=makeInput("Ex: 🎉 EVENT DOUBLE LUCK !"); titleBox.Size=UDim2.new(1,0,0,36); titleBox.LayoutOrder=2; titleBox.Parent=formScroll
		local msgLbl=makeLbl("Message :",9,TEXT3); msgLbl.Size=UDim2.new(1,0,0,14); msgLbl.LayoutOrder=3; msgLbl.Parent=formScroll
		local msgBox=Instance.new("TextBox"); msgBox.Size=UDim2.new(1,0,0,80); msgBox.BackgroundColor3=BG3; msgBox.BackgroundTransparency=0.0
		msgBox.BorderSizePixel=0; msgBox.PlaceholderText="Texte de l'annonce..."; msgBox.PlaceholderColor3=TEXT3; msgBox.Text=""; msgBox.TextColor3=TEXT
		msgBox.TextSize=11; msgBox.Font=Enum.Font.Gotham; msgBox.MultiLine=true; msgBox.TextXAlignment=Enum.TextXAlignment.Left; msgBox.TextYAlignment=Enum.TextYAlignment.Top
		msgBox.ClearTextOnFocus=false; msgBox.LayoutOrder=4; msgBox.Parent=formScroll; mkC(msgBox,6); mkS(msgBox,BORDER,0.4,1); mkP(msgBox,10,0,8,0)
		local row1=Instance.new("Frame"); row1.Size=UDim2.new(1,0,0,56); row1.BackgroundTransparency=1; row1.LayoutOrder=5; row1.Parent=formScroll
		local tgtLbl=makeLbl("Cible :",9,TEXT3); tgtLbl.Size=UDim2.new(0.48,0,0,14); tgtLbl.Position=UDim2.new(0,0,0,0); tgtLbl.Parent=row1
		local tgtDD=makeDropdown("Tous les serveurs",{"Tous les serveurs","Ce serveur","Joueur précis"})
		tgtDD.frame.Size=UDim2.new(0.48,0,0,36); tgtDD.frame.Position=UDim2.new(0,0,0,18); tgtDD.frame.Parent=row1; tgtDD.setValue("Tous les serveurs")
		local typeLbl=makeLbl("Style :",9,TEXT3); typeLbl.Size=UDim2.new(0.48,0,0,14); typeLbl.Position=UDim2.new(0.52,0,0,0); typeLbl.Parent=row1
		local typeDD=makeDropdown("Normal",{"Normal","Arc-en-ciel","Countdown update"})
		typeDD.frame.Size=UDim2.new(0.48,0,0,36); typeDD.frame.Position=UDim2.new(0.52,0,0,18); typeDD.frame.Parent=row1; typeDD.setValue("Normal")
		playerList={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(playerList,p.Name) end
		local spFrame=Instance.new("Frame"); spFrame.Size=UDim2.new(1,0,0,52); spFrame.BackgroundTransparency=1; spFrame.LayoutOrder=6; spFrame.Visible=false; spFrame.Parent=formScroll
		local spLbl=makeLbl("Joueur :",9,TEXT3); spLbl.Size=UDim2.new(1,0,0,14); spLbl.Parent=spFrame
		local spBox=makeDropdown("Sélectionner un joueur...",#playerList>0 and playerList or {"(aucun)"}); spBox.frame.Size=UDim2.new(1,0,0,36); spBox.frame.Position=UDim2.new(0,0,0,18); spBox.frame.Parent=spFrame
		local durFrame=Instance.new("Frame"); durFrame.Size=UDim2.new(1,0,0,52); durFrame.BackgroundTransparency=1; durFrame.LayoutOrder=7; durFrame.Visible=false; durFrame.Parent=formScroll
		local durLbl=makeLbl("Durée (ex: 5m 30s) :",9,TEXT3); durLbl.Size=UDim2.new(1,0,0,14); durLbl.Parent=durFrame
		local durBox=makeInput("5m 30s"); durBox.Size=UDim2.new(1,0,0,36); durBox.Position=UDim2.new(0,0,0,18); durBox.Parent=durFrame
		task.spawn(function()
			local lastTgt=tgtDD.getValue(); local lastTyp=typeDD.getValue()
			while formScroll and formScroll.Parent do
				task.wait(0.15); local t=tgtDD.getValue(); local ty=typeDD.getValue()
				if t~=lastTgt then lastTgt=t; spFrame.Visible=(t=="Joueur précis") end
				if ty~=lastTyp then lastTyp=ty; durFrame.Visible=(ty=="Countdown update") end
			end
		end)
		local sp2=Instance.new("Frame"); sp2.Size=UDim2.new(1,0,0,4); sp2.BackgroundTransparency=1; sp2.LayoutOrder=8; sp2.Parent=formScroll
		local btnRow=Instance.new("Frame"); btnRow.Size=UDim2.new(1,0,0,40); btnRow.BackgroundTransparency=1; btnRow.LayoutOrder=9; btnRow.Parent=formScroll
		local testBtn=Instance.new("TextButton"); testBtn.Size=UDim2.new(0.27,-4,1,0); testBtn.Position=UDim2.new(0,0,0,0)
		testBtn.BackgroundColor3=Color3.fromRGB(140,100,20); testBtn.BackgroundTransparency=0.1; testBtn.BorderSizePixel=0
		testBtn.Text="🧪 TEST"; testBtn.TextColor3=TEXT; testBtn.TextSize=11; testBtn.Font=Enum.Font.GothamBold; testBtn.Parent=btnRow; mkC(testBtn,8)
		local sendBtn=Instance.new("TextButton"); sendBtn.Size=UDim2.new(0.46,-4,1,0); sendBtn.Position=UDim2.new(0.27,4,0,0)
		sendBtn.BackgroundColor3=ORANGE; sendBtn.BackgroundTransparency=0.05; sendBtn.BorderSizePixel=0
		sendBtn.Text="📢 ENVOYER"; sendBtn.TextColor3=Color3.fromRGB(10,10,10); sendBtn.TextSize=12; sendBtn.Font=Enum.Font.GothamBold; sendBtn.Parent=btnRow; mkC(sendBtn,8)
		local stopBtn=Instance.new("TextButton"); stopBtn.Size=UDim2.new(0.27,-4,1,0); stopBtn.Position=UDim2.new(0.73,4,0,0)
		stopBtn.BackgroundColor3=RED; stopBtn.BackgroundTransparency=0.2; stopBtn.BorderSizePixel=0
		stopBtn.Text="⏹ STOP"; stopBtn.TextColor3=TEXT; stopBtn.TextSize=11; stopBtn.Font=Enum.Font.GothamBold; stopBtn.Parent=btnRow; mkC(stopBtn,8)
		testBtn.MouseButton1Click:Connect(function()
			local msg=(titleBox.Text~="" and "["..titleBox.Text.."] " or "")..msgBox.Text
			if msg=="" then showNotif("Message vide !",false); return end
			ExecuteCommand:FireServer("playerannounce",{player=player.Name,text=msg}); showNotif("Test envoyé ✓",true)
		end)
		sendBtn.MouseButton1Click:Connect(function()
			local ty=typeDD.getValue() or "Normal"
			if ty=="Countdown update" then local t=durBox.Text; if t=="" then showNotif("Durée requise",false); return end; ExecuteCommand:FireServer("startupdate",{time=t}); showNotif("Countdown démarré ✓",true); return end
			local msg=(titleBox.Text~="" and "["..titleBox.Text.."] " or "")..msgBox.Text
			if msg=="" then showNotif("Message vide !",false); return end
			local tgt=tgtDD.getValue() or "Tous les serveurs"
			if tgt=="Tous les serveurs" then
				if ty=="Arc-en-ciel" then ExecuteCommand:FireServer("rainbowannounce",{text=msg}) else ExecuteCommand:FireServer("globalannounce",{text=msg}) end; showNotif("Annonce globale ✓",true)
			elseif tgt=="Ce serveur" then ExecuteCommand:FireServer("announce",{text=msg}); showNotif("Annonce locale ✓",true)
			elseif tgt=="Joueur précis" then
				local pn=spBox.getValue(); if not pn or pn=="" then showNotif("Sélectionner un joueur",false); return end
				ExecuteCommand:FireServer("playerannounce",{player=pn,text=msg}); showNotif("Envoyé à "..pn.." ✓",true)
			end
		end)
		stopBtn.MouseButton1Click:Connect(function() ExecuteCommand:FireServer("stopupdate",{}); showNotif("Countdown arrêté ✓",true) end)
		return
	end

	if cat and cat.isCount then
		selectHint.Visible=false; formScroll.Visible=true
		local loadLbl=makeLbl("⏳ Chargement...",11,TEXT3); loadLbl.Size=UDim2.new(1,0,0,22); loadLbl.TextXAlignment=Enum.TextXAlignment.Center; loadLbl.LayoutOrder=0; loadLbl.Parent=formScroll
		task.spawn(function()
			local ok,data=pcall(function() return GetBrainrotData:InvokeServer() end)
			if not ok or not data then if loadLbl and loadLbl.Parent then loadLbl.Text="Erreur." end; return end
			if loadLbl and loadLbl.Parent then loadLbl:Destroy() end
			local RARITY_ORDER={"Secret","Mythic","OG","Legendary","Epic","Rare","Uncommon","Common"}
			local lo=0; local selectedRarity=nil
			local showRarities,showRarity,showBrainrotDetail
			local function clearF() for _,c in ipairs(formScroll:GetChildren()) do if not c:IsA("UIListLayout") and not c:IsA("UIPadding") then c:Destroy() end end; lo=0 end
			showBrainrotDetail=function(br)
				clearF()
				local bb=Instance.new("TextButton"); bb.Size=UDim2.new(1,0,0,30); bb.BackgroundColor3=BG3; bb.BackgroundTransparency=0.1; bb.BorderSizePixel=0; bb.Text="← Retour à "..selectedRarity; bb.TextColor3=TEXT2; bb.TextSize=10; bb.Font=Enum.Font.Gotham; bb.LayoutOrder=lo; lo+=1; bb.Parent=formScroll; mkC(bb,6)
				local tl=makeLbl(br.displayName,14,TEXT,true); tl.Size=UDim2.new(1,0,0,22); tl.LayoutOrder=lo; lo+=1; tl.Parent=formScroll
				local tot=0; for _,n in pairs(br.counts) do tot+=n end
				local totL=makeLbl("Total : "..tot,11,TEXT2); totL.Size=UDim2.new(1,0,0,18); totL.LayoutOrder=lo; lo+=1; totL.Parent=formScroll
				if tot==0 then local nl=makeLbl("Aucun joueur.",10,TEXT3); nl.Size=UDim2.new(1,0,0,18); nl.LayoutOrder=lo; lo+=1; nl.Parent=formScroll
				else
					local ml={}; for m,c in pairs(br.counts) do table.insert(ml,{mut=m,count=c}) end; table.sort(ml,function(a,b) return a.count>b.count end)
					for _,e in ipairs(ml) do
						local row=Instance.new("Frame"); row.Size=UDim2.new(1,0,0,30); row.BackgroundColor3=BG3; row.BackgroundTransparency=0.15; row.BorderSizePixel=0; row.LayoutOrder=lo; lo+=1; row.Parent=formScroll; mkC(row,6)
						local mL=makeLbl(e.mut,10,TEXT2); mL.Size=UDim2.new(0.7,0,1,0); mL.Position=UDim2.new(0,10,0,0); mL.Parent=row
						local cL=Instance.new("TextLabel"); cL.Size=UDim2.new(0.3,-10,1,0); cL.Position=UDim2.new(0.7,0,0,0); cL.BackgroundTransparency=1; cL.Text="x"..e.count; cL.TextColor3=GOLD; cL.TextSize=12; cL.Font=Enum.Font.GothamBold; cL.TextXAlignment=Enum.TextXAlignment.Right; cL.Parent=row; mkP(cL,0,8,0,0)
					end
				end
				bb.MouseButton1Click:Connect(function() showRarity(selectedRarity) end)
			end
			showRarity=function(rarity)
				selectedRarity=rarity; clearF(); local rd=data[rarity] or {}
				local bb=Instance.new("TextButton"); bb.Size=UDim2.new(1,0,0,30); bb.BackgroundColor3=BG3; bb.BackgroundTransparency=0.1; bb.BorderSizePixel=0; bb.Text="← Retour aux raretés"; bb.TextColor3=TEXT2; bb.TextSize=10; bb.Font=Enum.Font.Gotham; bb.LayoutOrder=lo; lo+=1; bb.Parent=formScroll; mkC(bb,6)
				local tl=makeLbl(rarity.." ("..#rd..")",13,TEXT,true); tl.Size=UDim2.new(1,0,0,22); tl.LayoutOrder=lo; lo+=1; tl.Parent=formScroll
				for _,br in ipairs(rd) do
					local tot=0; for _,n in pairs(br.counts) do tot+=n end
					local btn2=Instance.new("TextButton"); btn2.Size=UDim2.new(1,0,0,32); btn2.BackgroundColor3=BG3; btn2.BackgroundTransparency=0.15; btn2.BorderSizePixel=0; btn2.Text=""; btn2.LayoutOrder=lo; lo+=1; btn2.Parent=formScroll; mkC(btn2,6); mkS(btn2,BORDER,0.5,1)
					local nL=makeLbl(br.displayName,10,tot>0 and TEXT2 or TEXT3); nL.Size=UDim2.new(0.75,0,1,0); nL.Position=UDim2.new(0,10,0,0); nL.Parent=btn2
					local cL=Instance.new("TextLabel"); cL.Size=UDim2.new(0.25,-8,1,0); cL.Position=UDim2.new(0.75,0,0,0); cL.BackgroundTransparency=1; cL.Text=tot>0 and ("x"..tot) or "—"; cL.TextColor3=tot>0 and GOLD or TEXT3; cL.TextSize=11; cL.Font=Enum.Font.GothamBold; cL.TextXAlignment=Enum.TextXAlignment.Right; cL.Parent=btn2; mkP(cL,0,8,0,0)
					btn2.MouseEnter:Connect(function() TweenService:Create(btn2,TweenInfo.new(0.08),{BackgroundTransparency=0.0}):Play() end)
					btn2.MouseLeave:Connect(function() TweenService:Create(btn2,TweenInfo.new(0.08),{BackgroundTransparency=0.15}):Play() end)
					local b=br; btn2.MouseButton1Click:Connect(function() showBrainrotDetail(b) end)
				end
				bb.MouseButton1Click:Connect(function() showRarities() end)
			end
			showRarities=function()
				clearF()
				local hRow=Instance.new("Frame"); hRow.Size=UDim2.new(1,0,0,28); hRow.BackgroundTransparency=1; hRow.LayoutOrder=lo; lo+=1; hRow.Parent=formScroll
				local t2=makeLbl("📊  STATS BRAINROTS",13,TEXT,true); t2.Size=UDim2.new(1,-72,1,0); t2.Parent=hRow
				local refBtn=Instance.new("TextButton"); refBtn.Size=UDim2.new(0,64,0,22); refBtn.Position=UDim2.new(1,-66,0.5,-11); refBtn.BackgroundColor3=BG3; refBtn.BackgroundTransparency=0.1; refBtn.BorderSizePixel=0; refBtn.Text="↻ Refresh"; refBtn.TextColor3=TEXT2; refBtn.TextSize=10; refBtn.Font=Enum.Font.Gotham; refBtn.Parent=hRow; mkC(refBtn,6); mkS(refBtn,BORDER,0.5,1)
				refBtn.MouseButton1Click:Connect(function() refBtn.Text="..."; task.spawn(function() local ok2,nd=pcall(function() return GetBrainrotData:InvokeServer() end); if ok2 and nd then data=nd end; showRarities() end) end)
				for _,rarity in ipairs(RARITY_ORDER) do
					local rd=data[rarity]
					if rd and #rd>0 then
						local tot=0; for _,br in ipairs(rd) do for _,n in pairs(br.counts) do tot+=n end end
						local btn2=Instance.new("TextButton"); btn2.Size=UDim2.new(1,0,0,38); btn2.BackgroundColor3=BG3; btn2.BackgroundTransparency=0.1; btn2.BorderSizePixel=0; btn2.Text=""; btn2.LayoutOrder=lo; lo+=1; btn2.Parent=formScroll; mkC(btn2,8); mkS(btn2,BORDER,0.5,1)
						local rL=makeLbl(rarity,11,TEXT,true); rL.Size=UDim2.new(0.6,0,1,0); rL.Position=UDim2.new(0,12,0,0); rL.Parent=btn2
						local sL=Instance.new("TextLabel"); sL.Size=UDim2.new(0.4,-10,1,0); sL.Position=UDim2.new(0.6,0,0,0); sL.BackgroundTransparency=1; sL.Text=#rd.." types  ·  x"..tot; sL.TextColor3=TEXT3; sL.TextSize=9; sL.Font=Enum.Font.Gotham; sL.TextXAlignment=Enum.TextXAlignment.Right; sL.Parent=btn2; mkP(sL,0,8,0,0)
						btn2.MouseEnter:Connect(function() TweenService:Create(btn2,TweenInfo.new(0.08),{BackgroundTransparency=0.0}):Play() end)
						btn2.MouseLeave:Connect(function() TweenService:Create(btn2,TweenInfo.new(0.08),{BackgroundTransparency=0.1}):Play() end)
						local r=rarity; btn2.MouseButton1Click:Connect(function() showRarity(r) end)
					end
				end
			end
			showRarities()
		end)
	end
end

-- ============================================================
-- SPAWN PAGE
-- ============================================================
local spawnPage = Instance.new("Frame")
spawnPage.Size=UDim2.new(1,0,1,0); spawnPage.BackgroundColor3=BG; spawnPage.BackgroundTransparency=0
spawnPage.BorderSizePixel=0; spawnPage.Visible=false; spawnPage.ZIndex=20; spawnPage.Parent=rightZone; mkC(spawnPage,0)

local spawnHeader=Instance.new("Frame"); spawnHeader.Size=UDim2.new(1,0,0,46); spawnHeader.BackgroundColor3=BG2; spawnHeader.BackgroundTransparency=0.50; spawnHeader.BorderSizePixel=0; spawnHeader.ZIndex=21; spawnHeader.Parent=spawnPage
local spawnTitleLbl=Instance.new("TextLabel"); spawnTitleLbl.Size=UDim2.new(1,-110,1,0); spawnTitleLbl.Position=UDim2.new(0,14,0,0); spawnTitleLbl.BackgroundTransparency=1; spawnTitleLbl.Text="⚡  SPAWN BRAINROT"; spawnTitleLbl.TextColor3=TEXT; spawnTitleLbl.TextSize=14; spawnTitleLbl.Font=Enum.Font.GothamBold; spawnTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; spawnTitleLbl.ZIndex=22; spawnTitleLbl.Parent=spawnHeader
local spawnBackBtn=Instance.new("TextButton"); spawnBackBtn.Size=UDim2.new(0,82,0,28); spawnBackBtn.Position=UDim2.new(1,-90,0.5,-14); spawnBackBtn.BackgroundColor3=BG3; spawnBackBtn.BackgroundTransparency=0.1; spawnBackBtn.BorderSizePixel=0; spawnBackBtn.Text="← Retour"; spawnBackBtn.TextColor3=TEXT2; spawnBackBtn.TextSize=11; spawnBackBtn.Font=Enum.Font.Gotham; spawnBackBtn.ZIndex=22; spawnBackBtn.Parent=spawnHeader; mkC(spawnBackBtn,6); mkS(spawnBackBtn,BORDER,0.4,1)
spawnBackBtn.MouseButton1Click:Connect(function() spawnPage.Visible=false end)
local spawnHDiv=Instance.new("Frame"); spawnHDiv.Size=UDim2.new(1,0,0,1); spawnHDiv.Position=UDim2.new(0,0,1,-1); spawnHDiv.BackgroundColor3=ORANGE; spawnHDiv.BackgroundTransparency=0.4; spawnHDiv.BorderSizePixel=0; spawnHDiv.ZIndex=22; spawnHDiv.Parent=spawnHeader

local spawnSearchBox=Instance.new("TextBox"); spawnSearchBox.Size=UDim2.new(1,-24,0,32); spawnSearchBox.Position=UDim2.new(0,12,0,52); spawnSearchBox.BackgroundColor3=BG3; spawnSearchBox.BackgroundTransparency=0.0; spawnSearchBox.BorderSizePixel=0; spawnSearchBox.PlaceholderText="🔍 Rechercher..."; spawnSearchBox.PlaceholderColor3=TEXT3; spawnSearchBox.Text=""; spawnSearchBox.TextColor3=TEXT; spawnSearchBox.TextSize=12; spawnSearchBox.Font=Enum.Font.Gotham; spawnSearchBox.ClearTextOnFocus=false; spawnSearchBox.ZIndex=21; spawnSearchBox.Parent=spawnPage; mkC(spawnSearchBox,8); mkS(spawnSearchBox,ORANGE,0.5,1); mkP(spawnSearchBox,12,0,0,0)

local mutSection=Instance.new("Frame"); mutSection.Size=UDim2.new(1,-24,0,54); mutSection.Position=UDim2.new(0,12,0,92); mutSection.BackgroundTransparency=1; mutSection.ZIndex=21; mutSection.Parent=spawnPage
local mutLabel=Instance.new("TextLabel"); mutLabel.Size=UDim2.new(1,0,0,14); mutLabel.BackgroundTransparency=1; mutLabel.Text="✦ Mutation"; mutLabel.TextColor3=TEXT3; mutLabel.TextSize=9; mutLabel.Font=Enum.Font.GothamBold; mutLabel.TextXAlignment=Enum.TextXAlignment.Left; mutLabel.ZIndex=22; mutLabel.Parent=mutSection
local mutScroll=Instance.new("ScrollingFrame"); mutScroll.Size=UDim2.new(1,0,0,34); mutScroll.Position=UDim2.new(0,0,0,16); mutScroll.BackgroundTransparency=1; mutScroll.BorderSizePixel=0; mutScroll.ScrollBarThickness=0; mutScroll.CanvasSize=UDim2.new(0,0,0,34); mutScroll.ScrollingDirection=Enum.ScrollingDirection.X; mutScroll.ZIndex=21; mutScroll.Parent=mutSection
local mutLayout=Instance.new("UIListLayout"); mutLayout.FillDirection=Enum.FillDirection.Horizontal; mutLayout.Padding=UDim.new(0,4); mutLayout.Parent=mutScroll

local traitSection=Instance.new("Frame"); traitSection.Size=UDim2.new(1,-24,0,54); traitSection.Position=UDim2.new(0,12,0,150); traitSection.BackgroundTransparency=1; traitSection.ZIndex=21; traitSection.Parent=spawnPage
local traitLabel=Instance.new("TextLabel"); traitLabel.Size=UDim2.new(1,-130,0,14); traitLabel.BackgroundTransparency=1; traitLabel.Text="✦ Traits (optionnel)"; traitLabel.TextColor3=TEXT3; traitLabel.TextSize=9; traitLabel.Font=Enum.Font.GothamBold; traitLabel.TextXAlignment=Enum.TextXAlignment.Left; traitLabel.ZIndex=22; traitLabel.Parent=traitSection
local traitResetBtn=Instance.new("TextButton"); traitResetBtn.Size=UDim2.new(0,110,0,14); traitResetBtn.Position=UDim2.new(1,-112,0,0); traitResetBtn.BackgroundTransparency=1; traitResetBtn.BorderSizePixel=0; traitResetBtn.Text="□ Réinitialiser"; traitResetBtn.TextColor3=TEXT3; traitResetBtn.TextSize=9; traitResetBtn.Font=Enum.Font.Gotham; traitResetBtn.ZIndex=22; traitResetBtn.Parent=traitSection; traitResetBtn.TextXAlignment=Enum.TextXAlignment.Right
local traitScroll=Instance.new("ScrollingFrame"); traitScroll.Size=UDim2.new(1,0,0,34); traitScroll.Position=UDim2.new(0,0,0,16); traitScroll.BackgroundTransparency=1; traitScroll.BorderSizePixel=0; traitScroll.ScrollBarThickness=0; traitScroll.CanvasSize=UDim2.new(0,0,0,34); traitScroll.ScrollingDirection=Enum.ScrollingDirection.X; traitScroll.ZIndex=21; traitScroll.Parent=traitSection
local traitLayout=Instance.new("UIListLayout"); traitLayout.FillDirection=Enum.FillDirection.Horizontal; traitLayout.Padding=UDim.new(0,4); traitLayout.Parent=traitScroll

local spawnBar=Instance.new("Frame"); spawnBar.Size=UDim2.new(1,-24,0,40); spawnBar.Position=UDim2.new(0,12,0,210); spawnBar.BackgroundTransparency=1; spawnBar.ZIndex=21; spawnBar.Parent=spawnPage
local amountBox=Instance.new("TextBox"); amountBox.Size=UDim2.new(0,56,1,0); amountBox.BackgroundColor3=BG3; amountBox.BackgroundTransparency=0.0; amountBox.BorderSizePixel=0; amountBox.Text="1"; amountBox.PlaceholderText="Qté"; amountBox.PlaceholderColor3=TEXT3; amountBox.TextColor3=TEXT; amountBox.TextSize=12; amountBox.Font=Enum.Font.GothamBold; amountBox.ClearTextOnFocus=false; amountBox.ZIndex=22; amountBox.Parent=spawnBar; mkC(amountBox,8); mkS(amountBox,BORDER,0.4,1); mkP(amountBox,10,0,0,0)
local localBtn=Instance.new("TextButton"); localBtn.Size=UDim2.new(0,84,1,0); localBtn.Position=UDim2.new(0,62,0,0); localBtn.BackgroundColor3=ORANGE; localBtn.BackgroundTransparency=0.0; localBtn.BorderSizePixel=0; localBtn.Text="LOCAL"; localBtn.TextColor3=Color3.fromRGB(10,10,10); localBtn.TextSize=12; localBtn.Font=Enum.Font.GothamBold; localBtn.ZIndex=22; localBtn.Parent=spawnBar; mkC(localBtn,8)
local globalBtn=Instance.new("TextButton"); globalBtn.Size=UDim2.new(0,84,1,0); globalBtn.Position=UDim2.new(0,150,0,0); globalBtn.BackgroundColor3=BG3; globalBtn.BackgroundTransparency=0.1; globalBtn.BorderSizePixel=0; globalBtn.Text="GLOBAL"; globalBtn.TextColor3=TEXT2; globalBtn.TextSize=12; globalBtn.Font=Enum.Font.Gotham; globalBtn.ZIndex=22; globalBtn.Parent=spawnBar; mkC(globalBtn,8); mkS(globalBtn,BORDER,0.4,1)
local spawnExecBtn=Instance.new("TextButton"); spawnExecBtn.Size=UDim2.new(1,-244,1,0); spawnExecBtn.Position=UDim2.new(0,242,0,0); spawnExecBtn.BackgroundColor3=ORANGE; spawnExecBtn.BackgroundTransparency=0.05; spawnExecBtn.BorderSizePixel=0; spawnExecBtn.Text="⚡  SPAWN"; spawnExecBtn.TextColor3=Color3.fromRGB(10,10,10); spawnExecBtn.TextSize=13; spawnExecBtn.Font=Enum.Font.GothamBold; spawnExecBtn.ZIndex=22; spawnExecBtn.Parent=spawnBar; mkC(spawnExecBtn,8)

local brainrotGrid=Instance.new("ScrollingFrame"); brainrotGrid.Size=UDim2.new(1,-24,1,-262); brainrotGrid.Position=UDim2.new(0,12,0,258); brainrotGrid.BackgroundTransparency=1; brainrotGrid.BorderSizePixel=0; brainrotGrid.ScrollBarThickness=3; brainrotGrid.ScrollBarImageColor3=ORANGE; brainrotGrid.CanvasSize=UDim2.new(0,0,0,0); brainrotGrid.AutomaticCanvasSize=Enum.AutomaticSize.Y; brainrotGrid.ZIndex=21; brainrotGrid.Parent=spawnPage
local gridLayout=Instance.new("UIGridLayout"); gridLayout.CellSize=UDim2.new(0,112,0,128); gridLayout.CellPadding=UDim2.new(0,7,0,7); gridLayout.Parent=brainrotGrid; mkP(brainrotGrid,4,4,4,4)

local spawnState={selectedBrainrot=nil,selectedMutation="Normal",selectedTraits={},isGlobal=false,mode="brainrot"}
local mutBtns={} local traitBtns={} local brainrotBtns={}

local function refreshMutBtns()
	for mut,data in pairs(mutBtns) do
		local on=(mut==spawnState.selectedMutation)
		TweenService:Create(data.btn,TweenInfo.new(0.1),{BackgroundColor3=on and ORANGE or BG3,BackgroundTransparency=on and 0.0 or 0.1}):Play()
		data.lbl.TextColor3=on and Color3.fromRGB(10,10,10) or TEXT2; data.lbl.Font=on and Enum.Font.GothamBold or Enum.Font.Gotham
	end
end
local function refreshTraitBtns()
	for trait,data in pairs(traitBtns) do
		local on=table.find(spawnState.selectedTraits,trait)~=nil
		TweenService:Create(data.btn,TweenInfo.new(0.1),{BackgroundColor3=on and Color3.fromRGB(80,140,255) or BG3,BackgroundTransparency=on and 0.0 or 0.1}):Play()
		data.lbl.TextColor3=on and Color3.fromRGB(10,10,10) or TEXT2
	end
end
local function refreshScopeBtn()
	if spawnState.isGlobal then
		globalBtn.BackgroundColor3=Color3.fromRGB(80,140,255); globalBtn.BackgroundTransparency=0.0; globalBtn.TextColor3=Color3.fromRGB(10,10,10); globalBtn.Font=Enum.Font.GothamBold
		localBtn.BackgroundColor3=BG3; localBtn.BackgroundTransparency=0.1; localBtn.TextColor3=TEXT2; localBtn.Font=Enum.Font.Gotham
	else
		localBtn.BackgroundColor3=ORANGE; localBtn.BackgroundTransparency=0.0; localBtn.TextColor3=Color3.fromRGB(10,10,10); localBtn.Font=Enum.Font.GothamBold
		globalBtn.BackgroundColor3=BG3; globalBtn.BackgroundTransparency=0.1; globalBtn.TextColor3=TEXT2; globalBtn.Font=Enum.Font.Gotham
	end
end
localBtn.MouseButton1Click:Connect(function() spawnState.isGlobal=false; refreshScopeBtn() end)
globalBtn.MouseButton1Click:Connect(function() spawnState.isGlobal=true; refreshScopeBtn() end)
traitResetBtn.MouseButton1Click:Connect(function() spawnState.selectedTraits={}; refreshTraitBtns() end)

local function buildMutBtns(mutations)
	for _,c in ipairs(mutScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; mutBtns={}
	for _,mut in ipairs(mutations) do
		local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,0,1,0); btn.AutomaticSize=Enum.AutomaticSize.X; btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.1; btn.BorderSizePixel=0; btn.Text=""; btn.ZIndex=22; btn.Parent=mutScroll; mkC(btn,8)
		local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1; lbl.Text=mut; lbl.TextColor3=TEXT2; lbl.TextSize=11; lbl.Font=Enum.Font.Gotham; lbl.ZIndex=23; lbl.Parent=btn; mkP(lbl,10,10,0,0)
		mutBtns[mut]={btn=btn,lbl=lbl}; btn.MouseButton1Click:Connect(function() spawnState.selectedMutation=mut; refreshMutBtns() end)
	end
	task.wait(); local totalW=0; for _,c in ipairs(mutScroll:GetChildren()) do if c:IsA("TextButton") then totalW+=c.AbsoluteSize.X+4 end end
	mutScroll.CanvasSize=UDim2.new(0,totalW,0,34); refreshMutBtns()
end
local function buildTraitBtns(traits)
	for _,c in ipairs(traitScroll:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end; traitBtns={}
	for _,trait in ipairs(traits) do
		local btn=Instance.new("TextButton"); btn.Size=UDim2.new(0,0,1,0); btn.AutomaticSize=Enum.AutomaticSize.X; btn.BackgroundColor3=BG3; btn.BackgroundTransparency=0.1; btn.BorderSizePixel=0; btn.Text=""; btn.ZIndex=22; btn.Parent=traitScroll; mkC(btn,8)
		local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,0,1,0); lbl.BackgroundTransparency=1; lbl.Text=trait; lbl.TextColor3=TEXT2; lbl.TextSize=10; lbl.Font=Enum.Font.Gotham; lbl.ZIndex=23; lbl.Parent=btn; mkP(lbl,8,8,0,0)
		traitBtns[trait]={btn=btn,lbl=lbl}
		btn.MouseButton1Click:Connect(function()
			local idx=table.find(spawnState.selectedTraits,trait)
			if idx then table.remove(spawnState.selectedTraits,idx) else table.insert(spawnState.selectedTraits,trait) end; refreshTraitBtns()
		end)
	end
	task.wait(); local totalW=0; for _,c in ipairs(traitScroll:GetChildren()) do if c:IsA("TextButton") then totalW+=c.AbsoluteSize.X+4 end end
	traitScroll.CanvasSize=UDim2.new(0,totalW,0,34)
end

local function buildGrid(list, filterText, isEvent)
	for _,c in ipairs(brainrotGrid:GetChildren()) do if not c:IsA("UIGridLayout") and not c:IsA("UIPadding") then c:Destroy() end end; brainrotBtns={}
	local fl=(filterText or ""):lower()
	for _,name in ipairs(list) do
		if fl=="" or name:lower():find(fl,1,true) then
			local card=Instance.new("TextButton"); card.BackgroundColor3=BG3; card.BackgroundTransparency=0.1; card.BorderSizePixel=0; card.Text=""; card.ZIndex=22; card.Parent=brainrotGrid; mkC(card,10); mkS(card,BORDER,0.5,1)
			local imgZone=Instance.new("Frame"); imgZone.Size=UDim2.new(1,-6,0,80); imgZone.Position=UDim2.new(0,3,0,3); imgZone.BackgroundColor3=Color3.fromRGB(12,12,18); imgZone.BackgroundTransparency=0.0; imgZone.BorderSizePixel=0; imgZone.ClipsDescendants=true; imgZone.ZIndex=23; imgZone.Parent=card; mkC(imgZone,8)
			if isEvent then
				local evIcon=Instance.new("TextLabel"); evIcon.Size=UDim2.new(1,0,1,0); evIcon.BackgroundTransparency=1; evIcon.Text="🗓️"; evIcon.TextSize=36; evIcon.Font=Enum.Font.Gotham; evIcon.ZIndex=24; evIcon.Parent=imgZone
			else
				local vp=Instance.new("ViewportFrame"); vp.Size=UDim2.new(1,0,1,0); vp.BackgroundTransparency=1; vp.Ambient=Color3.fromRGB(180,180,220); vp.LightColor=Color3.fromRGB(255,248,230); vp.LightDirection=Vector3.new(-1,-2,-1); vp.ZIndex=24; vp.Parent=imgZone
				local vpCam=Instance.new("Camera"); vpCam.Parent=vp; vp.CurrentCamera=vpCam
				local cardRef=card; local vpRef=vp; local camRef=vpCam; local imgRef=imgZone
				task.spawn(function()
					task.wait(0.05); local model=nil
					if AnimalModels then model=AnimalModels:FindFirstChild(name); if not model then for _,child in ipairs(AnimalModels:GetChildren()) do if child.Name:lower()==name:lower() then model=child; break end end end end
					if model and cardRef and cardRef.Parent then
						local ok,clone=pcall(function() return model:Clone() end)
						if ok and clone then
							for _,s in ipairs(clone:GetDescendants()) do if s:IsA("Script") or s:IsA("LocalScript") then s.Disabled=true end; if s:IsA("ParticleEmitter") or s:IsA("Trail") or s:IsA("Beam") then s.Enabled=false end end
							clone.Parent=vpRef; local cf,sz; pcall(function() cf,sz=clone:GetBoundingBox() end)
							if cf and sz then local d=math.max(sz.X,sz.Y,sz.Z); camRef.CFrame=CFrame.new(cf.Position+Vector3.new(d*0.5,d*0.35,d*0.9),cf.Position+Vector3.new(0,d*0.1,0))
							else camRef.CFrame=CFrame.new(Vector3.new(0,4,10),Vector3.new(0,2,0)) end
						end
					else if imgRef and imgRef.Parent then local ph=Instance.new("TextLabel"); ph.Size=UDim2.new(1,0,1,0); ph.BackgroundTransparency=1; ph.Text=string.sub(name,1,1):upper(); ph.TextSize=32; ph.Font=Enum.Font.GothamBold; ph.TextColor3=Color3.fromRGB(60,60,80); ph.ZIndex=25; ph.Parent=imgRef end end
				end)
			end
			local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-4,0,38); lbl.Position=UDim2.new(0,2,0,84); lbl.BackgroundTransparency=1; lbl.Text=name; lbl.TextColor3=TEXT2; lbl.TextSize=9; lbl.Font=Enum.Font.Gotham; lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.TextWrapped=true; lbl.TextXAlignment=Enum.TextXAlignment.Center; lbl.ZIndex=23; lbl.Parent=card
			brainrotBtns[name]={btn=card,lbl=lbl}
			card.MouseEnter:Connect(function() if spawnState.selectedBrainrot~=name then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG4,BackgroundTransparency=0.0}):Play() end end)
			card.MouseLeave:Connect(function() if spawnState.selectedBrainrot~=name then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play() end end)
			card.MouseButton1Click:Connect(function()
				if spawnState.selectedBrainrot and brainrotBtns[spawnState.selectedBrainrot] then local old=brainrotBtns[spawnState.selectedBrainrot]; if old.btn and old.btn.Parent then TweenService:Create(old.btn,TweenInfo.new(0.12),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play(); old.lbl.TextColor3=TEXT2; old.lbl.Font=Enum.Font.Gotham; for _,s in ipairs(old.btn:GetChildren()) do if s:IsA("UIStroke") then s.Color=BORDER; s.Transparency=0.5; s.Thickness=1 end end end end
				spawnState.selectedBrainrot=name; TweenService:Create(card,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(35,28,8),BackgroundTransparency=0.0}):Play()
				lbl.TextColor3=ORANGE; lbl.Font=Enum.Font.GothamBold
				for _,s in ipairs(card:GetChildren()) do if s:IsA("UIStroke") then s.Color=ORANGE; s.Transparency=0.0; s.Thickness=2 end end
				spawnExecBtn.Text=isEvent and ("▶  LANCER  —  "..name) or ("⚡  SPAWN  —  "..name)
			end)
		end
	end
end

spawnSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local mode=spawnState.mode
	if mode=="brainrot" then buildGrid(brainrotList,spawnSearchBox.Text,false)
	elseif mode=="luckyblock" then buildGrid(luckyBlockList,spawnSearchBox.Text,false)
	elseif mode=="event" then buildGrid(eventList,spawnSearchBox.Text,true) end
end)
spawnExecBtn.MouseButton1Click:Connect(function()
	local selected=spawnState.selectedBrainrot
	if not selected or selected=="" then showNotif("Sélectionne d'abord un élément !",false); return end
	local amount=tonumber(amountBox.Text) or 1; local mutation=spawnState.selectedMutation~="Normal" and spawnState.selectedMutation or nil; local traits=#spawnState.selectedTraits>0 and spawnState.selectedTraits or nil; local mode=spawnState.mode
	if mode=="event" then if spawnState.isGlobal then ExecuteCommand:FireServer("executeglobalevent",{event=selected}); showNotif("Global event : "..selected,true) else ExecuteCommand:FireServer("executeevent",{event=selected}); showNotif("Event local : "..selected,true) end; return end
	local cmd=mode=="luckyblock" and (spawnState.isGlobal and "spawngloballuckyblock" or "spawnluckyblock") or (spawnState.isGlobal and "spawnglobalbrainrot" or "spawnbrainrot")
	ExecuteCommand:FireServer(cmd,{brainrot=selected,mutation=mutation,traits=traits,amount=amount}); showNotif((spawnState.isGlobal and "🌍 Global" or "📍 Local").." — "..selected,true)
	TweenService:Create(spawnExecBtn,TweenInfo.new(0.06),{BackgroundTransparency=0.5}):Play(); task.delay(0.12,function() if spawnExecBtn and spawnExecBtn.Parent then TweenService:Create(spawnExecBtn,TweenInfo.new(0.1),{BackgroundTransparency=0.05}):Play() end end)
end)

openSpawnPage = function(mode)
	spawnState.selectedBrainrot=nil; spawnState.selectedMutation="Normal"; spawnState.selectedTraits={}; spawnState.isGlobal=false; spawnState.mode=mode; spawnSearchBox.Text=""; amountBox.Text="1"
	if #brainrotList==0 then local ok,br=pcall(function() return GetBrainrots:InvokeServer() end); brainrotList=(ok and br) and br or {} end
	if #luckyBlockList==0 then local ok,lb=pcall(function() return GetLuckyBlocks:InvokeServer() end); luckyBlockList=(ok and lb) and lb or {} end
	if #mutationList==0 then local ok,mu=pcall(function() return GetMutations:InvokeServer() end); mutationList=(ok and mu) and mu or {"Normal"} end
	if #traitList==0 then local ok,tr=pcall(function() return GetTraits:InvokeServer() end); traitList=(ok and tr) and tr or {} end
	if #eventList==0 then local ok,ev=pcall(function() return GetEvents:InvokeServer() end); eventList=(ok and ev) and ev or {} end
	if mode=="event" then spawnTitleLbl.Text="🗓️  EVENTS"; mutSection.Visible=false; traitSection.Visible=false; spawnBar.Position=UDim2.new(0,12,0,92); brainrotGrid.Position=UDim2.new(0,12,0,142); brainrotGrid.Size=UDim2.new(1,-24,1,-146); amountBox.Visible=false; spawnExecBtn.Text="▶  LANCER L'EVENT"; buildGrid(eventList,"",true)
	elseif mode=="luckyblock" then spawnTitleLbl.Text="🎰  LUCKY BLOCKS"; mutSection.Visible=true; traitSection.Visible=false; spawnBar.Position=UDim2.new(0,12,0,154); brainrotGrid.Position=UDim2.new(0,12,0,202); brainrotGrid.Size=UDim2.new(1,-24,1,-206); amountBox.Visible=true; spawnExecBtn.Text="⚡  SPAWN"; buildMutBtns(mutationList); buildGrid(luckyBlockList,"",false)
	else spawnTitleLbl.Text="⚡  SPAWN BRAINROT"; mutSection.Visible=true; traitSection.Visible=true; spawnBar.Position=UDim2.new(0,12,0,210); brainrotGrid.Position=UDim2.new(0,12,0,258); brainrotGrid.Size=UDim2.new(1,-24,1,-262); amountBox.Visible=true; spawnExecBtn.Text="⚡  SPAWN"; buildMutBtns(mutationList); buildTraitBtns(traitList); buildGrid(brainrotList,"",false) end
	refreshScopeBtn(); refreshMutBtns(); spawnPage.Visible=true
end

-- ============================================================
-- ★ ITEM PAGE — Grille carrée avec image des items
-- ============================================================
local itemPage = Instance.new("Frame")
itemPage.Size=UDim2.new(1,0,1,0); itemPage.BackgroundColor3=BG; itemPage.BackgroundTransparency=0
itemPage.BorderSizePixel=0; itemPage.Visible=false; itemPage.ZIndex=20; itemPage.Parent=rightZone; mkC(itemPage,0)

-- Header
local itemHeader=Instance.new("Frame"); itemHeader.Size=UDim2.new(1,0,0,46); itemHeader.BackgroundColor3=BG2; itemHeader.BackgroundTransparency=0.50; itemHeader.BorderSizePixel=0; itemHeader.ZIndex=21; itemHeader.Parent=itemPage
local itemTitleLbl=Instance.new("TextLabel"); itemTitleLbl.Size=UDim2.new(1,-110,1,0); itemTitleLbl.Position=UDim2.new(0,14,0,0); itemTitleLbl.BackgroundTransparency=1; itemTitleLbl.Text="🎒  GIVE ITEM"; itemTitleLbl.TextColor3=TEXT; itemTitleLbl.TextSize=14; itemTitleLbl.Font=Enum.Font.GothamBold; itemTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; itemTitleLbl.ZIndex=22; itemTitleLbl.Parent=itemHeader
local itemBackBtn=Instance.new("TextButton"); itemBackBtn.Size=UDim2.new(0,82,0,28); itemBackBtn.Position=UDim2.new(1,-90,0.5,-14); itemBackBtn.BackgroundColor3=BG3; itemBackBtn.BackgroundTransparency=0.1; itemBackBtn.BorderSizePixel=0; itemBackBtn.Text="← Retour"; itemBackBtn.TextColor3=TEXT2; itemBackBtn.TextSize=11; itemBackBtn.Font=Enum.Font.Gotham; itemBackBtn.ZIndex=22; itemBackBtn.Parent=itemHeader; mkC(itemBackBtn,6); mkS(itemBackBtn,BORDER,0.4,1)
itemBackBtn.MouseButton1Click:Connect(function() itemPage.Visible=false end)
local itemHDiv=Instance.new("Frame"); itemHDiv.Size=UDim2.new(1,0,0,1); itemHDiv.Position=UDim2.new(0,0,1,-1); itemHDiv.BackgroundColor3=AMBER; itemHDiv.BackgroundTransparency=0.4; itemHDiv.BorderSizePixel=0; itemHDiv.ZIndex=22; itemHDiv.Parent=itemHeader

-- Barre joueur + mode give/remove + recherche
local itemTopBar=Instance.new("Frame"); itemTopBar.Size=UDim2.new(1,-24,0,86); itemTopBar.Position=UDim2.new(0,12,0,52); itemTopBar.BackgroundTransparency=1; itemTopBar.ZIndex=21; itemTopBar.Parent=itemPage

-- Label joueur
local itemPlayerLbl=Instance.new("TextLabel"); itemPlayerLbl.Size=UDim2.new(0.48,-4,0,14); itemPlayerLbl.BackgroundTransparency=1; itemPlayerLbl.Text="✦ Joueur cible"; itemPlayerLbl.TextColor3=TEXT3; itemPlayerLbl.TextSize=9; itemPlayerLbl.Font=Enum.Font.GothamBold; itemPlayerLbl.TextXAlignment=Enum.TextXAlignment.Left; itemPlayerLbl.ZIndex=22; itemPlayerLbl.Parent=itemTopBar
-- Holder dropdown joueur
local itemPlayerDDHolder=Instance.new("Frame"); itemPlayerDDHolder.Size=UDim2.new(0.48,-4,0,36); itemPlayerDDHolder.Position=UDim2.new(0,0,0,16); itemPlayerDDHolder.BackgroundTransparency=1; itemPlayerDDHolder.ZIndex=21; itemPlayerDDHolder.Parent=itemTopBar

-- Label mode
local itemModeLbl=Instance.new("TextLabel"); itemModeLbl.Size=UDim2.new(0.52,-4,0,14); itemModeLbl.Position=UDim2.new(0.48,4,0,0); itemModeLbl.BackgroundTransparency=1; itemModeLbl.Text="✦ Action"; itemModeLbl.TextColor3=TEXT3; itemModeLbl.TextSize=9; itemModeLbl.Font=Enum.Font.GothamBold; itemModeLbl.TextXAlignment=Enum.TextXAlignment.Left; itemModeLbl.ZIndex=22; itemModeLbl.Parent=itemTopBar
-- Boutons Give / Remove
local itemGiveBtn=Instance.new("TextButton"); itemGiveBtn.Size=UDim2.new(0.26,-2,0,36); itemGiveBtn.Position=UDim2.new(0.48,4,0,16); itemGiveBtn.BackgroundColor3=AMBER; itemGiveBtn.BackgroundTransparency=0.0; itemGiveBtn.BorderSizePixel=0; itemGiveBtn.Text="GIVE"; itemGiveBtn.TextColor3=Color3.fromRGB(10,10,10); itemGiveBtn.TextSize=12; itemGiveBtn.Font=Enum.Font.GothamBold; itemGiveBtn.ZIndex=22; itemGiveBtn.Parent=itemTopBar; mkC(itemGiveBtn,8)
local itemRemoveBtn=Instance.new("TextButton"); itemRemoveBtn.Size=UDim2.new(0.26,-2,0,36); itemRemoveBtn.Position=UDim2.new(0.74,4,0,16); itemRemoveBtn.BackgroundColor3=BG3; itemRemoveBtn.BackgroundTransparency=0.1; itemRemoveBtn.BorderSizePixel=0; itemRemoveBtn.Text="REMOVE"; itemRemoveBtn.TextColor3=TEXT2; itemRemoveBtn.TextSize=12; itemRemoveBtn.Font=Enum.Font.Gotham; itemRemoveBtn.ZIndex=22; itemRemoveBtn.Parent=itemTopBar; mkC(itemRemoveBtn,8); mkS(itemRemoveBtn,BORDER,0.4,1)

-- Recherche items
local itemSearchBox=Instance.new("TextBox"); itemSearchBox.Size=UDim2.new(1,0,0,32); itemSearchBox.Position=UDim2.new(0,0,0,56); itemSearchBox.BackgroundColor3=BG3; itemSearchBox.BackgroundTransparency=0.0; itemSearchBox.BorderSizePixel=0; itemSearchBox.PlaceholderText="🔍 Rechercher un item..."; itemSearchBox.PlaceholderColor3=TEXT3; itemSearchBox.Text=""; itemSearchBox.TextColor3=TEXT; itemSearchBox.TextSize=11; itemSearchBox.Font=Enum.Font.Gotham; itemSearchBox.ClearTextOnFocus=false; itemSearchBox.ZIndex=22; itemSearchBox.Parent=itemTopBar; mkC(itemSearchBox,8); mkS(itemSearchBox,AMBER,0.5,1); mkP(itemSearchBox,10,0,0,0)

-- Bouton exécuter
local itemExecBtn=Instance.new("TextButton"); itemExecBtn.Size=UDim2.new(1,-24,0,38); itemExecBtn.Position=UDim2.new(0,12,0,146); itemExecBtn.BackgroundColor3=AMBER; itemExecBtn.BackgroundTransparency=0.05; itemExecBtn.BorderSizePixel=0; itemExecBtn.Text="🎁  GIVE ITEM"; itemExecBtn.TextColor3=Color3.fromRGB(10,10,10); itemExecBtn.TextSize=13; itemExecBtn.Font=Enum.Font.GothamBold; itemExecBtn.ZIndex=22; itemExecBtn.Parent=itemPage; mkC(itemExecBtn,8)
itemExecBtn.MouseEnter:Connect(function() TweenService:Create(itemExecBtn,TweenInfo.new(0.08),{BackgroundTransparency=0}):Play() end)
itemExecBtn.MouseLeave:Connect(function() TweenService:Create(itemExecBtn,TweenInfo.new(0.08),{BackgroundTransparency=0.05}):Play() end)

-- Grille des items
local itemGrid=Instance.new("ScrollingFrame"); itemGrid.Size=UDim2.new(1,-24,1,-192); itemGrid.Position=UDim2.new(0,12,0,192); itemGrid.BackgroundTransparency=1; itemGrid.BorderSizePixel=0; itemGrid.ScrollBarThickness=3; itemGrid.ScrollBarImageColor3=AMBER; itemGrid.CanvasSize=UDim2.new(0,0,0,0); itemGrid.AutomaticCanvasSize=Enum.AutomaticSize.Y; itemGrid.ZIndex=21; itemGrid.Parent=itemPage
local itemGridLayout=Instance.new("UIGridLayout"); itemGridLayout.CellSize=UDim2.new(0,112,0,128); itemGridLayout.CellPadding=UDim2.new(0,7,0,7); itemGridLayout.Parent=itemGrid; mkP(itemGrid,4,4,4,4)

-- STATE item page
local itemState={selectedItem=nil, isRemove=false}
local itemBtns={}
local itemPlayerDD=nil

local function refreshItemModeBtn()
	if itemState.isRemove then
		itemRemoveBtn.BackgroundColor3=RED; itemRemoveBtn.BackgroundTransparency=0.0; itemRemoveBtn.TextColor3=Color3.fromRGB(255,200,200); itemRemoveBtn.Font=Enum.Font.GothamBold
		itemGiveBtn.BackgroundColor3=BG3; itemGiveBtn.BackgroundTransparency=0.1; itemGiveBtn.TextColor3=TEXT2; itemGiveBtn.Font=Enum.Font.Gotham
		itemExecBtn.BackgroundColor3=RED; itemExecBtn.Text="🗑  REMOVE ITEM"
	else
		itemGiveBtn.BackgroundColor3=AMBER; itemGiveBtn.BackgroundTransparency=0.0; itemGiveBtn.TextColor3=Color3.fromRGB(10,10,10); itemGiveBtn.Font=Enum.Font.GothamBold
		itemRemoveBtn.BackgroundColor3=BG3; itemRemoveBtn.BackgroundTransparency=0.1; itemRemoveBtn.TextColor3=TEXT2; itemRemoveBtn.Font=Enum.Font.Gotham
		itemExecBtn.BackgroundColor3=AMBER; itemExecBtn.Text="🎁  GIVE ITEM"
	end
	if itemState.selectedItem then
		itemExecBtn.Text=(itemState.isRemove and "🗑  REMOVE  —  " or "🎁  GIVE  —  ")..itemState.selectedItem
	end
end

itemGiveBtn.MouseButton1Click:Connect(function() itemState.isRemove=false; refreshItemModeBtn() end)
itemRemoveBtn.MouseButton1Click:Connect(function() itemState.isRemove=true; refreshItemModeBtn() end)

local function buildItemGrid(list, filterText)
	for _,c in ipairs(itemGrid:GetChildren()) do if not c:IsA("UIGridLayout") and not c:IsA("UIPadding") then c:Destroy() end end; itemBtns={}
	local fl=(filterText or ""):lower()
	local accentCol=AMBER
	for _,name in ipairs(list) do
		if fl=="" or name:lower():find(fl,1,true) then
			local card=Instance.new("TextButton"); card.BackgroundColor3=BG3; card.BackgroundTransparency=0.1; card.BorderSizePixel=0; card.Text=""; card.ZIndex=22; card.Parent=itemGrid; mkC(card,10); mkS(card,BORDER,0.5,1)

			-- Zone image
			local imgZone=Instance.new("Frame"); imgZone.Size=UDim2.new(1,-6,0,80); imgZone.Position=UDim2.new(0,3,0,3); imgZone.BackgroundColor3=Color3.fromRGB(16,13,8); imgZone.BackgroundTransparency=0.0; imgZone.BorderSizePixel=0; imgZone.ClipsDescendants=true; imgZone.ZIndex=23; imgZone.Parent=card; mkC(imgZone,8)

			-- Remplir l'image depuis le folder Items
			fillImageZone(imgZone, ItemsFolder, name, accentCol, "🎒")

			-- Nom
			local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-4,0,38); lbl.Position=UDim2.new(0,2,0,84); lbl.BackgroundTransparency=1; lbl.Text=name; lbl.TextColor3=TEXT2; lbl.TextSize=9; lbl.Font=Enum.Font.Gotham; lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.TextWrapped=true; lbl.TextXAlignment=Enum.TextXAlignment.Center; lbl.ZIndex=23; lbl.Parent=card
			itemBtns[name]={btn=card,lbl=lbl}

			card.MouseEnter:Connect(function() if itemState.selectedItem~=name then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG4,BackgroundTransparency=0.0}):Play() end end)
			card.MouseLeave:Connect(function() if itemState.selectedItem~=name then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play() end end)
			card.MouseButton1Click:Connect(function()
				-- Désélectionner ancien
				if itemState.selectedItem and itemBtns[itemState.selectedItem] then
					local old=itemBtns[itemState.selectedItem]
					if old.btn and old.btn.Parent then TweenService:Create(old.btn,TweenInfo.new(0.12),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play(); old.lbl.TextColor3=TEXT2; old.lbl.Font=Enum.Font.Gotham; for _,s in ipairs(old.btn:GetChildren()) do if s:IsA("UIStroke") then s.Color=BORDER; s.Transparency=0.5; s.Thickness=1 end end end
				end
				itemState.selectedItem=name
				local selBg=itemState.isRemove and Color3.fromRGB(30,8,8) or Color3.fromRGB(30,22,6)
				local selAccent=itemState.isRemove and RED or AMBER
				TweenService:Create(card,TweenInfo.new(0.12),{BackgroundColor3=selBg,BackgroundTransparency=0.0}):Play()
				lbl.TextColor3=selAccent; lbl.Font=Enum.Font.GothamBold
				for _,s in ipairs(card:GetChildren()) do if s:IsA("UIStroke") then s.Color=selAccent; s.Transparency=0.0; s.Thickness=2 end end
				itemExecBtn.Text=(itemState.isRemove and "🗑  REMOVE  —  " or "🎁  GIVE  —  ")..name
			end)
		end
	end
end

itemSearchBox:GetPropertyChangedSignal("Text"):Connect(function() buildItemGrid(itemList, itemSearchBox.Text) end)

itemExecBtn.MouseButton1Click:Connect(function()
	local sel=itemState.selectedItem
	if not sel or sel=="" then showNotif("Sélectionne d'abord un item !",false); return end
	local targetPlayer=itemPlayerDD and itemPlayerDD.getValue() or nil
	if not targetPlayer then showNotif("Sélectionne un joueur !",false); return end
	local cmd=itemState.isRemove and "removeitem" or "giveitem"
	ExecuteCommand:FireServer(cmd,{player=targetPlayer, item=sel})
	showNotif((itemState.isRemove and "🗑 Retiré : " or "🎁 Donné : ")..sel.." → "..targetPlayer, true)
	TweenService:Create(itemExecBtn,TweenInfo.new(0.06),{BackgroundTransparency=0.5}):Play()
	task.delay(0.12,function() if itemExecBtn and itemExecBtn.Parent then TweenService:Create(itemExecBtn,TweenInfo.new(0.1),{BackgroundTransparency=0.05}):Play() end end)
end)

openItemPage = function(cat, cmd)
	itemState.selectedItem=nil; itemState.isRemove=(cmd.cmd=="removeitem")
	itemSearchBox.Text=""

	-- Mode initial selon la commande cliquée
	if itemState.isRemove then
		itemTitleLbl.Text="🗑  REMOVE ITEM"
	else
		itemTitleLbl.Text="🎒  GIVE ITEM"
	end
	refreshItemModeBtn()

	-- Dropdown joueur
	for _,c in ipairs(itemPlayerDDHolder:GetChildren()) do c:Destroy() end
	playerList={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(playerList,p.Name) end
	itemPlayerDD=makeDropdown("Sélectionner un joueur...", #playerList>0 and playerList or {"(aucun)"})
	itemPlayerDD.frame.Size=UDim2.new(1,0,1,0); itemPlayerDD.frame.Parent=itemPlayerDDHolder

	-- Charger items
	if #itemList==0 then
		local ok,it=pcall(function() return GetItems:InvokeServer() end); itemList=(ok and it) and it or {}
	end

	buildItemGrid(itemList,"")
	formScroll.Visible=false; selectHint.Visible=false
	itemPage.Visible=true
end

-- ============================================================
-- SKIN PAGE
-- ============================================================
local skinPage = Instance.new("Frame")
skinPage.Size=UDim2.new(1,0,1,0); skinPage.BackgroundColor3=BG; skinPage.BackgroundTransparency=0
skinPage.BorderSizePixel=0; skinPage.Visible=false; skinPage.ZIndex=20; skinPage.Parent=rightZone; mkC(skinPage,0)

local skinHeader=Instance.new("Frame"); skinHeader.Size=UDim2.new(1,0,0,46); skinHeader.BackgroundColor3=BG2; skinHeader.BackgroundTransparency=0.50; skinHeader.BorderSizePixel=0; skinHeader.ZIndex=21; skinHeader.Parent=skinPage
local skinTitleLbl=Instance.new("TextLabel"); skinTitleLbl.Size=UDim2.new(1,-200,1,0); skinTitleLbl.Position=UDim2.new(0,14,0,0); skinTitleLbl.BackgroundTransparency=1; skinTitleLbl.Text="🏠  SET BASE SKIN"; skinTitleLbl.TextColor3=TEXT; skinTitleLbl.TextSize=14; skinTitleLbl.Font=Enum.Font.GothamBold; skinTitleLbl.TextXAlignment=Enum.TextXAlignment.Left; skinTitleLbl.ZIndex=22; skinTitleLbl.Parent=skinHeader
local skinBackBtn=Instance.new("TextButton"); skinBackBtn.Size=UDim2.new(0,82,0,28); skinBackBtn.Position=UDim2.new(1,-90,0.5,-14); skinBackBtn.BackgroundColor3=BG3; skinBackBtn.BackgroundTransparency=0.1; skinBackBtn.BorderSizePixel=0; skinBackBtn.Text="← Retour"; skinBackBtn.TextColor3=TEXT2; skinBackBtn.TextSize=11; skinBackBtn.Font=Enum.Font.Gotham; skinBackBtn.ZIndex=22; skinBackBtn.Parent=skinHeader; mkC(skinBackBtn,6); mkS(skinBackBtn,BORDER,0.4,1)
skinBackBtn.MouseButton1Click:Connect(function() skinPage.Visible=false end)
local skinHDiv=Instance.new("Frame"); skinHDiv.Size=UDim2.new(1,0,0,1); skinHDiv.Position=UDim2.new(0,0,1,-1); skinHDiv.BackgroundColor3=TEAL; skinHDiv.BackgroundTransparency=0.4; skinHDiv.BorderSizePixel=0; skinHDiv.ZIndex=22; skinHDiv.Parent=skinHeader

local skinTopBar=Instance.new("Frame"); skinTopBar.Size=UDim2.new(1,-24,0,72); skinTopBar.Position=UDim2.new(0,12,0,52); skinTopBar.BackgroundTransparency=1; skinTopBar.ZIndex=21; skinTopBar.Parent=skinPage
local skinPlayerLbl=Instance.new("TextLabel"); skinPlayerLbl.Size=UDim2.new(1,0,0,14); skinPlayerLbl.BackgroundTransparency=1; skinPlayerLbl.Text="✦ Joueur cible"; skinPlayerLbl.TextColor3=TEXT3; skinPlayerLbl.TextSize=9; skinPlayerLbl.Font=Enum.Font.GothamBold; skinPlayerLbl.TextXAlignment=Enum.TextXAlignment.Left; skinPlayerLbl.ZIndex=22; skinPlayerLbl.Parent=skinTopBar
local skinPlayerDDHolder=Instance.new("Frame"); skinPlayerDDHolder.Size=UDim2.new(0.48,-4,0,36); skinPlayerDDHolder.Position=UDim2.new(0,0,0,16); skinPlayerDDHolder.BackgroundTransparency=1; skinPlayerDDHolder.ZIndex=21; skinPlayerDDHolder.Parent=skinTopBar
local skinSearchBox=Instance.new("TextBox"); skinSearchBox.Size=UDim2.new(0.52,-4,0,36); skinSearchBox.Position=UDim2.new(0.48,4,0,16); skinSearchBox.BackgroundColor3=BG3; skinSearchBox.BackgroundTransparency=0.0; skinSearchBox.BorderSizePixel=0; skinSearchBox.PlaceholderText="🔍 Rechercher une skin..."; skinSearchBox.PlaceholderColor3=TEXT3; skinSearchBox.Text=""; skinSearchBox.TextColor3=TEXT; skinSearchBox.TextSize=11; skinSearchBox.Font=Enum.Font.Gotham; skinSearchBox.ClearTextOnFocus=false; skinSearchBox.ZIndex=22; skinSearchBox.Parent=skinTopBar; mkC(skinSearchBox,8); mkS(skinSearchBox,TEAL,0.5,1); mkP(skinSearchBox,10,0,0,0)

local skinApplyBtn=Instance.new("TextButton"); skinApplyBtn.Size=UDim2.new(1,-24,0,38); skinApplyBtn.Position=UDim2.new(0,12,0,128); skinApplyBtn.BackgroundColor3=TEAL; skinApplyBtn.BackgroundTransparency=0.05; skinApplyBtn.BorderSizePixel=0; skinApplyBtn.Text="🏠  APPLIQUER LA SKIN"; skinApplyBtn.TextColor3=Color3.fromRGB(5,30,25); skinApplyBtn.TextSize=13; skinApplyBtn.Font=Enum.Font.GothamBold; skinApplyBtn.ZIndex=22; skinApplyBtn.Parent=skinPage; mkC(skinApplyBtn,8)
skinApplyBtn.MouseEnter:Connect(function() TweenService:Create(skinApplyBtn,TweenInfo.new(0.08),{BackgroundTransparency=0}):Play() end)
skinApplyBtn.MouseLeave:Connect(function() TweenService:Create(skinApplyBtn,TweenInfo.new(0.08),{BackgroundTransparency=0.05}):Play() end)

local skinGrid=Instance.new("ScrollingFrame"); skinGrid.Size=UDim2.new(1,-24,1,-174); skinGrid.Position=UDim2.new(0,12,0,174); skinGrid.BackgroundTransparency=1; skinGrid.BorderSizePixel=0; skinGrid.ScrollBarThickness=3; skinGrid.ScrollBarImageColor3=TEAL; skinGrid.CanvasSize=UDim2.new(0,0,0,0); skinGrid.AutomaticCanvasSize=Enum.AutomaticSize.Y; skinGrid.ZIndex=21; skinGrid.Parent=skinPage
local skinGridLayout=Instance.new("UIGridLayout"); skinGridLayout.CellSize=UDim2.new(0,112,0,128); skinGridLayout.CellPadding=UDim2.new(0,7,0,7); skinGridLayout.Parent=skinGrid; mkP(skinGrid,4,4,4,4)

local skinState={selectedSkin=nil}; local skinBtns={}; local skinPlayerDD=nil

local function buildSkinGrid(list, filterText)
	for _,c in ipairs(skinGrid:GetChildren()) do if not c:IsA("UIGridLayout") and not c:IsA("UIPadding") then c:Destroy() end end; skinBtns={}
	local fl=(filterText or ""):lower()
	for _,skinData in ipairs(list) do
		local skinName,imageId
		if type(skinData)=="table" then skinName=skinData.name or tostring(skinData); imageId=skinData.imageId or ""
		else skinName=tostring(skinData); imageId="" end
		if fl=="" or skinName:lower():find(fl,1,true) then
			local card=Instance.new("TextButton"); card.BackgroundColor3=BG3; card.BackgroundTransparency=0.1; card.BorderSizePixel=0; card.Text=""; card.ZIndex=22; card.Parent=skinGrid; mkC(card,10); mkS(card,BORDER,0.5,1)
			local imgZone=Instance.new("Frame"); imgZone.Size=UDim2.new(1,-6,0,80); imgZone.Position=UDim2.new(0,3,0,3); imgZone.BackgroundColor3=Color3.fromRGB(10,18,16); imgZone.BackgroundTransparency=0.0; imgZone.BorderSizePixel=0; imgZone.ClipsDescendants=true; imgZone.ZIndex=23; imgZone.Parent=card; mkC(imgZone,8)
			if imageId and imageId~="" then
				local img=Instance.new("ImageLabel"); img.Size=UDim2.new(1,0,1,0); img.BackgroundTransparency=1; img.Image=imageId; img.ScaleType=Enum.ScaleType.Fit; img.ZIndex=24; img.Parent=imgZone
			else
				fillImageZone(imgZone, SkinsFolder, skinName, TEAL, "🏠")
			end
			local lbl=Instance.new("TextLabel"); lbl.Size=UDim2.new(1,-4,0,38); lbl.Position=UDim2.new(0,2,0,84); lbl.BackgroundTransparency=1; lbl.Text=skinName; lbl.TextColor3=TEXT2; lbl.TextSize=9; lbl.Font=Enum.Font.Gotham; lbl.TextTruncate=Enum.TextTruncate.AtEnd; lbl.TextWrapped=true; lbl.TextXAlignment=Enum.TextXAlignment.Center; lbl.ZIndex=23; lbl.Parent=card
			skinBtns[skinName]={btn=card,lbl=lbl}
			card.MouseEnter:Connect(function() if skinState.selectedSkin~=skinName then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG4,BackgroundTransparency=0.0}):Play() end end)
			card.MouseLeave:Connect(function() if skinState.selectedSkin~=skinName then TweenService:Create(card,TweenInfo.new(0.08),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play() end end)
			card.MouseButton1Click:Connect(function()
				if skinState.selectedSkin and skinBtns[skinState.selectedSkin] then local old=skinBtns[skinState.selectedSkin]; if old.btn and old.btn.Parent then TweenService:Create(old.btn,TweenInfo.new(0.12),{BackgroundColor3=BG3,BackgroundTransparency=0.1}):Play(); old.lbl.TextColor3=TEXT2; old.lbl.Font=Enum.Font.Gotham; for _,s in ipairs(old.btn:GetChildren()) do if s:IsA("UIStroke") then s.Color=BORDER; s.Transparency=0.5; s.Thickness=1 end end end end
				skinState.selectedSkin=skinName; TweenService:Create(card,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(8,30,22),BackgroundTransparency=0.0}):Play()
				lbl.TextColor3=TEAL; lbl.Font=Enum.Font.GothamBold
				for _,s in ipairs(card:GetChildren()) do if s:IsA("UIStroke") then s.Color=TEAL; s.Transparency=0.0; s.Thickness=2 end end
				skinApplyBtn.Text="🏠  APPLIQUER  —  "..skinName
			end)
		end
	end
end

skinSearchBox:GetPropertyChangedSignal("Text"):Connect(function() buildSkinGrid(skinList, skinSearchBox.Text) end)
skinApplyBtn.MouseButton1Click:Connect(function()
	local skin=skinState.selectedSkin; if not skin or skin=="" then showNotif("Sélectionne d'abord une skin !",false); return end
	local targetPlayer=skinPlayerDD and skinPlayerDD.getValue() or nil; if not targetPlayer then showNotif("Sélectionne un joueur !",false); return end
	ExecuteCommand:FireServer("setbaseskin",{player=targetPlayer, skin=skin}); showNotif("Skin \""..skin.."\" → "..targetPlayer,true)
	TweenService:Create(skinApplyBtn,TweenInfo.new(0.06),{BackgroundTransparency=0.5}):Play(); task.delay(0.12,function() if skinApplyBtn and skinApplyBtn.Parent then TweenService:Create(skinApplyBtn,TweenInfo.new(0.1),{BackgroundTransparency=0.05}):Play() end end)
end)

openSkinPage = function(cat, cmd)
	skinState.selectedSkin=nil; skinSearchBox.Text=""; skinApplyBtn.Text="🏠  APPLIQUER LA SKIN"
	for _,c in ipairs(skinPlayerDDHolder:GetChildren()) do c:Destroy() end
	playerList={}; for _,p in ipairs(Players:GetPlayers()) do table.insert(playerList,p.Name) end
	skinPlayerDD=makeDropdown("Sélectionner un joueur...", #playerList>0 and playerList or {"(aucun)"}); skinPlayerDD.frame.Size=UDim2.new(1,0,1,0); skinPlayerDD.frame.Parent=skinPlayerDDHolder
	skinList={}
	if GetBaseSkins then local ok,result=pcall(function() return GetBaseSkins:InvokeServer() end); if ok and result then skinList=result end end
	if #skinList==0 and SkinsFolder then for _,child in ipairs(SkinsFolder:GetChildren()) do table.insert(skinList,child.Name) end end
	if #skinList==0 then skinList={"Default","Stone","Gold","Neon","Crystal","Shadow","Lava","Ice","Jungle","Desert","Ocean","Sky"} end
	buildSkinGrid(skinList,""); formScroll.Visible=false; selectHint.Visible=false; skinPage.Visible=true
end

-- ============================================================
-- TOGGLE
-- ============================================================
local function openPanel()
	if toggleDebounce then return end; toggleDebounce=true; guiVisible=true
	mainFrame.Visible=true; mainFrame.Size=UDim2.new(0,W,0,0); mainFrame.BackgroundTransparency=1
	TweenService:Create(mainFrame,TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,W,0,H),BackgroundTransparency=0.45}):Play()
	task.delay(0.32,function() toggleDebounce=false end)
end
local function togglePanel() if toggleDebounce then return end; if guiVisible then closePanel() else openPanel() end end

player.CharacterAdded:Connect(function()
	task.wait(0.1)
	if mainFrame and mainFrame.Parent then mainFrame.Visible=guiVisible; if guiVisible then mainFrame.Size=UDim2.new(0,W,0,H); mainFrame.BackgroundTransparency=0.45 end; toggleDebounce=false end
end)

UserInputService.InputBegan:Connect(function(input,gp) if gp then return end; if input.KeyCode==Enum.KeyCode.H then togglePanel() end end)
closeBtn.MouseButton1Click:Connect(closePanel)
hudBtn.MouseButton1Click:Connect(togglePanel)

sidebar.InputBegan:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=true; dragOffset=Vector2.new(mouse.X-mainFrame.AbsolutePosition.X,mouse.Y-mainFrame.AbsolutePosition.Y) end end)
sidebar.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=false end end)
rightHeader.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then
		local mp=UserInputService:GetMouseLocation(); local cp=closeBtn.AbsolutePosition; local cs=closeBtn.AbsoluteSize
		local inClose=mp.X>=cp.X and mp.X<=cp.X+cs.X and mp.Y>=cp.Y and mp.Y<=cp.Y+cs.Y
		if not inClose then isDragging=true; dragOffset=Vector2.new(mouse.X-mainFrame.AbsolutePosition.X,mouse.Y-mainFrame.AbsolutePosition.Y) end
	end
end)
rightHeader.InputEnded:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseButton1 then isDragging=false end end)
RunService.RenderStepped:Connect(function()
	if isDragging and mainFrame.Visible then
		local vp=workspace.CurrentCamera.ViewportSize
		local nx=math.clamp(mouse.X-dragOffset.X,0,vp.X-mainFrame.AbsoluteSize.X)
		local ny=math.clamp(mouse.Y-dragOffset.Y,0,vp.Y-mainFrame.AbsoluteSize.Y)
		mainFrame.Position=UDim2.new(0,nx,0,ny)
	end
end)

CommandResult.OnClientEvent:Connect(function(success,message) showNotif(tostring(message),success==true) end)

-- INIT
buildSidebar(); selectCategory(1); print("[AdminClient] INIT ✅")