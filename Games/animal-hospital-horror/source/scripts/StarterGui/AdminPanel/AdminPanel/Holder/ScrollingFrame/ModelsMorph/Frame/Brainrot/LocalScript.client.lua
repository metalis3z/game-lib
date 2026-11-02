-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local AllGamepasses = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("AllGamepasses"))
local v1 = AllGamepasses.Latest("BeOwner")
local v2 = AllGamepasses.All("BeOwner")
local LocalPlayer = Players.LocalPlayer
local BrainrotMorphCommand = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BrainrotMorphCommand")
local CustomModels = ReplicatedStorage:WaitForChild("CustomModels", 10)
local v3 = script.Parent.Parent
local Brainrot = v3:WaitForChild("Brainrot")
local Overhead = v3:WaitForChild("Overhead")
local Spawn = v3:WaitForChild("Spawn")
local Unmorph = v3:WaitForChild("Unmorph")
local BrainrotSize = v3:FindFirstChild("BrainrotSize")
local AdminPanel = script:FindFirstAncestor("AdminPanel")
local AdminCooldownClient = require(AdminPanel:WaitForChild("AdminCooldownClient"))
local t = {}
local t2 = {}

local function rebuildLookup() --[[ rebuildLookup | Line: 55 | Upvalues: t (copy), t2 (copy), CustomModels (copy) ]]
	table.clear(t)
	table.clear(t2)

	if not CustomModels then
		return
	end

	for i, v in ipairs(CustomModels:GetChildren()) do
		if v:IsA("Model") then
			local v1 = string.lower(v.Name)

			t[v1] = v.Name
			t2[v1:gsub("[%W_]+", "")] = v.Name
		end
	end
end

rebuildLookup()

if CustomModels then
	CustomModels.ChildAdded:Connect(rebuildLookup)
	CustomModels.ChildRemoved:Connect(rebuildLookup)
end

local v4 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 74 | Upvalues: v4 (ref) ]]
	if not v4 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v1 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v1 then
			local ok, result = pcall(require, v1)

			if ok then
				v4 = result
			end
		end
	end

	if not v4 then
		return
	end

	v4(p1, p2 ~= false)
end

local v5 = 0
local v6 = false

local function ownsBeOwner() --[[ ownsBeOwner | Line: 91 | Upvalues: LocalPlayer (copy), v6 (ref), v5 (ref), MarketplaceService (copy), v2 (copy) ]]
	if LocalPlayer:GetAttribute("HasTrollingMenuAccess") == true then
		return true
	end

	if v6 and os.clock() - v5 < 15 then
		return false
	end

	local function checkOne(p1) --[[ checkOne | Line: 96 | Upvalues: MarketplaceService (ref), LocalPlayer (ref) ]]
		local ok, result = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, LocalPlayer.UserId, p1)

		return if ok then result == true else ok
	end

	local v1 = false

	for i, v in ipairs(v2) do
		local ok, result = pcall(MarketplaceService.UserOwnsGamePassAsync, MarketplaceService, LocalPlayer.UserId, v)

		if if ok then result == true else ok then
			v1 = true

			break
		end
	end

	if v1 then
		LocalPlayer:SetAttribute("HasTrollingMenuAccess", true)
		v6 = false

		return true
	end

	v5 = os.clock()
	v6 = true

	return false
end

MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(p1, p2, p3) --[[ Line: 114 | Upvalues: LocalPlayer (copy), AllGamepasses (copy), v6 (ref) ]]
	if p1 ~= LocalPlayer or not (AllGamepasses.Matches("BeOwner", p2) and p3) then
		return
	end

	LocalPlayer:SetAttribute("HasTrollingMenuAccess", true)
	v6 = false
end)

local v7 = (-1 / 0)

local function promptBeOwnerPurchase() --[[ promptBeOwnerPurchase | Line: 125 | Upvalues: v7 (ref), MarketplaceService (copy), LocalPlayer (copy), v1 (copy) ]]
	if not (os.clock() - v7 < 2) then
		v7 = os.clock()
		pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, LocalPlayer, v1)
	end
end

