--!strict
 
--[[

This helps organises the open-keybind, cmdbar overlay, and commands page toggle button, all into one value.
It also handles the permission checks on whether a user can open the cmdbar

]]


-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local scope = Fusion.scoped(Fusion)
local visible = scope:Value(false) :: Fusion.Value<boolean>
local canOpen = scope:Value(false) :: Fusion.Value<boolean>


-- LOCAL FUNCTIONS
-- Opening is gated on canOpen whereas closing is always allowed so a user whose
-- access is revoked mid-session can still dismiss an open bar
local function setOpen(open: boolean)
	if open then
		if Fusion.peek(canOpen) then
			visible:set(true)
		end
	else
		visible:set(false)
	end
end

local function toggle()
	setOpen(not Fusion.peek(visible))
end


return {
	visible = visible,
	canOpen = canOpen,
	setOpen = setOpen,
	toggle = toggle,
}
