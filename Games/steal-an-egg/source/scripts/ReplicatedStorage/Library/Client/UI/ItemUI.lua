-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")
local Audio = require(Library.Audio)
local InfoOverlay = require(Client.InfoOverlay)
local Sparkles = require(Client.GUIFX.Sparkles)
local Sparkles2 = require(Client.GUIFX.Sparkles)
local Abstract = require(script.Abstract)

require(ReplicatedStorage.Library.Items.AbstractItem)

local Simple = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)

function defaultCreate(p1, p2) --[[ defaultCreate | Line: 16 | Upvalues: Simple (copy), t (copy) ]]
	local v1 = if p2 then p2 else {}
	local ItemSlot = p1:GetRarity().ItemSlot
	local v2 = v1.QuantityOverride or p1:GetAmount()
	local v3 = ItemSlot:Clone()

	v3.Icon.Image = p1:GetIcon()
	v3.Quantity.Text = ("x%*"):format(Simple.FormatCompact(v2))
	v3.Strength.Visible = false

	local Level = v3:FindFirstChild("Level")

	if Level then
		Level.Visible = false
	end

	if v1.HideQuantity then
		v3.Quantity.Visible = false
	end

	if v1.NoScribble then
		v3.scribble.Visible = false
	end

	if not v1.NoOverlay then
		t.AddOverlay(v3, p1, v1)
	end

	return v3
end
function defaultAddOverlay(p1, p2, p3) --[[ defaultAddOverlay | Line: 46 | Upvalues: Abstract (copy), InfoOverlay (copy), Audio (copy) ]]
	local v1 = p3 or {}

	local function updateOverlay() --[[ updateOverlay | Line: 48 | Upvalues: p2 (copy), v1 (copy), Abstract (ref), InfoOverlay (ref), p1 (copy) ]]
		p2:Directory()

		local t = {}

		table.insert(t, { "Title", (" %* "):format(p2:GetName()), "Rare" })
		table.insert(t, { "Rarity", p2:GetRarity()._id })

		local v12 = if p2.Class.Name == "Skin" then "" else p2:GetDesc()

		if v1.AdditionalDescription then
			local AdditionalDescription = v1.AdditionalDescription

			v12 = if v12 == "" then AdditionalDescription else v12 .. "\n\n" .. AdditionalDescription
		end

		if v12 ~= "" then
			table.insert(t, { "Div" })
			table.insert(t, { "Desc", v12 })
		end

		Abstract.BottomOverlays(t, p2, v1)
		InfoOverlay.Add(p1, unpack(t))
	end

	p1.MouseEnter:Connect(function() --[[ Line: 74 | Upvalues: Audio (ref), updateOverlay (copy) ]]
		Audio.Play("rbxassetid://89944486811970", script, 1, 0.2)
		updateOverlay()
	end)
	p1.SelectionGained:Connect(function() --[[ Line: 79 | Upvalues: Audio (ref), updateOverlay (copy) ]]
		Audio.Play("rbxassetid://89944486811970", script, 1, 0.2)
		updateOverlay()
	end)
end

local t2 = {
	Brainrot = require(script.Brainrot)
}

require(ReplicatedStorage.ModuleLoader)(script, t2, {
	noPrint = true,
	warn = warn
})

local t3 = {
	Create = defaultCreate,
	AddOverlay = defaultAddOverlay
}

function getUIModule(p1) --[[ getUIModule | Line: 95 | Upvalues: t2 (copy), t3 (copy) ]]
	return t2[p1] or t3
end
function t.AddOverlay(p1, p2, p3) --[[ AddOverlay | Line: 99 | Upvalues: t3 (copy) ]]
	return (getUIModule(p2.Class.Name).AddOverlay or t3.AddOverlay)(p1, p2, if p3 then p3 else {})
end
function t.Create(p1, p2) --[[ Create | Line: 107 | Upvalues: t3 (copy), Sparkles2 (copy), Sparkles (copy) ]]
	local v1 = if p2 then p2 else {}
	local v3 = (getUIModule(p1.Class.Name).Create or t3.Create)(p1, v1)

	if not v1.NoButtonFX then
		Sparkles2(v3)
	end

	local star = v3:FindFirstChild("star")

	if v1.HideStars and star then
		star.Visible = false
	end

	local v4 = v1.IconOverride and v3:FindFirstChild("Icon")

	if v4 then
		v4.Image = v1.IconOverride
	end

	if p1:GetRarity()._id == "Mythical" or (p1:GetRarity()._id == "Legendary" or (p1:GetRarity()._id == "Rainbow" or (p1:GetRarity()._id == "Exotic" or p1:GetRarity()._id == "Divine"))) then
		local v5 = false

		v3.AncestryChanged:Connect(function(p1, p2) --[[ Line: 133 | Upvalues: v5 (ref), Sparkles (ref), v3 (copy) ]]
			if p2 == nil or v5 then
				return
			end

			task.defer(function() --[[ Line: 135 | Upvalues: Sparkles (ref), v3 (ref) ]]
				Sparkles(v3)
			end)
			v5 = true
		end)
	end

	if p1.LockingEnabled and v3:FindFirstChild("Locked") then
		v3.Locked.Visible = p1:IsLocked()

		if star and p1:IsLocked() then
			star.Visible = false
		end
	end

	return v3, nil
end

return t