--credit to quartz games studio
local t = {
	OpenClose = nil,
	IsOpen = false,
	StateChanged = Instance.new("BindableEvent")
}
local SideBar = script.SideBar

MushroomData = require(game.ReplicatedStorage.SharedModules.MushroomData)
GnomeData = require(game.ReplicatedStorage.SharedModules.GnomeData)
RaccoonData = require(game.ReplicatedStorage.SharedModules.RaccoonData)
CrateData = require(game.ReplicatedStorage.SharedModules.CrateData)
SeedPackData = require(game.ReplicatedStorage.SharedModules.SeedPackData)
EggData = require(game.ReplicatedStorage.SharedModules.EggData)
TeleporterData = require(game.ReplicatedStorage.SharedModules.TeleporterData)
PowerHoseData = require(game.ReplicatedStorage.SharedModules.PowerHoseData)
MutationData = require(game.ReplicatedStorage.SharedModules.MutationData)
WeightFormat = require(game.ReplicatedStorage.SharedModules.WeightFormat)
PetData = require(game.ReplicatedStorage.SharedData.PetData)
t.ModuleName = "Backpack"
t.KeepVRTopbarOpen = true
t.VRIsExclusive = true
t.VRClosesNonExclusive = true
ImageData = game.ReplicatedStorage.SharedModules.SeedData
FruitImages = ImageData.FruitImages
PlantImages = ImageData.PlantImages
SeedImages = ImageData.SeedImages
BuildIMG = "rbxassetid://123856554248782"
ICON_SIZE = 60
FONT_SIZE = script:GetAttribute("TextSize")
ICON_BUFFER = 5
BACKGROUND_FADE = script:GetAttribute("BackgroundTransparency")
BACKGROUND_COLOR = script:GetAttribute("BackgroundColor")
VR_FADE_TIME = 1
VR_PANEL_RESOLUTION = 100
SLOT_DRAGGABLE_COLOR = script:GetAttribute("DraggableColor")
SLOT_EQUIP_COLOR = script:GetAttribute("EquippedColor")
SLOT_EQUIP_THICKNESS = 3
SLOT_FADE_LOCKED = script:GetAttribute("SlotLockedTransparency")
SLOT_BORDER_COLOR = script:GetAttribute("BorderColor")
TOOLTIP_BUFFER = 24
TOOLTIP_HEIGHT = 24
TOOLTIP_OFFSET = -28
ARROW_HOTKEY = { Enum.KeyCode.Backquote, Enum.KeyCode.DPadUp }
HOTBAR_SLOTS_FULL = script:GetAttribute("FullSlots")
HOTBAR_SLOTS_VR = script:GetAttribute("EmptySlots")
HOTBAR_SLOTS_MINI = 5
HOTBAR_SLOTS_WIDTH_CUTOFF = 1024
HOTBAR_OFFSET_FROMBOTTOM = -30
INVENTORY_ROWS_FULL = 4
INVENTORY_ROWS_VR = 3
INVENTORY_ROWS_MINI = 2
INVENTORY_HEADER_SIZE = 40
INVENTORY_ARROWS_BUFFER_VR = 40

local v1 = script:GetAttribute("SearchBoxColor")
local v2 = script:GetAttribute("SearchBoxTransparency")
local Api = script:WaitForChild("Api")

Api.Parent = game.ReplicatedStorage

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local FruitProxyUtil = require(ReplicatedStorage.SharedModules.FruitProxyUtil)
local AnimatedGradient = require(ReplicatedStorage.SharedModules.AnimatedGradient)
local v3 = true
local v4 = false
local Zero = Enum.KeyCode.Zero.Value
local Backspace = Enum.KeyCode.Backspace.Value
local t2 = {
	[Enum.UserInputType.Gamepad1] = true,
	[Enum.UserInputType.Gamepad2] = true,
	[Enum.UserInputType.Gamepad3] = true,
	[Enum.UserInputType.Gamepad4] = true,
	[Enum.UserInputType.Gamepad5] = true,
	[Enum.UserInputType.Gamepad6] = true,
	[Enum.UserInputType.Gamepad7] = true,
	[Enum.UserInputType.Gamepad8] = true
}
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

game:GetService("ReplicatedStorage")

local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local BackpackGui = Instance.new("ScreenGui", Players.LocalPlayer.PlayerGui)

BackpackGui.DisplayOrder = 120
BackpackGui.IgnoreGuiInset = true
BackpackGui.ResetOnSpawn = false
BackpackGui.Name = "BackpackGui"

local ContextActionService = game:GetService("ContextActionService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")
local Utility = require(script.Utility)

require(script.GameTranslator)

local topbarplus = require(game:GetService("ReplicatedStorage").ClientModules.topbarplus)

require(game.ReplicatedStorage.SharedModules.SeedData)

local SprinklerData = require(game.ReplicatedStorage.SharedModules.SprinklerData)
local RakeData = require(game.ReplicatedStorage.SharedModules.RakeData)
local WateringcanData = require(game.ReplicatedStorage.SharedModules.WateringcanData)
local ShovelData = require(game.ReplicatedStorage.SharedModules.ShovelData)
local TrowelData = require(game.ReplicatedStorage.SharedModules.TrowelData)
local BuildData = require(game.ReplicatedStorage.SharedModules.BuildData)
local CrowbarData = require(game.ReplicatedStorage.SharedModules.CrowbarData)
local IMG = ShovelData.Data.IMG
local IMG2 = TrowelData.Data.IMG
local IMG3 = BuildData.Data.IMG
local IMG4 = CrowbarData.Data.IMG
local v5 = GuiService:IsTenFootInterface()

if v5 then
	ICON_SIZE = 100
	FONT_SIZE = 24
end

local v6 = false
local v7 = false
local v8 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local function GetHotbarBottomMargin() --[[ GetHotbarBottomMargin | Line: 172 | Upvalues: v8 (copy) ]]
	if not v8 then
		return 0
	end

	local ViewportSize = game.Workspace.Camera.ViewportSize

	if math.max(ViewportSize.X, ViewportSize.Y) >= 1000 then
		return 18
	end

	return 0
end

local LocalPlayer = Players.LocalPlayer
local v9 = nil
local v10 = nil
local v11 = nil
local v12 = nil
local v13 = nil
local v14 = nil
local v15 = nil
local v16 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = v16:FindFirstChildOfClass("Humanoid")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local v17 = topbarplus.new()

v17:setImage("rbxasset://textures/ui/TopBar/inventoryOff.png", "deselected")
v17:setImage("rbxasset://textures/ui/TopBar/inventoryOn.png", "selected")
v17:bindToggleKey(ARROW_HOTKEY[1], ARROW_HOTKEY[2])
v17:setName("InventoryIcon")
v17:setImageScale(1.12)
v17:setOrder(0)
v17:setCaption("Toggle the backpack.")
v17.deselectWhenOtherIconSelected = false

local v18 = topbarplus.new()

v18:setImage("rbxassetid://125872769879713", "deselected")
v18:setImage("rbxassetid://125872769879713", "selected")
v18:setName("ShopIcon")
v18:bindToggleKey(Enum.KeyCode.P)
v18:setImageScale(1.12)
v18:setOrder(1)
v18:setCaption("Open the shop.")
v18:setEnabled(true)
v18.deselectWhenOtherIconSelected = false

local v19 = topbarplus.new()

v19:setImage("rbxassetid://96480124490680", "deselected")
v19:setImage("rbxassetid://96480124490680", "selected")
v19:setName("SettingIcon")
v19:bindToggleKey(Enum.KeyCode.L)
v19:setImageScale(1.12)
v19:setOrder(1)
v19:setCaption("Open the settings.")
v19:setEnabled(true)
v19.deselectWhenOtherIconSelected = false

local v20 = topbarplus.new()

v20:setImage(IMG3, "deselected")
v20:setImage(IMG3, "selected")
v20:setName("BuildIcon")
v20:bindToggleKey(Enum.KeyCode.B)
v20:setImageScale(1.12)
v20:setOrder(2)
v20:setCaption("Equip build tool.")
v20:setEnabled(false)
v20.deselectWhenOtherIconSelected = false

local t3 = {}
local v21 = nil
local t4 = {}
local t5 = {}
local t6 = {}
local v22 = 0
local v23 = false
local v24 = false
local v25 = false
local v26 = false
local t7 = {}
local t8 = {}
local v27 = false
local v28 = 0
local VREnabled = VRService.VREnabled
local v29 = VREnabled and HOTBAR_SLOTS_VR or (v7 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL)
local v30 = VREnabled and INVENTORY_ROWS_VR or (v7 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL)
local v31 = nil
local v32 = "All"
local v33 = nil
local v34 = nil
local v35 = nil
local v36 = nil

local function ToggleFavorite(p1) --[[ ToggleFavorite | Line: 270 | Upvalues: FruitProxyUtil (copy), Networking (copy) ]]
	local Tool = p1.Tool

	if not (Tool and FruitProxyUtil.IsFruitInstance(Tool)) then
		return
	end

	local v1 = Tool:GetAttribute("Id")

	if not v1 then
		return
	end

	local v3 = not (Tool:GetAttribute("IsFavorite") == true)

	Tool:SetAttribute("IsFavorite", if v3 then true else nil)
	task.spawn(function() --[[ Line: 277 | Upvalues: Networking (ref), v1 (copy), v3 (copy) ]]
		Networking.Backpack.SetFruitFavorite:Fire(v1, v3)
	end)
end

local v37 = nil
local v38 = false
local v39 = false
local v40 = true

function GetToolKey(p1) --[[ GetToolKey | Line: 288 | Upvalues: FruitProxyUtil (copy) ]]
	if not p1 then
		return nil
	end

	if not (p1:IsA("Tool") or FruitProxyUtil.IsFruitProxy(p1)) then
		return nil
	end

	if p1:GetAttribute("SeedTool") then
		return "Seed:" .. p1:GetAttribute("SeedTool")
	end

	if p1:GetAttribute("Fruit") then
		local v1 = "Fruit:" .. p1:GetAttribute("Fruit")
		local v2 = p1:GetAttribute("Mutation")

		if v2 then
			v1 = v1 .. ":" .. v2
		end

		local v3 = p1:GetAttribute("Weight")

		if v3 then
			v1 = v1 .. ":" .. tostring((math.floor(v3 * 1000)))
		end

		return v1
	end

	if p1:GetAttribute("Sprinkler") then
		return "Sprinkler:" .. p1:GetAttribute("Sprinkler")
	end

	if p1:GetAttribute("Rake") then
		return "Rake:" .. p1:GetAttribute("Rake")
	end

	if p1:GetAttribute("WateringCan") then
		return "WateringCan:" .. p1:GetAttribute("WateringCan")
	end

	if p1:GetAttribute("Shovel") then
		return "Shovel:" .. p1:GetAttribute("Shovel")
	end

	if p1:GetAttribute("Trowel") then
		return "Trowel:" .. p1:GetAttribute("Trowel")
	end

	if p1:GetAttribute("Crowbar") then
		return "Crowbar:" .. p1:GetAttribute("Crowbar")
	end

	if p1:GetAttribute("Build") then
		return "Build:" .. p1:GetAttribute("Build")
	end

	if p1:GetAttribute("Mushroom") then
		return "Mushroom:" .. p1:GetAttribute("Mushroom")
	end

	if p1:GetAttribute("Gnome") then
		return "Gnome:" .. p1:GetAttribute("Gnome")
	end

	if p1:GetAttribute("SeedPack") then
		return "SeedPack:" .. p1:GetAttribute("SeedPack")
	end

	if p1:GetAttribute("Egg") then
		return "Egg:" .. p1:GetAttribute("Egg")
	end

	if p1:GetAttribute("Crate") then
		return "Crate:" .. p1:GetAttribute("Crate")
	end

	if p1:GetAttribute("Teleporter") then
		return "Teleporter:" .. p1:GetAttribute("Teleporter")
	end

	if p1:GetAttribute("PowerHose") then
		return "PowerHose:" .. p1:GetAttribute("PowerHose")
	end

	if p1:GetAttribute("Wheelbarrow") then
		return "Wheelbarrow:" .. p1:GetAttribute("Wheelbarrow")
	end

	if p1:GetAttribute("Ladder") then
		return "Ladder:" .. p1:GetAttribute("Ladder")
	end

	if p1:GetAttribute("FreezeRay") then
		return "FreezeRay:" .. p1:GetAttribute("FreezeRay")
	end

	if p1:GetAttribute("Flashbang") then
		return "Flashbang:" .. p1:GetAttribute("Flashbang")
	end

	if p1:GetAttribute("Bird") then
		return "Bird:" .. p1:GetAttribute("Bird")
	end

	return "Name:" .. p1.Name
end

local function SendHotbarLayoutToServer() --[[ SendHotbarLayoutToServer | Line: 348 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (copy) ]]
	if v40 then
		return
	end

	if not v39 then
		v39 = true
		task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
			if not v40 then
				local t2 = {}
				local count2 = 0

				for i = 1, v29 do
					local v1 = t3[i]

					if v1 and v1.Tool then
						local v2 = GetToolKey(v1.Tool)

						if v2 then
							t2[i] = v2
							count2 = count2 + 1
						end
					end
				end

				if count2 ~= 0 then
					Networking.Backpack.SaveLayout:Fire(t2)
				end
			end

			v39 = false
		end)
	end
end

local function ApplySavedLayout() --[[ ApplySavedLayout | Line: 383 | Upvalues: v37 (ref), v38 (ref), v29 (ref), t3 (ref), v21 (ref), v33 (ref), v34 (ref), v14 (ref), FruitProxyUtil (copy), v35 (ref), v36 (ref) ]]
	if not v37 or v38 then
		return
	end

	local count = 0

	for k in pairs(v37) do
		count = count + 1
	end

	if count == 0 then
		v38 = true

		return
	end

	v38 = true

	local t = {}

	for i = 1, v29 do
		local v1 = t3[i]

		if v1 and v1.Tool then
			table.insert(t, v1.Tool)
			v1:Clear()
		end
	end

	local t2 = {}

	for j = #t3, v29 + 1, -1 do
		local v2 = t3[j]

		if v2 and v2.Tool then
			table.insert(t2, v2.Tool)
			v2:Clear()
			v2:Delete()
		end
	end

	local t4 = {}

	for v3, v4 in t do
		table.insert(t4, v4)
	end

	for v5, v6 in t2 do
		table.insert(t4, v6)
	end

	local t5 = {}

	for k, v in pairs(v37) do
		local v7 = tonumber(k)

		if v7 and (v7 >= 1 and v7 <= v29) then
			for v8, v9 in t4 do
				if not t5[v9] and GetToolKey(v9) == v then
					t3[v7]:Fill(v9)
					t5[v9] = true

					break
				end
			end
		end
	end

	for v10, v11 in t4 do
		if not t5[v11] then
			v21 = v33();
			(v21 or v34(v14)):Fill(v11)
			t5[v11] = true
		end
	end

	for k = 1, v29 do
		local v13 = t3[k]

		if v13 and (v13.Tool and FruitProxyUtil.IsFruitProxy(v13.Tool)) then
			local v142 = v13.Tool:GetAttribute("Id")

			if v142 then
				FruitProxyUtil.Pending.Slots[v142] = k
				FruitProxyUtil.RequestPromote(v142)
			end
		end
	end

	v21 = v33()
	v35()
	v36()
end

