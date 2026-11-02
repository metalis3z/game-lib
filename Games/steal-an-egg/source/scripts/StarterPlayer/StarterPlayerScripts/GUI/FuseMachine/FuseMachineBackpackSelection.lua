-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local AssetIconShape = require(ReplicatedStorage.Library.Client.UI.AssetIconShape)
local AutoGridLayout = require(ReplicatedStorage.Library.Client.AutoGridLayout)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)

require(ReplicatedStorage.Library.Types.AssetItem)

local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local Directory = require(ReplicatedStorage.Directory.Assets).Directory
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local FuseKernelUtil = require(ReplicatedStorage.Library.Util.FuseKernelUtil)

require(ReplicatedStorage.Library.Types.FuseMachine)

local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Mutations = require(ReplicatedStorage.Library.Modules.Mutations)

require(ReplicatedStorage.Library.Client.Save)

local ScreenResolution = require(ReplicatedStorage.Library.Client.ScreenResolution)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local v1 = Log.new()
local t = {}

t.__index = t
t.__class = "FuseMachineBackpackSelection"

local t2 = {}
local t3 = {
	ResolutionThreshold = (1 / 0),
	ScalePaddingOffset = true
}

t3.PerRow = if UserInputService.TouchEnabled and ScreenResolution.GetViewportSize().X < 1024 then 4 else 5
t3.Padding = UDim2.fromScale(0.02, 0.04)
t2[1] = t3

local GUI = Players.LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("GUI")

assert(GUI:IsA("Folder"), "PlayerScripts.GUI must be a Folder")

local Main = GUI.BackpackController.Main

assert(Main:IsA("ModuleScript"), "BackpackController.Main must be a ModuleScript")

local InventoryTemplate = Main.InventoryTemplate

assert(InventoryTemplate:IsA("GuiButton"), "BackpackController.Main.InventoryTemplate must be a GuiButton")
function t.new(p1) --[[ new | Line: 68 | Upvalues: t (copy), Trove (copy), AutoGridLayout (copy), t2 (copy) ]]
	local v2 = setmetatable({}, t)

	v2._active = false
	v2._rows = Trove.new()
	v2._scrollingFrame = p1
	v2._trove = Trove.new()
	v2._updateGridLayout = AutoGridLayout.Register(p1, t2)
	p1.AutomaticCanvasSize = Enum.AutomaticSize.None
	v2._trove:Add(v2._rows)

	return v2
end

local function getConfig(p1) --[[ getConfig | Line: 84 | Upvalues: Directory (copy) ]]
	local v1 = Directory[p1.Category]

	assert(v1 ~= nil, (("Missing asset config %*"):format(p1.Category)))

	return v1
end

local function getOddsDenominator(p1) --[[ getOddsDenominator | Line: 90 | Upvalues: Directory (copy), Mutations (copy) ]]
	local v1 = Directory[p1.Category]

	assert(v1 ~= nil, (("Missing asset config %*"):format(p1.Category)))

	return 1 / v1.DropWeight * Mutations.GetVisualOddsMultiplier(p1.Mutations, p1.BaseMutation)
end

local function clearDirectGradients(p1) --[[ clearDirectGradients | Line: 95 ]]
	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("UIGradient") then
			v:Destroy()
		end
	end
end

local function sortLikeBackpack(p1, p2, p3, p4) --[[ sortLikeBackpack | Line: 103 | Upvalues: Directory (copy), AssetGenerationUtil (copy), Mutations (copy), AssetItemUtil (copy) ]]
	local v1 = Directory[p1.Category]

	assert(if v1 == nil then false else true, (("Missing asset config %*"):format(p1.Category)))

	local v4 = Directory[p3.Category]

	assert(if v4 == nil then false else true, (("Missing asset config %*"):format(p3.Category)))

	local RarityNumber = v1.Rarity.RarityNumber
	local RarityNumber2 = v4.Rarity.RarityNumber

	if RarityNumber == RarityNumber2 then
		local v7 = AssetGenerationUtil.GetBaseRateMutationOnly(p1)
		local v8 = AssetGenerationUtil.GetBaseRateMutationOnly(p3)

		if v7 == v8 then
			local v9 = Directory[p1.Category]

			assert(if v9 == nil then false else true, (("Missing asset config %*"):format(p1.Category)))

			local v12 = 1 / v9.DropWeight * Mutations.GetVisualOddsMultiplier(p1.Mutations, p1.BaseMutation)
			local v13 = Directory[p3.Category]

			assert(if v13 == nil then false else true, (("Missing asset config %*"):format(p3.Category)))

			local v18 = 1 / v13.DropWeight * Mutations.GetVisualOddsMultiplier(p3.Mutations, p3.BaseMutation)

			if v12 == v18 then
				if v1.DropWeight == v4.DropWeight then
					local v19 = AssetItemUtil.GetVisualWeightKg(p1)
					local v20 = AssetItemUtil.GetVisualWeightKg(p3)

					if v19 == v20 then
						return p2 < p4
					end

					return v20 < v19
				end

				return v1.DropWeight < v4.DropWeight
			end

			return v18 < v12
		end

		return v8 < v7
	end

	return RarityNumber2 < RarityNumber
