-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local ButtonFX = require(ReplicatedStorage.Library.Client.GUIFX.ButtonFX)
local ConsoleCmds = require(ReplicatedStorage.Library.Client.ConsoleCmds)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local InfoOverlay = require(ReplicatedStorage.Library.Client.InfoOverlay)
local Lock = require(ReplicatedStorage.Library.Functions.Lock)
local SearchArray = require(ReplicatedStorage.Library.Functions.SearchArray)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local v1 = require(ReplicatedStorage.Library.Modules.Event)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Player = require(ReplicatedStorage.Library.Player)
local Variables = require(ReplicatedStorage.Library.Variables)
local v2 = table.freeze({ "Message", "BuyMultiple" })
local v3 = Log.new()
local v4 = nil
local t = {}
local v5 = Player.Camera()
local FieldOfView = v5.FieldOfView
local TabControllerDepthBlur = Instance.new("DepthOfFieldEffect")

TabControllerDepthBlur.FarIntensity = 0.755
TabControllerDepthBlur.FocusDistance = 200
TabControllerDepthBlur.InFocusRadius = 13.25
TabControllerDepthBlur.NearIntensity = 0
TabControllerDepthBlur.Name = "TabControllerDepthBlur"
TabControllerDepthBlur.Enabled = false
TabControllerDepthBlur.Parent = Lighting

local t2 = {}
local v6 = nil
local v7 = nil
local v8 = false
local v9 = nil
local t3 = {}
local t4 = {}
local v10 = Lock()
local t5 = {
	Opened = v1.new(),
	Closed = v1.new()
}

local function isLockedAgainstTransition(p1) --[[ isLockedAgainstTransition | Line: 65 | Upvalues: v9 (ref), v6 (ref) ]]
	return if v9 == nil or v6 ~= v9 then false else p1 ~= v9
end

local function ToggleCoreUI(p1) --[[ ToggleCoreUI | Line: 69 | Upvalues: StarterGui (copy) ]]
	if StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) == p1 then
		return
	end

	StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, p1)
end

local function doMobile(p1) --[[ doMobile | Line: 75 | Upvalues: v4 (ref), Variables (copy) ]]
	if not v4 then
		v4 = Variables.Locks.DisableTouchControls:ObtainLock()

		return
	end

	v4()
	v4 = nil

	if not p1 then
		v4 = Variables.Locks.DisableTouchControls:ObtainLock()
	end
end

local function closeTab(p1, p2, p3) --[[ closeTab | Line: 87 | Upvalues: t5 (copy), v8 (ref), GuiService (copy), v6 (ref), GUI (copy), t2 (copy), Variables (copy), v4 (ref), t4 (copy), Workspace (copy), StarterGui (copy), t (copy), TabControllerDepthBlur (copy), Tween (copy), v5 (copy), FieldOfView (copy), InfoOverlay (copy) ]]
	if not t5.IsOpen() then
		v8 = false

		return
	end

	v8 = true

	if p2 == nil then
		if GuiService.SelectedObject then
			GuiService.SelectedObject = nil
		end

		if GuiService.GuiNavigationEnabled then
			GuiService.GuiNavigationEnabled = false
		end
	end

	local v1

	if v6 == nil then
		v1 = nil
	else
		local v2 = GUI.Get(v6)
		local v3 = v2:IsA("ScreenGui")

		assert(v3, (("Tab %* must be a ScreenGui"):format(v6)))

		if not t2[v2] then
			t2[v2] = {
				isOpen = false,
				initializedClose = false,
				ui = v2
			}
		end

		v1 = t2[v2]
	end

	if not v1 then
		return
	end

	if Variables.Mobile then
		if v4 then
			v4()
			v4 = nil
		else
			v4 = Variables.Locks.DisableTouchControls:ObtainLock()
		end
	end

	local v52 = v1.ui:FindFirstChildOfClass("Frame") or v1.ui:FindFirstChildWhichIsA("ImageLabel")

	assert(v52, "Expected uiFrame to exist in TabController.")

	local UIScale = v52:FindFirstChildOfClass("UIScale")

	if not UIScale then
		local TabControllerUIScale = Instance.new("UIScale")

		assert(TabControllerUIScale, "Failed to create UIScale in TabController.")
		TabControllerUIScale.Name = "TabControllerUIScale"
		TabControllerUIScale.Parent = v52
		UIScale = TabControllerUIScale
	end

	local function close() --[[ close | Line: 139 | Upvalues: v1 (ref), t4 (ref), v6 (ref), p2 (copy), p3 (copy), Variables (ref), Workspace (ref), StarterGui (ref), t5 (ref), t (ref) ]]
		v1.isOpen = false

		for v12, v2 in t4 do
			task.spawn(function() --[[ Line: 143 | Upvalues: v2 (copy), v6 (ref), p2 (ref), p3 (ref) ]]
				v2(v6, p2, p3 == true)
			end)
		end

		local v3 = v6

		if Variables.Mobile and (Workspace.CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= true) then
			StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end

		v6 = nil

		local v4 = p2
		local v5 = p3 == true

		t5.Closed:FireAsync(v3, v4, v5)

		for i, v in ipairs(t) do
			v.Enabled = true
		end
	end

	if p1 then
		if p3 then
			TabControllerDepthBlur.Enabled = false
		end
	else
		local v62 = Tween(v52, {
			Position = UDim2.new(0.5, 0, 0.6, v52.Position.Y.Offset)
		}, { 0.045, "Linear", "Out" })

		Tween(assert(UIScale, "Expected close tween UIScale to exist"), {
			Scale = 0.85
		}, { 0.045, "Linear", "Out" })
		Tween(v5, {
			FieldOfView = FieldOfView
		}, { 0.2, "Sine", "Out" })
		Tween(TabControllerDepthBlur, {
			FocusDistance = 200
		}, { 0.2, "Sine", "Out" }).Completed:Connect(function() --[[ Line: 184 | Upvalues: TabControllerDepthBlur (ref) ]]
			TabControllerDepthBlur.Enabled = false
		end)
		v62.Completed:Wait()
	end

	v1.ui.Enabled = false
	close()
	InfoOverlay.Remove()