local function ToolMatchesFilter(p1, p2) --[[ ToolMatchesFilter | Line: 468 ]]
	if p2 == "All" then
		return true
	end

	local v1 = p1:GetAttribute("MainCategory")

	if p2 == "Seeds" then
		return if v1 == "Seed" then true else p1:GetAttribute("SeedTool") ~= nil
	end

	if p2 == "Fruits" then
		return if v1 == "Fruit" then true else p1:GetAttribute("Fruit") ~= nil
	end

	if p2 == "Pets" then
		return if v1 == "Pet" then true else p1:GetAttribute("Pet") ~= nil
	end

	if p2 ~= "Gears" then
		return true
	end

	if v1 == "Gear" or v1 == "Egg" then
		return true
	end

	return if p1:GetAttribute("Egg") == nil and (p1:GetAttribute("Sprinkler") == nil and (p1:GetAttribute("WateringCan") == nil and (p1:GetAttribute("Shovel") == nil and (p1:GetAttribute("Trowel") == nil and (p1:GetAttribute("Crowbar") == nil and (p1:GetAttribute("Build") == nil and (p1:GetAttribute("Mushroom") == nil and (p1:GetAttribute("Gnome") == nil and (p1:GetAttribute("Crate") == nil and (p1:GetAttribute("Teleporter") == nil and (p1:GetAttribute("PowerHose") == nil and (p1:GetAttribute("Wheelbarrow") == nil and (p1:GetAttribute("Ladder") == nil and (p1:GetAttribute("FreezeRay") == nil and (p1:GetAttribute("Rake") == nil and p1:GetAttribute("Flashbang") == nil))))))))))))))) then p1:GetAttribute("Bird") ~= nil else true
end

local function EvaluateBackpackPanelVisibility(p1) --[[ EvaluateBackpackPanelVisibility | Line: 518 | Upvalues: v17 (copy), v3 (ref), VRService (copy) ]]
	return if p1 then v17.enabled and (v3 and VRService.VREnabled) else p1
end

local function ShowVRBackpackPopup() --[[ ShowVRBackpackPopup | Line: 522 ]] end

local function NewGui(p1, p2) --[[ NewGui | Line: 528 ]]
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
		v1.TextSize = FONT_SIZE
		v1.TextWrapped = true

		if p1 == "TextButton" then
			v1.FontFace = script:GetAttribute("SlotFont")
		end
	end

	return v1
end

v33 = function() --[[ Line: 550 | Upvalues: v29 (ref), t3 (ref) ]]
	for i = 1, v29 do
		local v1 = t3[i]

		if not v1.Tool then
			return v1
		end
	end

	return nil
end

local function isInventoryEmpty() --[[ isInventoryEmpty | Line: 560 | Upvalues: v29 (ref), t3 (ref) ]]
	for i = v29 + 1, #t3 do
		local v1 = t3[i]

		if v1 and v1.Tool then
			return false
		end
	end

	return true
end

local function UseGazeSelection() --[[ UseGazeSelection | Line: 570 | Upvalues: UserInputService (copy) ]]
	return UserInputService.VREnabled
end

local function GetBuildTool() --[[ GetBuildTool | Line: 575 | Upvalues: Backpack (ref), v16 (ref) ]]
	if Backpack then
		for v1, v2 in Backpack:GetChildren() do
			if v2:IsA("Tool") and v2:GetAttribute("Build") then
				return v2
			end
		end
	end

	if not v16 then
		return nil
	end

	for v3, v4 in v16:GetChildren() do
		if v4:IsA("Tool") and v4:GetAttribute("Build") then
			return v4
		end
	end

	return nil
end

local function IsBuildToolEquipped() --[[ IsBuildToolEquipped | Line: 595 | Upvalues: v16 (ref) ]]
	if not v16 then
		return false
	end

	for v1, v2 in v16:GetChildren() do
		if v2:IsA("Tool") and v2:GetAttribute("Build") then
			return true
		end
	end

	return false
end

local function UpdateBuildIcon() --[[ UpdateBuildIcon | Line: 607 | Upvalues: GetBuildTool (copy), v20 (copy), v4 (ref), v7 (ref), IsBuildToolEquipped (copy) ]]
	local v1 = GetBuildTool()

	v20:setEnabled(if v1 == nil then false else not v4 and not v7)

	if not v1 then
		return
	end

	if IsBuildToolEquipped() then
		v20:select()

		return
	end

	v20:deselect()
end

v20.selected:Connect(function() --[[ Line: 623 | Upvalues: GetBuildTool (copy), IsBuildToolEquipped (copy), Humanoid (ref), v16 (ref) ]]
	local v1 = GetBuildTool()

	if not v1 or IsBuildToolEquipped() then
		return
	end

	if Humanoid then
		Humanoid:UnequipTools()
	end

	v1.Parent = v16
end)
v20.deselected:Connect(function() --[[ Line: 633 | Upvalues: IsBuildToolEquipped (copy), Humanoid (ref) ]]
	if not (IsBuildToolEquipped() and Humanoid) then
		return
	end

	Humanoid:UnequipTools()
end)
task.spawn(function() --[[ Line: 641 | Upvalues: v18 (copy), v19 (copy), v11 (ref), t (copy), v4 (ref), v20 (copy), UpdateBuildIcon (ref) ]]
	local LocalPlayer = game.Players.LocalPlayer

	repeat
		task.wait()
	until LocalPlayer:HasTag("ControllersStarted")

	local GuiController = require(LocalPlayer.PlayerScripts:WaitForChild("Controllers"):WaitForChild("GuiController"))

	v18.selected:Connect(function() --[[ Line: 647 | Upvalues: GuiController (copy) ]]
		if GuiController:IsOpen("RobuxShop") then
			GuiController:Close("RobuxShop")
		else
			GuiController:Open("RobuxShop", nil, { "HUD" })
		end
	end)
	v18.deselected:Connect(function() --[[ Line: 655 | Upvalues: GuiController (copy) ]]
		if GuiController:IsOpen("RobuxShop") then
			GuiController:Close("RobuxShop")
		else
			GuiController:Open("RobuxShop", nil, { "HUD" })
		end
	end)
	v19.selected:Connect(function() --[[ Line: 663 | Upvalues: GuiController (copy) ]]
		if GuiController:IsOpen("Settings") then
			GuiController:Close("Settings")
		else
			GuiController:Open("Settings", nil, { "HUD" })
		end
	end)
	v19.deselected:Connect(function() --[[ Line: 671 | Upvalues: GuiController (copy) ]]
		if GuiController:IsOpen("Settings") then
			GuiController:Close("Settings")
		else
			GuiController:Open("Settings", nil, { "HUD" })
		end
	end)
	GuiController.GuiFocusedSignal:Connect(function() --[[ Line: 679 | Upvalues: v11 (ref), t (ref), v4 (ref), v18 (ref), v19 (ref), v20 (ref) ]]
		if not (v11 and v11.Visible) then
			v4 = true
			v18:setEnabled(false)
			v19:setEnabled(false)
			v20:setEnabled(false)

			return
		end

		t.OpenClose()
		v4 = true
		v18:setEnabled(false)
		v19:setEnabled(false)
		v20:setEnabled(false)
	end)
	GuiController.GuiUnfocusedSignal:Connect(function() --[[ Line: 690 | Upvalues: v4 (ref), v18 (ref), v19 (ref), UpdateBuildIcon (ref) ]]
		v4 = false
		v18:setEnabled(true)
		v19:setEnabled(true)
		UpdateBuildIcon()
	end)
end)
v35 = function() --[[ Line: 699 | Upvalues: v11 (ref), v29 (ref), v22 (ref), t3 (ref) ]]
	local Visible = v11.Visible
	local v1 = v11.Visible and v29 or v22
	local count = 0

	for i = 1, v29 do
		local v2 = t3[i]

		if v2.Tool or Visible then
			count = count + 1
			v2:Readjust(count, v1)
			v2.Frame.Visible = true

			continue
		end

		v2.Frame.Visible = false
	end
end

local v41 = 0

local function UpdateScrollingFrameCanvasSize() --[[ UpdateScrollingFrameCanvasSize | Line: 725 | Upvalues: v13 (ref), v41 (ref) ]]
	local v2 = math.floor(v13.AbsoluteSize.X / (ICON_SIZE + ICON_BUFFER))

	if v2 < 1 then
		v2 = 1
	end

	v13.CanvasSize = UDim2.new(0, 0, 0, math.ceil(v41 / v2) * (ICON_SIZE + ICON_BUFFER) + ICON_BUFFER)
end

v36 = function() --[[ Line: 734 | Upvalues: t (copy), v26 (ref), v29 (ref), t3 (ref), ToolMatchesFilter (copy), v32 (ref), v41 (ref), UpdateScrollingFrameCanvasSize (ref) ]]
	local _ApplySearch = t._ApplySearch

	if v26 and _ApplySearch then
		_ApplySearch()

		return
	end

	local count = 0

	for i = v29 + 1, #t3 do
		local v1 = t3[i]

		v1.Frame.LayoutOrder = v1.Index

		local v2 = if v1.Tool == nil then false else ToolMatchesFilter(v1.Tool, v32)

		v1.Frame.Visible = v2

		if v2 then
			count = count + 1
		end
	end

	v41 = count
	UpdateScrollingFrameCanvasSize()
end

local function AddInventorySlotIncremental(p1) --[[ AddInventorySlotIncremental | Line: 761 | Upvalues: t (copy), v26 (ref), ToolMatchesFilter (copy), v32 (ref), v41 (ref), UpdateScrollingFrameCanvasSize (ref) ]]
	local _ApplySearch = t._ApplySearch

	if v26 and _ApplySearch then
		_ApplySearch()

		return
	end

	p1.Frame.LayoutOrder = p1.Index

	local v1 = if p1.Tool == nil then false else ToolMatchesFilter(p1.Tool, v32)

	p1.Frame.Visible = v1

	if v1 then
		v41 = v41 + 1
	end

	UpdateScrollingFrameCanvasSize()
end

local v42 = false
local v43 = UpdateBuildIcon
local f51, f53

