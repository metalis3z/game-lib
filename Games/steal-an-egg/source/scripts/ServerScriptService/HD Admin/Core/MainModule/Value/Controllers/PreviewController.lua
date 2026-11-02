--!strict

--[[

	This keeps a sidebar action card up for the whole time you're previewing roles.
	It matters because previewing a role whose Icon is "None" hides the topbar icon
	and closes the menu, which removes every other route to ending the preview. So
	the card has no close X and no expiry, just an Exit Preview button

--]]


-- LOCAL
local PreviewController = {}
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Prompt = require(modules.Prompt)
local Remote = require(modules.Objects.Remote)
local Fusion = require(modules.Parent.Packages.Fusion)
local fuseState = require(modules.DataUtil.fuseState)
local Icons = require(modules.Parent.Controllers.UI.Config.Icons)
local scope = Fusion.scoped({
	Value = Fusion.Value,
	Computed = Fusion.Computed,
	Observer = Fusion.Observer,
})
local previewingFuse = fuseState(scope, "temp", "PreviewingRoles")
local roleInfoFuse = fuseState(scope, "everyone", "RoleInfo")
local endLoading: Fusion.Value<{[string]: boolean}> = scope:Value({})
local activeCard: {Disconnect: (any?) -> ()}? = nil
local activeFingerprint = ""
local endBusy = false


-- LOCAL FUNCTIONS
local function roleNamesLabel(keys: {string}): string
	local roleInfo = Fusion.peek(roleInfoFuse)
	local quoted: {string} = {}
	for _, key in keys do
		local entry = if typeof(roleInfo) == "table" then (roleInfo :: any)[key] else nil
		local name = if typeof(entry) == "table" and typeof((entry :: any).name) == "string"
			then (entry :: any).name
			else key
		table.insert(quoted, `"{name}"`)
	end
	return table.concat(quoted, ", ")
end

local function onCardAction(actionType: string, buttonId: string)
	if actionType ~= "button" or buttonId ~= "endPreview" or endBusy then
		return
	end
	endBusy = true
	endLoading:set({endPreview = true})
	task.spawn(function()
		local clearRemote: any = Remote.get("ClearPreviewingRoles")
		if clearRemote then
			clearRemote:invokeServerAsync()
		end
		endBusy = false
		endLoading:set({})
	end)
end

local function refreshCard()
	local list = Fusion.peek(previewingFuse)
	local keys: {string} = if typeof(list) == "table" then list :: {string} else {}
	if #keys == 0 then
		activeFingerprint = ""
		if activeCard then
			activeCard.Disconnect()
			activeCard = nil
		end
		return
	end
	-- Same keys means the card is already right, so don't flicker it
	local fingerprint = table.concat(keys, ",")
	if fingerprint == activeFingerprint and activeCard then
		return
	end
	activeFingerprint = fingerprint
	if activeCard then
		activeCard.Disconnect()
	end
	activeCard = Prompt.action(`You're previewing {roleNamesLabel(keys)}`, {
		title = "Role Preview",
		icon = Icons.Pages.Roles,
		duration = 0,
		dismissable = false,
		buttons = {{id = "endPreview", label = "Exit Preview"}},
		buttonLoadingState = endLoading,
		onAction = onCardAction,
	} :: any)
end


-- SETUP
scope:Observer(previewingFuse):onChange(refreshCard)
refreshCard()


return PreviewController
