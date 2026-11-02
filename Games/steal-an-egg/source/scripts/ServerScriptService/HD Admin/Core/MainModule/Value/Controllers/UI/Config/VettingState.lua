--!strict

--[[

The vet view is its own page (VetCommandsPage, opened from the Vet button on
the Commands page)

]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local wantsPendingFocus = false
local openListener: (() -> ())? = nil


-- FUNCTIONS
local function acknowledge()
	task.spawn(function()
		local Remote = require(modules.Objects.Remote)
		Remote.get("AcknowledgeVetting"):invokeServerAsync()
	end)
end

local function open(focusPending: boolean?)
	wantsPendingFocus = focusPending == true
	local Navigate = require(modules.Parent.Controllers.UI.Util.Navigate) :: any
	Navigate.openPanel()
	Navigate.toPage("VetCommands")
	-- Navigating to the page you're already on fires no isActive change, so
	-- the page also listens here to catch repeat opens
	local listener = openListener
	if listener then
		task.spawn(listener)
	end
end

local function setOpenListener(callback: (() -> ())?)
	openListener = callback
end

-- The page calls this when it opens. True means a notice click asked to land
-- on the Pending tab
local function consumePendingFocus(): boolean
	local wanted = wantsPendingFocus
	wantsPendingFocus = false
	return wanted
end


return {
	open = open,
	acknowledge = acknowledge,
	consumePendingFocus = consumePendingFocus,
	setOpenListener = setOpenListener,
}