do
	local v44 = false

	UpdateBuildIcon = function() --[[ Line: 782 | Upvalues: v44 (ref), v43 (copy) ]]
		if not v44 then
			v44 = true
			task.defer(function() --[[ Line: 785 | Upvalues: v44 (ref), v43 (ref) ]]
				v44 = false
				v43()
			end)
		end
	end

	local v45 = v35
	local v46 = false

	v35 = function() --[[ Line: 793 | Upvalues: v46 (ref), v45 (copy) ]]
		if not v46 then
			v46 = true
			task.defer(function() --[[ Line: 796 | Upvalues: v46 (ref), v45 (ref) ]]
				v46 = false
				v45()
			end)
		end
	end

	local v47 = UpdateScrollingFrameCanvasSize
	local v48 = false

	UpdateScrollingFrameCanvasSize = function() --[[ Line: 804 | Upvalues: v48 (ref), v47 (copy) ]]
		if not v48 then
			v48 = true
			task.defer(function() --[[ Line: 807 | Upvalues: v48 (ref), v47 (ref) ]]
				v48 = false
				v47()
			end)
		end
	end

	local t9 = {}
	local v49 = false
	local v50 = nil

	f51 = function(p1) --[[ Line: 818 | Upvalues: t9 (copy), v49 (ref), t3 (ref), v29 (ref), v41 (ref), v50 (ref), v15 (ref), v42 (ref), UpdateScrollingFrameCanvasSize (ref), RunService (copy) ]]
		p1.Frame.Visible = false

		local v1 = t9

		table.insert(v1, p1)

		if v49 then
			return
		end

		v49 = true
		task.defer(function() --[[ Line: 823 | Upvalues: v49 (ref), t9 (ref), t3 (ref), v29 (ref), v41 (ref), v50 (ref), v15 (ref), v42 (ref), UpdateScrollingFrameCanvasSize (ref), RunService (ref) ]]
			v49 = false

			local t = {}

			for v1, v2 in t9 do
				t[v2] = true
			end

			table.clear(t9)

			local t2 = {}
			local count = 1
			local count2 = 0

			for i = 1, #t3 do
				local v3 = t3[i]

				if t[v3] then
					table.insert(t2, v3.Frame)

					continue
				end

				v3.Index = count
				v3.Frame.Name = count
				v3.Frame.LayoutOrder = count
				t3[count] = v3

				if v29 < count and v3.Frame.Visible then
					count2 = count2 + 1
				end

				count = count + 1
			end

			for j = count, #t3 do
				t3[j] = nil
			end

			v41 = count2

			if v50 and v15 then
				v15.Parent = v50
				v50 = nil
			end

			v42 = false
			UpdateScrollingFrameCanvasSize()
			task.spawn(function() --[[ Line: 862 | Upvalues: t2 (copy), RunService (ref) ]]
				for i = 1, #t2, 50 do
					local v2 = math.min(i + 50 - 1, #t2)

					for j = i, v2 do
						t2[j]:Destroy()
					end

					if v2 < #t2 then
						RunService.Heartbeat:Wait()
					end
				end
			end)
		end)
	end

	local v52 = false

	f53 = function() --[[ Line: 878 | Upvalues: v52 (ref), v15 (ref), v42 (ref), v50 (ref), v49 (ref) ]]
		if v52 then
			return
		end

		if v15 and v15.Parent then
			v52 = true
			v42 = true
			v50 = v15.Parent
			v15.Parent = nil
			task.defer(function() --[[ Line: 885 | Upvalues: v52 (ref), v49 (ref), v50 (ref), v15 (ref), v42 (ref) ]]
				v52 = false

				if v49 or not (v50 and v15) then
					return
				end

				v15.Parent = v50
				v50 = nil
				v42 = false
			end)
		end
	end
end

local function UpdateBackpackLayout() --[[ UpdateBackpackLayout | Line: 896 | Upvalues: v10 (ref), v29 (ref), v8 (copy), v11 (ref), v30 (ref), VREnabled (copy), v13 (ref), v35 (ref), v36 (ref) ]]
	v10.Size = UDim2.new(0, ICON_BUFFER + v29 * (ICON_SIZE + ICON_BUFFER), 0, ICON_BUFFER + ICON_SIZE + ICON_BUFFER)

	local v2 = UDim2.new
	local v7

	if v8 then
		local ViewportSize = game.Workspace.Camera.ViewportSize

		v7 = if math.max(ViewportSize.X, ViewportSize.Y) >= 1000 then 18 else 0
	else
		v7 = 0
	end

	v10.Position = v2(0.5, -v10.Size.X.Offset / 2, 1, -v10.Size.Y.Offset - v7)
	v11.Size = UDim2.new(0, v10.Size.X.Offset, 0, v10.Size.Y.Offset * v30 + INVENTORY_HEADER_SIZE + (if VREnabled then 2 * INVENTORY_ARROWS_BUFFER_VR or 0 else 0))
	v11.Position = UDim2.new(0.5, -v11.Size.X.Offset / 2, 1, v10.Position.Y.Offset - v11.Size.Y.Offset)
	v13.Size = UDim2.new(1, v13.ScrollBarThickness + 1, 1, -INVENTORY_HEADER_SIZE - (if VREnabled then 2 * INVENTORY_ARROWS_BUFFER_VR or 0 else 0))
	v13.Position = UDim2.new(0, 0, 0, INVENTORY_HEADER_SIZE + (if VREnabled then INVENTORY_ARROWS_BUFFER_VR or 0 else 0))
	v35()
	v36()
end

local function Clamp(p1, p2, p3) --[[ Clamp | Line: 908 ]]
	return math.min(p2, (math.max(p1, p3)))
end

local function CheckBounds(p1, p2, p3) --[[ CheckBounds | Line: 912 ]]
	local AbsolutePosition = p1.AbsolutePosition
	local AbsoluteSize = p1.AbsoluteSize

	return if AbsolutePosition.X < p2 and (p2 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p3) then p3 <= AbsolutePosition.Y + AbsoluteSize.Y else false
end

local function GetOffset(p1, p2) --[[ GetOffset | Line: 918 ]]
	return (p1.AbsolutePosition + p1.AbsoluteSize / 2 - p2).magnitude
end

local v54 = nil

local function UnequipAllTools() --[[ UnequipAllTools | Line: 927 | Upvalues: v54 (ref), Humanoid (ref) ]]
	v54 = nil

	if not Humanoid then
		return
	end

	Humanoid:UnequipTools()
end

local function IsToolFullyReplicated(p1) --[[ IsToolFullyReplicated | Line: 937 ]]
	local v1 = p1:GetAttribute("ToolDescendants")

	if type(v1) ~= "number" then
		return true
	end

	return v1 <= #p1:GetDescendants()
end

local function EquipNewTool(p1) --[[ EquipNewTool | Line: 945 | Upvalues: v54 (ref), Humanoid (ref), v16 (ref), RunService (copy), Backpack (ref) ]]
	v54 = nil

	if Humanoid then
		Humanoid:UnequipTools()
	end

	local v1 = p1:GetAttribute("ToolDescendants")

	if if type(v1) == "number" then if v1 <= #p1:GetDescendants() then true else false else true then
		p1.Parent = v16
	else
		v54 = p1
		task.spawn(function() --[[ Line: 957 | Upvalues: v54 (ref), p1 (copy), RunService (ref), Backpack (ref), v16 (ref), Humanoid (ref) ]]
			local v1 = os.clock() + 1

			while v54 == p1 do
				local v2 = p1
				local v3 = v2:GetAttribute("ToolDescendants")
				local v4 = if type(v3) == "number" then if v3 <= #v2:GetDescendants() then true else false else true

				if v4 or not (os.clock() < v1) then
					break
				end

				RunService.Heartbeat:Wait()
			end

			if v54 ~= p1 then
				return
			end

			v54 = nil

			if p1.Parent ~= Backpack or not (v16 and v16.Parent) then
				return
			end

			v54 = nil

			if not Humanoid then
				p1.Parent = v16

				return
			end

			Humanoid:UnequipTools()
			p1.Parent = v16
		end)
	end
end

local function IsEquipped(p1) --[[ IsEquipped | Line: 974 | Upvalues: v16 (ref) ]]
	return if p1 then p1.Parent == v16 else p1
end

local function FormatWeight(p1) --[[ FormatWeight | Line: 978 ]]
	return WeightFormat.FormatGrams(p1)
end

local function FormatCount(p1) --[[ FormatCount | Line: 982 ]]
	if p1 >= 1000000000 then
		return ("x%*B"):format(math.floor(p1 / 100000000) / 10)
	end

	if p1 >= 1000000 then
		return ("x%*M"):format(math.floor(p1 / 100000) / 10)
	end

	if p1 >= 1000 then
		return ("x%*K"):format(math.floor(p1 / 100) / 10)
	end

	return ("x%*"):format(p1)
end

v34 = function(p1, p2) --[[ Line: 994 | Upvalues: t3 (ref), VRService (copy), v10 (ref), FormatCount (copy), SprinklerData (copy), RakeData (copy), WateringcanData (copy), IMG (copy), IMG2 (copy), IMG4 (copy), IMG3 (copy), FruitProxyUtil (copy), AnimatedGradient (copy), v29 (ref), v11 (ref), UserInputService (copy), v22 (ref), v24 (ref), v6 (ref), ContextActionService (copy), t4 (ref), v21 (ref), v33 (ref), UpdateBuildIcon (ref), v40 (ref), v39 (ref), Networking (copy), v16 (ref), v31 (ref), NewGui (copy), UpdateScrollingFrameCanvasSize (ref), v35 (ref), v42 (ref), LocalPlayer (ref), Backpack (ref), v54 (ref), Humanoid (ref), RunService (copy), ToggleFavorite (copy), v34 (ref), v14 (ref), v26 (ref), v36 (ref), t5 (ref), Zero (copy), t6 (copy), v17 (copy), v13 (ref), v41 (ref) ]]
	local v1 = p2 or #t3 + 1
	local t = {
		Tool = nil,
		Index = v1,
		Frame = nil
	}
	local v2 = nil
	local v3 = nil
	local v4 = nil
	local v5 = nil
	local v62 = nil
	local v7 = nil
	local v8 = nil
	local v9 = nil
	local v102 = ""
	local v112 = nil
	local v12 = nil
	local v132 = nil
	local v142 = nil

	local function UpdateSlotFading() --[[ UpdateSlotFading | Line: 1030 | Upvalues: VRService (ref), v2 (ref) ]]
		local VREnabled = VRService.VREnabled

		v2.SelectionImageObject = nil
		v2.BackgroundTransparency = if v2.Draggable then 0 else SLOT_FADE_LOCKED
		v2.BackgroundColor3 = v2.Draggable and SLOT_DRAGGABLE_COLOR or BACKGROUND_COLOR
	end

	function t.Readjust(p1, p2, p3) --[[ Readjust | Line: 1057 | Upvalues: v10 (ref), v2 (ref) ]]
		v2.Position = UDim2.new(0, v10.Size.X.Offset / 2 - ICON_SIZE / 2 + (ICON_BUFFER + ICON_SIZE) * (p2 - (p3 / 2 + 0.5)), 0, ICON_BUFFER)
	end
	function t.Fill(p1, p2) --[[ Fill | Line: 1065 | Upvalues: v5 (ref), v62 (ref), v4 (ref), v102 (ref), FormatCount (ref), SprinklerData (ref), RakeData (ref), WateringcanData (ref), IMG (ref), IMG2 (ref), IMG4 (ref), IMG3 (ref), v132 (ref), v112 (ref), v12 (ref), v2 (ref), FruitProxyUtil (ref), AnimatedGradient (ref), v7 (ref), v8 (ref), v29 (ref), v11 (ref), UserInputService (ref), v22 (ref), v24 (ref), v6 (ref), ContextActionService (ref), t4 (ref), v21 (ref), v33 (ref), UpdateBuildIcon (ref), v40 (ref), v39 (ref), t3 (ref), Networking (ref) ]]
		if not p2 then
			return p1:Clear()
		end

		p1.Tool = p2

		local function assignToolData() --[[ assignToolData | Line: 1072 | Upvalues: p2 (copy), v5 (ref), v62 (ref), v4 (ref), v102 (ref), FormatCount (ref), SprinklerData (ref), RakeData (ref), WateringcanData (ref), IMG (ref), IMG2 (ref), IMG4 (ref), IMG3 (ref), v132 (ref), v112 (ref), v12 (ref), v2 (ref), FruitProxyUtil (ref) ]]
			local v1 = p2:GetAttribute("SeedTool")
			local v22 = p2:GetAttribute("Sprinkler")
			local v3 = p2:GetAttribute("Rake")
			local v42 = p2:GetAttribute("WateringCan")
			local v52 = p2:GetAttribute("Fruit")
			local v6 = p2:GetAttribute("Count")
			local v7 = p2:GetAttribute("Weight")

			local function styleItemName() --[[ styleItemName | Line: 1081 | Upvalues: v5 (ref) ]]
				v5.FontFace = Font.new(script:GetAttribute("LabelFont").Family, Enum.FontWeight.Bold)
				v5.TextSize = 10
				v5.Size = UDim2.new(1, -4, 0, 24)
				v5.Position = UDim2.new(0, 2, 1, -26)
				v5.TextYAlignment = Enum.TextYAlignment.Bottom
				v5.TextWrapped = true
				v5.Visible = true
			end

			local function resetCount() --[[ resetCount | Line: 1091 | Upvalues: v62 (ref) ]]
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
			end

			if v52 then
				local v8 = FruitImages:FindFirstChild(v52) or PlantImages:FindFirstChild(v52)

				v4.Image = v8 and v8.Value or (p2:IsA("Tool") and p2.TextureId or "")

				local v11 = p2:GetAttribute("Mutation")

				v5.Text = v52
				v102 = if v11 and v11 ~= "" then v52 .. " " .. v11 else v52
				v5.FontFace = Font.new(script:GetAttribute("LabelFont").Family, Enum.FontWeight.Bold)
				v5.TextSize = 10
				v5.Size = UDim2.new(1, -4, 0, 16)
				v5.Position = UDim2.new(0, 2, 1, -26)
				v5.TextYAlignment = Enum.TextYAlignment.Top
				v5.TextWrapped = true
				v5.Visible = true

				local UIGradient = v5:FindFirstChildOfClass("UIGradient")

				if UIGradient then
					UIGradient:Destroy()
				end

				if v11 then
					local v122 = MutationData.GetMutation(v11)

					if v122 and v122.Gradient then
						v122.Gradient:Clone().Parent = v5
					end
				end

				v62.Text = WeightFormat.FormatGrams(v7)
				v62.Size = UDim2.new(1, -4, 0, 16)
				v62.Position = UDim2.new(0, 2, 1, -18)
				v62.TextXAlignment = Enum.TextXAlignment.Center
				v62.Visible = v7 ~= nil
			elseif v1 and v6 then
				local v15 = p2:GetAttribute("Count")
				local v16 = SeedImages:FindFirstChild(v1)

				v4.Image = v16 and v16.Value or p2.TextureId

				local v19 = string.lower(v1)

				if string.sub(v19, -5) == " seed" or v19 == "seed" then
					v5.Text = v1
				else
					v5.Text = v1 .. " Seed"
				end

				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Text = FormatCount(v15)
				v62.Visible = true
			elseif v22 and v6 then
				local v20 = nil

				for v21, v222 in SprinklerData do
					if v222.SprinklerName == v22 then
						v20 = v222

						break
					end
				end

				v4.Image = v20 and v20.Image or p2.TextureId
				v5.Text = v22
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Text = FormatCount(v6)
				v62.Visible = true
			elseif v3 and v6 then
				local v25 = nil

				for v26, v27 in RakeData do
					if v27.RakeName == v3 then
						v25 = v27

						break
					end
				end

				v4.Image = v25 and v25.Image or p2.TextureId
				v5.Text = v3
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Text = FormatCount(v6)
				v62.Visible = true
			elseif v42 and v6 then
				local v30 = nil

				for v31, v32 in WateringcanData do
					if v32.Name == v42 then
						v30 = v32

						break
					end
				end

				v4.Image = v30 and v30.Image or p2.TextureId
				v5.Text = v42
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Text = FormatCount(v6)
				v62.Visible = true
			elseif p2:GetAttribute("Shovel") then
				local v35 = p2:GetAttribute("Shovel")

				v4.Image = IMG
				v5.Text = v35
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("Trowel") then
				local v36 = p2:GetAttribute("Trowel")

				v4.Image = IMG2
				v5.Text = v36
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
				v62.Text = FormatCount(v6)
				v62.Visible = true
			elseif p2:GetAttribute("Crowbar") then
				p2:GetAttribute("Crowbar")
				v4.Image = IMG4
				v5.Text = "Door Crowbar"
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
				v62.Text = FormatCount(v6)
				v62.Visible = true
			elseif p2:GetAttribute("Build") then
				local v37 = p2:GetAttribute("Build")

				v4.Image = IMG3
				v5.Text = v37
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("EmptyPot") then
				local v38 = p2:GetAttribute("EmptyPot")
				local v39 = p2:GetAttribute("Count")

				v4.Image = p2.TextureId
				v5.Text = v38
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v39 and v39 > 0 then
					v62.Text = FormatCount(v39)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("Mushroom") then
				local v40 = p2:GetAttribute("Mushroom")
				local v41 = p2:GetAttribute("Count")
				local v422 = nil

				for v43, v44 in MushroomData.Data do
					if v44.Name == v40 then
						v422 = v44

						break
					end
				end

				v4.Image = v422 and v422.IMG or p2.TextureId
				v5.Text = v40
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v41 and v41 > 0 then
					v62.Text = FormatCount(v41)
					v62.Visible = true
				else
					v62.Visible = false
				end

				if v132 and v422 then
					v132.Text = v422.Description

					local v47 = v132.TextBounds.X + TOOLTIP_BUFFER

					v132.Size = UDim2.new(0, v47, 0, TOOLTIP_HEIGHT)
					v132.Position = UDim2.new(0.5, -v47 / 2, 0, TOOLTIP_OFFSET)
				end
			elseif p2:GetAttribute("Gnome") then
				local v48 = p2:GetAttribute("Gnome")
				local v49 = p2:GetAttribute("Count")
				local v50 = nil

				for v51, v522 in GnomeData.Data do
					if v522.Name == v48 then
						v50 = v522

						break
					end
				end

				v4.Image = v50 and v50.IMG or p2.TextureId
				v5.Text = v48
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v49 and v49 > 0 then
					v62.Text = FormatCount(v49)
					v62.Visible = true
				else
					v62.Visible = false
				end

				if v132 and v50 then
					v132.Text = v50.Description

					local v55 = v132.TextBounds.X + TOOLTIP_BUFFER

					v132.Size = UDim2.new(0, v55, 0, TOOLTIP_HEIGHT)
					v132.Position = UDim2.new(0.5, -v55 / 2, 0, TOOLTIP_OFFSET)
				end
			elseif p2:GetAttribute("Raccoon") then
				local v56 = p2:GetAttribute("Raccoon")
				local v57 = p2:GetAttribute("Count")
				local v58 = nil

				for v59, v60 in RaccoonData.Data do
					if v60.Name == v56 then
						v58 = v60

						break
					end
				end

				v4.Image = v58 and v58.IMG or p2.TextureId
				v5.Text = v56
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v57 and v57 > 0 then
					v62.Text = FormatCount(v57)
					v62.Visible = true
				else
					v62.Visible = false
				end

				if v132 and v58 then
					v132.Text = v58.Description

					local v63 = v132.TextBounds.X + TOOLTIP_BUFFER

					v132.Size = UDim2.new(0, v63, 0, TOOLTIP_HEIGHT)
					v132.Position = UDim2.new(0.5, -v63 / 2, 0, TOOLTIP_OFFSET)
				end
			elseif p2:GetAttribute("Wheelbarrow") then
				local v64 = p2:GetAttribute("Wheelbarrow")

				p2:GetAttribute("Count")
				v4.Image = p2.TextureId
				v5.Text = v64
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("Ladder") then
				local v65 = p2:GetAttribute("Ladder")

				p2:GetAttribute("Count")
				v4.Image = p2.TextureId
				v5.Text = v65
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("FreezeRay") then
				p2:GetAttribute("FreezeRay")
				v4.Image = p2.TextureId
				v5.Text = "Freeze Ray"
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("Lantern") then
				p2:GetAttribute("Lantern")
				v4.Image = p2.TextureId
				v5.Text = "Lantern"
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("Sign") then
				p2:GetAttribute("Sign")
				v4.Image = p2.TextureId
				v5.Text = "Sign"
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("SeedPack") then
				local v66 = p2:GetAttribute("SeedPack")
				local v67 = p2:GetAttribute("Count")
				local v68 = SeedPackData.GetData(v66)

				v4.Image = v68 and v68.IMG or p2.TextureId

				local v71 = string.lower(v66)

				if string.sub(v71, -5) == " pack" or v71 == "pack" then
					v5.Text = v66
				else
					v5.Text = v66 .. " Seed Pack"
				end

				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v67 and v67 > 0 then
					v62.Text = FormatCount(v67)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("Egg") then
				local v72 = p2:GetAttribute("Egg")
				local v73 = p2:GetAttribute("Count")
				local v74 = EggData.GetData(v72)

				v4.Image = v74 and v74.IMG or p2.TextureId
				v5.Text = v72
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v73 and v73 > 0 then
					v62.Text = FormatCount(v73)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("Crate") then
				local v77 = p2:GetAttribute("Crate")
				local v78 = p2:GetAttribute("Count")
				local v79 = CrateData.GetData(v77)

				v4.Image = v79 and v79.IMG or p2.TextureId
				v5.Text = v77
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v78 and v78 > 0 then
					v62.Text = FormatCount(v78)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("Teleporter") then
				local v82 = p2:GetAttribute("Teleporter")
				local v83 = p2:GetAttribute("Count")
				local v84 = nil

				for v85, v86 in TeleporterData do
					if v86.TeleporterName == v82 then
						v84 = v86

						break
					end
				end

				v4.Image = v84 and v84.Image or p2.TextureId
				v5.Text = v82
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v83 and v83 > 0 then
					v62.Text = FormatCount(v83)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("PowerHose") then
				local v89 = p2:GetAttribute("PowerHose")

				p2:GetAttribute("Count")

				for v90, v91 in PowerHoseData do
					if v91.Name == v89 then
						break
					end
				end

				v4.Image = p2.TextureId
				v5.Text = "Power Hose"
				v102 = "Power Hose"
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("VineWrapper") then
				local v92 = p2:GetAttribute("VineWrapper")

				v4.Image = p2.TextureId
				v5.Text = v92
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			elseif p2:GetAttribute("Flashbang") then
				local v93 = p2:GetAttribute("Flashbang")
				local v94 = p2:GetAttribute("Count")

				v4.Image = p2.TextureId
				v5.Text = v93
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v94 and v94 > 0 then
					v62.Text = FormatCount(v94)
					v62.Visible = true
				else
					v62.Visible = false
				end
			elseif p2:GetAttribute("Bird") then
				local v95 = p2:GetAttribute("Bird")
				local v96 = p2:GetAttribute("Count")

				v4.Image = "rbxassetid://80206395781273"
				v5.Text = v95
				v102 = v5.Text
				styleItemName()
				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right

				if v96 and v96 > 0 then
					v62.Text = FormatCount(v96)
					v62.Visible = true
				else
					v62.Visible = false
				end
			else
				if p2:GetAttribute("Pet") then
					local v97 = p2:GetAttribute("Pet")

					if p2:IsA("Tool") and p2.TextureId ~= "" then
						v4.Image = p2.TextureId
					end

					v5.Text = PetData.GetDisplayName(v97, p2:GetAttribute("PetSize"))
					v102 = v5.Text
					styleItemName()
				else
					local v98 = if p2:IsA("Tool") then p2.TextureId else ""

					v4.Image = v98

					if p2.Name == "Rainbow Carpet" then
						v4.Image = v98
						v5.Text = "Carpet"
						v102 = "Rainbow Carpet"
						styleItemName()
					else
						v5.Visible = v98 == ""
						v5.Text = p2.Name
						v102 = v5.Text
						v5.Size = UDim2.new(1, -2, 1, -2)
						v5.Position = UDim2.new(0, 1, 0, 1)
						v5.TextYAlignment = Enum.TextYAlignment.Center
						v5.TextSize = FONT_SIZE
					end
				end

				v62.Size = UDim2.new(0, 30, 0, 20)
				v62.Position = UDim2.new(1, -32, 0, 2)
				v62.TextXAlignment = Enum.TextXAlignment.Right
				v62.Visible = false
			end

			local v101 = p2:GetAttribute("CooldownEnd")

			if v101 and os.clock() < v101 then
				v112(v101)
			else
				v12()
			end

			v2.FavIcon.Visible = FruitProxyUtil.IsFruitInstance(p2) and p2:GetAttribute("IsFavorite") == true

			if not (v132 and p2:IsA("Tool")) then
				return
			end

			v132.Text = p2.ToolTip

			local v103 = v132.TextBounds.X + TOOLTIP_BUFFER

			v132.Size = UDim2.new(0, v103, 0, TOOLTIP_HEIGHT)
			v132.Position = UDim2.new(0.5, -v103 / 2, 0, TOOLTIP_OFFSET)
		end

		assignToolData()

		if (p2:GetAttribute("Pet") and p2:GetAttribute("PetType") == "Rainbow") or p2:GetAttribute("RainbowItem") then
			AnimatedGradient:AddRainbowColor(v4, "ImageColor3")
			AnimatedGradient:AddRainbowColor(v2, "BackgroundColor3", 0.4) -- MODDED: fondo rainbow del slot (Shovel Rainbow)
		else
			AnimatedGradient:Remove(v4)
			AnimatedGradient:Remove(v2)
		end

		if v7 then
			v7:disconnect()
			v7 = nil
		end

		if v8 then
			v8:Disconnect()
			v8 = nil
		end

		v7 = if p2:IsA("Tool") then p2.Changed:connect(function(p1) --[[ Line: 1682 | Upvalues: assignToolData (copy) ]]
	if p1 ~= "TextureId" and (p1 ~= "Name" and p1 ~= "ToolTip") then
		return
	end

	assignToolData()
end) else p2:GetPropertyChangedSignal("Name"):Connect(function() --[[ Line: 1688 | Upvalues: assignToolData (copy) ]]
	assignToolData()
end)
		v8 = p2.AttributeChanged:Connect(function(p1) --[[ Line: 1693 | Upvalues: assignToolData (copy), p2 (copy), v112 (ref), v12 (ref) ]]
			if p1 == "Count" or (p1 == "Seed" or (p1 == "Sprinkler" or (p1 == "Build" or (p1 == "Fruit" or (p1 == "Weight" or (p1 == "Mushroom" or (p1 == "Mutation" or (p1 == "Teleporter" or (p1 == "SeedPack" or (p1 == "Egg" or (p1 == "Wheelbarrow" or (p1 == "EmptyPot" or (p1 == "Flashbang" or (p1 == "Bird" or p1 == "IsFavorite")))))))))))))) then
				assignToolData()

				return
			end

			if p1 ~= "CooldownEnd" then
				return
			end

			local v1 = p2:GetAttribute("CooldownEnd")

			if v1 and os.clock() < v1 then
				v112(v1)

				return
			end

			v12()
		end)

		local v1 = p1.Index <= v29

		if (not v1 or v11.Visible) and not UserInputService.VREnabled then
			v2.Draggable = true
		end

		p1:UpdateEquipView()

		if v1 then
			v22 = v22 + 1

			if v24 and (v22 >= 1 and not v6) then
				v6 = true
				ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
			end
		end

		t4[p2] = p1
		v21 = v33()
		UpdateBuildIcon()

		if v40 then
			return
		end

		if not v39 then
			v39 = true
			task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
				if not v40 then
					local t2 = {}
					local count2 = 0

					for i = 1, v29 do
						local v1 = t3[i]

						if v1 and v1.Tool then
							local v2 = GetToolKey(v1.Tool)

							if v2 then
								t2[i] = v2
								count2 = count2 + 1
							end
						end
					end

					if count2 ~= 0 then
						Networking.Backpack.SaveLayout:Fire(t2)
					end
				end

				v39 = false
			end)
		end
	end
	function t.Clear(p1) --[[ Clear | Line: 1736 | Upvalues: v7 (ref), v8 (ref), AnimatedGradient (ref), v4 (ref), v5 (ref), v102 (ref), v62 (ref), v132 (ref), v2 (ref), v29 (ref), v22 (ref), v6 (ref), ContextActionService (ref), t4 (ref), v12 (ref), v21 (ref), v33 (ref), UpdateBuildIcon (ref), v40 (ref), v39 (ref), t3 (ref), Networking (ref) ]]
		if not p1.Tool then
			return
		end

		if v7 then
			v7:disconnect()
			v7 = nil
		end

		if v8 then
			v8:Disconnect()
			v8 = nil
		end

		AnimatedGradient:Remove(v4)
		AnimatedGradient:Remove(v2) -- MODDED: limpiar fondo rainbow del slot al reciclarlo
		v4.Image = ""
		v5.Text = ""
		v102 = ""

		local UIGradient = v5:FindFirstChildOfClass("UIGradient")

		if UIGradient then
			UIGradient:Destroy()
		end

		v62.Text = ""
		v62.Visible = false

		if v132 then
			v132.Text = ""
			v132.Visible = false
		end

		v2.Draggable = false
		v2.FavIcon.Visible = false
		p1:UpdateEquipView(true)

		if p1.Index <= v29 then
			v22 = v22 - 1

			if v22 < 1 then
				v6 = false
				ContextActionService:UnbindAction("RBXHotbarEquip")
			end
		end

		t4[p1.Tool] = nil
		v12()
		p1.Tool = nil
		v21 = v33()
		UpdateBuildIcon()

		if v40 then
			return
		end

		if not v39 then
			v39 = true
			task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
				if not v40 then
					local t2 = {}
					local count2 = 0

					for i = 1, v29 do
						local v1 = t3[i]

						if v1 and v1.Tool then
							local v2 = GetToolKey(v1.Tool)

							if v2 then
								t2[i] = v2
								count2 = count2 + 1
							end
						end
					end

					if count2 ~= 0 then
						Networking.Backpack.SaveLayout:Fire(t2)
					end
				end

				v39 = false
			end)
		end
	end
	function t.UpdateEquipView(p1, p2) --[[ UpdateEquipView | Line: 1786 | Upvalues: v16 (ref), v31 (ref), t (copy), v9 (ref), NewGui (ref), v2 (ref), UpdateSlotFading (copy), UpdateBuildIcon (ref) ]]
		if p2 then
			if not v9 then
				UpdateSlotFading()
				UpdateBuildIcon()

				return
			end

			v9.Parent = nil
		else
			local Tool = p1.Tool

			if if Tool then Tool.Parent == v16 else Tool then
				v31 = t

				if not v9 then
					v9 = NewGui("Frame", "Equipped")
					v9.ZIndex = v2.ZIndex

					local UICorner = Instance.new("UICorner")

					UICorner.CornerRadius = script:GetAttribute("CornerRadius")
					UICorner.Parent = v9

					local v22 = SLOT_EQUIP_THICKNESS
					local UIStroke = Instance.new("UIStroke")

					UIStroke.Color = SLOT_EQUIP_COLOR
					UIStroke.Thickness = v22
					UIStroke.Parent = v9
				end

				v9.Parent = v2
			else
				if not v9 then
					UpdateSlotFading()
					UpdateBuildIcon()

					return
				end

				v9.Parent = nil
			end
		end

		UpdateSlotFading()
		UpdateBuildIcon()
	end
	function t.IsEquipped(p1) --[[ IsEquipped | Line: 1814 | Upvalues: v16 (ref) ]]
		local Tool = p1.Tool

		return if Tool then Tool.Parent == v16 else Tool
	end
	function t.Delete(p1) --[[ Delete | Line: 1818 | Upvalues: v2 (ref), t3 (ref), UpdateScrollingFrameCanvasSize (ref) ]]
		v2:Destroy()
		table.remove(t3, p1.Index)

		for i = p1.Index, #t3 do
			t3[i]:SlideBack()
		end

		UpdateScrollingFrameCanvasSize()
	end
	function t.Swap(p1, p2) --[[ Swap | Line: 1830 | Upvalues: v29 (ref), FruitProxyUtil (ref), v40 (ref), v39 (ref), t3 (ref), Networking (ref), v35 (ref) ]]
		local Tool = p1.Tool
		local Tool2 = p2.Tool
		local Index = p1.Index
		local Index2 = p2.Index
		local v1 = Index <= v29
		local v2 = if Index2 <= v29 then true else false

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

		if Tool and (FruitProxyUtil.IsFruitProxy(Tool) and v2) then
			local v3 = Tool:GetAttribute("Id")

			if v3 then
				FruitProxyUtil.Pending.Slots[v3] = Index2
				FruitProxyUtil.RequestPromote(v3)
			end
		end

		if Tool2 and (FruitProxyUtil.IsFruitProxy(Tool2) and v1) then
			local v4 = Tool2:GetAttribute("Id")

			if v4 then
				FruitProxyUtil.Pending.Slots[v4] = Index
				FruitProxyUtil.RequestPromote(v4)
			end
		end

		if Tool and (FruitProxyUtil.IsFruitTool(Tool) and (not v2 and v1)) then
			local v5 = Tool:GetAttribute("Id")

			if v5 then
				FruitProxyUtil.Pending.Slots[v5] = Index2
				FruitProxyUtil.RequestDemote(v5)
			end
		end

		if Tool2 and (FruitProxyUtil.IsFruitTool(Tool2) and (not v1 and v2)) then
			local v6 = Tool2:GetAttribute("Id")

			if v6 then
				FruitProxyUtil.Pending.Slots[v6] = Index
				FruitProxyUtil.RequestDemote(v6)
			end
		end

		if not (v40 or v39) then
			v39 = true
			task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
				if not v40 then
					local t2 = {}
					local count2 = 0

					for i = 1, v29 do
						local v1 = t3[i]

						if v1 and v1.Tool then
							local v2 = GetToolKey(v1.Tool)

							if v2 then
								t2[i] = v2
								count2 = count2 + 1
							end
						end
					end

					if count2 ~= 0 then
						Networking.Backpack.SaveLayout:Fire(t2)
					end
				end

				v39 = false
			end)
		end

		v35()
	end
	function t.SlideBack(p1) --[[ SlideBack | Line: 1881 | Upvalues: v42 (ref), v2 (ref) ]]
		p1.Index = p1.Index - 1

		if v42 then
			return
		end

		v2.Name = p1.Index
		v2.LayoutOrder = p1.Index
	end
	function t.TurnNumber(p1, p2) --[[ TurnNumber | Line: 1889 | Upvalues: v142 (ref) ]]
		if not v142 then
			return
		end

		v142.Visible = p2
	end
	function t.SetClickability(p1, p2) --[[ SetClickability | Line: 1895 | Upvalues: UserInputService (ref), v2 (ref), UpdateSlotFading (copy) ]]
		if not p1.Tool then
			return
		end

		if UserInputService.VREnabled then
			v2.Draggable = false
		else
			v2.Draggable = not p2
		end

		UpdateSlotFading()
	end
	function t.CheckTerms(p1, p2) --[[ CheckTerms | Line: 1906 | Upvalues: v102 (ref), v132 (ref) ]]
		local sum = 0

		local function checkEm(p1, p2) --[[ checkEm | Line: 1908 | Upvalues: sum (ref) ]]
			local _, v1 = p1:lower():gsub(p2, "")

			sum = sum + v1
		end

		local Tool = p1.Tool

		if Tool then
			for k in pairs(p2) do
				local v1 = k:gsub("([%(%)%.%%%+%-%*%?%[%]%^%$])", "%%%1")
				local _, v2 = v102:lower():gsub(v1, "")

				sum = sum + v2

				if Tool:IsA("Tool") then
					local _2, v4 = (if v132 then v132.Text or "" else ""):lower():gsub(v1, "")

					sum = sum + v4
				end
			end
		end

		return sum
	end
	function t.Select(p1) --[[ Select | Line: 1935 | Upvalues: LocalPlayer (ref), t (copy), FruitProxyUtil (ref), v16 (ref), Backpack (ref), v54 (ref), Humanoid (ref), RunService (ref) ]]
		if LocalPlayer:GetAttribute("LoadingScreenActive") then
			return
		end

		if LocalPlayer:GetAttribute("IsStealingFruit") or LocalPlayer:GetAttribute("CarryingStolenFruit") then
			return
		end

		local Tool = t.Tool

		if not Tool then
			return
		end

		if FruitProxyUtil.IsFruitProxy(Tool) then
			local v1 = Tool:GetAttribute("Id")

			if not v1 then
				return
			end

			if v16 then
				for v2, v3 in v16:GetChildren() do
					if v3:IsA("Tool") then
						v3.Parent = Backpack
					end
				end
			end

			FruitProxyUtil.Pending.Slots[v1] = p1.Index
			FruitProxyUtil.Pending.Equip = v1
			FruitProxyUtil.RequestPromote(v1)
		else
			local v4 = if Tool then if Tool.Parent == v16 then true else false else Tool

			v54 = nil

			if v4 then
				if Humanoid then
					Humanoid:UnequipTools()
				end
			else
				if Tool.Parent ~= Backpack then
					return
				end

				if Humanoid then
					Humanoid:UnequipTools()
				end

				local v5 = Tool:GetAttribute("ToolDescendants")

				if if type(v5) == "number" then if v5 <= #Tool:GetDescendants() then true else false else true then
					Tool.Parent = v16

					return
				end

				v54 = Tool
				task.spawn(function() --[[ Line: 957 | Upvalues: v54 (ref), Tool (copy), RunService (ref), Backpack (ref), v16 (ref), Humanoid (ref) ]]
					local v1 = os.clock() + 1

					while v54 == Tool do
						local v2 = Tool
						local v3 = v2:GetAttribute("ToolDescendants")
						local v4 = if type(v3) == "number" then if v3 <= #v2:GetDescendants() then true else false else true

						if v4 or not (os.clock() < v1) then
							break
						end

						RunService.Heartbeat:Wait()
					end

					if v54 ~= Tool then
						return
					end

					v54 = nil

					if Tool.Parent ~= Backpack or not (v16 and v16.Parent) then
						return
					end

					v54 = nil

					if not Humanoid then
						Tool.Parent = v16

						return
					end

					Humanoid:UnequipTools()
					Tool.Parent = v16
				end)
			end
		end
	end
	v2 = NewGui("TextButton", v1)

	local UIStroke = Instance.new("UIStroke")

	UIStroke.Parent = v2

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = script:GetAttribute("CornerRadius")
	UICorner.Parent = v2
	UIStroke.Thickness = 0
	v2.BackgroundColor3 = BACKGROUND_COLOR
	UIStroke.Color = SLOT_BORDER_COLOR
	v2.Text = ""
	v2.AutoButtonColor = false
	v2.BorderSizePixel = 0
	v2.Size = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
	v2.Active = true
	v2.Draggable = false
	v2.BackgroundTransparency = SLOT_FADE_LOCKED
	v2.MouseButton1Click:connect(function() --[[ Line: 1983 | Upvalues: t (copy) ]]
		changeSlot(t)
	end)
	v2.MouseButton2Click:Connect(function() --[[ Line: 1984 | Upvalues: ToggleFavorite (ref), t (copy) ]]
		ToggleFavorite(t)
	end)

	local v15 = nil
	local v162 = nil
	local v172 = nil

	local function cancelTouch() --[[ cancelTouch | Line: 1994 | Upvalues: v172 (ref), v15 (ref), v162 (ref) ]]
		if not v172 then
			v15 = nil
			v162 = nil

			return
		end

		task.cancel(v172)
		v172 = nil
		v15 = nil
		v162 = nil
	end

	v2.InputBegan:Connect(function(p1) --[[ Line: 2003 | Upvalues: v172 (ref), v15 (ref), v162 (ref), ToggleFavorite (ref), t (copy) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if not v172 then
			v15 = nil
			v162 = nil
			v15 = os.clock()
			v162 = p1.Position
			v172 = task.delay(1, function() --[[ Line: 2008 | Upvalues: v15 (ref), ToggleFavorite (ref), t (ref), v172 (ref), v162 (ref) ]]
				if v15 and os.clock() - v15 >= 1 then
					ToggleFavorite(t)
				end

				v172 = nil
				v15 = nil
				v162 = nil
			end)

			return
		end

		task.cancel(v172)
		v172 = nil
		v15 = nil
		v162 = nil
		v15 = os.clock()
		v162 = p1.Position
		v172 = task.delay(1, function() --[[ Line: 2008 | Upvalues: v15 (ref), ToggleFavorite (ref), t (ref), v172 (ref), v162 (ref) ]]
			if v15 and os.clock() - v15 >= 1 then
				ToggleFavorite(t)
			end

			v172 = nil
			v15 = nil
			v162 = nil
		end)
	end)
	v2.InputChanged:Connect(function(p1) --[[ Line: 2018 | Upvalues: v162 (ref), v172 (ref), v15 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if not (v162 and (p1.Position - v162).Magnitude > 8) then
			return
		end

		if v172 then
			task.cancel(v172)
			v172 = nil
		end

		v15 = nil
		v162 = nil
	end)
	v2.InputEnded:Connect(function(p1) --[[ Line: 2025 | Upvalues: v172 (ref), v15 (ref), v162 (ref) ]]
		if p1.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if not v172 then
			v15 = nil
			v162 = nil

			return
		end

		task.cancel(v172)
		v172 = nil
		v15 = nil
		v162 = nil
	end)
	v2.DragBegin:Connect(cancelTouch)
	t.Frame = v2

	local v18 = NewGui("Frame", "SelectionObjectClipper")

	v18.Visible = false
	v18.Parent = v2

	local v19 = NewGui("ImageLabel", "Selector")

	v19.Size = UDim2.new(1, 0, 1, 0)
	v19.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
	v19.ScaleType = Enum.ScaleType.Slice
	v19.SliceCenter = Rect.new(12, 12, 52, 52)
	v19.Parent = v18
	v4 = NewGui("ImageLabel", "Icon")
	v4.Size = UDim2.new(0.8, 0, 0.8, 0)
	v4.Position = UDim2.new(0.1, 0, 0.1, 0)
	v4.Parent = v2
	v62 = NewGui("TextLabel", "ToolCount")
	v62.Size = UDim2.new(0, 30, 0, 20)
	v62.Position = UDim2.new(1, -32, 0, 2)
	v62.TextXAlignment = Enum.TextXAlignment.Right
	v62.FontFace = script:GetAttribute("SlotFont")
	v62.TextSize = 14
	v62.TextScaled = true

	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

	UITextSizeConstraint.MaxTextSize = 14
	UITextSizeConstraint.Parent = v62
	v62.Visible = false
	v62.Parent = v2

	local v20 = NewGui("Frame", "CooldownOverlay")

	v20.BackgroundColor3 = Color3.new(0/255, 0/255, 0/255)
	v20.BackgroundTransparency = 0.3
	v20.Size = UDim2.new(1, 0, 1, 0)
	v20.ZIndex = 5
	v20.Visible = false
	v20.Parent = v2

	local UICorner2 = Instance.new("UICorner")

	UICorner2.CornerRadius = script:GetAttribute("CornerRadius")
	UICorner2.Parent = v20

	local v212 = NewGui("TextLabel", "CooldownText")

	v212.Size = UDim2.new(1, 0, 1, 0)
	v212.TextSize = 22
	v212.FontFace = script:GetAttribute("ToolTipFont")
	v212.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	v212.ZIndex = 6
	v212.Parent = v20

	local v222 = nil

	v12 = function() --[[ Line: 2093 | Upvalues: v20 (copy), v212 (copy), v222 (ref) ]]
		v20.Visible = false
		v212.Text = ""

		if not v222 then
			return
		end

		v222:Disconnect()
		v222 = nil
	end
	v112 = function(p1) --[[ Line: 2102 | Upvalues: v12 (ref), v20 (copy), v222 (ref), RunService (ref), v212 (copy) ]]
		v12()
		v20.Visible = true
		v222 = RunService.Heartbeat:Connect(function() --[[ Line: 2105 | Upvalues: p1 (copy), v12 (ref), v212 (ref) ]]
			local v1 = p1 - os.clock()

			if v1 <= 0 then
				v12()
			else
				v212.Text = math.ceil(v1) .. "s"
			end
		end)
	end

	local v23 = NewGui("ImageLabel", "FavIcon")

	v23.Size = UDim2.new(0.3, 0, 0.3, 0)
	v23.AnchorPoint = Vector2.new(1, 0)
	v23.Position = UDim2.new(1, -2, 0, 2)
	v23.Parent = v2
	v23.Visible = false
	v23.Image = "rbxassetid://102498784369651"
	v23.BackgroundTransparency = 1
	v23.ZIndex = 10
	v5 = NewGui("TextLabel", "ToolName")
	v5.Size = UDim2.new(1, -2, 1, -2)
	v5.Position = UDim2.new(0, 1, 0, 1)
	v5.Parent = v2
	t.Frame.LayoutOrder = t.Index

	if v1 <= v29 then
		v132 = NewGui("TextLabel", "ToolTip")
		v132.ZIndex = 2
		v132.FontFace = script:GetAttribute("ToolTipFont")
		v132.TextWrapped = false
		v132.TextYAlignment = Enum.TextYAlignment.Center
		v132.BackgroundColor3 = Color3.new(102/255, 102/255, 102/255)
		v132.BackgroundTransparency = 0
		v132.Visible = false
		v132.Parent = v2

		local UICorner3 = Instance.new("UICorner")

		UICorner3.CornerRadius = script:GetAttribute("CornerRadius")
		UICorner3.Parent = v132
		v2.MouseEnter:connect(function() --[[ Line: 2145 | Upvalues: v132 (ref) ]]
			if v132.Text == "" then
				return
			end

			v132.Visible = true
		end)
		v2.MouseLeave:connect(function() --[[ Line: 2150 | Upvalues: v132 (ref) ]]
			v132.Visible = false
		end)
		function t.MoveToInventory(p1) --[[ MoveToInventory | Line: 2152 | Upvalues: t (copy), v29 (ref), FruitProxyUtil (ref), v34 (ref), v14 (ref), v16 (ref), v54 (ref), Humanoid (ref), v26 (ref), v11 (ref), v36 (ref), v35 (ref), v40 (ref), v39 (ref), t3 (ref), Networking (ref) ]]
			if not (t.Index <= v29) then
				return
			end

			local Tool = t.Tool
			local v1 = if Tool then FruitProxyUtil.IsFruitTool(Tool) else Tool

			p1:Clear()

			local v2 = v34(v14)

			v2:Fill(Tool)

			if v1 then
				local v3 = Tool:GetAttribute("Id")

				if v3 then
					FruitProxyUtil.Pending.Slots[v3] = v2.Index
					FruitProxyUtil.RequestDemote(v3)
				end
			elseif if Tool then Tool.Parent == v16 else Tool then
				v54 = nil

				if Humanoid then
					Humanoid:UnequipTools()
				end
			end

			if v26 then
				v2.Frame.Visible = false
				v2.Frame.Parent = v11
			end

			v36()
			v35()

			if v40 then
				return
			end

			if v39 then
				return
			end

			v39 = true
			task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
				if not v40 then
					local t2 = {}
					local count2 = 0

					for i = 1, v29 do
						local v1 = t3[i]

						if v1 and v1.Tool then
							local v2 = GetToolKey(v1.Tool)

							if v2 then
								t2[i] = v2
								count2 = count2 + 1
							end
						end
					end

					if count2 ~= 0 then
						Networking.Backpack.SaveLayout:Fire(t2)
					end
				end

				v39 = false
			end)
		end

		if v1 < 10 or v1 == v29 then
			local v25 = v1 < 10 and v1 or 0

			v142 = NewGui("TextLabel", "Number")
			v142.Text = v25
			v142.Size = UDim2.new(0, 15, 0, 15)
			v142.Visible = false
			v142.Parent = v2
			t5[Zero + v25] = t.Select
		end
	end

	local Position = v2.Position
	local v262 = 0
	local v27 = nil

	v2.DragBegin:connect(function(p1) --[[ Line: 2197 | Upvalues: t6 (ref), v2 (ref), Position (ref), UIStroke (copy), v17 (ref), v4 (ref), v5 (ref), v62 (ref), v142 (ref), v9 (ref), v27 (ref), v14 (ref), v11 (ref), v3 (ref), NewGui (ref) ]]
		t6[v2] = true
		Position = p1
		UIStroke.Thickness = 2
		v17:lock()
		v2.ZIndex = 2
		v4.ZIndex = 2
		v5.ZIndex = 2
		v62.ZIndex = 2
		v2.Parent.ZIndex = 2

		if v142 then
			v142.ZIndex = 2
		end

		if v9 then
			v9.ZIndex = 2

			for k, v in pairs(v9:GetChildren()) do
				if not (v:IsA("UICorner") or v:IsA("UIStroke")) then
					v.ZIndex = 2
				end
			end
		end

		v27 = v2.Parent

		if v27 ~= v14 then
			return
		end

		local AbsolutePosition = v2.AbsolutePosition
		local v1 = UDim2.new(0, v2.AbsolutePosition.X - v11.AbsolutePosition.X, 0, v2.AbsolutePosition.Y - v11.AbsolutePosition.Y)

		v2.Parent = v11
		v2.Position = v1
		v3 = NewGui("Frame", "FakeSlot")
		v3.LayoutOrder = v2.LayoutOrder
		v3.Size = v2.Size
		v3.BackgroundTransparency = 1
		v3.Parent = v14
	end)
	v2.DragStopped:connect(function(p1, p2) --[[ Line: 2238 | Upvalues: v3 (ref), v2 (ref), Position (ref), v27 (ref), UIStroke (copy), v17 (ref), v4 (ref), v5 (ref), v62 (ref), v142 (ref), v9 (ref), t6 (ref), t (copy), v11 (ref), v29 (ref), v262 (ref), v21 (ref), v10 (ref), t3 (ref), v16 (ref), v54 (ref), Humanoid (ref), v36 (ref), v40 (ref), v39 (ref), Networking (ref) ]]
		if v3 then
			v3:Destroy()
		end

		local v1 = tick()

		v2.Position = Position
		v2.Parent = v27
		UIStroke.Thickness = 0
		v17:unlock()
		v2.ZIndex = 1
		v4.ZIndex = 1
		v5.ZIndex = 1
		v62.ZIndex = 1
		v27.ZIndex = 1

		if v142 then
			v142.ZIndex = 1
		end

		if v9 then
			v9.ZIndex = 1

			for k, v in pairs(v9:GetChildren()) do
				if not (v:IsA("UICorner") or v:IsA("UIStroke")) then
					v.ZIndex = 1
				end
			end
		end

		t6[v2] = nil

		if not t.Tool then
			return
		end

		local v22 = v11
		local AbsolutePosition = v22.AbsolutePosition
		local AbsoluteSize = v22.AbsoluteSize

		if if AbsolutePosition.X < p1 and (p1 <= AbsolutePosition.X + AbsoluteSize.X and AbsolutePosition.Y < p2) then if p2 <= AbsolutePosition.Y + AbsoluteSize.Y then true else false else false then
			if t.Index <= v29 then
				t:MoveToInventory()
			end

			if v29 < t.Index and v1 - v262 < 0.5 then
				if v21 then
					t:Clear()
					v21:Fill(t.Tool)
					t:Delete()
				end

				v1 = 0
			end
		else
			local v42 = v10
			local AbsolutePosition2 = v42.AbsolutePosition
			local AbsoluteSize2 = v42.AbsoluteSize

			if if AbsolutePosition2.X < p1 and (p1 <= AbsolutePosition2.X + AbsoluteSize2.X and AbsolutePosition2.Y < p2) then if p2 <= AbsolutePosition2.Y + AbsoluteSize2.Y then true else false else false then
				local t2 = { (1 / 0), nil }

				for i = 1, v29 do
					local v6 = t3[i]
					local Frame = v6.Frame
					local magnitude = (Frame.AbsolutePosition + Frame.AbsoluteSize / 2 - Vector2.new(p1, p2)).magnitude

					if magnitude < t2[1] then
						t2 = { magnitude, v6 }
					end
				end

				local v8 = t2[2]

				if v8 ~= t then
					t:Swap(v8)

					if v29 < t.Index then
						local Tool = t.Tool

						if Tool then
							if if Tool then Tool.Parent == v16 else Tool then
								v54 = nil

								if Humanoid then
									Humanoid:UnequipTools()
								end
							end

							v36()
						else
							t:Delete()
						end
					end
				end
			elseif t.Index <= v29 then
				t:MoveToInventory()
			end
		end

		if not (v40 or v39) then
			v39 = true
			task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
				if not v40 then
					local t2 = {}
					local count2 = 0

					for i = 1, v29 do
						local v1 = t3[i]

						if v1 and v1.Tool then
							local v2 = GetToolKey(v1.Tool)

							if v2 then
								t2[i] = v2
								count2 = count2 + 1
							end
						end
					end

					if count2 ~= 0 then
						Networking.Backpack.SaveLayout:Fire(t2)
					end
				end

				v39 = false
			end)
		end

		v262 = v1
	end)
	v2.Parent = p1
	t3[v1] = t

	if v29 < v1 then
		local v292 = math.floor(v13.AbsoluteSize.X / (ICON_SIZE + ICON_BUFFER))

		if v292 < 1 then
			v292 = 1
		end

		v13.CanvasSize = UDim2.new(0, 0, 0, math.ceil(v41 / v292) * (ICON_SIZE + ICON_BUFFER) + ICON_BUFFER)

		if v11.Visible and not v26 then
			v13.CanvasPosition = Vector2.new(0, (math.max(0, v13.CanvasSize.Y.Offset - v13.AbsoluteSize.Y)))
		end
	end

	return t
end
function OnChildAdded(p1) --[[ OnChildAdded | Line: 2348 | Upvalues: FruitProxyUtil (copy), v16 (ref), Humanoid (ref), f53 (ref), v28 (ref), v23 (ref), t4 (ref), LocalPlayer (ref), v21 (ref), v34 (ref), v14 (ref), t3 (ref), Backpack (ref), v35 (ref), UpdateBuildIcon (ref), RunService (copy), v29 (ref), v11 (ref), t (copy), v26 (ref), ToolMatchesFilter (copy), v32 (ref), v41 (ref), UpdateScrollingFrameCanvasSize (ref), v40 (ref) ]]
	local v1 = p1:IsA("Tool")
	local v2 = FruitProxyUtil.IsFruitProxy(p1)

	if v1 or v2 then
		f53()

		if p1.Parent == v16 then
			v28 = tick()
		end

		if not v23 and (p1.Parent == v16 and not t4[p1]) then
			local StarterGear = LocalPlayer:FindFirstChild("StarterGear")

			if StarterGear and StarterGear:FindFirstChild(p1.Name) then
				v23 = true

				for i = (v21 or v34(v14)).Index, 1, -1 do
					local v4 = t3[i]
					local v5 = i - 1

					if v5 > 0 then
						t3[v5]:Swap(v4)

						continue
					end

					v4:Fill(p1)
				end

				for k, v in pairs(v16:GetChildren()) do
					if v:IsA("Tool") and v ~= p1 then
						v.Parent = Backpack
					end
				end

				v35()

				return
			end
		end

		local v6 = p1:GetAttribute("Id")
		local v7 = if v6 then FruitProxyUtil.Pending.Slots[v6] else v6

		if v7 then
			if v1 and t4[p1] then
				t4[p1]:UpdateEquipView()
			else
				FruitProxyUtil.Pending.Slots[v6] = nil

				local v8 = t3[v7]

				if v8 then
					if v8.Tool then
						v8:Clear()
					end

					v8:Fill(p1)
				end

				if FruitProxyUtil.Pending.Equip == v6 and v1 then
					FruitProxyUtil.Pending.Equip = nil
					task.spawn(function() --[[ Line: 2412 | Upvalues: RunService (ref), p1 (copy), Backpack (ref), v16 (ref) ]]
						RunService.Heartbeat:Wait()

						if not p1 or (p1.Parent ~= Backpack or not v16) then
							return
						end

						for v1, v2 in v16:GetChildren() do
							if v2:IsA("Tool") then
								v2.Parent = Backpack
							end
						end

						p1.Parent = v16
					end)
				end
			end
		else
			local v9 = t4[p1]

			if v9 then
				v9:UpdateEquipView()
			else
				local v10 = v21 or v34(v14)

				v10:Fill(p1)

				if v10.Index <= v29 and not v11.Visible then
					v35()
				end

				if v29 < v10.Index then
					local _ApplySearch = t._ApplySearch

					if v26 and _ApplySearch then
						_ApplySearch()
					else
						v10.Frame.LayoutOrder = v10.Index

						local v112, v12

						if v10.Tool == nil then
							v112 = v10
							v12 = false
						else
							v12 = ToolMatchesFilter(v10.Tool, v32)
							v112 = v10
						end

						v112.Frame.Visible = v12

						if v12 then
							v41 = v41 + 1
						end

						UpdateScrollingFrameCanvasSize()
					end
				end

				local v13 = v10

				if not v40 and (v13.Index <= v29 and v2) then
					local v142 = p1:GetAttribute("Id")

					if v142 then
						FruitProxyUtil.Pending.Slots[v142] = v13.Index
						FruitProxyUtil.RequestPromote(v142)
					end
				end
			end
		end

		UpdateBuildIcon()
	else
		if not p1:IsA("Humanoid") or p1.Parent ~= v16 then
			return
		end

		Humanoid = p1
	end
end
function OnChildRemoved(p1) --[[ OnChildRemoved | Line: 2453 | Upvalues: FruitProxyUtil (copy), f53 (ref), v28 (ref), v16 (ref), Backpack (ref), t4 (ref), v29 (ref), v22 (ref), f51 (ref), v11 (ref), v35 (ref), UpdateBuildIcon (ref) ]]
	if not (p1:IsA("Tool") or FruitProxyUtil.IsFruitProxy(p1)) then
		return
	end

	f53()
	v28 = tick()

	local v1 = p1.Parent

	if v1 == v16 or v1 == Backpack then
		return
	end

	local v2 = p1:GetAttribute("Id")

	if v2 and FruitProxyUtil.Pending.Slots[v2] then
		local v3 = t4[p1]

		if not v3 then
			return
		end

		if v3.Index <= v29 then
			v22 = v22 - 1
		end

		t4[p1] = nil
		v3.Tool = nil
	else
		local v4 = t4[p1]

		if not v4 then
			UpdateBuildIcon()

			return
		end

		if v29 < v4.Index then
			t4[p1] = nil
			v4.Tool = nil
			f51(v4)
		else
			v4:Clear()

			if v11.Visible then
				UpdateBuildIcon()

				return
			end

			v35()
		end

		UpdateBuildIcon()
	end
end
function OnCharacterAdded(p1) --[[ OnCharacterAdded | Line: 2498 | Upvalues: v40 (ref), FruitProxyUtil (copy), t3 (ref), v29 (ref), v41 (ref), t8 (ref), v16 (ref), Backpack (ref), LocalPlayer (ref), v35 (ref), UpdateBuildIcon (ref), v38 (ref), Networking (copy), v37 (ref), ApplySavedLayout (copy) ]]
	v40 = true
	table.clear(FruitProxyUtil.Pending.Slots)
	FruitProxyUtil.Pending.Equip = nil

	for i = #t3, 1, -1 do
		local v1 = t3[i]

		if v1.Tool then
			v1:Clear()
		end

		if v29 < i then
			v1:Delete()
		end
	end

	v41 = 0

	for k, v in pairs(t8) do
		v:Disconnect()
	end

	t8 = {}
	v16 = p1
	table.insert(t8, p1.ChildRemoved:Connect(OnChildRemoved))
	table.insert(t8, p1.ChildAdded:Connect(OnChildAdded))

	for k, v in pairs(p1:GetChildren()) do
		OnChildAdded(v)
	end

	Backpack = LocalPlayer:WaitForChild("Backpack")
	table.insert(t8, Backpack.ChildRemoved:Connect(OnChildRemoved))
	table.insert(t8, Backpack.ChildAdded:Connect(OnChildAdded))

	for k, v in pairs(Backpack:GetChildren()) do
		OnChildAdded(v)
	end

	v35()
	UpdateBuildIcon()
	task.defer(function() --[[ Line: 2540 | Upvalues: v38 (ref), Networking (ref), v37 (ref), ApplySavedLayout (ref), v40 (ref) ]]
		if v38 then
			if v37 then
				v38 = false
				ApplySavedLayout()
			end
		else
			local ok, result = pcall(function() --[[ Line: 2543 | Upvalues: Networking (ref) ]]
				return Networking.Backpack.GetLayout:Fire()
			end)

			if ok and (result and typeof(result) == "table") then
				local count = 0

				for k in pairs(result) do
					count = count + 1
				end

				if count > 0 then
					v37 = result
					ApplySavedLayout()
				else
					v38 = true
				end
			else
				v38 = true
			end
		end

		v40 = false
	end)
end
function OnInputBegan(p1, p2) --[[ OnInputBegan | Line: 2572 | Upvalues: v25 (ref), v24 (ref), Backspace (copy), t5 (ref), v11 (ref), v17 (copy) ]]
	if p2 ~= false then
		return
	end

	if p1.UserInputType == Enum.UserInputType.Keyboard and (not v25 and (v24 or p1.KeyCode.Value == Backspace)) then
		local v1 = t5[p1.KeyCode.Value]

		if v1 then
			v1(p2)
		end
	end

	local UserInputType = p1.UserInputType

	if UserInputType ~= Enum.UserInputType.MouseButton1 and UserInputType ~= Enum.UserInputType.Touch or not v11.Visible then
		return
	end

	v17:deselect()
end

local function OnUISChanged(p1) --[[ OnUISChanged | Line: 2590 | Upvalues: UserInputService (copy), v29 (ref), t3 (ref) ]]
	if p1 ~= "KeyboardEnabled" and p1 ~= "VREnabled" then
		return
	end

	local v1 = UserInputService.KeyboardEnabled and not UserInputService.VREnabled

	for i = 1, v29 do
		t3[i]:TurnNumber(v1)
	end
end

local v55 = nil
local v56 = nil

local function f57() --[[ Line: 2602 ]] end

local v58 = Vector2.new(0, 0)

function unbindAllGamepadEquipActions() --[[ unbindAllGamepadEquipActions | Line: 2606 | Upvalues: ContextActionService (copy) ]]
	ContextActionService:UnbindAction("RBXBackpackHasGamepadFocus")
	ContextActionService:UnbindAction("RBXCloseInventory")
end

local function setHotbarVisibility(p1, p2) --[[ setHotbarVisibility | Line: 2611 | Upvalues: v29 (ref), t3 (ref) ]]
	for i = 1, v29 do
		local v1 = t3[i]

		if v1 and (v1.Frame and (p2 or v1.Tool)) then
			v1.Frame.Visible = p1
		end
	end
end

local function getInputDirection(p1) --[[ getInputDirection | Line: 2620 | Upvalues: v58 (ref) ]]
	local v1 = if p1.UserInputState == Enum.UserInputState.End then -1 else 1

	if p1.KeyCode == Enum.KeyCode.Thumbstick1 then
		local magnitude = p1.Position.magnitude

		v58 = if magnitude > 0.98 then Vector2.new(p1.Position.x / magnitude, -p1.Position.y / magnitude) else Vector2.new(0, 0)
	else
		v58 = if p1.KeyCode == Enum.KeyCode.DPadLeft then Vector2.new(v58.x - v1 * 1, v58.y) elseif p1.KeyCode == Enum.KeyCode.DPadRight then Vector2.new(v58.x + v1 * 1, v58.y) elseif p1.KeyCode == Enum.KeyCode.DPadUp then Vector2.new(v58.x, v58.y - v1 * 1) elseif p1.KeyCode == Enum.KeyCode.DPadDown then Vector2.new(v58.x, v58.y + v1 * 1) else Vector2.new(0, 0)
	end

	return v58
end

function changeToolFunc(p1, p2, p3) --[[ Line: 2679 | Upvalues: v55 (ref), v56 (ref), UserInputService (copy), v54 (ref), Humanoid (ref), v29 (ref), t3 (ref), v31 (ref) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	if v55 then
		if (v55.KeyCode ~= Enum.KeyCode.ButtonR1 or p3.KeyCode ~= Enum.KeyCode.ButtonL1) and (v55.KeyCode ~= Enum.KeyCode.ButtonL1 or p3.KeyCode ~= Enum.KeyCode.ButtonR1) then
			v55 = p3
			v56 = tick()
			task.delay(0.06, function() --[[ Line: 2705 | Upvalues: v55 (ref), p3 (copy), v29 (ref), t3 (ref), v54 (ref), Humanoid (ref), v31 (ref) ]]
				if v55 ~= p3 then
					return
				end

				local v1 = if p3.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

				for i = 1, v29 do
					if t3[i]:IsEquipped() then
						local sum2 = v1 + i
						local v2 = false

						if v29 < sum2 then
							sum2 = 1
							v2 = true
						elseif sum2 < 1 then
							sum2 = v29
							v2 = true
						end

						local v3 = sum2

						while not t3[sum2].Tool do
							sum2 = sum2 + v1

							if sum2 == v3 then
								return
							end

							if v29 < sum2 then
								sum2 = 1
								v2 = true
							elseif sum2 < 1 then
								sum2 = v29
								v2 = true
							else
								continue
							end
						end

						if not v2 then
							t3[sum2]:Select()

							return
						end

						v54 = nil

						if not Humanoid then
							v31 = nil

							return
						end

						Humanoid:UnequipTools()
						v31 = nil

						return
					end
				end

				if v31 and v31.Tool then
					v31:Select()

					return
				end

				for j = if v1 == -1 then v29 or 1 else 1, if v1 == -1 then 1 else v29, v1 do
					if t3[j].Tool then
						t3[j]:Select()

						return
					end
				end
			end)

			return
		end

		if tick() - v56 <= 0.06 and UserInputService:IsGamepadButtonDown(p3.UserInputType, v55.KeyCode) then
			v54 = nil

			if not Humanoid then
				v55 = p3
				v56 = tick()

				return
			end

			Humanoid:UnequipTools()
			v55 = p3
			v56 = tick()

			return
		end
	end

	v55 = p3
	v56 = tick()
	task.delay(0.06, function() --[[ Line: 2705 | Upvalues: v55 (ref), p3 (copy), v29 (ref), t3 (ref), v54 (ref), Humanoid (ref), v31 (ref) ]]
		if v55 ~= p3 then
			return
		end

		local v1 = if p3.KeyCode == Enum.KeyCode.ButtonL1 then -1 else 1

		for i = 1, v29 do
			if t3[i]:IsEquipped() then
				local sum2 = v1 + i
				local v2 = false

				if v29 < sum2 then
					sum2 = 1
					v2 = true
				elseif sum2 < 1 then
					sum2 = v29
					v2 = true
				end

				local v3 = sum2

				while not t3[sum2].Tool do
					sum2 = sum2 + v1

					if sum2 == v3 then
						return
					end

					if v29 < sum2 then
						sum2 = 1
						v2 = true
					elseif sum2 < 1 then
						sum2 = v29
						v2 = true
					else
						continue
					end
				end

				if not v2 then
					t3[sum2]:Select()

					return
				end

				v54 = nil

				if not Humanoid then
					v31 = nil

					return
				end

				Humanoid:UnequipTools()
				v31 = nil

				return
			end
		end

		if v31 and v31.Tool then
			v31:Select()

			return
		end

		for j = if v1 == -1 then v29 or 1 else 1, if v1 == -1 then 1 else v29, v1 do
			if t3[j].Tool then
				t3[j]:Select()

				return
			end
		end
	end)
end
function getGamepadSwapSlot() --[[ getGamepadSwapSlot | Line: 2768 | Upvalues: t3 (ref) ]]
	for i = 1, #t3 do
		if t3[i].Frame:WaitForChild("UIStroke").Thickness > 0 then
			return t3[i]
		end
	end
end
function changeSlot(p1) --[[ changeSlot | Line: 2776 | Upvalues: VRService (copy), v11 (ref), GuiService (copy), v12 (ref), v29 (ref) ]]
	if p1.Frame == GuiService.SelectedObject and (not VRService.VREnabled or v11.Visible) then
		local v2 = getGamepadSwapSlot()

		if not v2 then
			local Size = p1.Frame.Size
			local Position = p1.Frame.Position

			p1.Frame:TweenSizeAndPosition(Size + UDim2.new(0, 10, 0, 10), Position - UDim2.new(0, 5, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 2805 | Upvalues: p1 (copy), Size (copy), Position (copy) ]]
				p1.Frame:TweenSizeAndPosition(Size, Position, Enum.EasingDirection.In, Enum.EasingStyle.Quad, 0.1, true)
			end)
			p1.Frame:WaitForChild("UIStroke").Thickness = 3
			v12.SelectionImageObject.Visible = true

			return
		end

		v2.Frame:WaitForChild("UIStroke").Thickness = 0

		if v2 == p1 then
			return
		end

		p1:Swap(v2)
		v12.SelectionImageObject.Visible = false

		if v29 < p1.Index and not p1.Tool then
			if GuiService.SelectedObject == p1.Frame then
				GuiService.SelectedObject = v2.Frame
			end

			p1:Delete()
		end

		if not (v29 < v2.Index) or v2.Tool then
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
	v12.SelectionImageObject.Visible = false
end
function vrMoveSlotToInventory() --[[ vrMoveSlotToInventory | Line: 2815 | Upvalues: VRService (copy), v12 (ref) ]]
	if not VRService.VREnabled then
		return
	end

	local v1 = getGamepadSwapSlot()

	if not (v1 and v1.Tool) then
		return
	end

	v1:WaitForChild("UIStroke").Thickness = 0
	v1:MoveToInventory()
	v12.SelectionImageObject.Visible = false
end
function enableGamepadInventoryControl() --[[ enableGamepadInventoryControl | Line: 2828 | Upvalues: v11 (ref), v17 (copy), ContextActionService (copy), f57 (copy), UserInputService (copy), GuiService (copy), v10 (ref) ]]
	local function f1(p1, p2, p3) --[[ Line: 2829 | Upvalues: v11 (ref), v17 (ref) ]]
		if p2 ~= Enum.UserInputState.Begin then
			return
		end

		if getGamepadSwapSlot() then
			local v1 = getGamepadSwapSlot()

			if v1 then
				v1:WaitForChild("UIStroke").Thickness = 0
			end
		else
			if not v11.Visible then
				return
			end

			v17:deselect()
		end
	end

	ContextActionService:BindAction("RBXBackpackHasGamepadFocus", f57, false, Enum.UserInputType.Gamepad1)
	ContextActionService:BindAction("RBXCloseInventory", f1, false, Enum.KeyCode.ButtonB, Enum.KeyCode.ButtonStart)

	if UserInputService.VREnabled then
		return
	end

	GuiService.SelectedObject = v10:FindFirstChild("1")
end
function disableGamepadInventoryControl() --[[ disableGamepadInventoryControl | Line: 2853 | Upvalues: v29 (ref), t3 (ref), GuiService (copy), v9 (ref) ]]
	unbindAllGamepadEquipActions()

	for i = 1, v29 do
		local v1 = t3[i]

		if v1 and v1.Frame then
			v1.Frame:WaitForChild("UIStroke").Thickness = 0
		end
	end

	if not (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(v9)) then
		return
	end

	GuiService.SelectedObject = nil
end

local function bindBackpackHotbarAction() --[[ bindBackpackHotbarAction | Line: 2869 | Upvalues: v24 (ref), v6 (ref), ContextActionService (copy) ]]
	if not v24 then
		return
	end

	if not v6 or ContextActionService:GetAllBoundActionInfo().RBXHotbarEquip == nil then
		v6 = true
		ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end
end

local function unbindBackpackHotbarAction() --[[ unbindBackpackHotbarAction | Line: 2884 | Upvalues: v6 (ref), ContextActionService (copy) ]]
	disableGamepadInventoryControl()
	v6 = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end

function gamepadDisconnected() --[[ gamepadDisconnected | Line: 2890 | Upvalues: v27 (ref) ]]
	v27 = false
	disableGamepadInventoryControl()
end
function gamepadConnected() --[[ gamepadConnected | Line: 2895 | Upvalues: v27 (ref), GuiService (copy), v9 (ref), v22 (ref), v24 (ref), v6 (ref), ContextActionService (copy), v11 (ref) ]]
	v27 = true
	GuiService:AddSelectionParent("RBXBackpackSelection", v9)

	if v22 >= 1 and (v24 and (not v6 or ContextActionService:GetAllBoundActionInfo().RBXHotbarEquip == nil)) then
		v6 = true
		ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
	end

	if not v11.Visible then
		return
	end

	enableGamepadInventoryControl()
end

local function OnIconChanged(p1) --[[ OnIconChanged | Line: 2908 | Upvalues: v4 (ref), StarterGui (copy), v17 (copy), GuiService (copy), v24 (ref), v9 (ref), t7 (copy), v29 (ref), t3 (ref), v6 (ref), ContextActionService (copy) ]]
	if v4 then
		p1 = false
	end

	local v1 = if p1 then StarterGui:GetCore("TopbarEnabled") else p1

	v17:setEnabled(if v1 then not GuiService.MenuIsOpen else v1)
	v24 = v1
	v9.Visible = v1

	for k, v in pairs(t7) do

	end

	if v1 then
		local v5 = false

		for i = 1, v29 do
			local v62 = t3[i]

			if v62 and v62.Tool then
				v5 = true

				break
			end
		end

		if not v5 then
			return
		end

		if not v1 then
			return
		end

		if not v6 or ContextActionService:GetAllBoundActionInfo().RBXHotbarEquip == nil then
			v6 = true
			ContextActionService:BindAction("RBXHotbarEquip", changeToolFunc, false, Enum.KeyCode.ButtonL1, Enum.KeyCode.ButtonR1)
		end

		return
	end

	disableGamepadInventoryControl()
	v6 = false
	ContextActionService:UnbindAction("RBXHotbarEquip")
end

local function MakeVRRoundButton(p1, p2) --[[ MakeVRRoundButton | Line: 2947 | Upvalues: NewGui (copy) ]]
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

v9 = NewGui("Frame", "Backpack")
v9.Visible = false
v9.Parent = BackpackGui
v10 = NewGui("Frame", "Hotbar")
v10.Parent = v9

for i = 1, v29 do
	local v59 = v34(v10, i)

	v59.Frame.Visible = false

	if not v21 then
		v21 = v59
	end
end

v17.selected:Connect(function() --[[ Line: 2987 | Upvalues: GuiService (copy), t (copy) ]]
	if GuiService.MenuIsOpen then
		return
	end

	t.OpenClose()
end)
v17.deselected:Connect(function() --[[ Line: 2992 | Upvalues: v11 (ref), t (copy) ]]
	if not v11.Visible then
		return
	end

	t.OpenClose()
end)
LeftBumperButton = NewGui("ImageLabel", "LeftBumper")
LeftBumperButton.Size = UDim2.new(0, 40, 0, 40)
LeftBumperButton.Position = UDim2.new(0, -LeftBumperButton.Size.X.Offset, 0.5, -LeftBumperButton.Size.Y.Offset / 2)
RightBumperButton = NewGui("ImageLabel", "RightBumper")
RightBumperButton.Size = UDim2.new(0, 40, 0, 40)
RightBumperButton.Position = UDim2.new(1, 0, 0.5, -RightBumperButton.Size.Y.Offset / 2)
v11 = NewGui("Frame", "Inventory")

local UICorner = Instance.new("UICorner")

UICorner.CornerRadius = script:GetAttribute("CornerRadius")
UICorner.Parent = v11
v11.BackgroundTransparency = BACKGROUND_FADE
v11.BackgroundColor3 = BACKGROUND_COLOR
v11.Active = true
v11.Visible = false
v11.Parent = v9
v12 = NewGui("TextButton", "VRInventorySelector")
v12.Position = UDim2.new(0, 0, 0, 0)
v12.Size = UDim2.new(1, 0, 1, 0)
v12.BackgroundTransparency = 1
v12.Text = ""
v12.Parent = v11

local v60 = NewGui("ImageLabel", "Selector")

v60.Size = UDim2.new(1, 0, 1, 0)
v60.Image = "rbxasset://textures/ui/Keyboard/key_selection_9slice.png"
v60.ScaleType = Enum.ScaleType.Slice
v60.SliceCenter = Rect.new(12, 12, 52, 52)
v60.Visible = false
v12.SelectionImageObject = v60
v12.MouseButton1Click:Connect(function() --[[ Line: 3032 ]]
	vrMoveSlotToInventory()
end)
v13 = NewGui("ScrollingFrame", "ScrollingFrame")
v13.Selectable = false
v13.CanvasSize = UDim2.new(0, 0, 0, 0)
v13.Parent = v11
v14 = NewGui("Frame", "UIGridFrame")
v14.Selectable = false
v14.Size = UDim2.new(1, -(ICON_BUFFER * 2), 1, 0)
v14.Position = UDim2.new(0, ICON_BUFFER, 0, 0)
v14.Parent = v13
v15 = Instance.new("UIGridLayout")
v15.SortOrder = Enum.SortOrder.LayoutOrder
v15.CellSize = UDim2.new(0, ICON_SIZE, 0, ICON_SIZE)
v15.CellPadding = UDim2.new(0, ICON_BUFFER, 0, ICON_BUFFER)
v15.Parent = v14

local v61 = SideBar:Clone()

v61.Parent = v11

local v62 = script.FruitInventory:Clone()

v62.Parent = v11

local v63 = v62

local function update() --[[ update | Line: 3067 | Upvalues: LocalPlayer (ref), v62 (copy) ]]
	v62.Text = ("%*/%* Fruits"):format(LocalPlayer:GetAttribute("FruitCount") or 0, LocalPlayer:GetAttribute("MaxFruitCapacity") or 100)
end

update()
LocalPlayer:GetAttributeChangedSignal("FruitCount"):Connect(update)
LocalPlayer:GetAttributeChangedSignal("MaxFruitCapacity"):Connect(update)

local function f64(p1) --[[ Line: 3078 | Upvalues: v32 (ref), v61 (copy), v63 (ref), v36 (ref), v13 (ref) ]]
	v32 = p1
	v61.Gears.SelectedStroke.Enabled = p1 == "Gears"
	v61.Seeds.SelectedStroke.Enabled = p1 == "Seeds"
	v61.Fruits.SelectedStroke.Enabled = p1 == "Fruits"
	v61.All.SelectedStroke.Enabled = p1 == "All"

	local Pets = v61:FindFirstChild("Pets")

	if Pets then
		local SelectedStroke5 = Pets:FindFirstChild("SelectedStroke")

		if SelectedStroke5 then
			SelectedStroke5.Enabled = p1 == "Pets"
		end
	end

	if v63 then
		v63.Visible = if p1 == "All" then true else p1 == "Fruits"
	end

	v36()
	v13.CanvasPosition = Vector2.new(0, 0)
end

v61.Gears.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3104 | Upvalues: f64 (ref) ]]
	f64("Gears")
end)
v61.Seeds.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3105 | Upvalues: f64 (ref) ]]
	f64("Seeds")
