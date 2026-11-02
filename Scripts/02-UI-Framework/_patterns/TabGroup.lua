--[[
	TabGroup (ModuleScript, client only)

	Tabs inside a window: a row of tab buttons and a set of pages, matched by name.
	Exactly one tab is selected; its page is visible and the others are hidden.
	Gamepad players can cycle tabs with L1 / R1 (bind only while the window is open).

	Credits / ideas taken from:
	  - Work at a Pizza Place  GuiManager/TabGroup + Tab   (sort tabs left-to-right, one pressed, L1/R1 cycling, TabChanged event)
	  - Brainrot Lab UIInitializer                         (match buttons to frames by name instead of hard-coding)

	Usage (LocalScript):
		local TabGroup = require(ReplicatedStorage.Modules.TabGroup)
		local shop = PlayerGui.Main.Frames.Shop

		local tabs = TabGroup.fromContainers(shop.Tabs, shop.Pages, {
			Default = "Featured",
			SelectedColor = Color3.fromRGB(255, 200, 40),
			UnselectedColor = Color3.fromRGB(60, 60, 60),
		})
		tabs.Changed:Connect(function(name) print("tab:", name) end)

		-- with the WindowManager pattern:
		windows:Register("Shop", shop, {
			OnOpen = function() tabs:BindGamepad() end,
			OnClose = function() tabs:UnbindGamepad() end,
		})

		tabs:Select("Gamepasses")
		tabs:Next(1)   -- move right, wraps around

	Custom look: pass Style = function(button, selected) ... end to fully control the selected look.
	Without Style, the button gets a "Selected" attribute, its BackgroundColor3 is set when colors
	are given, and a child named "SelectedIndicator" (if any) is shown only when selected.
]]

local ContextActionService = game:GetService("ContextActionService")

local TabGroup = {}
TabGroup.__index = TabGroup

local groupCount = 0

local function defaultStyle(options)
	return function(button: GuiButton, selected: boolean)
		button:SetAttribute("Selected", selected)
		if options.SelectedColor and options.UnselectedColor then
			button.BackgroundColor3 = if selected then options.SelectedColor else options.UnselectedColor
		end
		local indicator = button:FindFirstChild("SelectedIndicator")
		if indicator and indicator:IsA("GuiObject") then
			indicator.Visible = selected
		end
	end
end

--[[
	tabs: { { Name = string, Button = GuiButton, Page = GuiObject? } } in display order
	options: { Default, Style, SelectedColor, UnselectedColor }
]]
function TabGroup.new(tabs: { { [string]: any } }, options: { [string]: any }?)
	local opts = options or {}
	groupCount += 1

	local self = setmetatable({}, TabGroup)
	self._tabs = tabs
	self._byName = {}
	self._selected = nil
	self._style = opts.Style or defaultStyle(opts)
	self._actionName = "TabGroupCycle_" .. groupCount
	self._connections = {}

	self._changedEvent = Instance.new("BindableEvent")
	self.Changed = self._changedEvent.Event -- fires (tabName: string)

	for _, tab in tabs do
		self._byName[tab.Name] = tab
		table.insert(self._connections, tab.Button.Activated:Connect(function()
			self:Select(tab.Name)
		end))
	end

	local first = tabs[1]
	local default = opts.Default or (first and first.Name)
	if default then
		self:Select(default)
	end
	return self
end

-- Pair every GuiButton in buttonContainer with the GuiObject of the same name in pageContainer.
-- Order: LayoutOrder first, then on-screen X position.
function TabGroup.fromContainers(buttonContainer: Instance, pageContainer: Instance?, options: { [string]: any }?)
	local list = {}
	for _, child in buttonContainer:GetChildren() do
		if child:IsA("GuiButton") then
			local page = pageContainer and pageContainer:FindFirstChild(child.Name)
			table.insert(list, {
				Name = child.Name,
				Button = child,
				Page = if page and page:IsA("GuiObject") then page else nil,
			})
		end
	end
	table.sort(list, function(a, b)
		if a.Button.LayoutOrder ~= b.Button.LayoutOrder then
			return a.Button.LayoutOrder < b.Button.LayoutOrder
		end
		return a.Button.AbsolutePosition.X < b.Button.AbsolutePosition.X
	end)
	return TabGroup.new(list, options)
end

function TabGroup:Select(name: string)
	local target = self._byName[name]
	if not target then
		warn("[TabGroup] unknown tab: " .. tostring(name))
		return
	end
	if self._selected == name then
		return
	end
	self._selected = name
	for _, tab in self._tabs do
		local selected = tab.Name == name
		self._style(tab.Button, selected)
		if tab.Page then
			tab.Page.Visible = selected
		end
	end
	self._changedEvent:Fire(name)
end

function TabGroup:GetSelected(): string?
	return self._selected
end

-- direction: 1 = next tab, -1 = previous tab (wraps around)
function TabGroup:Next(direction: number)
	local count = #self._tabs
	if count == 0 then
		return
	end
	local index = 1
	for i, tab in self._tabs do
		if tab.Name == self._selected then
			index = i
			break
		end
	end
	local nextIndex = ((index - 1 + direction) % count) + 1
	self:Select(self._tabs[nextIndex].Name)
end

-- L1 / R1 cycle tabs. Call when the window opens; call UnbindGamepad when it closes.
function TabGroup:BindGamepad(previousKey: Enum.KeyCode?, nextKey: Enum.KeyCode?)
	local previous = previousKey or Enum.KeyCode.ButtonL1
	local nextK = nextKey or Enum.KeyCode.ButtonR1
	ContextActionService:BindAction(self._actionName, function(_, inputState, inputObject)
		if inputState ~= Enum.UserInputState.Begin then
			return Enum.ContextActionResult.Pass
		end
		self:Next(if inputObject.KeyCode == previous then -1 else 1)
		return Enum.ContextActionResult.Sink
	end, false, previous, nextK)
end

function TabGroup:UnbindGamepad()
	ContextActionService:UnbindAction(self._actionName)
end

function TabGroup:Destroy()
	self:UnbindGamepad()
	for _, connection in self._connections do
		connection:Disconnect()
	end
	table.clear(self._connections)
	self._changedEvent:Destroy()
end

return TabGroup
