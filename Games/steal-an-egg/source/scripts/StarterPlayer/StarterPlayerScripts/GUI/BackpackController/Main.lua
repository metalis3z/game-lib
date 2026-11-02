if not game:IsLoaded() then
	game.Loaded:Wait()
end

local v1 = nil
local v2 = nil
local v3 = nil
local v4 = nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local PlotCmds = require(ReplicatedStorage.Library.Client.PlotCmds)
local TabController = require(ReplicatedStorage.Library.Client.TabController)
local Message = require(ReplicatedStorage.Library.Client.NotificationCmds.Message)
local AutoGridLayout = require(ReplicatedStorage.Library.Client.AutoGridLayout)
local Areas = require(ReplicatedStorage.Directory.Areas)

RarityDirectory = require(ReplicatedStorage.Directory.Rarity).Rarities
MutationHandler = require(ReplicatedStorage.Library.Modules.Mutations)
InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)
Variables = require(ReplicatedStorage.Library.Variables)
ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
SimpleNumber = require(ReplicatedStorage.Library.Modules.FormatNumber.Simple)

local EggCmds = require(ReplicatedStorage.Library.Client.EggCmds)
local EggItemUtil = require(ReplicatedStorage.Library.Util.EggItemUtil)
local AssetGenerationUtil = require(ReplicatedStorage.Library.Util.AssetGenerationUtil)
local AssetIconShape = require(ReplicatedStorage.Library.Client.UI.AssetIconShape)
local ItemDisplay = require(ReplicatedStorage.Library.Modules.ItemDisplay)
local ToolGameplayGuard = require(ReplicatedStorage.Library.Client.ToolGameplayGuard)
local AssetItemUtil = require(ReplicatedStorage.Library.Util.AssetItemUtil)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local PreloadAssets = require(ReplicatedStorage.Library.Functions.PreloadAssets)
local t = {
	{
		Name = "Pets",
		Image = "rbxassetid://93714449004895",
		Tags = { "Asset" }
	},
	{
		Name = "Eggs",
		Image = "rbxassetid://116524274262912",
		Tags = { "AssetEgg", "PetEgg" }
	}
}
-- Eggs are the core collectible in this experience, so open the backpack on
-- the Eggs category instead of hiding newly collected eggs behind the Pets tab.
local v5 = t[2] and t[2].Name or "Eggs"
local v6 = v5
local v7 = nil
local v8 = GuiService:IsTenFootInterface() or RunService:IsStudio()
local t2 = {}

for v9, v10 in t do
	t2[v10.Name] = v10
end

function IsOfCategory(p1) --[[ IsOfCategory | Line: 78 | Upvalues: t2 (copy), v6 (ref) ]]
	if not p1 then
		return false
	end

	local v1 = t2[v6]

	if not (v1 and v1.Tags) then
		return false
	end

	for v2, v3 in v1.Tags do
		if p1:GetAttribute("ItemType") == v3 then
			return true
		end
	end

	return false
end
function GetCategory(p1) --[[ GetCategory | Line: 94 | Upvalues: t2 (copy), v5 (copy) ]]
	for v1, v2 in t2 do
		if v2.Tags then
			for v3, v4 in v2.Tags do
				if p1:GetAttribute("ItemType") == v4 then
					return v1
				end
			end
		end
	end

	return v5
end

local t3 = {
	OpenClose = nil,
	IsOpen = false,
	ModuleName = "Backpack",
	KeepVRTopbarOpen = true,
	VRIsExclusive = true,
	VRClosesNonExclusive = true,
	StartFuseSelection = nil,
	EndFuseSelection = nil,
	IsFuseSelectionActive = nil,
	StateChanged = Instance.new("BindableEvent")
}
local v11 = 60

TextSizeAttribute = script:GetAttribute("TextSize")
_BackgroundTransparencyAttribute = script:GetAttribute("BackgroundTransparency")
BackgroundColorAttribute = script:GetAttribute("BackgroundColor")
DraggableColorAttribute = script:GetAttribute("DraggableColor")
EquippedColorAttribute = script:GetAttribute("EquippedColor")
SlotLockedTransparencyAttribute = script:GetAttribute("SlotLockedTransparency")
BorderColorAttribute = script:GetAttribute("BorderColor")
ToggleHotkeys = { Enum.KeyCode.Backquote }
EmptySlotsAttribute = script:GetAttribute("EmptySlots")
_SearchBoxColorAttribute = script:GetAttribute("SearchBoxColor")
_SearchBoxTransparencyAttribute = script:GetAttribute("SearchBoxTransparency")
ApiEvent = ReplicatedStorage:FindFirstChild("Api") or script:WaitForChild("Api")
ApiEvent.Parent = ReplicatedStorage
SelectedSlot = nil
BackpackEnabled = true

local v13 = nil

ActiveFuseSelectionState = nil
function GetScreenResolution() --[[ GetScreenResolution | Line: 162 ]]
	local ScreenGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	local Frame = Instance.new("Frame", ScreenGui)

	Frame.BackgroundTransparency = 1
	Frame.Size = UDim2.new(1, 0, 1, 0)
	ScreenGui:Destroy()

	return Frame.AbsoluteSize
end

local Zero = Enum.KeyCode.Zero.Value
local Backspace = Enum.KeyCode.Backspace.Value
local t4 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}

UserInputService = game:GetService("UserInputService")
Players = game:GetService("Players")
PlayerGui = Players.LocalPlayer.PlayerGui
BackpackGui = PlayerGui:WaitForChild("BackpackGui")
ContextActionService = game:GetService("ContextActionService")
VRService = game:GetService("VRService")
Utility = require(script.Utility)
require(script.GameTranslator)
TopBarPlus = require(ReplicatedStorage.Library.Modules.Packages.TopBarPlus)
CoreCall = require(ReplicatedStorage.Library.Functions.CoreCall)
Save = require(ReplicatedStorage.Library.Client.Save)
Network = require(ReplicatedStorage.Library.Client.Network)

local AssetItemSerialization = require(ReplicatedStorage.Library.Util.AssetItemSerialization)

AssetDirectoryModule = require(ReplicatedStorage.Directory.Assets)
AssetDirectory = AssetDirectoryModule.Directory
BaseAssetConfig = require(ReplicatedStorage.Directory.Assets.BaseConfigs.Default)

local Gears = require(ReplicatedStorage.Directory.Gears)

Lock = require(ReplicatedStorage.Library.Functions.Lock)
Audio = require(ReplicatedStorage.Library.Audio)
Constants = require(ReplicatedStorage.Library.Globals.Constants)

local AssetCmds = require(ReplicatedStorage.Library.Client.AssetCmds)
local v14 = nil
local v15 = false

CloseButton = nil
InventoryStroke = nil
InventoryStrokeDefaultColor = nil
FuseSelectionVisualTrove = nil
FUSE_SELECTION_ASSET_CATEGORY_NAME = "Pets"
FUSE_SELECTION_BACKGROUND_COLOR = Color3.fromRGB(0, 255, 255)
FUSE_SELECTION_STROKE_COLOR = Color3.fromRGB(0, 183, 186)
FUSE_SELECTION_BACKGROUND_TRANSPARENCY = 0

local v16 = nil

local function isBackpackEquipInteractionBlocked() --[[ isBackpackEquipInteractionBlocked | Line: 218 ]]
	return not BackpackEnabled or (not BackpackGui.Enabled or Variables.Locks.HideUI:IsLocked())
end

local v17 = GuiService:IsTenFootInterface()

if v17 then
	TextSizeAttribute = 24
	v11 = 100
end

local v18 = false
local v20 = UserInputService.TouchEnabled and GetScreenResolution().X < 1024
local v21 = v11 * 1.5
local LocalPlayer = Players.LocalPlayer
local v22 = nil
local v23 = nil
local v24 = nil
local v25 = nil
local v26 = Color3.fromRGB(79, 63, 0)
local v27 = nil
local v28 = nil
local v29 = nil
local v30 = nil
local v31 = nil
local v32 = nil
local v33 = nil
local v34 = nil
local v35 = nil
local v36 = nil
local v37 = nil
local v38 = nil
local t5 = {}
local t6 = {
	ResolutionThreshold = (1 / 0),
	ScalePaddingOffset = true
}

t6.PerRow = if v20 then 5 else 6
t6.Padding = UDim2.new(0.02, 0, 0.04, 0)
t5[1] = t6