end)
v61.Fruits.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3106 | Upvalues: f64 (ref) ]]
	f64("Fruits")
end)
v61.All.ImageButton.MouseButton1Click:Connect(function() --[[ Line: 3107 | Upvalues: f64 (ref) ]]
	f64("All")
end)

local Pets = v61:FindFirstChild("Pets")
local v65 = Pets and Pets:FindFirstChild("ImageButton")

if v65 and v65:IsA("GuiButton") then
	v65.MouseButton1Click:Connect(function() --[[ Line: 3114 | Upvalues: f64 (ref) ]]
		f64("Pets")
	end)
end

f64("All")

local v66 = MakeVRRoundButton("ScrollUpButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v66.Size = UDim2.new(0, 34, 0, 34)
v66.Position = UDim2.new(0.5, -v66.Size.X.Offset / 2, 0, INVENTORY_HEADER_SIZE + 3)
v66.Icon.Position = v66.Icon.Position - UDim2.new(0, 0, 0, 2)
v66.MouseButton1Click:Connect(function() --[[ Line: 3125 | Upvalues: v13 (ref) ]]
	v13.CanvasPosition = Vector2.new(v13.CanvasPosition.X, (math.min(v13.CanvasSize.Y.Offset - v13.AbsoluteWindowSize.Y, (math.max(0, v13.CanvasPosition.Y - (ICON_BUFFER + ICON_SIZE))))))
end)

local v67 = MakeVRRoundButton("ScrollDownButton", "rbxasset://textures/ui/Backpack/ScrollUpArrow.png")

v67.Rotation = 180
v67.Icon.Position = v67.Icon.Position - UDim2.new(0, 0, 0, 2)
v67.Size = UDim2.new(0, 34, 0, 34)
v67.Position = UDim2.new(0.5, -v67.Size.X.Offset / 2, 1, -v67.Size.Y.Offset - 3)
v67.MouseButton1Click:Connect(function() --[[ Line: 3136 | Upvalues: v13 (ref) ]]
	v13.CanvasPosition = Vector2.new(v13.CanvasPosition.X, (math.min(v13.CanvasSize.Y.Offset - v13.AbsoluteWindowSize.Y, (math.max(0, v13.CanvasPosition.Y + (ICON_BUFFER + ICON_SIZE))))))
end)
v13.Changed:Connect(function(p1) --[[ Line: 3142 | Upvalues: v13 (ref), v66 (ref), v67 (ref) ]]
	if p1 ~= "AbsoluteWindowSize" and (p1 ~= "CanvasPosition" and p1 ~= "CanvasSize") then
		return
	end

	local v1 = if v13.CanvasPosition.Y < v13.CanvasSize.Y.Offset - v13.AbsoluteWindowSize.Y then true else false

	v66.Visible = v13.CanvasPosition.Y ~= 0
	v67.Visible = v1
end)
UpdateBackpackLayout()

local v68 = Utility:Create("Frame")
local t10 = {
	Name = "GamepadHintsFrame",
	BackgroundTransparency = 1,
	Visible = false
}
local v69 = UDim2.new
local Offset = v10.Size.X.Offset

t10.Size = v69(0, Offset, 0, if v5 then 95 else 60)
t10.Parent = v9

local v73 = v68(t10)
local t11 = {}

local function addGamepadHint(p1, p2) --[[ addGamepadHint | Line: 3165 | Upvalues: Utility (copy), v73 (copy), v5 (copy), UserInputService (copy), t11 (copy) ]]
	local v1 = Utility:Create("Frame")({
		Name = "HintFrame",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 1, -5),
		Position = UDim2.new(0, 0, 0, 0),
		Parent = v73
	})
	local v2 = Utility:Create("ImageLabel")
	local t = {
		Name = "HintImage",
		BackgroundTransparency = 1
	}

	t.Size = v5 and UDim2.new(0, 90, 0, 90) or UDim2.new(0, 60, 0, 60)
	t.Image = UserInputService:GetImageForKeyCode(p1)
	t.Parent = v1
	t11[v2(t)] = p1

	local v4 = Utility:Create("TextLabel")
	local t2 = {
		Name = "HintText",
		BackgroundTransparency = 1,
		TextWrapped = true
	}

	t2.Position = UDim2.new(0, if v5 then 100 else 70, 0, 0)
	t2.Size = UDim2.new(1, -(if v5 then 100 else 70), 1, 0)
	t2.Font = Enum.Font.SourceSansBold
	t2.FontSize = v5 and Enum.FontSize.Size36 or Enum.FontSize.Size24
	t2.Text = p2
	t2.TextColor3 = Color3.new(255/255, 255/255, 255/255)
	t2.TextXAlignment = Enum.TextXAlignment.Left
	t2.Parent = v1

	local v12 = v4(t2)

	Instance.new("UITextSizeConstraint", v12).MaxTextSize = v12.TextSize
