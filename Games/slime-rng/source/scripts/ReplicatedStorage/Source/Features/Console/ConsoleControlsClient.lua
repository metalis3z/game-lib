-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- [[ Script name: ConsoleControlsClient, time of decompilation: Sun May  3 10:12:22 2026 ]]
local ContextActionService = game:GetService("ContextActionService")
local GamepadService = game:GetService("GamepadService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local client = require(ReplicatedStorage.Packages.DataService).client
local Vide = require(ReplicatedStorage.Packages.Vide)
local preferredInputSource = require(ReplicatedStorage.Source.Core.UI.Sources.preferredInputSource)
local Menu = require(ReplicatedStorage.Source.Features.App.Components.Menu)
local SubMenu = require(ReplicatedStorage.Source.Features.App.Components.SubMenu)
local InventoryMenu = require(ReplicatedStorage.Source.Features.Inventory.UI.InventoryMenu)
local screenCoveredSource = require(ReplicatedStorage.Source.Features.App.Sources.screenCoveredSource)
local RollServiceClient = require(ReplicatedStorage.Source.Features.Roll.RollServiceClient)
local RollSlice = require(ReplicatedStorage.Source.Features.Roll.RollSlice)
local TutorialServiceClient = require(ReplicatedStorage.Source.Features.Tutorial.TutorialServiceClient)
local UpgradeServiceUtils = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeServiceUtils)
local UpgradeSlice = require(ReplicatedStorage.Source.Features.Upgrades.UpgradeSlice)
local t1 = {}
local u19 = false

function t1._bindAction(_: {[any]: any}, s1: string, p1, p2: ((...any) -> ...any)) -- line: 76
	-- upvalues: ContextActionService (copy), preferredInputSource (copy), UserInputService (copy)
	ContextActionService:BindAction(s1, function(_, p4) -- line: 77
		-- upvalues: preferredInputSource (copy), UserInputService (copy), p2 (copy)
		if p4 ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end

		if preferredInputSource() ~= Enum.PreferredInput.Gamepad or UserInputService:GetFocusedTextBox() ~= nil then
			return Enum.ContextActionResult.Pass
		end

		if p2() then
			return Enum.ContextActionResult.Sink
		end

		return Enum.ContextActionResult.Pass
	end, false, p1)
end
function t1.init(p5) -- line: 94
	-- upvalues: RollSlice (copy), UpgradeServiceUtils (copy), client (copy), RollServiceClient (copy), UpgradeSlice (copy), Menu (copy), SubMenu (copy), screenCoveredSource (copy), Vide (copy), TutorialServiceClient (copy), InventoryMenu (copy), RunService (copy), preferredInputSource (copy), u19 (ref), GamepadService (copy)
	if p5.initialized then
		return
	end

	p5.initialized = true
	p5:_bindAction("ConsoleRoll", Enum.KeyCode.ButtonX, function() -- line: 100
		-- upvalues: RollSlice (copy), UpgradeServiceUtils (copy), client (copy), RollServiceClient (copy), UpgradeSlice (copy), Menu (copy), SubMenu (copy), screenCoveredSource (copy)
		if RollSlice.rollScreenShown() and (UpgradeServiceUtils.ownsUpgrade("autoRoll", client:get("upgrades") or {}) and not RollSlice.hiddenRoll()) then
			RollServiceClient:setAutoRollEnabled(not RollSlice.autoRoll())

			return true
		end

		if UpgradeSlice.shown() or (Menu.openedMenu() ~= nil or SubMenu.openedMenu() ~= nil) or screenCoveredSource() then
			return false
		end

		return RollServiceClient:activateRollButton()
	end)
	p5:_bindAction("ConsoleInventory", Enum.KeyCode.ButtonY, function() -- line: 113
		-- upvalues: RollSlice (copy), UpgradeServiceUtils (copy), client (copy), Vide (copy), RollServiceClient (copy), UpgradeSlice (copy), Menu (copy), SubMenu (copy), screenCoveredSource (copy), TutorialServiceClient (copy), InventoryMenu (copy)
		if RollSlice.rollScreenShown() and (UpgradeServiceUtils.ownsUpgrade("autoRoll", client:get("upgrades") or {}) and not RollSlice.hiddenRoll()) and RollSlice.autoRoll() then
			Vide.batch(function() -- line: 115
				-- upvalues: RollServiceClient (copy), RollSlice (copy)
				RollServiceClient:setHiddenRollEnabled(true)
				RollSlice.rollScreenShown(false)
			end)

			return true
		end

		if UpgradeSlice.shown() or (Menu.openedMenu() ~= nil or SubMenu.openedMenu() ~= nil) or screenCoveredSource() or (not TutorialServiceClient:shouldShowBackpackButton() or (not UpgradeServiceUtils.ownsUpgrade("backpack", client:get("upgrades") or {}) or not TutorialServiceClient:canOpenMenu("Inventory"))) then
			return false
		end

		InventoryMenu.openSlimesPage()

		return Menu.openedMenu() == "Inventory"
	end)
	p5:_bindAction("ConsoleUpgrades", Enum.KeyCode.DPadUp, function() -- line: 130
		-- upvalues: UpgradeSlice (copy), Menu (copy), SubMenu (copy), screenCoveredSource (copy), TutorialServiceClient (copy)
		if UpgradeSlice.shown() or (Menu.openedMenu() ~= nil or SubMenu.openedMenu() ~= nil) or (screenCoveredSource() or (not TutorialServiceClient:shouldShowUpgradeButton() or not TutorialServiceClient:canOpenUpgradeScreen())) then
			return false
		end

		UpgradeSlice.shown(true)

		return UpgradeSlice.shown()
	end)
	p5:_bindAction("ConsoleClose", Enum.KeyCode.ButtonB, function() -- line: 139
		-- upvalues: UpgradeSlice (copy), SubMenu (copy), Menu (copy)
		if UpgradeSlice.shown() then
			UpgradeSlice.shown(false)

			return true
		end

		if SubMenu.openedMenu() ~= nil then
			SubMenu.closeCurrentMenu()

			return true
		end

		if Menu.openedMenu() ~= nil then
			Menu.closeCurrentMenu()

			return true
		end

		return false
	end)
	p5.cursorConn = RunService.Heartbeat:Connect(function() -- line: 158
		-- upvalues: preferredInputSource (copy), UpgradeSlice (copy), Menu (copy), SubMenu (copy), u19 (ref), GamepadService (copy)
		local v30 = preferredInputSource() == Enum.PreferredInput.Gamepad and (UpgradeSlice.shown() or (Menu.openedMenu() ~= nil or SubMenu.openedMenu() ~= nil))

		if v30 == u19 then
			return
		end

		u19 = v30

		if v30 then
			GamepadService:EnableGamepadCursor(nil)

			return
		end

		GamepadService:DisableGamepadCursor()
	end)

	local v27 = preferredInputSource() == Enum.PreferredInput.Gamepad and (UpgradeSlice.shown() or (Menu.openedMenu() ~= nil or SubMenu.openedMenu() ~= nil))

	if v27 == u19 then
		return
	end

	u19 = v27

	if v27 then
		GamepadService:EnableGamepadCursor(nil)

		return
	end

	GamepadService:DisableGamepadCursor()
end

return t1
