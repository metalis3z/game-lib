-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

if not game:IsLoaded() then
	game.Loaded:Wait()
end
local v1, v2, v3, v4
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiService = game:GetService("GuiService")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")
local Areas = require(ReplicatedStorage.Data.Areas)
local HotbarEggOffers = require(ReplicatedStorage.Data.HotbarEggOffers)
require(ReplicatedStorage.Client.AutoGridLayout)
local GUI = require(ReplicatedStorage.Client.GUI)
local HiddenUIHandler = require(ReplicatedStorage.Client.HiddenUIHandler)
local Message = require(ReplicatedStorage.Client.Notifications.Message)
local PlotState = require(ReplicatedStorage.Client.PlotState)
local Tabs = require(ReplicatedStorage.Client.Tabs)

RarityDirectory = require(ReplicatedStorage.Data.Rarity).Rarities
MutationHandler = require(ReplicatedStorage.Shared.Modules.Mutations)
InfoOverlay = require(ReplicatedStorage.Client.InfoOverlay)

local ClientGlobals = require(ReplicatedStorage.Client.ClientGlobals)

ButtonHintStrip = require(ReplicatedStorage.Client.ButtonHintStrip)
PlatformSignal = require(ReplicatedStorage.Client.PlatformSignals)
ButtonFX = require(ReplicatedStorage.Client.UI.VFX.ButtonFX)
SimpleNumber = require(ReplicatedStorage.Packages.FormatNumber.Simple)

local AssetEarnings = require(ReplicatedStorage.Shared.Util.AssetEarnings)
local AssetIconShape = require(ReplicatedStorage.Client.UI.AssetIconShape)
local AssetItems = require(ReplicatedStorage.Shared.Util.AssetItems)
require(ReplicatedStorage.Shared.Globals.Constants)
local EggRecords = require(ReplicatedStorage.Shared.Util.EggRecords)
local EggState = require(ReplicatedStorage.Client.EggState)
local PromptPurchase = require(ReplicatedStorage.Client.Functions.PromptPurchase)
local ItemDisplay = require(ReplicatedStorage.Shared.Modules.ItemDisplay)
local WarmAssets = require(ReplicatedStorage.Shared.Utils.Warmup).WarmAssets
require(ReplicatedStorage.Shared.Remotes)
require(ReplicatedStorage.Shared.Save)
local ToolGameplayGuard = require(ReplicatedStorage.Client.ToolGameplayGuard)
require(ReplicatedStorage.Shared.Flags.TreadmillFlags)
local Trove = require(ReplicatedStorage.Packages.Trove)
local v5 = {
	{
		Name = "Pets",
		Image = "rbxassetid://93714449004895",
		Tags = { "Asset", "Phone" }
	},
	{
		Name = "Eggs",
		Image = "rbxassetid://116524274262912",
		Tags = { "AssetEgg", "PetEgg" }
	}
}
local v6, v7

if v5[1] then
	local Name = v5[1].Name
	v6 = Name
	v7 = Name
else
	v6 = "Pets"
	v7 = "Pets"
end
local v8
local v9 = GuiService:IsTenFootInterface()
local v10 = v9

if not v9 then
	v10 = RunService:IsStudio()
end
local v11 = {}
for v12, v13 in v5 do
	v11[v13.Name] = v13
end

function IsOfCategory(v14) -- line 77 | captures: v7, HotbarEggOffers, v11
	if v14 then
		if HotbarEggOffers.ByUid[getAttribute(v14, "UID")] then
			return true
		end
		local v15 = v11[v7]
		if v15 and v15.Tags then
			for v16, v17 in v15.Tags do
				if v14:GetAttribute("ItemType") == v17 then
					return true
				end
			end
		end
	end
	return false
end

function GetCategory(v19) -- line 99 | captures: v6, v11
	for v20, v21 in v11 do
		if v21.Tags then
			for v22, v23 in v21.Tags do
				if v19:GetAttribute("ItemType") == v23 then
					return v20
				end
			end
		end
	end
	return v6
end

local v24 = {
	IsOpen = false,
	ModuleName = "Backpack",
	KeepVRTopbarOpen = true,
	VRIsExclusive = true,
	VRClosesNonExclusive = true,
	StateChanged = Instance.new("BindableEvent")
}
local v25 = 60

TextSizeAttribute = script:GetAttribute("TextSize")
_BackgroundTransparencyAttribute = script:GetAttribute("BackgroundTransparency")
BackgroundColorAttribute = script:GetAttribute("BackgroundColor")
DraggableColorAttribute = script:GetAttribute("DraggableColor")
EquippedColorAttribute = script:GetAttribute("EquippedColor")
SlotLockedTransparencyAttribute = script:GetAttribute("SlotLockedTransparency")
BorderColorAttribute = script:GetAttribute("BorderColor")
ToggleHotkeys = {
	Enum.KeyCode.Backquote,
	Enum.KeyCode.ButtonSelect
}
EmptySlotsAttribute = script:GetAttribute("EmptySlots")
_SearchBoxColorAttribute = script:GetAttribute("SearchBoxColor")
_SearchBoxTransparencyAttribute = script:GetAttribute("SearchBoxTransparency")
ApiEvent = ReplicatedStorage:FindFirstChild("Api") or script:WaitForChild("Api")
ApiEvent.Parent = ReplicatedStorage
SelectedSlot = nil
BackpackEnabled = true

local v26

ActiveFuseSelectionState = nil

function GetViewportSize() -- line 149
	local v27 = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	local v28 = Instance.new("Frame", v27)
	v28.BackgroundTransparency = 1
	v28.Size = UDim2.new(1, 0, 1, 0)
	local ViewportSize = v28.AbsoluteSize
	v27:Destroy()
	return ViewportSize
end

local Value = Enum.KeyCode.Zero.Value
local Value_2 = Enum.KeyCode.Backspace.Value
local v29 = {}

v29[Enum.UserInputType.Gamepad1] = true
v29[Enum.UserInputType.Gamepad2] = true
v29[Enum.UserInputType.Gamepad3] = true
v29[Enum.UserInputType.Gamepad4] = true
v29[Enum.UserInputType.Gamepad5] = true
v29[Enum.UserInputType.Gamepad6] = true
v29[Enum.UserInputType.Gamepad7] = true
v29[Enum.UserInputType.Gamepad8] = true
UserInputService = game:GetService("UserInputService")
Players = game:GetService("Players")
PlayerGui = Players.LocalPlayer.PlayerGui
BackpackGui = PlayerGui:WaitForChild("BackpackGui")
ContextActionService = game:GetService("ContextActionService")
VRService = game:GetService("VRService")
Utility = require(script.Utility)
require(script.GameTranslator)
TopBarPlus = require(ReplicatedStorage.Packages.TopBarPlus)

local function tryCore(v30, ...) -- line 177 | captures: RunService, StarterGui
	for v31 = 1, 8 do
		local v32 = table.pack(pcall(StarterGui[v30], StarterGui, ...))
		if v32[1] then
			local n = v32.n
			return true, table.unpack(v32, 2, n)
		end
		RunService.RenderStepped:Wait()
	end
	return false, nil
end

local Save = require(ReplicatedStorage.Shared.Save)
local Remotes = require(ReplicatedStorage.Shared.Remotes)
local AssetItems_2 = require(ReplicatedStorage.Shared.Util.AssetItems)

AssetDirectoryModule = require(ReplicatedStorage.Data.Assets)
AssetDirectory = AssetDirectoryModule.Directory
BaseAssetConfig = AssetDirectoryModule.BaseConfig

local Gears = require(ReplicatedStorage.Data.Gears)

TryLock = require(ReplicatedStorage.Shared.Utils.TryLock)
Audio = require(ReplicatedStorage.Shared.Audio)

local Constants = require(ReplicatedStorage.Shared.Globals.Constants)
local AssetRoster = require(ReplicatedStorage.Client.AssetRoster)
local v33
local v34 = false

CloseButton = nil
InventoryStroke = nil
InventoryStrokeDefaultColor = nil
FuseSelectionVisualTrove = nil
FUSE_SELECTION_ASSET_CATEGORY_NAME = "Pets"
FUSE_SELECTION_BACKGROUND_COLOR = Color3.fromRGB(0, 255, 255)
FUSE_SELECTION_STROKE_COLOR = Color3.fromRGB(0, 183, 186)
FUSE_SELECTION_BACKGROUND_TRANSPARENCY = 0

local v35

local function v18() -- line 212 | captures: HiddenUIHandler
	return not BackpackEnabled or not BackpackGui.Enabled or HiddenUIHandler.IsHidden()
end

local v36 = GuiService:IsTenFootInterface()
local v37

if v36 then
	v25 = 100
	TextSizeAttribute = 24
	v37 = 100
else
	v37 = 60
end
local v38 = false
local v39 = UserInputService.TouchEnabled and GetViewportSize().X < 1024
local v40 = v37 * 1.5
local LocalPlayer = Players.LocalPlayer
local LocalPlayer_2 = LocalPlayer
local v41, v42, v43, v44
local v45 = Color3.fromRGB(79, 63, 0)
local v46, v47, v48, v49, v50, AspectRatio, v51, v52, v53, PaddingLeft, v54
local v55 = { ScalePaddingOffset = true }

if v39 then
	v55.PerRow = 5
else
	v55.PerRow = 6
end
v55.Padding = UDim2.fromScale(0.02, 0.04)

local Character = LocalPlayer.Character
local v56 = Character

if not Character then
	Character = LocalPlayer.CharacterAdded:Wait()
	v56 = Character
end
local v57 = Character:FindFirstChildOfClass("Humanoid")
local v58 = LocalPlayer:WaitForChild("Backpack")
local v59 = TopBarPlus.new()
v59:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected")
v59:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected")
for v60, v61 in ToggleHotkeys do
	v59:bindToggleKey(v61)
end
v59:setName("InventoryIcon")
v59:setImageScale(1.12)
v59:setOrder(-5)
v59:setCaption("Toggle the backpack.")
v59.deselectWhenOtherIconSelected = false

local v62 = {}
local v63
local v64 = {}
local v65 = {}
local v66 = {}
local v67 = 0
local v68 = true
local v69 = false
local v70 = false
local v71 = false
local v72 = false
local v73 = false
local v74 = {}
local v75 = {}
local v76 = false
local v77 = 0
local VREnabled = VRService.VREnabled
local v78, v79

if VREnabled then
	v78 = EmptySlotsAttribute
	v79 = 3
elseif v39 then
	v78 = 5
	v79 = 2
else
	v78 = 10
	v79 = 4
end
local v80 = TryLock()
local v81 = TryLock()
local v82
local v83 = {}
local v84 = {}
local v85 = {}
local v86 = {}
local v87 = {}
local v88 = {}
local v89 = false
local v90 = {}
local v91 = {}
local v92 = {}
local v93 = {}
local v94 = {}
local v95 = false
local v96, AutoSell, v97, v98
local v99 = TryLock()
local v100 = 0
local v101 = false
local v102 = false
local v103 = true
local v104 = false
local v105 = false
local v106 = 0
local Frame = GUI.AutoSell():WaitForChild("Frame"):WaitForChild("Frame")
local v107 = {}
local v108 = {}
local v109 = false
local Template = Frame.UIGridLayout.Template
local v110

function invokeBackpack(v111, ...) -- line 351
	local v112 = { ... }
	local v113, v114 = pcall(function() -- line 354 | captures: v111, v112
		return { v111:InvokeServer(unpack(v112)) }
	end)
	if v113 then
		return v114
	end
	warn((("[Backpack] Failed to invoke '%*': %*"):format(v111 and v111.Name or "?", v114)))
	return nil
end

function isLocalPlayerWithinOwnPlotBounds() -- line 373 | captures: LocalPlayer_2, v56, PlotState
	local v115 = PlotState.ResolvePlot()
	if v115 then
		local v116 = v56 or LocalPlayer_2.Character
		if v116 then
			local HumanoidRootPart = v116:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart and HumanoidRootPart:IsA("BasePart") then
				local v117, v118 = v115.PlotFolder:GetBoundingBox()
				local v119 = v117:PointToObjectSpace(HumanoidRootPart.Position)
				local v120 = v118 * 0.5
				local X = v119.X
				if math.abs(X) <= v120.X then
					local Z = v119.Z
					return math.abs(Z) <= v120.Z
				end
				return false
			end
		end
	end
	return false
end

function updateEquipBestButtonVisibility() -- line 401 | captures: v98
	if v98 then
		v98.Visible = false
	end
end

function requestEquipBestStatusRefresh(v121) -- line 407 | captures: v98, v101, v102, v103, v104, v105, v106, Remotes
	if not (v98 and v105) then
		updateEquipBestButtonVisibility()
	elseif not v104 then
		local v122 = workspace:GetServerTimeNow()
		if v121 == true then
			v106 = v122
			v104 = true
			task.spawn(function() -- line 419 | captures: v101, v102, v103, v104, Remotes
				local v123 = invokeBackpack(Remotes.Haul.FetchWearBestStatus)
				v104 = false
				if v123 then
					v101 = v123[1] == true
					v102 = true
					v103 = false
				end
				updateEquipBestButtonVisibility()
			end)
		elseif not (v122 - v106 < 0.5) then
			v106 = v122
			v104 = true
			task.spawn(function() -- line 440 | captures: v101, v102, v103, v104, Remotes
				local v124 = invokeBackpack(Remotes.Haul.FetchWearBestStatus)
				v104 = false
				if v124 then
					v101 = v124[1] == true
					v102 = true
					v103 = false
				end
				updateEquipBestButtonVisibility()
			end)
		end
	end
end

function invalidateEquipBestStatus(v125) -- line 454 | captures: v103, v105
	v103 = true
	if v105 then
		requestEquipBestStatusRefresh(v125)
	else
		updateEquipBestButtonVisibility()
	end
end

function showEquipBestDebounceNotification() -- line 462 | captures: Message
	Message.Bottom({
		Message = "Please wait a bit before equipping bests again!",
		Time = 2,
		Color = Color3.fromRGB(255, 170, 0)
	})
end

function requestEquipBest() -- line 465 | captures: v100, Remotes, v99
	if workspace:GetServerTimeNow() - v100 < 5 or
		not v99(function() -- line 472 | captures: v100, Remotes
			local v126 = workspace:GetServerTimeNow()
			if v126 - v100 >= 5 then
				v100 = v126
				local v127 = invokeBackpack(Remotes.Haul.WearBest)
				if v127 then
					local v128 = v127[2]
					if v127[1] then
						invalidateEquipBestStatus(true)
					elseif v128 == "DEBOUNCE" or v128 == "LOCKED" then
						showEquipBestDebounceNotification()
					end
				end
			else
				showEquipBestDebounceNotification()
			end
		end) then
		showEquipBestDebounceNotification()
	end
end

function applyAutoSellSlot(v129, v130) -- line 503 | captures: v107
	local v131 = v107[v129]
	if not v131 then
		return
	end
	local SelectedGradient = v131.SelectedGradient
	if SelectedGradient then
		SelectedGradient.Enabled = v130
	end
	local RarityGradient = v131.RarityGradient
	if RarityGradient then
		RarityGradient.Enabled = not v130
	end
end

function applyAutoSellMap(v132) -- line 517 | captures: v108, v107
	v108 = {}
	for v133, v134 in pairs(v132) do
		if v134 then
			v108[v133] = true
		end
	end
	for v135 in pairs(v107) do
		local v136 = v108[v135] == true
		applyAutoSellSlot(v135, v136)
	end
end

function serializeAutoSellState() -- line 530 | captures: v108
	local v137 = {}
	for v138, v139 in pairs(v108) do
		if v139 then
			v137[v138] = true
		end
	end
	return v137
end

function pushAutoSellState() -- line 539 | captures: Remotes
	local v140 = invokeBackpack(Remotes.Haul.WriteAutoSell, (serializeAutoSellState()))
	if v140 then
		local v141 = v140[2]
		if v140[1] then
			if typeof(v141) == "table" then
				applyAutoSellMap(v141)
			end
			return true
		end
		if typeof(v141) == "string" then
			warn((("[Backpack] Failed to update auto-sell: %*"):format(v141)))
		end
	end
	return false
end

function buildAutoSellSlots(v142) -- line 556 | captures: v108, v109, v107, Template
	local v143 = {}
	for v144, v145 in pairs(AssetDirectory) do
		local Rarity = v145.Rarity
		if Rarity then
			local _id = Rarity._id
			if typeof(_id) == "string" then
				v143[_id] = Rarity
			end
		end
	end
	local v146 = {}
	for v147, v148 in pairs(v143) do
		table.insert(v146, v148)
	end
	table.sort(v146, function(v149, v150) -- line 572
		local RarityNumber = v149.RarityNumber
		local v151 = if typeof(RarityNumber) == "number" then v149.RarityNumber else 0
		local RarityNumber_2 = v150.RarityNumber
		local v152 = if typeof(RarityNumber_2) == "number" then v150.RarityNumber else 0
		if v151 == v152 then
			local DisplayName = v149.DisplayName
			local v153 = if typeof(DisplayName) == "string" then v149.DisplayName else v149._id
			local DisplayName_2 = v150.DisplayName
			return v153 < (typeof(DisplayName_2) == "string" and v150.DisplayName or v150._id)
		end
		return v151 < v152
	end)
	local TextLabel
	for v154, v155 in ipairs(v146) do
		local _id = v155._id
		if not v107[_id] then
			local v156 = Template:Clone()
			v156.Visible = true
			v156.Name = _id
			local RarityNumber = v155.RarityNumber
			if typeof(RarityNumber) == "number" then
				v156.LayoutOrder = v155.RarityNumber
			else
				v156.LayoutOrder = 0
			end
			local TextButton = v156.TextButton
			local Selected = TextButton.Selected
			if Selected then
				if Selected:IsA("UIGradient") then
					Selected.Enabled = false
				end
			else
				Selected = nil
			end
			local TextLabel_2 = v156:FindFirstChild("TextLabel")
			if TextLabel_2 then
				if TextLabel_2:IsA("TextLabel") then
					TextLabel = TextLabel_2
				end
			else
				TextLabel = nil
			end
			if TextLabel then
				local DisplayName = v155.DisplayName
				if typeof(DisplayName) == "string" then
					if DisplayName ~= "" then
						TextLabel.Text = DisplayName
					end
				else
					TextLabel.Text = _id
				end
			end
			v156.Parent = v142
			local RarityGradient = v155.RarityGradient
			local v157
			if typeof(RarityGradient) == "Instance" then
				v157 = RarityGradient:Clone()
				v157.Name = "RarityGradient"
				v157.Parent = TextButton
			end
			for v158, v159 in ipairs(TextButton:GetChildren()) do
				if v159:IsA("UIGradient") then
					if v159 == v157 then
						v159.Enabled = true
					else
						v159.Enabled = false
					end
				end
			end
			v107[_id] = {
				Button = TextButton,
				SelectedGradient = Selected,
				RarityGradient = v157
			}
			ButtonFX(TextButton, nil, function() -- line 657 | captures: _id, v108, v109
				if v109 then
					return
				end
				local v160 = v108[_id] == true
				local v161 = not v160
				v108[_id] = v161
				applyAutoSellSlot(_id, v161)
				v109 = true
				if not pushAutoSellState() then
					v108[_id] = v160
					applyAutoSellSlot(_id, v160)
				end
				v109 = false
			end)
		end
	end
end

function initializeAutoSellUI() -- line 675 | captures: AutoSell, Tabs, Remotes, Frame
	ButtonFX(AutoSell, nil, function() -- line 676 | captures: Tabs
		Tabs.Toggle("AutoSell")
	end)
	local v162 = {}
	local v163 = invokeBackpack(Remotes.Haul.FetchAutoSell)
	if v163 then
		local v164 = v163[1]
		if typeof(v164) == "table" then
			for v165, v166 in pairs(v164) do
				if v166 then
					v162[v165] = true
				end
			end
		end
	end
	buildAutoSellSlots(Frame)
	applyAutoSellMap(v162)
end

function claimLowestEmptySlot(v167) -- line 694 | captures: v78, v63, v62
	local v168 = v63
	if not (v168 and canToolUseHotbarSlot(v167, v168.Index)) then
		return nil
	end
	local v169 = v78
	local v170
	for v171 = 1, v169 do
		v170 = v62[v171]
		if v170 and v170 ~= v168 and not v170.Tool and not v170.IsFakeSlot and canToolUseHotbarSlot(v167, v171) then
			break
		end
		v170 = nil
	end
	v63 = v170
	return v168
end

function getInsertableHotbarIndices(v172) -- line 714 | captures: v78, v62
	local v173 = {}
	local v174 = v78
	for v175 = 1, v174 do
		local v176 = v62[v175]
		if v176 and not v176.IsFakeSlot and canToolUseHotbarSlot(v172, v175) then
			table.insert(v173, v175)
		end
	end
	return v173
end

