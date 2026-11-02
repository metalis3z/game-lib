-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local LocalPlayer = Players.LocalPlayer
local UNPLACE_PROMPT = Constants.TAGS_MAP.Traps.UNPLACE_PROMPT
local t = {}

local function cleanupPromptConnections(p1) --[[ cleanupPromptConnections | Line: 27 | Upvalues: t (copy) ]]
	local v1 = t[p1]

	if not v1 then
		return
	end

	local Owner = v1.Owner

	if Owner then
		Owner:Disconnect()
	end

	local Active = v1.Active

	if Active then
		Active:Disconnect()
	end

	t[p1] = nil
end

local function updatePromptEnabled(p1) --[[ updatePromptEnabled | Line: 46 | Upvalues: LocalPlayer (copy) ]]
	local v1 = p1.Parent

	if not (v1 and v1:IsA("BasePart")) then
		p1.Enabled = false

		return
	end

	local v2 = v1:GetAttribute("Owner")

	p1.Enabled = if v2 == LocalPlayer.Name then v1:GetAttribute("TrapActive") ~= true else false
end

local function bindPromptConnections(p1) --[[ bindPromptConnections | Line: 58 | Upvalues: t (copy), LocalPlayer (copy) ]]
	local v1 = t[p1]

	if v1 then
		local Owner = v1.Owner

		if Owner then
			Owner:Disconnect()
		end

		local Active = v1.Active

		if Active then
			Active:Disconnect()
		end

		t[p1] = nil
	end

	local v2 = p1.Parent

	if v2 and v2:IsA("BasePart") then
		t[p1] = {
			Owner = v2:GetAttributeChangedSignal("Owner"):Connect(function() --[[ Line: 67 | Upvalues: p1 (copy), LocalPlayer (ref) ]]
				local v1 = p1
				local v2 = v1.Parent

				if not (v2 and v2:IsA("BasePart")) then
					v1.Enabled = false

					return
				end

				local v3 = v2:GetAttribute("Owner")

				v1.Enabled = if v3 == LocalPlayer.Name then v2:GetAttribute("TrapActive") ~= true else false
			end),
			Active = v2:GetAttributeChangedSignal("TrapActive"):Connect(function() --[[ Line: 70 | Upvalues: p1 (copy), LocalPlayer (ref) ]]
				local v1 = p1
				local v2 = v1.Parent

				if not (v2 and v2:IsA("BasePart")) then
					v1.Enabled = false

					return
				end

				local v3 = v2:GetAttribute("Owner")

				v1.Enabled = if v3 == LocalPlayer.Name then v2:GetAttribute("TrapActive") ~= true else false
			end)
		}
	end
end

local function refreshPrompt(p1) --[[ refreshPrompt | Line: 76 | Upvalues: bindPromptConnections (copy), LocalPlayer (copy) ]]
	bindPromptConnections(p1)

	local v1 = p1.Parent

	if not (v1 and v1:IsA("BasePart")) then
		p1.Enabled = false

		return
	end

	local v2 = v1:GetAttribute("Owner")

	p1.Enabled = if v2 == LocalPlayer.Name then v1:GetAttribute("TrapActive") ~= true else false
end

local function trackPrompt(p1) --[[ trackPrompt | Line: 81 | Upvalues: bindPromptConnections (copy), LocalPlayer (copy), t (copy) ]]
	bindPromptConnections(p1)

	local v1 = p1.Parent

	if v1 and v1:IsA("BasePart") then
		local v2 = v1:GetAttribute("Owner")

		p1.Enabled = if v2 == LocalPlayer.Name then v1:GetAttribute("TrapActive") ~= true else false
	else
		p1.Enabled = false
	end

	p1.AncestryChanged:Connect(function(p12, p2) --[[ Line: 84 | Upvalues: p1 (copy), t (ref), bindPromptConnections (ref), LocalPlayer (ref) ]]
		if p2 then
			local v1 = p1

			bindPromptConnections(v1)

			local v2 = v1.Parent

			if not (v2 and v2:IsA("BasePart")) then
				v1.Enabled = false

				return
			end

			local v3 = v2:GetAttribute("Owner")

			v1.Enabled = if v3 == LocalPlayer.Name then v2:GetAttribute("TrapActive") ~= true else false
		else
			local v6 = p1
			local v7 = t[v6]

			if not v7 then
				return
			end

			local Owner = v7.Owner

			if Owner then
				Owner:Disconnect()
			end

			local Active = v7.Active

			if not Active then
				t[v6] = nil

				return
			end

			Active:Disconnect()
			t[v6] = nil
		end
	end)
	p1.Destroying:Connect(function() --[[ Line: 93 | Upvalues: p1 (copy), t (ref) ]]
		local v1 = p1
		local v2 = t[v1]

		if not v2 then
			return
		end

		local Owner = v2.Owner

		if Owner then
			Owner:Disconnect()
		end

		local Active = v2.Active

		if Active then
			Active:Disconnect()
		end

		t[v1] = nil
	end)
end

local function onPromptAdded(p1) --[[ onPromptAdded | Line: 98 | Upvalues: trackPrompt (copy) ]]
	if p1:IsA("ProximityPrompt") then
		trackPrompt(p1)
	end
end

local function onPromptRemoved(p1) --[[ onPromptRemoved | Line: 106 | Upvalues: t (copy) ]]
	if not p1:IsA("ProximityPrompt") then
		return
	end

	local v1 = t[p1]

	if not v1 then
		return
	end

	local Owner = v1.Owner

	if Owner then
		Owner:Disconnect()
	end

	local Active = v1.Active

	if Active then
		Active:Disconnect()
	end

	t[p1] = nil
end

for i, v in ipairs(CollectionService:GetTagged(UNPLACE_PROMPT)) do
	if v:IsA("ProximityPrompt") then
		trackPrompt(v)
	end
end

CollectionService:GetInstanceAddedSignal(UNPLACE_PROMPT):Connect(onPromptAdded)
CollectionService:GetInstanceRemovedSignal(UNPLACE_PROMPT):Connect(onPromptRemoved)