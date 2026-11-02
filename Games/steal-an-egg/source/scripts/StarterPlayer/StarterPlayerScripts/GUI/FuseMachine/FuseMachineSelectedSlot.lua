-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")

require(ReplicatedStorage.Library.Types.AssetItem)

local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)
local AssetViewport = require(ReplicatedStorage.Library.Client.AssetViewport)
local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)

require(ReplicatedStorage.Library.Types.FuseMachine)

local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local t = {}

t.__index = t
t.__class = "FuseMachineSelectedSlot"
function t.new(p1, p2, p3, p4, p5, p6) --[[ new | Line: 40 | Upvalues: t (copy), Trove (copy), AssetItemSerialization (copy), AssetViewport (copy), Directory (copy), ButtonFX (copy) ]]
	local v2 = setmetatable({}, t)

	v2._frame = p1:Clone()
	v2._trove = Trove.new()
	v2._uid = p4
	v2._frame.Name = ("Selected.%*"):format(p3)
	v2._frame.LayoutOrder = p3
	v2._frame.Visible = true
	v2._frame.Parent = p2
	v2._trove:Add(v2._frame)

	local ViewportFrame = v2._frame.ViewportFrame

	assert(ViewportFrame:IsA("ViewportFrame"), "Fuse selected slot ViewportFrame must be a ViewportFrame")

	local v4 = AssetItemSerialization.Deserialize(p5)

	v2._trove:Add((AssetViewport.AttachItemDataOnViewport(v4, ViewportFrame, t._getPresentationScale(v4.Scale), true)))

	local v6 = Directory[p5.Category]

	assert(if v6 == nil then false else true, (("Missing asset config %*"):format(p5.Category)))

	local BrainrotName = v2._frame.BrainrotName

	assert(BrainrotName:IsA("TextLabel"), "Fuse selected slot BrainrotName must be a TextLabel")
	BrainrotName.Text = v6.DisplayName
	v2:_applyMutation(p5)
	v2:_applyRarity(p5)

	local Return = v2._frame.Return

	assert(Return:IsA("ImageButton"), "Fuse selected slot Return must be an ImageButton")
	v2._trove:Add(Return.Activated:Connect(function() --[[ Line: 80 | Upvalues: p6 (copy), p4 (copy) ]]
		p6(p4)
	end))
	ButtonFX(Return)

	return v2
end
function t._getPresentationScale(p1) --[[ _getPresentationScale | Line: 91 ]]
	return math.clamp((p1 - 0.9) / 14.1, 0, 1) * 0.5 + 0.7
end
function t._applyMutation(p1, p2) --[[ _applyMutation | Line: 96 | Upvalues: Mutations (copy) ]]
	local Mutation = p1._frame.Mutation

	assert(Mutation:IsA("TextLabel"), "Fuse selected slot Mutation must be a TextLabel")

	local v2 = p2.BaseMutation or p2.Mutations[1]

	if v2 == nil or v2 == "None" then
		Mutation.Text = ""

		return
	end

	local v3 = Mutations.GetMutation(v2)

	Mutation.Text = Mutations.GetDisplayName(v2)

	if not v3 then
		return
	end

	Mutation.TextColor3 = v3.Color
end
function t._applyRarity(p1, p2) --[[ _applyRarity | Line: 115 | Upvalues: Directory (copy) ]]
	local Rarity = p1._frame.Rarity

	assert(Rarity:IsA("TextLabel"), "Fuse selected slot Rarity must be a TextLabel")

	local v2 = Directory[p2.Category]

	assert(v2 ~= nil, (("Missing asset config %*"):format(p2.Category)))

	for i, v in ipairs(Rarity:GetChildren()) do
		if v:IsA("UIGradient") then
			v:Destroy()
		end
	end

	Rarity.Text = v2.Rarity.DisplayName
	Rarity.TextColor3 = v2.Rarity.Color

	if not v2.Rarity.Gradient then
		return
	end

	v2.Rarity.Gradient:Clone().Parent = Rarity
end
function t.GetUid(p1) --[[ GetUid | Line: 139 ]]
	return p1._uid
end
function t.Destroy(p1) --[[ Destroy | Line: 143 ]]
	p1._trove:Destroy()
end

return t