function insertToolIntoFrontHotbar(v177) -- line 728 | captures: v63, v62
	local v178 = getInsertableHotbarIndices(v177)
	local v179 = v178[1]
	if v179 then
		local v180 = v62[v179]
		if v180 then
			if v180.Tool then
				if getLockedHotbarSlotForTool(v177) == v179 and canToolUseHotbarSlot(v180.Tool, v179) then
					return nil
				end
			else
				local v181 = v63
				if v181 then
					local v182 = table.find(v178, v181.Index)
					if v182 then
						for v183 = v182, 2, -1 do
							local v184 = v62[v178[v183]]
							local v185 = v62[v178[v183 - 1]]
							if v184 and v185 then
								v185:Swap(v184)
							end
						end
						v180:Fill(nil)
						return v180
					end
				else
					local v186 = v178[#v178]
					local v187 = v186 and v62[v186]
					if v187 and v187.Tool then
						v187:MoveToInventory()
					end
					local v188 = #v178
					for v189 = v188, 2, -1 do
						local v190 = v62[v178[v189]]
						local v191 = v62[v178[v189 - 1]]
						if v190 and v191 then
							v191:Swap(v190)
						end
					end
					v180:Fill(nil)
					return v180
				end
			end
			return
		end
	end
	return nil
end

function _getAssetUID(v192) -- line 783
	if typeof(v192) == "table" and (v192.IsVirtualAsset or v192.IsVirtualEgg) then
		return v192.UID
	end
	if typeof(v192) == "Instance" then
		return v192:GetAttribute("UID")
	end
	return nil
end

function getAttribute(v193, v194) -- line 798
	if v193 then
		if typeof(v193) == "table" then
			if v193.GetAttribute or typeof(v193) == "Instance" then
				return v193:GetAttribute(v194)
			end
		elseif typeof(v193) == "Instance" then
			return v193:GetAttribute(v194)
		end
	end
	return nil
end

function applyPromptBrainrotHotbarStroke(v195, v196) -- line 813 | captures: ReplicatedStorage, HotbarEggOffers
	if not v195 then
		return
	end
	local StrokeFrame = v195:FindFirstChild("StrokeFrame")
	local v197 = if not (StrokeFrame and StrokeFrame:IsA("GuiObject")) then v195 else StrokeFrame
	local PromptBrainrotHotBarStroke = v197:FindFirstChild("PromptBrainrotHotBarStroke")
	local PromptBrainrotHotBarStroke_2 = v195:FindFirstChild("PromptBrainrotHotBarStroke")
	if PromptBrainrotHotBarStroke_2 and PromptBrainrotHotBarStroke_2 ~= PromptBrainrotHotBarStroke then
		PromptBrainrotHotBarStroke_2:Destroy()
	end
	if HotbarEggOffers.ByUid[getAttribute(v196, "UID")] ~= nil and getAttribute(v196, "IsPromptOnly") == true then
		if StrokeFrame and StrokeFrame:IsA("GuiObject") then
			StrokeFrame.Visible = true
			StrokeFrame.BackgroundTransparency = 1
			StrokeFrame.ZIndex = 35
			StrokeFrame.Size = UDim2.fromScale(1, 1)
			StrokeFrame.Position = UDim2.fromScale(0.5, 0.5)
			StrokeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			for v198, v199 in ipairs(StrokeFrame:GetChildren()) do
				if v199:IsA("UIStroke") and v199.Name ~= "PromptBrainrotHotBarStroke" then
					v199.Enabled = false
				end
			end
		end
		if PromptBrainrotHotBarStroke then
			PromptBrainrotHotBarStroke.Enabled = true
			PromptBrainrotHotBarStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			PromptBrainrotHotBarStroke.Transparency = 0
			local Thickness = PromptBrainrotHotBarStroke.Thickness
			PromptBrainrotHotBarStroke.Thickness = math.max(Thickness, 8)
		else
			local HotBarStroke = ReplicatedStorage:FindFirstChild("HotBarStroke")
			local v200 = HotBarStroke and HotBarStroke:FindFirstChild("Stroke")
			if v200 then
				local v201 = v200:Clone()
				v201.Name = "PromptBrainrotHotBarStroke"
				v201.Enabled = true
				v201.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				v201.Transparency = 0
				local Thickness = v201.Thickness
				v201.Thickness = math.max(Thickness, 8)
				v201.Parent = v197
			end
		end
	else
		if PromptBrainrotHotBarStroke then
			PromptBrainrotHotBarStroke:Destroy()
		end
		if StrokeFrame and StrokeFrame:IsA("GuiObject") then
			StrokeFrame.Visible = false
		end
	end
end

function parseMutations(v202) -- line 867
	if typeof(v202) == "table" then
		return table.clone(v202)
	end
	if typeof(v202) == "string" then
		local v203 = {}
		for v204 in string.gmatch(v202, "[^,]+") do
			local v205 = string.match(v204, "^%s*(.-)%s*$")
			if v205 ~= "" then
				table.insert(v203, v205)
			end
		end
		return v203
	end
	return {}
end

function isAssetUIDFavorite(v206) -- line 884 | captures: Save, AssetItems_2
	local v207, v208
	if typeof(v206) == "string" then
		if v206 == "" then
			v208 = true
		else
			local v209 = Save.Get()
			v207 = v209 and v209.Inventory
			v208 = false
		end
	else
		v208 = true
	end
	if v208 then
		return false
	end
	local v210 = if typeof(v207) == "table" then v207[v206] else nil
	if typeof(v210) == "table" then
		return AssetItems_2.Decode(v210).IsFavorite == true
	end
	return false
end

function isToolFavorite(v211) -- line 905
	if isAssetTool(v211) then
		local Favorite = getAttribute(v211, "Favorite")
		if typeof(Favorite) == "boolean" then
			return Favorite
		end
		local ItemData = getAttribute(v211, "ItemData")
		if typeof(ItemData) == "table" and ItemData.IsFavorite == true then
			return true
		end
		return isAssetUIDFavorite(_getAssetUID(v211))
	end
	return getAttribute(v211, "Favorite") == true
end

function getAssetItemData(v212) -- line 924
	local ItemData = getAttribute(v212, "ItemData")
	if typeof(ItemData) == "table" then
		return ItemData
	end
	local Category = getAttribute(v212, "Category")
	if Category then
		local Scale = getAttribute(v212, "Scale")
		local v213 = {
			Category = Category,
			Mutations = parseMutations(getAttribute(v212, "Mutations")),
			BaseMutation = getAttribute(v212, "BaseMutation")
		}
		v213.Scale = typeof(Scale) == "number" and Scale or 1
		v213.IsFavorite = isAssetUIDFavorite(_getAssetUID(v212))
		return v213
	end
	return nil
end

function getAssetItemDisplayName(v214, v215) -- line 948 | captures: ItemDisplay
	if typeof(v214) == "table" then
		local Category = v214.Category
		if not (typeof(Category) == "string" and AssetDirectory[v214.Category]) then
			return
		end
		return ItemDisplay.GetNameFromItemData(v214)
	end
	return v215 and v215.DisplayName or "Asset"
end

function getAssetItemDisplayNameWithVisualWeight(v216, v217) -- line 985 | captures: AssetItems
	return (("%* (%*)"):format(getAssetItemDisplayName(v216, v217), (AssetItems.WeightLabel(v216))))
end

function isAssetTool(v218) -- line 989
	return getAttribute(v218, "ItemType") == "Asset"
end

function getGearName(v219) -- line 993
	local GearName = getAttribute(v219, "GearName")
	if typeof(GearName) == "string" then
		if GearName == "" then
			return nil
		end
		return GearName
	end
	return nil
end

function getGearConfig(v220) -- line 1003 | captures: Gears
	local v221 = getGearName(v220)
	if v221 then
		return Gears.Directory[v221]
	end
	return nil
end

function getGearUses(v222) -- line 1010
	local Uses = getAttribute(v222, "Uses")
	if typeof(Uses) == "number" then
		return (math.max(Uses, 0))
	end
	return 0
end

function shouldDisplayGearUses(v223) -- line 1017
	local v224 = getGearConfig(v223)
	if v224 then
		local ActiveDeploymentAttribute = v224.ActiveDeploymentAttribute
		if typeof(ActiveDeploymentAttribute) == "string" then
			return v224.ActiveDeploymentAttribute ~= ""
		end
	end
	return false
end

function getGearUsesText(v225) -- line 1025
	return (("x%*"):format((getGearUses(v225))))
end

function getHotbarFillTool(v226) -- line 1028
	if typeof(v226) == "table" and not v226.IsVirtualAsset and not v226.IsVirtualEgg then
		return v226
	end
	return v226
end

function virtualAssetMatchesUID(v227, v228) -- line 1034
	if typeof(v227) == "table" and v227.IsVirtualAsset and typeof(v228) == "string" then
		return v227.UID == v228
	end
	return false
end

function getVirtualAssetUID(v229) -- line 1041
	if typeof(v229) == "table" and v229.IsVirtualAsset then
		return v229.UID
	end
	return nil
end

function getVirtualEggUID(v230) -- line 1050
	if typeof(v230) == "table" and v230.IsVirtualEgg then
		return v230.UID
	end
	return nil
end

function virtualEggSlotMatchesUID(v231, v232) -- line 1059
	local v233, v234
	if v231 then
		if v231.IsDeleted then
			v234 = true
		else
			v233 = getVirtualEggUID(v231.Tool) == v232
			v234 = false
		end
	else
		v234 = true
	end
	if not v234 then
		return v233
	end
	return false
end

function findVirtualEggSlotByUID(v235) -- line 1066 | captures: v62
	for v236, v237 in pairs(v62) do
		if virtualEggSlotMatchesUID(v237, v235) then
			return v237
		end
	end
	return nil
end

function clearVirtualEggSlotsByUID(v238) -- line 1074 | captures: v78, v62
	local v239 = #v62
	for v240 = v239, 1, -1 do
		local v241 = v62[v240]
		if virtualEggSlotMatchesUID(v241, v238) then
			v241:Clear()
			if v78 < v241.Index then
				v241:Delete()
			end
		end
	end
end

function clearDuplicateVirtualEggSlotsByUID(v242, v243) -- line 1089 | captures: v78, v62
	local v244 = #v62
	for v245 = v244, 1, -1 do
		local v246 = v62[v245]
		if v246 ~= v243 and virtualEggSlotMatchesUID(v246, v242) then
			v246:Clear()
			if v78 < v246.Index then
				v246:Delete()
			end
		end
	end
end

function getRegisteredBackpackSlot(v247) -- line 1104 | captures: v64, v83, v90
	local v248 = getVirtualAssetUID(v247)
	if v248 then
		return v83[v248]
	end
	local v249 = getVirtualEggUID(v247)
	if v249 then
		return v90[v249]
	end
	return v64[v247]
end

function registeredSlotContainsTool(v250, v251) -- line 1115
	if not v250 or v250.IsDeleted then
		return false
	end
	local Tool = v250.Tool
	local v252 = getVirtualAssetUID(v251)
	if v252 then
		return getVirtualAssetUID(Tool) == v252
	end
	local v253 = getVirtualEggUID(v251)
	if v253 then
		return getVirtualEggUID(Tool) == v253
	end
	return Tool == v251
end

function unregisterVirtualBackpackSlot(v254, v255) -- line 1134 | captures: v83, v84, v90, v91
	local v256 = getVirtualAssetUID(v255)
	if v256 then
		if v83[v256] == v254 then
			v83[v256] = nil
		end
		if v84[v256] == v255 then
			v84[v256] = nil
		end
	end
	local v257 = getVirtualEggUID(v255)
	if v257 then
		if v90[v257] == v254 then
			v90[v257] = nil
		end
		if v91[v257] == v255 then
			v91[v257] = nil
		end
	end
end

function unregisterBackpackSlotTool(v258, v259) -- line 1150 | captures: v64
	unregisterVirtualBackpackSlot(v258, v259)
	if v259 and v64[v259] == v258 then
		v64[v259] = nil
	end
end

function registerVirtualBackpackSlot(v260, v261) -- line 1156 | captures: v83, v84, v90, v91
	local v262 = getVirtualAssetUID(v261)
	if v262 then
		v83[v262] = v260
		v84[v262] = v261
	end
	local v263 = getVirtualEggUID(v261)
	if v263 then
		v90[v263] = v260
		v91[v263] = v261
	end
end

function createVirtualAsset(v264, v265) -- line 1168 | captures: Save
	local Category = v265.Category
	local v266 = AssetDirectory[Category] or BaseAssetConfig
	local v267 = table.clone(v265)
	local v268 = getAssetItemDisplayName(v267, v266)
	local v269 = {
		IsVirtualAsset = true,
		ToolTip = "",
		UID = v264,
		Name = v268,
		TextureId = v266.Icon or ""
	}

	function v269.GetAttribute(v270, v271) -- line 1182 | captures: v264, Category, v267, v268, Save
		if v271 == "ItemType" then
			return "Asset"
		end
		if v271 == "UID" then
			return v264
		end
		if v271 == "Category" then
			return Category
		end
		if v271 == "DisplayName" then
			return v268
		end
		if v271 == "Mutations" then
			local v272 = v267.Mutations or {}
			return table.concat(v272, ", ")
		end
		if v271 == "BaseMutation" then
			return v267.BaseMutation
		end
		if v271 == "Scale" then
			return v267.Scale
		end
		if v271 == "ItemData" then
			return v267
		end
		if v271 == "Favorite" then
			local v273 = Save.Get()
			if v273 then
				local Inventory = v273.Inventory
				if typeof(Inventory) == "table" then
					return isAssetUIDFavorite(v264)
				end
			end
			return v267.IsFavorite == true
		end
		return nil
	end

	function v269.IsA(v274, v275) -- line 1226
		return v275 == "Tool"
	end

	return v269
end

function isAssetUIDPlaced(v276) -- line 1232 | captures: v85
	if typeof(v276) == "string" then
		return v85[v276] == true
	end
	return false
end

function hasLocalAssetToolUID(v277) -- line 1236
	return findAssetToolByUID(v277) ~= nil
end

function refreshPlacedAssetUIDs(v278) -- line 1240 | captures: v85
	local v279 = {}
	for v280 in pairs(v278) do
		if typeof(v280) == "string" then
			v279[v280] = true
		end
	end
	v85 = v279
end

function assetSignatureField(v281) -- line 1249
	if v281 == nil then
		return ""
	end
	return (tostring(v281))
end

function getAssetItemSignature(v282) -- line 1255
	local v283 = {}
	local v284 = assetSignatureField(v282.Category)
	local v285 = v282.Mutations or {}
	local v286 = table.concat(v285, ",")
	local v287 = assetSignatureField(v282.BaseMutation)
	local v288 = assetSignatureField(v282.Scale)
	local v289 = assetSignatureField(v282.Gender)
	local v290 = assetSignatureField(v282.EyeColor)
	local v291 = assetSignatureField(v282.ColorSeed)
	local v292 = assetSignatureField(v282.ColorIndex)
	local v293 = assetSignatureField(v282.GeneratedMoney)
	local v294 = assetSignatureField(v282.PendingEggName)
	local v295 = assetSignatureField(v282.Claimed)
	v283[1] = v284
	v283[2] = v286
	v283[3] = v287
	v283[4] = v288
	v283[5] = v289
	v283[6] = v290
	v283[7] = v291
	v283[8] = v292
	v283[9] = v293
	v283[10] = v294
	v283[11] = v295
	v283[12] = assetSignatureField(v282.HasBeenFirstPlaced)
	return table.concat(v283, "\031")
end

function buildEligibleAssetDataFromSave() -- line 1286 | captures: Save, AssetItems_2
	local v296 = Save.Get()
	local v297
	if v296 then
		local Inventory = v296.Inventory
		v297 = typeof(Inventory) == "table"
	end
	if not v296 or not v297 then
		return {}, {}
	end
	local v298 = {}
	local v299 = {}
	for v300, v301 in pairs(v296.Inventory) do
		if typeof(v300) == "string" and typeof(v301) == "table" then
			local v302 = AssetItems_2.Decode(v301)
			local v303 = v296.EquippedAssets or {}
			local v304 = table.find(v303, v300) ~= nil
			if v302.InFuse ~= true then
				if v304 then
					if hasLocalAssetToolUID(v300) then
					end
				elseif not isAssetUIDPlaced(v300) then
					v298[v300] = v302
					v299[v300] = getAssetItemSignature(v302)
				end
			end
		end
	end
	return v298, v299
end

function isSerializedAssetEligibleForBackpack(v305, v306) -- line 1315 | captures: Save, AssetItems_2
	if typeof(v306) == "table" then
		local v307 = AssetItems_2.Decode(v306)
		local v308 = Save.Get()
		local v309
		if v308 then
			local v310 = v308.EquippedAssets or {}
			v309 = table.find(v310, v305) ~= nil
		else
			v309 = v308
		end
		if v307.InFuse == true then
			return false
		end
		if v309 then
			return not (not hasLocalAssetToolUID(v305) or isAssetUIDPlaced(v305))
		end
		return not isAssetUIDPlaced(v305)
	end
	return false
end

function captureEligibleAssetUIDs() -- line 1343 | captures: Save
	local v311 = Save.Get()
	local v312 = {}
	local v313
	if v311 then
		local Inventory = v311.Inventory
		v313 = typeof(Inventory) == "table"
	end
	if v311 and v313 then
		for v314, v315 in pairs(v311.Inventory) do
			if typeof(v314) == "string" and isSerializedAssetEligibleForBackpack(v314, v315) then
				v312[v314] = true
			end
		end
	end
	return v312
end

function queueNewEligibleAssetsForHotbar(v316, v317) -- line 1356 | captures: v87
	for v318 in pairs(v317) do
		if v316[v318] ~= true then
			v87[v318] = true
		end
	end
end

function getEggConfigForRecord(v319) -- line 1363
	local v320 = typeof(v319) == "table"
	local v321
	if v320 then
		local AssetCategory = v319.AssetCategory
		v321 = typeof(AssetCategory) == "string"
	end
	if v320 and v321 then
		local v322 = AssetDirectory[v319.AssetCategory]
		if v322 then
			return v322.Egg, v322
		end
	end
	return nil, nil
end

function getAreaForEggRecord(v323) -- line 1373 | captures: Areas
	local v324, v325 = getEggConfigForRecord(v323)
	_ = v324
	local AssetCategory, v326
	if v325 and v325.Rarity then
		AssetCategory = v323.AssetCategory
		v326 = v325.Rarity._id or v325.Rarity.DisplayName
	else
		return nil
	end
	for v327, v328 in pairs(Areas.Directory) do
		for v329, v330 in ipairs(v328.DropTable) do
			local v331 = v330[1]
			if v331 == AssetCategory or v331 == v326 then
				return v328
			end
		end
	end
	return nil
end

function getEggDisplayName(v332) -- line 1395
	local v333 = MutationHandler.EggDisplayName(v332.Mutations, v332.BaseMutation)
	if v333 then
		return v333
	end
	local v334 = getAreaForEggRecord(v332)
	if v334 then
		return (("%* Egg"):format(v334.DisplayName))
	end
	return "Egg"
end

function getEggDisplayNameWithWeight(v335) -- line 1406 | captures: EggRecords
	return (("%* (%*)"):format(getEggDisplayName(v335), (EggRecords.WeightLabel(v335))))
end

function getEggIconForRecord(v336, v337) -- line 1410
	if typeof(v336) == "table" then
		local v338 = MutationHandler.EggIcon(v336.Mutations, v336.BaseMutation)
		if not v338 or v338 == "" then
			local v339 = v337 and v337.Icon
			if typeof(v339) == "string" then
				return v339
			end
			return ""
		end
		return v338
	end
	return v337 and v337.Icon or ""
end

function getEggRecordFromTool(v340) -- line 1431
	local EggRecord = getAttribute(v340, "EggRecord")
	if typeof(EggRecord) == "table" then
		return EggRecord
	end
	local v341 = getAttribute(v340, "AssetCategory") or getAttribute(v340, "Category")
	local v342 = getAttribute(v340, "AssetScale") or getAttribute(v340, "Scale")
	if not (typeof(v341) == "string" and typeof(v342) == "number") then
		return nil
	end
	return {
		AssetCategory = v341,
		AssetScale = v342,
		Mutations = parseMutations(getAttribute(v340, "Mutations")),
		BaseMutation = getAttribute(v340, "BaseMutation")
	}
end

function createVirtualEgg(v343, v344) -- line 1449 | captures: EggRecords
	local v345, v346 = getEggConfigForRecord(v344)
	local v347
	if v345 and v346 then
		v347 = v344.PromptDisplayName or getEggDisplayNameWithWeight(v344)
	else
		return nil
	end
	local v348 = EggRecords.WeightKg(v344)
	local v349 = {
		IsVirtualEgg = true,
		UID = v343,
		Name = v347,
		TextureId = v344.PromptIcon or getEggIconForRecord(v344, v345),
		ToolTip = v347
	}
	local v350 = v347

	function v349.GetAttribute(v351, v352) -- line 1464 | captures: v343, v344, v348, v350
		if v352 == "ItemType" then
			return "AssetEgg"
		end
		if v352 == "UID" then
			return v343
		end
		if v352 == "AssetCategory" or v352 == "Category" then
			return v344.AssetCategory
		end
		if v352 == "DisplayName" or v352 == "EggDisplayName" then
			return v350
		end
		if v352 == "EggRecord" then
			return table.clone(v344)
		end
		if v352 == "IsPromptOnly" then
			return v344.IsPromptOnly == true
		end
		if v352 == "PromptProductId" then
			return v344.PromptProductId
		end
		if v352 == "PromptIcon" then
			return v344.PromptIcon
		end
		if v352 == "Mutations" then
			local v353 = v344.Mutations or {}
			return table.concat(v353, ", ")
		end
		if v352 == "BaseMutation" then
			return v344.BaseMutation
		end
		if v352 == "Weight" or v352 == "WeightKg" then
			return v348
		end
		if v352 == "Favorite" then
			return false
		end
		return nil
	end

	function v349.IsA(v354, v355) -- line 1508
		return v355 == "Tool"
	end

	return v349
end

function buildVirtualEggsFromSave() -- line 1514 | captures: HotbarEggOffers, EggRecords, Save
	local function decoratePromptRecord(v356, v357) -- line 1515
		local v358 = table.clone(v356)
		v358.IsPromptOnly = true
		v358.PromptProductId = v357.ProductId
		v358.PromptDisplayName = v357.DisplayName
		v358.PromptIcon = AssetDirectory[v357.AssetCategory].Egg.Icon
		return v358
	end

	local v359 = Save.Get()
	local v360 = v359 and v359.EggInventory
	local v361 = {}
	for v362, v363 in ipairs(HotbarEggOffers.Offers) do
		local v364 = EggRecords.NewEgg(v363.AssetCategory)
		local v365 = table.clone(v364)
		v365.IsPromptOnly = true
		v365.PromptProductId = v363.ProductId
		v365.PromptDisplayName = v363.DisplayName
		v365.PromptIcon = AssetDirectory[v363.AssetCategory].Egg.Icon
		v361[v363.Uid] = createVirtualEgg(v363.Uid, v365)
	end
	if typeof(v360) == "table" then
		for v366, v367 in pairs(v360) do
			if typeof(v366) == "string" and typeof(v367) == "table" and v367.Placement == nil then
				local v368 = HotbarEggOffers.ByUid[v366]
				local v369
				if v368 then
					local v370 = table.clone(v367)
					v370.IsPromptOnly = true
					v370.PromptProductId = v368.ProductId
					v370.PromptDisplayName = v368.DisplayName
					v370.PromptIcon = AssetDirectory[v368.AssetCategory].Egg.Icon
					v369 = v370 or v367
				else
					v369 = v367
				end
				local v371 = createVirtualEgg(v366, v369)
				if v371 then
					v361[v366] = v371
				end
			end
		end
	end
	return v361
end

function captureEggUIDs() -- line 1545 | captures: Save
	local v372 = Save.Get()
	local v373 = v372 and v372.EggInventory
	local v374 = {}
	if typeof(v373) == "table" then
		for v375, v376 in pairs(v373) do
			if typeof(v375) == "string" and typeof(v376) == "table" and v376.Placement == nil then
				v374[v375] = true
			end
		end
	end
	return v374
end

function queueNewEggsForHotbar(v377, v378) -- line 1562 | captures: v92
	for v379 in pairs(v378) do
		if not v377[v379] then
			v92[v379] = true
		end
	end
end

function clearInstanceAssetSlots() -- line 1569 | captures: v78, v62
	local v380 = false
	for v381, v382 in pairs(v62) do
		if v382 then
			local Tool = v382.Tool
			if typeof(Tool) == "Instance" and Tool:IsA("Tool") and isAssetTool(Tool) then
				v382:Clear()
				if v78 < v382.Index then
					v382:Delete()
				end
				v380 = true
			end
		end
	end
	return v380
end

function clearPlacedAssetBackpackSlot(v383) -- line 1587 | captures: v78, v62, v83, v84, v86, v87
	v87[v383] = nil
	v86[v383] = nil
	local v384 = #v62
	local v385 = false
	for v386 = v384, 1, -1 do
		local v387 = v62[v386]
		if v387 then
			local Tool = v387.Tool
			if Tool and getAttribute(Tool, "ItemType") == "Asset" and _getAssetUID(Tool) == v383 then
				v387:Clear()
				if v78 < v387.Index then
					v387:Delete()
				end
				v385 = true
			end
		end
	end
	v83[v383] = nil
	v84[v383] = nil
	return v385
end

function clearPlacedAssetBackpackSlots(v388) -- line 1612
	local v389 = false
	for v390 in pairs(v388) do
		if typeof(v390) == "string" and clearPlacedAssetBackpackSlot(v390) then
			v389 = true
		end
	end
	return v389
end

function syncAssetsFromSave() -- line 1621 | captures: v78, v47, v83, v84, v86
	if v47 then
		local v391, v392 = buildEligibleAssetDataFromSave()
		local v393 = clearInstanceAssetSlots()
		for v394, v395 in pairs(v83) do
			if not v391[v394] then
				if v395 and not v395.IsDeleted then
					v395:Clear()
					if v78 < v395.Index then
						v395:Delete()
					end
				end
				v83[v394] = nil
				v86[v394] = nil
				v393 = true
			end
		end
		for v396, v397 in pairs(v391) do
			local v398 = v392[v396]
			local v399 = v83[v396]
			local v400 = v399 and not v399.IsDeleted and virtualAssetMatchesUID(v399.Tool, v396)
			if not v400 or v86[v396] ~= v398 then
				if not v400 then
					v399 = FindEmptyInventorySlot() or MakeSlot(v47)
				end
				v83[v396] = v399
				v84[v396] = createVirtualAsset(v396, v397)
				v86[v396] = v398
				v399:Fill(v84[v396])
				v393 = true
			elseif v399 then
				v84[v396] = v399.Tool
				v86[v396] = v398
				if v399.UpdateFavoriteVisual and v399:UpdateFavoriteVisual() then
					v393 = true
				end
			end
		end
		for v401 in pairs(v84) do
			if not v391[v401] then
				v84[v401] = nil
			end
		end
		if v393 then
			AdjustHotbarFrames()
			UpdateInventorySlots()
		end
		return v393
	end
	return false
end

function forcePromptEggHotbarSlots() -- line 1687 | captures: v78, v47, HotbarEggOffers, v62, v90
	for v402, v403 in ipairs(HotbarEggOffers.Offers) do
		local v404 = v90[v403.Uid] or findVirtualEggSlotByUID(v403.Uid)
		local v405 = v62[v403.Slot]
		if v404 and not v404.IsDeleted and v405 and not v405.IsFakeSlot and v404 ~= v405 and v404.Tool then
			local Tool = v404.Tool
			local Tool_2 = v405.Tool
			v404:Clear()
			v405:Clear()
			if Tool_2 then
				local Index = v404.Index
				if not (v78 < Index) then
					v404 = FindEmptyInventorySlot() or MakeSlot(v47)
				end
				v404:Fill(Tool_2)
			end
			v405:Fill(Tool)
			v90[v403.Uid] = v405
		end
	end
end

function syncEggsFromSave() -- line 1705 | captures: v47, v90, v91
	if not v47 then
		return
	end
	local v406 = buildVirtualEggsFromSave()
	for v407 in pairs(v90) do
		if not v406[v407] then
			clearVirtualEggSlotsByUID(v407)
			v90[v407] = nil
		end
	end
	for v408, v409 in pairs(v406) do
		local v410 = v90[v408]
		if not virtualEggSlotMatchesUID(v410, v408) then
			v410 = findVirtualEggSlotByUID(v408)
		end
		if v410 then
			if v410.IsDeleted then
			end
		else
			v410 = FindEmptyInventorySlot() or MakeSlot(v47)
		end
		v90[v408] = v410
		v91[v408] = v409
		clearDuplicateVirtualEggSlotsByUID(v408, v410)
		v410:Fill(v409)
	end
	for v411 in pairs(v91) do
		if not v406[v411] then
			v91[v411] = nil
		end
	end
	forcePromptEggHotbarSlots()
	ensureGameplayGearHotbarSlots()
	AdjustHotbarFrames()
	UpdateInventorySlots()
end

function getAssetRarityNumber(v412) -- line 1745
	local Category = getAttribute(v412, "Category")
	local v413 = if Category then AssetDirectory[Category] else BaseAssetConfig
	local v414 = v413 and v413.Rarity
	if v414 then
		if v414.RarityNumber then
			return v414.RarityNumber
		end
		if RarityDirectory[v414] and RarityDirectory[v414].RarityNumber then
			return RarityDirectory[v414].RarityNumber
		end
	end
	return (1/0)
end

function getAssetDropWeight(v415) -- line 1771
	local Category = getAttribute(v415, "Category")
	local v416 = Category and AssetDirectory[Category] or BaseAssetConfig
	if v416 then
		local DropWeight = v416.DropWeight
		if typeof(DropWeight) == "number" then
			return v416.DropWeight
		end
	end
	return (1/0)
end

function getAssetOddsDenominator(v417) -- line 1790
	if getAttribute(v417, "ItemType") == "Asset" then
		local Category = getAttribute(v417, "Category")
		local v418 = if Category then AssetDirectory[Category] else BaseAssetConfig
		local v419 = v418 and v418.DropWeight
		if typeof(v419) == "number" and not (v419 <= 0) then
			local v420 = getAssetItemData(v417)
			if v420 then
				return 1 / v419 * MutationHandler.RarityFactorFor(v420.Mutations, v420.BaseMutation)
			end
			return 0
		end
	end
	return 0
end

function getAssetEarningRate(v421) -- line 1814 | captures: AssetEarnings
	if getAttribute(v421, "ItemType") == "Asset" then
		local v422 = getAssetItemData(v421)
		if v422 then
			return AssetEarnings.MutationOnlyRatePerSecond(v422)
		end
	end
	return 0
end

function getEggAssetConfig(v423) -- line 1824
	local v424 = getEggRecordFromTool(v423)
	local v425, v426 = getEggConfigForRecord(v424)
	_ = v425
	if v426 then
		return v426
	end
	local v427 = getAttribute(v423, "AssetCategory") or getAttribute(v423, "Category")
	return v427 and AssetDirectory[v427] or nil
end

function getEggRarityNumber(v428) -- line 1845
	local v429 = getEggAssetConfig(v428)
	local v430 = v429 and v429.Rarity
	if v430 then
		if v430.RarityNumber then
			return v430.RarityNumber
		end
		if RarityDirectory[v430] and RarityDirectory[v430].RarityNumber then
			return RarityDirectory[v430].RarityNumber
		end
	end
	return (1/0)
end

function getEggBaseEarningRate(v431) -- line 1865
	local v432 = getEggAssetConfig(v431)
	if v432 then
		local EarningRate = v432.EarningRate
		if typeof(EarningRate) == "number" then
			return v432.EarningRate
		end
	end
	return 0
end

function requestFavoriteToggle(v433) -- line 1875 | captures: Remotes, v81
	if not ActiveFuseSelectionState and isAssetTool(v433) then
		local v434 = _getAssetUID(v433)
		if typeof(v434) == "string" and v434 ~= "" then
			local v435 = not isToolFavorite(v433)
			v81(function() -- line 1884 | captures: v434, v435, Remotes
				Remotes.PetSatchel.WriteFavourite:FireServer(v434, v435)
			end)
		end
	end
end

function getStackQuantity(v436) -- line 1888
	local StackQuantity = getAttribute(v436, "StackQuantity")
	if typeof(StackQuantity) == "number" and StackQuantity > 1 then
		return (math.floor(StackQuantity))
	end
	return 1
end

function clearMutationIconFrame(v437, v438) -- line 1898
	if v437 and v438 then
		for v439, v440 in ipairs(v437:GetChildren()) do
			if v440:IsA("ImageLabel") and v440 ~= v438 then
				v440:Destroy()
			end
		end
		v437.Visible = false
	end
end

function populateMutationIconFrame(v441, v442, v443, v444) -- line 1909
	if v441 and v442 then
		clearMutationIconFrame(v441, v442)
		v441.Visible = false
	end
end

function updateEquipSelectionVisuals() -- line 1916 | captures: v62
	for v445, v446 in pairs(v62) do
		if v446 then
			v446:UpdateEquipView()
		end
	end
end

function findVirtualAssetSlotContainingUID(v447) -- line 1923 | captures: v62
	for v448, v449 in pairs(v62) do
		if v449 and virtualAssetMatchesUID(v449.Tool, v447) then
			return v449
		end
	end
	return nil
end

function getCharacterAssetToolUID() -- line 1931 | captures: v56
	for v450, v451 in ipairs(v56:GetChildren()) do
		if v451:IsA("Tool") and v451:GetAttribute("ItemType") == "Asset" then
			local UID = v451:GetAttribute("UID")
			if typeof(UID) == "string" then
				return UID
			end
		end
	end
	return nil
end

function findAssetToolByUID(v452) -- line 1943 | captures: v56, v58
	local function searchContainer(v453) -- line 1944 | captures: v452
		if v453 then
			for v454, v455 in ipairs(v453:GetChildren()) do
				if v455:IsA("Tool") and v455:GetAttribute("ItemType") == "Asset" and v455:GetAttribute("UID") == v452 then
					return v455
				end
			end
		end
		return nil
	end

	return searchContainer(v56) or searchContainer(v58) or nil
end

function applyVirtualAssetEquipUID(v456) -- line 1969 | captures: v82
	v82 = v456
	if typeof(v456) == "string" then
		SelectedSlot = findVirtualAssetSlotContainingUID(v456)
	elseif SelectedSlot and getAttribute(SelectedSlot.Tool, "ItemType") == "Asset" then
		SelectedSlot = nil
	end
	updateEquipSelectionVisuals()
end

function reconcileVirtualAssetEquipState() -- line 1978 | captures: v82
	local v457 = getCharacterAssetToolUID()
	if v457 == v82 then
		if typeof(v457) == "string" and not SelectedSlot then
			SelectedSlot = findVirtualAssetSlotContainingUID(v457)
			updateEquipSelectionVisuals()
		end
	else
		applyVirtualAssetEquipUID(v457)
	end
	return v457
end

function syncVirtualAssetEquipStateFromTool(v458) -- line 1990 | captures: v56, v58, v82
	local UID = v458:GetAttribute("UID")
	if typeof(UID) == "string" then
		if v458.Parent == v56 then
			applyVirtualAssetEquipUID(UID)
		elseif v458.Parent == v58 and v82 == UID then
			task.defer(reconcileVirtualAssetEquipState)
		end
	end
end

function getCharacterEggToolUID() -- line 2003 | captures: v56
	for v459, v460 in ipairs(v56:GetChildren()) do
		if v460:IsA("Tool") and v460:GetAttribute("ItemType") == "AssetEgg" then
			local UID = v460:GetAttribute("UID")
			if typeof(UID) == "string" then
				return UID
			end
		end
	end
	return nil
end

function applyVirtualEggEquipUID(v461) -- line 2015 | captures: v96
	v96 = v461
	if typeof(v461) == "string" then
		SelectedSlot = findVirtualEggSlotByUID(v461)
	elseif SelectedSlot and getAttribute(SelectedSlot.Tool, "ItemType") == "AssetEgg" then
		SelectedSlot = nil
	end
	updateEquipSelectionVisuals()
end

function reconcileVirtualEggEquipState() -- line 2024 | captures: v96
	local v462 = getCharacterEggToolUID()
	if v462 == v96 then
		if typeof(v462) == "string" and not SelectedSlot then
			SelectedSlot = findVirtualEggSlotByUID(v462)
			updateEquipSelectionVisuals()
		end
	else
		applyVirtualEggEquipUID(v462)
	end
	return v462
end

function syncVirtualEggEquipStateFromTool(v463) -- line 2036 | captures: v56, v58, v96
	local UID = v463:GetAttribute("UID")
	if typeof(UID) == "string" then
		if v463.Parent == v56 then
			applyVirtualEggEquipUID(UID)
		elseif v463.Parent == v58 and v96 == UID then
			task.defer(reconcileVirtualEggEquipState)
		end
	end
end

function requestUnequipVirtualEgg() -- line 2049 | captures: v96, Message, EggState, v80
	local v464
	reconcileVirtualEggEquipState()
	if v96 then
		v80(function() -- line 2055 | captures: v464, v96, Message, EggState
			local v465 = v96
			local v466, v467 = EggState.DoffEggTool(v465)
			if v466 then
				v96 = nil
				if SelectedSlot and getAttribute(SelectedSlot.Tool, "UID") == v465 then
					SelectedSlot = nil
				end
				updateEquipSelectionVisuals()
				v464 = true
			elseif v467 then
				Message.Bottom({
					Time = 2,
					Message = v467,
					Color = Color3.fromRGB(255, 64, 64)
				})
			end
		end)
		return false
	end
	return true
end

function requestEquipVirtualEgg(v468, v469) -- line 2074 | captures: v57, v96, HotbarEggOffers, HiddenUIHandler, Message, EggState, PromptPurchase, v80
	local v470 = HotbarEggOffers.ByUid[v468]
	if v470 then
		PromptPurchase.Prompt(v470.ProductId, true)
		SelectedSlot = v469
		updateEquipSelectionVisuals()
	elseif BackpackEnabled and BackpackGui.Enabled and not HiddenUIHandler.IsHidden() then
		if reconcileVirtualEggEquipState() == v468 then
			SelectedSlot = v469
			updateEquipSelectionVisuals()
		else
			v80(function() -- line 2093 | captures: v468, v469, v57, v96, Message, EggState
				requestUnequipVirtualAsset()
				if v57 then
					v57:UnequipTools()
				end
				local v471, v472 = EggState.WearEggTool(v468)
				if v471 then
					v96 = v468
					SelectedSlot = v469
					updateEquipSelectionVisuals()
				elseif v472 then
					Message.Bottom({
						Time = 2,
						Message = v472,
						Color = Color3.fromRGB(255, 64, 64)
					})
				end
			end)
		end
	end
end

function requestUnequipVirtualAsset() -- line 2115 | captures: v82, Message, Remotes, v80
	local v473
	reconcileVirtualAssetEquipState()
	if v82 then
		v80(function() -- line 2121 | captures: v473, v82, Message, Remotes
			local v474 = v82
			local v475, v476 = Remotes.PenRoster.AskDoff:InvokeServer(v474)
			if v475 == false then
				if v476 and v476 ~= "Asset is not available." then
					Message.Bottom({
						Time = 2,
						Message = v476,
						Color = Color3.fromRGB(255, 64, 64)
					})
				end
			else
				v82 = nil
				if SelectedSlot and virtualAssetMatchesUID(SelectedSlot.Tool, v474) then
					SelectedSlot = nil
				end
				updateEquipSelectionVisuals()
				v473 = true
			end
		end)
		return false
	end
	return true
end

function addVirtualAssetOverlay(v477, v478, v479, v480, v481) -- line 2140 | captures: AssetEarnings, AssetItems, ItemDisplay
	if not v477:GetAttribute("IsInventorySlot") or v477:GetAttribute("HasAssetOverlay") then
		return
	end
	local v482, v483, v484
	if v479.Rarity then
		local DisplayName = v479.Rarity.DisplayName
		v484 = DisplayName
		if not DisplayName then
			local _id = v479.Rarity._id
			v484 = _id
			if not _id then
				v484 = v479.Rarity.Name
			end
		end
	else
		v484 = "Unknown"
	end
	local v485 = getAssetItemDisplayName(v478, v479)
	if typeof(v478) == "table" then
		local Category = v478.Category
		if typeof(Category) == "string" and AssetDirectory[v478.Category] then
			v482 = AssetEarnings.MutationOnlyRatePerSecond(v478)
		end
	else
		v482 = AssetEarnings.ComputeBaseRateFromDropWeight(v479.DropWeight)
	end
	if typeof(v478) == "table" then
		local Mutations = v478.Mutations
		if typeof(Mutations) == "table" then
			v483 = ItemDisplay.GetMutationRichTextLine(v478.Mutations, v478.BaseMutation)
		end
	end
	local v486
	if typeof(v478) == "table" then
		local Category = v478.Category
		if typeof(Category) == "string" then
			local Scale = v478.Scale
			if typeof(Scale) == "number" then
				v486 = AssetItems.WeightLabel(v478)
			end
		end
	end
	if v480 then
		v480:Add((InfoOverlay.Hook(v477, function() -- line 2177 | captures: v484, v482, v483, v486, v477, v485
			if v477:GetAttribute("IsInventorySlot") then
				local v487 = {}
				local v488 = {}
				v488[1] = "Title"
				v488[2] = v485
				local v489 = {}
				v489[1] = "Div"
				local v490 = {}
				v490[1] = "Rarity"
				v490[2] = v484
				local v491 = {}
				v491[1] = "Div"
				local v492 = {}
				local v493 = "$" .. SimpleNumber.FormatCompact(v482, ".#") .. "/s"
				v492[1] = "Title"
				v492[2] = v493
				v492[3] = nil
				v492[4] = Color3.new(0, 1, 0)
				v487[1] = v488
				v487[2] = v489
				v487[3] = v490
				v487[4] = v491
				v487[5] = v492
				if v486 then
					local v494 = {}
					v494[1] = "Desc"
					v494[2] = v486
					table.insert(v487, 2, v494)
				end
				if v483 then
					local v495 = {}
					v495[1] = "Div"
					table.insert(v487, v495)
					local v496 = {}
					v496[1] = "Desc"
					v496[2] = v483
					table.insert(v487, v496)
				end
				return v487
			end
			return nil
		end)))
	end
	v477:SetAttribute("HasAssetOverlay", true)
end

function addVirtualEggOverlay(v497, v498, v499) -- line 2233
	local v500, v501, v502, v503
	if v497:GetAttribute("IsInventorySlot") then
		if v497:GetAttribute("HasEggOverlay") then
			v503 = true
		else
			v500 = getEggDisplayNameWithWeight(v498)
			local v504
			v504, v501 = getEggConfigForRecord(v498)
			_ = v504
			v502 = v501 and v501.Rarity
			v503 = false
		end
	else
		v503 = true
	end
	if v503 then
		return
	end
	local v505 = if v501 == nil then false else v501.Egg.HideRarity == true
	local v506, v507
	if v502 then
		local DisplayName = v502.DisplayName
		v507 = DisplayName
		if not DisplayName then
			local _id = v502._id
			v507 = _id
			if not _id then
				v507 = v502.Name
			end
		end
		v506 = v502.Color
	else
		v507 = "Egg"
		v506 = Color3.new(1, 1, 1)
	end
	if v499 then
		local Hook = InfoOverlay.Hook
		local v508 = v500
		local v509 = v505
		v499:Add((Hook(v497, function() -- line 2263 | captures: v506, v507, v497, v508, v509
			if v497:GetAttribute("IsInventorySlot") then
				local v510 = {}
				local v511 = {}
				v511[1] = "Title"
				v511[2] = v508
				v510[1] = v511
				if not v509 then
					local v512 = {}
					v512[1] = "Div"
					table.insert(v510, v512)
					local v513 = {}
					v513[1] = "Title"
					v513[2] = v507
					v513[3] = nil
					v513[4] = v506
					table.insert(v510, v513)
				end
				return v510
			end
			return nil
		end)))
	end
	v497:SetAttribute("HasEggOverlay", true)
end

function NewGui(v514, v515) -- line 2290
	local v516 = Instance.new(v514)
	v516.Name = v515
	v516.BackgroundColor3 = Color3.new(0, 0, 0)
	v516.BackgroundTransparency = 1
	v516.BorderColor3 = Color3.new(0, 0, 0)
	v516.BorderSizePixel = 0
	v516.Size = UDim2.new(1, 0, 1, 0)
	if v514:match("Text") then
		v516.TextColor3 = Color3.new(1, 1, 1)
		v516.Text = ""
		v516.FontFace = script:GetAttribute("LabelFont")
		v516.TextSize = TextSizeAttribute
		v516.TextWrapped = true
		if v514 == "TextButton" then
			v516.FontFace = script:GetAttribute("SlotFont")
		end
	end
	return v516
end

function FindLowestEmpty(v517) -- line 2310 | captures: v78, v62
	local v518 = v78
	for v519 = 1, v518 do
		local v520 = v62[v519]
		if v520 and not v520.IsFakeSlot and not v520.Tool and canToolUseHotbarSlot(v517, v519) then
			return v520
		end
	end
	return nil
end

function FindEmptyInventorySlot() -- line 2323 | captures: v78, v62
	local v521 = v78 + 1
	local v522 = #v62
	for v523 = v521, v522 do
		local v524 = v62[v523]
		if v524 and not v524.Tool then
			return v524
		end
	end
	return nil
end

function cancelPendingBackpackRoundRestore() -- line 2336 | captures: v110
	if v110 then
		task.cancel(v110)
		v110 = nil
	end
end

function moveRestrictedHotbarToolsToInventory() -- line 2342 | captures: v78, v62
	local v525 = v78
	for v526 = 1, v525 do
		local v527 = v62[v526]
		if v527 and not v527.IsFakeSlot and v527.Tool and not isToolLockedToCurrentHotbarSlot(v527) then
			v527:MoveToInventory()
		end
	end
end

function isGearTool(v528) -- line 2353
	local function v529(...)
		return (typeof(...))
	end

	if getAttribute(v528, "ItemType") == "Gear" then
		return true
	end
	return v529(getAttribute(v528, "GearName")) == "string"
end

function isPhoneTool(v530) -- line 2357
	return getAttribute(v530, "ItemType") == "Phone"
end

function isBatGearTool(v531) -- line 2361
	local v532 = getGearConfig(v531)
	if v532 == nil then
		return false
	end
	return v532.BatControllerData ~= nil
end

function isTrapGearTool(v533) -- line 2366
	return getGearName(v533) == "Trap"
end

function isBeeLauncherGearTool(v534) -- line 2370
	return getGearName(v534) == "BeeLauncher"
end

local BatSlot = HotbarEggOffers.BatSlot
local TrapSlot = HotbarEggOffers.TrapSlot

function getLockedHotbarSlotForTool(v535) -- line 2378 | captures: HotbarEggOffers, BatSlot, TrapSlot
	local v536 = HotbarEggOffers.ByUid[getAttribute(v535, "UID")]
	if v536 then
		return v536.Slot
	end
	if typeof(v535) == "Instance" and v535:IsA("Tool") and isGearTool(v535) then
		if isBatGearTool(v535) then
			return BatSlot
		end
		if isTrapGearTool(v535) then
			return TrapSlot
		end
	end
	return nil
end

function canToolUseHotbarSlot(v537, v538) -- line 2397 | captures: TrapSlot
	local v539 = getLockedHotbarSlotForTool(v537)
	if v539 == nil then
		return not (v538 >= 1 and v538 <= TrapSlot)
	end
	return v539 == v538
end

function isToolLockedToCurrentHotbarSlot(v540) -- line 2409
	if v540 and not v540.IsFakeSlot and v540.Tool then
		local v541 = getLockedHotbarSlotForTool(v540.Tool)
		if v541 == nil then
			return false
		end
		return v541 == v540.Index
	end
	return false
end

function findGearSlot(v542) -- line 2417 | captures: v62
	for v543, v544 in pairs(v62) do
		if v544 and not v544.IsFakeSlot and v544.Tool and isGearTool(v544.Tool) and v542(v544.Tool) then
			return v544
		end
	end
	return nil
end

function moveGameplayGearToHotbarSlot(v545, v546) -- line 2425 | captures: v78, v62
	local v547 = findGearSlot(v545)
	if v547 then
		local v548 = v62[v546]
		if v548 and not v548.IsFakeSlot and v547 ~= v548 then
			if v548.Tool then
				local v549
				if canToolUseHotbarSlot(v548.Tool, v546) then
					v549 = true
				else
					v547:Swap(v548)
					if v78 < v547.Index and not v547.Tool then
						v547:Delete()
					end
					v549 = false
				end
				return not v549
			end
			v547:Swap(v548)
			if v78 < v547.Index and not v547.Tool then
				v547:Delete()
			end
			return true
		end
	end
	return false
end

function moveInvalidLockedHotbarSlotToolToInventory(v550) -- line 2450 | captures: v62
	local v551 = v62[v550]
	if v551 and not v551.IsFakeSlot and v551.Tool and not canToolUseHotbarSlot(v551.Tool, v550) then
		v551:MoveToInventory()
		return true
	end
	return false
end

function ensureGameplayGearHotbarSlots() -- line 2458 | captures: v3, BatSlot, TrapSlot
	local v552 = moveGameplayGearToHotbarSlot(isBatGearTool, BatSlot)
	if moveGameplayGearToHotbarSlot(isTrapGearTool, TrapSlot) then
		v552 = true
	end
	if moveInvalidLockedHotbarSlotToolToInventory(BatSlot) then
		v552 = true
	end
	if not (moveInvalidLockedHotbarSlotToolToInventory(TrapSlot) or v552) then
		return
	end
	AdjustHotbarFrames()
	UpdateInventorySlots()
	if v3 then
		v3(true)
	end
end

function isToolInCharacterOrBackpack(v553) -- line 2478 | captures: v56, v58
	if not (typeof(v553) == "Instance" and v553:IsA("Tool")) then
		return false
	end
	local Parent = v553.Parent
	if Parent == v56 then
		return true
	end
	return Parent == v58
end

function _isInventoryEmpty() -- line 2486 | captures: v78, v62
	local v554 = v78 + 1
	local v555 = #v62
	for v556 = v554, v555 do
		local v557 = v62[v556]
		if v557 and v557.Tool then
			return false
		end
	end
	return true
end

function _UseGazeSelection() -- line 2499
	return UserInputService.VREnabled
end

function AdjustHotbarFrames() -- line 2502 | captures: v78, v44, v67, v70, v62
	debug.profilebegin("BackpackController :: AdjustHotbarFrames")
	local v558 = v78
	for v559 = 1, v558 do
		local v560 = v62[v559]
		if v560 then
			v560:SetNumberText(nil)
		end
	end
	local Visible = v44.Visible
	local v561 = {}
	for v562 = 1, v558 do
		local v563 = v62[v562]
		local IsFakeSlot = v563 and (v563.IsFakeSlot or v563.Tool or Visible)
		local v564 = if v70 then v563 and v563.Tool and isPhoneTool(v563.Tool) else IsFakeSlot
		if v564 then
			local v565 = {
				Kind = "Slot",
				Slot = v563
			}
			table.insert(v561, v565)
		end
	end
	local v566 = #v561
	local v567 = math.max(1, v566)
	v67 = v567
	for v568 = 1, v558 do
		local v569 = v62[v568]
		if v569 then
			v569.Frame.Visible = false
		end
	end
	local v570 = 0
	for v571, v572 in ipairs(v561) do
		v570 += 1
		local Slot = v572.Slot
		if Slot then
			Slot.Frame.LayoutOrder = v570
			Slot:Readjust(v570, v567)
			Slot.Frame.Visible = true
		end
	end
	PositionInventoryAffordances()
	debug.profileend()
end

function UpdateScrollingFrameCanvasSize() -- line 2566
	debug.profilebegin("BackpackController :: UpdateScrollingFrameCanvasSize")
	debug.profileend()
end

function UpdateInventorySlots() -- line 2573 | captures: v78, v3, v73, v62
	debug.profilebegin("BackpackController :: UpdateInventorySlots")
	if v73 then
		if v3 then
			v3()
		end
	else
		local v573 = {}
		local v574 = {}
		local v575 = {}
		local v576 = {}
		local v577 = {}
		local v578 = v78 + 1
		local v579 = #v62
		for v580 = v578, v579 do
			local v581 = v62[v580]
			local Tool = v581.Tool
			if Tool then
				if IsOfCategory(Tool) then
					local ItemType = getAttribute(Tool, "ItemType")
					if ItemType == "Asset" then
						table.insert(v573, v581)
					elseif ItemType == "AssetEgg" then
						table.insert(v574, v581)
					elseif ItemType == "Sword" then
						table.insert(v575, v581)
					else
						table.insert(v576, v581)
					end
					v581.Frame.Visible = true
				else
					v581.Frame.Visible = false
				end
			else
				table.insert(v577, v581)
				v581.Frame.Visible = false
			end
		end
		table.sort(v573, function(v582, v583) -- line 2612
			local Tool = v582.Tool
			local Tool_2 = v583.Tool
			local v584 = Tool and isToolFavorite(Tool)
			if v584 ~= (Tool_2 and isToolFavorite(Tool_2)) then
				return v584
			end
			local v585
			if Tool then
				v585 = getAssetRarityNumber(Tool)
			else
				v585 = (1/0)
			end
			local v586
			if Tool_2 then
				v586 = getAssetRarityNumber(Tool_2)
			else
				v586 = (1/0)
			end
			if v585 ~= v586 then
				return v586 < v585
			end
			local v587
			if Tool then
				v587 = getAssetEarningRate(Tool)
			else
				v587 = 0
			end
			local v588
			if Tool_2 then
				v588 = getAssetEarningRate(Tool_2)
			else
				v588 = 0
			end
			if v587 ~= v588 then
				return v588 < v587
			end
			local v589
			if Tool then
				v589 = getAssetOddsDenominator(Tool)
			else
				v589 = 0
			end
			local v590
			if Tool_2 then
				v590 = getAssetOddsDenominator(Tool_2)
			else
				v590 = 0
			end
			if v589 ~= v590 then
				return v590 < v589
			end
			local v591
			if Tool then
				v591 = getAssetDropWeight(Tool)
			else
				v591 = (1/0)
			end
			local v592
			if Tool_2 then
				v592 = getAssetDropWeight(Tool_2)
			else
				v592 = (1/0)
			end
			if v591 ~= v592 then
				return v591 < v592
			end
			local v593
			if Tool then
				v593 = getAttribute(Tool, "Weight")
			else
				v593 = 0
			end
			local v594
			if Tool_2 then
				v594 = getAttribute(Tool_2, "Weight")
			else
				v594 = 0
			end
			if v593 ~= v594 then
				return v594 < v593
			end
			local v595
			if Tool then
				v595 = getAttribute(Tool, "UID")
			else
				v595 = ""
			end
			return v595 < (Tool_2 and getAttribute(Tool_2, "UID") or "")
		end)
		table.sort(v574, function(v596, v597) -- line 2713
			local Tool = v596.Tool
			local Tool_2 = v597.Tool
			local v598
			if Tool then
				v598 = getEggRarityNumber(Tool)
			else
				v598 = (1/0)
			end
			local v599
			if Tool_2 then
				v599 = getEggRarityNumber(Tool_2)
			else
				v599 = (1/0)
			end
			if v598 == v599 then
				local v600
				if Tool then
					v600 = getEggBaseEarningRate(Tool)
				else
					v600 = 0
				end
				local v601
				if Tool_2 then
					v601 = getEggBaseEarningRate(Tool_2)
				else
					v601 = 0
				end
				if v600 == v601 then
					local v602
					if Tool then
						v602 = getAttribute(Tool, "UID")
					else
						v602 = ""
					end
					return v602 < (Tool_2 and getAttribute(Tool_2, "UID") or "")
				end
				return v601 < v600
			end
			return v599 < v598
		end)
		table.sort(v575, function(v603, v604) -- line 2761
			local v605 = getAttribute(v603.Tool, "MoneyCost") or 0
			return not not (getAttribute(v604.Tool, "MoneyCost") or v605 > 0)
		end)
		local v606 = v78
		for v607, v608 in ipairs(v573) do
			v606 += 1
			v608.Frame.LayoutOrder = v606
		end
		for v609, v610 in ipairs(v574) do
			v606 += 1
			local v611
			if v610.Tool then
				v611 = getEggAssetConfig(v610.Tool)
			end
			local Frame = v610.Frame
			if v611 and v611.Egg.HideRarity then
				Frame.LayoutOrder = -2147483648
			else
				Frame.LayoutOrder = v606
			end
		end
		for v612, v613 in ipairs(v575) do
			v606 += 1
			v613.Frame.LayoutOrder = v606
		end
		for v614, v615 in ipairs(v576) do
			v606 += 1
			v615.Frame.LayoutOrder = v606
		end
		for v616, v617 in ipairs(v577) do
			v606 += 1
			v617.Frame.LayoutOrder = v606
		end
		UpdateScrollingFrameCanvasSize()
		debug.profileend()
	end
end

function ResizeContainers() -- line 2808 | captures: v78, v79, v25, v42, v43, VREnabled
	v43.Size = UDim2.new(0, 5 + v78 * (v25 + 5), 0, v25 + 5 + 5)
	v43.Position = UDim2.new(0.5, -v43.Size.X.Offset / 2, 1, -v43.Size.Y.Offset)
	local v618 = if VREnabled then 80 else 0
	v42.Size = UDim2.new(0, v43.Size.X.Offset, 0, v43.Size.Y.Offset * v79 + 40 + v618)
	v42.Position = UDim2.new(0.5, -v42.Size.X.Offset / 2, 1, v43.Position.Y.Offset - v42.Size.Y.Offset)
	PositionInventoryAffordances()
	AdjustHotbarFrames()
	UpdateInventorySlots()
end

INVENTORY_AFFORDANCE_GAP = 8
PROMPT_HOTBAR_GAP = 28

function PositionInventoryAffordances() -- line 2825 | captures: v25, v67, v69, ClientGlobals
	local v619 = if workspace.CurrentCamera then workspace.CurrentCamera.ViewportSize.X else 0
	if v619 > 0 then
		local v620 = v25 + 5
		local v621 = v67
		local v622 = 2.5 - v620 * math.max(1, v621) * 0.5
		ButtonHintStrip.PinRight(0.5 + (v622 - PROMPT_HOTBAR_GAP) / v619)
	end
	if ClientGlobals.Console and v69 then
		ButtonHintStrip.Present("Backpack", Enum.KeyCode.ButtonSelect, "Backpack")
	else
		ButtonHintStrip.Retract("Backpack")
	end
end

function _Clamp(v623, v624, v625) -- line 2846
	local v626 = math.max(v623, v625)
	return (math.min(v624, v626))
end

function CheckBounds(v627, v628, v629) -- line 2849
	local AbsolutePosition = v627.AbsolutePosition
	local AbsoluteSize = v627.AbsoluteSize
	if AbsolutePosition.X < v628 and v628 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < v629 then
		return v629 <= AbsolutePosition.Y + AbsoluteSize.Y
	end
	return false
end

function GetOffset(v630, v631) -- line 2855
	return (v630.AbsolutePosition + v630.AbsoluteSize / 2 - v631).magnitude
end

function UnequipAllTools(v632, v633) -- line 2858 | captures: v57
	requestUnequipVirtualAsset()
	requestUnequipVirtualEgg()
	if v57 then
		v57:UnequipTools()
	end
end

function _EquipNewTool(v634) -- line 2865 | captures: v56, v57, HiddenUIHandler
	if BackpackEnabled and BackpackGui.Enabled and not HiddenUIHandler.IsHidden() then
		if v57 then
			UnequipAllTools()
		end
		v634.Parent = v56
	end
end

function _ToggleFavoriteTool(v635) -- line 2881
	local Tool = v635.Tool
	if Tool then
		requestFavoriteToggle(Tool)
	end
end

function _IsEquipped(v636) -- line 2888 | captures: v56
	return v636 and v636.Parent == v56
end

function MakeSlot(v637, v638) -- line 2895 | captures: v6, v78, v1, v2, v3, v7, v8, v10, v25, v26, v34, v38, LocalPlayer_2, v43, v44, v47, v56, v57, v58, v63, v67, v69, v73, v82, v96, RunService, HiddenUIHandler, AssetIconShape, Trove, v24, Value, v40, v59, v62, v64, v65, v66
	local v639, v640
	local v641 = v638 or #v62 + 1
	local v642 = {
		IsFakeSlot = false,
		IsDeleted = false,
		Index = v641
	}
	local v643 = if v637 == v47 then true else v78 < v641
	local v644, Shadow, ToolName, Weight, v645, v646, v647, v648
	local v649 = {}
	local v650, v651, ToolTip, Number, FavIcon, v652, TextXAlignment, TextYAlignment, v653
	if v643 then
		v653 = script.InventoryTemplate
	else
		v653 = script.HotbarTemplate
	end
	local v654 = v653:Clone()
	v654.Name = v641
	v654.ZIndex = 20
	local Icon = v654.Icon
	local CooldownOverlay = NewGui("Frame", "CooldownOverlay")
	CooldownOverlay.BackgroundColor3 = Color3.new(0, 0, 0)
	CooldownOverlay.BackgroundTransparency = 0.35
	CooldownOverlay.BorderSizePixel = 0
	CooldownOverlay.Size = UDim2.fromScale(1, 1)
	CooldownOverlay.Visible = false
	CooldownOverlay.ZIndex = 20
	CooldownOverlay.Parent = v654
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = script:GetAttribute("CornerRadius")
	UICorner.Parent = CooldownOverlay
	local CooldownLabel = NewGui("TextLabel", "CooldownLabel")
	CooldownLabel.BackgroundTransparency = 1
	CooldownLabel.Size = UDim2.new(1, -4, 1, -4)
	CooldownLabel.Position = UDim2.fromOffset(2, 2)
	CooldownLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.Bold)
	CooldownLabel.TextColor3 = Color3.new(1, 1, 1)
	CooldownLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	CooldownLabel.TextStrokeTransparency = 0.4
	CooldownLabel.TextScaled = true
	CooldownLabel.TextXAlignment = Enum.TextXAlignment.Center
	CooldownLabel.TextYAlignment = Enum.TextYAlignment.Center
	CooldownLabel.Visible = false
	CooldownLabel.ZIndex = CooldownOverlay.ZIndex + 1
	CooldownLabel.Text = ""
	CooldownLabel.Parent = CooldownOverlay
	local v655 = Trove.new()

	local function restoreAssetIconHover(v656) -- line 2959
	end

	local function clearSlotOverlays() -- line 2960 | captures: v645, v654, v655
		v655:Clean()
		clearMutationIconFrame(v645, nil)
		if not v654 then
			return
		end
		v654:SetAttribute("HasAssetOverlay", nil)
		v654:SetAttribute("HasEggOverlay", nil)
		v654:SetAttribute("HasSwordOverlay", nil)
	end

	local function isDragRestrictedItemType(v657) -- line 2969
		return false
	end

	local function canPlaceToolInSlot(v658, v659) -- line 2972 | captures: v78
		if not v658.IsFakeSlot then
			if not v659 or v78 < v658.Index then
				return true
			end
			if canToolUseHotbarSlot(v659, v658.Index) then
				if typeof(v659) == "table" and (v659.IsVirtualAsset or v659.IsVirtualEgg) then
					return getHotbarFillTool(v659) ~= nil
				end
				getAttribute(v659, "ItemType")
				return true
			end
		end
		return false
	end

	local function shouldAllowSlotDragging(v660) -- line 2993 | captures: v642, canPlaceToolInSlot, v78, v44
		if not isToolLockedToCurrentHotbarSlot(v642) then
			local v661 = v660 or v642.Tool
			if v661 then
				if typeof(v661) == "Instance" then
					getAttribute(v661, "ItemType")
					local v662, v663
					if canPlaceToolInSlot(v642, v661) then
						if UserInputService.VREnabled then
							v663 = true
						else
							v662 = v642.Index <= v78
							v663 = false
						end
					else
						v663 = true
					end
					if v663 then
						return false
					end
					return not v662 or v44.Visible
				end
				if typeof(v661) == "table" and (v661.IsVirtualAsset or v661.IsVirtualEgg) then
					return
				end
			end
		end
		return false
	end

	local function applySlotDraggableState(v664) -- line 3021 | captures: v654, v10
		if v10 then
			v654:SetAttribute("Draggable", v664)
		else
			v654.Draggable = v664
		end
	end

	local function stopCooldownHeartbeat() -- line 3028 | captures: v650
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
	end

	local function disconnectCooldownConnections() -- line 3034 | captures: v649
		for v665, v666 in ipairs(v649) do
			v666:Disconnect()
		end
		v649 = {}
	end

	local function hideCooldownOverlay() -- line 3040 | captures: v650, CooldownOverlay, CooldownLabel
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
		if CooldownOverlay then
			CooldownOverlay.Visible = false
		end
		if CooldownLabel then
			CooldownLabel.Visible = false
			CooldownLabel.Text = ""
		end
	end

	local function updateCooldownDisplay() -- line 3053 | captures: v650, v642, CooldownOverlay, CooldownLabel
		local Tool = v642.Tool
		if Tool then
			local CooldownEndTime = Tool:GetAttribute("CooldownEndTime")
			if typeof(CooldownEndTime) == "number" then
				if CooldownEndTime > 0 then
					if Tool:GetAttribute("CooldownActive") then
						local v667 = CooldownEndTime - workspace:GetServerTimeNow()
						if v667 > 1 then
							if CooldownOverlay then
								CooldownOverlay.Visible = true
							end
							if CooldownLabel then
								CooldownLabel.Visible = true
								local v668 = math.ceil(v667)
								local v669 = math.max(v668, 0)
								CooldownLabel.Text = tostring(v669)
							end
							return true
						end
					end
					if v650 then
						v650:Disconnect()
						v650 = nil
					end
					if CooldownOverlay then
						CooldownOverlay.Visible = false
					end
					if CooldownLabel then
						CooldownLabel.Visible = false
						CooldownLabel.Text = ""
					end
					return false
				end
				return
			end
		end
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
		if CooldownOverlay then
			CooldownOverlay.Visible = false
		end
		if CooldownLabel then
			CooldownLabel.Visible = false
			CooldownLabel.Text = ""
		end
		return false
	end

	local function ensureCooldownHeartbeat(v670) -- line 3124 | captures: v650, v642, CooldownOverlay, CooldownLabel, updateCooldownDisplay, RunService
		v650 = v650 or
			RunService.Heartbeat:Connect(function() -- line 3128 | captures: v670, v650, v642, CooldownOverlay, CooldownLabel, updateCooldownDisplay
				if v642.Tool == v670 then
					if not updateCooldownDisplay() and v650 then
						v650:Disconnect()
						v650 = nil
					end
				else
					if v650 then
						v650:Disconnect()
						v650 = nil
					end
					if CooldownOverlay then
						CooldownOverlay.Visible = false
					end
					if CooldownLabel then
						CooldownLabel.Visible = false
						CooldownLabel.Text = ""
					end
					if v650 then
						v650:Disconnect()
						v650 = nil
					end
				end
			end)
	end

	local function connectCooldownListeners(v671) -- line 3153 | captures: v649, v650, v642, CooldownOverlay, CooldownLabel, disconnectCooldownConnections, updateCooldownDisplay, RunService
		local function v672(v673, ...)
			table.insert(v673, ...)
		end

		local function v674(v675, ...)
			table.insert(v675, ...)
		end

		local function v676(v677, ...)
			table.insert(v677, ...)
		end

		disconnectCooldownConnections()
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
		if CooldownOverlay then
			CooldownOverlay.Visible = false
		end
		if CooldownLabel then
			CooldownLabel.Visible = false
			CooldownLabel.Text = ""
		end
		if not v671 then
			return
		end

		local function onAttributeChanged() -- line 3169 | captures: v671, v650, v642, CooldownOverlay, CooldownLabel, updateCooldownDisplay, RunService
			if updateCooldownDisplay() then
				v650 = v650 or
					RunService.Heartbeat:Connect(function() -- line 3181 | captures: v671, v650, v642, CooldownOverlay, CooldownLabel, updateCooldownDisplay
						if v642.Tool == v671 then
							if not updateCooldownDisplay() and v650 then
								v650:Disconnect()
								v650 = nil
							end
						else
							if v650 then
								v650:Disconnect()
								v650 = nil
							end
							if CooldownOverlay then
								CooldownOverlay.Visible = false
							end
							if CooldownLabel then
								CooldownLabel.Visible = false
								CooldownLabel.Text = ""
							end
							if v650 then
								v650:Disconnect()
								v650 = nil
							end
						end
					end)
			elseif v650 then
				v650:Disconnect()
				v650 = nil
			end
		end

		local CooldownEndTime = v671:GetAttributeChangedSignal("CooldownEndTime")
		v672(v649, CooldownEndTime:Connect(onAttributeChanged))
		local CooldownActive = v671:GetAttributeChangedSignal("CooldownActive")
		v674(v649, CooldownActive:Connect(onAttributeChanged))
		local CooldownDuration = v671:GetAttributeChangedSignal("CooldownDuration")
		v676(v649, CooldownDuration:Connect(onAttributeChanged))
		if updateCooldownDisplay() then
			v650 = v650 or
				RunService.Heartbeat:Connect(function() -- line 3216 | captures: v671, v650, v642, CooldownOverlay, CooldownLabel, updateCooldownDisplay
					if v642.Tool == v671 then
						if not updateCooldownDisplay() and v650 then
							v650:Disconnect()
							v650 = nil
						end
					else
						if v650 then
							v650:Disconnect()
							v650 = nil
						end
						if CooldownOverlay then
							CooldownOverlay.Visible = false
						end
						if CooldownLabel then
							CooldownLabel.Visible = false
							CooldownLabel.Text = ""
						end
						if v650 then
							v650:Disconnect()
							v650 = nil
						end
					end
				end)
		elseif v650 then
			v650:Disconnect()
			v650 = nil
		end
	end

	local v678 = v643

	function v642.updateDragAppearance(v679) -- line 3247 | captures: v642, v654, v678, v10
		if v642.IsFakeSlot then
			v654.BackgroundTransparency = SlotLockedTransparencyAttribute
			v654.BackgroundColor3 = BackgroundColorAttribute
		else
			v654.SelectionImageObject = nil
			local v680 = v679.Tool and getAttribute(v679.Tool, "ItemType")
			if v678 then
				local v681 = 0.5
				v654.BackgroundTransparency = v681
				v654.BackgroundColor3 = Color3.new(0, 0, 0)
			else
				local v682
				if v10 then
					v682 = v654:GetAttribute("Draggable")
				else
					v682 = v654.Draggable
				end
				v654.BackgroundTransparency = SlotLockedTransparencyAttribute
				local v683 = v682 and DraggableColorAttribute or BackgroundColorAttribute
				v654.BackgroundColor3 = v683
			end
		end
	end

	function v642.Readjust(v684, v685, v686) -- line 3287 | captures: v654, v25, v43
		local AnchorPoint = v654.AnchorPoint
		local Size = v654.Size
		v654.Position = UDim2.new(0, v43.Size.X.Offset / 2 - v25 / 2 + (v25 + 5) * (v685 - (v686 / 2 + 0.5)) + Size.X.Offset * AnchorPoint.X, 0, 5 + Size.Y.Offset * AnchorPoint.Y)
	end

	function v642.SetNumberText(v687, v688) -- line 3292 | captures: Number, v652
		if Number then
			local v689 = v688 or v652 or ""
			Number.Text = v689
		end
	end

	function v642.Fill(v690, v691) -- line 3304 | captures: Shadow, ToolName, Weight, v645, v646, v647, v648, v650, ToolTip, TextXAlignment, TextYAlignment, v642, v654, Icon, CooldownOverlay, CooldownLabel, v655, clearSlotOverlays, canPlaceToolInSlot, shouldAllowSlotDragging, disconnectCooldownConnections, v678, v78, v10, v38, v44, v63, v67, v69, v73, AssetIconShape, v64
		local IsFakeSlot = v690.IsFakeSlot
		local Tool, v692
		if IsFakeSlot then
			v692 = v690.FakeType == "SwordEquip"
		else
			if v691 then
				if canPlaceToolInSlot(v690, v691) then
					clearSlotOverlays()
					if v647 then
						v647:Disconnect()
						v647 = nil
					end
					if v648 then
						v648:Disconnect()
						v648 = nil
					end
					disconnectCooldownConnections()
					if v650 then
						v650:Disconnect()
						v650 = nil
					end
					if CooldownOverlay then
						CooldownOverlay.Visible = false
					end
					if CooldownLabel then
						CooldownLabel.Visible = false
						CooldownLabel.Text = ""
					end
					if v690.Tool and v690.Tool ~= v691 then
						v690:Clear()
					end
					local v693 = typeof(v691) == "Instance"
					local ItemType = getAttribute(v691, "ItemType")
					local v694 = getRegisteredBackpackSlot(v691)
					if v694 and v694 ~= v690 and registeredSlotContainsTool(v694, v691) then
						v694:Clear()
						if v78 < v694.Index then
							v694:Delete()
						end
					end
					v690.Tool = v691
					registerVirtualBackpackSlot(v690, v691)
					v690:UpdateFavoriteVisual()
					if v693 then
						v647 = v691:GetAttributeChangedSignal("Favorite"):Connect(function() -- line 3352 | captures: v690, v691
							v690:UpdateFavoriteVisual()
							if isAssetTool(v691) then
								UpdateInventorySlots()
							end
						end)
					end

					local function UpdateVisuals() -- line 3359 | captures: v690, v691, ItemType, Shadow, ToolName, Weight, v645, ToolTip, TextXAlignment, TextYAlignment, v654, Icon, v678, v78, AssetIconShape
						local TextureId = v691.TextureId
						AssetIconShape.Strip(Icon)
						Icon.Image = TextureId
						Icon.ScaleType = Enum.ScaleType.Fit
						ToolName.TextXAlignment = TextXAlignment
						ToolName.TextYAlignment = TextYAlignment
						Shadow.Visible = false
						clearMutationIconFrame(v645, nil)
						for v695, v696 in ipairs(Shadow:GetChildren()) do
							if v696:IsA("UIGradient") then
								v696:Destroy()
							end
						end
						for v697, v698 in ipairs(ToolName:GetChildren()) do
							if v698:IsA("UIGradient") then
								v698:Destroy()
							end
						end
						for v699, v700 in ipairs(Weight:GetChildren()) do
							if v700:IsA("UIGradient") then
								v700:Destroy()
							end
						end
						local v701 = string.match(v691.Name, "%[X(%d+)%]")
						local Name = v691.Name
						local v702, v703, v704, v705
						if ItemType == "Asset" then
							local Category = getAttribute(v691, "Category")
							local v706 = Category and AssetDirectory[Category]
							if v706 then
								local v707 = getAssetItemData(v691)
								if v707 then
									AssetIconShape.Paint(Icon, v707)
								else
									Icon.Image = v706.Icon or TextureId
								end
								Icon.ImageColor3 = Color3.new(1, 1, 1)
								if v706.Rarity and v706.Rarity.RarityGradient then
									v706.Rarity.RarityGradient:Clone().Parent = ToolName
									if v678 then
										v706.Rarity.RarityGradient:Clone().Parent = Shadow
									end
								end
							end
							Shadow.Visible = v678
							local v708 = getAssetItemData(v691)
							if v708 then
								local v709 = v706 or BaseAssetConfig
								Name = getAssetItemDisplayNameWithVisualWeight(v708, v709)
							else
								Name = getAttribute(v691, "DisplayName") or v691.Name
							end
							local v710 = parseMutations(getAttribute(v691, "Mutations"))
							local BaseMutation = getAttribute(v691, "BaseMutation")
							if v678 then
								populateMutationIconFrame(v645, nil, BaseMutation, v710)
								v703 = not not v678
							else
								if typeof(v691) == "table" then
									if v691.IsVirtualAsset then
									end
								else
									Name = ""
								end
								v703 = true
							end
							v704 = ""
							v705 = false
							v702 = Name
						else
							if ItemType == "AssetEgg" then
								local v711 = getEggRecordFromTool(v691)
								local v712, v713 = getEggConfigForRecord(v711)
								if v712 and v713 then
									local v714 = getEggIconForRecord(v711, v712)
									if v714 == "" then
										v714 = TextureId
									end
									Icon.Image = v714
									Icon.ImageColor3 = Color3.new(1, 1, 1)
									if not v712.HideRarity and v713.Rarity and v713.Rarity.RarityGradient then
										v713.Rarity.RarityGradient:Clone().Parent = ToolName
										if v678 then
											v713.Rarity.RarityGradient:Clone().Parent = Shadow
										end
									end
								end
								Shadow.Visible = v678
								if getAttribute(v691, "IsPromptOnly") then
									Name = getAttribute(v691, "DisplayName") or v691.Name
									Icon.Image = getAttribute(v691, "PromptIcon") or Icon.Image
								elseif v711 then
									Name = getEggDisplayNameWithWeight(v711)
								else
									Name = getAttribute(v691, "DisplayName") or v691.Name
								end
								v702 = Name
								v703 = true
							elseif ItemType == "Gear" then
								local v715 = getGearConfig(v691)
								local v716 = if TextureId == nil or TextureId == "" then v715 and v715.Icon or "" else TextureId
								Icon.Image = v716
								Icon.ImageColor3 = Color3.new(1, 1, 1)
								Shadow.Visible = false
								if shouldDisplayGearUses(v691) then
									v702 = getGearUsesText(v691)
								else
									v702 = ""
								end
								v703 = v702 ~= ""
								if v703 then
									ToolName.TextXAlignment = Enum.TextXAlignment.Center
									ToolName.TextYAlignment = Enum.TextYAlignment.Center
								end
								Name = ""
							elseif TextureId == "" then
								v702 = Name
								v703 = true
							elseif v701 then
								Name = ""
								v702 = ""
								v703 = true
							else
								v702 = Name
								v703 = false
							end
							v704 = ""
							v705 = false
						end
						if not v678 then
							if ItemType == "Gear" then
								if shouldDisplayGearUses(v691) then
								end
							else
								Name = ""
								v702 = ""
								v703 = false
							end
							v704 = ""
							v705 = false
						end
						ToolName.Text = v702 or Name
						ToolName.Visible = v703
						Weight.Text = v704
						Weight.Visible = v705
						applyPromptBrainrotHotbarStroke(v654, v691)
						if ToolTip and v691:IsA("Tool") then
							if v690.Index <= v78 and (ItemType == "Asset" or ItemType == "Pet" or ItemType == "AssetEgg" or ItemType == "Gear") then
								ToolTip.Text = ""
								ToolTip.Visible = false
							else
								local ToolTip_2 = v691.ToolTip
								if ToolTip_2 == "" then
									ToolTip_2 = v691.Name
								end
								ToolTip.Text = ToolTip_2
							end
						end
					end

					v642.UpdateVisuals = UpdateVisuals
					v642.UpdateVisuals()
					if v646 then
						v646:Disconnect()
						v646 = nil
					end
					if v693 then
						v646 = v691.Changed:Connect(function(v717) -- line 3566 | captures: v642
							if v717 == "TextureId" or v717 == "Name" or v717 == "ToolTip" then
								v642.UpdateVisuals()
							end
						end)
						if ItemType == "Asset" then
							v648 = v691:GetAttributeChangedSignal("Weight"):Connect(function() -- line 3586
								UpdateInventorySlots()
							end)
						end
					end
					local v718 = v690.Index <= v78
					local v719 = shouldAllowSlotDragging(v691)
					if v10 then
						v654:SetAttribute("Draggable", v719)
					else
						v654.Draggable = v719
					end
					v690:UpdateEquipView()
					if v718 and not v690.IsFakeSlot then
						v67 += 1
						if v69 and v67 >= 1 and not v38 then
							v38 = true
							ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
						end
					end
					if typeof(v691) == "Instance" then
						v64[v691] = v690
					end
					if ItemType == "Asset" then
						local v720 = AssetDirectory[getAttribute(v691, "Category")] or BaseAssetConfig
						local v721 = getAssetItemData(v691) or {}
						addVirtualAssetOverlay(v654, v721, v720, v655)
					elseif ItemType == "AssetEgg" then
						local v722 = getEggRecordFromTool(v691)
						if v722 then
							addVirtualEggOverlay(v654, v722, v655)
						end
					end
					v63 = FindLowestEmpty()
					if v678 and v44.Visible and not v73 then
						v654.Visible = IsOfCategory(v691)
					end
				end
				return
			end
			Tool = v690.Tool
		end
		if not (IsFakeSlot and v692 or not IsFakeSlot and not Tool) and not IsFakeSlot then
			v690:Clear()
		end
	end

	function v642.Clear(v723) -- line 3636 | captures: Shadow, ToolName, Weight, v646, v647, v648, v650, ToolTip, FavIcon, v654, Icon, CooldownOverlay, CooldownLabel, clearSlotOverlays, disconnectCooldownConnections, v78, v10, v38, v63, v67, AssetIconShape
		local v724
		if v723.Tool then
			if v723.IsFakeSlot then
				v724 = true
			else
				clearSlotOverlays()
				applyPromptBrainrotHotbarStroke(v654, nil)
				if v646 then
					v646:Disconnect()
					v646 = nil
				end
				v724 = false
			end
		else
			v724 = true
		end
		if v724 then
			return
		end
		if v647 then
			v647:Disconnect()
			v647 = nil
		end
		if v648 then
			v648:Disconnect()
			v648 = nil
		end
		disconnectCooldownConnections()
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
		if CooldownOverlay then
			CooldownOverlay.Visible = false
		end
		if CooldownLabel then
			CooldownLabel.Visible = false
			CooldownLabel.Text = ""
		end
		for v725, v726 in ipairs(Shadow:GetChildren()) do
			if v726:IsA("UIGradient") then
				v726:Destroy()
			end
		end
		Shadow.Visible = false
		AssetIconShape.Strip(Icon)
		Icon.Image = ""
		ToolName.Text = ""
		ToolName.Visible = true
		Weight.Text = ""
		Weight.Visible = false
		if ToolTip then
			ToolTip.Text = ""
			ToolTip.Visible = false
		end
		if v10 then
			v654:SetAttribute("Draggable", false)
		else
			v654.Draggable = false
		end
		FavIcon.Visible = false
		v723:UpdateEquipView(true)
		if v723.Index <= v78 and not v723.IsFakeSlot then
			v67 -= 1
			if v67 < 1 then
				v38 = false
				ContextActionService:UnbindAction("RBXHotbarEquip")
			end
		end
		unregisterBackpackSlotTool(v723, v723.Tool)
		v723.Tool = nil
		v63 = FindLowestEmpty()
	end

	function v642.UpdateEquipView(v727, v728) -- line 3700 | captures: v651, v654, v56, v82, v96
		if v727.IsFakeSlot then
			return
		end
		local ItemType = getAttribute(v727.Tool, "ItemType")
		local v729
		if ItemType == "Asset" then
			local Tool = v727.Tool
			if typeof(Tool) == "table" and v727.Tool.IsVirtualAsset then
				v729 = not v728 and virtualAssetMatchesUID(v727.Tool, v82)
			else
				v729 = false
			end
		elseif ItemType == "AssetEgg" then
			local Tool = v727.Tool
			if typeof(Tool) == "table" and v727.Tool.IsVirtualEgg then
				local v730 = not v728
				if v730 then
					local v731 = v96
					if typeof(v731) == "string" then
						v730 = v727.Tool.UID == v96
					else
						v730 = false
					end
				end
				v729 = v730
			else
				v729 = false
			end
		elseif v728 then
			v729 = false
		else
			local Tool = v727.Tool
			if Tool and typeof(Tool) == "Instance" then
				v729 = Tool.Parent == v56
			else
				v729 = false
			end
		end
		if v729 then
			if not v651 then
				v651 = NewGui("Frame", "Equipped")
				v651.ZIndex = 3
				v651.Size = UDim2.fromScale(1, 1)
				v651.AnchorPoint = Vector2.new(0.5, 0.5)
				v651.Position = UDim2.fromScale(0.5, 0.5)
				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = script:GetAttribute("CornerRadius")
				UICorner.Parent = v651
				local UIStroke = Instance.new("UIStroke")
				UIStroke.Color = EquippedColorAttribute
				UIStroke.Thickness = 3.8
				UIStroke.Parent = v651
			end
			v651.Parent = v654
		elseif v651 then
			v651.Parent = nil
		end
	end

	function v642.Delete(v732) -- line 3751 | captures: v650, v654, CooldownOverlay, CooldownLabel, clearSlotOverlays, disconnectCooldownConnections, v2, v59, v62, v66
		if v732.IsFakeSlot or v732.IsDeleted then
			return
		end
		v732.IsDeleted = true
		if v732.Tool then
			v732:Clear()
		end
		clearSlotOverlays()
		disconnectCooldownConnections()
		if v650 then
			v650:Disconnect()
			v650 = nil
		end
		if CooldownOverlay then
			CooldownOverlay.Visible = false
		end
		if CooldownLabel then
			CooldownLabel.Visible = false
			CooldownLabel.Text = ""
		end
		if v66[v654] then
			v66[v654] = nil
			v59:unlock()
			if v2 then
				v2:Destroy()
			end
		end
		v654:Destroy()
		local v733 = table.find(v62, v732)
		if v733 then
			table.remove(v62, v733)
			local v734 = #v62
			for v735 = v733, v734 do
				v62[v735]:SlideBack()
			end
		end
		UpdateScrollingFrameCanvasSize()
	end

	function v642.UpdateFavoriteVisual(v736) -- line 3791 | captures: FavIcon
		if not (FavIcon and v736.Tool) then
			return false
		end
		local v737 = isToolFavorite(v736.Tool)
		if FavIcon.Visible == v737 then
			return false
		end
		FavIcon.Visible = v737
		return true
	end

	function v642.Swap(v738, v739) -- line 3802 | captures: canPlaceToolInSlot
		if v738.IsFakeSlot or v739.IsFakeSlot then
			return
		end
		local Tool = v738.Tool
		local Tool_2 = v739.Tool
		if Tool and isToolLockedToCurrentHotbarSlot(v738) and v739 ~= v738 then
			return
		end
		if Tool_2 and isToolLockedToCurrentHotbarSlot(v739) and v738 ~= v739 then
			return
		end
		if not ((not Tool or canPlaceToolInSlot(v739, Tool)) and (not Tool_2 or canPlaceToolInSlot(v738, Tool_2))) then
			return
		end
		v738:Clear()
		if Tool_2 then
			v739:Clear()
			v738:Fill(Tool_2)
		end
		if Tool then
			v739:Fill(Tool)
		else
			v739:Clear()
		end
	end

	function v642.SlideBack(v740) -- line 3834 | captures: v654
		v740.Index -= 1
		v654.Name = v740.Index
		v654.LayoutOrder = v740.Index
	end

	function v642.TurnNumber(v741, v742) -- line 3839 | captures: Number
		if Number then
			Number.Visible = v742
		end
	end

	local v743

	function v642.SetClickability(v744, v745) -- line 3845 | captures: v743, v654, shouldAllowSlotDragging, v10, v66
		if v744.IsFakeSlot or not v744.Tool then
			return
		end
		local v746 = not v745 and shouldAllowSlotDragging(v744.Tool)
		if not v746 and v66[v654] then
			v743(UserInputService:GetMouseLocation())
		end
		if v10 then
			v654:SetAttribute("Draggable", v746)
		else
			v654.Draggable = v746
		end
		v744:updateDragAppearance()
	end

	function v642.CheckTerms(v747, v748) -- line 3865 | captures: ToolName, ToolTip
		local function v749(v750, ...)
			table.insert(v750, ...)
		end

		local function v751(v752, ...)
			table.insert(v752, ...)
		end

		local function v753(v754, ...)
			table.insert(v754, ...)
		end

		local function v755(v756, ...)
			table.insert(v756, ...)
		end

		local Tool = v747.Tool
		local v757
		if Tool then
			local v758 = {}
			if ToolName and ToolName.Text ~= "" then
				v749(v758, ToolName.Text:lower())
			end
			if typeof(Tool) == "table" then
			end
			local Name = Tool.Name
			if Name then
				v751(v758, tostring(Name):lower())
			end
			local v759 = ToolTip and ToolTip.Text
			if v759 and v759 ~= "" then
				v753(v758, v759:lower())
			end
			if typeof(Tool) == "table" then
			end
			local ToolTip_2 = Tool.ToolTip
			if ToolTip_2 and ToolTip_2 ~= "" then
				v755(v758, tostring(ToolTip_2):lower())
			end
			local v760 = 0
			v757 = 0
			for v761 in pairs(v748) do
				local v762 = v760
				for v763, v764 in ipairs(v758) do
					local v765, v766 = v764:gsub(v761, "")
					_ = v765
					v762 += v766
					v760 = v762
				end
				v757 = v760
			end
		else
			v757 = 0
		end
		return v757
	end

	function v642.Select(v767) -- line 3906 | captures: v78, v26, v56, v57, v58, v82, HiddenUIHandler, v24
		local Tool = v767.Tool
		if not Tool then
			return
		end
		if v26 then
			if v26.ItemType == getAttribute(Tool, "ItemType") then
				local v768
				if v78 < v767.Index or v26.AllowHotbar then
					local Validator = v26.Validator
					if Validator then
						v768 = Validator(Tool) == false
					else
						v768 = false
					end
				else
					v768 = true
				end
				if not v768 then
					local v769 = v26
					if ActiveFuseSelectionState then
						v24:EndFuseSelection()
						task.spawn(v769.Callback, Tool)
					else
						v769.Callback(Tool)
						if v769.Preserve ~= true then
							v26 = nil
						end
					end
					return
				end
			elseif ActiveFuseSelectionState then
				return
			end
		end
		if BackpackEnabled and BackpackGui.Enabled and not HiddenUIHandler.IsHidden() then
			if typeof(Tool) == "table" then
				if Tool.IsVirtualAsset then
					local v770 = _getAssetUID(Tool)
					if typeof(v770) == "string" then
						SelectedSlot = v767
						local v771 = findAssetToolByUID(v770)
						if v771 and v57 then
							if v771.Parent == v56 then
								v57:UnequipTools()
							else
								v57:UnequipTools()
								v57:EquipTool(v771)
							end
						elseif v82 == v770 then
							requestUnequipVirtualAsset()
						end
						updateEquipSelectionVisuals()
					end
				elseif Tool.IsVirtualEgg then
					local UID = getAttribute(Tool, "UID")
					if typeof(UID) == "string" then
						if reconcileVirtualEggEquipState() == UID then
							requestUnequipVirtualEgg()
						else
							requestEquipVirtualEgg(UID, v767)
						end
					end
				end
			else
				SelectedSlot = v767
				if Tool.Parent == v56 then
					SelectedSlot = nil
					if v57 then
						UnequipAllTools()
					end
				elseif Tool.Parent == v58 then
					if v57 then
						UnequipAllTools()
					end
					Tool.Parent = v56
				end
			end
		end
	end

	v642.MainImage = v654.ImageLabel
	local BaseTemplate = v654.BaseTemplate
	BaseTemplate.Amount.Visible = false
	BaseTemplate.Amount.Text = ""
	v645 = BaseTemplate:FindFirstChild("Mutations")
	local Amount = v645 and v645:FindFirstChild("Template")
	clearMutationIconFrame(v645, Amount)
	local UIStroke = v654.UIStroke
	UIStroke.Thickness = 0
	local v772
	if v643 then
		v772 = Color3.new(0, 0, 0)
	else
		v772 = BackgroundColorAttribute
	end
	v654.BackgroundColor3 = v772
	UIStroke.Color = BorderColorAttribute
	v654.Text = ""
	v654.AutoButtonColor = false
	v654.BorderSizePixel = 0
	if v637 == v47 then
		v772 = v40
	else
		v772 = v25
	end
	v654.Size = UDim2.new(0, v772, 0, v772)
	v654.Active = true
	v654.Draggable = false
	if v10 then
		v654:SetAttribute("Draggable", false)
	end
	v654:SetAttribute("IsInventorySlot", v643)
	local v773 = if v643 then 0.5 else SlotLockedTransparencyAttribute
	v654.BackgroundTransparency = v773
	ButtonFX(v654, 1.015, nil, true)
	v654.MouseButton1Click:Connect(function() -- line 4041 | captures: v642, v34
		if not (os.clock() < 0) then
			local Tool = v642.Tool
			if not v34 or not Tool then
				changeSlot(v642)
			elseif isAssetTool(Tool) then
				requestFavoriteToggle(Tool)
			else
				changeSlot(v642)
			end
		end
	end)
	if UserInputService.TouchEnabled then
		v654.TouchLongPress:Connect(function(v774, v775, v776) -- line 4064 | captures: v642
			if v775 == Enum.UserInputState.End then
				local Tool = v642.Tool
				if Tool and isAssetTool(Tool) then
					requestFavoriteToggle(Tool)
				end
			end
		end)
	else
		v654.MouseButton2Click:Connect(function() -- line 4057 | captures: v642
			local Tool = v642.Tool
			if Tool and isAssetTool(Tool) then
				requestFavoriteToggle(Tool)
			end
		end)
	end
	v642.Frame = v654
	Shadow = v654.Shadow
	Shadow.Visible = false
	v642.IconImage = Icon
	FavIcon = v654.FavIcon
	FavIcon.Visible = false
	ToolName = v654.ToolName
	TextXAlignment = ToolName.TextXAlignment
	TextYAlignment = ToolName.TextYAlignment
	Weight = v654.Weight
	Weight.Visible = false
	v642.Frame.LayoutOrder = v642.Index
	local v777, v778
	if v641 <= v78 then
		v654.StrokeFrame.Visible = false
		ToolTip = v654.ToolTip
		ToolTip.Visible = false
		v642.TooltipLabel = ToolTip
		v654.MouseEnter:Connect(function() -- line 4090 | captures: ToolTip
			if ToolTip.Text ~= "" then
				ToolTip.Visible = false
			end
		end)
		v654.MouseLeave:Connect(function() -- line 4095 | captures: ToolTip
			ToolTip.Visible = false
		end)

		function v642.MoveToInventory(v779) -- line 4098 | captures: v78, v44, v47, v56, v57, v73
			local v780 = false
			local v781 = false
			local v782 = false
			if not v779.IsFakeSlot then
				v780 = true
			end
			if v780 and not isToolLockedToCurrentHotbarSlot(v779) then
				v781 = true
			end
			v780 = false
			if v781 and v779.Index <= v78 then
				v780 = true
			end
			v781 = false
			local Tool, v783
			if v780 then
				Tool = v779.Tool
				v779:Clear()
				v783 = MakeSlot(v47)
				v783:Fill(Tool)
				if Tool then
					v781 = true
				else
					v782 = true
				end
			end
			v780 = false
			if v781 then
				if Tool.Parent == v56 then
					v780 = true
				else
					v782 = true
				end
			end
			v781 = false
			if v780 then
				if v57 then
					v781 = true
				else
					v782 = true
				end
			end
			v780 = false
			if v781 then
				UnequipAllTools()
				v782 = true
			end
			v781 = false
			if v782 then
				if Tool then
					v781 = true
				else
					v780 = true
				end
			end
			v782 = false
			if v781 then
				if typeof(Tool) == "Instance" then
					v782 = true
				else
					v780 = true
				end
			end
			v781 = false
			if v782 then
				if getAttribute(Tool, "ItemType") == "Asset" then
					v781 = true
				else
					v780 = true
				end
			end
			if v781 then
				task.defer(syncAssetsFromSave)
				v780 = true
			end
			v781 = false
			if v780 and v73 then
				v781 = true
			end
			if not v781 then
				return
			end
			v783.Frame.Visible = false
			v783.Frame.Parent = v44
		end

		if v641 <= 10 then
			if v641 > 10 then
				v777 = 0
			else
				v777 = v641
			end
			v778 = false
		else
			v778 = true
		end
	else
		v778 = true
	end
	if not v778 then
		Number = v654.Number
		v652 = tostring(v777)
		Number.Text = v652
		Number.Visible = false
		local v784 = Value + v777

		v65[v784] = function() -- line 4133 | captures: v642
			changeSlot(v642)
		end
	end
	local v785 = v654.Position
	local v786 = 0
	local Parent, v787

	local function startDrag(v788) -- line 4142 | captures: v644, v651, v785, Parent, v787, v642, v654, shouldAllowSlotDragging, UIStroke, v2, v10, LocalPlayer_2, v44, v47, v59, v66
		if v642.Tool and shouldAllowSlotDragging(v642.Tool) then
			v66[v654] = true
			v785 = v788
			UIStroke.Thickness = 2
			v59:lock()
			if v787 then
				v787:Disconnect()
				v787 = nil
			end
			if v642.Tool then
				local Tool = v642.Tool
				if typeof(Tool) == "Instance" then
					v787 = v642.Tool.AncestryChanged:Connect(function(v789, v790) -- line 4161 | captures: v644, v787, v642, LocalPlayer_2
						if v642.Tool and v789 == v642.Tool then
							local Parent = v642.Tool.Parent
							if Parent ~= LocalPlayer_2.Backpack and Parent ~= LocalPlayer_2.Character then
								if v644 then
									v644:Destroy()
									v644 = nil
								end
								if v787 then
									v787:Disconnect()
									v787 = nil
								end
							end
						elseif v787 then
							v787:Disconnect()
							v787 = nil
						end
					end)
				end
			end
			v654.ZIndex = 22
			v654.Parent.ZIndex = 22
			if v651 then
				v651.ZIndex = 22
				for v791, v792 in v651:GetChildren() do
					if not v792:IsA("UICorner") and not v792:IsA("UIStroke") then
						v792.ZIndex = 22
					end
				end
			end
			Parent = v654.Parent
			if Parent == v47 then
				local v793 = UDim2.new(0, v654.AbsolutePosition.X - v44.AbsolutePosition.X, 0, v654.AbsolutePosition.Y - v44.AbsolutePosition.Y)
				v654.Parent = v44
				v654.Position = v793
				v644 = NewGui("Frame", "FakeSlot")
				v644.LayoutOrder = v654.LayoutOrder
				v644.Size = v654.Size
				v644.BackgroundTransparency = 1
				v644.Parent = v47
				v2 = v644
			end
		else
			if v10 then
				v654:SetAttribute("Draggable", false)
			else
				v654.Draggable = false
			end
			v642:updateDragAppearance()
		end
	end

	function v743(v794) -- line 4214 | captures: v644, v651, v785, v786, Parent, v787, v642, v654, canPlaceToolInSlot, shouldAllowSlotDragging, UIStroke, v6, v78, v1, v3, v7, v8, v10, v43, v44, v56, v57, v63, v73, v59, v62, v66
		v66[v654] = nil
		if v644 then
			v644:Destroy()
			v644 = nil
		end
		if v787 then
			v787:Disconnect()
			v787 = nil
		end
		local v795 = tick()
		v654.Position = v785
		if Parent and v654.Parent ~= Parent then
			v654.Parent = Parent
		end
		UIStroke.Thickness = 0
		v59:unlock()
		v654.ZIndex = 20
		if Parent then
			Parent.ZIndex = 20
		end
		if v651 then
			v651.ZIndex = 20
			for v796, v797 in v651:GetChildren() do
				if not v797:IsA("UICorner") and not v797:IsA("UIStroke") then
					v797.ZIndex = 20
				end
			end
		end
		if v642.Tool then
			if shouldAllowSlotDragging(v642.Tool) then
				if CheckBounds(v44, v794.X, v794.Y) then
					if v642.Index <= v78 then
						if v7 ~= v6 then
							local v798 = GetCategory(v642.Tool)
							v8(v798)
						end
						v642:MoveToInventory()
						v1.Text = ""
						task.delay(0.01, function() -- line 4265 | captures: v3
							if v3 then
								v3(true)
							end
						end)
					end
					if v78 < v642.Index and v795 - v786 < 0.5 then
						if v63 and canPlaceToolInSlot(v63, v642.Tool) then
							v642:Clear()
							v63:Fill(v642.Tool)
							v642:Delete()
						end
						v786 = 0
					else
						v786 = v795
					end
				else
					if CheckBounds(v43, v794.X, v794.Y) then
						local v799 = { (1/0), nil }
						local v800 = v78
						for v801 = 1, v800 do
							local v802 = v62[v801]
							local v803 = GetOffset(v802.Frame, v794)
							if v803 < v799[1] then
								v799 = { v803, v802 }
							end
						end
						local v804 = v799[2]
						if v804 ~= v642 then
							v642:Swap(v804)
							if v78 < v642.Index then
								local Tool = v642.Tool
								if Tool then
									if Tool.Parent == v56 and v57 then
										UnequipAllTools()
									end
									if v73 then
										v642.Frame.Visible = false
										v642.Frame.Parent = v44
									end
								else
									v642:Delete()
								end
							end
						end
					elseif v642.Index <= v78 then
						v642:MoveToInventory()
						task.delay(0.01, function() -- line 4315 | captures: v3
							if v3 then
								v3(true)
							end
						end)
					elseif v642.Tool and v642.Tool:IsA("Tool") and v642.Tool.CanBeDropped then
						v642.Tool.Parent = workspace
					end
					v786 = v795
				end
				task.delay(0.01, function() -- line 4324 | captures: v3
					if v3 then
						v3(true)
					end
				end)
			else
				if v10 then
					v654:SetAttribute("Draggable", false)
				else
					v654.Draggable = false
				end
				v642:updateDragAppearance()
			end
		end
	end

	local v805, v806
	if v10 then
		v806 = false
		v640 = false
		v805 = nil
		v639 = nil

		local function drag(v807) -- line 4346 | captures: v639, v805, v806, v640, v654, v66
			if v639 and v805 then
				local v808 = v807 - v805
				v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v808.X, v639.Y.Scale, v639.Y.Offset + v808.Y)
			else
				v640 = false
				v806 = false
				v66[v654] = nil
			end
		end

		v654.InputBegan:Connect(function(v809) -- line 4362 | captures: v639, v805, v806, v640, v654, startDrag, v66
			if v654:GetAttribute("Draggable") then
				if v809.UserInputType == Enum.UserInputType.MouseButton1 then
					v640 = true
					UserInputService.InputChanged:Connect(function(v810) -- line 4369 | captures: v639, v805, v806, v640, v654, startDrag, v66
						if v640 then
							v640 = false
							startDrag(v654.Position)
							v806 = true
							v805 = UserInputService:GetMouseLocation()
							v639 = v654.Position
						end
						if v806 then
							if v810.UserInputType == Enum.UserInputType.MouseMovement or v810.UserInputType == Enum.UserInputType.Touch then
								local v811 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v812 = v811 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v812.X, v639.Y.Scale, v639.Y.Offset + v812.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							elseif string.find(v810.UserInputType.Name, "Gamepad") then
								local v813 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v814 = v813 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v814.X, v639.Y.Scale, v639.Y.Offset + v814.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							end
						end
					end)
					v809:GetPropertyChangedSignal("UserInputState")
				elseif v809.UserInputType == Enum.UserInputType.Touch then
					v640 = true
					UserInputService.InputChanged:Connect(function(v815) -- line 4422 | captures: v639, v805, v806, v640, v654, startDrag, v66
						if v640 then
							v640 = false
							startDrag(v654.Position)
							v806 = true
							v805 = UserInputService:GetMouseLocation()
							v639 = v654.Position
						end
						if v806 then
							if v815.UserInputType == Enum.UserInputType.MouseMovement or v815.UserInputType == Enum.UserInputType.Touch then
								local v816 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v817 = v816 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v817.X, v639.Y.Scale, v639.Y.Offset + v817.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							elseif string.find(v815.UserInputType.Name, "Gamepad") then
								local v818 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v819 = v818 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v819.X, v639.Y.Scale, v639.Y.Offset + v819.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							end
						end
					end)
					v809:GetPropertyChangedSignal("UserInputState")
				elseif v809.KeyCode == Enum.KeyCode.ButtonA then
					v640 = true
					UserInputService.InputChanged:Connect(function(v820) -- line 4475 | captures: v639, v805, v806, v640, v654, startDrag, v66
						if v640 then
							v640 = false
							startDrag(v654.Position)
							v806 = true
							v805 = UserInputService:GetMouseLocation()
							v639 = v654.Position
						end
						if v806 then
							if v820.UserInputType == Enum.UserInputType.MouseMovement or v820.UserInputType == Enum.UserInputType.Touch then
								local v821 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v822 = v821 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v822.X, v639.Y.Scale, v639.Y.Offset + v822.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							elseif string.find(v820.UserInputType.Name, "Gamepad") then
								local v823 = UserInputService:GetMouseLocation()
								if v639 and v805 then
									local v824 = v823 - v805
									v654.Position = UDim2.new(v639.X.Scale, v639.X.Offset + v824.X, v639.Y.Scale, v639.Y.Offset + v824.Y)
								else
									v640 = false
									v806 = false
									v66[v654] = nil
								end
							end
						end
					end)
					v809:GetPropertyChangedSignal("UserInputState")
				end
			end
		end)
	else
		v654.DragBegin:Connect(function(v825) -- CanvasSize | line 4332 | captures: startDrag
			startDrag(v825)
		end)
		local DragBegin = v654.DragStopped

		local function CanvasSize(v826, v827) -- line 4337 | captures: v743
			v743(Vector2.new(v826, v827))
		end

		v805 = CanvasSize
		DragBegin:Connect(CanvasSize)
	end
	v654.Parent = v637
	v806 = v62
	v806[v641] = v642
	v806 = v78
	if v806 < v641 then
		v806 = v47.CanvasPosition
		UpdateScrollingFrameCanvasSize()
		v639 = v47.AbsoluteSize.Y
		v640 = v47.CanvasSize.Y.Offset - v639
		v805 = v44.Visible
		if v805 then
			v805 = v73
			if v805 then
				v805 = v47
				v805.CanvasPosition = v806
			else
				v805 = v47
				local Y = v806.Y
				local new = Vector2.new
				local InputBegan = v806.X
				local v828 = v640
				local v829 = math.max(0, v828)
				v639 = new(InputBegan, (math.min(Y, v829)))
				v805.CanvasPosition = v639
			end
		else
			v805 = v47
			v805.CanvasPosition = v806
		end
	end
	return v642
