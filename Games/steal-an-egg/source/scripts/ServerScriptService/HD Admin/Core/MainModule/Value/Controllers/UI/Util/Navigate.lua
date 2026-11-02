--!strict

--[[

	This is a public navigation API for HD Admin's frontend

	It makes it easier for you to programmatically open the menu, switch pages, and
	trigger buttons (no clicking required). Useful for chaining flows, integration
	tests, debug commands, and external tools

	The internals also use this module so there's only one code path for any
	given action (clicking a title or calling Navigate.activate(), etc
	the same callback fires)

	Example:
		
		local Navigate = require(<this module>)
		Navigate.openPanel()
		Navigate.toPage("Settings")
		Navigate.activate("Cafe")
		Navigate.confirm()

--]]


-- CONFIG
local BRIDGE_TAG = "_HDNavigateBridge" -- other script contexts reach the live menu instance through this tag


-- LOCAL
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local Navigate = {}
local localContext: Context? = nil
local localVisibility: VisibilityBinding? = nil
local activateRegistry: { [Instance]: () -> () } = setmetatable({}, { __mode = "k" }) :: any -- weak-keyed so destroyed buttons don't pin themselves in memory


-- TYPES
export type Context = {
	navigateTo: (pageId: string) -> (),
	goBack: () -> (),
	currentPage: () -> string,
	pageHistory: () -> { string },
	panelRoot: () -> Instance?,
}

export type VisibilityBinding = {
	setVisible: (visible: boolean) -> (),
	isVisible: () -> boolean,
}


-- LOCAL FUNCTIONS
local function activateLocal(btn: GuiButton): boolean
	local callback = activateRegistry[btn]
	if not callback then return false end
	local ok, err = pcall(callback)
	if not ok then
		warn("HD Admin Navigate.activate error: " .. tostring(err))
		return false
	end
	return true
end

local function getBridge(): BindableFunction?
	for _, inst in CollectionService:GetTagged(BRIDGE_TAG) do
		if inst:IsA("BindableFunction") and inst.Parent then
			return inst
		end
	end
	return nil
end

local function invoke(op: string, ...): any
	-- Prefer the in-process context, no marshalling
	if localContext then
		if op == "currentPage" then return localContext.currentPage() end
		if op == "pageHistory" then return localContext.pageHistory() end
		if op == "navigateTo" then localContext.navigateTo(...); return nil end
		if op == "goBack" then localContext.goBack(); return nil end
		if op == "panelRoot" then return localContext.panelRoot() end
	end
	if localVisibility then
		if op == "setPanelVisible" then localVisibility.setVisible(...); return nil end
		if op == "isPanelOpen" then return localVisibility.isVisible() end
	end
	local bridge = getBridge()
	if not bridge then
		error("HD Admin UI Navigate: menu has not mounted (register was never called)")
	end
	return bridge:Invoke(op, ...)
end


-- REGISTRATION
function Navigate.register(ctx: Context)
	localContext = ctx

	local panelRoot = ctx.panelRoot()
	if not panelRoot then return end

	for _, inst in CollectionService:GetTagged(BRIDGE_TAG) do
		inst:Destroy()
	end

	local bridge = Instance.new("BindableFunction")
	bridge.Name = "HDNavigateBridge"
	bridge.Parent = panelRoot
	bridge.OnInvoke = function(op: string, ...: any): any
		if op == "currentPage" then return ctx.currentPage() end
		if op == "pageHistory" then return ctx.pageHistory() end
		if op == "navigateTo" then ctx.navigateTo(...); return nil end
		if op == "goBack" then ctx.goBack(); return nil end
		if op == "setPanelVisible" then
			if localVisibility then localVisibility.setVisible(...) end
			return nil
		end
		if op == "isPanelOpen" then
			return if localVisibility then localVisibility.isVisible() else false
		end
		if op == "activate" then
			local target, btnPath = ...
			-- Instance refs from another script context don't carry over, so prefer the path
			if typeof(btnPath) == "string" then
				local parts = string.split(btnPath, ".")
				local inst: Instance? = game:GetService(parts[1])
				for index = 2, #parts do
					if not inst then break end
					inst = inst:FindFirstChild(parts[index])
				end
				if inst and inst:IsA("GuiButton") and activateRegistry[inst] then
					return activateLocal(inst :: GuiButton)
				end
			end
			if typeof(target) == "string" then
				local btn = Navigate.findButton(target)
				if not btn then
					local root = ctx.panelRoot()
					if root then
						for _, descendant in root:GetDescendants() do
							if descendant:IsA("GuiButton") and descendant.Name == target then
								btn = descendant :: GuiButton
								break
							end
						end
					end
				end
				if btn then return activateLocal(btn) end
			end
			return false
		end
		if op == "isReady" then return true end
		return nil
	end
	CollectionService:AddTag(bridge, BRIDGE_TAG)
end

function Navigate.bindPanelVisibility(binding: VisibilityBinding)
	localVisibility = binding
end

function Navigate.unregister()
	localContext = nil
	for _, inst in CollectionService:GetTagged(BRIDGE_TAG) do
		inst:Destroy()
	end
