-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local GUI = require(ReplicatedStorage.Library.Client.GUI)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Signal)
local Variables = require(ReplicatedStorage.Library.Variables)
local v1 = table.freeze({
	ButtonA = Enum.KeyCode.ButtonA,
	ButtonB = Enum.KeyCode.ButtonB,
	ButtonX = Enum.KeyCode.ButtonX,
	ButtonY = Enum.KeyCode.ButtonY,
	ButtonLB = Enum.KeyCode.ButtonL1,
	ButtonLT = Enum.KeyCode.ButtonL2,
	ButtonLS = Enum.KeyCode.ButtonL3,
	ButtonRB = Enum.KeyCode.ButtonR1,
	ButtonRT = Enum.KeyCode.ButtonR2,
	ButtonRS = Enum.KeyCode.ButtonR3,
	ButtonStart = Enum.KeyCode.ButtonStart,
	ButtonSelect = Enum.KeyCode.ButtonSelect,
	DPadUp = Enum.KeyCode.DPadUp,
	DPadDown = Enum.KeyCode.DPadDown,
	DPadLeft = Enum.KeyCode.DPadLeft,
	DPadRight = Enum.KeyCode.DPadRight
})
local v2 = table.freeze({
	[Enum.KeyCode.ButtonA] = "ButtonA",
	[Enum.KeyCode.ButtonB] = "ButtonB",
	[Enum.KeyCode.ButtonX] = "ButtonX",
	[Enum.KeyCode.ButtonY] = "ButtonY",
	[Enum.KeyCode.ButtonL1] = "ButtonLB",
	[Enum.KeyCode.ButtonL2] = "ButtonLT",
	[Enum.KeyCode.ButtonL3] = "ButtonLS",
	[Enum.KeyCode.ButtonR1] = "ButtonRB",
	[Enum.KeyCode.ButtonR2] = "ButtonRT",
	[Enum.KeyCode.ButtonR3] = "ButtonRS",
	[Enum.KeyCode.ButtonStart] = "ButtonStart",
	[Enum.KeyCode.ButtonSelect] = "ButtonSelect",
	[Enum.KeyCode.DPadUp] = "DPadUp",
	[Enum.KeyCode.DPadDown] = "DPadDown",
	[Enum.KeyCode.DPadLeft] = "DPadLeft",
	[Enum.KeyCode.DPadRight] = "DPadRight"
})
local v3 = table.freeze({
	Message = 1000,
	BuyMultiple = 1000,
	StealDnaMessage = 1000,
	PetList = 900,
	GrowingEggList = 900,
	DropHeldEgg = 200,
	RunButton = 100
})
local v4 = table.freeze({
	BackpackGui = true,
	Treadmill = true,
	TreadmillScreenButtonSwapLeft = true,
	TreadmillScreenButtonSwapRight = true,
	TreadmillScreenComments = true,
	TreadmillUI = true
})
local v5 = table.freeze({
	PetList = true,
	GrowingEggList = true
})
local v6 = table.freeze({
	Xbox = "rbxassetid://107953372253363",
	Playstation = "rbxassetid://111385931591371"
})
local v7 = table.freeze({
	Xbox = "B",
	Playstation = "O"
})
local v8 = Log.new()
local v9 = GUI.PlayerGui()
local t = {}
local t2 = {}
local t3 = {}
local t4 = {}
local t5 = {}
local v10 = nil
local v11 = nil
local t6 = {}

local function consoleScreenOf(p1) --[[ consoleScreenOf | Line: 118 ]]
	if p1:IsA("ScreenGui") then
		return p1
	end

	return p1:FindFirstAncestorOfClass("ScreenGui")
end

local function consoleButtonOf(p1) --[[ consoleButtonOf | Line: 125 ]]
	local v1 = p1.Parent

	while v1 ~= nil and not v1:IsA("ScreenGui") do
		if v1:IsA("GuiButton") then
			return v1
		end

		v1 = v1.Parent
	end

	return nil
