-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = game:GetService("Players").LocalPlayer
local BrainrotMorphCommand = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("BrainrotMorphCommand")
local EntitiesData = require(ReplicatedStorage.Shared.Data.EntitiesData)
local v1 = script.Parent.Parent
local Brainrot = v1:WaitForChild("Brainrot")
local Overhead = v1:WaitForChild("Overhead")
local Spawn = v1:WaitForChild("Spawn")
local Unmorph = v1:WaitForChild("Unmorph")
local BrainrotSize = v1:FindFirstChild("BrainrotSize")
local AdminPanel = script:FindFirstAncestor("AdminPanel")
local AdminCooldownClient = require(AdminPanel:WaitForChild("AdminCooldownClient"))
local t = {}
local t2 = {}

for k in pairs(EntitiesData.Brainrots) do
	local v2 = string.lower(k)

	t[v2] = k
	t2[v2:gsub("[%W_]+", "")] = k
end

local v3 = nil

local function showNotif(p1, p2) --[[ showNotif | Line: 43 | Upvalues: v3 (ref) ]]
	if not v3 then
		local AdminPanel = script:FindFirstAncestor("AdminPanel")
		local v1 = if AdminPanel then AdminPanel:FindFirstChild("NotifModule") else AdminPanel

		if v1 then
			local ok, result = pcall(require, v1)

			if ok then
				v3 = result
			end
		end
	end

	if not v3 then
		return
	end

	v3(p1, p2 ~= false)
end

local function refreshSizeAccess() --[[ refreshSizeAccess | Line: 54 | Upvalues: BrainrotSize (copy), LocalPlayer (copy) ]]
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
	BrainrotSize.FocusLost:Connect(function() --[[ Line: 74 | Upvalues: BrainrotSize (copy) ]]
		local v1 = tonumber(BrainrotSize.Text)

		if v1 then
			BrainrotSize.Text = tostring((math.clamp(v1, 0.1, 100)))
		else
			BrainrotSize.Text = tostring(1)
		end
	end)
end

local function trim(p1) --[[ trim | Line: 85 ]]
	if typeof(p1) == "string" then
		return p1:gsub("^%s+", ""):gsub("%s+$", "")
	end

	return ""
end

local function canonicalizeBrainrotText(p1) --[[ canonicalizeBrainrotText | Line: 90 | Upvalues: t (copy), t2 (copy) ]]
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

local function normalizeOverheadText() --[[ normalizeOverheadText | Line: 121 | Upvalues: trim (copy), Overhead (copy) ]]
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

Brainrot.FocusLost:Connect(function() --[[ Line: 131 | Upvalues: Brainrot (copy), canonicalizeBrainrotText (copy) ]]
	Brainrot.Text = canonicalizeBrainrotText(Brainrot.Text)
end)
Overhead.FocusLost:Connect(normalizeOverheadText)
Spawn.MouseButton1Click:Connect(function() --[[ Line: 137 | Upvalues: Brainrot (copy), canonicalizeBrainrotText (copy), normalizeOverheadText (copy), showNotif (copy), EntitiesData (copy), Overhead (copy), BrainrotSize (copy), LocalPlayer (copy), AdminCooldownClient (copy), BrainrotMorphCommand (copy) ]]
	Brainrot.Text = canonicalizeBrainrotText(Brainrot.Text)
	normalizeOverheadText()

	local Text = Brainrot.Text
	local v1 = if typeof(Text) == "string" then Text:gsub("^%s+", ""):gsub("%s+$", "") else ""

	if v1 == "" then
		showNotif("Pick a brainrot first", false)

		return
	end

	if not EntitiesData.Brainrots[v1] then
		showNotif("Unknown brainrot: " .. v1, false)

		return
	end

	local Text2 = Overhead.Text
	local v3 = if typeof(Text2) == "string" then Text2:gsub("^%s+", ""):gsub("%s+$", "") else ""

	if v3 == "" then
		v3 = "no"
	end

	local v5 = if BrainrotSize and LocalPlayer:GetAttribute("HasMapEditorAccess") == true then math.clamp(tonumber(BrainrotSize.Text) or 1, 0.1, 100) else 1

	if AdminCooldownClient:Try("BrainrotMorph") then
		BrainrotMorphCommand:FireServer({
			Action = "Morph",
			BrainrotName = v1,
			StatsOverhead = v3,
			Size = v5
		})
	end
end)
Unmorph.MouseButton1Click:Connect(function() --[[ Line: 168 | Upvalues: BrainrotMorphCommand (copy) ]]
	BrainrotMorphCommand:FireServer({
		Action = "Unmorph"
	})
end)
BrainrotMorphCommand.OnClientEvent:Connect(function(p1) --[[ Line: 174 | Upvalues: showNotif (copy) ]]
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