--!strict

-- LOCAL
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local packages = modules.Parent.Packages
local Fusion = require(packages.Fusion)
local generateUID = require(modules.DataUtil.generateUID)
local peek = Fusion.peek
local Popups = {}
local scope = Fusion.scoped({Value = Fusion.Value})


-- TYPES 
export type Channel = "sidebar" | "top" | "centre"

export type ActionControl = {
	id: string,
	inputType: string,
	config: {[string]: any},
	value: any,
	label: string?,
}

export type ActionButton = {
	id: string,
	label: string,
	style: string?,
	confirm: boolean?,
}

export type Options = {
	title: string?,
	duration: number?,
	color: Color3?,
	icon: string?, -- overrides the kind's default header icon
	image: string?, -- centre cards render this beneath the body text
	imageRatio: number?, -- the image's width/height, so the card hugs it (16:9 assumed until known)
	roleBadges: {{name: string, color: Color3}}?, -- rendered as RoleBadge pills beneath the body text
	subtext: string?, -- dim italic line beneath the body and badges
	footerButtons: {{label: string, icon: string?, style: ("Primary" | "Neutral")?, onActivate: () -> ()}}?, -- action-style button row at the card's foot (client-set; each button spins while its onActivate runs then hides itself)
	dismissable: boolean?, -- false hides the close X so the card can't be swiped away
	onActivate: (() -> ())?,
	onClosed: (() -> ())?,
	keepOpenOnActivate: boolean?,
	userOpened: boolean?,
	allowReply: boolean?,
	fromServer: boolean?,
	onMute: (() -> ())?,
	muteState: Fusion.Value<boolean>?,
	countdown: number?,
	controls: {ActionControl}?,
	buttons: {ActionButton}?,
	clientButtons: {{label: string, style: string?, onActivate: () -> ()}}?,
	progressScale: number?,
	toggleable: boolean?,
	state: string?,
	actionState: Fusion.Value<string>?,
	buttonLoadingState: Fusion.Value<{[string]: boolean}>?,
	controlValuesState: Fusion.Value<{[string]: any}>?, -- server pushed control values, applied when a change is rejected
	onAction: ((actionType: string, id: string, value: any) -> ())?,
	fields: {string}?,
	voteConfig: {[string]: any}?, -- voting or results body spec, rendered by VoteBody
	votePreview: {[string]: any}?,
	fromUserId: (number | string)?,
	fromUserName: string?,
	fromUserImage: string?,
	fromUserDisplayName: string?,
	fromUserTopRole: string?,
	fromUserTopRoleColor: Color3?,
}

export type Entry = {
	id: string,
	channel: Channel,
	kind: string, -- info/success/warn/error/alert/message/hint
	text: string,
	options: Options?,
	duration: number, -- if less than 0, then it stays up until dismissed
	dismissRequested: Fusion.Value<boolean>,
	paused: Fusion.Value<boolean>,
	exiting: Fusion.Value<boolean>,
	settled: Fusion.Value<boolean>,
	size: Fusion.Value<Vector2>,
}

export type Handle = {
	Destroy: (any?) -> (),
	Disconnect: (any?) -> (),
	disconnect: (any?) -> (),
}


-- LOCAL
local lists: {[Channel]: Fusion.Value<{Entry}>} = {
	sidebar = scope:Value({}),
	top = scope:Value({}),
	centre = scope:Value({}),
}


-- LOCAL FUNCTIONS
local function defaultDuration(channel: Channel, text: string): number
	-- Centre is full-read so it lingers longer
	if channel == "centre" then
		return math.clamp(6 + 0.1 * #text, 6, 20)
	end
	return math.clamp(4 + 0.0625 * #text, 4, 10)
end


-- PUBLIC FUNCTIONS
-- A reactive value that needs to outlive a single popup
function Popups.value<T>(default: T): Fusion.Value<T>
	return scope:Value(default)
end

function Popups.toggle(value: Fusion.Value<boolean>)
	value:set(not peek(value))
end

function Popups.getList(channel: Channel): Fusion.Value<{Entry}>
	return lists[channel]
end

function Popups.pull(channel: Channel, id: string)
	local list = lists[channel]
	if not list then return end
	local current = peek(list)
	for index, entry in current do
		if entry.id == id then
			local next = table.clone(current)
			table.remove(next, index)
			list:set(next)
			local onClosed = entry.options and entry.options.onClosed
			if typeof(onClosed) == "function" then
				task.spawn(onClosed)
			end
			return
		end
	end
end

function Popups.push(channel: Channel, params: {kind: string, text: string, options: Options?}): Handle
	local list = lists[channel]
	local id = generateUID(10)
	local opts = params.options
	local rawDuration = if opts then opts.duration else nil
	local duration: number = if typeof(rawDuration) == "number"
		then rawDuration
		else defaultDuration(channel, params.text)

	local entry: Entry = {
		id = id,
		channel = channel,
		kind = params.kind,
		text = params.text,
		options = params.options,
		duration = duration,
		dismissRequested = scope:Value(false),
		paused = scope:Value(false),
		exiting = scope:Value(false),
		settled = scope:Value(false),
		size = scope:Value(Vector2.zero),
	}

	local current = peek(list)
	local next = table.clone(current)
	table.insert(next, entry)
	list:set(next)

	local function requestDismiss()
		entry.dismissRequested:set(true)
	end

	local handle: Handle = {
		Destroy = requestDismiss,
		Disconnect = requestDismiss,
		disconnect = requestDismiss,
	}
	return handle
end


return Popups