end

function Navigate.isReady(): boolean
	if localContext ~= nil then return true end
	return getBridge() ~= nil
end

function Navigate.awaitReady(timeout: number?)
	local deadline = os.clock() + (timeout or 5)
	while not Navigate.isReady() and os.clock() < deadline do
		task.wait(0.1)
	end
	if not Navigate.isReady() then
		error("HD Admin UI Navigate: timed out waiting for menu to mount")
	end
end


-- NAVIGATION
function Navigate.toPage(pageId: string)
	Navigate.awaitReady()
	invoke("navigateTo", pageId)
end

function Navigate.goBack()
	invoke("goBack")
end

function Navigate.currentPage(): string
	return invoke("currentPage")
end

function Navigate.pageHistory(): { string }
	return invoke("pageHistory")
end


-- MENU VISIBILITY
function Navigate.openPanel()
	Navigate.awaitReady()
	invoke("setPanelVisible", true)
end

function Navigate.closePanel()
	invoke("setPanelVisible", false)
end

function Navigate.isPanelOpen(): boolean
	return invoke("isPanelOpen")
end


-- INSPECTION
local function getPanelRoot(): Instance?
	if localContext then return localContext.panelRoot() end
	local bridge = getBridge()
	return bridge and bridge.Parent or nil
end

function Navigate.findByLabel(text: string, exact: boolean?): { { path: string, absPos: Vector2, absSize: Vector2, visible: boolean, instance: Instance } }
	local root = getPanelRoot()
	if not root then return {} end

	local exactMatch = exact ~= false
	local results = {}
	local function walk(inst: Instance)
		if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
			-- ContentText handles rich-text labels
			local candidate = (inst :: any).ContentText or (inst :: any).Text
			local matches = if exactMatch then candidate == text else string.find(candidate, text, 1, true) ~= nil
			if matches then
				local gui = inst :: GuiObject
				table.insert(results, {
					path = inst:GetFullName(),
					absPos = gui.AbsolutePosition,
					absSize = gui.AbsoluteSize,
					visible = gui.Visible,
					instance = inst,
				})
			end
		end
		for _, child in inst:GetChildren() do
			walk(child)
		end
	end
	walk(root)
	return results
end

function Navigate.scrollIntoView(target: GuiObject, paddingTop: number?)
	local padding = paddingTop or 10
	local scroll: ScrollingFrame? = nil
	local parent: Instance? = target.Parent
	while parent do
		if parent:IsA("ScrollingFrame") then
			scroll = parent
			break
		end
		parent = parent.Parent
	end
	if not scroll then return end

	local scrollAbs = scroll.AbsolutePosition.Y
	local targetAbs = target.AbsolutePosition.Y
	local relative = targetAbs - scrollAbs + scroll.CanvasPosition.Y
	scroll.CanvasPosition = Vector2.new(scroll.CanvasPosition.X, math.max(relative - padding, 0))
end

function Navigate.snapshot(): { currentPage: string, visibleButtons: { { label: string, path: string, absPos: Vector2 } } }
	local out = {
		currentPage = Navigate.currentPage(),
		visibleButtons = {},
	}
	local root = getPanelRoot()
	if not root then return out end

	local function walk(inst: Instance)
		if inst:IsA("GuiButton") and (inst :: GuiButton).Visible and (inst :: GuiButton).Interactable then
			local label = inst:FindFirstChild("Label")
			local text = "?"
			if label and (label:IsA("TextLabel") or label:IsA("TextButton")) then
				text = (label :: any).ContentText or (label :: any).Text
			elseif inst:IsA("TextButton") then
				text = (inst :: any).ContentText or (inst :: any).Text
			end
			if text ~= "" and text ~= "?" then
				table.insert(out.visibleButtons, {
					label = text,
					path = inst:GetFullName(),
					absPos = (inst :: GuiButton).AbsolutePosition,
				})
			end
		end
		for _, child in inst:GetChildren() do
			walk(child)
		end
	end
	walk(root)
	return out
end


-- BUTTON LOOKUPS
-- True only when GetFullName resolves to a single Instance under the menu root
local function isPathUnique(target: Instance): boolean
	local root = getPanelRoot()
	if not root then return false end
	local targetPath = target:GetFullName()
	local found = 0
	for _, descendant in root:GetDescendants() do
		if descendant:GetFullName() == targetPath then
			found += 1
			if found > 1 then return false end
		end
	end
	return found == 1
end

local function findClickableAncestor(inst: Instance): GuiButton?
	local current: Instance? = inst
	local depth = 0
	while current and depth < 10 do
		if current:IsA("GuiButton") and (current :: GuiButton).Interactable then
			return current :: GuiButton
		end
		current = current.Parent
		depth += 1
	end
	return nil
end

-- Returns the actual GuiButton, not the inner TextLabel
function Navigate.findButton(label: string): GuiButton?
	local matches = Navigate.findByLabel(label, true)
	for _, match in matches do
		local btn = findClickableAncestor(match.instance)
		if btn then return btn end
	end
	return nil
end