end

local function isExcluded(p1) --[[ isExcluded | Line: 136 | Upvalues: v4 (copy) ]]
	local v1 = if p1:IsA("LayerCollector") then p1 else p1:FindFirstAncestorWhichIsA("LayerCollector")

	return if v1 == nil then false else v4[v1.Name] == true
end

local function isVisible(p1) --[[ isVisible | Line: 143 ]]
	local v1 = p1

	while v1 ~= nil do
		if v1:IsA("ScreenGui") then
			return v1.Enabled
		end

		if v1:IsA("GuiObject") and not v1.Visible then
			break
		end

		v1 = v1.Parent
	end

	return false
end

local function rootPriority(p1) --[[ rootPriority | Line: 157 | Upvalues: v3 (copy) ]]
	return v3[p1.Name] or p1.DisplayOrder
end

local function detectConsoleType() --[[ detectConsoleType | Line: 161 | Upvalues: UserInputService (copy) ]]
	if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then
		return "Playstation"
	end

	return "Xbox"
end

local function projectMarker(p1, p2) --[[ projectMarker | Line: 167 | Upvalues: Variables (copy), t6 (copy) ]]
	p1.Visible = Variables.Console and (if p1:GetAttribute("HideOnLoad") == true then false else true)

	if Variables.Console and p1:IsA("ImageLabel") then
		p1.Image = t6.GetImageForString(p2)

		return
	end

	if not (Variables.Console and p1:IsA("ImageButton")) then
		return
	end

	p1.Image = t6.GetImageForString(p2)
end

