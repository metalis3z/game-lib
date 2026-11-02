-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Audio = require(ReplicatedStorage.Library.Audio)
local Variables = require(ReplicatedStorage.Library.Variables)
local InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)

require(ReplicatedStorage.Library.Items.BrainrotItem)

local t = {}

local function getDisplayMutations(p1) --[[ getDisplayMutations | Line: 19 ]]
	local t = {}
	local BaseMutation = p1:GetData().BaseMutation

	if typeof(BaseMutation) == "string" and (BaseMutation ~= "" and BaseMutation ~= "None") then
		table.insert(t, BaseMutation)
	end

	for i, v in ipairs(p1:GetMutations()) do
		if v ~= "" and (v ~= "None" and table.find(t, v) == nil) then
			table.insert(t, v)
		end
	end

	return t
end

local function formatMutationRichText(p1) --[[ formatMutationRichText | Line: 35 | Upvalues: Mutations (copy) ]]
	local v1 = Mutations.GetMutation(p1)

	if v1 then
		return string.format("<font color=\"#%s\">%s</font>", v1.Color:ToHex(), v1.Name)
	end

	return p1
end

local function getMutationLine(p1) --[[ getMutationLine | Line: 44 | Upvalues: getDisplayMutations (copy), Mutations (copy) ]]
	local v1 = getDisplayMutations(p1)

	if #v1 == 0 then
		return "No Mutations"
	end

	local v2 = table.create(#v1)

	for i, v in ipairs(v1) do
		local v3
		local v4 = Mutations.GetMutation(v)

		v3 = if v4 then string.format("<font color=\"#%s\">%s</font>", v4.Color:ToHex(), v4.Name) else v
		v2[i] = v3
	end

	return table.concat(v2, ", ")
end

local function showOverlay(p1, p2) --[[ showOverlay | Line: 58 | Upvalues: Variables (copy), InfoOverlay (copy), getMutationLine (copy) ]]
	if not Variables.DisableInfoOverlay then
		InfoOverlay.Add(p1, { "Title", (" %s "):format(p2:GetName()) }, { "Rarity", p2:GetRarity()._id }, { "Div" }, { "Desc", getMutationLine(p2) })
	end
end

function t.AddOverlay(p1, p2) --[[ AddOverlay | Line: 73 | Upvalues: Audio (copy), showOverlay (copy) ]]
	local function handleOverlay() --[[ handleOverlay | Line: 74 | Upvalues: Audio (ref), showOverlay (ref), p1 (copy), p2 (copy) ]]
		Audio.Play("rbxassetid://89944486811970", script, 1, 0.2)
		showOverlay(p1, p2)
	end

	p1.MouseEnter:Connect(handleOverlay)
	p1.SelectionGained:Connect(handleOverlay)
	p1.Activated:Connect(handleOverlay)
end

return t