-- Polls until the label shows up, for lazily-rendered rows
function Navigate.waitForLabel(label: string, timeout: number?): GuiButton?
	local deadline = os.clock() + (timeout or 2)
	while os.clock() < deadline do
		local btn = Navigate.findButton(label)
		if btn then return btn end
		task.wait(0.05)
	end
	return nil
end

function Navigate.scrollAndFind(label: string, scrollingFrame: ScrollingFrame?, maxScrolls: number?): GuiButton?
	local btn = Navigate.findButton(label)
	if btn then return btn end

	local scroll = scrollingFrame
	if not scroll then
		local root = getPanelRoot()
		if root then
			for _, descendant in root:GetDescendants() do
				if descendant:IsA("ScrollingFrame") and descendant.AbsoluteSize.X > 0 and descendant.Visible then
					scroll = descendant
					break
				end
			end
		end
	end
	if not scroll then return nil end

	local step = scroll.AbsoluteWindowSize.Y * 0.5
	local limit = maxScrolls or 40
	for _ = 1, limit do
		scroll.CanvasPosition = Vector2.new(scroll.CanvasPosition.X, scroll.CanvasPosition.Y + step)
		task.wait(0.05)
		btn = Navigate.findButton(label)
		if btn then return btn end
		if scroll.CanvasPosition.Y + scroll.AbsoluteWindowSize.Y >= scroll.AbsoluteCanvasSize.Y - 1 then
			break
		end
	end
	return nil
end

-- path is nil when GetFullName isn't unique, which happens with repeated names
-- like virtualised rows. Callers should fall back to (x, y) then
export type ClickTarget = {
	path: string?,
	x: number,
	y: number,
}

function Navigate.resolveClickPoint(label: string, timeout: number?): ClickTarget?
	local btn = Navigate.waitForLabel(label, timeout or 0.5)
	if not btn then
		btn = Navigate.scrollAndFind(label)
	end
	if not btn then return nil end
	return Navigate.pointFor(btn)
end

function Navigate.pointFor(btn: GuiButton): ClickTarget
	Navigate.scrollIntoView(btn)
	task.wait(0.05)
	local pos = btn.AbsolutePosition
	local size = btn.AbsoluteSize
	return {
		path = if isPathUnique(btn) then btn:GetFullName() else nil,
		x = pos.X + size.X / 2,
		y = pos.Y + size.Y / 2,
	}
end


-- PENDING-CHANGES
-- The ConfirmBarWrap collapses to height 0 with children still Visible, so we
-- check the wrap's size instead of the button's Visible flag
local function findPendingButton(buttonName: string): GuiButton?
	local root = getPanelRoot()
	if not root then return nil end
	for _, descendant in root:GetDescendants() do
		if descendant:IsA("GuiButton") and descendant.Name == buttonName then
			local wrap = descendant.Parent and descendant.Parent.Parent and descendant.Parent.Parent.Parent
			if wrap and wrap.Name == "ConfirmBarWrap" and (wrap :: Frame).AbsoluteSize.Y > 4 then
				return descendant :: GuiButton
			end
		end
	end
	return nil
end

function Navigate.confirmPending(): ClickTarget?
	local btn = findPendingButton("ConfirmButton")
	return if btn then Navigate.pointFor(btn) else nil
end

function Navigate.undoPending(): ClickTarget?
	local btn = findPendingButton("UndoButton")
	return if btn then Navigate.pointFor(btn) else nil
end

function Navigate.hasPendingChanges(): boolean
	return findPendingButton("ConfirmButton") ~= nil
end


-- ACTIVATION
-- Same code path as a real click but synchronous. Pressable self-registers

function Navigate.registerActivate(instance: Instance, callback: () -> ())
	activateRegistry[instance] = callback
end

-- Returns the button unchanged so you can inline it in [Children]
function Navigate.makeActivatable<T>(button: T, callback: () -> ()): T
	if typeof(button) == "Instance" then
		activateRegistry[button :: Instance] = callback
	end
	return button
end

-- Routes through the bridge when the registry isn't in this script context
function Navigate.activate(target: GuiButton | string): boolean
	local btn: GuiButton? = nil
	if typeof(target) == "Instance" then
		btn = target :: GuiButton
	end

	if btn and activateRegistry[btn] then
		return activateLocal(btn)
	end

	local bridge = getBridge()
	if bridge then
		local btnPath: string? = if btn then btn:GetFullName() else nil
		return bridge:Invoke("activate", target, btnPath)
	end

	if not btn then
		btn = Navigate.findButton(target :: string)
		if not btn then
			local root = getPanelRoot()
			if root then
				for _, descendant in root:GetDescendants() do
					if descendant:IsA("GuiButton") and descendant.Name == target then
						btn = descendant :: GuiButton
						break
					end
				end
			end
		end
	end
	return if btn then activateLocal(btn) else false
end

function Navigate.confirm(): boolean
	local btn = findPendingButton("ConfirmButton")
	return if btn then Navigate.activate(btn) else false
end

function Navigate.undo(): boolean
	local btn = findPendingButton("UndoButton")
	return if btn then Navigate.activate(btn) else false
end


return Navigate