end

function moveStackSlotIntoFrontHotbar(v830) -- line 4557 | captures: v78, v63, v62
	if v830 and not v830.IsDeleted then
		if v830.Index <= v78 then
			return v830
		end
		local v831 = getInsertableHotbarIndices(v830.Tool)
		local v832 = v831[1]
		if v832 then
			local v833 = v62[v832]
			if v833 then
				local v834 = v63
				local v835 = v834 and table.find(v831, v834.Index)
				local v836
				if v835 then
					v836 = v835
				else
					local v837 = v831[#v831]
					local v838 = v837 and v62[v837]
					if v838 and v838.Tool then
						v838:MoveToInventory()
						v836 = #v831
					else
						v836 = v835
					end
				end
				if v836 then
					for v839 = v836, 2, -1 do
						local v840 = v62[v831[v839]]
						local v841 = v62[v831[v839 - 1]]
						if v840 and v841 then
							v841:Swap(v840)
						end
					end
					v830:Swap(v833)
					if v78 < v830.Index and not v830.Tool then
						v830:Delete()
					end
					return v833
				end
			end
		end
	end
	return nil
end

function movePendingHotbarAssets() -- line 4608 | captures: v3, v83, v87
	local v842 = false
	for v843 in pairs(v87) do
		local v844 = v83[v843]
		if v844 then
			local v845 = moveStackSlotIntoFrontHotbar(v844)
			if v845 then
				v83[v843] = v845
				v87[v843] = nil
				v842 = true
			end
		end
	end
	if v842 then
		AdjustHotbarFrames()
		UpdateInventorySlots()
		if v3 then
			v3(true)
		end
	end
	return v842
end

function movePendingHotbarEggs() -- line 4631 | captures: v3, v24, v90, v92, v93
	local v846 = false
	for v847 in pairs(v92) do
		local v848 = v90[v847]
		if v848 then
			local v849 = moveStackSlotIntoFrontHotbar(v848)
			if v849 then
				v90[v847] = v849
				v92[v847] = nil
				v846 = true
			end
		end
	end
	if v846 then
		AdjustHotbarFrames()
		UpdateInventorySlots()
		if v3 then
			v3(true)
		end
	end
	for v850 in pairs(v93) do
		if v24:ForceEggIntoTutorialHotbar(v850) ~= nil then
			v93[v850] = nil
		end
	end
	return v846
end

function OnChildAdded(v851, v852) -- line 4659 | captures: v78, v3, LocalPlayer_2, v44, v47, v56, v57, v58, v68, v77, v64
	if v851:IsA("Tool") then
		if v851.Parent == v56 then
			v77 = tick()
		end
		local ItemType = v851:GetAttribute("ItemType")
		if ItemType == "Asset" then
			invalidateEquipBestStatus()
			syncVirtualAssetEquipStateFromTool(v851)
			task.defer(syncAssetsFromSave)
		elseif ItemType == "AssetEgg" then
			syncVirtualEggEquipStateFromTool(v851)
		else
			local v853 = v47
			local CanvasPosition = v47.CanvasPosition
			if v68 then
				local v854 = v64[v851]
				if v854 then
					v854:UpdateEquipView()
				else
					local v855 = insertToolIntoFrontHotbar(v851) or claimLowestEmptySlot(v851) or MakeSlot(v47)
					if v855.Tool ~= v851 then
						v855:Fill(v851)
					end
					if isGearTool(v851) then
						ensureGameplayGearHotbarSlots()
					end
					if v855.Index <= v78 and not v44.Visible then
						AdjustHotbarFrames()
					end
					UpdateInventorySlots()
					local v856 = v853.CanvasSize.Y.Offset - v853.AbsoluteSize.Y
					local new = Vector2.new
					local X = CanvasPosition.X
					local Y = CanvasPosition.Y
					local v857 = math.max(0, v856)
					v853.CanvasPosition = new(X, (math.min(Y, v857)))
					task.delay(0.05, function() -- line 4709 | captures: v3
						if v3 then
							v3(true)
						end
					end)
				end
			else
				local v858, v859
				if v851.Parent == v56 then
					if v64[v851] then
						v859 = true
					else
						local StarterGear = LocalPlayer_2:FindFirstChild("StarterGear")
						if StarterGear and StarterGear:FindFirstChild(v851.Name) then
							v68 = true
							v858 = insertToolIntoFrontHotbar(v851) or claimLowestEmptySlot(v851) or MakeSlot(v47)
							v859 = false
						else
							v859 = true
						end
					end
				else
					v859 = true
				end
				if v859 then
					return
				end
				if v858.Tool ~= v851 then
					v858:Fill(v851)
				end
				if isGearTool(v851) then
					ensureGameplayGearHotbarSlots()
				end
				for v860, v861 in pairs(v56:GetChildren()) do
					if v861:IsA("Tool") and v861 ~= v851 then
						v861.Parent = v58
					end
				end
				AdjustHotbarFrames()
				if v3 then
					v3(true)
				end
				UpdateInventorySlots()
				local v862 = v853.CanvasSize.Y.Offset - v853.AbsoluteSize.Y
				local new = Vector2.new
				local X = CanvasPosition.X
				local Y = CanvasPosition.Y
				local v863 = math.max(0, v862)
				v853.CanvasPosition = new(X, (math.min(Y, v863)))
			end
		end
	elseif v851:IsA("Humanoid") and v851.Parent == v56 then
		v57 = v851
	end
end

function OnChildRemoved(v864) -- line 4748 | captures: v78, v44, v56, v58, v77, v62, v64
	if not v864:IsA("Tool") then
		return
	end
	v77 = tick()
	local ItemType = v864:GetAttribute("ItemType")
	if ItemType == "Asset" then
		invalidateEquipBestStatus()
		task.defer(reconcileVirtualAssetEquipState)
		task.defer(syncAssetsFromSave)
		local v865 = v64[v864]
		if v865 and v865.Tool == v864 then
			v865:Clear()
			if v78 < v865.Index then
				v865:Delete()
			end
			if v865.Index <= v78 and not v44.Visible then
				AdjustHotbarFrames()
			end
			UpdateInventorySlots()
		end
	elseif ItemType == "AssetEgg" then
		task.defer(reconcileVirtualEggEquipState)
	else
		local v866 = v64[v864]
		local Parent = v864.Parent
		if Parent ~= v56 and Parent ~= v58 then
			if v866 then
				if v866.Tool == v864 then
				end
			else
				for v867, v868 in pairs(v62) do
					if v868.Tool == v864 then
						v866 = v868
						break
					end
				end
			end
			if v866 and v866.Tool == v864 then
				v866:Clear()
				if v78 < v866.Index then
					v866:Delete()
				end
				if v866.Index <= v78 and not v44.Visible then
					AdjustHotbarFrames()
				end
				UpdateInventorySlots()
			end
		end
	end
end

function SetupCharacter(v869) -- line 4801 | captures: LocalPlayer_2, v56, v58, v75, v82, v96, Constants, v62
	local function v870(v871, ...)
		table.insert(v871, ...)
	end

	local function v872(v873, ...)
		table.insert(v873, ...)
	end

	local function v874(v875, ...)
		table.insert(v875, ...)
	end

	local function v876(v877, ...)
		table.insert(v877, ...)
	end

	v82 = nil
	v96 = nil
	local v878 = #v62
	for v879 = v878, 1, -1 do
		local v880 = v62[v879]
		if v880.Tool then
			local Tool = v880.Tool
			if typeof(Tool) == "Instance" then
				v880:Clear()
			else
				v880:UpdateEquipView(true)
			end
		end
	end
	for v881, v882 in pairs(v75) do
		v882:Disconnect()
	end
	v75 = {}
	v56 = v869
	v870(v75, v869.ChildRemoved:Connect(OnChildRemoved))
	v872(v75, v869.ChildAdded:Connect(function(v883) -- line 4823 | captures: Constants
		if v883:IsA("Tool") then
			if v883.Name ~= Constants.LUCKY_BLOCK_TOOL_NAME and v883:GetAttribute("HideFromBackpackUI") ~= true then
				OnChildAdded(v883, false)
			end
		else
			OnChildAdded(v883, false)
		end
	end))
	for v884, v885 in pairs(v869:GetChildren()) do
		task.spawn(OnChildAdded, v885, false)
	end
	v58 = LocalPlayer_2:WaitForChild("Backpack")
	v874(v75, v58.ChildRemoved:Connect(OnChildRemoved))
	v876(v75, v58.ChildAdded:Connect(function(v886) -- line 4838 | captures: Constants
		if v886:IsA("Tool") then
			if v886.Name ~= Constants.LUCKY_BLOCK_TOOL_NAME and v886:GetAttribute("HideFromBackpackUI") ~= true then
				OnChildAdded(v886, true)
			end
		else
			OnChildAdded(v886, true)
		end
	end))
	for v887, v888 in pairs(v58:GetChildren()) do
		task.spawn(OnChildAdded, v888, false)
	end
	AdjustHotbarFrames()
	invalidateEquipBestStatus(true)
	reconcileVirtualAssetEquipState()
end

local PlayerGui_2 = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

function HandleInputBegan(v889, v890) -- line 4856 | captures: v44, v72, v59, v65, PlayerGui_2
	if v890 == false then
		local v891 = v65[v889.KeyCode.Value]
		if v891 == nil then
			if v889.UserInputType == Enum.UserInputType.MouseButton1 and not (not v44.Visible or ActiveFuseSelectionState) then
				local v892 = UserInputService:GetMouseLocation()
				for v893, v894 in PlayerGui_2:GetGuiObjectsAtPosition(v892.X, v892.Y) do
					if v894.Name:find("CategoryFrame") then
						return
					end
				end
				v59:deselect()
			end
		elseif not ActiveFuseSelectionState and not (v889.UserInputType == Enum.UserInputType.Keyboard and v72) then
			v891(v890)
		end
	end
end

function OnInputServiceChanged(v895) -- line 4891 | captures: v78, v62
	if v895 ~= "KeyboardEnabled" then
		return
	end
	local v896 = UserInputService.KeyboardEnabled and not UserInputService.VREnabled
	local v897 = v78
	for v898 = 1, v897 do
		v62[v898]:TurnNumber(v896)
	end
end

function OnGamepadFocus() -- line 4906
end

function unbindAllGamepadEquipActions() -- line 4907
	ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
	ContextActionService:UnbindAction("RBXCloseInventory")
end

function _setHotbarVisibility(v899, v900) -- line 4911 | captures: v78, v62
	local v901 = v78
	for v902 = 1, v901 do
		local v903 = v62[v902]
		if v903 and v903.Frame then
			if v900 then
				v903.Frame.Visible = v899
			elseif v903.Tool then
			end
		end
	end
end

function getEquippedHotbarSlot() -- line 4926 | captures: v78, v56, v64, v83, v90
	local v904 = reconcileVirtualAssetEquipState()
	if typeof(v904) == "string" then
		local v905 = v83[v904]
		if v905 and not v905.IsDeleted and v905.Index <= v78 and v905.Tool then
			return v905
		end
	else
		local v906 = reconcileVirtualEggEquipState()
		if typeof(v906) == "string" then
			local v907 = v90[v906]
			if v907 and not v907.IsDeleted and v907.Index <= v78 and v907.Tool then
				return v907
			end
		else
			if v56 then
				for v908, v909 in ipairs(v56:GetChildren()) do
					if v909:IsA("Tool") then
						local v910 = v64[v909]
						if v910 and v910.Index <= v78 and v910.Tool then
							return v910
						end
					end
				end
			end
			return nil
		end
	end
end

function changeTool(v911, v912, v913) -- line 4958 | captures: v78, v62
	if v912 ~= Enum.UserInputState.Begin then
		return
	end
	local v914 = if v913.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1
	local v915 = getEquippedHotbarSlot()
	local v916
	if v915 then
		v916 = v915.Index
	elseif v914 == -1 then
		v916 = 1
	else
		v916 = v78
	end
	local v917 = v78
	for v918 = 1, v917 do
		v916 += v914
		if v78 < v916 then
			v916 = 1
		elseif v916 < 1 then
			v916 = v78
		end
		local v919 = v62[v916]
		if v919.Tool and v919 ~= v915 then
			v919:Select()
			return
		end
	end
end

function getGamepadSwapSlot() -- line 4992 | captures: v62
	local v920 = #v62
	for v921 = 1, v920 do
		if v62[v921].Frame:WaitForChild("UIStroke").Thickness > 0 then
			return v62[v921]
		end
	end
end

function changeSlot(v922) -- line 5001 | captures: v78, v44, v46, GuiService
	if v922.IsFakeSlot then
		v922:Select()
	else
		local v923 = not VRService.VREnabled or v44.Visible
		if v922.Frame == GuiService.SelectedObject and v923 then
			local v924 = getGamepadSwapSlot()
			if v924 then
				v924.Frame:WaitForChild("UIStroke").Thickness = 0
				if v924 ~= v922 then
					v922:Swap(v924)
					v46.SelectionImageObject.Visible = false
					if v78 < v922.Index and not v922.Tool then
						if GuiService.SelectedObject == v922.Frame then
							GuiService.SelectedObject = v924.Frame
						end
						v922:Delete()
					end
					local v925 = v78
					if v924.Index <= v925 or v924.Tool then
						return
					end
					if GuiService.SelectedObject == v924.Frame then
						GuiService.SelectedObject = v922.Frame
					end
					v924:Delete()
				end
			else
				local Size = v922.Frame.Size
				local Position = v922.Frame.Position
				v922.Frame:TweenSizeAndPosition(Size + UDim2.new(0, 10, 0, 10), Position - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() -- line 5023 | captures: v922, Size, Position
					v922.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
				end)
				v922.Frame:WaitForChild("UIStroke").Thickness = 3
				v46.SelectionImageObject.Visible = true
			end
		else
			v922:Select()
			v46.SelectionImageObject.Visible = false
		end
	end
end

function vrMoveSlotToInventory() -- line 5052 | captures: v46
	if VRService.VREnabled then
		local v926 = getGamepadSwapSlot()
		if v926 and v926.Tool then
			v926:WaitForChild("UIStroke").Thickness = 0
			v926:MoveToInventory()
			v46.SelectionImageObject.Visible = false
		end
	end
end

function enableGamepadInventoryControl() -- line 5064 | captures: v43, v44, GuiService, v59
	ContextActionService:BindAction("RBXBackpackHasGamepadFocus", OnGamepadFocus, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction("RBXCloseInventory", function(v927, v928) -- line 5066 | captures: v44, v59
		if v928 == Enum.UserInputState.Begin then
			local v929 = getGamepadSwapSlot()
			if v929 then
				v929.Frame:WaitForChild("UIStroke").Thickness = 0
			elseif v44.Visible then
				v59:deselect()
			end
		end
	end, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart, Enum.KeyCode.ButtonSelect)
	if not UserInputService.VREnabled then
		GuiService.SelectedObject = v43:FindFirstChild("1")
	end
end

function disableGamepadInventoryControl() -- line 5084 | captures: v78, v41, GuiService, v62
	unbindAllGamepadEquipActions()
	local v930 = v78
	for v931 = 1, v930 do
		local v932 = v62[v931]
		if v932 and v932.Frame then
			v932.Frame:WaitForChild("UIStroke").Thickness = 0
		end
	end
	if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(v41) then
		GuiService.SelectedObject = nil
	end
end

function _bindBackpackHotbarAction() -- line 5100 | captures: v38, v69
	if v69 and not v38 then
		v38 = true
		ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
end

function _unbindBackpackHotbarAction() -- line 5106 | captures: v38
	disableGamepadInventoryControl()
	v38 = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected() -- line 5111 | captures: v76
	v76 = false
	disableGamepadInventoryControl()
end

function gamepadConnected() -- line 5115 | captures: v38, v41, v44, v67, v69, v76, GuiService
	v76 = true
	GuiService:AddSelectionParent("RBXBackpackSelection", v41)
	if v67 >= 1 and v69 and not v38 then
		v38 = true
		ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
	if v44.Visible then
		enableGamepadInventoryControl()
	end
end

function OnIconChanged(v933) -- line 5126 | captures: v38, v41, v67, v69, GuiService, tryCore, v59
	local v934 = v933 and tryCore("GetCore", "TopbarEnabled")
	local v935 = v934 and not GuiService.MenuIsOpen and not ActiveFuseSelectionState
	v59:setEnabled(v935)
	v69 = v934
	v41.Visible = v934
	PositionInventoryAffordances()
	if v934 then
		if not (v67 < 1) and v69 and not v38 then
			v38 = true
			ContextActionService:BindAction("RBXHotbarEquip", changeTool, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
		end
	else
		disableGamepadInventoryControl()
		v38 = false
		ContextActionService:UnbindAction("RBXHotbarEquip")
	end
end

function createScrollButton(v936, v937) -- line 5155
	local v938 = NewGui("ImageButton", v936)
	v938.Size = UDim2.new(0, 40, 0, 40)
	v938.Image = "rbxasset://textures/ui/Keyboard/close_button_background.png"
	local Icon = NewGui("ImageLabel", "Icon")
	Icon.Size = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Position = UDim2.new(0.25, 0, 0.25, 0)
	Icon.Image = v937
	Icon.Parent = v938
	local Selection = NewGui("ImageLabel", "Selection")
	Selection.Size = UDim2.new(0.9, 0, 0.9, 0)
	Selection.Position = UDim2.new(0.05, 0, 0.05, 0)
	Selection.Image = "rbxasset://textures/ui/Keyboard/close_button_selection.png"
	v938.SelectionImageObject = Selection
	return v938, Icon, Selection
end

v41 = BackpackGui:WaitForChild("Backpack")
v41.Visible = false
v43 = NewGui("Frame", "Hotbar")
v43.Parent = v41

local RoundChoices = script:FindFirstChild("RoundChoices")

if RoundChoices then
	RoundChoices.Parent = v43
	if v39 then
		RoundChoices.Size = UDim2.fromScale(1, 0.4)
	end
elseif RunService:IsStudio() then
	error("RoundChoices frame not found in Backpack script")
end
local v939 = v78
for v940 = 1, v939 do
	MakeSlot(v43, v940).Frame.Visible = false
end
v42 = v41:WaitForChild("Main")
v44 = v42:WaitForChild("Inventory")
local Loading = v44:WaitForChild("Loading")

Loading.Visible = false
task.spawn(WarmAssets, v44.ImageLabel.ImageLabel)
AutoSell = v44.AutoSell
AutoSell.Visible = false
task.spawn(initializeAutoSellUI)
AdjustHotbarFrames()
v59.selected:Connect(function() -- line 5198 | captures: GuiService, v24
	if not GuiService.MenuIsOpen then
		v24.OpenClose()
	end
end)
v59.deselected:Connect(function() -- line 5203 | captures: v44, v24
	if v44.Visible then
		v24.OpenClose()
	end
end)
local selected = NewGui("ImageLabel", "LeftBumper")

selected.Size = UDim2.new(0, 40, 0, 40)

local v941 = -selected.Size.X.Offset

selected.Position = UDim2.new(0, v941, 0.5, -selected.Size.Y.Offset / 2)

local RightBumper = NewGui("ImageLabel", "RightBumper")

RightBumper.Size = UDim2.new(0, 40, 0, 40)
RightBumper.Position = UDim2.new(1, 0, 0.5, -RightBumper.Size.Y.Offset / 2)

local BackgroundColor3 = v44.BackgroundColor3

InventoryStroke = v44:FindFirstChildWhichIsA("UIStroke")

if InventoryStroke then
	InventoryStrokeDefaultColor = InventoryStroke.Color
else
	InventoryStrokeDefaultColor = nil
end
InventoryStrokeDefaultTransparency = v44.BackgroundTransparency
v44.Visible = false

function refreshInventoryFrameVisuals() -- line 5225 | captures: v34, v44, v45, BackgroundColor3
	if ActiveFuseSelectionState then
		v44.BackgroundColor3 = FUSE_SELECTION_BACKGROUND_COLOR
		if InventoryStroke then
			InventoryStroke.Color = FUSE_SELECTION_STROKE_COLOR
		end
		v44.BackgroundTransparency = FUSE_SELECTION_BACKGROUND_TRANSPARENCY
	else
		v44.BackgroundColor3 = v34 and v45 or BackgroundColor3
		if InventoryStroke and InventoryStrokeDefaultColor then
			InventoryStroke.Color = InventoryStrokeDefaultColor
		end
		v44.BackgroundTransparency = InventoryStrokeDefaultTransparency
	end
end

local UIStroke = Instance.new("UIStroke")

UIStroke.Name = "FavoriteMode"
UIStroke.Thickness = 4.5
UIStroke.Color = Color3.fromRGB(255, 170, 0)
UIStroke.Enabled = false
UIStroke.ZIndex = 2
UIStroke.Parent = v44

function updateFavoriteModeVisuals() -- line 5257 | captures: v33, v34, UIStroke
	local v942 = v33 and v33:FindFirstChildWhichIsA("TextLabel")
	if v942 then
		if v34 then
			v942.Text = "Favorite: ON"
		else
			v942.Text = "Favorite: OFF"
		end
	end
	if UIStroke then
		local v943 = v34 and not ActiveFuseSelectionState
		UIStroke.Enabled = v943
	end
	refreshInventoryFrameVisuals()
end

function setFavoriteModeActive(v944) -- line 5280 | captures: v33, v34, UIStroke
	v34 = v944
	if v33 then
		updateFavoriteModeVisuals()
	else
		refreshInventoryFrameVisuals()
		if UIStroke then
			local v945 = v34 and not ActiveFuseSelectionState
			UIStroke.Enabled = v945
		end
	end
end

function hideFavoriteModeButton() -- line 5295 | captures: v33, v34, AutoSell, v97
	if v34 then
		setFavoriteModeActive(false)
	end
	if not v33 then
		return
	end
	v33.Visible = false
	if AutoSell then
		AutoSell.Visible = false
	end
	if v97 then
		v97.Visible = false
	end
end

function refreshFavoriteModeVisibility() -- line 5309 | captures: v6, v7, v33, AutoSell, v97, v11
	if not v33 then
		return
	end
	local v946 = v11[v7]
	local v947 = v7 == v6
	if v946 and v946.Tags then
		for v948, v949 in v946.Tags do
			if v949 == "Asset" then
				v947 = true
				break
			end
		end
	end
	if v947 then
		v33.Visible = false
		if AutoSell then
			AutoSell.Visible = false
		end
		if v97 then
			v97.Visible = false
		end
	else
		hideFavoriteModeButton()
	end
	updateEquipBestButtonVisibility()
end

v33 = v44:FindFirstChild("FavoriteMode") or script:FindFirstChild("FavoriteMode")

if v33 then
	v33.Parent = v44
	v33.Visible = false
	updateFavoriteModeVisuals()
	ButtonFX(v33, nil, function() -- line 5349 | captures: v34
		setFavoriteModeActive(not v34)
	end)
end
v97 = v44:FindFirstChild("EquipBest")

if v97 then
	v97.Visible = false
	ButtonFX(v97, nil, requestEquipBest)
end
local FavoriteMode = script:FindFirstChild("EquipBest")

if FavoriteMode and FavoriteMode:IsA("GuiButton") then
	v98 = FavoriteMode:Clone()
	local v950 = v98
	assert(v950, "missing hotbar")
	v98.Parent = v43
	v98.Visible = false
	ButtonFX(v98, nil, requestEquipBest)
end
FavoriteMode = v44:FindFirstChild("CategoryLabel") or script.CategoryTemplate:Clone()
FavoriteMode.Parent = v44

if not FavoriteMode:IsA("TextLabel") then
	FavoriteMode = FavoriteMode:FindFirstChildWhichIsA("TextLabel", true)
end
local FavoriteMode_2 = FavoriteMode
local v951 = FavoriteMode and FavoriteMode:IsA("TextLabel")
assert(v951, "Category label template must contain a TextLabel")
local v952 = {}
local v953 = {}

local function u2904() -- line 5383 | captures: v953
	local v954 = ActiveFuseSelectionState
	local v955 = v954 ~= nil
	for v956, v957 in v953 do
		local v958 = if v955 then v954.AllowedCategories[v956] == true else true
		v957.Visible = v958
		local ImageButton = v957:FindFirstChild("ImageButton")
		if ImageButton and ImageButton:IsA("GuiButton") then
			ImageButton.Active = v958
		end
	end
end

function updateCategorySelectionVisuals() -- line 5399 | captures: v7, v952
	for v959, v960 in v952 do
		v960.Enabled = v959 == v7
	end
end

function updateCategoryLabel(v961) -- line 5409 | captures: FavoriteMode_2
	FavoriteMode_2.Text = v961
end

function applyCategoryLayout() -- line 5412 | captures: v47, v48, v49, v50, AspectRatio, v51, v52, v53, PaddingLeft, v54
	if v48 and v47 then
		v49 = v49 or v48.CellSize
	else
		return
	end
	if not v50 then
		v50 = v48:FindFirstChildWhichIsA("UIAspectRatioConstraint") or v47:FindFirstChildWhichIsA("UIAspectRatioConstraint")
		if v50 then
			AspectRatio = v50.AspectRatio
		end
	end
	v53 = v53 or v47.ScrollingDirection
	v51 = v51 or v48.FillDirection
	v52 = v52 or v48.HorizontalAlignment
	if v54 and not PaddingLeft then
		PaddingLeft = v54.PaddingLeft
	end
	v48.CellSize = v49
	if v50 and AspectRatio then
		v50.AspectRatio = AspectRatio
	end
	v47.AutomaticCanvasSize = Enum.AutomaticSize.None
	v47.ScrollingDirection = v53
	v48.FillDirection = v51
	v48.HorizontalAlignment = v52
	if v54 and PaddingLeft then
		v54.PaddingLeft = PaddingLeft
	end
end

function v8(v962) -- line 5453 | captures: v6, v1, v3, v4, v7, v34, v47, Loading
	local v963
	if ActiveFuseSelectionState then
		if ActiveFuseSelectionState.AllowedCategories[v962] == true then
			v963 = v962
		else
			v963 = ActiveFuseSelectionState.PreferredCategory
		end
	else
		v963 = v962
	end
	if v7 == v963 then
		updateCategoryLabel(v963)
	else
		v7 = v963
		applyCategoryLayout()
		local v964
		if v1 then
			if v1.Text == "" then
				v964 = true
			else
				if v4 then
					v4()
				end
				v964 = false
			end
		else
			v964 = true
		end
		if not v964 then
			v1.Text = ""
		end
		if v7 ~= v6 and v34 then
			setFavoriteModeActive(false)
		end
		if Loading and v7 ~= v6 then
			Loading.Visible = false
		end
		refreshFavoriteModeVisibility()
		updateCategoryLabel(v963)
		if v47 then
			v47.CanvasPosition = Vector2.new(0, 0)
		end
		v3()
	end
	updateCategorySelectionVisuals()
end

local CategoryFrame = v44:WaitForChild("CategoryFrame")
local CategoryTemplate = CategoryFrame.CategoryTemplate

if not CategoryFrame:FindFirstChildWhichIsA("UIGridLayout") then
	CategoryFrame:FindFirstChildWhichIsA("UIListLayout")
end

function createHintForCategory(v965, v966) -- line 5494
	local v967, v968, v969 = v965:ToHSV()
	local v970 = v969 + v966
	local v971 = math.clamp(v970, 0, 1)
	return Color3.fromHSV(v967, v968, v971)
end

local ImageButton
for v972, v973 in v5 do
	local Name = v973.Name
	local v974 = CategoryTemplate:Clone()
	ImageButton = v974.ImageButton
	local CategoryName = v974:FindFirstChild("CategoryName")
	if CategoryName and CategoryName:IsA("TextLabel") then
		CategoryName.Text = Name
	end
	local BackgroundColor3 = v974.BackgroundColor3
	local v975 = TweenService:Create(v974, TweenInfo.new(0.2), { BackgroundColor3 = createHintForCategory(BackgroundColor3, 0.2) })
	local v976 = TweenService:Create(v974, TweenInfo.new(0.2), { BackgroundColor3 = BackgroundColor3 })
	local MouseEnter = ImageButton.MouseEnter
	MouseEnter:Connect(function() -- line 5516 | captures: v975
		v975:Play()
	end)
	MouseEnter = ImageButton.MouseLeave
	MouseEnter:Connect(function() -- line 5519 | captures: v976
		v976:Play()
	end)
	MouseEnter = ImageButton.MouseButton1Down
	MouseEnter:Connect(function() -- line 5522 | captures: v976
		v976:Play()
	end)
	MouseEnter = ImageButton.MouseButton1Up
	MouseEnter:Connect(function() -- line 5525 | captures: v8, Name, v975
		v975:Play()
		v8(Name)
	end)
	local UIStroke = v974.UIStroke
	MouseEnter = UIStroke:IsA("UIStroke")
	assert(MouseEnter, "Category button UIStroke must be a UIStroke")
	UIStroke.Enabled = false
	v952[Name] = UIStroke
	v953[Name] = v974
	ImageButton.Image = v973.Image
	v974.Visible = true
	v974.Parent = CategoryFrame
end
u2904()
updateCategoryLabel(v7)
updateCategorySelectionVisuals()
refreshFavoriteModeVisibility()
v46 = NewGui("TextButton", "VRInventorySelector")
local v977 = UDim2.new(0, 0, 0, 0)

v46.Position = v977
v977 = UDim2.new(1, 0, 1, 0)
v46.Size = v977
v46.BackgroundTransparency = 1
v46.Text = ""
v46.Parent = v44
v977 = NewGui("ImageLabel", "Selector")
v977.Size = UDim2.new(1, 0, 1, 0)
v977.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v977.ScaleType = Enum.ScaleType.Slice
v977.SliceCenter = Rect.new(12, 12, 52, 52)
v977.Visible = false
v46.SelectionImageObject = v977
v46.MouseButton1Click:Connect(function() -- line 5556
	vrMoveSlotToInventory()
end)
v47 = v44:WaitForChild("ScrollingFrame")
v48 = v47:WaitForChild("UIGridLayout")
v54 = v47:FindFirstChildWhichIsA("UIPadding")
v50 = v48:FindFirstChildWhichIsA("UIAspectRatioConstraint") or v47:FindFirstChildWhichIsA("UIAspectRatioConstraint")

if v39 then
	v977 = UDim2.new(v48.CellSize.X.Scale, v48.CellSize.X.Offset, v48.CellSize.Y.Scale, v48.CellSize.Y.Offset / 2)
	v48.CellSize = v977
end
applyCategoryLayout()
local v978 = createScrollButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v978.Size = UDim2.new(0, 34, 0, 34)
v978.Position = UDim2.new(0.5, -v978.Size.X.Offset / 2, 0, 43)
v978.Icon.Position = v978.Icon.Position - UDim2.new(0, 0, 0, 2)
v978.MouseButton1Click:Connect(function() -- line 5578 | captures: v47, v40
	local v979 = v47.CanvasSize.Y.Offset - v47.AbsoluteWindowSize.Y
	local v980 = v47
	local new = Vector2.new
	local X = v47.CanvasPosition.X
	local v981 = v47.CanvasPosition.Y - (v40 + 5)
	local v982 = math.max(0, v981)
	v980.CanvasPosition = new(X, (math.min(v979, v982)))
end)
local v983 = createScrollButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v983.Rotation = 180
v983.Icon.Position = v983.Icon.Position - UDim2.new(0, 0, 0, 2)
v983.Size = UDim2.new(0, 34, 0, 34)
v983.Position = UDim2.new(0.5, -v983.Size.X.Offset / 2, 1, -v983.Size.Y.Offset - 3)
v983.MouseButton1Click:Connect(function() -- line 5588 | captures: v47, v40
	local v984 = v47.CanvasSize.Y.Offset - v47.AbsoluteWindowSize.Y
	local v985 = v47
	local new = Vector2.new
	local X = v47.CanvasPosition.X
	local v986 = v47.CanvasPosition.Y + (v40 + 5)
	local v987 = math.max(0, v986)
	v985.CanvasPosition = new(X, (math.min(v984, v987)))
end)
v47.Changed:Connect(function(v988) -- line 5592 | captures: v47, v978, v983
	if v988 ~= "AbsoluteWindowSize" then
		return
	end
	local v989 = v47.CanvasPosition.Y ~= 0
	local v990 = v47.CanvasPosition.Y < v47.CanvasSize.Y.Offset - v47.AbsoluteWindowSize.Y
	v978.Visible = v989
	v983.Visible = v990
end)
ResizeContainers()
v44:GetPropertyChangedSignal("Visible"):Connect(PositionInventoryAffordances)
PlatformSignal.Changed:Connect(PositionInventoryAffordances)
PositionInventoryAffordances()
local v991 = Utility:Create("Frame")
local v992 = {
	Name = "GamepadHintsFrame",
	BackgroundTransparency = 1,
	Visible = false
}

if v36 then
	ImageButton = 95
else
	ImageButton = 60
end
v992.Size = UDim2.new(0, v43.Size.X.Offset, 0, ImageButton)
v992.Parent = v41

local v993 = v991(v992)

function createHint(v994, v995, v996) -- line 5616 | captures: v36, v993
	local v997 = Utility:Create("Frame")({
		Name = "HintFrame",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -5),
		Position = UDim2.new(0, 0, 0, 0),
		Parent = v993
	})
	local ImageLabel = Utility:Create("ImageLabel")
	local v998 = {
		Name = "HintImage",
		BackgroundTransparency = 1
	}
	if v36 then
		v998.Size = UDim2.new(0, 90, 0, 90)
	else
		v998.Size = UDim2.new(0, 60, 0, 60)
	end
	if v36 then
		v998.Image = v995
	else
		v998.Image = v994
	end
	v998.Parent = v997
	ImageLabel(v998)
	local TextLabel = Utility:Create("TextLabel")
	local v999 = {
		Name = "HintText",
		BackgroundTransparency = 1,
		TextWrapped = true
	}
	local v1000 = if v36 then 100 else 70
	v999.Position = UDim2.new(0, v1000, 0, 0)
	local v1001 = if v36 then 100 else 70
	v999.Size = UDim2.new(1, -v1001, 1, 0)
	v999.Font = Enum.Font.SourceSansBold
	v999.FontSize = v36 and Enum.FontSize.Size36 or Enum.FontSize.Size24
	v999.Text = v996
	v999.TextColor3 = Color3.new(1, 1, 1)
	v999.TextXAlignment = Enum.TextXAlignment.Left
	v999.Parent = v997
	local v1002 = TextLabel(v999)
	Instance.new("UITextSizeConstraint", v1002).MaxTextSize = v1002.TextSize
end

function PositionHintFrame() -- line 5674 | captures: v43, v44, v36, v993
	local v1003 = if v36 then 95 else 60
	v993.Size = UDim2.new(v43.Size.X.Scale, v43.Size.X.Offset, 0, v1003)
	v993.Position = UDim2.new(v43.Position.X.Scale, v43.Position.X.Offset, v44.Position.Y.Scale, v44.Position.Y.Offset - v993.Size.Y.Offset)
	local v1004 = v993:GetChildren()
	local v1005 = #v1004
	local v1006 = 0
	for v1007 = 1, v1005 do
		v1004[v1007].Size = UDim2.new(1, 0, 1, -5)
		v1004[v1007].Position = UDim2.new(0, 0, 0, 0)
		v1006 += v1004[v1007].HintText.Position.X.Offset + v1004[v1007].HintText.TextBounds.X
	end
	local v1008 = (v993.AbsoluteSize.X - v1006) / (#v1004 - 1)
	local v1009 = #v1004
	for v1010 = 1, v1009 do
		local v1011 = v1004[v1010]
		if v1010 == 1 then
			v1011.Position = UDim2.new(0, 0, 0, 0)
		else
			v1011.Position = UDim2.new(0, v1004[v1010 - 1].Position.X.Offset + v1004[v1010 - 1].Size.X.Offset + v1008, 0, 0)
		end
		v1004[v1010].Size = UDim2.new(0, v1004[v1010].HintText.Position.X.Offset + v1004[v1010].HintText.TextBounds.X, 1, -5)
	end
end

createHint("rbxasset://textures/ui/Settings/Help/XButtonDark.png", "rbxasset://textures/ui/Settings/Help/XButtonDark@2x.png", "Remove From Hotbar ")
createHint("rbxasset://textures/ui/Settings/Help/AButtonDark.png", "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png", "Select/Swap")
createHint("rbxasset://textures/ui/Settings/Help/BButtonDark.png", "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png", "Close Backpack")
local Search = v44:WaitForChild("Search")
v1 = Search:WaitForChild("TextBox")
v1.ClearTextOnFocus = false

local v1012 = Enum.TextXAlignment.Left

v1.TextXAlignment = v1012
CloseButton = v44:FindFirstChild("Close")

if CloseButton and CloseButton:IsA("GuiButton") then
	ButtonFX(CloseButton, nil, function() -- line 5715 | captures: v44, v24
		if v44.Visible then
			v24.OpenClose()
		end
	end)
end
v1012 = Search:FindFirstChild("StrokeTemplate")
local v1013 = v1012

if not v1012 then
	v1012 = Search:FindFirstChildWhichIsA("UIStroke")
	v1013 = v1012
	if not v1012 then
		v1012 = script.StrokeTemplate:Clone()
		v1013 = v1012
	end
end
v1012.Enabled = false
v1012.Parent = Search
task.spawn(function() -- line 5730 | captures: v1013, TweenService
	while true do
		task.wait()
		if v1013.Enabled then
			local v1014 = TweenInfo.new(0.05)
			local v1015 = TweenService:Create(v1013.UIGradient, v1014, { Rotation = v1013.UIGradient.Rotation + 1 })
			v1015:Play()
			v1015.Completed:Wait()
		end
	end
end)
local v1016 = Search:FindFirstChild("X")
local v1017 = v1016

if not v1016 then
	v1016 = Search:FindFirstChild("ClearSearch")
	v1017 = v1016
	if not v1016 then
		v1016 = Search:WaitForChild("X")
		v1017 = v1016
	end
end
v1016.Visible = false

function PerformSearch() -- line 5750 | captures: v1017, v78, v1, v44, v47, v73, v62
	if v1.Text == "" then
		ResetSearchResults()
	else
		local v1018 = {}
		for v1019 in v1.Text:gmatch("%S+") do
			v1018[v1019:lower()] = true
		end
		local v1020 = {}
		local v1021 = v78 + 1
		local v1022 = #v62
		for v1023 = v1021, v1022 do
			local v1024 = v62[v1023]
			if v1024 and v1024.Tool then
				if IsOfCategory(v1024.Tool) then
					local v1025 = {
						v1024,
						v1024:CheckTerms(v1018)
					}
					table.insert(v1020, v1025)
					v1024.Frame.Visible = false
					pcall(function() -- line 5771 | captures: v1024, v44
						v1024.Frame.Parent = v44
					end)
				else
					v1024.Frame.Visible = false
				end
			end
		end
		table.sort(v1020, function(v1026, v1027) -- line 5779
			return v1027[2] < v1026[2]
		end)
		v73 = true
		local v1028 = 0
		for v1029, v1030 in ipairs(v1020) do
			local v1031 = v1030[1]
			if v1030[2] <= 0 then
				v1031.Frame.Visible = false
			else
				v1031.Frame.Visible = true
				v1031.Frame.Parent = v47
				v1031.Frame.LayoutOrder = v78 + v1028
				v1028 += 1
			end
		end
		UpdateScrollingFrameCanvasSize()
		v1017.ZIndex = 2000
	end
end

v3 = PerformSearch

function ResetSearchResults() -- line 5800 | captures: v1017, v78, v47, v73, v62
	v73 = false
	local v1032 = v78 + 1
	local v1033 = #v62
	for v1034 = v1032, v1033 do
		local v1035 = v62[v1034]
		if v1035 and v1035.Tool then
			if IsOfCategory(v1035.Tool) then
				v1035.Frame.Parent = v47
				v1035.Frame.Visible = true
			else
				v1035.Frame.Visible = false
			end
		end
	end
	v1017.ZIndex = 0
	UpdateInventorySlots()
end

v4 = ResetSearchResults

function ClearSearchText() -- line 5821 | captures: v1
	ResetSearchResults()
	v1.Text = ""
end

function OnSearchTextChanged(v1036) -- line 5825 | captures: v1017, v1, v1013
	if v1036 ~= "Text" then
		return
	end
	PerformSearch()
	local v1037 = v1.Text ~= ""
	v1017.Visible = v1037
	v1013.Enabled = v1037
end

function OnSearchFocusLost(v1038) -- line 5833
	if v1038 then
		PerformSearch()
	end
end

v1017.MouseButton1Click:Connect(ClearSearchText)
v1.Changed:Connect(OnSearchTextChanged)
v1.FocusLost:Connect(OnSearchFocusLost)
v24.StateChanged.Event:Connect(function(v1039) -- line 5841 | captures: v44, v59
	if not v1039 and not v44.Visible then
		v59:deselect()
	end
end)

function OnEscapePressed(v1040) -- line 5846 | captures: v44, v59
	if not (v1040 or ActiveFuseSelectionState) and v44.Visible then
		v59:deselect()
	end
end

function OnFavoritePressed() -- line 5854
	if not ActiveFuseSelectionState and SelectedSlot then
		local Tool = SelectedSlot.Tool
		if Tool then
			requestFavoriteToggle(Tool)
		end
	end
end

v65[Enum.KeyCode.Escape.Value] = OnEscapePressed
v65[Enum.KeyCode.ButtonL2.Value] = OnFavoritePressed
UserInputService.LastInputTypeChanged:Connect(function(v1041) -- line 5865 | captures: Search
	if not (v1041 ~= Enum.UserInputType.Gamepad1 or UserInputService.VREnabled) then
		Search.Visible = false
	end
end)
GuiService.MenuOpened:Connect(function() -- line 5871 | captures: v44, v59
	if v44.Visible then
		v59:deselect()
	end
end)

function RemoveSlotAction(v1042, v1043, v1044) -- line 5876 | captures: v78, v4, GuiService, v62
	if not (v1043 == Enum.UserInputState.Begin and GuiService.SelectedObject) then
		return
	end
	local v1045 = v78
	for v1046 = 1, v1045 do
		if v62[v1046].Frame == GuiService.SelectedObject and v62[v1046].Tool then
			v62[v1046]:MoveToInventory()
			v4()
			return
		end
	end
	v4()
end

function setInventoryVisibility(v1047) -- line 5891 | captures: v78, v26, v34, v35, v43, v44, v76, v24, v29, v62, v993
	v44.Visible = v1047
	AdjustHotbarFrames()
	v43.Active = not v1047
	local v1048 = v78
	for v1049 = 1, v1048 do
		v62[v1049]:SetClickability(not v1047)
	end
	if v44.Visible then
		if v76 then
			if v29[UserInputService:GetLastInputType()] then
				PositionHintFrame()
				v993.Visible = not UserInputService.VREnabled
			end
			enableGamepadInventoryControl()
		end
	else
		if v76 then
			v993.Visible = false
		end
		disableGamepadInventoryControl()
	end
	if v44.Visible then
		ContextActionService:BindAction("RBXRemoveSlot", RemoveSlotAction, false, Enum.KeyCode.ButtonX)
	else
		ContextActionService:UnbindAction("RBXRemoveSlot")
	end
	v24.IsOpen = v44.Visible
	v24.StateChanged:Fire(v44.Visible)
	if not v44.Visible then
		if ActiveFuseSelectionState and v35 then
			v35(false)
		else
			v26 = nil
			if v34 then
				setFavoriteModeActive(false)
			end
		end
	end
end

function v24.OpenClose() -- line 5933 | captures: v44, v70, v24, v66
	if v70 then
		if v44.Visible then
			if ActiveFuseSelectionState then
				if v44.Visible then
					setInventoryVisibility(false)
				else
					v24.IsOpen = v44.Visible
				end
			elseif not next(v66) then
				setInventoryVisibility(not v44.Visible)
			end
		end
	elseif ActiveFuseSelectionState then
		if v44.Visible then
			setInventoryVisibility(false)
		else
			v24.IsOpen = v44.Visible
		end
	elseif not next(v66) then
		setInventoryVisibility(not v44.Visible)
	end
end

function setFuseSelectionSlotClickability(v1050) -- line 5965 | captures: v62
	for v1051, v1052 in v62 do
		if v1052 and v1052.Tool then
			v1052:SetClickability(not v1050)
		end
	end
end

function captureFuseHotbarSnapshot() -- line 5975 | captures: v78, v62
	local v1053 = {}
	local v1054 = v78
	for v1055 = 1, v1054 do
		local v1056 = v62[v1055]
		if v1056 then
			local Tool = v1056.Tool
			if not v1056.IsFakeSlot and typeof(Tool) == "Instance" and Tool:IsA("Tool") and isAssetTool(Tool) then
				v1053[v1055] = Tool
			end
		end
	end
	return v1053
end

function moveFuseHotbarAssetsToInventory() -- line 5992 | captures: v78, v62
	local v1057 = v78
	for v1058 = 1, v1057 do
		local v1059 = v62[v1058]
		if v1059 and not v1059.IsFakeSlot and v1059.Tool and isAssetTool(v1059.Tool) then
			v1059:MoveToInventory()
		end
	end
end

function restoreFuseHotbarSnapshot(v1060) -- line 6003 | captures: v78, v62, v64
	local v1061 = {}
	for v1062, v1063 in v1060 do
		if typeof(v1063) == "Instance" and v1063:IsA("Tool") and v1063.Parent then
			v1061[v1063] = v1062
		end
	end
	local v1064 = v78
	for v1065 = 1, v1064 do
		local v1066 = v62[v1065]
		if v1066 and not v1066.IsFakeSlot and v1066.Tool and isAssetTool(v1066.Tool) and not v1061[v1066.Tool] then
			v1066:MoveToInventory()
		end
	end
	for v1067, v1068 in nil do
		if typeof(v1068) == "Instance" and v1068:IsA("Tool") and v1068.Parent then
			local v1069 = v62[v1067]
			local v1070 = v64[v1068]
			if v1069 and not v1069.IsFakeSlot and v1070 and not v1070.IsFakeSlot and v1070.Tool == v1068 and v1069 ~= v1070 then
				if v1069.Tool then
					v1069:MoveToInventory()
				end
				v1070:Swap(v1069)
			end
		end
	end
end

function stopFuseSelectionVisuals() -- line 6038
	if FuseSelectionVisualTrove then
		FuseSelectionVisualTrove:Clean()
		FuseSelectionVisualTrove = nil
	end
	refreshInventoryFrameVisuals()
end

function startFuseSelectionVisuals() -- line 6045 | captures: RunService, Trove
	stopFuseSelectionVisuals()
	if InventoryStroke then
		FuseSelectionVisualTrove = Trove.new()
		local v1071 = 0
		FuseSelectionVisualTrove:Add(RunService.Heartbeat:Connect(function(v1072) -- line 6053 | captures: v1071
			if not ActiveFuseSelectionState then
				return
			end
			v1071 += v1072 * 3
			local v1073 = v1071
			local v1074 = (math.sin(v1073) + 1) / 2
			local v1075 = Color3.fromRGB(255, 255, 255)
			InventoryStroke.Color = FUSE_SELECTION_STROKE_COLOR:Lerp(v1075, v1074)
		end))
	end
	refreshInventoryFrameVisuals()
end

function v24.StartMachineSelection(v1076, v1077, v1078, v1079, v1080, v1081) -- line 6064 | captures: v1, v4, v7, v8, v33, v34, v73, AutoSell, v97, u2904
	local v1082 = type(v1077) == "string"
	assert(v1082, "Expected machine selection item type to be a string")
	local v1083 = type(v1078) == "function"
	assert(v1083, "Expected fuse selection callback to be a function")
	local v1084 = type(v1081) == "string"
	assert(v1084, "Expected preferred category to be a string")
	if ActiveFuseSelectionState then
		v1076:EndFuseSelection()
	end
	ActiveFuseSelectionState = {
		AllowedCategories = v1080,
		ItemType = v1077,
		PreviousCategory = v7,
		PreviousFavoriteModeActive = v34,
		PreferredCategory = v1081,
		HotbarSnapshot = captureFuseHotbarSnapshot()
	}
	v1076:RequestSelection(v1077, v1078, false, false, v1079)
	if v34 then
		setFavoriteModeActive(false)
	end
	local v1085
	if v1 then
		if v1.Text == "" then
			v1085 = true
		else
			if v4 then
				v4()
			end
			v1085 = false
		end
	else
		v1085 = true
	end
	if not v1085 then
		v1.Text = ""
	end
	if v33 then
		v33.Visible = false
		if AutoSell then
			AutoSell.Visible = false
		end
		if v97 then
			v97.Visible = false
		end
	end
	if v73 and v4 then
		v4()
	end
	if v1 and v1.Text ~= "" then
		v1.Text = ""
	end
	u2904()
	updateEquipBestButtonVisibility()
	v8(v1081)
	if v1077 == "Asset" then
		moveFuseHotbarAssetsToInventory()
	end
	AdjustHotbarFrames()
	setInventoryVisibility(true)
	setFuseSelectionSlotClickability(false)
	UpdateInventorySlots()
	startFuseSelectionVisuals()
	OnIconChanged(BackpackEnabled)
	return true
end

function v35(v1086) -- line 6121 | captures: v8, v26, v33, AutoSell, v97, u2904
	local v1087 = ActiveFuseSelectionState
	if not v1087 then
		return
	end
	ActiveFuseSelectionState = nil
	stopFuseSelectionVisuals()
	v26 = nil
	if v1086 then
		setInventoryVisibility(false)
	end
	setFuseSelectionSlotClickability(true)
	if CloseButton then
		CloseButton.Active = true
		CloseButton.Visible = true
	end
	if v33 then
		v33.Visible = false
		if AutoSell then
			AutoSell.Visible = false
		end
		if v97 then
			v97.Visible = false
		end
	end
	u2904()
	if v1087.ItemType == "Asset" then
		restoreFuseHotbarSnapshot(v1087.HotbarSnapshot)
	end
	v8(v1087.PreviousCategory)
	refreshFavoriteModeVisibility()
	if v1087.PreviousFavoriteModeActive then
		setFavoriteModeActive(true)
	else
		refreshInventoryFrameVisuals()
	end
	UpdateInventorySlots()
	OnIconChanged(BackpackEnabled)
	updateEquipBestButtonVisibility()
end

function v24.EndFuseSelection(v1088) -- line 6161 | captures: v35
	v35(true)
end

local function StartFuseSelection(v1089, v1090, v1091) -- line 6164
	local v1092 = {}
	v1092[FUSE_SELECTION_ASSET_CATEGORY_NAME] = true
	return v1089:StartMachineSelection("Asset", v1090, v1091, v1092, FUSE_SELECTION_ASSET_CATEGORY_NAME)
end

v24.StartFuseSelection = StartFuseSelection

local function IsFuseSelectionActive(v1093) -- line 6169
	return ActiveFuseSelectionState ~= nil
end

v24.IsFuseSelectionActive = IsFuseSelectionActive
tryCore("SetCoreGuiEnabled", Enum.CoreGuiType.Backpack, false)
while not LocalPlayer_2 do
	wait()
	LocalPlayer_2 = Players.LocalPlayer
end
LocalPlayer_2.CharacterAdded:Connect(SetupCharacter)

if LocalPlayer_2.Character then
	SetupCharacter(LocalPlayer_2.Character)
end

local function handleLocalActiveAssetRecords(v1094) -- line 6182
	refreshPlacedAssetUIDs(v1094)
	if clearPlacedAssetBackpackSlots(v1094) and not syncAssetsFromSave() then
		AdjustHotbarFrames()
		UpdateInventorySlots()
	end
	reconcileVirtualAssetEquipState()
end

refreshPlacedAssetUIDs(AssetRoster.ReadOwnerPen(LocalPlayer_2.UserId))
AssetRoster.OwnerRefreshed:Connect(function(v1095, v1096) -- line 6192 | captures: LocalPlayer_2, handleLocalActiveAssetRecords
	if v1095 == LocalPlayer_2.UserId then
		handleLocalActiveAssetRecords(v1096)
	end
end)
AssetRoster.OwnerCleared:Connect(function(v1097) -- line 6197 | captures: LocalPlayer_2, handleLocalActiveAssetRecords
	if v1097 == LocalPlayer_2.UserId then
		handleLocalActiveAssetRecords({})
	end
end)
task.spawn(function() -- line 6202 | captures: v88, v89, v94, v95, Save
	if not Save.IsLocalDataLoaded() then
		Save.ProfileReady:Wait()
	end
	syncAssetsFromSave()
	syncEggsFromSave()
	reconcileVirtualAssetEquipState()
	reconcileVirtualEggEquipState()
	v88 = captureEligibleAssetUIDs()
	v94 = captureEggUIDs()
	v89 = true
	v95 = true
end)
Save.WatchFields({ "Inventory", "AssetFavoriteCategories" }, function() -- line 6215 | captures: v88, v89
	local v1098 = captureEligibleAssetUIDs()
	if v89 then
		queueNewEligibleAssetsForHotbar(v88, v1098)
	end
	v88 = v1098
	v89 = true
	syncAssetsFromSave()
	reconcileVirtualAssetEquipState()
	movePendingHotbarAssets()
end)
Save.WatchFields({ "EquippedAssets", "BaseUpgradeLevel", "Gamepasses", "Products" }, function() -- line 6226
	syncAssetsFromSave()
	reconcileVirtualAssetEquipState()
end)
Save.WatchFields("EggInventory", function() -- line 6230 | captures: v94, v95
	local v1099 = captureEggUIDs()
	if v95 then
		queueNewEggsForHotbar(v94, v1099)
	end
	v94 = v1099
	v95 = true
	syncEggsFromSave()
	reconcileVirtualEggEquipState()
	movePendingHotbarEggs()
end)
EggState.SnapshotRefreshed:Connect(function() -- line 6241
	syncEggsFromSave()
	reconcileVirtualEggEquipState()
end)
PlotState.LocalPlotChanged:Connect(function() -- line 6245
	invalidateEquipBestStatus(true)
end)
PlotState.FolderChanged:Connect(function() -- line 6248
	invalidateEquipBestStatus(true)
end)
UserInputService.InputBegan:Connect(HandleInputBegan)
UserInputService.TextBoxFocused:Connect(function() -- line 6252 | captures: v72
	v72 = true
end)
UserInputService.TextBoxFocusReleased:Connect(function() -- line 6255 | captures: v72
	v72 = false
end)

v65[Value_2] = function() -- line 6258 | captures: v57
	if v57 then
		UnequipAllTools()
	end
end

UserInputService.Changed:Connect(OnInputServiceChanged)
OnInputServiceChanged("KeyboardEnabled")

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	gamepadConnected()
end
UserInputService.GamepadConnected:Connect(function(v1100) -- line 6268
	if v1100 == Enum.UserInputType.Gamepad1 then
		gamepadConnected()
	end
end)
UserInputService.GamepadDisconnected:Connect(function(v1101) -- line 6273
	if v1101 == Enum.UserInputType.Gamepad1 then
		gamepadDisconnected()
	end
end)

function v24.RequestSelection(v1102, v1103, v1104, v1105, v1106, v1107) -- line 6278 | captures: v26
	local v1108 = {
		ItemType = v1103,
		Callback = v1104
	}
	v1108.AllowHotbar = v1105 == true
	v1108.Preserve = v1106 == true
	v1108.Validator = v1107
	v26 = v1108
end

function v24.ClearSelectionRequest(v1109) -- line 6287 | captures: v26
	v26 = nil
end

function v24.SetCategory(v1110, v1111) -- line 6290 | captures: v8
	v8(v1111)
end

function v24.OpenInventory(v1112) -- line 6293 | captures: v24
	if not v24.IsOpen then
		v24.OpenClose()
	end
end

local function SetBackpackEnabled(v1113, v1114) -- line 6298
	BackpackEnabled = v1114
end

v24.SetBackpackEnabled = SetBackpackEnabled

function v24.SetTreadmillPhoneOnlyMode(v1115, v1116) -- line 6301 | captures: v44, v70, v59
	if v70 == v1116 then
		return
	end
	v70 = v1116
	if v1116 and v44.Visible then
		v59:deselect()
	end
	AdjustHotbarFrames()
end

function v24.IsOpened(v1117) -- line 6311 | captures: v24
	return v24.IsOpen
end

local function GetBackpackEnabled(v1118) -- line 6314
	return BackpackEnabled
end

v24.GetBackpackEnabled = GetBackpackEnabled

function v24.GetCategory(v1119) -- line 6317 | captures: v7
	return v7
end

function v24.RefreshInventory(v1120) -- line 6320 | captures: v3
	if v3 then
		v3()
	else
		UpdateInventorySlots()
	end
end

function v24.GetStateChangedEvent(v1121) -- line 6327 | captures: v24
	return v24.StateChanged.Event
end

function v24.ForceEggIntoTutorialHotbar(v1122, v1123) -- line 6330 | captures: v3, v62, v90, v92, v93
	local v1124 = v90[v1123] or findVirtualEggSlotByUID(v1123)
	if v1124 and not v1124.IsDeleted then
		v92[v1123] = nil
		v93[v1123] = nil
		local v1125 = getInsertableHotbarIndices(v1124.Tool)
		local v1126
		for v1127, v1128 in ipairs(v1125) do
			v1126 = v62[v1128]
			if v1126 and not v1126.IsFakeSlot and not v1126.Tool then
				break
			end
			v1126 = nil
		end
		if v1126 == nil then
			for v1129, v1130 in ipairs(v1125) do
				local v1131 = v62[v1130]
				if v1131 and not v1131.IsFakeSlot then
					v1126 = v1131
					break
				end
			end
		end
		local v1132 = v1126 ~= nil
		assert(v1132, "Tutorial egg has no usable hotbar slot")
		if v1126.Tool and v1126 ~= v1124 then
			v1126:MoveToInventory()
		end
		if v1124 ~= v1126 then
			v1124:Swap(v1126)
		end
		v90[v1123] = v1126
		AdjustHotbarFrames()
		UpdateInventorySlots()
		if v3 then
			v3(true)
		end
		if reconcileVirtualEggEquipState() ~= v1123 then
			v1126:Select()
		end
		return v1126.Frame
	end
	v93[v1123] = true
	return nil
end

function v24.GetPhoneSlotFrame(v1133) -- line 6381 | captures: v78, v62
	local v1134 = v78
	for v1135 = 1, v1134 do
		local v1136 = v62[v1135]
		if v1136 and not v1136.IsFakeSlot and v1136.Tool and isPhoneTool(v1136.Tool) then
			return v1136.Frame
		end
	end
	return nil
end

function v24.GetEggSlotFrame(v1137, v1138) -- line 6393 | captures: v90
	local v1139 = v90[v1138] or findVirtualEggSlotByUID(v1138)
	if v1139 ~= nil and not v1139.IsDeleted then
		return v1139.Frame
	end
	return nil
end

RunService.Heartbeat:Connect(function() -- line 6403 | captures: v71, v102, v103, v105, ToolGameplayGuard
	OnIconChanged(BackpackEnabled)
	local v1140 = ToolGameplayGuard.IsLocalInsideArena()
	if v1140 and not v71 then
		ensureGameplayGearHotbarSlots()
	end
	v71 = v1140
	local v1141 = isLocalPlayerWithinOwnPlotBounds()
	if v105 == v1141 then
		if v105 and not (not v103 and v102) then
			requestEquipBestStatusRefresh()
		else
			updateEquipBestButtonVisibility()
		end
	else
		v105 = v1141
		if v1141 then
			requestEquipBestStatusRefresh(true)
		else
			updateEquipBestButtonVisibility()
		end
	end
end)
ApiEvent.Event:Connect(function(v1142, v1143) -- line 6430 | captures: v24
	if v1142 == "SetBackpackEnabled" then
		v24:SetBackpackEnabled(v1143)
	elseif v1142 == "SetInventoryOpen" then
		if type(v1143) == "boolean" and v1143 == true then
			v24.IsOpen = true
		elseif type(v1143) == "boolean" then
			v24.IsOpen = false
		end
	elseif v1142 == "ToggleBackpack" then
		v24.OpenClose()
	end
end)
return v24