local v40 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = v40:FindFirstChildOfClass("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local v41 = TopBarPlus.new()

v41:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected")
v41:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected")
v41:bindToggleKey(ToggleHotkeys[1], ToggleHotkeys[2])
v41:setName("InventoryIcon")
v41:setImageScale(1.12)
v41:setOrder(-5)
v41:setCaption("Toggle the backpack.")
v41.deselectWhenOtherIconSelected = false

local t7 = {}
local v42 = nil
local t8 = {}
local t9 = {}
local t10 = {}
local v43 = 0
local v44 = false
local v45 = false
local v46 = false
local v47 = false
local v48 = false
local t11 = {}
local v49 = false
local v50 = 0
local VREnabled = VRService.VREnabled
local v51 = VREnabled and EmptySlotsAttribute or (if v20 then 5 else 10)
local v52 = if VREnabled then 3 elseif v20 then 2 else 4
local ActiveAssets = Constants.NETWORK_MAP.ActiveAssets
local AssetInventory = Constants.NETWORK_MAP.AssetInventory
local v53 = Lock()
local v54 = Lock()
local v55 = nil
local t12 = {}
local t13 = {}
local t14 = {}
local t15 = {}
local t16 = {}
local t17 = {}
local v56 = false
local t18 = {}
local t19 = {}
local t20 = {}
local t21 = {}
local t22 = {}
local v57 = false
local v58 = nil
local Backpack2 = Constants.NETWORK_MAP.Backpack
local v59 = nil
local v60 = nil
local v61 = nil
local v62 = Lock()
local v63 = 0
local v64 = false
local v65 = false
local v66 = true
local v67 = false
local v68 = false
local v69 = 0
local Frame = GUI.AutoSell():WaitForChild("Frame"):WaitForChild("Frame")
local t23 = {}
local t24 = {}
local v70 = false
local Template = Frame.UIGridLayout.Template
local v71 = nil

function invokeBackpack(p1, ...) --[[ invokeBackpack | Line: 347 ]]
	local t = { ... }
	local ok, result = pcall(function() --[[ Line: 349 | Upvalues: p1 (copy), t (copy) ]]
		local t2 = {}

		t2[1] = Network.Invoke(p1, unpack(t))

		return t2
	end)

	if ok then
		return result
	end

	warn((("[Backpack] Failed to invoke \'%*\': %*"):format(p1, result)))

	return nil
end
function isLocalPlayerWithinOwnPlotBounds() --[[ isLocalPlayerWithinOwnPlotBounds | Line: 359 | Upvalues: PlotCmds (copy), v40 (ref), LocalPlayer (ref) ]]
	local v1 = PlotCmds.GetPlotData()

	if not v1 then
		return false
	end

	local v2 = v40 or LocalPlayer.Character

	if not v2 then
		return false
	end

	local HumanoidRootPart = v2:FindFirstChild("HumanoidRootPart")

	if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
		return false
	end

	local v3, v4 = v1.PlotFolder:GetBoundingBox()
	local v5 = v3:PointToObjectSpace(HumanoidRootPart.Position)
	local v6 = v4 * 0.5

	return if math.abs(v5.X) <= v6.X then math.abs(v5.Z) <= v6.Z else false
end
function updateEquipBestButtonVisibility() --[[ updateEquipBestButtonVisibility | Line: 382 | Upvalues: v61 (ref) ]]
	if v61 then
		v61.Visible = false
	end
end
function requestEquipBestStatusRefresh(p1) --[[ requestEquipBestStatusRefresh | Line: 390 | Upvalues: v61 (ref), v68 (ref), v67 (ref), v69 (ref), Backpack2 (copy), v64 (ref), v65 (ref), v66 (ref) ]]
	if not (v61 and v68) then
		updateEquipBestButtonVisibility()

		return
	end

	if v67 then
		return
	end

	local v1 = workspace:GetServerTimeNow()

	if p1 ~= true and v1 - v69 < 0.5 then
		return
	end

	v69 = v1
	v67 = true
	task.spawn(function() --[[ Line: 408 | Upvalues: Backpack2 (ref), v67 (ref), v64 (ref), v65 (ref), v66 (ref) ]]
		local v1 = invokeBackpack(Backpack2.GET_EQUIP_BEST_STATUS)

		v67 = false

		if v1 then
			v64 = v1[1] == true
			v65 = true
			v66 = false
		end

		updateEquipBestButtonVisibility()
	end)
end
function invalidateEquipBestStatus(p1) --[[ invalidateEquipBestStatus | Line: 424 | Upvalues: v66 (ref), v68 (ref) ]]
	v66 = true

	if v68 then
		requestEquipBestStatusRefresh(p1)
	else
		updateEquipBestButtonVisibility()
	end
end
function showEquipBestDebounceNotification() --[[ showEquipBestDebounceNotification | Line: 433 | Upvalues: Message (copy) ]]
	Message.Bottom({
		Message = "Please wait a bit before equipping bests again!",
		Time = 2,
		Color = Color3.fromRGB(255, 170, 0)
	})
end
function requestEquipBest() --[[ requestEquipBest | Line: 441 | Upvalues: v63 (ref), v62 (copy), Backpack2 (copy) ]]
	if workspace:GetServerTimeNow() - v63 < 5 then
		showEquipBestDebounceNotification()

		return
	end

	if v62(function() --[[ Line: 448 | Upvalues: v63 (ref), Backpack2 (ref) ]]
		local v1 = workspace:GetServerTimeNow()

		if not (v1 - v63 < 5) then
			v63 = v1

			local v2 = invokeBackpack(Backpack2.EQUIP_BEST)

			if not v2 then
				return
			end

			local v4 = v2[2]

			if v2[1] then
				invalidateEquipBestStatus(true)

				return
			end

			if v4 ~= "DEBOUNCE" and v4 ~= "LOCKED" then
				return
			end
		end

		showEquipBestDebounceNotification()
	end) then
		return
	end

	showEquipBestDebounceNotification()
end
function applyAutoSellSlot(p1, p2) --[[ applyAutoSellSlot | Line: 479 | Upvalues: t23 (copy) ]]
	local v1 = t23[p1]

	if not v1 then
		return
	end

	local SelectedGradient = v1.SelectedGradient

	if SelectedGradient then
		SelectedGradient.Enabled = p2
	end

	local RarityGradient = v1.RarityGradient

	if not RarityGradient then
		return
	end

	RarityGradient.Enabled = not p2
end
function applyAutoSellMap(p1) --[[ applyAutoSellMap | Line: 496 | Upvalues: t24 (ref), t23 (copy) ]]
	t24 = {}

	for k, v in pairs(p1) do
		if v then
			t24[k] = true
		end
	end

	for k in pairs(t23) do
		local v1 = applyAutoSellSlot

		v1(k, t24[k] == true)
	end
end
function serializeAutoSellState() --[[ serializeAutoSellState | Line: 509 | Upvalues: t24 (ref) ]]
	local t = {}

	for k, v in pairs(t24) do
		if v then
			t[k] = true
		end
	end

	return t
end
function pushAutoSellState() --[[ pushAutoSellState | Line: 519 | Upvalues: Backpack2 (copy) ]]
	local v2 = invokeBackpack(Backpack2.SET_AUTO_SELL_STATE, (serializeAutoSellState()))

	if not v2 then
		return false
	end

	local v4 = v2[2]

	if v2[1] then
		if typeof(v4) ~= "table" then
			return true
		end

		applyAutoSellMap(v4)

		return true
	end

	if typeof(v4) ~= "string" then
		return false
	end

	warn((("[Backpack] Failed to update auto-sell: %*"):format(v4)))

	return false
end
function buildAutoSellSlots(p1) --[[ buildAutoSellSlots | Line: 542 | Upvalues: t23 (copy), Template (copy), v70 (ref), t24 (ref) ]]
	local tbl = {}

	for k, v in pairs(AssetDirectory) do
		local Rarity = v.Rarity

		if Rarity then
			local _id = Rarity._id

			if typeof(_id) == "string" then
				tbl[_id] = Rarity
			end
		end
	end

	local list = {}

	for k, v in pairs(tbl) do
		table.insert(list, v)
	end

	table.sort(list, function(p1, p2) --[[ Line: 559 ]]
		local v1 = typeof(p1.RarityNumber) == "number" and p1.RarityNumber or 0
		local v2 = typeof(p2.RarityNumber) == "number" and p2.RarityNumber or 0

		if v1 == v2 then
			local v3 = typeof(p1.DisplayName) == "string" and p1.DisplayName or p1._id

			return v3 < (typeof(p2.DisplayName) == "string" and p2.DisplayName or p2._id)
		end

		return v1 < v2
	end)

	for i, v in ipairs(list) do
		local v1, v2
		local _id = v._id

		if not t23[_id] then
			local v3 = Template:Clone()

			v3.Visible = true
			v3.Name = _id
			v3.LayoutOrder = typeof(v.RarityNumber) == "number" and v.RarityNumber or 0

			local TextButton = v3.TextButton
			local Selected = TextButton.Selected

			if Selected and Selected:IsA("UIGradient") then
				Selected.Enabled = false
			else
				Selected = nil
			end

			local TextLabel = v3:FindFirstChild("TextLabel")

			v1 = if TextLabel and TextLabel:IsA("TextLabel") then TextLabel else nil

			if v1 then
				local DisplayName = v.DisplayName

				if typeof(DisplayName) == "string" and DisplayName ~= "" then
					v1.Text = DisplayName
				else
					v1.Text = _id
				end
			end

			v3.Parent = p1

			local Gradient = v.Gradient

			if typeof(Gradient) == "Instance" then
				local RarityGradient = Gradient:Clone()

				RarityGradient.Name = "RarityGradient"
				RarityGradient.Parent = TextButton
				v2 = RarityGradient
			else
				v2 = nil
			end

			for i2, v5 in ipairs(TextButton:GetChildren()) do
				if v5:IsA("UIGradient") then
					if v5 == v2 then
						v5.Enabled = true

						continue
					end

					v5.Enabled = false
				end
			end

			t23[_id] = {
				Button = TextButton,
				SelectedGradient = Selected,
				RarityGradient = v2
			}
			ButtonFX(TextButton, nil, function() --[[ Line: 627 | Upvalues: v70 (ref), t24 (ref), _id (copy) ]]
				if v70 then
					return
				end

				local v1 = t24[_id] == true
				local v2 = not v1

				t24[_id] = v2
				applyAutoSellSlot(_id, v2)
				v70 = true

				if not pushAutoSellState() then
					t24[_id] = v1
					applyAutoSellSlot(_id, v1)
				end

				v70 = false
			end)
		end
	end
end
function initializeAutoSellUI() --[[ initializeAutoSellUI | Line: 648 | Upvalues: v59 (ref), TabController (copy), Backpack2 (copy), Frame (copy) ]]
	ButtonFX(v59, nil, function() --[[ Line: 649 | Upvalues: TabController (ref) ]]
		TabController.ToggleTab("AutoSell")
	end)

	local t = {}
	local v1 = invokeBackpack(Backpack2.GET_AUTO_SELL_STATE)

	if v1 then
		local v2 = v1[1]

		if typeof(v2) == "table" then
			for k, v in pairs(v2) do
				if v then
					t[k] = true
				end
			end
		end
	end

	buildAutoSellSlots(Frame)
	applyAutoSellMap(t)
end
function claimLowestEmptySlot(p1) --[[ claimLowestEmptySlot | Line: 670 | Upvalues: v42 (ref), v51 (copy), t7 (copy) ]]
	local v1 = v42

	if not v1 then
		return nil
	end

	if not canToolUseHotbarSlot(p1, v1.Index) then
		return nil
	end

	local v2 = nil

	for i = 1, v51 do
		local v3 = t7[i]

		if v3 and (v3 ~= v1 and (not v3.Tool and (not v3.IsFakeSlot and canToolUseHotbarSlot(p1, i)))) then
			v2 = v3

			break
		end
	end

	v42 = v2

	return v1
end
function getInsertableHotbarIndices(p1) --[[ getInsertableHotbarIndices | Line: 698 | Upvalues: v51 (copy), t7 (copy) ]]
	local t = {}

	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and (not v1.IsFakeSlot and canToolUseHotbarSlot(p1, i)) then
			table.insert(t, i)
		end
	end

	return t
end
function insertToolIntoFrontHotbar(p1) --[[ insertToolIntoFrontHotbar | Line: 711 | Upvalues: t7 (copy), v42 (ref) ]]
	local v1 = getInsertableHotbarIndices(p1)
	local v2 = v1[1]

	if not v2 then
		return nil
	end

	local v3 = t7[v2]

	if not v3 then
		return nil
	end

	if v3.Tool and (getLockedHotbarSlotForTool(p1) == v2 and canToolUseHotbarSlot(v3.Tool, v2)) then
		return nil
	end

	local v4 = v42

	if v4 then
		local v5 = table.find(v1, v4.Index)

		if v5 then
			for i = v5, 2, -1 do
				local v6 = t7[v1[i]]
				local v7 = t7[v1[i - 1]]

				if v6 and v7 then
					v7:Swap(v6)
				end
			end

			v3:Fill(p1)

			return v3
		end
	end

	local v8 = v1[#v1]
	local v9 = if v8 then t7[v8] else v8

	if v9 and v9.Tool then
		v9:MoveToInventory()
	end

	for j = #v1, 2, -1 do
		local v10 = t7[v1[j]]
		local v11 = t7[v1[j - 1]]

		if v10 and v11 then
			v11:Swap(v10)
		end
	end

	v3:Fill(p1)

	return v3
end
function _getAssetUID(p1) --[[ _getAssetUID | Line: 765 ]]
	if typeof(p1) == "table" and (p1.IsVirtualAsset or p1.IsVirtualEgg) then
		return p1.UID
	end

	if typeof(p1) == "Instance" then
		return p1:GetAttribute("UID")
	end

	return nil
end
function getAttribute(p1, p2) --[[ getAttribute | Line: 775 ]]
	if not p1 then
		return nil
	end

	if typeof(p1) == "table" and p1.GetAttribute then
		return p1:GetAttribute(p2)
	end

	if typeof(p1) == "Instance" then
		return p1:GetAttribute(p2)
	end

	return nil
end
function parseMutations(p1) --[[ parseMutations | Line: 789 ]]
	if typeof(p1) == "table" then
		return table.clone(p1)
	end

	if typeof(p1) ~= "string" then
		return {}
	end

	local t = {}

	for v1 in string.gmatch(p1, "[^,]+") do
		local v2 = string.match(v1, "^%s*(.-)%s*$")

		if v2 ~= "" then
			table.insert(t, v2)
		end
	end

	return t
end
function isAssetUIDFavorite(p1) --[[ isAssetUIDFavorite | Line: 810 | Upvalues: AssetItemSerialization (copy) ]]
	if typeof(p1) ~= "string" or p1 == "" then
		return false
	end

	local v1 = Save.Get()
	local v2 = if v1 then v1.Inventory else v1
	local v3 = if typeof(v2) == "table" then v2[p1] else nil

	if typeof(v3) ~= "table" then
		return false
	end

	local isIsFavorite = AssetItemSerialization.Deserialize(v3).IsFavorite == true

	return isIsFavorite
end
function isToolFavorite(p1) --[[ isToolFavorite | Line: 825 ]]
	if isAssetTool(p1) then
		local v1 = getAttribute(p1, "Favorite")

		if typeof(v1) == "boolean" then
			return v1
		end

		local v2 = getAttribute(p1, "ItemData")

		if typeof(v2) == "table" and v2.IsFavorite == true then
			return true
		end

		return isAssetUIDFavorite(_getAssetUID(p1))
	end

	return getAttribute(p1, "Favorite") == true
end
function getAssetItemData(p1) --[[ getAssetItemData | Line: 843 ]]
	local v1 = getAttribute(p1, "ItemData")

	if typeof(v1) == "table" then
		return v1
	end

	local v2 = getAttribute(p1, "Category")

	if not v2 then
		return nil
	end

	local v3 = getAttribute(p1, "Scale")
	local t = {
		Category = v2,
		Mutations = parseMutations(getAttribute(p1, "Mutations")),
		BaseMutation = getAttribute(p1, "BaseMutation")
	}

	t.Scale = if typeof(v3) == "number" and v3 then v3 else 1
	t.IsFavorite = isAssetUIDFavorite(_getAssetUID(p1))

	return t
end
function getAssetItemDisplayName(p1, p2) --[[ getAssetItemDisplayName | Line: 865 | Upvalues: ItemDisplay (copy) ]]
	local v1 = if typeof(p1) == "table" then true else false

	if v1 and (typeof(p1.Category) == "string" and AssetDirectory[p1.Category]) then
		return ItemDisplay.GetNameFromItemData(p1)
	end

	local v2 = if v1 then p1.DisplayName else nil
	local v3 = if v1 then p1.Category else nil

	return if v2 then v2 else p2 and p2.DisplayName or (if v3 then v3 else "Asset")
end
function getAssetItemDisplayNameWithVisualWeight(p1, p2) --[[ getAssetItemDisplayNameWithVisualWeight | Line: 876 | Upvalues: AssetItemUtil (copy) ]]
	return ("%* (%*)"):format(getAssetItemDisplayName(p1, p2), (AssetItemUtil.GetVisualWeightKgDisplay(p1)))
end
function isAssetTool(p1) --[[ isAssetTool | Line: 881 ]]
	return getAttribute(p1, "ItemType") == "Asset"
end
function getGearName(p1) --[[ getGearName | Line: 885 ]]
	local v1 = getAttribute(p1, "GearName")

	if typeof(v1) == "string" and v1 ~= "" then
		return v1
	end

	return nil
end
function getGearConfig(p1) --[[ getGearConfig | Line: 890 | Upvalues: Gears (copy) ]]
	local v1 = getGearName(p1)

	if v1 then
		return Gears.Directory[v1]
	end

	return nil
end
function getGearUses(p1) --[[ getGearUses | Line: 895 ]]
	local v1 = getAttribute(p1, "Uses")

	if typeof(v1) == "number" then
		return math.max(v1, 0)
	end

	return 0
end
function shouldDisplayGearUses(p1) --[[ shouldDisplayGearUses | Line: 900 ]]
	local v1 = getGearConfig(p1)

	if not v1 then
		return false
	end

	return if typeof(v1.ActiveDeploymentAttribute) == "string" then v1.ActiveDeploymentAttribute ~= "" else false
end
function getGearUsesText(p1) --[[ getGearUsesText | Line: 909 ]]
	return ("x%*"):format((getGearUses(p1)))
end
function getHotbarFillTool(p1) --[[ getHotbarFillTool | Line: 913 ]]
	local _ = typeof(p1) == "table" and (p1.IsVirtualAsset or p1.IsVirtualEgg)

	return p1
end
function virtualAssetMatchesUID(p1, p2) --[[ virtualAssetMatchesUID | Line: 921 ]]
	if typeof(p1) ~= "table" or (not p1.IsVirtualAsset or typeof(p2) ~= "string") then
		return false
	end

	return p1.UID == p2
end
function getVirtualAssetUID(p1) --[[ getVirtualAssetUID | Line: 929 ]]
	if typeof(p1) == "table" and p1.IsVirtualAsset then
		return p1.UID
	end

	return nil
end
function getVirtualEggUID(p1) --[[ getVirtualEggUID | Line: 937 ]]
	if typeof(p1) == "table" and p1.IsVirtualEgg then
		return p1.UID
	end

	return nil
end
function virtualEggSlotMatchesUID(p1, p2) --[[ virtualEggSlotMatchesUID | Line: 945 ]]
	if not p1 or p1.IsDeleted then
		return false
	end

	return getVirtualEggUID(p1.Tool) == p2
end
function findVirtualEggSlotByUID(p1) --[[ findVirtualEggSlotByUID | Line: 953 | Upvalues: t7 (copy) ]]
	for k, v in pairs(t7) do
		if virtualEggSlotMatchesUID(v, p1) then
			return v
		end
	end

	return nil
end
function clearVirtualEggSlotsByUID(p1) --[[ clearVirtualEggSlotsByUID | Line: 963 | Upvalues: t7 (copy), v51 (copy) ]]
	for i = #t7, 1, -1 do
		local v1 = t7[i]

		if virtualEggSlotMatchesUID(v1, p1) then
			v1:Clear()

			if v51 < v1.Index then
				v1:Delete()
			end
		end
	end
end
function clearDuplicateVirtualEggSlotsByUID(p1, p2) --[[ clearDuplicateVirtualEggSlotsByUID | Line: 975 | Upvalues: t7 (copy), v51 (copy) ]]
	for i = #t7, 1, -1 do
		local v1 = t7[i]

		if v1 ~= p2 and virtualEggSlotMatchesUID(v1, p1) then
			v1:Clear()

			if v51 < v1.Index then
				v1:Delete()
			end
		end
	end
end
function getRegisteredBackpackSlot(p1) --[[ getRegisteredBackpackSlot | Line: 987 | Upvalues: t12 (copy), t18 (copy), t8 (copy) ]]
	local v1 = getVirtualAssetUID(p1)

	if v1 then
		return t12[v1]
	end

	local v2 = getVirtualEggUID(p1)

	if v2 then
		return t18[v2]
	end

	return t8[p1]
end
function registeredSlotContainsTool(p1, p2) --[[ registeredSlotContainsTool | Line: 1001 ]]
	if not p1 or p1.IsDeleted then
		return false
	end

	local Tool = p1.Tool
	local v1 = getVirtualAssetUID(p2)

	if v1 then
		return getVirtualAssetUID(Tool) == v1
	end

	local v3 = getVirtualEggUID(p2)

	if v3 then
		return getVirtualEggUID(Tool) == v3
	end

	return Tool == p2
end
function unregisterVirtualBackpackSlot(p1, p2) --[[ unregisterVirtualBackpackSlot | Line: 1020 | Upvalues: t12 (copy), t13 (copy), t18 (copy), t19 (copy) ]]
	local v1 = getVirtualAssetUID(p2)

	if v1 and t12[v1] == p1 then
		t12[v1] = nil
	end

	if v1 and t13[v1] == p2 then
		t13[v1] = nil
	end

	local v2 = getVirtualEggUID(p2)

	if v2 and t18[v2] == p1 then
		t18[v2] = nil
	end

	if not v2 or t19[v2] ~= p2 then
		return
	end

	t19[v2] = nil
end
function unregisterBackpackSlotTool(p1, p2) --[[ unregisterBackpackSlotTool | Line: 1038 | Upvalues: t8 (copy) ]]
	unregisterVirtualBackpackSlot(p1, p2)

	if not p2 or t8[p2] ~= p1 then
		return
	end

	t8[p2] = nil
end
function registerVirtualBackpackSlot(p1, p2) --[[ registerVirtualBackpackSlot | Line: 1046 | Upvalues: t12 (copy), t13 (copy), t18 (copy), t19 (copy) ]]
	local v1 = getVirtualAssetUID(p2)

	if v1 then
		t12[v1] = p1
		t13[v1] = p2
	end

	local v2 = getVirtualEggUID(p2)

	if not v2 then
		return
	end

	t18[v2] = p1
	t19[v2] = p2
end
function createVirtualAsset(p1, p2) --[[ createVirtualAsset | Line: 1060 ]]
	local Category = p2.Category
	local v1 = AssetDirectory[Category] or BaseAssetConfig
	local v2 = table.clone(p2)
	local v3 = getAssetItemDisplayName(v2, v1)

	return {
		IsVirtualAsset = true,
		ToolTip = "",
		UID = p1,
		Name = v3,
		TextureId = v1.Icon or "",
		GetAttribute = function(p12, p2) --[[ GetAttribute | Line: 1072 | Upvalues: p1 (copy), Category (copy), v3 (copy), v2 (copy) ]]
			if p2 == "ItemType" then
				return "Asset"
			end

			if p2 == "UID" then
				return p1
			end

			if p2 == "Category" then
				return Category
			end

			if p2 == "DisplayName" then
				return v3
			end

			if p2 == "Mutations" then
				local concat = table.concat

				return concat(v2.Mutations or {}, ", ")
			end

			if p2 == "BaseMutation" then
				return v2.BaseMutation
			end

			if p2 == "Scale" then
				return v2.Scale
			end

			if p2 == "ItemData" then
				return v2
			end

			if p2 ~= "Favorite" then
				return nil
			end

			local v22 = Save.Get()

			if v22 and typeof(v22.Inventory) == "table" then
				return isAssetUIDFavorite(p1)
			end

			return v2.IsFavorite == true
		end,
		IsA = function(p1, p2) --[[ IsA | Line: 1100 ]]
			return p2 == "Tool"
		end
	}
end
function isAssetUIDPlaced(p1) --[[ isAssetUIDPlaced | Line: 1106 | Upvalues: t14 (ref) ]]
	return if typeof(p1) == "string" then t14[p1] == true else false
end
function hasLocalAssetToolUID(p1) --[[ hasLocalAssetToolUID | Line: 1110 ]]
	return findAssetToolByUID(p1) ~= nil
end
function refreshPlacedAssetUIDs(p1) --[[ refreshPlacedAssetUIDs | Line: 1114 | Upvalues: t14 (ref) ]]
	local t = {}

	for k in pairs(p1) do
		if typeof(k) == "string" then
			t[k] = true
		end
	end

	t14 = t
end
function assetSignatureField(p1) --[[ assetSignatureField | Line: 1125 ]]
	if p1 == nil then
		return ""
	end

	return tostring(p1)
end
function getAssetItemSignature(p1) --[[ getAssetItemSignature | Line: 1133 ]]
	local concat = table.concat
	local t = {}
	local v1 = assetSignatureField(p1.Category)
	local concat2 = table.concat

	t[1] = v1
	t[2] = concat2(p1.Mutations or {}, ",")
	t[3] = assetSignatureField(p1.BaseMutation)
	t[4] = assetSignatureField(p1.Scale)
	t[5] = assetSignatureField(p1.Gender)
	t[6] = assetSignatureField(p1.EyeColor)
	t[7] = assetSignatureField(p1.ColorSeed)
	t[8] = assetSignatureField(p1.ColorIndex)
	t[9] = assetSignatureField(p1.GeneratedMoney)
	t[10] = assetSignatureField(p1.PendingEggName)
	t[11] = assetSignatureField(p1.Claimed)
	t[12] = assetSignatureField(p1.HasBeenFirstPlaced)

	return concat(t, "\31")
end
function buildEligibleAssetDataFromSave() --[[ buildEligibleAssetDataFromSave | Line: 1150 | Upvalues: AssetItemSerialization (copy) ]]
	local v1 = Save.Get()

	if not v1 then
		return {}, {}
	end

	if typeof(v1.Inventory) ~= "table" then
		return {}, {}
	end

	local t = {}
	local t2 = {}

	for k, v in pairs(v1.Inventory) do
		if typeof(k) == "string" and typeof(v) == "table" then
			local v2 = AssetItemSerialization.Deserialize(v)
			local v4 = if table.find(v1.EquippedAssets or {}, k) == nil then false else true

			if v2.InFuse ~= true and (not v4 or hasLocalAssetToolUID(k)) and not isAssetUIDPlaced(k) then
				t[k] = v2
				t2[k] = getAssetItemSignature(v2)
			end
		end
	end

	return t, t2
end
function isSerializedAssetEligibleForBackpack(p1, p2) --[[ isSerializedAssetEligibleForBackpack | Line: 1176 | Upvalues: AssetItemSerialization (copy) ]]
	if typeof(p2) ~= "table" then
		return false
	end

	local v1 = AssetItemSerialization.Deserialize(p2)
	local v2 = Save.Get()
	local v3

	if v2 then
		local find = table.find

		v3 = if find(v2.EquippedAssets or {}, p1) == nil then false else true
	else
		v3 = v2
	end

	if v1.InFuse == true or v3 and not hasLocalAssetToolUID(p1) then
		return false
	end

	if isAssetUIDPlaced(p1) then
		return false
	end

	return true
end
function captureEligibleAssetUIDs() --[[ captureEligibleAssetUIDs | Line: 1191 ]]
	local v1 = Save.Get()
	local t = {}

	if not v1 then
		return t
	end

	if typeof(v1.Inventory) ~= "table" then
		return t
	end

	for k, v in pairs(v1.Inventory) do
		if typeof(k) == "string" and isSerializedAssetEligibleForBackpack(k, v) then
			t[k] = true
		end
	end

	return t
end
function queueNewEligibleAssetsForHotbar(p1, p2) --[[ queueNewEligibleAssetsForHotbar | Line: 1211 | Upvalues: t16 (copy) ]]
	for k in pairs(p2) do
		if p1[k] ~= true then
			t16[k] = true
		end
	end
end
function getEggConfigForRecord(p1) --[[ getEggConfigForRecord | Line: 1219 ]]
	if typeof(p1) ~= "table" then
		return nil, nil
	end

	if typeof(p1.AssetCategory) ~= "string" then
		return nil, nil
	end

	local v1 = AssetDirectory[p1.AssetCategory]

	if v1 then
		return v1.Egg, v1
	end

	return nil, nil
end
function getAreaForEggRecord(p1) --[[ getAreaForEggRecord | Line: 1232 | Upvalues: Areas (copy) ]]
	local _, v1 = getEggConfigForRecord(p1)

	if not (v1 and v1.Rarity) then
		return nil
	end

	local AssetCategory = p1.AssetCategory
	local v2 = v1.Rarity._id or v1.Rarity.DisplayName

	for k, v in pairs(Areas.Directory) do
		for i, v3 in ipairs(v.DropTable) do
			local v32 = v3[1]

			if v32 == AssetCategory or v32 == v2 then
				return v
			end
		end
	end

	return nil
end
function getEggDisplayName(p1) --[[ getEggDisplayName | Line: 1252 ]]
	local v1 = getAreaForEggRecord(p1)

	if v1 then
		return ("%* Egg"):format(v1.DisplayName)
	end

	return "Egg"
end
function getEggDisplayNameWithWeight(p1) --[[ getEggDisplayNameWithWeight | Line: 1261 | Upvalues: EggItemUtil (copy) ]]
	return ("%* (%*)"):format(getEggDisplayName(p1), (EggItemUtil.GetWeightKgDisplay(p1)))
end
function getEggRecordFromTool(p1) --[[ getEggRecordFromTool | Line: 1265 ]]
	local v1 = getAttribute(p1, "EggRecord")

	if typeof(v1) == "table" then
		return v1
	end

	local v2 = getAttribute(p1, "AssetCategory") or getAttribute(p1, "Category")
	local v3 = getAttribute(p1, "AssetScale") or getAttribute(p1, "Scale")

	if typeof(v2) == "string" and typeof(v3) == "number" then
		return {
			AssetCategory = v2,
			AssetScale = v3,
			Mutations = parseMutations(getAttribute(p1, "Mutations")),
			BaseMutation = getAttribute(p1, "BaseMutation")
		}
	end

	return nil
end
function createVirtualEgg(p1, p2) --[[ createVirtualEgg | Line: 1285 | Upvalues: EggItemUtil (copy) ]]
	local v1, v2 = getEggConfigForRecord(p2)

	if v1 and v2 then
		local v3 = getEggDisplayNameWithWeight(p2)
		local v4 = EggItemUtil.GetWeightKg(p2)

		return {
			IsVirtualEgg = true,
			UID = p1,
			Name = v3,
			TextureId = v1.Icon or "",
			ToolTip = v3,
			GetAttribute = function(p12, p22) --[[ GetAttribute | Line: 1299 | Upvalues: p1 (copy), p2 (copy), v3 (copy), v4 (copy) ]]
				if p22 == "ItemType" then
					return "AssetEgg"
				end

				if p22 == "UID" then
					return p1
				end

				if p22 == "AssetCategory" or p22 == "Category" then
					return p2.AssetCategory
				end

				if p22 == "DisplayName" then
					return v3
				end

				if p22 == "EggDisplayName" then
					return v3
				end

				if p22 == "EggRecord" then
					return table.clone(p2)
				end

				if p22 == "Mutations" then
					local concat = table.concat

					return concat(p2.Mutations or {}, ", ")
				end

				if p22 == "BaseMutation" then
					return p2.BaseMutation
				end

				if p22 == "Weight" or p22 == "WeightKg" then
					return v4
				end

				if p22 == "Favorite" then
					return false
				end

				return nil
			end,
			IsA = function(p1, p2) --[[ IsA | Line: 1324 ]]
				return p2 == "Tool"
			end
		}
	end

	return nil
end
function buildVirtualEggsFromSave() --[[ buildVirtualEggsFromSave | Line: 1330 ]]
	local v1 = Save.Get()
	local v2 = if v1 then v1.EggInventory else v1
	local t = {}

	if typeof(v2) ~= "table" then
		return t
	end

	for k, v in pairs(v2) do
		if typeof(k) == "string" and (typeof(v) == "table" and v.Placement == nil) then
			local v3 = createVirtualEgg(k, v)

			if v3 then
				t[k] = v3
			end
		end
	end

	return t
end
function captureEggUIDs() --[[ captureEggUIDs | Line: 1352 ]]
	local v1 = Save.Get()
	local v2 = if v1 then v1.EggInventory else v1
	local t = {}

	if typeof(v2) ~= "table" then
		return t
	end

	for k, v in pairs(v2) do
		if typeof(k) == "string" and (typeof(v) == "table" and v.Placement == nil) then
			t[k] = true
		end
	end

	return t
end
function queueNewEggsForHotbar(p1, p2) --[[ queueNewEggsForHotbar | Line: 1369 | Upvalues: t20 (copy) ]]
	for k in pairs(p2) do
		if not p1[k] then
			t20[k] = true
		end
	end
end
function clearInstanceAssetSlots() --[[ clearInstanceAssetSlots | Line: 1377 | Upvalues: t7 (copy), v51 (copy) ]]
	local v1 = false

	for k, v in pairs(t7) do
		local v2 = if v then v.Tool else v

		if v and (typeof(v2) == "Instance" and (v2:IsA("Tool") and isAssetTool(v2))) then
			v:Clear()
			v1 = true

			if v51 < v.Index then
				v:Delete()
			end
		end
	end

	return v1
end
function clearPlacedAssetBackpackSlot(p1) --[[ clearPlacedAssetBackpackSlot | Line: 1393 | Upvalues: t16 (copy), t15 (copy), t7 (copy), v51 (copy), t12 (copy), t13 (copy) ]]
	t16[p1] = nil
	t15[p1] = nil

	local v1 = false

	for i = #t7, 1, -1 do
		local v2 = t7[i]
		local v3 = if v2 then v2.Tool else v2

		if v2 and (v3 and (getAttribute(v3, "ItemType") == "Asset" and _getAssetUID(v3) == p1)) then
			v2:Clear()
			v1 = true

			if v51 < v2.Index then
				v2:Delete()
			end
		end
	end

	t12[p1] = nil
	t13[p1] = nil

	return v1
end
function clearPlacedAssetBackpackSlots(p1) --[[ clearPlacedAssetBackpackSlots | Line: 1415 ]]
	local v1 = false

	for k in pairs(p1) do
		if typeof(k) == "string" and clearPlacedAssetBackpackSlot(k) then
			v1 = true
		end
	end

	return v1
end
function syncAssetsFromSave() --[[ syncAssetsFromSave | Line: 1426 | Upvalues: v28 (ref), t12 (copy), v51 (copy), t15 (copy), t13 (copy) ]]
	if not v28 then
		return false
	end

	local v1, v2 = buildEligibleAssetDataFromSave()
	local v3 = clearInstanceAssetSlots()

	for k, v in pairs(t12) do
		if not v1[k] then
			if v and not v.IsDeleted then
				v:Clear()

				if v51 < v.Index then
					v:Delete()
				end
			end

			t12[k] = nil
			t15[k] = nil
			v3 = true
		end
	end

	for k, v in pairs(v1) do
		local v4 = v2[k]
		local v5 = t12[k]
		local v6 = if v5 then not v5.IsDeleted and virtualAssetMatchesUID(v5.Tool, k) else v5

		if not v6 or (if t15[k] == v4 then false else true) then
			if not v6 then
				v5 = FindEmptyInventorySlot() or MakeSlot(v28)
			end

			t12[k] = v5
			t13[k] = createVirtualAsset(k, v)
			t15[k] = v4
			v5:Fill(t13[k])
			v3 = true

			continue
		end

		if v5 then
			t13[k] = v5.Tool
			t15[k] = v4

			if v5.UpdateFavoriteVisual and v5:UpdateFavoriteVisual() then
				v3 = true
			end
		end
	end

	for k in pairs(t13) do
		if not v1[k] then
			t13[k] = nil
		end
	end

	if not v3 then
		return v3
	end

	AdjustHotbarFrames()
	UpdateInventorySlots()

	return v3
end
function syncEggsFromSave() --[[ syncEggsFromSave | Line: 1484 | Upvalues: v28 (ref), t18 (copy), t19 (copy) ]]
	if not v28 then
		return
	end

	local v1 = buildVirtualEggsFromSave()

	for k in pairs(t18) do
		if not v1[k] then
			clearVirtualEggSlotsByUID(k)
			t18[k] = nil
		end
	end

	for k, v in pairs(v1) do
		local v2 = t18[k]

		if not virtualEggSlotMatchesUID(v2, k) then
			v2 = findVirtualEggSlotByUID(k)
		end

		if not v2 or v2.IsDeleted then
			v2 = FindEmptyInventorySlot() or MakeSlot(v28)
		end

		t18[k] = v2
		t19[k] = v
		clearDuplicateVirtualEggSlotsByUID(k, v2)
		v2:Fill(v)
	end

	for k in pairs(t19) do
		if not v1[k] then
			t19[k] = nil
		end
	end

	AdjustHotbarFrames()
	UpdateInventorySlots()
end
function getAssetRarityNumber(p1) --[[ getAssetRarityNumber | Line: 1523 ]]
	local v1 = getAttribute(p1, "Category")
	local v2 = getAttribute(p1, "Category") and AssetDirectory[v1] or BaseAssetConfig
	local v3 = if v2 then v2.Rarity else v2

	if not v3 then
		return (1 / 0)
	end

	if v3.RarityNumber then
		return v3.RarityNumber
	end

	if RarityDirectory[v3] and RarityDirectory[v3].RarityNumber then
		return RarityDirectory[v3].RarityNumber
	end

	return (1 / 0)
end
function getAssetDropWeight(p1) --[[ getAssetDropWeight | Line: 1539 ]]
	local v1 = getAttribute(p1, "Category")
	local v2 = getAttribute(p1, "Category") and AssetDirectory[v1] or BaseAssetConfig

	if not v2 then
		return (1 / 0)
	end

	if typeof(v2.DropWeight) == "number" then
		return v2.DropWeight
	end

	return (1 / 0)
end
function getAssetOddsDenominator(p1) --[[ getAssetOddsDenominator | Line: 1550 ]]
	if getAttribute(p1, "ItemType") ~= "Asset" then
		return 0
	end

	local v1 = getAttribute(p1, "Category")
	local v2 = getAttribute(p1, "Category") and AssetDirectory[v1] or BaseAssetConfig
	local v3 = if v2 then v2.DropWeight else v2

	if typeof(v3) ~= "number" or v3 <= 0 then
		return 0
	end

	local v4 = getAssetItemData(p1)

	if v4 then
		return 1 / v3 * MutationHandler.GetVisualOddsMultiplier(v4.Mutations, v4.BaseMutation)
	end

	return 0
end
function getAssetEarningRate(p1) --[[ getAssetEarningRate | Line: 1570 | Upvalues: AssetGenerationUtil (copy) ]]
	if getAttribute(p1, "ItemType") ~= "Asset" then
		return 0
	end

	local v1 = getAssetItemData(p1)

	if v1 then
		return AssetGenerationUtil.GetBaseRateMutationOnly(v1)
	end

	return 0
end
function getEggAssetConfig(p1) --[[ getEggAssetConfig | Line: 1583 ]]
	local _, v2 = getEggConfigForRecord((getEggRecordFromTool(p1)))

	if v2 then
		return v2
	end

	local v3 = getAttribute(p1, "AssetCategory") or getAttribute(p1, "Category")

	return if v3 then AssetDirectory[v3] or nil else nil
end
function getEggRarityNumber(p1) --[[ getEggRarityNumber | Line: 1594 ]]
	local v1 = getEggAssetConfig(p1)
	local v2 = if v1 then v1.Rarity else v1

	if not v2 then
		return (1 / 0)
	end

	if v2.RarityNumber then
		return v2.RarityNumber
	end

	if RarityDirectory[v2] and RarityDirectory[v2].RarityNumber then
		return RarityDirectory[v2].RarityNumber
	end

	return (1 / 0)
end
function getEggBaseEarningRate(p1) --[[ getEggBaseEarningRate | Line: 1609 ]]
	local v1 = getEggAssetConfig(p1)

	if not v1 then
		return 0
	end

	if typeof(v1.EarningRate) == "number" then
		return v1.EarningRate
	end

	return 0
end
function requestFavoriteToggle(p1) --[[ requestFavoriteToggle | Line: 1614 | Upvalues: v54 (copy), AssetInventory (copy) ]]
	if ActiveFuseSelectionState then
		return
	end

	if not isAssetTool(p1) then
		return
	end

	local v1 = _getAssetUID(p1)

	if typeof(v1) == "string" and v1 ~= "" then
		local v2 = not isToolFavorite(p1)

		v54(function() --[[ Line: 1629 | Upvalues: AssetInventory (ref), v1 (copy), v2 (copy) ]]
			Network.Fire(AssetInventory.SET_FAVORITE, v1, v2)
		end)
	end
end
function getStackQuantity(p1) --[[ getStackQuantity | Line: 1634 ]]
	local v1 = getAttribute(p1, "StackQuantity")

	if typeof(v1) == "number" and v1 > 1 then
		return math.floor(v1)
	end

	return 1
end
function clearMutationIconFrame(p1, p2) --[[ clearMutationIconFrame | Line: 1643 ]]
	if not (p1 and p2) then
		return
	end

	for i, v in ipairs(p1:GetChildren()) do
		if v:IsA("ImageLabel") and v ~= p2 then
			v:Destroy()
		end
	end

	p1.Visible = false
end
function populateMutationIconFrame(p1, p2, p3, p4) --[[ populateMutationIconFrame | Line: 1657 ]]
	if p1 and p2 then
		clearMutationIconFrame(p1, p2)
		p1.Visible = false
	end
end
function updateEquipSelectionVisuals() --[[ updateEquipSelectionVisuals | Line: 1685 | Upvalues: t7 (copy) ]]
	for k, v in pairs(t7) do
		if v then
			v:UpdateEquipView()
		end
	end
end
function findVirtualAssetSlotContainingUID(p1) --[[ findVirtualAssetSlotContainingUID | Line: 1693 | Upvalues: t7 (copy) ]]
	for k, v in pairs(t7) do
		if v and virtualAssetMatchesUID(v.Tool, p1) then
			return v
		end
	end

	return nil
end
function getCharacterAssetToolUID() --[[ getCharacterAssetToolUID | Line: 1703 | Upvalues: v40 (ref) ]]
	for i, v in ipairs(v40:GetChildren()) do
		if v:IsA("Tool") and v:GetAttribute("ItemType") == "Asset" then
			local v1 = v:GetAttribute("UID")

			if typeof(v1) == "string" then
				return v1
			end
		end
	end

	return nil
end
function findAssetToolByUID(p1) --[[ findAssetToolByUID | Line: 1716 | Upvalues: v40 (ref), Backpack (ref) ]]
	local function searchContainer(p12) --[[ searchContainer | Line: 1717 | Upvalues: p1 (copy) ]]
		if not p12 then
			return nil
		end

		for i, v in ipairs(p12:GetChildren()) do
			if v:IsA("Tool") and (v:GetAttribute("ItemType") == "Asset" and v:GetAttribute("UID") == p1) then
				return v
			end
		end

		return nil
	end

	local v1 = searchContainer(v40)

	if v1 then
		return v1
	end

	local v2 = searchContainer(Backpack)

	if v2 then
		return v2
	end

	return nil
end
function applyVirtualAssetEquipUID(p1) --[[ applyVirtualAssetEquipUID | Line: 1744 | Upvalues: v55 (ref) ]]
	v55 = p1

	if typeof(p1) == "string" then
		SelectedSlot = findVirtualAssetSlotContainingUID(p1)
	else
		if not SelectedSlot or getAttribute(SelectedSlot.Tool, "ItemType") ~= "Asset" then
			updateEquipSelectionVisuals()

			return
		end

		SelectedSlot = nil
	end

	updateEquipSelectionVisuals()
end
function reconcileVirtualAssetEquipState() --[[ reconcileVirtualAssetEquipState | Line: 1755 | Upvalues: v55 (ref) ]]
	local v1 = getCharacterAssetToolUID()

	if v1 ~= v55 then
		applyVirtualAssetEquipUID(v1)

		return v1
	end

	if typeof(v1) == "string" and not SelectedSlot then
		SelectedSlot = findVirtualAssetSlotContainingUID(v1)
		updateEquipSelectionVisuals()
	end

	return v1
end
function syncVirtualAssetEquipStateFromTool(p1) --[[ syncVirtualAssetEquipStateFromTool | Line: 1767 | Upvalues: v40 (ref), Backpack (ref), v55 (ref) ]]
	local v1 = p1:GetAttribute("UID")

	if typeof(v1) ~= "string" then
		return
	end

	if p1.Parent == v40 then
		applyVirtualAssetEquipUID(v1)

		return
	end

	if p1.Parent ~= Backpack or v55 ~= v1 then
		return
	end

	task.defer(reconcileVirtualAssetEquipState)
end
function getCharacterEggToolUID() --[[ getCharacterEggToolUID | Line: 1780 | Upvalues: v40 (ref) ]]
	for i, v in ipairs(v40:GetChildren()) do
		if v:IsA("Tool") and v:GetAttribute("ItemType") == "AssetEgg" then
			local v1 = v:GetAttribute("UID")

			if typeof(v1) == "string" then
				return v1
			end
		end
	end

	return nil
end
function applyVirtualEggEquipUID(p1) --[[ applyVirtualEggEquipUID | Line: 1793 | Upvalues: v58 (ref) ]]
	v58 = p1

	if typeof(p1) == "string" then
		SelectedSlot = findVirtualEggSlotByUID(p1)
	else
		if not SelectedSlot or getAttribute(SelectedSlot.Tool, "ItemType") ~= "AssetEgg" then
			updateEquipSelectionVisuals()

			return
		end

		SelectedSlot = nil
	end

	updateEquipSelectionVisuals()
end
function reconcileVirtualEggEquipState() --[[ reconcileVirtualEggEquipState | Line: 1804 | Upvalues: v58 (ref) ]]
	local v1 = getCharacterEggToolUID()

	if v1 ~= v58 then
		applyVirtualEggEquipUID(v1)

		return v1
	end

	if typeof(v1) == "string" and not SelectedSlot then
		SelectedSlot = findVirtualEggSlotByUID(v1)
		updateEquipSelectionVisuals()
	end

	return v1
end
function syncVirtualEggEquipStateFromTool(p1) --[[ syncVirtualEggEquipStateFromTool | Line: 1816 | Upvalues: v40 (ref), Backpack (ref), v58 (ref) ]]
	local v1 = p1:GetAttribute("UID")

	if typeof(v1) ~= "string" then
		return
	end

	if p1.Parent == v40 then
		applyVirtualEggEquipUID(v1)

		return
	end

	if p1.Parent ~= Backpack or v58 ~= v1 then
		return
	end

	task.defer(reconcileVirtualEggEquipState)
end
function requestUnequipVirtualEgg() --[[ requestUnequipVirtualEgg | Line: 1829 | Upvalues: v58 (ref), v53 (copy), EggCmds (copy), Message (copy) ]]
	reconcileVirtualEggEquipState()

	if v58 then
		local v1 = false

		v53(function() --[[ Line: 1836 | Upvalues: v58 (ref), EggCmds (ref), v1 (ref), Message (ref) ]]
			local v12 = v58
			local v2, v3 = EggCmds.RequestUnequipTool(v12)

			if v2 then
				v58 = nil

				if SelectedSlot and getAttribute(SelectedSlot.Tool, "UID") == v12 then
					SelectedSlot = nil
				end

				updateEquipSelectionVisuals()
				v1 = true
			else
				if not v3 then
					return
				end

				Message.Bottom({
					Time = 2,
					Message = v3,
					Color = Color3.fromRGB(255, 64, 64)
				})
			end
		end)

		return v1
	end

	return true
end
function requestEquipVirtualEgg(p1, p2) --[[ requestEquipVirtualEgg | Line: 1861 | Upvalues: v53 (copy), Humanoid (ref), EggCmds (copy), v58 (ref), Message (copy) ]]
	if not BackpackEnabled or (not BackpackGui.Enabled or Variables.Locks.HideUI:IsLocked()) then
		return
	end

	if reconcileVirtualEggEquipState() == p1 then
		SelectedSlot = p2
		updateEquipSelectionVisuals()
	else
		v53(function() --[[ Line: 1872 | Upvalues: Humanoid (ref), EggCmds (ref), p1 (copy), v58 (ref), p2 (copy), Message (ref) ]]
			requestUnequipVirtualAsset()

			if Humanoid then
				Humanoid:UnequipTools()
			end

			local v1, v2 = EggCmds.RequestEquipTool(p1)

			if v1 then
				v58 = p1
				SelectedSlot = p2
				updateEquipSelectionVisuals()

				return
			end

			if not v2 then
				return
			end

			Message.Bottom({
				Time = 2,
				Message = v2,
				Color = Color3.fromRGB(255, 64, 64)
			})
		end)
	end
end
function requestUnequipVirtualAsset() --[[ requestUnequipVirtualAsset | Line: 1896 | Upvalues: v55 (ref), v53 (copy), ActiveAssets (copy), Message (copy) ]]
	reconcileVirtualAssetEquipState()

	if v55 then
		local v1 = false

		v53(function() --[[ Line: 1903 | Upvalues: v55 (ref), ActiveAssets (ref), v1 (ref), Message (ref) ]]
			local v12 = v55
			local v2, v3 = Network.Invoke(ActiveAssets.REQUEST_UNEQUIP, v12)

			if v2 == false then
				if not v3 or v3 == "Asset is not available." then
					return
				end

				Message.Bottom({
					Time = 2,
					Message = v3,
					Color = Color3.fromRGB(255, 64, 64)
				})
			else
				v55 = nil

				if not (SelectedSlot and virtualAssetMatchesUID(SelectedSlot.Tool, v12)) then
					updateEquipSelectionVisuals()
					v1 = true

					return
				end

				SelectedSlot = nil
				updateEquipSelectionVisuals()
				v1 = true
			end
		end)

		return v1
	end

	return true
end
function addVirtualAssetOverlay(p1, p2, p3, p4, p5) --[[ addVirtualAssetOverlay | Line: 1928 | Upvalues: AssetGenerationUtil (copy), ItemDisplay (copy), AssetItemUtil (copy) ]]
	if not (p1:GetAttribute("IsInventorySlot") or p5) then
		return
	end

	if p1:GetAttribute("HasAssetOverlay") and not p5 then
		return
	end

	local v1 = if p3.Rarity then p3.Rarity.DisplayName or (p3.Rarity._id or p3.Rarity.Name) else "Unknown"
	local v2 = getAssetItemDisplayName(p2, p3)
	local v3 = if typeof(p2) == "table" then if typeof(p2.Category) == "string" and AssetDirectory[p2.Category] then AssetGenerationUtil.GetBaseRateMutationOnly(p2) else AssetGenerationUtil.ComputeBaseRateFromDropWeight(p3.DropWeight) else AssetGenerationUtil.ComputeBaseRateFromDropWeight(p3.DropWeight)
	local v4 = if typeof(p2) == "table" then if typeof(p2.Mutations) == "table" then ItemDisplay.GetMutationRichTextLine(p2.Mutations, p2.BaseMutation) else nil else nil
	local v5 = if typeof(p2) == "table" then if typeof(p2.Category) == "string" then if typeof(p2.Scale) == "number" then AssetItemUtil.GetVisualWeightKgDisplay(p2) else nil else nil else nil

	local function show() --[[ show | Line: 1955 | Upvalues: p1 (copy), v2 (copy), v1 (copy), v3 (copy), v5 (copy), v4 (copy) ]]
		if not p1:GetAttribute("IsInventorySlot") then
			return
		end

		local t = {
			{ "Title", v2 },
			{ "Div" },
			{ "Rarity", v1 },
			{ "Div" },
			{
				"Title",
				"$" .. SimpleNumber.FormatCompact(v3, ".#") .. "/s",
				nil,
				Color3.new(0/255, 255/255, 0/255)
			}
		}

		if v5 then
			table.insert(t, 2, { "Desc", v5 })
		end

		if v4 then
			table.insert(t, { "Div" })
			table.insert(t, { "Desc", v4 })
		end

		InfoOverlay.Add(p1, unpack(t))
	end

	if p4 then
		p4:Add(p1.MouseEnter:Connect(function() --[[ Line: 1980 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end))
		p4:Add(p1.SelectionGained:Connect(function() --[[ Line: 1985 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end))
	else
		p1.MouseEnter:Connect(function() --[[ Line: 1991 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end)
		p1.SelectionGained:Connect(function() --[[ Line: 1997 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end)
	end

	p1:SetAttribute("HasAssetOverlay", true)
end
function addVirtualEggOverlay(p1, p2, p3) --[[ addVirtualEggOverlay | Line: 2007 ]]
	if not p1:GetAttribute("IsInventorySlot") then
		return
	end

	if p1:GetAttribute("HasEggOverlay") then
		return
	end

	local v1 = getEggDisplayNameWithWeight(p2)
	local _, v2 = getEggConfigForRecord(p2)
	local v3 = if v2 then v2.Rarity else v2
	local v4 = if v2 == nil then false else v2.Egg.HideRarity == true
	local v5 = if v3 then v3.DisplayName or (v3._id or v3.Name) else "Egg"
	local v6 = if v3 then v3.Color else Color3.new(255/255, 255/255, 255/255)

	local function show() --[[ show | Line: 2023 | Upvalues: p1 (copy), v1 (copy), v4 (copy), v5 (copy), v6 (copy) ]]
		if not p1:GetAttribute("IsInventorySlot") then
			return
		end

		local t = {
			{ "Title", v1 }
		}

		if not v4 then
			table.insert(t, { "Div" })
			table.insert(t, { "Title", v5, nil, v6 })
		end

		InfoOverlay.Add(p1, unpack(t))
	end

	if p3 then
		p3:Add(p1.MouseEnter:Connect(function() --[[ Line: 2041 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end))
		p3:Add(p1.SelectionGained:Connect(function() --[[ Line: 2046 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end))
	else
		p1.MouseEnter:Connect(function() --[[ Line: 2052 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end)
		p1.SelectionGained:Connect(function() --[[ Line: 2058 | Upvalues: show (copy) ]]
			if Variables.DisableInfoOverlay then
				return
			end

			show()
		end)
	end

	p1:SetAttribute("HasEggOverlay", true)
end
function NewGui(p1, p2) --[[ NewGui | Line: 2068 ]]
	local v1 = Instance.new(p1)

	v1.Name = p2
	v1.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	v1.BackgroundTransparency = 1
	v1.BorderColor3 = Color3.new(0/255, 0/255, 0/255)
	v1.BorderSizePixel = 0
	v1.Size = UDim2.new(1, 0, 1, 0)

	if p1:match("Text") then
		v1.TextColor3 = Color3.new(255/255, 255/255, 255/255)
		v1.Text = ""
		v1.FontFace = script:GetAttribute("LabelFont")
		v1.TextSize = TextSizeAttribute
		v1.TextWrapped = true

		if p1 == "TextButton" then
			v1.FontFace = script:GetAttribute("SlotFont")
		end
	end

	return v1
end
function FindLowestEmpty(p1) --[[ FindLowestEmpty | Line: 2088 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and (not v1.IsFakeSlot and (not v1.Tool and canToolUseHotbarSlot(p1, i))) then
			return v1
		end
	end

	return nil
end
function FindEmptyInventorySlot() --[[ FindEmptyInventorySlot | Line: 2097 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = v51 + 1, #t7 do
		local v1 = t7[i]

		if v1 and not v1.Tool then
			return v1
		end
	end

	return nil
end
function cancelPendingBackpackRoundRestore() --[[ cancelPendingBackpackRoundRestore | Line: 2107 | Upvalues: v71 (ref) ]]
	if not v71 then
		return
	end

	task.cancel(v71)
	v71 = nil
end
function moveRestrictedHotbarToolsToInventory() --[[ moveRestrictedHotbarToolsToInventory | Line: 2114 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and (not v1.IsFakeSlot and (v1.Tool and not isToolLockedToCurrentHotbarSlot(v1))) then
			v1:MoveToInventory()
		end
	end
end
function isGearTool(p1) --[[ isGearTool | Line: 2123 ]]
	return if getAttribute(p1, "ItemType") == "Gear" then true else typeof(getAttribute(p1, "GearName")) == "string"
end
function isBatGearTool(p1) --[[ isBatGearTool | Line: 2127 ]]
	local v1 = getGearConfig(p1)

	return if v1 == nil then false else v1.BatControllerData ~= nil
end
function isTrapGearTool(p1) --[[ isTrapGearTool | Line: 2132 ]]
	return getGearName(p1) == "Trap"
end
function isBeeLauncherGearTool(p1) --[[ isBeeLauncherGearTool | Line: 2136 ]]
	return getGearName(p1) == "BeeLauncher"
end
function getLockedHotbarSlotForTool(p1) --[[ getLockedHotbarSlotForTool | Line: 2140 ]]
	if typeof(p1) ~= "Instance" or not (p1:IsA("Tool") and isGearTool(p1)) then
		return nil
	end

	if isBatGearTool(p1) then
		return 1
	end

	if isTrapGearTool(p1) then
		return 2
	end

	if isBeeLauncherGearTool(p1) then
		return 3
	end

	return nil
end
function canToolUseHotbarSlot(p1, p2) --[[ canToolUseHotbarSlot | Line: 2158 ]]
	if p2 == 1 then
		if typeof(p1) == "Instance" and p1:IsA("Tool") and isGearTool(p1) then
			return isBatGearTool(p1)
		end
		return true
	end

	if p2 == 2 then
		if typeof(p1) == "Instance" and p1:IsA("Tool") and isGearTool(p1) then
			return isTrapGearTool(p1)
		end
		return true
	end

	if p2 == 3 then
		if typeof(p1) == "Instance" and (p1:IsA("Tool") and (isGearTool(p1) and isBeeLauncherGearTool(p1))) then
			return true
		end

		return findGearSlot(isBeeLauncherGearTool) == nil
	end

	local v4 = getLockedHotbarSlotForTool(p1)

	return if v4 == nil then true else v4 == p2
end
function isToolLockedToCurrentHotbarSlot(p1) --[[ isToolLockedToCurrentHotbarSlot | Line: 2177 ]]
	if not p1 or (p1.IsFakeSlot or not p1.Tool) then
		return false
	end

	local v1 = getLockedHotbarSlotForTool(p1.Tool)

	return if v1 == nil then false else v1 == p1.Index
end
function findGearSlot(p1) --[[ findGearSlot | Line: 2186 | Upvalues: t7 (copy) ]]
	for k, v in pairs(t7) do
		if v and (not v.IsFakeSlot and (v.Tool and (isGearTool(v.Tool) and p1(v.Tool)))) then
			return v
		end
	end

	return nil
end
function moveGameplayGearToHotbarSlot(p1, p2) --[[ moveGameplayGearToHotbarSlot | Line: 2196 | Upvalues: t7 (copy), v51 (copy) ]]
	local v1 = findGearSlot(p1)

	if not v1 then
		return false
	end

	local v2 = t7[p2]

	if not v2 or v2.IsFakeSlot then
		return false
	end

	if v1 == v2 then
		return false
	end

	if v2.Tool and getLockedHotbarSlotForTool(v2.Tool) == p2 then
		return false
	end

	v1:Swap(v2)

	if not (v51 < v1.Index) or v1.Tool then
		return true
	end

	v1:Delete()

	return true
end
function moveInvalidLockedHotbarSlotToolToInventory(p1) --[[ moveInvalidLockedHotbarSlotToolToInventory | Line: 2222 | Upvalues: t7 (copy) ]]
	local v1 = t7[p1]

	if not v1 or (v1.IsFakeSlot or not v1.Tool) then
		return false
	end

	if canToolUseHotbarSlot(v1.Tool, p1) then
		return false
	end

	v1:MoveToInventory()

	return true
end
function ensureGameplayGearHotbarSlots() --[[ ensureGameplayGearHotbarSlots | Line: 2235 | Upvalues: v3 (ref) ]]
	local v1 = moveGameplayGearToHotbarSlot(isBatGearTool, 1) and true or false

	if moveGameplayGearToHotbarSlot(isTrapGearTool, 2) then
		v1 = true
	end

	if moveGameplayGearToHotbarSlot(isBeeLauncherGearTool, 3) then
		v1 = true
	end

	if moveInvalidLockedHotbarSlotToolToInventory(1) then
		v1 = true
	end

	if moveInvalidLockedHotbarSlotToolToInventory(2) then
		v1 = true
	end

	if moveInvalidLockedHotbarSlotToolToInventory(3) then
		v1 = true
	end

	if not v1 then
		return
	end

	AdjustHotbarFrames()
	UpdateInventorySlots()

	if not v3 then
		return
	end

	v3(true)
end
function isToolInCharacterOrBackpack(p1) --[[ isToolInCharacterOrBackpack | Line: 2266 | Upvalues: v40 (ref), Backpack (ref) ]]
	if typeof(p1) ~= "Instance" or not p1:IsA("Tool") then
		return false
	end

	local v1 = p1.Parent

	return if v1 == v40 then true else v1 == Backpack
end
function _isInventoryEmpty() --[[ _isInventoryEmpty | Line: 2275 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = v51 + 1, #t7 do
		local v1 = t7[i]

		if v1 and v1.Tool then
			return false
		end
	end

	return true
end
function _UseGazeSelection() --[[ _UseGazeSelection | Line: 2284 ]]
	return UserInputService.VREnabled
end
function AdjustHotbarFrames() --[[ AdjustHotbarFrames | Line: 2287 | Upvalues: v51 (copy), t7 (copy), v25 (ref), v43 (ref) ]]
	debug.profilebegin("BackpackController :: AdjustHotbarFrames")

	for i = 1, v51 do
		local v1 = t7[i]

		if v1 then
			v1:SetNumberText(nil)
		end
	end

	local Visible = v25.Visible
	local list = {}

	for j = 1, v51 do
		local v2 = t7[j]

		if if v2 then v2.IsFakeSlot or (v2.Tool or Visible) else v2 then
			table.insert(list, {
				Kind = "Slot",
				Slot = v2
			})
		end
	end

	local v4 = math.max(1, #list)

	v43 = v4

	local count = 0

	for k = 1, v51 do
		local v5 = t7[k]

		if v5 then
			v5.Frame.Visible = false
		end
	end

	for i, v in ipairs(list) do
		count = count + 1

		local Slot = v.Slot

		if Slot then
			Slot.Frame.LayoutOrder = count
			Slot:Readjust(count, v4)
			Slot.Frame.Visible = true
		end
	end

	debug.profileend()
end
function UpdateScrollingFrameCanvasSize() --[[ UpdateScrollingFrameCanvasSize | Line: 2333 | Upvalues: v30 (ref) ]]
	debug.profilebegin("BackpackController :: UpdateScrollingFrameCanvasSize")

	if not v30 then
		debug.profileend()

		return
	end

	v30()
	debug.profileend()
end
function UpdateInventorySlots() --[[ UpdateInventorySlots | Line: 2342 | Upvalues: v48 (ref), v3 (ref), v51 (copy), t7 (copy) ]]
	debug.profilebegin("BackpackController :: UpdateInventorySlots")

	if v48 then
		if not v3 then
			return
		end

		v3()
	else
		local list = {}
		local list2 = {}
		local list3 = {}
		local list4 = {}
		local list5 = {}

		for i = v51 + 1, #t7 do
			local v1 = t7[i]
			local Tool = v1.Tool

			if Tool then
				if IsOfCategory(Tool) then
					local v2 = getAttribute(Tool, "ItemType")

					if v2 == "Asset" then
						table.insert(list4, v1)
					elseif v2 == "AssetEgg" then
						table.insert(list3, v1)
					elseif v2 == "Sword" then
						table.insert(list2, v1)
					else
						table.insert(list, v1)
					end

					v1.Frame.Visible = true

					continue
				end

				v1.Frame.Visible = false

				continue
			end

			table.insert(list5, v1)
			v1.Frame.Visible = false
		end

		table.sort(list4, function(p1, p2) --[[ Line: 2380 ]]
			local Tool = p1.Tool
			local Tool2 = p2.Tool
			local v1 = if Tool then isToolFavorite(Tool) else Tool

			if v1 ~= (if Tool2 then isToolFavorite(Tool2) else Tool2) then
				return v1
			end

			local v3 = Tool and getAssetRarityNumber(Tool) or (1 / 0)
			local v4 = Tool2 and getAssetRarityNumber(Tool2) or (1 / 0)

			if v3 == v4 then
				local v5 = Tool and getAssetEarningRate(Tool) or 0
				local v6 = Tool2 and getAssetEarningRate(Tool2) or 0

				if v5 == v6 then
					local v7 = Tool and getAssetOddsDenominator(Tool) or 0
					local v8 = Tool2 and getAssetOddsDenominator(Tool2) or 0

					if v7 == v8 then
						local v9 = Tool and getAssetDropWeight(Tool) or (1 / 0)
						local v10 = Tool2 and getAssetDropWeight(Tool2) or (1 / 0)

						if v9 == v10 then
							local v11 = Tool and getAttribute(Tool, "Weight") or 0
							local v12 = Tool2 and getAttribute(Tool2, "Weight") or 0

							if v11 == v12 then
								local v13 = Tool and getAttribute(Tool, "UID") or ""

								return v13 < (Tool2 and getAttribute(Tool2, "UID") or "")
							end

							return v12 < v11
						end

						return v9 < v10
					end

					return v8 < v7
				end

				return v6 < v5
			end

			return v4 < v3
		end)
		table.sort(list3, function(p1, p2) --[[ Line: 2428 ]]
			local Tool = p1.Tool
			local Tool2 = p2.Tool
			local v1 = Tool and getEggRarityNumber(Tool) or (1 / 0)
			local v2 = Tool2 and getEggRarityNumber(Tool2) or (1 / 0)

			if v1 == v2 then
				local v3 = Tool and getEggBaseEarningRate(Tool) or 0
				local v4 = Tool2 and getEggBaseEarningRate(Tool2) or 0

				if v3 == v4 then
					local v5 = Tool and getAttribute(Tool, "UID") or ""

					return v5 < (Tool2 and getAttribute(Tool2, "UID") or "")
				end

				return v4 < v3
			end

			return v2 < v1
		end)
		table.sort(list2, function(p1, p2) --[[ Line: 2449 ]]
			return (getAttribute(p1.Tool, "MoneyCost") or 0) > (getAttribute(p2.Tool, "MoneyCost") or 0)
		end)

		local count = v51

		for i, v in ipairs(list4) do
			count = count + 1
			v.Frame.LayoutOrder = count
		end

		for i, v in ipairs(list3) do
			local v32

			count = count + 1

			local v4 = if v.Tool then getEggAssetConfig(v.Tool) else nil

			v32 = if v4 and v4.Egg.HideRarity then -2147483648 else count
			v.Frame.LayoutOrder = v32
		end

		for i, v in ipairs(list2) do
			count = count + 1
			v.Frame.LayoutOrder = count
		end

		for i, v in ipairs(list) do
			count = count + 1
			v.Frame.LayoutOrder = count
		end

		for i, v in ipairs(list5) do
			count = count + 1
			v.Frame.LayoutOrder = count
		end

		UpdateScrollingFrameCanvasSize()
		debug.profileend()
	end
end
function ResizeContainers() --[[ ResizeContainers | Line: 2481 | Upvalues: v24 (ref), v51 (copy), v11 (ref), v23 (ref), v52 (copy), VREnabled (copy) ]]
	v24.Size = UDim2.new(0, 5 + v51 * (v11 + 5), 0, v11 + 5 + 5)
	v24.Position = UDim2.new(0.5, -v24.Size.X.Offset / 2, 1, -v24.Size.Y.Offset)
	v23.Size = UDim2.new(0, v24.Size.X.Offset, 0, v24.Size.Y.Offset * v52 + 40 + (if VREnabled then 80 else 0))
	v23.Position = UDim2.new(0.5, -v23.Size.X.Offset / 2, 1, v24.Position.Y.Offset - v23.Size.Y.Offset)
	AdjustHotbarFrames()
	UpdateInventorySlots()
end
function _Clamp(p1, p2, p3) --[[ _Clamp | Line: 2499 ]]
	return math.min(p2, (math.max(p1, p3)))
end
function CheckBounds(p1, p2, p3) --[[ CheckBounds | Line: 2502 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local AbsoluteSize = p1.AbsoluteSize

	return if AbsolutePosition.X < p2 and (p2 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p3) then p3 <= AbsolutePosition.Y + AbsoluteSize.Y else false
end
function GetOffset(p1, p2) --[[ GetOffset | Line: 2517 ]]
	return (p1.AbsolutePosition + p1.AbsoluteSize / 2 - p2).magnitude
end
function UnequipAllTools(p1, p2) --[[ Line: 2521 | Upvalues: Humanoid (ref) ]]
	requestUnequipVirtualAsset()
	requestUnequipVirtualEgg()

	if not Humanoid then
		return
	end

	Humanoid:UnequipTools()
end
function _EquipNewTool(p1) --[[ _EquipNewTool | Line: 2528 | Upvalues: Humanoid (ref), v40 (ref) ]]
	if not BackpackEnabled or (not BackpackGui.Enabled or Variables.Locks.HideUI:IsLocked()) then
		return
	end

	if not Humanoid then
		p1.Parent = v40

		return
	end

	UnequipAllTools()
	p1.Parent = v40
end
function _ToggleFavoriteTool(p1) --[[ _ToggleFavoriteTool | Line: 2538 ]]
	local Tool = p1.Tool

	if Tool then
		requestFavoriteToggle(Tool)
	end
end
function _IsEquipped(p1) --[[ _IsEquipped | Line: 2547 | Upvalues: v40 (ref) ]]
	return if p1 then p1.Parent == v40 else p1
end
function MakeSlot(p1, p2) --[[ MakeSlot | Line: 2551 | Upvalues: t7 (copy), v28 (ref), v51 (copy), Trove (copy), v25 (ref), v8 (copy), RunService (copy), v24 (ref), v11 (ref), AssetIconShape (copy), v43 (ref), v45 (ref), v18 (ref), t8 (copy), v42 (ref), v48 (ref), v55 (ref), v58 (ref), v40 (ref), t10 (copy), v41 (copy), v2 (ref), v13 (ref), t3 (copy), Humanoid (ref), Backpack (ref), v21 (copy), v15 (ref), t9 (copy), Zero (copy), LocalPlayer (ref), v6 (ref), v5 (copy), v7 (ref), v1 (ref), v3 (ref) ]]
	local v12 = p2 or #t7 + 1
	local t = {
		Tool = nil,
		Frame = nil,
		IsFakeSlot = false,
		FakeType = nil,
		IsDeleted = false,
		Index = v12
	}
	local v22 = if p1 == v28 or v51 < v12 then true else false
	local v4 = nil
	local v52 = nil
	local v62 = nil
	local v72 = nil
	local v82 = nil
	local v9 = nil
	local v10 = nil
	local v112 = nil
	local v122 = nil
	local t2 = {}
	local v132 = nil
	local v14 = nil
	local v152 = nil
	local v16 = nil
	local v17 = nil
	local v182 = nil
	local v19 = nil
	local v20 = nil
	local v212 = nil
	local v23 = (if v22 then script.InventoryTemplate else script.HotbarTemplate):Clone()

	v23.Name = v12
	v23.ZIndex = 20

	local Icon = v23.Icon
	local v242 = NewGui("Frame", "CooldownOverlay")

	v242.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	v242.BackgroundTransparency = 0.35
	v242.BorderSizePixel = 0
	v242.Size = UDim2.fromScale(1, 1)
	v242.Visible = false
	v242.ZIndex = 20
	v242.Parent = v23

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = script:GetAttribute("CornerRadius")
	UICorner.Parent = v242

	local v252 = NewGui("TextLabel", "CooldownLabel")

	v252.BackgroundTransparency = 1
	v252.Size = UDim2.new(1, -4, 1, -4)
	v252.Position = UDim2.fromOffset(2, 2)
	v252.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
	v252.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	v252.TextStrokeColor3 = Color3.new(0/255, 0/255, 0/255)
	v252.TextStrokeTransparency = 0.4
	v252.TextScaled = true
	v252.TextXAlignment = Enum.TextXAlignment.Center
	v252.TextYAlignment = Enum.TextYAlignment.Center
	v252.Visible = false
	v252.ZIndex = v242.ZIndex + 1
	v252.Text = ""
	v252.Parent = v242

	local v26 = Trove.new()

	local function restoreAssetIconHover(p1) --[[ restoreAssetIconHover | Line: 2622 ]] end

	local function clearSlotOverlays() --[[ clearSlotOverlays | Line: 2624 | Upvalues: v26 (copy), v82 (ref), v9 (ref), v23 (ref) ]]
		v26:Clean()
		clearMutationIconFrame(v82, v9)

		if not v23 then
			return
		end

		v23:SetAttribute("HasAssetOverlay", nil)
		v23:SetAttribute("HasEggOverlay", nil)
		v23:SetAttribute("HasSwordOverlay", nil)
	end

	local function isDragRestrictedItemType(p1) --[[ isDragRestrictedItemType | Line: 2634 ]]
		return false
	end

	local function canPlaceToolInSlot(p1, p2) --[[ canPlaceToolInSlot | Line: 2638 | Upvalues: v51 (ref) ]]
		if p1.IsFakeSlot then
			return false
		end

		if not p2 then
			return true
		end

		if v51 < p1.Index then
			return true
		end

		if not canToolUseHotbarSlot(p2, p1.Index) then
			return false
		end

		if typeof(p2) == "table" and (p2.IsVirtualAsset or p2.IsVirtualEgg) then
			return getHotbarFillTool(p2) ~= nil
		end

		getAttribute(p2, "ItemType")

		return true
	end

	local function shouldAllowSlotDragging(p1) --[[ shouldAllowSlotDragging | Line: 2664 | Upvalues: t (copy), canPlaceToolInSlot (copy), v51 (ref), v25 (ref) ]]
		local v1 = if p1 then p1 else t.Tool

		if not v1 then
			return false
		end

		if typeof(v1) ~= "Instance" and (typeof(v1) ~= "table" or not (v1.IsVirtualAsset or v1.IsVirtualEgg)) then
			return false
		end

		getAttribute(v1, "ItemType")

		if not canPlaceToolInSlot(t, v1) then
			return false
		end

		if UserInputService.VREnabled then
			return false
		end

		return not (t.Index <= v51) or v25.Visible
	end

	local function applySlotDraggableState(p1) --[[ applySlotDraggableState | Line: 2692 | Upvalues: v8 (ref), v23 (ref) ]]
		if v8 then
			v23:SetAttribute("Draggable", p1)
		else
			v23.Draggable = p1
		end
	end

	local function stopCooldownHeartbeat() --[[ stopCooldownHeartbeat | Line: 2700 | Upvalues: v132 (ref) ]]
		if not v132 then
			return
		end

		v132:Disconnect()
		v132 = nil
	end

	local function disconnectCooldownConnections() --[[ disconnectCooldownConnections | Line: 2707 | Upvalues: t2 (ref) ]]
		for i, v in ipairs(t2) do
			v:Disconnect()
		end

		t2 = {}
	end

	local function hideCooldownOverlay() --[[ hideCooldownOverlay | Line: 2714 | Upvalues: v132 (ref), v242 (ref), v252 (ref) ]]
		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if not v252 then
			return
		end

		v252.Visible = false
		v252.Text = ""
	end

	local function updateCooldownDisplay() --[[ updateCooldownDisplay | Line: 2725 | Upvalues: t (copy), v132 (ref), v242 (ref), v252 (ref) ]]
		local Tool = t.Tool

		if Tool then
			local v1 = Tool:GetAttribute("CooldownEndTime")

			if typeof(v1) == "number" and not (v1 <= 0) then
				if Tool:GetAttribute("CooldownActive") then
					local v2 = v1 - workspace:GetServerTimeNow()

					if v2 <= 1 then
						if v132 then
							v132:Disconnect()
							v132 = nil
						end

						if v242 then
							v242.Visible = false
						end

						if not v252 then
							return false
						end

						v252.Visible = false
						v252.Text = ""

						return false
					end

					if v242 then
						v242.Visible = true
					end

					if not v252 then
						return true
					end

					v252.Visible = true
					v252.Text = tostring((math.max(math.ceil(v2), 0)))

					return true
				end

				if v132 then
					v132:Disconnect()
					v132 = nil
				end

				if v242 then
					v242.Visible = false
				end

				if not v252 then
					return false
				end

				v252.Visible = false
				v252.Text = ""

				return false
			end

			if v132 then
				v132:Disconnect()
				v132 = nil
			end

			if v242 then
				v242.Visible = false
			end

			if not v252 then
				return false
			end

			v252.Visible = false
			v252.Text = ""

			return false
		end

		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if not v252 then
			return false
		end

		v252.Visible = false
		v252.Text = ""

		return false
	end

	local function ensureCooldownHeartbeat(p1) --[[ ensureCooldownHeartbeat | Line: 2762 | Upvalues: v132 (ref), RunService (ref), t (copy), v242 (ref), v252 (ref), updateCooldownDisplay (copy) ]]
		if not v132 then
			v132 = RunService.Heartbeat:Connect(function() --[[ Line: 2767 | Upvalues: t (ref), p1 (copy), v132 (ref), v242 (ref), v252 (ref), updateCooldownDisplay (ref) ]]
				if t.Tool == p1 then
					if updateCooldownDisplay() or not v132 then
						return
					end
				else
					if v132 then
						v132:Disconnect()
						v132 = nil
					end

					if v242 then
						v242.Visible = false
					end

					if v252 then
						v252.Visible = false
						v252.Text = ""
					end

					if not v132 then
						return
					end
				end

				v132:Disconnect()
				v132 = nil
			end)
		end
	end

	local function connectCooldownListeners(p1) --[[ connectCooldownListeners | Line: 2780 | Upvalues: disconnectCooldownConnections (copy), v132 (ref), v242 (ref), v252 (ref), updateCooldownDisplay (copy), RunService (ref), t (copy), t2 (ref) ]]
		disconnectCooldownConnections()

		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if v252 then
			v252.Visible = false
			v252.Text = ""
		end

		if not p1 then
			return
		end

		local function onAttributeChanged() --[[ onAttributeChanged | Line: 2788 | Upvalues: updateCooldownDisplay (ref), p1 (copy), v132 (ref), RunService (ref), t (ref), v242 (ref), v252 (ref) ]]
			if updateCooldownDisplay() then
				local v1 = p1

				if not v132 then
					v132 = RunService.Heartbeat:Connect(function() --[[ Line: 2767 | Upvalues: t (ref), v1 (copy), v132 (ref), v242 (ref), v252 (ref), updateCooldownDisplay (ref) ]]
						if t.Tool == v1 then
							if updateCooldownDisplay() or not v132 then
								return
							end
						else
							if v132 then
								v132:Disconnect()
								v132 = nil
							end

							if v242 then
								v242.Visible = false
							end

							if v252 then
								v252.Visible = false
								v252.Text = ""
							end

							if not v132 then
								return
							end
						end

						v132:Disconnect()
						v132 = nil
					end)
				end
			else
				if not v132 then
					return
				end

				v132:Disconnect()
				v132 = nil
			end
		end

		table.insert(t2, p1:GetAttributeChangedSignal("CooldownEndTime"):Connect(onAttributeChanged))
		table.insert(t2, p1:GetAttributeChangedSignal("CooldownActive"):Connect(onAttributeChanged))
		table.insert(t2, p1:GetAttributeChangedSignal("CooldownDuration"):Connect(onAttributeChanged))

		if updateCooldownDisplay() then
			if not v132 then
				v132 = RunService.Heartbeat:Connect(function() --[[ Line: 2767 | Upvalues: t (ref), p1 (copy), v132 (ref), v242 (ref), v252 (ref), updateCooldownDisplay (ref) ]]
					if t.Tool == p1 then
						if updateCooldownDisplay() or not v132 then
							return
						end
					else
						if v132 then
							v132:Disconnect()
							v132 = nil
						end

						if v242 then
							v242.Visible = false
						end

						if v252 then
							v252.Visible = false
							v252.Text = ""
						end

						if not v132 then
							return
						end
					end

					v132:Disconnect()
					v132 = nil
				end)
			end
		else
			if not v132 then
				return
			end

			v132:Disconnect()
			v132 = nil
		end
	end

	function t.updateDragAppearance(p1) --[[ updateDragAppearance | Line: 2813 | Upvalues: t (copy), v23 (ref), v22 (copy), v8 (ref) ]]
		if t.IsFakeSlot then
			v23.BackgroundTransparency = SlotLockedTransparencyAttribute
			v23.BackgroundColor3 = BackgroundColorAttribute

			return
		end

		v23.SelectionImageObject = nil

		local v1 = p1.Tool and getAttribute(p1.Tool, "ItemType")

		if v22 then
			v23.BackgroundTransparency = 0.5
			v23.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
		else
			local v4 = v8 and v23:GetAttribute("Draggable") or v23.Draggable

			v23.BackgroundTransparency = SlotLockedTransparencyAttribute
			v23.BackgroundColor3 = v4 and DraggableColorAttribute or BackgroundColorAttribute
		end
	end
	function t.Readjust(p1, p2, p3) --[[ Readjust | Line: 2835 | Upvalues: v24 (ref), v11 (ref), v23 (ref) ]]
		v23.Position = UDim2.new(0, v24.Size.X.Offset / 2 - v11 / 2 + (v11 + 5) * (p2 - (p3 / 2 + 0.5)), 0, 5)
	end
	function t.SetNumberText(p1, p2) --[[ SetNumberText | Line: 2841 | Upvalues: v17 (ref), v19 (ref) ]]
		if not v17 then
			return
		end

		v17.Text = if p2 then p2 else v19 or ""
	end
	function t.Fill(p1, p2) --[[ Fill | Line: 2846 | Upvalues: canPlaceToolInSlot (copy), clearSlotOverlays (copy), v112 (ref), v122 (ref), disconnectCooldownConnections (copy), v132 (ref), v242 (ref), v252 (ref), v51 (ref), AssetIconShape (ref), Icon (ref), v62 (ref), v20 (ref), v212 (ref), v52 (ref), v82 (ref), v9 (ref), v72 (ref), v22 (copy), v152 (ref), v16 (ref), t (copy), v10 (ref), connectCooldownListeners (copy), shouldAllowSlotDragging (copy), v8 (ref), v23 (ref), v43 (ref), v45 (ref), v18 (ref), t8 (ref), v26 (copy), v42 (ref), v25 (ref), v48 (ref) ]]
		if p1.IsFakeSlot and p1.FakeType ~= "SwordEquip" then
			return
		end

		if p2 and not canPlaceToolInSlot(p1, p2) then
			return
		end

		clearSlotOverlays()

		if v112 then
			v112:Disconnect()
			v112 = nil
		end

		if v122 then
			v122:Disconnect()
			v122 = nil
		end

		disconnectCooldownConnections()

		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if v252 then
			v252.Visible = false
			v252.Text = ""
		end

		if not p2 then
			return p1:Clear()
		end

		if p1.Tool and p1.Tool ~= p2 then
			p1:Clear()
		end

		local v1 = if typeof(p2) == "Instance" then true else false
		local v2 = getAttribute(p2, "ItemType")
		local v3 = getRegisteredBackpackSlot(p2)

		if v3 and (v3 ~= p1 and registeredSlotContainsTool(v3, p2)) then
			v3:Clear()

			if v51 < v3.Index then
				v3:Delete()
			end
		end

		p1.Tool = p2
		registerVirtualBackpackSlot(p1, p2)
		p1:UpdateFavoriteVisual()

		if v1 then
			v112 = p2:GetAttributeChangedSignal("Favorite"):Connect(function() --[[ Line: 2886 | Upvalues: p1 (copy), p2 (copy) ]]
				p1:UpdateFavoriteVisual()

				if not isAssetTool(p2) then
					return
				end

				UpdateInventorySlots()
			end)
		end

		function t.UpdateVisuals() --[[ UpdateVisuals | Line: 2893 | Upvalues: p2 (copy), AssetIconShape (ref), Icon (ref), v62 (ref), v20 (ref), v212 (ref), v52 (ref), v82 (ref), v9 (ref), v72 (ref), v2 (copy), v22 (ref), v152 (ref), v16 (ref), p1 (copy), v51 (ref) ]]
			local TextureId = p2.TextureId

			AssetIconShape.Clear(Icon)
			Icon.Image = TextureId
			Icon.ScaleType = Enum.ScaleType.Fit
			v62.TextXAlignment = v20
			v62.TextYAlignment = v212
			v52.Visible = false
			clearMutationIconFrame(v82, v9)

			for i, v in ipairs(v52:GetChildren()) do
				if v:IsA("UIGradient") then
					v:Destroy()
				end
			end

			for i, v in ipairs(v62:GetChildren()) do
				if v:IsA("UIGradient") then
					v:Destroy()
				end
			end

			for i, v in ipairs(v72:GetChildren()) do
				if v:IsA("UIGradient") then
					v:Destroy()
				end
			end

			local v1 = string.match(p2.Name, "%[X(%d+)%]")
			local v23 = p2.Name
			local v3 = true
			local v4 = ""
			local v5 = false
			local v6

			if v2 == "Asset" then
				local v7 = getAttribute(p2, "Category")
				local v8 = if v7 then AssetDirectory[v7] else v7

				if v8 then
					local v92 = getAssetItemData(p2)

					if v92 then
						AssetIconShape.Apply(Icon, v92)
					else
						Icon.Image = v8.Icon or TextureId
					end

					Icon.ImageColor3 = Color3.new(255/255, 255/255, 255/255)

					if v8.Rarity and v8.Rarity.Gradient then
						v8.Rarity.Gradient:Clone().Parent = v62

						if v22 then
							v8.Rarity.Gradient:Clone().Parent = v52
						end
					end
				end

				v52.Visible = v22

				local v11 = getAssetItemData(p2)
				local v12

				if v11 then
					local v13 = getAssetItemDisplayNameWithVisualWeight

					v12 = v13(v11, if v8 then v8 else BaseAssetConfig)
				else
					v12 = getAttribute(p2, "DisplayName") or p2.Name
				end

				local v15 = parseMutations(getAttribute(p2, "Mutations"))
				local v162 = getAttribute(p2, "BaseMutation")

				v3 = true

				if v22 or typeof(p2) == "table" and p2.IsVirtualAsset then
					populateMutationIconFrame(v82, v9, v162, v15)
					v4 = ""
					v5 = false

					if v22 then
						v23 = v12
					else
						v23 = v12
						v3 = false
					end
				else
					v23 = ""
				end

				v6 = v23
			elseif v2 == "AssetEgg" then
				local v18 = getEggRecordFromTool(p2)
				local v19, v202 = getEggConfigForRecord(v18)

				if v19 and v202 then
					Icon.Image = v19.Icon ~= "" and v19.Icon or TextureId
					Icon.ImageColor3 = Color3.new(255/255, 255/255, 255/255)

					if not v19.HideRarity and (v202.Rarity and v202.Rarity.Gradient) then
						v202.Rarity.Gradient:Clone().Parent = v62

						if v22 then
							v202.Rarity.Gradient:Clone().Parent = v52
						end
					end
				end

				v52.Visible = v22
				v23 = if v18 then getEggDisplayNameWithWeight(v18) else getAttribute(p2, "DisplayName") or p2.Name
				v6 = v23
				v3 = true
				v4 = ""
				v5 = false
			elseif v2 == "Gear" then
				local v26 = getGearConfig(p2)

				Icon.Image = if TextureId and (TextureId ~= "" and TextureId) then TextureId else v26 and v26.Icon or ""
				Icon.ImageColor3 = Color3.new(255/255, 255/255, 255/255)
				v52.Visible = false
				v23 = ""
				v6 = if shouldDisplayGearUses(p2) then getGearUsesText(p2) else ""
				v3 = if v6 == "" then false else true

				if v3 then
					v62.TextXAlignment = Enum.TextXAlignment.Center
					v62.TextYAlignment = Enum.TextYAlignment.Center
				end

				v4 = ""
				v5 = false
			elseif TextureId == "" then
				v6 = v23
				v5 = false
			else
				v5 = false

				if v1 then
					v6 = ""
					v23 = ""
				else
					v6 = v23
					v3 = false
				end
			end

			if not v22 then
				if v2 ~= "Gear" or not shouldDisplayGearUses(p2) then
					v6 = ""
					v23 = ""
					v3 = false
				end

				v4 = ""
				v5 = false
			end

			v62.Text = v6 or v23
			v62.Visible = v3
			v72.Text = v4
			v72.Visible = v5

			if v152 then
				v152.Visible = true
			end

			if not (v16 and p2:IsA("Tool")) then
				return
			end

			if if p1.Index <= v51 then if v2 == "Asset" or (v2 == "Pet" or v2 == "AssetEgg") then true else v2 == "Gear" else false then
				v16.Text = ""
				v16.Visible = false

				return
			end

			local ToolTip = p2.ToolTip

			if ToolTip == "" then
				ToolTip = p2.Name
			end

			v16.Text = ToolTip
		end
		t.UpdateVisuals()

		if v10 then
			v10:Disconnect()
			v10 = nil
		end

		if v1 then
			v10 = p2.Changed:Connect(function(p1) --[[ Line: 3065 | Upvalues: t (ref) ]]
				if p1 ~= "TextureId" and (p1 ~= "Name" and p1 ~= "ToolTip") then
					return
				end

				t.UpdateVisuals()
			end)
		end

		if v1 and v2 == "Asset" then
			v122 = p2:GetAttributeChangedSignal("Weight"):Connect(function() --[[ Line: 3072 ]]
				UpdateInventorySlots()
			end)
		elseif v1 and v2 == "Gear" then
			v122 = p2:GetAttributeChangedSignal("Uses"):Connect(function() --[[ Line: 3076 | Upvalues: t (ref) ]]
				t.UpdateVisuals()
			end)
			connectCooldownListeners(p2)
		end

		local v4 = if p1.Index <= v51 then true else false
		local v5 = shouldAllowSlotDragging(p2)

		if v8 then
			v23:SetAttribute("Draggable", v5)
		else
			v23.Draggable = v5
		end

		p1:UpdateEquipView()

		if v4 and not p1.IsFakeSlot then
			v43 = v43 + 1

			if v45 and (v43 >= 1 and not v18) then
				v18 = true
				ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			end
		end

		if typeof(p2) == "Instance" then
			t8[p2] = p1
		end

		if v2 == "Asset" then
			local v6 = AssetDirectory[getAttribute(p2, "Category")] or BaseAssetConfig

			addVirtualAssetOverlay(v23, getAssetItemData(p2) or {}, v6, v26)
		elseif v2 == "AssetEgg" then
			local v83 = getEggRecordFromTool(p2)

			if v83 then
				addVirtualEggOverlay(v23, v83, v26)
			end
		end

		v42 = FindLowestEmpty()

		if not v22 or (not v25.Visible or v48) then
			return
		end

		v23.Visible = IsOfCategory(p2)
	end
	function t.Clear(p1) --[[ Clear | Line: 3120 | Upvalues: clearSlotOverlays (copy), v10 (ref), v112 (ref), v122 (ref), disconnectCooldownConnections (copy), v132 (ref), v242 (ref), v252 (ref), v52 (ref), AssetIconShape (ref), Icon (ref), v62 (ref), v72 (ref), v16 (ref), v8 (ref), v23 (ref), v182 (ref), v51 (ref), v43 (ref), v18 (ref), v42 (ref) ]]
		if not p1.Tool then
			return
		end

		if p1.IsFakeSlot then
			return
		end

		clearSlotOverlays()

		if v10 then
			v10:Disconnect()
			v10 = nil
		end

		if v112 then
			v112:Disconnect()
			v112 = nil
		end

		if v122 then
			v122:Disconnect()
			v122 = nil
		end

		disconnectCooldownConnections()

		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if v252 then
			v252.Visible = false
			v252.Text = ""
		end

		for i, v in ipairs(v52:GetChildren()) do
			if v:IsA("UIGradient") then
				v:Destroy()
			end
		end

		v52.Visible = false
		AssetIconShape.Clear(Icon)
		Icon.Image = ""
		v62.Text = ""
		v62.Visible = true
		v72.Text = ""
		v72.Visible = false

		if v16 then
			v16.Text = ""
			v16.Visible = false
		end

		if v8 then
			v23:SetAttribute("Draggable", false)
		else
			v23.Draggable = false
		end

		v182.Visible = false
		p1:UpdateEquipView(true)

		if p1.Index <= v51 and not p1.IsFakeSlot then
			v43 = v43 - 1

			if v43 < 1 then
				v18 = false
				ContextActionService:UnbindAction("RBXHotbarEquip")
			end
		end

		unregisterBackpackSlotTool(p1, p1.Tool)
		p1.Tool = nil
		v42 = FindLowestEmpty()
	end
	function t.UpdateEquipView(p1, p2) --[[ UpdateEquipView | Line: 3177 | Upvalues: v55 (ref), v58 (ref), v40 (ref), v14 (ref), v23 (ref) ]]
		if p1.IsFakeSlot then
			return
		end

		local v1 = false
		local v2 = getAttribute(p1.Tool, "ItemType")

		if v2 == "Asset" and (typeof(p1.Tool) == "table" and p1.Tool.IsVirtualAsset) then
			v1 = not p2 and virtualAssetMatchesUID(p1.Tool, v55)
		else
			local v3, v4, v5, v6

			if v2 == "AssetEgg" then
				v3 = p1.Tool

				if typeof(v3) == "table" and p1.Tool.IsVirtualEgg then
					v4 = not p2

					if v4 then
						v5 = v58
						v4 = if typeof(v58) == "string" then p1.Tool.UID == v58 else false
					end

					v1 = v4
				elseif not p2 then
					v6 = p1.Tool

					if v6 and (typeof(v6) == "Instance" and v6.Parent == v40) then
						v1 = true
					end
				end
			elseif not p2 then
				v6 = p1.Tool

				if v6 and (typeof(v6) == "Instance" and v6.Parent == v40) then
					v1 = true
				end
			end
		end

		if v1 then
			if not v14 then
				v14 = NewGui("Frame", "Equipped")
				v14.ZIndex = 3
				v14.Size = UDim2.fromScale(1, 1)
				v14.AnchorPoint = Vector2.new(0.5, 0.5)
				v14.Position = UDim2.fromScale(0.5, 0.5)

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = script:GetAttribute("CornerRadius")
				UICorner.Parent = v14

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = EquippedColorAttribute
				UIStroke.Thickness = 3.8
				UIStroke.Parent = v14
			end

			v14.Parent = v23
		else
			if not v14 then
				return
			end

			v14.Parent = nil
		end
	end
	function t.Delete(p1) --[[ Delete | Line: 3215 | Upvalues: clearSlotOverlays (copy), disconnectCooldownConnections (copy), v132 (ref), v242 (ref), v252 (ref), t10 (ref), v23 (ref), v41 (ref), v2 (ref), t7 (ref) ]]
		if p1.IsFakeSlot or p1.IsDeleted then
			return
		end

		p1.IsDeleted = true

		if p1.Tool then
			p1:Clear()
		end

		clearSlotOverlays()
		disconnectCooldownConnections()

		if v132 then
			v132:Disconnect()
			v132 = nil
		end

		if v242 then
			v242.Visible = false
		end

		if v252 then
			v252.Visible = false
			v252.Text = ""
		end

		if t10[v23] then
			t10[v23] = nil
			v41:unlock()

			if v2 then
				v2:Destroy()
			end
		end

		v23:Destroy()

		local v1 = table.find(t7, p1)

		if not v1 then
			UpdateScrollingFrameCanvasSize()

			return
		end

		table.remove(t7, v1)

		for i = v1, #t7 do
			t7[i]:SlideBack()
		end

		UpdateScrollingFrameCanvasSize()
	end
	function t.UpdateFavoriteVisual(p1) --[[ UpdateFavoriteVisual | Line: 3247 | Upvalues: v182 (ref) ]]
		if not (v182 and p1.Tool) then
			return false
		end

		local v1 = isToolFavorite(p1.Tool)

		if v182.Visible == v1 then
			return false
		end

		v182.Visible = v1

		return true
	end
	function t.Swap(p1, p2) --[[ Swap | Line: 3258 | Upvalues: canPlaceToolInSlot (copy) ]]
		if p1.IsFakeSlot or p2.IsFakeSlot then
			return
		end

		local Tool = p1.Tool
		local Tool2 = p2.Tool

		if Tool and (isToolLockedToCurrentHotbarSlot(p1) and p2 ~= p1) then
			return
		end

		if Tool2 and (isToolLockedToCurrentHotbarSlot(p2) and p1 ~= p2) then
			return
		end

		if Tool and not canPlaceToolInSlot(p2, Tool) then
			return
		end

		if Tool2 and not canPlaceToolInSlot(p1, Tool2) then
			return
		end

		p1:Clear()

		if Tool2 then
			p2:Clear()
			p1:Fill(Tool2)
		end

		if Tool then
			p2:Fill(Tool)
		else
			p2:Clear()
		end
	end
	function t.SlideBack(p1) --[[ SlideBack | Line: 3292 | Upvalues: v23 (ref) ]]
		p1.Index = p1.Index - 1
		v23.Name = p1.Index
		v23.LayoutOrder = p1.Index
	end
	function t.TurnNumber(p1, p2) --[[ TurnNumber | Line: 3297 | Upvalues: v17 (ref) ]]
		if not v17 then
			return
		end

		v17.Visible = p2
	end

	local v27 = nil

	function t.SetClickability(p1, p2) --[[ SetClickability | Line: 3305 | Upvalues: shouldAllowSlotDragging (copy), t10 (ref), v23 (ref), v27 (ref), v8 (ref) ]]
		if p1.IsFakeSlot then
			return
		end

		if not p1.Tool then
			return
		end

		local v1 = not p2 and shouldAllowSlotDragging(p1.Tool)

		if not v1 and t10[v23] then
			v27(UserInputService:GetMouseLocation())
		end

		if v8 then
			v23:SetAttribute("Draggable", v1)
		else
			v23.Draggable = v1
		end

		p1:updateDragAppearance()
	end
	function t.CheckTerms(p1, p2) --[[ CheckTerms | Line: 3319 | Upvalues: v62 (ref), v16 (ref) ]]
		local sum = 0
		local Tool = p1.Tool

		if Tool then
			local list = {}

			if v62 and v62.Text ~= "" then
				table.insert(list, v62.Text:lower())
			end

			local v1 = typeof(Tool) == "table" and Tool.Name or Tool.Name

			if v1 then
				table.insert(list, tostring(v1):lower())
			end

			local v3 = v16 and v16.Text

			if v3 and v3 ~= "" then
				table.insert(list, v3:lower())
			end

			local v4 = typeof(Tool) == "table" and Tool.ToolTip or Tool.ToolTip

			if v4 and v4 ~= "" then
				table.insert(list, tostring(v4):lower())
			end

			for k in pairs(p2) do
				for i, v in ipairs(list) do
					local _, v6 = v:gsub(k, "")

					sum = sum + v6
				end
			end
		end

		return sum
	end
	function t.Select(p1) --[[ Select | Line: 3352 | Upvalues: v13 (ref), v51 (ref), t3 (ref), Humanoid (ref), v40 (ref), v55 (ref), Backpack (ref) ]]
		local Tool = p1.Tool

		if Tool and v13 then
			if v13.ItemType == getAttribute(Tool, "ItemType") and (v51 < p1.Index or v13.AllowHotbar) then
				local Validator = v13.Validator

				if not Validator or Validator(Tool) ~= false then
					local v2 = v13

					if ActiveFuseSelectionState then
						t3:EndFuseSelection()
						task.spawn(v2.Callback, Tool)

						return
					end

					v2.Callback(Tool)

					if v2.Preserve == true then
						return
					end

					v13 = nil

					return
				end
			end

			if ActiveFuseSelectionState then
				return
			end
		end

		if not Tool then
			return
		end

		if not BackpackEnabled or (not BackpackGui.Enabled or Variables.Locks.HideUI:IsLocked()) then
			return
		end

		if typeof(Tool) == "table" and Tool.IsVirtualAsset then
			local v4 = _getAssetUID(Tool)

			if typeof(v4) ~= "string" then
				return
			end

			SelectedSlot = p1

			local v5 = findAssetToolByUID(v4)

			if v5 and Humanoid then
				if v5.Parent == v40 then
					Humanoid:UnequipTools()
				else
					Humanoid:UnequipTools()
					Humanoid:EquipTool(v5)
				end
			else
				if v55 ~= v4 then
					updateEquipSelectionVisuals()

					return
				end

				requestUnequipVirtualAsset()
			end

			updateEquipSelectionVisuals()
		elseif typeof(Tool) == "table" and Tool.IsVirtualEgg then
			local v6 = reconcileVirtualEggEquipState()
			local v7 = getAttribute(Tool, "UID")

			if typeof(v7) ~= "string" then
				return
			end

			if v6 == v7 then
				requestUnequipVirtualEgg()
			else
				requestEquipVirtualEgg(v7, p1)
			end
		else
			SelectedSlot = p1

			if Tool.Parent == v40 then
				SelectedSlot = nil

				if Humanoid then
					UnequipAllTools()
				end
			else
				if Tool.Parent ~= Backpack then
					return
				end

				if Humanoid then
					UnequipAllTools()
				end

				Tool.Parent = v40
			end
		end
	end
	t.MainImage = v23.ImageLabel

	local BaseTemplate = v23.BaseTemplate

	BaseTemplate.Amount.Visible = false
	BaseTemplate.Amount.Text = ""
	v52 = BaseTemplate.Amount

	local Mutations = BaseTemplate:FindFirstChild("Mutations")
	v82 = Mutations
	v9 = Mutations and Mutations:FindFirstChild("Template")

	clearMutationIconFrame(v82, v9)

	local UIStroke = v23.UIStroke

	UIStroke.Thickness = 0
	v23.BackgroundColor3 = v22 and Color3.new(0/255, 0/255, 0/255) or BackgroundColorAttribute
	UIStroke.Color = BorderColorAttribute
	v23.Text = ""
	v23.AutoButtonColor = false
	v23.BorderSizePixel = 0

	local v31 = p1 == v28 and v21 or v11

	v23.Size = UDim2.new(0, v31, 0, v31)
	v23.Active = true
	v23.Draggable = false

	if v8 then
		v23:SetAttribute("Draggable", false)
	end

	v23:SetAttribute("IsInventorySlot", v22)
	v23.BackgroundTransparency = if v22 then 0.5 else SlotLockedTransparencyAttribute
	ButtonFX(v23, 1.015, nil, true)
	v23.MouseButton1Click:Connect(function() --[[ Line: 3467 | Upvalues: t (copy), v15 (ref) ]]
		if os.clock() < 0 then
			return
		end

		local Tool = t.Tool

		if v15 and (Tool and isAssetTool(Tool)) then
			requestFavoriteToggle(Tool)
		else
			changeSlot(t)
		end
	end)

	if UserInputService.TouchEnabled then
		v23.TouchLongPress:Connect(function(p1, p2, p3) --[[ Line: 3481 | Upvalues: t (copy) ]]
			if p2 ~= Enum.UserInputState.End then
				return
			end

			local Tool = t.Tool

			if not (Tool and isAssetTool(Tool)) then
				return
			end

			requestFavoriteToggle(Tool)
		end)
	else
		v23.MouseButton2Click:Connect(function() --[[ Line: 3490 | Upvalues: t (copy) ]]
			local Tool = t.Tool

			if not (Tool and isAssetTool(Tool)) then
				return
			end

			requestFavoriteToggle(Tool)
		end)
	end

	t.Frame = v23

	local Selector = v23.SelectionObjectClipper.Selector
	local Shadow = v23.Shadow
	v152 = Shadow

	Shadow.Visible = false
	t.IconImage = Icon

	local FavIcon = v23.FavIcon
	v182 = FavIcon

	FavIcon.Visible = false

	local ToolName = v23.ToolName
	local TextXAlignment = ToolName.TextXAlignment
	local TextYAlignment = ToolName.TextYAlignment
	local Weight = v23.Weight
	v62 = ToolName
	v72 = Weight
	v20 = TextXAlignment
	v212 = TextYAlignment

	Weight.Visible = false
	t.Frame.LayoutOrder = t.Index

	if v12 <= v51 then
		v23.StrokeFrame.Visible = false

		local ToolTip = v23.ToolTip
		v16 = ToolTip

		ToolTip.Visible = false
		t.TooltipLabel = ToolTip
		v23.MouseEnter:Connect(function() --[[ Line: 3522 | Upvalues: ToolTip (ref) ]]
			if ToolTip.Text == "" then
				return
			end

			ToolTip.Visible = false
		end)
		v23.MouseLeave:Connect(function() --[[ Line: 3527 | Upvalues: ToolTip (ref) ]]
			ToolTip.Visible = false
		end)
		function t.MoveToInventory(p1) --[[ MoveToInventory | Line: 3530 | Upvalues: v51 (ref), v28 (ref), v40 (ref), Humanoid (ref), v48 (ref), v25 (ref) ]]
			if p1.IsFakeSlot then
				return
			end

			if isToolLockedToCurrentHotbarSlot(p1) then
				return
			end

			if not (p1.Index <= v51) then
				return
			end

			local Tool = p1.Tool

			p1:Clear()

			local v1 = MakeSlot(v28)

			v1:Fill(Tool)

			if Tool and (Tool.Parent == v40 and Humanoid) then
				UnequipAllTools()
			end

			if Tool and (typeof(Tool) == "Instance" and getAttribute(Tool, "ItemType") == "Asset") then
				task.defer(syncAssetsFromSave)
			end

			if not v48 then
				return
			end

			v1.Frame.Visible = false
			v1.Frame.Parent = v25
		end

		if v12 <= 10 then
			local v33 = v12 <= 10 and v12 or 0
			local Number = v23.Number
			v17 = Number

			Number.Text = v33

			local _ = tostring(v33)

			Number.Visible = false
			t9[Zero + v33] = function() --[[ Line: 3561 | Upvalues: t (copy) ]]
				changeSlot(t)
			end
		end
	end

	local Position = v23.Position
	local v34 = 0
	local v35 = nil
	local v36 = nil

	local function startDrag(p1) --[[ startDrag | Line: 3570 | Upvalues: t (copy), shouldAllowSlotDragging (copy), v8 (ref), v23 (ref), t10 (ref), Position (ref), UIStroke (copy), v41 (ref), v36 (ref), LocalPlayer (ref), v4 (ref), v14 (ref), v35 (ref), v28 (ref), v25 (ref), v2 (ref) ]]
		if t.Tool and shouldAllowSlotDragging(t.Tool) then
			t10[v23] = true
			Position = p1
			UIStroke.Thickness = 2
			v41:lock()

			if v36 then
				v36:Disconnect()
				v36 = nil
			end

			if t.Tool then
				local Tool = t.Tool

				if typeof(Tool) == "Instance" then
					v36 = t.Tool.AncestryChanged:Connect(function(p1, p2) --[[ Line: 3586 | Upvalues: t (ref), v36 (ref), LocalPlayer (ref), v4 (ref) ]]
						if t.Tool and p1 == t.Tool then
							local v1 = t.Tool.Parent

							if v1 == LocalPlayer.Backpack or v1 == LocalPlayer.Character then
								return
							end

							if v4 then
								v4:Destroy()
								v4 = nil
							end

							if not v36 then
								return
							end

							v36:Disconnect()
							v36 = nil
						elseif v36 then
							v36:Disconnect()
							v36 = nil
						end
					end)
				end
			end

			v23.ZIndex = 22
			v23.Parent.ZIndex = 22

			if v14 then
				v14.ZIndex = 22

				for v1, v22 in v14:GetChildren() do
					if not (v22:IsA("UICorner") or v22:IsA("UIStroke")) then
						v22.ZIndex = 22
					end
				end
			end

			v35 = v23.Parent

			if v35 ~= v28 then
				return
			end

			local v3 = UDim2.new(0, v23.AbsolutePosition.X - v25.AbsolutePosition.X, 0, v23.AbsolutePosition.Y - v25.AbsolutePosition.Y)

			v23.Parent = v25
			v23.Position = v3
			v4 = NewGui("Frame", "FakeSlot")
			v4.LayoutOrder = v23.LayoutOrder
			v4.Size = v23.Size
			v4.BackgroundTransparency = 1
			v4.Parent = v28
			v2 = v4
		else
			if v8 then
				v23:SetAttribute("Draggable", false)
			else
				v23.Draggable = false
			end

			t:updateDragAppearance()
		end
	end

	v27 = function(p1) --[[ Line: 3636 | Upvalues: t10 (ref), v23 (ref), v4 (ref), v36 (ref), Position (ref), v35 (ref), UIStroke (copy), v41 (ref), v14 (ref), t (copy), shouldAllowSlotDragging (copy), v8 (ref), v25 (ref), v51 (ref), v6 (ref), v5 (ref), v7 (ref), v1 (ref), v3 (ref), v34 (ref), v42 (ref), canPlaceToolInSlot (copy), v24 (ref), t7 (ref), v40 (ref), Humanoid (ref), v48 (ref) ]]
		t10[v23] = nil

		if v4 then
			v4:Destroy()
			v4 = nil
		end

		if v36 then
			v36:Disconnect()
			v36 = nil
		end

		local v12 = tick()

		v23.Position = Position

		if v35 and v23.Parent ~= v35 then
			v23.Parent = v35
		end

		UIStroke.Thickness = 0
		v41:unlock()
		v23.ZIndex = 20

		if v35 then
			v35.ZIndex = 20
		end

		if v14 then
			v14.ZIndex = 20

			for v2, v32 in v14:GetChildren() do
				if not (v32:IsA("UICorner") or v32:IsA("UIStroke")) then
					v32.ZIndex = 20
				end
			end
		end

		if not t.Tool then
			return
		end

		if shouldAllowSlotDragging(t.Tool) then
			if CheckBounds(v25, p1.X, p1.Y) then
				if t.Index <= v51 then
					if v6 ~= v5 then
						v7((GetCategory(t.Tool)))
					end

					t:MoveToInventory()
					v1.Text = ""
					task.delay(0.01, function() --[[ Line: 3682 | Upvalues: v3 (ref) ]]
						if not v3 then
							return
						end

						v3(true)
					end)
				end

				if v51 < t.Index and v12 - v34 < 0.5 then
					if v42 and canPlaceToolInSlot(v42, t.Tool) then
						t:Clear()
						v42:Fill(t.Tool)
						t:Delete()
					end

					v12 = 0
				end
			elseif CheckBounds(v24, p1.X, p1.Y) then
				local t2 = { (1 / 0), nil }

				for i = 1, v51 do
					local v43 = t7[i]
					local v52 = GetOffset(v43.Frame, p1)

					if v52 < t2[1] then
						t2 = { v52, v43 }
					end
				end

				local v62 = t2[2]

				if v62 ~= t then
					t:Swap(v62)

					if v51 < t.Index then
						local Tool = t.Tool

						if Tool then
							if Tool.Parent == v40 and Humanoid then
								UnequipAllTools()
							end

							if v48 then
								t.Frame.Visible = false
								t.Frame.Parent = v25
							end
						else
							t:Delete()
						end
					end
				end
			elseif t.Index <= v51 then
				t:MoveToInventory()
				task.delay(0.01, function() --[[ Line: 3729 | Upvalues: v3 (ref) ]]
					if not v3 then
						return
					end

					v3(true)
				end)
			elseif t.Tool and (t.Tool:IsA("Tool") and t.Tool.CanBeDropped) then
				t.Tool.Parent = workspace
			end

			v34 = v12
			task.delay(0.01, function() --[[ Line: 3739 | Upvalues: v3 (ref) ]]
				if not v3 then
					return
				end

				v3(true)
			end)
		else
			if v8 then
				v23:SetAttribute("Draggable", false)
			else
				v23.Draggable = false
			end

			t:updateDragAppearance()
		end
	end

	if v8 then
		local v37 = false
		local v38 = false
		local v39 = nil
		local v402 = nil

		local function drag(p1) --[[ drag | Line: 3750 | Upvalues: v402 (ref), v39 (ref), v38 (ref), v37 (ref), t10 (ref), v23 (ref) ]]
			if v402 and v39 then
				local v1 = p1 - v39

				v23.Position = UDim2.new(v402.X.Scale, v402.X.Offset + v1.X, v402.Y.Scale, v402.Y.Offset + v1.Y)
			else
				v38 = false
				v37 = false
				t10[v23] = nil
			end
		end

		v23.InputBegan:Connect(function(p1) --[[ Line: 3765 | Upvalues: v23 (ref), v38 (ref), startDrag (copy), v37 (ref), v39 (ref), v402 (ref), t10 (ref), v27 (ref) ]]
			if not v23:GetAttribute("Draggable") then
				return
			end

			if p1.UserInputType ~= Enum.UserInputType.MouseButton1 and (p1.UserInputType ~= Enum.UserInputType.Touch and p1.KeyCode ~= Enum.KeyCode.ButtonA) then
				return
			end

			v38 = true

			local v1 = UserInputService.InputChanged:Connect(function(p1) --[[ Line: 3776 | Upvalues: v38 (ref), startDrag (ref), v23 (ref), v37 (ref), v39 (ref), v402 (ref), t10 (ref) ]]
				if v38 then
					v38 = false
					startDrag(v23.Position)
					v37 = true
					v39 = UserInputService:GetMouseLocation()
					v402 = v23.Position
				end

				if not v37 or p1.UserInputType ~= Enum.UserInputType.MouseMovement and (p1.UserInputType ~= Enum.UserInputType.Touch and not string.find(p1.UserInputType.Name, "Gamepad")) then
					return
				end

				local v1 = UserInputService:GetMouseLocation()

				if not (v402 and v39) then
					v38 = false
					v37 = false
					t10[v23] = nil

					return
				end

				local v2 = v1 - v39

				v23.Position = UDim2.new(v402.X.Scale, v402.X.Offset + v2.X, v402.Y.Scale, v402.Y.Offset + v2.Y)
			end)
			local v2 = nil

			v2 = p1:GetPropertyChangedSignal("UserInputState"):Connect(function() --[[ Line: 3796 | Upvalues: v37 (ref), v38 (ref), v2 (ref), p1 (copy), v1 (ref), v39 (ref), v402 (ref), v27 (ref) ]]
				if v37 or v38 then
					if p1.UserInputState ~= Enum.UserInputState.End then
						return
					end

					v1:Disconnect()

					local v12 = v37

					v38 = false
					v37 = false
					v39 = nil
					v402 = nil

					if v2 then
						v2:Disconnect()
						v2 = nil
					end

					if not v12 then
						return
					end

					v27(Vector2.new(p1.Position.X, p1.Position.Y))
				else
					if not v2 then
						return
					end

					v2:Disconnect()
					v2 = nil
				end
			end)
		end)
	else
		v23.DragBegin:Connect(function(p1) --[[ Line: 3823 | Upvalues: startDrag (copy) ]]
			startDrag(p1)
		end)
		v23.DragStopped:Connect(function(p1, p2) --[[ Line: 3826 | Upvalues: v27 (ref) ]]
			v27(Vector2.new(p1, p2))
		end)
	end

	v23.Parent = p1
	t7[v12] = t

	if v51 < v12 then
		local CanvasPosition = v28.CanvasPosition

		UpdateScrollingFrameCanvasSize()

		local v412 = v28.CanvasSize.Y.Offset - v28.AbsoluteSize.Y

		if v25.Visible and not v48 then
			v28.CanvasPosition = Vector2.new(CanvasPosition.X, (math.min(CanvasPosition.Y, (math.max(0, v412)))))
		else
			v28.CanvasPosition = CanvasPosition
		end
	end

	return t
end
function moveStackSlotIntoFrontHotbar(p1) --[[ moveStackSlotIntoFrontHotbar | Line: 3845 | Upvalues: v51 (copy), t7 (copy), v42 (ref) ]]
	if not p1 or p1.IsDeleted then
		return nil
	end

	if p1.Index <= v51 then
		return p1
	end

	local v1 = getInsertableHotbarIndices(p1.Tool)
	local v2 = v1[1]

	if not v2 then
		return nil
	end

	local v3 = t7[v2]

	if not v3 then
		return nil
	end

	local v4 = v42
	local v5 = if v4 then table.find(v1, v4.Index) else v4

	if not v5 then
		local v6 = v1[#v1]
		local v7 = if v6 then t7[v6] else v6

		if v7 and v7.Tool then
			v7:MoveToInventory()
			v5 = #v1
		end
	end

	if not v5 then
		return nil
	end

	for i = v5, 2, -1 do
		local v8 = t7[v1[i]]
		local v9 = t7[v1[i - 1]]

		if v8 and v9 then
			v9:Swap(v8)
		end
	end

	p1:Swap(v3)

	if not (v51 < p1.Index) or p1.Tool then
		return v3
	end

	p1:Delete()

	return v3
end
function movePendingHotbarAssets() --[[ movePendingHotbarAssets | Line: 3894 | Upvalues: t16 (copy), t12 (copy), v3 (ref) ]]
	local v1 = false

	for k in pairs(t16) do
		local v2 = t12[k]

		if v2 then
			local v32 = moveStackSlotIntoFrontHotbar(v2)

			if v32 then
				t12[k] = v32
				t16[k] = nil
				v1 = true
			end
		end
	end

	if not v1 then
		return v1
	end

	AdjustHotbarFrames()
	UpdateInventorySlots()

	if not v3 then
		return v1
	end

	v3(true)

	return v1
end
function movePendingHotbarEggs() --[[ movePendingHotbarEggs | Line: 3919 | Upvalues: t20 (copy), t18 (copy), v3 (ref), t21 (copy), t3 (copy) ]]
	local v1 = false

	for k in pairs(t20) do
		local v2 = t18[k]

		if v2 then
			local v32 = moveStackSlotIntoFrontHotbar(v2)

			if v32 then
				t18[k] = v32
				t20[k] = nil
				v1 = true
			end
		end
	end

	if v1 then
		AdjustHotbarFrames()
		UpdateInventorySlots()

		if v3 then
			v3(true)
		end
	end

	for k in pairs(t21) do
		if t3:ForceEggIntoTutorialHotbar(k) ~= nil then
			t21[k] = nil
		end
	end

	return v1
end
function OnChildAdded(p1, p2) --[[ OnChildAdded | Line: 3950 | Upvalues: v40 (ref), Humanoid (ref), v50 (ref), v28 (ref), v44 (ref), t8 (copy), LocalPlayer (ref), Backpack (ref), v3 (ref), v51 (copy), v25 (ref) ]]
	if p1:IsA("Tool") then
		if p1.Parent == v40 then
			v50 = tick()
		end

		local v1 = p1:GetAttribute("ItemType")

		if v1 == "Asset" then
			invalidateEquipBestStatus()
			syncVirtualAssetEquipStateFromTool(p1)
			task.defer(syncAssetsFromSave)

			return
		end

		if v1 == "AssetEgg" then
			syncVirtualEggEquipStateFromTool(p1)

			return
		end

		local v2 = v28
		local CanvasPosition = v28.CanvasPosition

		if not v44 and (p1.Parent == v40 and not t8[p1]) then
			local StarterGear = LocalPlayer:FindFirstChild("StarterGear")

			if StarterGear and StarterGear:FindFirstChild(p1.Name) then
				v44 = true

				local v32 = insertToolIntoFrontHotbar(p1) or claimLowestEmptySlot(p1) or MakeSlot(v28)

				if v32.Tool ~= p1 then
					v32:Fill(p1)
				end

				if isGearTool(p1) then
					ensureGameplayGearHotbarSlots()
				end

				for k, v in pairs(v40:GetChildren()) do
					if v:IsA("Tool") and v ~= p1 then
						v.Parent = Backpack
					end
				end

				AdjustHotbarFrames()

				local v4, v5, v6, v7, v8

				if not v3 then
					UpdateInventorySlots()
					v4 = v2.CanvasSize.Y.Offset - v2.AbsoluteSize.Y
					v5 = Vector2.new
					v6 = CanvasPosition.X
					v7 = CanvasPosition.Y
					v8 = math.max(0, v4)
					v2.CanvasPosition = v5(v6, (math.min(v7, v8)))

					return
				end

				v3(true)
				UpdateInventorySlots()
				v4 = v2.CanvasSize.Y.Offset - v2.AbsoluteSize.Y
				v5 = Vector2.new
				v6 = CanvasPosition.X
				v7 = CanvasPosition.Y
				v8 = math.max(0, v4)
				v2.CanvasPosition = v5(v6, (math.min(v7, v8)))

				return
			end
		end

		local v9 = t8[p1]

		if v9 then
			v9:UpdateEquipView()

			return
		end

		local v10 = insertToolIntoFrontHotbar(p1) or (claimLowestEmptySlot(p1) or MakeSlot(v28))

		if v10.Tool ~= p1 then
			v10:Fill(p1)
		end

		if isGearTool(p1) then
			ensureGameplayGearHotbarSlots()
		end

		local v12, v13, v14, v15, v16

		if not (v10.Index <= v51) or v25.Visible then
			UpdateInventorySlots()
			v12 = v2.CanvasSize.Y.Offset - v2.AbsoluteSize.Y
			v13 = Vector2.new
			v14 = CanvasPosition.X
			v15 = CanvasPosition.Y
			v16 = math.max(0, v12)
			v2.CanvasPosition = v13(v14, (math.min(v15, v16)))
			task.delay(0.05, function() --[[ Line: 4025 | Upvalues: v3 (ref) ]]
				if not v3 then
					return
				end

				v3(true)
			end)

			return
		end

		AdjustHotbarFrames()
		UpdateInventorySlots()
		v12 = v2.CanvasSize.Y.Offset - v2.AbsoluteSize.Y
		v13 = Vector2.new
		v14 = CanvasPosition.X
		v15 = CanvasPosition.Y
		v16 = math.max(0, v12)
		v2.CanvasPosition = v13(v14, (math.min(v15, v16)))
		task.delay(0.05, function() --[[ Line: 4025 | Upvalues: v3 (ref) ]]
			if not v3 then
				return
			end

			v3(true)
		end)
	else
		if not p1:IsA("Humanoid") or p1.Parent ~= v40 then
			return
		end

		Humanoid = p1
	end
end
function OnChildRemoved(p1) --[[ OnChildRemoved | Line: 4034 | Upvalues: v50 (ref), t8 (copy), v51 (copy), v25 (ref), v40 (ref), Backpack (ref), t7 (copy) ]]
	if not p1:IsA("Tool") then
		return
	end

	v50 = tick()

	local v1 = p1:GetAttribute("ItemType")

	if v1 == "Asset" then
		invalidateEquipBestStatus()
		task.defer(reconcileVirtualAssetEquipState)
		task.defer(syncAssetsFromSave)

		local v2 = t8[p1]

		if not v2 or v2.Tool ~= p1 then
			return
		end

		v2:Clear()

		if v51 < v2.Index then
			v2:Delete()
		end

		if v2.Index <= v51 and not v25.Visible then
			AdjustHotbarFrames()
		end
	else
		if v1 == "AssetEgg" then
			task.defer(reconcileVirtualEggEquipState)

			return
		end

		local v3 = t8[p1]
		local v4 = p1.Parent

		if v4 == v40 or v4 == Backpack then
			return
		end

		local v5

		if v3 and v3.Tool == p1 then
			v5 = v3
		else
			v5 = v3

			for k, v in pairs(t7) do
				if v.Tool == p1 then
					v5 = v

					break
				end
			end
		end

		if not v5 or v5.Tool ~= p1 then
			return
		end

		v5:Clear()

		if v51 < v5.Index then
			v5:Delete()
		end

		if v5.Index <= v51 and not v25.Visible then
			AdjustHotbarFrames()
		end
	end

	UpdateInventorySlots()
end
function SetupCharacter(p1) --[[ SetupCharacter | Line: 4091 | Upvalues: v55 (ref), v58 (ref), t7 (copy), t11 (ref), v40 (ref), Backpack (ref), LocalPlayer (ref) ]]
	v55 = nil
	v58 = nil

	for i = #t7, 1, -1 do
		local v1 = t7[i]

		if v1.Tool then
			if typeof(v1.Tool) == "Instance" then
				v1:Clear()

				continue
			end

			v1:UpdateEquipView(true)
		end
	end

	for k, v in pairs(t11) do
		v:Disconnect()
	end

	t11 = {}
	v40 = p1
	table.insert(t11, p1.ChildRemoved:Connect(OnChildRemoved))
	table.insert(t11, p1.ChildAdded:Connect(function(p1) --[[ Line: 4113 ]]
		if p1:IsA("Tool") and (p1.Name == Constants.LUCKY_BLOCK_TOOL_NAME or p1:GetAttribute("HideFromBackpackUI") == true) then
			return
		end

		OnChildAdded(p1, false)
	end))

	for k, v in pairs(p1:GetChildren()) do
		task.spawn(OnChildAdded, v, false)
	end

	Backpack = LocalPlayer:WaitForChild("Backpack")
	table.insert(t11, Backpack.ChildRemoved:Connect(OnChildRemoved))
	table.insert(t11, Backpack.ChildAdded:Connect(function(p1) --[[ Line: 4130 ]]
		if p1:IsA("Tool") and (p1.Name == Constants.LUCKY_BLOCK_TOOL_NAME or p1:GetAttribute("HideFromBackpackUI") == true) then
			return
		end

		OnChildAdded(p1, true)
	end))

	for k, v in pairs(Backpack:GetChildren()) do
		task.spawn(OnChildAdded, v, false)
	end

	AdjustHotbarFrames()
	invalidateEquipBestStatus(true)
	reconcileVirtualAssetEquipState()
end

local PlayerGui2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function HandleInputBegan(p1, p2) --[[ HandleInputBegan | Line: 4148 | Upvalues: v47 (ref), v45 (ref), Backspace (copy), t9 (copy), v25 (ref), PlayerGui2 (copy), v41 (copy) ]]
	if p2 ~= false then
		return
	end

	if p1.KeyCode == Enum.KeyCode.ButtonL2 or p1.UserInputType == Enum.UserInputType.Keyboard and (not v47 and (v45 or p1.KeyCode.Value == Backspace)) then
		local v1 = t9[p1.KeyCode.Value]

		if v1 then
			if ActiveFuseSelectionState then
				return
			end

			v1(p2)
		end
	end

	local UserInputType = p1.UserInputType

	if UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.Touch or (not v25.Visible or ActiveFuseSelectionState) then
		return
	end

	local v2 = UserInputService:GetMouseLocation()
	local v3 = nil

	for v4, v5 in PlayerGui2:GetGuiObjectsAtPosition(v2.X, v2.Y) do
		if v5.Name:find("CategoryFrame") then
			v3 = v5

			break
		end
	end

	if v3 then
		return
	end

	v41:deselect()
end
function OnInputServiceChanged(p1) --[[ OnInputServiceChanged | Line: 4184 | Upvalues: v51 (copy), t7 (copy) ]]
	if p1 ~= "KeyboardEnabled" and p1 ~= "VREnabled" then
		return
	end

	local v1 = UserInputService.KeyboardEnabled and not UserInputService.VREnabled

	for i = 1, v51 do
		t7[i]:TurnNumber(v1)
	end
end
function OnGamepadFocus() --[[ OnGamepadFocus | Line: 4192 ]] end
function unbindAllGamepadEquipActions() --[[ unbindAllGamepadEquipActions | Line: 4193 ]]
	ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
	ContextActionService:UnbindAction("RBXCloseInventory")
end
function _setHotbarVisibility(p1, p2) --[[ _setHotbarVisibility | Line: 4197 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and (v1.Frame and (p2 or v1.Tool)) then
			v1.Frame.Visible = p1
		end
	end
end
function getEquippedHotbarSlot() --[[ getEquippedHotbarSlot | Line: 4205 | Upvalues: t12 (copy), v51 (copy), t18 (copy), v40 (ref), t8 (copy) ]]
	local v1 = reconcileVirtualAssetEquipState()

	if typeof(v1) == "string" then
		local v2 = t12[v1]

		if v2 and (not v2.IsDeleted and (v2.Index <= v51 and v2.Tool)) then
			return v2
		end
	end

	local v3 = reconcileVirtualEggEquipState()

	if typeof(v3) == "string" then
		local v4 = t18[v3]

		if v4 and (not v4.IsDeleted and (v4.Index <= v51 and v4.Tool)) then
			return v4
		end
	end

	if not v40 then
		return nil
	end

	for i, v in ipairs(v40:GetChildren()) do
		if v:IsA("Tool") then
			local v5 = t8[v]

			if v5 and (v5.Index <= v51 and v5.Tool) then
				return v5
			end
		end
	end

	return nil
end
function changeTool(p1, p2, p3) --[[ changeTool | Line: 4235 | Upvalues: v51 (copy), t7 (copy) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	local v1 = if p3.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1
	local v2 = getEquippedHotbarSlot()
	local sum = if v2 then v2.Index elseif v1 == -1 then 1 else v51

	for i = 1, v51 do
		sum = sum + v1

		if v51 < sum then
			sum = 1
		elseif sum < 1 then
			sum = v51
		end

		local v3 = t7[sum]

		if v3.Tool and v3 ~= v2 then
			v3:Select()

			return
		end
	end
end
function getGamepadSwapSlot() --[[ getGamepadSwapSlot | Line: 4259 | Upvalues: t7 (copy) ]]
	for i = 1, #t7 do
		if t7[i].Frame:WaitForChild("UIStroke").Thickness > 0 then
			return t7[i]
		end
	end
end
function changeSlot(p1) --[[ Line: 4267 | Upvalues: v25 (ref), GuiService (copy), v27 (ref), v51 (copy) ]]
	if p1.IsFakeSlot then
		p1:Select()

		return
	end

	if p1.Frame == GuiService.SelectedObject and (not VRService.VREnabled or v25.Visible) then
		local v2 = getGamepadSwapSlot()

		if not v2 then
			local Size = p1.Frame.Size
			local Position = p1.Frame.Position

			p1.Frame:TweenSizeAndPosition(Size + UDim2.new(0, 10, 0, 10), Position - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 4305 | Upvalues: p1 (copy), Size (copy), Position (copy) ]]
				p1.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
			end)
			p1.Frame:WaitForChild("UIStroke").Thickness = 3
			v27.SelectionImageObject.Visible = true

			return
		end

		v2.Frame:WaitForChild("UIStroke").Thickness = 0

		if v2 == p1 then
			return
		end

		p1:Swap(v2)
		v27.SelectionImageObject.Visible = false

		if v51 < p1.Index and not p1.Tool then
			if GuiService.SelectedObject == p1.Frame then
				GuiService.SelectedObject = v2.Frame
			end

			p1:Delete()
		end

		if not (v51 < v2.Index) or v2.Tool then
			return
		end

		if GuiService.SelectedObject ~= v2.Frame then
			v2:Delete()

			return
		end

		GuiService.SelectedObject = p1.Frame
		v2:Delete()

		return
	end

	p1:Select()
	v27.SelectionImageObject.Visible = false
end
function vrMoveSlotToInventory() --[[ vrMoveSlotToInventory | Line: 4325 | Upvalues: v27 (ref) ]]
	if not VRService.VREnabled then
		return
	end

	local v1 = getGamepadSwapSlot()

	if not (v1 and v1.Tool) then
		return
	end

	v1:WaitForChild("UIStroke").Thickness = 0
	v1:MoveToInventory()
	v27.SelectionImageObject.Visible = false
end
function enableGamepadInventoryControl() --[[ enableGamepadInventoryControl | Line: 4336 | Upvalues: v25 (ref), v41 (copy), GuiService (copy), v24 (ref) ]]
	local function handleBackAction(p1, p2) --[[ handleBackAction | Line: 4337 | Upvalues: v25 (ref), v41 (ref) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return
		end

		local v1 = getGamepadSwapSlot()

		if v1 then
			v1.Frame:WaitForChild("UIStroke").Thickness = 0

			return
		end

		if not v25.Visible then
			return
		end

		v41:deselect()
	end

	ContextActionService:BindAction("RBXBackpackHasGamepadFocus", OnGamepadFocus, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction("RBXCloseInventory", handleBackAction, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

	if UserInputService.VREnabled then
		return
	end

	GuiService.SelectedObject = v24:FindFirstChild("1")
end
function disableGamepadInventoryControl() --[[ disableGamepadInventoryControl | Line: 4362 | Upvalues: v51 (copy), t7 (copy), GuiService (copy), v22 (ref) ]]
	unbindAllGamepadEquipActions()

	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and v1.Frame then
			v1.Frame:WaitForChild("UIStroke").Thickness = 0
		end
	end

	if not (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(v22)) then
		return
	end

	GuiService.SelectedObject = nil
end
function _bindBackpackHotbarAction() --[[ _bindBackpackHotbarAction | Line: 4374 | Upvalues: v45 (ref), v18 (ref) ]]
	if not v45 or v18 then
		return
	end

	v18 = true
	ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
end
function _unbindBackpackHotbarAction() --[[ _unbindBackpackHotbarAction | Line: 4386 | Upvalues: v18 (ref) ]]
	disableGamepadInventoryControl()
	v18 = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end
function gamepadDisconnected() --[[ gamepadDisconnected | Line: 4391 | Upvalues: v49 (ref) ]]
	v49 = false
	disableGamepadInventoryControl()
end
function gamepadConnected() --[[ gamepadConnected | Line: 4395 | Upvalues: v49 (ref), GuiService (copy), v22 (ref), v43 (ref), v45 (ref), v18 (ref), v25 (ref) ]]
	v49 = true
	GuiService:AddSelectionParent("RBXBackpackSelection", v22)

	if v43 >= 1 and (v45 and not v18) then
		v18 = true
		ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end

	if not v25.Visible then
		return
	end

	enableGamepadInventoryControl()
end
function OnIconChanged(p1) --[[ OnIconChanged | Line: 4413 | Upvalues: v41 (copy), GuiService (copy), v45 (ref), v22 (ref), v43 (ref), v18 (ref) ]]
	local v1 = if p1 then CoreCall("GetCore", "TopbarEnabled") else p1

	v41:setEnabled(if v1 then not GuiService.MenuIsOpen and not ActiveFuseSelectionState else v1)
	v45 = v1
	v22.Visible = v1

	if v1 then
		if v43 >= 1 and (v1 and not v18) then
			v18 = true
			ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
		end
	else
		disableGamepadInventoryControl()
		v18 = false
		ContextActionService:UnbindAction("RBXHotbarEquip")
	end
end
function createScrollButton(p1, p2) --[[ createScrollButton | Line: 4435 ]]
	local v1 = NewGui("ImageButton", p1)

	v1.Size = UDim2.new(0, 40, 0, 40)
	v1.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"

	local v2 = NewGui("ImageLabel", "Icon")

	v2.Size = UDim2.new(0.5, 0, 0.5, 0)
	v2.Position = UDim2.new(0.25, 0, 0.25, 0)
	v2.Image = p2
	v2.Parent = v1

	local v3 = NewGui("ImageLabel", "Selection")

	v3.Size = UDim2.new(0.9, 0, 0.9, 0)
	v3.Position = UDim2.new(0.05, 0, 0.05, 0)
	v3.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	v1.SelectionImageObject = v3

	return v1, v2, v3
end
v22 = BackpackGui:WaitForChild("Backpack")
v22.Visible = false
v24 = NewGui("Frame", "Hotbar")
v24.Parent = v22

local RoundChoices = script:FindFirstChild("RoundChoices")

if RoundChoices then
	RoundChoices.Parent = v24

	if v20 then
		RoundChoices.Size = UDim2.fromScale(1, 0.4)
	end
elseif RunService:IsStudio() then
	error("RoundChoices frame not found in Backpack script")
end

for i = 1, v51 do
	MakeSlot(v24, i).Frame.Visible = false
end

v23 = v22:WaitForChild("Main")
v25 = v23:WaitForChild("Inventory")

local Loading = v25:WaitForChild("Loading")

Loading.Visible = false
task.spawn(PreloadAssets, v25.ImageLabel.ImageLabel)
v59 = v25.AutoSell
v59.Visible = false
task.spawn(initializeAutoSellUI)
v42 = FindLowestEmpty()
AdjustHotbarFrames()
v41.selected:Connect(function() --[[ Line: 4486 | Upvalues: GuiService (copy), t3 (copy) ]]
	if GuiService.MenuIsOpen then
		return
	end

	t3.OpenClose()
end)
v41.deselected:Connect(function() --[[ Line: 4491 | Upvalues: v25 (ref), t3 (copy) ]]
	if not v25.Visible then
		return
	end

	t3.OpenClose()
end)

local v72 = NewGui("ImageLabel", "LeftBumper")

v72.Size = UDim2.new(0, 40, 0, 40)
v72.Position = UDim2.new(0, -v72.Size.X.Offset, 0.5, -v72.Size.Y.Offset / 2)

local v73 = NewGui("ImageLabel", "RightBumper")

v73.Size = UDim2.new(0, 40, 0, 40)
v73.Position = UDim2.new(1, 0, 0.5, -v73.Size.Y.Offset / 2)

local BackgroundColor3 = v25.BackgroundColor3

InventoryStroke = v25:FindFirstChildWhichIsA("UIStroke")
InventoryStrokeDefaultColor = InventoryStroke and InventoryStroke.Color or nil
InventoryStrokeDefaultTransparency = v25.BackgroundTransparency
v25.Visible = false
function refreshInventoryFrameVisuals() --[[ refreshInventoryFrameVisuals | Line: 4507 | Upvalues: v25 (ref), v15 (ref), v26 (copy), BackgroundColor3 (copy) ]]
	if ActiveFuseSelectionState then
		v25.BackgroundColor3 = FUSE_SELECTION_BACKGROUND_COLOR

		if InventoryStroke then
			InventoryStroke.Color = FUSE_SELECTION_STROKE_COLOR
		end

		v25.BackgroundTransparency = FUSE_SELECTION_BACKGROUND_TRANSPARENCY
	else
		v25.BackgroundColor3 = v15 and v26 or BackgroundColor3

		if InventoryStroke and InventoryStrokeDefaultColor then
			InventoryStroke.Color = InventoryStrokeDefaultColor
		end

		v25.BackgroundTransparency = InventoryStrokeDefaultTransparency
	end
end

local FavoriteMode = Instance.new("UIStroke")

FavoriteMode.Name = "FavoriteMode"
FavoriteMode.Thickness = 4.5
FavoriteMode.Color = Color3.fromRGB(255, 170, 0)
FavoriteMode.Enabled = false
FavoriteMode.ZIndex = 2
FavoriteMode.Parent = v25
function updateFavoriteModeVisuals() --[[ updateFavoriteModeVisuals | Line: 4530 | Upvalues: v14 (ref), v15 (ref), FavoriteMode (ref) ]]
	local v1 = v14 and v14:FindFirstChildWhichIsA("TextLabel")

	if v1 then
		v1.Text = if v15 then "Favorite: ON" else "Favorite: OFF"
	end

	if not FavoriteMode then
		refreshInventoryFrameVisuals()

		return
	end

	FavoriteMode.Enabled = v15 and not ActiveFuseSelectionState
	refreshInventoryFrameVisuals()
end
function setFavoriteModeActive(p1) --[[ setFavoriteModeActive | Line: 4543 | Upvalues: v15 (ref), v14 (ref), FavoriteMode (ref) ]]
	v15 = p1

	if v14 then
		updateFavoriteModeVisuals()

		return
	end

	refreshInventoryFrameVisuals()

	if not FavoriteMode then
		return
	end

	FavoriteMode.Enabled = p1 and not ActiveFuseSelectionState
end
function hideFavoriteModeButton() --[[ hideFavoriteModeButton | Line: 4556 | Upvalues: v15 (ref), v14 (ref), v59 (ref), v60 (ref) ]]
	if v15 then
		setFavoriteModeActive(false)
	end

	if not v14 then
		return
	end

	v14.Visible = false

	if v59 then
		v59.Visible = false
	end

	if not v60 then
		return
	end

	v60.Visible = false
end
function refreshFavoriteModeVisibility() --[[ refreshFavoriteModeVisibility | Line: 4572 | Upvalues: v14 (ref), t2 (copy), v6 (ref), v5 (copy), v59 (ref), v60 (ref) ]]
	if not v14 then
		return
	end

	local v1 = t2[v6]
	local v2 = v6 == v5

	if v1 and v1.Tags then
		for v3, v4 in v1.Tags do
			if v4 == "Asset" then
				v2 = true

				break
			end
		end
	end

	if v2 then
		v14.Visible = false

		if v59 then
			v59.Visible = false
		end

		if v60 then
			v60.Visible = false
		end
	else
		hideFavoriteModeButton()
	end

	updateEquipBestButtonVisibility()
end
v14 = v25:FindFirstChild("FavoriteMode") or script:FindFirstChild("FavoriteMode")

if v14 then
	v14.Parent = v25
	v14.Visible = false
	updateFavoriteModeVisuals()
	ButtonFX(v14, nil, function() --[[ Line: 4609 | Upvalues: v15 (ref) ]]
		setFavoriteModeActive(not v15)
	end)
end

v60 = v25:FindFirstChild("EquipBest")

if v60 then
	v60.Visible = false
	ButtonFX(v60, nil, requestEquipBest)
end

local EquipBest = script:FindFirstChild("EquipBest")

if EquipBest and EquipBest:IsA("GuiButton") then
	v61 = EquipBest:Clone()
	assert(v61, "missing hotbar")
	v61.Parent = v24
	v61.Visible = false
	ButtonFX(v61, nil, requestEquipBest)
end

local v77 = v25:FindFirstChild("CategoryLabel") or script.CategoryTemplate:Clone()

v77.Parent = v25

local v78 = if v77:IsA("TextLabel") then v77 else v77:FindFirstChildWhichIsA("TextLabel", true)

assert(v78 and v78:IsA("TextLabel"), "Category label template must contain a TextLabel")

local t25 = {}
local t26 = {}

local function f80() --[[ Line: 4637 | Upvalues: t26 (copy) ]]
	local v1 = ActiveFuseSelectionState
	local v2 = v1 ~= nil

	for v3, v4 in t26 do
		local v5 = if v2 then if v1.AllowedCategories[v3] == true then true else false else true

		v4.Visible = v5

		local ImageButton = v4:FindFirstChild("ImageButton")

		if ImageButton and ImageButton:IsA("GuiButton") then
			ImageButton.Active = v5
		end
	end
end

function updateCategorySelectionVisuals() --[[ updateCategorySelectionVisuals | Line: 4654 | Upvalues: t25 (copy), v6 (ref) ]]
	for v1, v2 in t25 do
		v2.Enabled = v1 == v6
	end
end
function updateCategoryLabel(p1) --[[ updateCategoryLabel | Line: 4660 | Upvalues: v78 (copy) ]]
	v78.Text = p1
end
function applyCategoryLayout() --[[ applyCategoryLayout | Line: 4664 | Upvalues: v29 (ref), v28 (ref), v31 (ref), v32 (ref), v33 (ref), v36 (ref), v34 (ref), v35 (ref), v38 (ref), v37 (ref) ]]
	if not (v29 and v28) then
		return
	end

	if not v31 then
		v31 = v29.CellSize
	end

	if not v32 then
		v32 = v29:FindFirstChildWhichIsA("UIAspectRatioConstraint") or v28:FindFirstChildWhichIsA("UIAspectRatioConstraint")

		if v32 then
			v33 = v32.AspectRatio
		end
	end

	if not v36 then
		v36 = v28.ScrollingDirection
	end

	if not v34 then
		v34 = v29.FillDirection
	end

	if not v35 then
		v35 = v29.HorizontalAlignment
	end

	if v38 and not v37 then
		v37 = v38.PaddingLeft
	end

	v29.CellSize = v31

	if v32 and v33 then
		v32.AspectRatio = v33
	end

	v28.AutomaticCanvasSize = Enum.AutomaticSize.None
	v28.ScrollingDirection = v36
	v29.FillDirection = v34
	v29.HorizontalAlignment = v35

	if not (v38 and v37) then
		return
	end

	v38.PaddingLeft = v37
end
v7 = function(p1) --[[ SetCategory | Line: 4710 | Upvalues: v6 (ref), v1 (ref), v4 (ref), v5 (copy), v15 (ref), Loading (ref), v28 (ref), v3 (ref) ]]
	if ActiveFuseSelectionState and ActiveFuseSelectionState.AllowedCategories[p1] ~= true then
		p1 = ActiveFuseSelectionState.PreferredCategory
	end

	if v6 == p1 then
		updateCategoryLabel(p1)
	else
		v6 = p1
		applyCategoryLayout()

		if v1 and v1.Text ~= "" then
			if v4 then
				v4()
			end

			v1.Text = ""
		end

		if p1 ~= v5 and v15 then
			setFavoriteModeActive(false)
		end

		if Loading and p1 ~= v5 then
			Loading.Visible = false
		end

		refreshFavoriteModeVisibility()
		updateCategoryLabel(p1)

		if v28 then
			v28.CanvasPosition = Vector2.new(0, 0)
		end

		v3()
	end

	updateCategorySelectionVisuals()
end

local CategoryFrame = v25:WaitForChild("CategoryFrame")
local CategoryTemplate = CategoryFrame.CategoryTemplate

if not CategoryFrame:FindFirstChildWhichIsA("UIGridLayout") then
	CategoryFrame:FindFirstChildWhichIsA("UIListLayout")
end

function createHintForCategory(p1, p2) --[[ createHintForCategory | Line: 4747 ]]
	local v1, v2, v3 = p1:ToHSV()

	return Color3.fromHSV(v1, v2, (math.clamp(v3 + p2, 0, 1)))
end

for v81, v82 in t do
	local v83 = v82.Name
	local v84 = CategoryTemplate:Clone()
	local ImageButton = v84.ImageButton
	local CategoryName = v84:FindFirstChild("CategoryName")

	if CategoryName and CategoryName:IsA("TextLabel") then
		CategoryName.Text = v83
	end

	local BackgroundColor32 = v84.BackgroundColor3
	local v85 = TweenService:Create(v84, TweenInfo.new(0.2), {
		BackgroundColor3 = createHintForCategory(BackgroundColor32, 0.2)
	})
	local v86 = TweenService:Create(v84, TweenInfo.new(0.2), {
		BackgroundColor3 = BackgroundColor32
	})

	ImageButton.MouseEnter:Connect(function() --[[ Line: 4767 | Upvalues: v85 (copy) ]]
		v85:Play()
	end)
	ImageButton.MouseLeave:Connect(function() --[[ Line: 4770 | Upvalues: v86 (copy) ]]
		v86:Play()
	end)
	ImageButton.MouseButton1Down:Connect(function() --[[ Line: 4773 | Upvalues: v86 (copy) ]]
		v86:Play()
	end)
	ImageButton.MouseButton1Up:Connect(function() --[[ Line: 4776 | Upvalues: v85 (copy), v7 (ref), v83 (copy) ]]
		v85:Play()
		v7(v83)
	end)

	local UIStroke = v84.UIStroke

	assert(UIStroke:IsA("UIStroke"), "Category button UIStroke must be a UIStroke")
	UIStroke.Enabled = false
	t25[v83] = UIStroke
	t26[v83] = v84
	ImageButton.Image = v82.Image
	v84.Visible = true
	v84.Parent = CategoryFrame
end

f80()
updateCategoryLabel(v6)
updateCategorySelectionVisuals()
refreshFavoriteModeVisibility()
v27 = NewGui("TextButton", "VRInventorySelector")
v27.Position = UDim2.new(0, 0, 0, 0)
v27.Size = UDim2.new(1, 0, 1, 0)
v27.BackgroundTransparency = 1
v27.Text = ""
v27.Parent = v25

local v88 = NewGui("ImageLabel", "Selector")

v88.Size = UDim2.new(1, 0, 1, 0)
v88.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v88.ScaleType = Enum.ScaleType.Slice
v88.SliceCenter = Rect.new(12, 12, 52, 52)
v88.Visible = false
v27.SelectionImageObject = v88
v27.MouseButton1Click:Connect(function() --[[ Line: 4806 ]]
	vrMoveSlotToInventory()
end)
v28 = v25:WaitForChild("ScrollingFrame")

local UIGridLayout = v28:WaitForChild("UIGridLayout")
local v89 = v28:FindFirstChildWhichIsA("UIPadding")

v30 = AutoGridLayout(v28, t5)

local v91 = UIGridLayout:FindFirstChildWhichIsA("UIAspectRatioConstraint") or v28:FindFirstChildWhichIsA("UIAspectRatioConstraint")

if v91 then
	local AspectRatio = v91.AspectRatio
end

local ScrollingDirection = v28.ScrollingDirection

if v89 then
	local PaddingLeft = v89.PaddingLeft
end

if v20 then
	UIGridLayout.CellSize = UDim2.new(UIGridLayout.CellSize.X.Scale, UIGridLayout.CellSize.X.Offset, UIGridLayout.CellSize.Y.Scale, UIGridLayout.CellSize.Y.Offset / 2)
end

local CellSize = UIGridLayout.CellSize

applyCategoryLayout()

local v92 = createScrollButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v92.Size = UDim2.new(0, 34, 0, 34)
v92.Position = UDim2.new(0.5, -v92.Size.X.Offset / 2, 0, 43)
v92.Icon.Position = v92.Icon.Position - UDim2.new(0, 0, 0, 2)
v92.MouseButton1Click:Connect(function() --[[ Line: 4845 | Upvalues: v28 (ref), v21 (copy) ]]
	v28.CanvasPosition = Vector2.new(v28.CanvasPosition.X, (math.min(v28.CanvasSize.Y.Offset - v28.AbsoluteWindowSize.Y, (math.max(0, v28.CanvasPosition.Y - (v21 + 5))))))
end)

local v93 = createScrollButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v93.Rotation = 180
v93.Icon.Position = v93.Icon.Position - UDim2.new(0, 0, 0, 2)
v93.Size = UDim2.new(0, 34, 0, 34)
v93.Position = UDim2.new(0.5, -v93.Size.X.Offset / 2, 1, -v93.Size.Y.Offset - 3)
v93.MouseButton1Click:Connect(function() --[[ Line: 4862 | Upvalues: v28 (ref), v21 (copy) ]]
	v28.CanvasPosition = Vector2.new(v28.CanvasPosition.X, (math.min(v28.CanvasSize.Y.Offset - v28.AbsoluteWindowSize.Y, (math.max(0, v28.CanvasPosition.Y + (v21 + 5))))))
end)
v28.Changed:Connect(function(p1) --[[ Line: 4873 | Upvalues: v28 (ref), v92 (ref), v93 (ref) ]]
	if p1 ~= "AbsoluteWindowSize" and (p1 ~= "CanvasPosition" and p1 ~= "CanvasSize") then
		return
	end

	local v1 = if v28.CanvasPosition.Y < v28.CanvasSize.Y.Offset - v28.AbsoluteWindowSize.Y then true else false

	v92.Visible = v28.CanvasPosition.Y ~= 0
	v93.Visible = v1
end)
ResizeContainers()

local v94 = Utility:Create("Frame")
local t27 = {
	Name = "GamepadHintsFrame",
	BackgroundTransparency = 1,
	Visible = false
}
local v95 = UDim2.new
local Offset = v24.Size.X.Offset

t27.Size = v95(0, Offset, 0, if v17 then 95 else 60)
t27.Parent = v22

local v99 = v94(t27)

function createHint(p1, p2, p3) --[[ createHint | Line: 4894 | Upvalues: v99 (ref), v17 (copy) ]]
	local v1 = Utility:Create("Frame")({
		Name = "HintFrame",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -5),
		Position = UDim2.new(0, 0, 0, 0),
		Parent = v99
	})
	local v2 = Utility:Create("ImageLabel")
	local t = {
		Name = "HintImage",
		BackgroundTransparency = 1
	}

	t.Size = v17 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60)
	t.Image = if v17 and p2 then p2 else p1
	t.Parent = v1
	v2(t)

	local v5 = Utility:Create("TextLabel")
	local t2 = {
		Name = "HintText",
		BackgroundTransparency = 1,
		TextWrapped = true
	}

	t2.Position = UDim2.new(0, if v17 then 100 else 70, 0, 0)
	t2.Size = UDim2.new(1, -(if v17 then 100 else 70), 1, 0)
	t2.Font = Enum.Font.SourceSansBold
	t2.FontSize = v17 and Enum.FontSize.Size36 or Enum.FontSize.Size24
	t2.Text = p3
	t2.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	t2.TextXAlignment = Enum.TextXAlignment.Left
	t2.Parent = v1

	local v13 = v5(t2)

	Instance.new("UITextSizeConstraint", v13).MaxTextSize = v13.TextSize
end
function PositionHintFrame() --[[ PositionHintFrame | Line: 4924 | Upvalues: v99 (ref), v24 (ref), v17 (copy), v25 (ref) ]]
	v99.Size = UDim2.new(v24.Size.X.Scale, v24.Size.X.Offset, 0, if v17 then 95 else 60)
	v99.Position = UDim2.new(v24.Position.X.Scale, v24.Position.X.Offset, v25.Position.Y.Scale, v25.Position.Y.Offset - v99.Size.Y.Offset)

	local v5 = v99:GetChildren()
	local sum = 0

	for i = 1, #v5 do
		v5[i].Size = UDim2.new(1, 0, 1, -5)
		v5[i].Position = UDim2.new(0, 0, 0, 0)
		sum = sum + (v5[i].HintText.Position.X.Offset + v5[i].HintText.TextBounds.X)
	end

	local v6 = (v99.AbsoluteSize.X - sum) / (#v5 - 1)

	for j = 1, #v5 do
		v5[j].Position = j == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v5[j - 1].Position.X.Offset + v5[j - 1].Size.X.Offset + v6, 0, 0)
		v5[j].Size = UDim2.new(0, v5[j].HintText.Position.X.Offset + v5[j].HintText.TextBounds.X, 1, -5)
	end
end
createHint("rbxasset://textures/ui/Settings/Help/XButtonDark.png", "rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png", "Remove From Hotbar ")
createHint("rbxasset://textures/ui/Settings/Help/AButtonDark.png", "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png", "Select/Swap")
createHint("rbxasset://textures/ui/Settings/Help/BButtonDark.png", "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png", "Close Backpack")

local Search = v25:WaitForChild("Search")

v1 = Search:WaitForChild("TextBox")
v1.ClearTextOnFocus = false
v1.TextXAlignment = Enum.TextXAlignment.Left
CloseButton = v25:FindFirstChild("Close")

if CloseButton and CloseButton:IsA("GuiButton") then
	ButtonFX(CloseButton, nil, function() --[[ Line: 4968 | Upvalues: v25 (ref), t3 (copy) ]]
		if not v25.Visible then
			return
		end

		t3.OpenClose()
	end)
end

local v100 = Search:FindFirstChild("StrokeTemplate") or (Search:FindFirstChildWhichIsA("UIStroke") or script.StrokeTemplate:Clone())

v100.Enabled = false
v100.Parent = Search
task.spawn(function() --[[ Line: 4979 | Upvalues: v100 (copy), TweenService (copy) ]]
	while true do
		repeat
			task.wait()
		until v100.Enabled

		local v1 = TweenService:Create(v100.UIGradient, TweenInfo.new(0.05), {
			Rotation = v100.UIGradient.Rotation + 1
		})

		v1:Play()
		v1.Completed:Wait()
	end
end)

local v101 = Search:FindFirstChild("X") or Search:FindFirstChild("ClearSearch") or Search:WaitForChild("X")

v101.Visible = false
function PerformSearch() --[[ PerformSearch | Line: 4995 | Upvalues: v1 (ref), v51 (copy), t7 (copy), v25 (ref), v48 (ref), v28 (ref), v101 (copy) ]]
	if v1.Text == "" then
		ResetSearchResults()

		return
	end

	local t = {}

	for v12 in v1.Text:gmatch("%S+") do
		t[v12:lower()] = true
	end

	local list = {}

	for i = v51 + 1, #t7 do
		local v2 = t7[i]

		if v2 and v2.Tool then
			if IsOfCategory(v2.Tool) then
				table.insert(list, { v2, v2:CheckTerms(t) })
				v2.Frame.Visible = false
				pcall(function() --[[ Line: 5018 | Upvalues: v2 (copy), v25 (ref) ]]
					v2.Frame.Parent = v25
				end)

				continue
			end

			v2.Frame.Visible = false
		end
	end

	table.sort(list, function(p1, p2) --[[ Line: 5023 ]]
		return p1[2] > p2[2]
	end)
	v48 = true

	local count = 0

	for i, v in ipairs(list) do
		local v3 = v[1]

		if v[2] > 0 then
			v3.Frame.Visible = true
			v3.Frame.Parent = v28
			v3.Frame.LayoutOrder = v51 + count
			count = count + 1

			continue
		end

		v3.Frame.Visible = false
	end

	UpdateScrollingFrameCanvasSize()
	v101.ZIndex = 2000
end
v3 = PerformSearch
function ResetSearchResults() --[[ ResetSearchResults | Line: 5044 | Upvalues: v48 (ref), v51 (copy), t7 (copy), v28 (ref), v101 (copy) ]]
	v48 = false

	for i = v51 + 1, #t7 do
		local v1 = t7[i]

		if v1 and v1.Tool then
			if IsOfCategory(v1.Tool) then
				v1.Frame.Parent = v28
				v1.Frame.Visible = true

				continue
			end

			v1.Frame.Visible = false
		end
	end

	v101.ZIndex = 0
	UpdateInventorySlots()
end

local v102 = ResetSearchResults

function ClearSearchText() --[[ ClearSearchText | Line: 5062 | Upvalues: v1 (ref) ]]
	ResetSearchResults()
	v1.Text = ""
end
function OnSearchTextChanged(p1) --[[ OnSearchTextChanged | Line: 5066 | Upvalues: v1 (ref), v101 (copy), v100 (copy) ]]
	if p1 ~= "Text" then
		return
	end

	PerformSearch()

	local isNotText = v1.Text ~= ""

	v101.Visible = isNotText
	v100.Enabled = isNotText
end
function OnSearchFocusLost(p1) --[[ OnSearchFocusLost | Line: 5074 ]]
	if not p1 then
		return
	end

	PerformSearch()
end
v101.MouseButton1Click:Connect(ClearSearchText)
v1.Changed:Connect(OnSearchTextChanged)
v1.FocusLost:Connect(OnSearchFocusLost)
t3.StateChanged.Event:Connect(function(p1) --[[ Line: 5082 | Upvalues: v25 (ref), v41 (copy) ]]
	if p1 or v25.Visible then
		return
	end

	v41:deselect()
end)
function OnEscapePressed(p1) --[[ OnEscapePressed | Line: 5087 | Upvalues: v25 (ref), v41 (copy) ]]
	if p1 then
		return
	end

	if ActiveFuseSelectionState then
		return
	end

	if not v25.Visible then
		return
	end

	v41:deselect()
end
function OnFavoritePressed() --[[ OnFavoritePressed | Line: 5096 ]]
	if ActiveFuseSelectionState then
		return
	end

	if not SelectedSlot then
		return
	end

	local Tool = SelectedSlot.Tool

	if not Tool then
		return
	end

	requestFavoriteToggle(Tool)
end
t9[Enum.KeyCode.Escape.Value] = OnEscapePressed
t9[Enum.KeyCode.ButtonL2.Value] = OnFavoritePressed
UserInputService.LastInputTypeChanged:Connect(function(p1) --[[ Line: 5112 | Upvalues: Search (copy) ]]
	if p1 == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
		Search.Visible = false
	end
end)
GuiService.MenuOpened:Connect(function() --[[ Line: 5121 | Upvalues: v25 (ref), v41 (copy) ]]
	if not v25.Visible then
		return
	end

	v41:deselect()
end)
function RemoveSlotAction(p1, p2, p3) --[[ RemoveSlotAction | Line: 5126 | Upvalues: GuiService (copy), v51 (copy), t7 (copy), v102 (ref) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	if not GuiService.SelectedObject then
		return
	end

	for i = 1, v51 do
		if t7[i].Frame == GuiService.SelectedObject and t7[i].Tool then
			t7[i]:MoveToInventory()
			v102()

			return
		end
	end

	v102()
end
function setInventoryVisibility(p1) --[[ setInventoryVisibility | Line: 5144 | Upvalues: v25 (ref), v24 (ref), v51 (copy), t7 (copy), v49 (ref), t4 (copy), v99 (ref), t3 (copy), v16 (ref), v13 (ref), v15 (ref) ]]
	v25.Visible = p1
	AdjustHotbarFrames()
	v24.Active = not p1

	for i = 1, v51 do
		t7[i]:SetClickability(not p1)
	end

	if v25.Visible then
		if v49 then
			if t4[UserInputService:GetLastInputType()] then
				PositionHintFrame()
				v99.Visible = not UserInputService.VREnabled
			end

			enableGamepadInventoryControl()
		end
	else
		if v49 then
			v99.Visible = false
		end

		disableGamepadInventoryControl()
	end

	if v25.Visible then
		ContextActionService:BindAction("RBXRemoveSlot", RemoveSlotAction, false, Enum.KeyCode.ButtonX)
	else
		ContextActionService:UnbindAction("RBXRemoveSlot")
	end

	t3.IsOpen = v25.Visible
	t3.StateChanged:Fire(v25.Visible)

	if v25.Visible then
		return
	end

	local v1

	if ActiveFuseSelectionState and v16 then
		v16(false)
		v1 = true
	else
		v1 = false
	end

	if v1 then
		return
	end

	v13 = nil

	if not v15 then
		return
	end

	setFavoriteModeActive(false)
end
function t3.OpenClose() --[[ OpenClose | Line: 5192 | Upvalues: v25 (ref), t3 (copy), t10 (copy) ]]
	if ActiveFuseSelectionState then
		if v25.Visible then
			setInventoryVisibility(false)
		else
			t3.IsOpen = v25.Visible
		end
	elseif not next(t10) then
		setInventoryVisibility(not v25.Visible)
	end
end
function setFuseSelectionSlotClickability(p1) --[[ setFuseSelectionSlotClickability | Line: 5209 | Upvalues: t7 (copy) ]]
	for v1, v2 in t7 do
		if v2 and v2.Tool then
			v2:SetClickability(not p1)
		end
	end
end
function captureFuseHotbarSnapshot() --[[ captureFuseHotbarSnapshot | Line: 5217 | Upvalues: v51 (copy), t7 (copy) ]]
	local t = {}

	for i = 1, v51 do
		local v1 = t7[i]
		local v2 = if v1 then v1.Tool else v1

		if v1 and (not v1.IsFakeSlot and (typeof(v2) == "Instance" and (v2:IsA("Tool") and isAssetTool(v2)))) then
			t[i] = v2
		end
	end

	return t
end
function moveFuseHotbarAssetsToInventory() --[[ moveFuseHotbarAssetsToInventory | Line: 5231 | Upvalues: v51 (copy), t7 (copy) ]]
	for i = 1, v51 do
		local v1 = t7[i]

		if v1 and (not v1.IsFakeSlot and (v1.Tool and isAssetTool(v1.Tool))) then
			v1:MoveToInventory()
		end
	end
end
function restoreFuseHotbarSnapshot(p1) --[[ restoreFuseHotbarSnapshot | Line: 5240 | Upvalues: v51 (copy), t7 (copy), t8 (copy) ]]
	local t = {}

	for v1, v2 in p1 do
		if typeof(v2) == "Instance" and (v2:IsA("Tool") and v2.Parent) then
			t[v2] = v1
		end
	end

	for i = 1, v51 do
		local v3 = t7[i]

		if v3 and (not v3.IsFakeSlot and (v3.Tool and (isAssetTool(v3.Tool) and not t[v3.Tool]))) then
			v3:MoveToInventory()
		end
	end

	for v4, v5 in p1 do
		if typeof(v5) == "Instance" and (v5:IsA("Tool") and v5.Parent) then
			local v6 = t7[v4]
			local v7 = t8[v5]

			if v6 and (not v6.IsFakeSlot and (v7 and (not v7.IsFakeSlot and (v7.Tool == v5 and v6 ~= v7)))) then
				if v6.Tool then
					v6:MoveToInventory()
				end

				v7:Swap(v6)
			end
		end
	end
end
function stopFuseSelectionVisuals() --[[ stopFuseSelectionVisuals | Line: 5279 ]]
	if not FuseSelectionVisualTrove then
		refreshInventoryFrameVisuals()

		return
	end

	FuseSelectionVisualTrove:Clean()
	FuseSelectionVisualTrove = nil
	refreshInventoryFrameVisuals()
end
function startFuseSelectionVisuals() --[[ startFuseSelectionVisuals | Line: 5288 | Upvalues: Trove (copy), RunService (copy) ]]
	stopFuseSelectionVisuals()

	if InventoryStroke then
		FuseSelectionVisualTrove = Trove.new()

		local v1 = 0

		FuseSelectionVisualTrove:Add(RunService.Heartbeat:Connect(function(p1) --[[ Line: 5298 | Upvalues: v1 (ref) ]]
			if ActiveFuseSelectionState then
				v1 = v1 + p1 * 3

				local v2 = (math.sin(v1) + 1) / 2

				InventoryStroke.Color = FUSE_SELECTION_STROKE_COLOR:Lerp(Color3.fromRGB(255, 255, 255), v2)
			end
		end))
		refreshInventoryFrameVisuals()
	else
		refreshInventoryFrameVisuals()
	end
end
function t3.StartMachineSelection(p1, p2, p3, p4, p5, p6) --[[ StartMachineSelection | Line: 5310 | Upvalues: v6 (ref), v15 (ref), v1 (ref), v102 (ref), v14 (ref), v59 (ref), v60 (ref), v48 (ref), f80 (ref), v7 (ref) ]]
	assert(if type(p2) == "string" then true else false, "Expected machine selection item type to be a string")
	assert(if type(p3) == "function" then true else false, "Expected fuse selection callback to be a function")
	assert(if type(p6) == "string" then true else false, "Expected preferred category to be a string")

	if ActiveFuseSelectionState then
		p1:EndFuseSelection()
	end

	ActiveFuseSelectionState = {
		AllowedCategories = p5,
		ItemType = p2,
		PreviousCategory = v6,
		PreviousFavoriteModeActive = v15,
		PreferredCategory = p6,
		HotbarSnapshot = captureFuseHotbarSnapshot()
	}
	p1:RequestSelection(p2, p3, false, false, p4)

	if v15 then
		setFavoriteModeActive(false)
	end

	if v1 and v1.Text ~= "" then
		if v102 then
			v102()
		end

		v1.Text = ""
	end

	if v14 then
		v14.Visible = false

		if v59 then
			v59.Visible = false
		end

		if v60 then
			v60.Visible = false
		end
	end

	if v48 and v102 then
		v102()
	end

	if v1 and v1.Text ~= "" then
		v1.Text = ""
	end

	f80()
	updateEquipBestButtonVisibility()
	v7(p6)

	if p2 ~= "Asset" then
		AdjustHotbarFrames()
		setInventoryVisibility(true)
		setFuseSelectionSlotClickability(false)
		UpdateInventorySlots()
		startFuseSelectionVisuals()
		OnIconChanged(BackpackEnabled)

		return true
	end

	moveFuseHotbarAssetsToInventory()
	AdjustHotbarFrames()
	setInventoryVisibility(true)
	setFuseSelectionSlotClickability(false)
	UpdateInventorySlots()
	startFuseSelectionVisuals()
	OnIconChanged(BackpackEnabled)

	return true
end

local function f103(p1) --[[ Line: 5380 | Upvalues: v13 (ref), v14 (ref), v59 (ref), v60 (ref), f80 (ref), v7 (ref) ]]
	local v1 = ActiveFuseSelectionState

	if not v1 then
		return
	end

	ActiveFuseSelectionState = nil
	stopFuseSelectionVisuals()
	v13 = nil

	if p1 then
		setInventoryVisibility(false)
	end

	setFuseSelectionSlotClickability(true)

	if CloseButton then
		CloseButton.Active = true
		CloseButton.Visible = true
	end

	if v14 then
		v14.Visible = false

		if v59 then
			v59.Visible = false
		end

		if v60 then
			v60.Visible = false
		end
	end

	f80()

	if v1.ItemType == "Asset" then
		restoreFuseHotbarSnapshot(v1.HotbarSnapshot)
	end

	v7(v1.PreviousCategory)
	refreshFavoriteModeVisibility()

	if v1.PreviousFavoriteModeActive then
		setFavoriteModeActive(true)
	else
		refreshInventoryFrameVisuals()
	end

	UpdateInventorySlots()
	OnIconChanged(BackpackEnabled)
	updateEquipBestButtonVisibility()
end

function t3.EndFuseSelection(p1) --[[ EndFuseSelection | Line: 5424 | Upvalues: f103 (ref) ]]
	f103(true)
end
function t3.StartFuseSelection(p1, p2, p3) --[[ StartFuseSelection | Line: 5428 ]]
	return p1:StartMachineSelection("Asset", p2, p3, {
		[FUSE_SELECTION_ASSET_CATEGORY_NAME] = true
	}, FUSE_SELECTION_ASSET_CATEGORY_NAME)
end
function t3.IsFuseSelectionActive(p1) --[[ IsFuseSelectionActive | Line: 5434 ]]
	return ActiveFuseSelectionState ~= nil
end
CoreCall("SetCoreGuiEnabled", Enum.CoreGuiType.Backpack, false)

while not LocalPlayer do
	wait()
	LocalPlayer = Players.LocalPlayer
end

LocalPlayer.CharacterAdded:Connect(SetupCharacter)

if LocalPlayer.Character then
	SetupCharacter(LocalPlayer.Character)
end

local function handleLocalActiveAssetRecords(p1) --[[ handleLocalActiveAssetRecords | Line: 5448 ]]
	refreshPlacedAssetUIDs(p1)

	if not clearPlacedAssetBackpackSlots(p1) or syncAssetsFromSave() then
		reconcileVirtualAssetEquipState()

		return
	end

	AdjustHotbarFrames()
	UpdateInventorySlots()
	reconcileVirtualAssetEquipState()
end

refreshPlacedAssetUIDs(AssetCmds.GetOwnerRuntimeRecords(LocalPlayer.UserId))
AssetCmds.RuntimeOwnerUpdated:Connect(function(p1, p2) --[[ Line: 5461 | Upvalues: LocalPlayer (ref), handleLocalActiveAssetRecords (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	handleLocalActiveAssetRecords(p2)
end)
AssetCmds.RuntimeOwnerCleared:Connect(function(p1) --[[ Line: 5467 | Upvalues: LocalPlayer (ref), handleLocalActiveAssetRecords (copy) ]]
	if p1 ~= LocalPlayer.UserId then
		return
	end

	handleLocalActiveAssetRecords({})
end)
task.spawn(function() --[[ Line: 5473 | Upvalues: t17 (ref), t22 (ref), v56 (ref), v57 (ref) ]]
	if Save.IsLocalDataLoaded() then
		syncAssetsFromSave()
		syncEggsFromSave()
		reconcileVirtualAssetEquipState()
		reconcileVirtualEggEquipState()
		t17 = captureEligibleAssetUIDs()
		t22 = captureEggUIDs()
		v56 = true
		v57 = true

		return
	end

	Save.LoadedStats:Wait()
	syncAssetsFromSave()
	syncEggsFromSave()
	reconcileVirtualAssetEquipState()
	reconcileVirtualEggEquipState()
	t17 = captureEligibleAssetUIDs()
	t22 = captureEggUIDs()
	v56 = true
	v57 = true
end)
Save.ConnectForDataChanged({ "Inventory", "AssetFavoriteCategories" }, function() --[[ Line: 5488 | Upvalues: v56 (ref), t17 (ref) ]]
	local v1 = captureEligibleAssetUIDs()

	if v56 then
		queueNewEligibleAssetsForHotbar(t17, v1)
	end

	t17 = v1
	v56 = true
	syncAssetsFromSave()
	reconcileVirtualAssetEquipState()
	movePendingHotbarAssets()
end)
Save.ConnectForDataChanged({ "EquippedAssets", "BaseUpgradeLevel", "Rebirth", "Gamepasses", "Products" }, function() --[[ Line: 5500 ]]
	syncAssetsFromSave()
	reconcileVirtualAssetEquipState()
end)
Save.ConnectForDataChanged("EggInventory", function() --[[ Line: 5505 | Upvalues: v57 (ref), t22 (ref) ]]
	local v1 = captureEggUIDs()

	if v57 then
		queueNewEggsForHotbar(t22, v1)
	end

	t22 = v1
	v57 = true
	syncEggsFromSave()
	reconcileVirtualEggEquipState()
	movePendingHotbarEggs()
end)
EggCmds.RuntimeSnapshotUpdated:Connect(function() --[[ Line: 5517 ]]
	syncEggsFromSave()
	reconcileVirtualEggEquipState()
end)
PlotCmds.OnLocalPlotUpdated:Connect(function() --[[ Line: 5522 ]]
	invalidateEquipBestStatus(true)
end)
PlotCmds.OnPlotsFolderUpdated:Connect(function() --[[ Line: 5525 ]]
	invalidateEquipBestStatus(true)
end)
UserInputService.InputBegan:Connect(HandleInputBegan)
UserInputService.TextBoxFocused:Connect(function() --[[ Line: 5530 | Upvalues: v47 (ref) ]]
	v47 = true
end)
UserInputService.TextBoxFocusReleased:Connect(function() --[[ Line: 5533 | Upvalues: v47 (ref) ]]
	v47 = false
end)
t9[Backspace] = function() --[[ Line: 5536 | Upvalues: Humanoid (ref) ]]
	if not Humanoid then
		return
	end

	UnequipAllTools()
end
UserInputService.Changed:Connect(OnInputServiceChanged)
OnInputServiceChanged("KeyboardEnabled")

if not UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	UserInputService.GamepadConnected:Connect(function(p13) --[[ Line: 5546 ]]
		if p13 ~= Enum.UserInputType.Gamepad1 then
			return
		end

		gamepadConnected()
	end)
	UserInputService.GamepadDisconnected:Connect(function(p13) --[[ Line: 5551 ]]
		if p13 ~= Enum.UserInputType.Gamepad1 then
			return
		end

		gamepadDisconnected()
	end)
	function t3.RequestSelection(p13, p23, p33, p43, p53, p63) --[[ RequestSelection | Line: 5556 | Upvalues: v13 (ref) ]]
		local t2 = {
			ItemType = p23,
			Callback = p33
		}

		t2.AllowHotbar = if p43 == true then true else false
		t2.Preserve = if p53 == true then true else false
		t2.Validator = p63
		v13 = t2
	end
	function t3.ClearSelectionRequest(p13) --[[ ClearSelectionRequest | Line: 5571 | Upvalues: v13 (ref) ]]
		v13 = nil
	end
	function t3.SetCategory(p13, p23) --[[ SetCategory | Line: 5574 | Upvalues: v7 (ref) ]]
		v7(p23)
	end
	function t3.OpenInventory(p13) --[[ OpenInventory | Line: 5577 | Upvalues: t3 (copy) ]]
		if t3.IsOpen then
			return
		end

		t3.OpenClose()
	end
	function t3.SetBackpackEnabled(p13, p23) --[[ SetBackpackEnabled | Line: 5582 ]]
		BackpackEnabled = p23
	end
	function t3.IsOpened(p13) --[[ IsOpened | Line: 5585 | Upvalues: t3 (copy) ]]
		return t3.IsOpen
	end
	function t3.GetBackpackEnabled(p13) --[[ GetBackpackEnabled | Line: 5588 ]]
		return BackpackEnabled
	end
	function t3.GetCategory(p13) --[[ GetCategory | Line: 5591 | Upvalues: v6 (ref) ]]
		return v6
	end
	function t3.RefreshInventory(p13) --[[ RefreshInventory | Line: 5594 | Upvalues: v3 (ref) ]]
		if v3 then
			v3()
		else
			UpdateInventorySlots()
		end
	end
	function t3.GetStateChangedEvent(p13) --[[ GetStateChangedEvent | Line: 5602 | Upvalues: t3 (copy) ]]
		return t3.StateChanged.Event
	end
	function t3.ForceEggIntoTutorialHotbar(p13, p23) --[[ ForceEggIntoTutorialHotbar | Line: 5606 | Upvalues: t18 (copy), t21 (copy), t20 (copy), t7 (copy), v3 (ref) ]]
		local v1 = t18[p23] or findVirtualEggSlotByUID(p23)

		if not v1 or v1.IsDeleted then
			t21[p23] = true

			return nil
		end

		t20[p23] = nil
		t21[p23] = nil

		local v2 = t7[4]

		assert(if v2 then not v2.IsFakeSlot else v2, "Tutorial egg hotbar slot 4 must be available")
		assert(canToolUseHotbarSlot(v1.Tool, 4), "Tutorial egg must be insertable in slot 4")

		if v2.Tool and v2 ~= v1 then
			v2:MoveToInventory()
		end

		if v1 ~= v2 then
			v1:Swap(v2)
		end

		t18[p23] = v2
		AdjustHotbarFrames()
		UpdateInventorySlots()

		if v3 then
			v3(true)
		end

		if reconcileVirtualEggEquipState() ~= p23 then
			v2:Select()
		end

		return v2.Frame
	end
	function t3.GetEggSlotFrame(p13, p23) --[[ GetEggSlotFrame | Line: 5642 | Upvalues: t18 (copy) ]]
		local v1 = t18[p23] or findVirtualEggSlotByUID(p23)

		if v1 == nil or v1.IsDeleted then
			return nil
		end

		return v1.Frame
	end
	RunService.Heartbeat:Connect(function() --[[ Line: 5653 | Upvalues: ToolGameplayGuard (copy), v46 (ref), v68 (ref), v66 (ref), v65 (ref) ]]
		OnIconChanged(BackpackEnabled)

		local v1 = ToolGameplayGuard.IsLocalPlayerInGameplayArea()

		if v1 and not v46 then
			ensureGameplayGearHotbarSlots()
		end

		v46 = v1

		local v2 = isLocalPlayerWithinOwnPlotBounds()

		if v68 == v2 then
			if v68 and (v66 or not v65) then
				requestEquipBestStatusRefresh()
			else
				updateEquipBestButtonVisibility()
			end
		else
			v68 = v2

			if v2 then
				requestEquipBestStatusRefresh(true)
			else
				updateEquipBestButtonVisibility()
			end
		end
	end)
	ApiEvent.Event:Connect(function(p13, p23) --[[ Line: 5678 | Upvalues: t3 (copy) ]]
		if p13 == "SetBackpackEnabled" then
			t3:SetBackpackEnabled(p23)

			return
		end

		if p13 == "SetInventoryOpen" then
			if type(p23) == "boolean" and p23 == true then
				t3.IsOpen = true

				return
			end

			if type(p23) == "boolean" then
				t3.IsOpen = false
			end
		else
			if p13 ~= "ToggleBackpack" then
				return
			end

			t3.OpenClose()
		end
	end)

	return t3
end

gamepadConnected()
UserInputService.GamepadConnected:Connect(function(p13) --[[ Line: 5546 ]]
	if p13 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadConnected()
end)
UserInputService.GamepadDisconnected:Connect(function(p13) --[[ Line: 5551 ]]
	if p13 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadDisconnected()
end)
function t3.RequestSelection(p13, p23, p33, p43, p53, p63) --[[ RequestSelection | Line: 5556 | Upvalues: v13 (ref) ]]
	local t2 = {
		ItemType = p23,
		Callback = p33
	}

	t2.AllowHotbar = if p43 == true then true else false
	t2.Preserve = if p53 == true then true else false
	t2.Validator = p63
	v13 = t2
end
function t3.ClearSelectionRequest(p13) --[[ ClearSelectionRequest | Line: 5571 | Upvalues: v13 (ref) ]]
	v13 = nil
end
function t3.SetCategory(p13, p23) --[[ SetCategory | Line: 5574 | Upvalues: v7 (ref) ]]
	v7(p23)
end
function t3.OpenInventory(p13) --[[ OpenInventory | Line: 5577 | Upvalues: t3 (copy) ]]
	if t3.IsOpen then
		return
	end

	t3.OpenClose()
end
function t3.SetBackpackEnabled(p13, p23) --[[ SetBackpackEnabled | Line: 5582 ]]
	BackpackEnabled = p23
end
function t3.IsOpened(p13) --[[ IsOpened | Line: 5585 | Upvalues: t3 (copy) ]]
	return t3.IsOpen
end
function t3.GetBackpackEnabled(p13) --[[ GetBackpackEnabled | Line: 5588 ]]
	return BackpackEnabled
end
function t3.GetCategory(p13) --[[ GetCategory | Line: 5591 | Upvalues: v6 (ref) ]]
	return v6
end
function t3.RefreshInventory(p13) --[[ RefreshInventory | Line: 5594 | Upvalues: v3 (ref) ]]
	if v3 then
		v3()
	else
		UpdateInventorySlots()
	end
end
function t3.GetStateChangedEvent(p13) --[[ GetStateChangedEvent | Line: 5602 | Upvalues: t3 (copy) ]]
	return t3.StateChanged.Event
end
function t3.ForceEggIntoTutorialHotbar(p13, p23) --[[ ForceEggIntoTutorialHotbar | Line: 5606 | Upvalues: t18 (copy), t21 (copy), t20 (copy), t7 (copy), v3 (ref) ]]
	local v1 = t18[p23] or findVirtualEggSlotByUID(p23)

	if not v1 or v1.IsDeleted then
		t21[p23] = true

		return nil
	end

	t20[p23] = nil
	t21[p23] = nil

	local v2 = t7[4]

	assert(if v2 then not v2.IsFakeSlot else v2, "Tutorial egg hotbar slot 4 must be available")
	assert(canToolUseHotbarSlot(v1.Tool, 4), "Tutorial egg must be insertable in slot 4")

	if v2.Tool and v2 ~= v1 then
		v2:MoveToInventory()
	end

	if v1 ~= v2 then
		v1:Swap(v2)
	end

	t18[p23] = v2
	AdjustHotbarFrames()
	UpdateInventorySlots()

	if v3 then
		v3(true)
	end

	if reconcileVirtualEggEquipState() ~= p23 then
		v2:Select()
	end

	return v2.Frame
end
function t3.GetEggSlotFrame(p13, p23) --[[ GetEggSlotFrame | Line: 5642 | Upvalues: t18 (copy) ]]
	local v1 = t18[p23] or findVirtualEggSlotByUID(p23)

	if v1 == nil or v1.IsDeleted then
		return nil
	end

	return v1.Frame
end
RunService.Heartbeat:Connect(function() --[[ Line: 5653 | Upvalues: ToolGameplayGuard (copy), v46 (ref), v68 (ref), v66 (ref), v65 (ref) ]]
	OnIconChanged(BackpackEnabled)

	local v1 = ToolGameplayGuard.IsLocalPlayerInGameplayArea()

	if v1 and not v46 then
		ensureGameplayGearHotbarSlots()
	end

	v46 = v1

	local v2 = isLocalPlayerWithinOwnPlotBounds()

	if v68 == v2 then
		if v68 and (v66 or not v65) then
			requestEquipBestStatusRefresh()
		else
			updateEquipBestButtonVisibility()
		end
	else
		v68 = v2

		if v2 then
			requestEquipBestStatusRefresh(true)
		else
			updateEquipBestButtonVisibility()
		end
	end
end)
ApiEvent.Event:Connect(function(p13, p23) --[[ Line: 5678 | Upvalues: t3 (copy) ]]
	if p13 == "SetBackpackEnabled" then
		t3:SetBackpackEnabled(p23)

		return
	end

	if p13 == "SetInventoryOpen" then
		if type(p23) == "boolean" and p23 == true then
			t3.IsOpen = true

			return
		end

		if type(p23) == "boolean" then
			t3.IsOpen = false
		end
	else
		if p13 ~= "ToggleBackpack" then
			return
		end

		t3.OpenClose()
	end
end)

return t3