end

function t._createRow(p1, p2, p3, p4, p5) --[[ _createRow | Line: 142 | Upvalues: InventoryTemplate (copy), AssetIconShape (copy), Directory (copy), clearDirectGradients (copy), ItemDisplay (copy), AssetItemUtil (copy), ButtonFX (copy) ]]
	local v1 = InventoryTemplate:Clone()

	v1.Name = ("FuseSelection.%*"):format(p2)
	v1.LayoutOrder = p4
	v1:SetAttribute("IsInventorySlot", true)
	v1.Active = true
	v1.AutoButtonColor = false
	v1.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	v1.BackgroundTransparency = 0.5

	local UIStroke = v1.UIStroke

	assert(UIStroke:IsA("UIStroke"), "Fuse inventory row requires UIStroke")
	UIStroke.Thickness = 0
	v1.Visible = true
	v1.Parent = p1._scrollingFrame
	p1._rows:Add(v1)

	local BaseTemplate = v1.BaseTemplate
	local Amount = BaseTemplate.Amount

	assert(Amount:IsA("TextLabel"), "Fuse inventory row Amount must be a TextLabel")
	Amount.Text = ""
	Amount.Visible = false

	local Mutations = BaseTemplate.Mutations

	assert(Mutations:IsA("GuiObject"), "Fuse inventory row Mutations must be a GuiObject")
	Mutations.Visible = false

	local Icon = v1.Icon

	assert(Icon:IsA("ImageLabel"), "Fuse inventory row Icon must be an ImageLabel")
	AssetIconShape.Apply(Icon, p3)
	Icon.ImageColor3 = Color3.new(255/255, 255/255, 255/255)

	local v6 = Directory[p3.Category]

	assert(if v6 == nil then false else true, (("Missing asset config %*"):format(p3.Category)))

	local ToolName = v1.ToolName

	assert(ToolName:IsA("TextLabel"), "Fuse inventory row ToolName must be a TextLabel")
	clearDirectGradients(ToolName)
	v6.Rarity.Gradient:Clone().Parent = ToolName
	ToolName.Text = ("%* (%*)"):format(ItemDisplay.GetNameFromItemData(p3), (AssetItemUtil.GetVisualWeightKgDisplay(p3)))
	ToolName.Visible = true

	local Shadow = v1.Shadow

	assert(Shadow:IsA("ImageLabel"), "Fuse inventory row Shadow must be an ImageLabel")
	clearDirectGradients(Shadow)
	v6.Rarity.Gradient:Clone().Parent = Shadow
	Shadow.Visible = true

	local FavIcon = v1.FavIcon

	assert(FavIcon:IsA("GuiObject"), "Fuse inventory row FavIcon must be a GuiObject")
	FavIcon.Visible = false

	local Weight = v1.Weight

	assert(Weight:IsA("GuiObject"), "Fuse inventory row Weight must be a GuiObject")
	Weight.Visible = false
	p1._rows:Add(v1.Activated:Connect(function() --[[ Line: 199 | Upvalues: p5 (copy), p2 (copy) ]]
		p5(p2)
	end))
	ButtonFX(v1)
end
function t.Open(p1, p2, p3, p4) --[[ Open | Line: 209 | Upvalues: FuseKernelUtil (copy), AssetItemSerialization (copy), sortLikeBackpack (copy) ]]
	if p1._active then
		return 0
	end

	local list = {}
	local t = {}

	for k, v in pairs(p2.Inventory) do
		if FuseKernelUtil.CanSelectPet(k, v, p3, false) then
			table.insert(list, k)
			t[k] = AssetItemSerialization.Deserialize(v)
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 228 | Upvalues: sortLikeBackpack (ref), t (copy) ]]
		return sortLikeBackpack(assert(t[p1], (("Missing Fuse selection item data for %*"):format(p1))), p1, assert(t[p2], (("Missing Fuse selection item data for %*"):format(p2))), p2)
	end)

	if #list == 0 then
		return 0
	end

	p1._active = true
	p1._scrollingFrame.CanvasPosition = Vector2.zero

	for i, v in ipairs(list) do
		p1:_createRow(v, assert(t[v], (("Missing Fuse selection item data for %*"):format(v))), i, p4)
	end

	return #list
end
function t.Close(p1) --[[ Close | Line: 254 ]]
	if p1._active then
		p1._rows:Clean()
		p1._scrollingFrame.CanvasPosition = Vector2.zero
		p1._active = false
	end
end
function t.RefreshGridLayout(p1) --[[ RefreshGridLayout | Line: 264 ]]
	assert(p1._active, "FuseMachine backpack selection must be open before refreshing its grid")
	p1._updateGridLayout()
end
function t.IsOpen(p1) --[[ IsOpen | Line: 269 ]]
	return p1._active
end
function t.Destroy(p1) --[[ Destroy | Line: 273 | Upvalues: v1 (copy) ]]
	p1:Close()
	p1._trove:Destroy()
	v1:AtTrace():Log("Destroyed FuseMachine backpack selection")
end

return t