end

local function openTab(p1, p2, p3) --[[ openTab | Line: 197 | Upvalues: v6 (ref), closeTab (copy), GUI (copy), t2 (copy), t (copy), Variables (copy), v4 (ref), ConsoleCmds (copy), t5 (copy), ButtonFX (copy), Tween (copy), TabControllerDepthBlur (copy), SearchArray (copy), v2 (copy), v5 (copy), Workspace (copy), StarterGui (copy), v7 (ref), t3 (copy) ]]
	if v6 == p1 then
		return
	end

	if v6 ~= nil then
		closeTab(true, p1, false)
	end

	local v1 = GUI.Get(p1)

	assert(v1:IsA("ScreenGui"), (("Tab %* must be a ScreenGui"):format(p1)))

	local v42

	if t2[v1] then
		v42 = t2[v1]
	else
		local t4 = {
			isOpen = false,
			initializedClose = false,
			ui = v1
		}

		t2[v1] = t4
		v42 = t4
	end

	if not v42 then
		return
	end

	v42.ui.Enabled = true
	v42.isOpen = true

	for i, v in ipairs(t) do
		v.Enabled = false
	end

	if Variables.Mobile then
		if v4 then
			v4()
			v4 = nil
		end

		v4 = Variables.Locks.DisableTouchControls:ObtainLock()
	end

	Variables.HideProgressUI = true

	local v52 = v42.ui:FindFirstChildOfClass("Frame") or v42.ui:FindFirstChildWhichIsA("ImageLabel")

	assert(v52, "Expected uiFrame to exist in TabController for opening a tab.")

	local UIScale = v52:FindFirstChildOfClass("UIScale")

	if not UIScale then
		local TabControllerUIScale = Instance.new("UIScale")

		assert(TabControllerUIScale, "Failed to create UIScale in TabController during openTab.")
		TabControllerUIScale.Name = "TabControllerUIScale"
		TabControllerUIScale.Parent = v52
		UIScale = TabControllerUIScale
	end

	assert(UIScale, "Expected uiScale to exist in TabController during openTab.")

	if not v42.initializedClose and v52 then
		local v62 = v52:FindFirstChildWhichIsA("Frame")
		local v72 = v52:FindFirstChild("Close") or (if v62 then v62:FindFirstChild("Close") else v62)

		if v72 then
			assert(v72:IsA("GuiButton"), "Expected closeButton to be a GuiButton in TabController.")
			ConsoleCmds.ConfigureCloseButton(v72)
			GUI.ButtonActivated(v72, function() --[[ Line: 255 | Upvalues: t5 (ref) ]]
				t5.CloseTab(true)
			end)
			ButtonFX(v72)
		end

		v42.initializedClose = true
	end

	local v9 = if v6 == "Ultimates" then p1 == "Inventory" else false

	if not v9 and (v6 == nil and v52) then
		UIScale.Scale = 0.975
		v52.Position = UDim2.new(0.5, 0, 0.6, v52.Position.Y.Offset)
		Tween(v52, {
			Position = UDim2.fromScale(0.5, 0.5)
		}, { 0.1, Enum.EasingStyle.Circular, "Out" })
		Tween(UIScale, {
			Scale = 1
		}, { 0.15, Enum.EasingStyle.Circular, "Out" })
		TabControllerDepthBlur.FocusDistance = 200
		TabControllerDepthBlur.Enabled = true
		Tween(TabControllerDepthBlur, {
			FocusDistance = 5
		}, { 0.2, Enum.EasingStyle.Circular, "Out" })

		if not SearchArray(v2, p1) then
			Tween(v5, {
				FieldOfView = 76
			}, { 0.325, Enum.EasingStyle.Circular, "Out" })
		end
	elseif not v9 and (v6 ~= nil and v52) then
		UIScale.Scale = 1
		v52.Position = UDim2.new(0.5, 0, 0.525, v52.Position.Y.Offset)
		Tween(v52, {
			Position = UDim2.fromScale(0.5, 0.5)
		}, { 0.1, "Sine", "Out" })
	end

	if Variables.Mobile and (Workspace.CurrentCamera.ViewportSize.Y > 550 and StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) ~= false) then
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	end

	v6 = p1
	v7 = if p3 then nil else p1

	for i, v in ipairs(t3) do
		task.spawn(function() --[[ Line: 320 | Upvalues: v (copy), p1 (copy), p2 (copy) ]]
			v(p1, p2 == true)
		end)
	end

	local Opened = t5.Opened

	Opened:FireAsync(p1, p2 == true)