end

local function updateGamepadHintImages() --[[ updateGamepadHintImages | Line: 3204 | Upvalues: t11 (copy), UserInputService (copy) ]]
	for v1, v2 in t11 do
		v1.Image = UserInputService:GetImageForKeyCode(v2)
	end
end

local function resizeGamepadHintsFrame() --[[ resizeGamepadHintsFrame | Line: 3210 | Upvalues: v73 (copy), v10 (ref), v5 (copy), v11 (ref) ]]
	v73.Size = UDim2.new(v10.Size.X.Scale, v10.Size.X.Offset, 0, if v5 then 95 else 60)
	v73.Position = UDim2.new(v10.Position.X.Scale, v10.Position.X.Offset, v11.Position.Y.Scale, v11.Position.Y.Offset - v73.Size.Y.Offset)

	local v52 = v73:GetChildren()
	local sum = 0

	for i = 1, #v52 do
		v52[i].Size = UDim2.new(1, 0, 1, -5)
		v52[i].Position = UDim2.new(0, 0, 0, 0)
		sum = sum + (v52[i].HintText.Position.X.Offset + v52[i].HintText.TextBounds.X)
	end

	local v6 = (v73.AbsoluteSize.X - sum) / (#v52 - 1)

	for j = 1, #v52 do
		v52[j].Position = j == 1 and UDim2.new(0, 0, 0, 0) or UDim2.new(0, v52[j - 1].Position.X.Offset + v52[j - 1].Size.X.Offset + v6, 0, 0)
		v52[j].Size = UDim2.new(0, v52[j].HintText.Position.X.Offset + v52[j].HintText.TextBounds.X, 1, -5)
	end
end

addGamepadHint(Enum.KeyCode.ButtonX, "Remove From Hotbar")
addGamepadHint(Enum.KeyCode.ButtonA, "Select/Swap")
addGamepadHint(Enum.KeyCode.ButtonB, "Close Backpack")

local v74 = NewGui("Frame", "Search")
local UICorner2 = Instance.new("UICorner")

UICorner2.CornerRadius = script:GetAttribute("CornerRadius")
UICorner2.Parent = v74
v74.BackgroundColor3 = v1
v74.BackgroundTransparency = v2
v74.Size = UDim2.new(0, 190, 0, INVENTORY_HEADER_SIZE - 10)
v74.Position = UDim2.new(1, -v74.Size.X.Offset - 5, 0, 5)
v74.Parent = v11

local v75 = NewGui("TextBox", "TextBox")

v75.PlaceholderText = "Search"
v75.ClearTextOnFocus = false
v75.FontSize = Enum.FontSize.Size24
v75.TextXAlignment = Enum.TextXAlignment.Left

local UIPadding = Instance.new("UIPadding")

UIPadding.Parent = v75
UIPadding.PaddingLeft = UDim.new(0, 8)
v75.Size = v74.Size - UDim2.fromOffset(0, 0)
v75.Position = UDim2.new(0, 0, 0, 0)
v75.Parent = v74

local v76 = NewGui("TextButton", "X")
local UICorner3 = Instance.new("UICorner")

UICorner3.CornerRadius = script:GetAttribute("CornerRadius")
UICorner3.Parent = v76
v76.Text = "X"
v76.ZIndex = 10
v76.TextColor3 = Color3.new(255/255, 255/255, 255/255)
v76.FontSize = Enum.FontSize.Size24
v76.TextYAlignment = Enum.TextYAlignment.Bottom
v76.BackgroundTransparency = 1
v76.Size = UDim2.new(0, v74.Size.Y.Offset - 10, 0, v74.Size.Y.Offset - 10)
v76.Position = UDim2.new(1, -v76.Size.X.Offset - 10, 0.5, -v76.Size.Y.Offset / 2)
v76.Visible = false
v76.BorderSizePixel = 0
v76.Parent = v74

local function search() --[[ search | Line: 3273 | Upvalues: v75 (copy), v29 (ref), t3 (ref), v11 (ref), v26 (ref), v14 (ref), v41 (ref), v13 (ref), UpdateScrollingFrameCanvasSize (ref), v76 (copy) ]]
	local t = {}

	for v1 in v75.Text:gmatch("%S+") do
		t[v1:lower()] = true
	end

	local list = {}

	for i = v29 + 1, #t3 do
		local v2 = t3[i]

		table.insert(list, { v2, (v2:CheckTerms(t)) })
		v2.Frame.Visible = false
		v2.Frame.Parent = v11
	end

	table.sort(list, function(p1, p2) --[[ Line: 3288 ]]
		return p1[2] > p2[2]
	end)
	v26 = true

	local count = 0

	for i, v in ipairs(list) do
		local v3 = v[1]

		if v[2] > 0 then
			v3.Frame.Visible = true
			v3.Frame.Parent = v14
			v3.Frame.LayoutOrder = v29 + count
			count = count + 1
		end
	end

	v41 = count
	v13.CanvasPosition = Vector2.new(0, 0)
	UpdateScrollingFrameCanvasSize()
	v76.ZIndex = 3
end

t._ApplySearch = search

local function clearResults() --[[ clearResults | Line: 3314 | Upvalues: v76 (copy), v26 (ref), v29 (ref), t3 (ref), v14 (ref), v41 (ref), UpdateScrollingFrameCanvasSize (ref) ]]
	if not (v76.ZIndex > 0) then
		UpdateScrollingFrameCanvasSize()

		return
	end

	v26 = false

	local count = 0

	for i = v29 + 1, #t3 do
		local v1 = t3[i]

		v1.Frame.LayoutOrder = v1.Index
		v1.Frame.Parent = v14
		v1.Frame.Visible = true
		count = count + 1
	end

	v41 = count
	v76.ZIndex = 0
	UpdateScrollingFrameCanvasSize()
end

local function reset() --[[ reset | Line: 3331 | Upvalues: clearResults (copy), v75 (copy) ]]
	clearResults()
	v75.Text = ""
end

local function onChanged(p1) --[[ onChanged | Line: 3336 | Upvalues: v75 (copy), clearResults (copy), search (copy), v76 (copy) ]]
	if p1 ~= "Text" then
		return
	end

	local Text = v75.Text

	if Text == "" then
		clearResults()
	elseif Text ~= "Search" then
		search()
	end

	v76.Visible = if Text == "" then false else Text ~= "Search"
end

local function focusLost(p1) --[[ focusLost | Line: 3348 | Upvalues: search (copy) ]]
	if not p1 then
		return
	end

	search()
end

v76.MouseButton1Click:Connect(reset)
v75.Changed:Connect(onChanged)
v75.FocusLost:Connect(focusLost)
t.StateChanged.Event:Connect(function(p1) --[[ Line: 3358 | Upvalues: clearResults (copy), v75 (copy), v11 (ref), v17 (copy) ]]
	if p1 then
		return
	end

	clearResults()
	v75.Text = ""

	if v11.Visible then
		return
	end

	v17:deselect()
end)
t5[Enum.KeyCode.Escape.Value] = function(p1) --[[ Line: 3367 | Upvalues: clearResults (copy), v75 (copy), v11 (ref), v17 (copy) ]]
	if p1 then
		clearResults()
		v75.Text = ""

		return
	end

	if not v11.Visible then
		return
	end

	v17:deselect()
end

local function detectGamepad(p1) --[[ detectGamepad | Line: 3375 | Upvalues: UserInputService (copy), v74 (copy) ]]
	if p1 == Enum.UserInputType.Gamepad1 and not UserInputService.VREnabled then
		v74.Visible = false
	else
		v74.Visible = true
	end
end

UserInputService.LastInputTypeChanged:Connect(detectGamepad)
GuiService.MenuOpened:Connect(function() --[[ Line: 3385 | Upvalues: v11 (ref), v17 (copy) ]]
	if not v11.Visible then
		return
	end

	v17:deselect()
end)

local v77 = false

local function f78(p1, p2, p3) --[[ Line: 3398 | Upvalues: GuiService (copy), v29 (ref), t3 (ref) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	if not GuiService.SelectedObject then
		return
	end

	for i = 1, v29 do
		if t3[i].Frame == GuiService.SelectedObject and t3[i].Tool then
			t3[i]:MoveToInventory()

			return
		end
	end
end

local function f79(p1, p2) --[[ Line: 3410 | Upvalues: GuiService (copy), t3 (ref), ToggleFavorite (copy) ]]
	if p2 ~= Enum.UserInputState.Begin then
		return
	end

	local SelectedObject = GuiService.SelectedObject

	if not SelectedObject then
		return
	end

	for v1, v2 in t3 do
		if v2.Frame == SelectedObject and v2.Tool then
			ToggleFavorite(v2)

			return
		end
	end
end

local function openClose() --[[ openClose | Line: 3422 | Upvalues: t6 (copy), v11 (ref), f64 (ref), v35 (ref), v10 (ref), v29 (ref), t3 (ref), v27 (ref), t2 (copy), UserInputService (copy), t11 (copy), resizeGamepadHintsFrame (copy), v73 (copy), ContextActionService (copy), f78 (copy), f79 (copy), ProximityPromptService (copy), v77 (ref), t (copy) ]]
	if not next(t6) then
		v11.Visible = not v11.Visible

		local Visible = v11.Visible

		if Visible then
			f64("All")
		end

		v35()
		v10.Active = not v10.Active

		for i = 1, v29 do
			t3[i]:SetClickability(not Visible)
		end
	end

	if v11.Visible then
		if v27 then
			if t2[UserInputService:GetLastInputType()] then
				for v1, v2 in t11 do
					v1.Image = UserInputService:GetImageForKeyCode(v2)
				end

				resizeGamepadHintsFrame()
				v73.Visible = not UserInputService.VREnabled
			end

			enableGamepadInventoryControl()
		end
	else
		if v27 then
			v73.Visible = false
		end

		disableGamepadInventoryControl()
	end

	if v11.Visible then
		ContextActionService:BindAction("RBXRemoveSlot", f78, false, Enum.KeyCode.ButtonX)
		ContextActionService:BindAction("RBXFavoriteFruit", f79, false, Enum.KeyCode.ButtonY)

		if v27 and (t2[UserInputService:GetLastInputType()] and ProximityPromptService.Enabled) then
			ProximityPromptService.Enabled = false
			v77 = true
		end
	else
		ContextActionService:UnbindAction("RBXRemoveSlot")
		ContextActionService:UnbindAction("RBXFavoriteFruit")

		if v77 then
			v77 = false
			ProximityPromptService.Enabled = true
		end
	end

	t.IsOpen = v11.Visible
	t.StateChanged:Fire(v11.Visible)
end

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
t.OpenClose = openClose

while not LocalPlayer do
	wait()
	LocalPlayer = Players.LocalPlayer
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)

if LocalPlayer.Character then
	OnCharacterAdded(LocalPlayer.Character)
end

UserInputService.InputBegan:Connect(OnInputBegan)
UserInputService.TextBoxFocused:Connect(function() --[[ Line: 3497 | Upvalues: v25 (ref) ]]
	v25 = true
end)
UserInputService.TextBoxFocusReleased:Connect(function() --[[ Line: 3498 | Upvalues: v25 (ref) ]]
	v25 = false
end)
UserInputService.Changed:Connect(OnUISChanged)
OnUISChanged("KeyboardEnabled")

if UserInputService:GetGamepadConnected(Enum.UserInputType.Gamepad1) then
	gamepadConnected()
end

UserInputService.GamepadConnected:Connect(function(p1) --[[ Line: 3511 ]]
	if p1 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadConnected()
end)
UserInputService.GamepadDisconnected:Connect(function(p1) --[[ Line: 3516 ]]
	if p1 ~= Enum.UserInputType.Gamepad1 then
		return
	end

	gamepadDisconnected()
end)
function t.SetBackpackEnabled(p1, p2) --[[ SetBackpackEnabled | Line: 3523 | Upvalues: v3 (ref) ]]
	v3 = p2
end
function t.IsOpened(p1) --[[ IsOpened | Line: 3527 | Upvalues: t (copy) ]]
	return t.IsOpen
end
function t.GetBackpackEnabled(p1) --[[ GetBackpackEnabled | Line: 3531 | Upvalues: v3 (ref) ]]
	return v3
end
function t.GetStateChangedEvent(p1) --[[ GetStateChangedEvent | Line: 3535 | Upvalues: Backpack (ref) ]]
	return Backpack.StateChanged
end
RunService.Heartbeat:Connect(function() --[[ Line: 3539 | Upvalues: OnIconChanged (copy), v3 (ref) ]]
	OnIconChanged(v3)
end)
LocalPlayer:GetAttributeChangedSignal("LoadingScreenActive"):Connect(function() --[[ Line: 3547 | Upvalues: LocalPlayer (ref), v6 (ref), ContextActionService (copy), OnIconChanged (copy), v3 (ref) ]]
	if not LocalPlayer:GetAttribute("LoadingScreenActive") then
		disableGamepadInventoryControl()
		v6 = false
		ContextActionService:UnbindAction("RBXHotbarEquip")
		OnIconChanged(v3)
	end
end)
Api.Event:Connect(function(p1, p2) --[[ Line: 3555 | Upvalues: t (copy) ]]
	if p1 == "SetBackpackEnabled" then
		t:SetBackpackEnabled(p2)

		return
	end

	if p1 == "SetInventoryOpen" then
		if type(p2) == "boolean" and p2 == true then
			t.IsOpen = true

			return
		end

		if type(p2) == "boolean" then
			t.IsOpen = false
		end
	else
		if p1 ~= "ToggleBackpack" then
			return
		end

		t.OpenClose()
	end
end)
v7 = (function() --[[ UpdateIsPhone | Line: 3569 | Upvalues: UserInputService (copy) ]]
	return if game.Workspace.Camera.ViewportSize.X < 1000 then true else UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end)()

local v80 = VREnabled and HOTBAR_SLOTS_VR or (v7 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL)

v30 = VREnabled and INVENTORY_ROWS_VR or (v7 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL)

if v80 == v29 then
	v29 = v80
else
	v40 = true

	local list = {}

	for j = 1, #t3 do
		local v82 = t3[j]

		if v82 and v82.Tool then
			table.insert(list, v82.Tool)
			v82:Clear()
		end
	end

	for k = #t3, 1, -1 do
		t3[k].Frame:Destroy()
	end

	t3 = {}
	t4 = {}
	v22 = 0
	v21 = nil
	v29 = v80

	for n = 1, v80 do
		local v83 = v34(v10, n)

		v83.Frame.Visible = false

		if not v21 then
			v21 = v83
		end
	end

	for i, v in ipairs(list) do
		v21 = v33();
		(v21 or v34(v14)):Fill(v)
	end

	v21 = v33()

	for m = 1, v80 do
		if m < 10 then
			t5[Zero + m] = t3[m].Select

			continue
		end

		if m == v80 then
			t5[Zero] = t3[m].Select
		end
	end

	v40 = false
end

OnUISChanged("KeyboardEnabled")
UpdateBackpackLayout()
game.Workspace.Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 3632 | Upvalues: v7 (ref), UserInputService (copy), VREnabled (copy), v30 (ref), v29 (ref), UpdateBackpackLayout (copy), v40 (ref), t3 (ref), t4 (ref), v22 (ref), v21 (ref), v34 (ref), v10 (ref), v37 (ref), v33 (ref), v14 (ref), t5 (ref), Zero (copy), v39 (ref), Networking (copy) ]]
	local v1 = v7

	v7 = if game.Workspace.Camera.ViewportSize.X < 1000 then true else UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

	if v1 == v7 then
		return
	end

	local v3 = VREnabled and HOTBAR_SLOTS_VR or (v7 and HOTBAR_SLOTS_MINI or HOTBAR_SLOTS_FULL)

	v30 = VREnabled and INVENTORY_ROWS_VR or (v7 and INVENTORY_ROWS_MINI or INVENTORY_ROWS_FULL)

	if v3 == v29 then
		UpdateBackpackLayout()

		return
	end

	v40 = true

	local list = {}

	for i = 1, #t3 do
		local v5 = t3[i]

		if v5 and v5.Tool then
			table.insert(list, v5.Tool)
			v5:Clear()
		end
	end

	for j = #t3, 1, -1 do
		t3[j].Frame:Destroy()
	end

	t3 = {}
	t4 = {}
	v22 = 0
	v21 = nil
	v29 = v3

	for k = 1, v29 do
		local v6 = v34(v10, k)

		v6.Frame.Visible = false

		if not v21 then
			v21 = v6
		end
	end

	if v37 then
		local t = {}

		for k, v in pairs(v37) do
			local v72 = tonumber(k)

			if v72 and (v72 >= 1 and v72 <= v29) then
				for i, v5 in ipairs(list) do
					if not t[v5] and GetToolKey(v5) == v then
						t3[v72]:Fill(v5)
						t[v5] = true

						break
					end
				end
			end
		end

		for i, v in ipairs(list) do
			if not t[v] then
				v21 = v33();
				(v21 or v34(v14)):Fill(v)
				t[v] = true
			end
		end
	else
		for i, v in ipairs(list) do
			v21 = v33();
			(v21 or v34(v14)):Fill(v)
		end
	end

	v21 = v33()
	UpdateBackpackLayout()
	t5 = {}
	t5[Enum.KeyCode.Escape.Value] = t5[Enum.KeyCode.Escape.Value]

	for n = 1, v29 do
		if n < 10 then
			t5[Zero + n] = t3[n].Select

			continue
		end

		if n == v29 then
			t5[Zero] = t3[n].Select
		end
	end

	local v102 = UserInputService.KeyboardEnabled and not UserInputService.VREnabled

	for m = 1, v29 do
		t3[m]:TurnNumber(v102)
	end

	v40 = false

	if v40 then
		return
	end

	if v39 then
		return
	end

	v39 = true
	task.delay(1, function() --[[ Line: 353 | Upvalues: v40 (ref), v39 (ref), v29 (ref), t3 (ref), Networking (ref) ]]
		if not v40 then
			local t2 = {}
			local count2 = 0

			for i = 1, v29 do
				local v1 = t3[i]

				if v1 and v1.Tool then
					local v2 = GetToolKey(v1.Tool)

					if v2 then
						t2[i] = v2
						count2 = count2 + 1
					end
				end
			end

			if count2 ~= 0 then
				Networking.Backpack.SaveLayout:Fire(t2)
			end
		end

		v39 = false
	end)
end)

return t