local function requireBeOwner() --[[ requireBeOwner | Line: 134 | Upvalues: ownsBeOwner (copy), showNotif (copy), v7 (ref), MarketplaceService (copy), LocalPlayer (copy), v1 (copy) ]]
	if ownsBeOwner() then
		return true
	end

	showNotif("Be Owner is required to use this feature!", false)

	if os.clock() - v7 < 2 then
		return false
	end

	v7 = os.clock()
	pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, LocalPlayer, v1)

	return false
end

local function requirePrivateServer() --[[ requirePrivateServer | Line: 144 | Upvalues: showNotif (copy) ]]
	if workspace:GetAttribute("IsPrivateServer") == true then
		return true
	end

	showNotif("This feature works on Private Servers!", false)

	return false
end

local function refreshSizeAccess() --[[ refreshSizeAccess | Line: 152 | Upvalues: BrainrotSize (copy), LocalPlayer (copy) ]]
	if not BrainrotSize then
		return
	end

	if LocalPlayer:GetAttribute("HasMapEditorAccess") == true then
		BrainrotSize.PlaceholderText = "Enter size (e.g. 1)"
		BrainrotSize.TextEditable = true

		if BrainrotSize.Text == "" then
			BrainrotSize.Text = "1"
		end
	else
		BrainrotSize.PlaceholderText = "Requires Map Editor Gamepass"
		BrainrotSize.TextEditable = false
		BrainrotSize.Text = ""
	end
end

if BrainrotSize and LocalPlayer:GetAttribute("HasMapEditorAccess") == true then
	BrainrotSize.PlaceholderText = "Enter size (e.g. 1)"
	BrainrotSize.TextEditable = true

	if BrainrotSize.Text == "" then
		BrainrotSize.Text = "1"
	end
elseif BrainrotSize then
	BrainrotSize.PlaceholderText = "Requires Map Editor Gamepass"
	BrainrotSize.TextEditable = false
	BrainrotSize.Text = ""
end

LocalPlayer:GetAttributeChangedSignal("HasMapEditorAccess"):Connect(refreshSizeAccess)

if BrainrotSize then
	BrainrotSize.FocusLost:Connect(function() --[[ Line: 172 | Upvalues: BrainrotSize (copy) ]]
		local v1 = tonumber(BrainrotSize.Text)

		if v1 then
			BrainrotSize.Text = tostring((math.clamp(v1, 0.1, 100)))
		else
			BrainrotSize.Text = tostring(1)
		end
	end)
end

local function trim(p1) --[[ trim | Line: 183 ]]
	if typeof(p1) == "string" then
		return p1:gsub("^%s+", ""):gsub("%s+$", "")
	end

	return ""
end