local function projectCloseImage(p1) --[[ projectCloseImage | Line: 178 | Upvalues: t2 (copy), Variables (copy), v6 (copy), v11 (ref), UserInputService (copy) ]]
	local v2 = assert(t2[p1], "Close image state must be registered before applying")

	if not Variables.Console then
		p1.Image = v2.Image
		p1.Visible = v2.Visible

		return
	end

	p1.Image = v6[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
	p1.Visible = true
end

local function projectCloseText(p1) --[[ projectCloseText | Line: 189 | Upvalues: t3 (copy), Variables (copy), v7 (copy), v11 (ref), UserInputService (copy) ]]
	local v2 = assert(t3[p1], "Close text state must be registered before applying")

	if not Variables.Console then
		p1.Text = v2.Text
		p1.Visible = v2.Visible

		return
	end

	p1.Text = v7[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
	p1.Visible = true
end

local function registerCloseText(p1) --[[ registerCloseText | Line: 200 | Upvalues: t3 (copy), Variables (copy), v7 (copy), v11 (ref), UserInputService (copy) ]]
	if t3[p1] == nil then
		t3[p1] = {
			Text = p1.Text,
			Visible = p1.Visible
		}
		p1.Destroying:Once(function() --[[ Line: 206 | Upvalues: t3 (ref), p1 (copy) ]]
			t3[p1] = nil
		end)
	end

	local v1 = t3[p1]
	local v2 = assert(v1, "Close text state must be registered before applying")

	if not Variables.Console then
		p1.Text = v2.Text
		p1.Visible = v2.Visible

		return
	end

	p1.Text = v7[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
	p1.Visible = true
end

local function removeButton(p1) --[[ removeButton | Line: 213 | Upvalues: t (copy), t5 (copy) ]]
	t[p1] = nil

	for v1, v2 in t5 do
		if v2 == p1 then
			t5[v1] = nil
		end
	end
end

local function registerActionButton(p1, p2, p3, p4) --[[ registerActionButton | Line: 222 | Upvalues: v1 (copy), t (copy), t5 (copy) ]]
	assert(if v1[p2] == nil then false else true, (("Unknown console action \"%*\""):format(p2)))

	local v5 = assert(if p1:IsA("ScreenGui") then p1 else p1:FindFirstAncestorOfClass("ScreenGui"), (("Console action button %* must belong to a ScreenGui"):format((p1:GetFullName()))))
	local v6 = if t[p1] == nil then true else false

	t[p1] = {
		Action = p2,
		Button = p1,
		Marker = p3,
		Screen = v5,
		IsClose = p4
	}

	if not v6 then
		return
	end

	p1.Destroying:Once(function() --[[ Line: 235 | Upvalues: p1 (copy), t (ref), t5 (ref) ]]
		local v1 = p1

		t[v1] = nil

		for v2, v3 in t5 do
			if v3 == v1 then
				t5[v2] = nil
			end
		end
	end)
end

local function isRecordEligible(p1, p2) --[[ isRecordEligible | Line: 241 | Upvalues: isVisible (copy), v10 (ref) ]]
	if p1.Action ~= p2 or not isVisible(p1.Button) then
		return false
	end

	if p1.Marker ~= nil and not p1.Marker.Visible then
		return false
	end

	if v10 == nil then
		return true
	end

	return p1.Screen == v10
end

local function actionTarget(p1) --[[ actionTarget | Line: 254 | Upvalues: t (copy), isVisible (copy), v10 (ref), v3 (copy) ]]
	local v1 = nil

	for v32, v4 in t do
		local v2

		v2 = if v4.Action == p1 and isVisible(v4.Button) then if v4.Marker == nil or v4.Marker.Visible then if v10 == nil then true elseif v4.Screen == v10 then true else false else false else false

		if v2 then
			if v1 == nil then
				v1 = v4

				continue
			end

			local Screen = v4.Screen
			local v5 = v3[Screen.Name] or Screen.DisplayOrder
			local Screen2 = v1.Screen
			local v6 = v3[Screen2.Name] or Screen2.DisplayOrder

			if v6 < v5 or v5 == v6 and (v1.IsClose and not v4.IsClose) then
				v1 = v4
			end
		end
	end

	if v1 == nil then
		return nil
	end

	return v1.Button
end

local function nativeButtonAOwnsInput() --[[ nativeButtonAOwnsInput | Line: 273 | Upvalues: GuiService (copy), isVisible (copy) ]]
	local SelectedObject = GuiService.SelectedObject

	return if SelectedObject == nil then false else isVisible(SelectedObject)
end

local function onInputBegan(p1, p2) --[[ onInputBegan | Line: 278 | Upvalues: Variables (copy), v2 (copy), GuiService (copy), isVisible (copy), actionTarget (copy), t5 (copy), Signal (copy) ]]
	if not Variables.Console or p2 then
		return
	end

	local v1 = v2[p1.KeyCode]

	if v1 == nil then
		return
	end

	if v1 == "ButtonA" then
		local SelectedObject = GuiService.SelectedObject

		if if SelectedObject == nil then false else isVisible(SelectedObject) then
			return
		end
	end

	local v4 = actionTarget(v1)

	if v4 ~= nil then
		t5[p1.KeyCode] = v4
		Signal.Fire("Console: Pressed", v1)
		Signal.Fire("Console: Pressed Button", v4, v1)
	end
end

local function onInputEnded(p1, p2) --[[ onInputEnded | Line: 295 | Upvalues: Variables (copy), v2 (copy), t5 (copy), isVisible (copy), Signal (copy) ]]
	if not Variables.Console then
		return
	end

	local v1 = v2[p1.KeyCode]

	if v1 == nil then
		return
	end

	local v22 = t5[p1.KeyCode]

	t5[p1.KeyCode] = nil

	if v22 ~= nil and (v22.Active and isVisible(v22)) then
		Signal.Fire("Console: Released", v1)
		Signal.Fire("Console: Released Button", v22, v1)
		Signal.Fire("Console: Full Press", v1)
	end
end

function t6.GetConsoleType() --[[ GetConsoleType | Line: 317 | Upvalues: v11 (ref) ]]
	return v11
end
function t6.GetImageForString(p1) --[[ GetImageForString | Line: 321 | Upvalues: Asserts (copy), v1 (copy), t4 (copy), UserInputService (copy) ]]
	Asserts.string(p1)

	local v3 = assert(v1[p1], (("Unknown console action \"%*\""):format(p1)))
	local v4 = t4[p1]

	if v4 == nil then
		local v5 = UserInputService:GetImageForKeyCode(v3)

		t4[p1] = v5

		return v5
	end

	return v4
end
function t6.ElementIsVisibleOnScreen(p1) --[[ ElementIsVisibleOnScreen | Line: 333 | Upvalues: Asserts (copy), isVisible (copy) ]]
	Asserts.Instance(p1)

	return isVisible(p1)
end
function t6.ConfigureCloseButton(p1) --[[ ConfigureCloseButton | Line: 338 | Upvalues: Asserts (copy), v4 (copy), t2 (copy), t6 (copy), Variables (copy), v6 (copy), v11 (ref), UserInputService (copy) ]]
	Asserts.GuiButton(p1)

	local v1 = if p1:IsA("LayerCollector") then p1 else p1:FindFirstAncestorWhichIsA("LayerCollector")

	if if v1 == nil then false else v4[v1.Name] == true then
		return
	end

	local TextButton = p1:FindFirstChild("TextButton")

	assert(if TextButton == nil then false else TextButton:IsA("ImageLabel"), (("%*.TextButton must be an ImageLabel"):format((p1:GetFullName()))))

	if t2[TextButton] == nil then
		t2[TextButton] = {
			Image = TextButton.Image,
			Visible = TextButton.Visible
		}
		TextButton.Destroying:Once(function() --[[ Line: 350 | Upvalues: t2 (ref), TextButton (copy) ]]
			t2[TextButton] = nil
		end)
	end

	t6.RegisterCloseButton(p1)

	local v5 = t2[TextButton]
	local v62 = assert(v5, "Close image state must be registered before applying")

	if not Variables.Console then
		TextButton.Image = v62.Image
		TextButton.Visible = v62.Visible

		return
	end

	TextButton.Image = v6[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
	TextButton.Visible = true
end
function t6.RegisterCloseButton(p1) --[[ RegisterCloseButton | Line: 358 | Upvalues: Asserts (copy), v4 (copy), v5 (copy), registerCloseText (copy), registerActionButton (copy) ]]
	Asserts.GuiButton(p1)

	local v1 = if p1:IsA("LayerCollector") then p1 else p1:FindFirstAncestorWhichIsA("LayerCollector")

	if if v1 == nil then false else v4[v1.Name] == true then
		return
	end

	local v3 = if p1:IsA("ScreenGui") then p1 else p1:FindFirstAncestorOfClass("ScreenGui")

	if v5[assert(v3, (("Close button %* must belong to a ScreenGui"):format((p1:GetFullName())))).Name] then
		local TextLabel = p1:FindFirstChild("TextLabel")
		local v52 = if TextLabel == nil then false else TextLabel:IsA("TextLabel")

		assert(v52, (("%*.TextLabel must be a TextLabel"):format((p1:GetFullName()))))

		local TextLabel2 = TextLabel:FindFirstChild("TextLabel")

		registerCloseText(TextLabel)

		if TextLabel2 ~= nil then
			local v7 = TextLabel2:IsA("TextLabel")

			assert(v7, (("%*.TextLabel must be a TextLabel when present"):format((TextLabel:GetFullName()))))
			registerCloseText(TextLabel2)
		end
	end

	registerActionButton(p1, "ButtonB", nil, true)
end
function t6.ObserveInstance(p1) --[[ ObserveInstance | Line: 377 | Upvalues: v4 (copy), v5 (copy), t6 (copy), Asserts (copy), consoleButtonOf (copy), registerActionButton (copy), projectMarker (copy) ]]
	local v1 = if p1:IsA("LayerCollector") then p1 else p1:FindFirstAncestorWhichIsA("LayerCollector")

	if if v1 == nil then false else v4[v1.Name] == true then
		return
	end

	if p1:IsA("GuiButton") and p1.Name == "Close" then
		if v5[assert(if p1:IsA("ScreenGui") then p1 else p1:FindFirstAncestorOfClass("ScreenGui"), "Observed close button must belong to a ScreenGui").Name] then
			t6.RegisterCloseButton(p1)
		else
			t6.ConfigureCloseButton(p1)
		end
	elseif p1:IsA("GuiObject") and p1.Name == "ConsoleButton" then
		local v42 = p1:GetAttribute("ConsoleButton")

		Asserts.string(v42)

		local v52 = consoleButtonOf(p1)

		registerActionButton(assert(v52, (("%* must be below a GuiButton"):format((p1:GetFullName())))), v42, p1, false)
		projectMarker(p1, v42)
	end
end
function t6.SetActiveInterface(p1) --[[ SetActiveInterface | Line: 401 | Upvalues: v9 (copy), v10 (ref) ]]
	if p1 ~= nil then
		assert(p1:IsDescendantOf(v9), "Active console interface must belong to the local PlayerGui")
	end

	v10 = p1
end
function t6.UpdateInterface(p1) --[[ UpdateInterface | Line: 408 | Upvalues: Variables (copy), v11 (ref), UserInputService (copy), t4 (copy), v9 (copy), t6 (copy), t2 (copy), v6 (copy), t3 (copy), v7 (copy), t (copy), projectMarker (copy), Signal (copy) ]]
	local v1 = if p1 then p1 else Variables.Platform

	v11 = if v1 == "Console" then if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox" else nil
	table.clear(t4)

	for v3, v4 in v9:GetDescendants() do
		t6.ObserveInstance(v4)
	end

	for v5 in t2 do
		if v5.Parent ~= nil then
			local v72 = assert(t2[v5], "Close image state must be registered before applying")

			if Variables.Console then
				v5.Image = v6[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
				v5.Visible = true

				continue
			end

			v5.Image = v72.Image
			v5.Visible = v72.Visible
		end
	end

	for v10 in t3 do
		if v10.Parent ~= nil then
			local v12 = assert(t3[v10], "Close text state must be registered before applying")

			if Variables.Console then
				v10.Text = v7[v11 or (if UserInputService:GetStringForKeyCode(Enum.KeyCode.ButtonX) == "ButtonSquare" then "Playstation" else "Xbox")]
				v10.Visible = true

				continue
			end

			v10.Text = v12.Text
			v10.Visible = v12.Visible
		end
	end

	for v15, v16 in t do
		if v16.Marker ~= nil then
			projectMarker(v16.Marker, v16.Action)
		end
	end

	Signal.Fire("Console Updated")
end
function t6.IsJumpPermitted() --[[ IsJumpPermitted | Line: 434 ]]
	return true
end
Signal.Fired("Changed Platform"):Connect(t6.UpdateInterface)
Signal.Invoked("Console: Get Console Type").OnInvoke = t6.GetConsoleType
Signal.Invoked("Console: Get Image For String").OnInvoke = t6.GetImageForString
Signal.Invoked("Console: Element Visible On Screen").OnInvoke = t6.ElementIsVisibleOnScreen
Signal.Invoked("Console: Button Visible on Screen").OnInvoke = function(p1) --[[ Line: 446 | Upvalues: actionTarget (copy) ]]
	local v1 = actionTarget(p1)
	local v2 = v1 ~= nil

	if v1 == nil then
		return v2, {}
	end

	return v2, { v1 }
end
UserInputService.InputBegan:Connect(onInputBegan)
UserInputService.InputEnded:Connect(onInputEnded)
v8:AtInfo():Log("Console command routing initialized")

return t6