end

function t5.AddOpenListener(p1) --[[ AddOpenListener | Line: 333 | Upvalues: t3 (copy) ]]
	table.insert(t3, p1)
end
function t5.AddCloseListener(p1) --[[ AddCloseListener | Line: 337 | Upvalues: t4 (copy) ]]
	table.insert(t4, p1)
end
function t5.IsOpen(p1) --[[ IsOpen | Line: 341 | Upvalues: v6 (ref), GUI (copy), t2 (copy) ]]
	if p1 == nil then
		return v6 ~= nil
	end

	local v2 = GUI.Get(p1)

	assert(v2:IsA("ScreenGui"), (("Tab %* must be a ScreenGui"):format(p1)))

	local v5

	if t2[v2] then
		v5 = t2[v2]
	else
		local t = {
			isOpen = false,
			initializedClose = false,
			ui = v2
		}

		t2[v2] = t
		v5 = t
	end

	return v5.isOpen
end
function t5.IsClosed(p1) --[[ IsClosed | Line: 363 | Upvalues: t5 (copy) ]]
	return not t5.IsOpen(p1)
end
function t5.Get() --[[ Get | Line: 367 | Upvalues: v6 (ref) ]]
	return v6
end
function t5.SetLockedTab(p1) --[[ SetLockedTab | Line: 371 | Upvalues: v9 (ref) ]]
	v9 = p1
end
function t5.OpenTab(p1, p2, p3, p4) --[[ OpenTab | Line: 375 | Upvalues: v10 (copy), v9 (ref), v6 (ref), openTab (copy) ]]
	local v1 = false

	v10(function() --[[ Line: 377 | Upvalues: p4 (copy), p1 (copy), v9 (ref), v6 (ref), v1 (ref), openTab (ref), p2 (copy), p3 (copy) ]]
		if p4 then
			v1 = true
			openTab(p1, p2, p3)

			return
		end

		if not (if v9 == nil or v6 ~= v9 then false else p1 ~= v9) then
			v1 = true
			openTab(p1, p2, p3)
		end
	end)

	return v1
end
function t5.CloseTab(p1) --[[ CloseTab | Line: 388 | Upvalues: v10 (copy), v9 (ref), v6 (ref), v8 (ref), closeTab (copy) ]]
	v10(function() --[[ Line: 389 | Upvalues: v9 (ref), v6 (ref), v8 (ref), closeTab (ref), p1 (copy) ]]
		if if v9 == nil or v6 ~= v9 then false else v9 ~= nil then
			v8 = false

			return
		end

		if not v6 then
			v8 = false

			return
		end

		closeTab(nil, nil, p1 == true)
	end)
end
function t5.ToggleTab(p1) --[[ ToggleTab | Line: 403 | Upvalues: v6 (ref), t5 (copy) ]]
	if v6 == p1 then
		t5.CloseTab()
	else
		t5.OpenTab(p1)
	end
end
function t5.Restore() --[[ Restore | Line: 411 | Upvalues: t5 (copy), v7 (ref), v8 (ref) ]]
	if t5.IsOpen() or not (v7 and v8) then
		return
	end

	t5.OpenTab(v7, true)
end
task.spawn(function() --[[ Line: 423 | Upvalues: Variables (copy), t5 (copy), v4 (ref) ]]
	if not Variables.Mobile then
		return
	end

	local v1 = t5.Get() == nil

	if v4 then
		v4()
		v4 = nil

		if v1 then
			return
		end
	end

	v4 = Variables.Locks.DisableTouchControls:ObtainLock()
end)
v3:AtInfo():Log("Tab controller initialized")

return t5