local function canonicalizeBrainrotText(p1) --[[ canonicalizeBrainrotText | Line: 188 | Upvalues: t (copy), t2 (copy) ]]
	local v1 = if typeof(p1) == "string" then p1:gsub("^%s+", ""):gsub("%s+$", "") else ""

	if v1 == "" then
		return ""
	end

	local v2 = string.lower(v1)

	if t[v2] then
		return t[v2]
	end

	local v3 = nil

	for k, v in pairs(t) do
		if v2:find(k, 1, true) and (not v3 or #v3 < #v) then
			v3 = v
		end
	end

	if v3 then
		return v3
	end

	local v4 = v2:gsub("[%W_]+", "")

	if v4 == "" then
		return v1
	end

	if t2[v4] then
		return t2[v4]
	end

	local v5 = nil

	for k, v in pairs(t2) do
		if v4:find(k, 1, true) and (not v5 or #v5 < #v) then
			v5 = v
		end
	end

	return v5 or v1
end

local function normalizeOverheadText() --[[ normalizeOverheadText | Line: 219 | Upvalues: trim (copy), Overhead (copy) ]]
	local v1 = string.lower(trim(Overhead.Text))

	if v1 == "" then
		return
	end

	if v1 == "yes" or (v1 == "true" or (v1 == "1" or v1 == "on")) then
		Overhead.Text = "Yes"

		return
	end

	if v1 ~= "no" and (v1 ~= "false" and (v1 ~= "0" and v1 ~= "off")) then
		return
	end

	Overhead.Text = "No"
end

Brainrot.FocusLost:Connect(function() --[[ Line: 229 | Upvalues: Brainrot (copy), canonicalizeBrainrotText (copy) ]]
	Brainrot.Text = canonicalizeBrainrotText(Brainrot.Text)
end)
Overhead.FocusLost:Connect(normalizeOverheadText)
Spawn.MouseButton1Click:Connect(function() --[[ Line: 235 | Upvalues: ownsBeOwner (copy), showNotif (copy), v7 (ref), MarketplaceService (copy), LocalPlayer (copy), v1 (copy), Brainrot (copy), canonicalizeBrainrotText (copy), normalizeOverheadText (copy), CustomModels (copy), Overhead (copy), BrainrotSize (copy), AdminCooldownClient (copy), BrainrotMorphCommand (copy) ]]
	local v12

	if ownsBeOwner() then
		v12 = true
	else
		showNotif("Be Owner is required to use this feature!", false)

		if not (os.clock() - v7 < 2) then
			v7 = os.clock()
			pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, LocalPlayer, v1)
		end

		v12 = false
	end

	if not v12 then
		return
	end

	local v2

	if workspace:GetAttribute("IsPrivateServer") == true then
		v2 = true
	else
		showNotif("This feature works on Private Servers!", false)
		v2 = false
	end

	if not v2 then
		return
	end

	Brainrot.Text = canonicalizeBrainrotText(Brainrot.Text)
	normalizeOverheadText()

	local Text = Brainrot.Text
	local v3 = if typeof(Text) == "string" then Text:gsub("^%s+", ""):gsub("%s+$", "") else ""

	if v3 == "" then
		showNotif("Pick a model first", false)

		return
	end

	if CustomModels and CustomModels:FindFirstChild(v3) then
		local Text2 = Overhead.Text
		local v5 = if typeof(Text2) == "string" then Text2:gsub("^%s+", ""):gsub("%s+$", "") else ""

		if v5 == "" then
			v5 = "no"
		end

		local v72 = if BrainrotSize and LocalPlayer:GetAttribute("HasMapEditorAccess") == true then math.clamp(tonumber(BrainrotSize.Text) or 1, 0.1, 100) else 1

		if AdminCooldownClient:Try("ModelsMorph") then
			BrainrotMorphCommand:FireServer({
				Action = "Morph",
				Source = "ModelsMorph",
				BrainrotName = v3,
				StatsOverhead = v5,
				Size = v72
			})
		end
	else
		showNotif("Unknown model: " .. v3, false)
	end
end)
Unmorph.MouseButton1Click:Connect(function() --[[ Line: 280 | Upvalues: ownsBeOwner (copy), showNotif (copy), v7 (ref), MarketplaceService (copy), LocalPlayer (copy), v1 (copy), BrainrotMorphCommand (copy) ]]
	local v12

	if ownsBeOwner() then
		v12 = true
	else
		showNotif("Be Owner is required to use this feature!", false)

		if not (os.clock() - v7 < 2) then
			v7 = os.clock()
			pcall(MarketplaceService.PromptGamePassPurchase, MarketplaceService, LocalPlayer, v1)
		end

		v12 = false
	end

	if not v12 then
		return
	end

	local v2

	if workspace:GetAttribute("IsPrivateServer") == true then
		v2 = true
	else
		showNotif("This feature works on Private Servers!", false)
		v2 = false
	end

	if v2 then
		BrainrotMorphCommand:FireServer({
			Action = "Unmorph",
			Source = "ModelsMorph"
		})
	end
end)
BrainrotMorphCommand.OnClientEvent:Connect(function(p1) --[[ Line: 288 | Upvalues: showNotif (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	if typeof(p1.message) ~= "string" then
		return
	end

	if p1.success == false then
		warn("[BrainrotMorph] " .. p1.message)
		showNotif(p1.message, false)
	else
		print("[BrainrotMorph] " .. p1.message)
		showNotif(p1.message, true)
	end
end)