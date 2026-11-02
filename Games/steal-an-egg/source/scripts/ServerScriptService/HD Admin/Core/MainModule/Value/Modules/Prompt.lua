--!strict
--[[ 
This abstracts all networking for prompt-related popups on both server and client:
	> on SERVER: Prompt.info(player, text, options?)
	> on CLIENT: Prompt.info(text, options?)
--]]

-- LOCAL
local Prompt = {}
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserService = game:GetService("UserService")
local HttpService = game:GetService("HttpService")
local modules = script:FindFirstAncestor("MainModule").Value.Modules
local Remote = require(modules.Objects.Remote)
local promptRemote: Remote.Class? = nil
local dismissRemote: Remote.Class? = nil
local createConnection = require(modules.AssetUtil.createConnection)
local cachedPopups: any? = nil


-- LOCAL FUNCTIONS
local function getPopups()
	if cachedPopups == nil then
		local main = script:FindFirstAncestor("MainModule") :: any
		cachedPopups = require(main.Value.Controllers.UI.Util.Popups) :: any
	end
	return cachedPopups
end

local function ensureRemotes()
	if not promptRemote then
		promptRemote = Remote.new("Prompt", "Event")
	end
	if not dismissRemote then
		dismissRemote = Remote.new("PromptDismiss", "Event")
	end
end

local function addInUserInfo(options: any): any
	if typeof(options) ~= "table" then
		return options
	end
	local fromUserId = options.fromUserId
	if not fromUserId or options.fromUserName then
		return options
	end
	local getUserInfoAsync = require(modules.PlayerUtil.getUserInfoAsync)
	local success, info = getUserInfoAsync(fromUserId)
	if not success or typeof(info) ~= "table" then
		return options
	end
	options.fromUserName = info.userName
	options.fromUserImage = info.userImage
	options.fromUserDisplayName = info.userDisplayName
	local topRole = info.userTopRole
	if typeof(topRole) == "table" then
		options.fromUserTopRole = topRole.name
		options.fromUserTopRoleColor = topRole.color
	end
	return options
end

function Prompt.fireRaw(player: Player, promptType: string, text: string, options: any, promptId: string)
	ensureRemotes()
	if promptRemote then
		promptRemote:fireClient(player, promptType, text, options, promptId)
	end
end

function Prompt.dismissRaw(player: Player, promptId: string)
	ensureRemotes()
	if dismissRemote then
		dismissRemote:fireClient(player, promptId)
	end
end

function Prompt.addUserInfoAsync(options: any): any
	return addInUserInfo(options)
end

local function handleClient(promptType: PromptType, clientCallback: (text: string, options: PromptOptions?) -> (any), playerOrText: unknown, textOrOptions: unknown, potentialOptions: unknown?): Disconnect
	if RunService:IsClient() then
		local text = playerOrText :: any
		local options = textOrOptions :: any
		if typeof(text) ~= "string" then
			error("HD Admin: First argument must be a string (on the client)")
		end
		if options and typeof(options) ~= "table" then
			error("HD Admin: Second argument must be a PromptOptions table or empty (on the client)")
		end
		addInUserInfo(options)
		local noticeInstance = clientCallback(text, options)
		return createConnection(function()
			-- Destroy the client prompt object (stubs return nothing yet)
			if noticeInstance then
				noticeInstance:Destroy()
			end
		end)
	end
	local player = playerOrText
	if player == nil then
		-- Do nothing when disconnected as nothing was created in first place
		return createConnection(function() end)
	end
	if not (typeof(player) == "Instance" and player:IsA("Player")) then
		error("HD Admin: First argument must be a Player (on the server)")
	end
	local text = textOrOptions
	if typeof(text) ~= "string" then
		error("HD Admin: Second argument must be a string (on the server)")
	end
	local options = potentialOptions
	if options and typeof(options) ~= "table" then
		error("HD Admin: Third argument must be a PromptOptions table or empty (on the server)")
	end
	addInUserInfo(options)
	ensureRemotes()
	-- Tag this prompt so the client can find and dismiss exactly this one later
	local promptId = HttpService:GenerateGUID(false)
	if promptRemote then
		promptRemote:fireClient(player, promptType, text, options, promptId)
	end
	return createConnection(function()
		if dismissRemote and typeof(player) == "Instance" and (player :: Player).Parent then
			dismissRemote:fireClient(player :: Player, promptId)
		end
	end)
end


-- FUNCTIONS
function Prompt.info(...: Player? | string | PromptOptions?): Disconnect
	-- Sidebar notice with standard notify sound
	return handleClient("info", function(text, options)
		return getPopups().push("sidebar", {kind = "info", text = text, options = options})
	end, ...)
end

function Prompt.success(...: Player? | string | PromptOptions?): Disconnect
	-- Sidebar notice with success sound
	return handleClient("success", function(text, options)
		return getPopups().push("sidebar", {kind = "success", text = text, options = options})
	end, ...)
end

function Prompt.warn(...: Player? | string | PromptOptions?): Disconnect
	-- Sidebar notice with warn sound
	return handleClient("warn", function(text, options)
		return getPopups().push("sidebar", {kind = "warn", text = text, options = options})
	end, ...)
end

function Prompt.error(...: Player? | string | PromptOptions?): Disconnect
	-- Sidebar notice with error sound
	return handleClient("error", function(text, options)
		return getPopups().push("sidebar", {kind = "error", text = text, options = options})
	end, ...)
end

function Prompt.message(...: Player? | string | PromptOptions?): Disconnect
	-- Full screen centred ;message
	return handleClient("message", function(text, options)
		return getPopups().push("centre", {kind = "message", text = text, options = options})
	end, ...)
end

function Prompt.hint(...: Player? | string | PromptOptions?): Disconnect
	return handleClient("hint", function(text, options)
		return getPopups().push("top", {kind = "hint", text = text, options = options})
	end, ...)
end

function Prompt.privateMessage(...: Player? | string | PromptOptions?): Disconnect
	-- Sticky sidebar notice and clicking it opens the full message centre-screen
	return handleClient("privateMessage", function(text, options)
		local Popups = getPopups()
		local opts: any = options or {}
		if opts.duration == nil then opts.duration = 0 end
		opts.keepOpenOnActivate = true
		opts.title = "Private Message"
		local senderName = if opts.fromServer then "the server"
			else (opts.fromUserDisplayName or opts.fromUserName or "Someone")
		opts.onActivate = function()
			Popups.push("centre", {
				kind = "message",
				text = text,
				options = {
					title = `Private Message from {senderName}`,
					duration = 0,
					userOpened = true,
					-- The server has no reply target, so only player PMs get the reply box
					allowReply = opts.fromServer ~= true,
					fromServer = opts.fromServer,
					fromUserId = opts.fromUserId,
					fromUserName = opts.fromUserName,
					fromUserImage = opts.fromUserImage,
					fromUserDisplayName = opts.fromUserDisplayName,
					fromUserTopRole = opts.fromUserTopRole,
					fromUserTopRoleColor = opts.fromUserTopRoleColor,
				},
			})
		end
		return Popups.push("sidebar", {kind = "privateMessage", text = text, options = opts})
	end, ...)
end

function Prompt.alert(...: Player? | string | PromptOptions?): Disconnect
	-- Sticky alert notice that loops a sound and opens a full message on click
	return handleClient("alert", function(text, options)
		local Popups = getPopups()
		local opts: any = options or {}
		opts.duration = 0 -- sticky, no expiry
		opts.keepOpenOnActivate = true
		opts.title = "Alert"
		local muted = Popups.value(false)
		opts.muteState = muted
		opts.onMute = function() Popups.toggle(muted) end
		opts.onActivate = function()
			Popups.push("centre", {
				kind = "alert",
				text = text,
				options = {
					title = "Alert",
					duration = 0,
					userOpened = true,
					fromServer = opts.fromServer,
					muteState = muted,
					onMute = function() Popups.toggle(muted) end,
					fromUserId = opts.fromUserId,
					fromUserName = opts.fromUserName,
					fromUserImage = opts.fromUserImage,
					fromUserDisplayName = opts.fromUserDisplayName,
					fromUserTopRole = opts.fromUserTopRole,
					fromUserTopRoleColor = opts.fromUserTopRoleColor,
				},
			})
		end
		return Popups.push("sidebar", {kind = "alert", text = text, options = opts})
	end, ...)
end

function Prompt.vote(...: Player? | string | PromptOptions?): Disconnect
	return handleClient("vote", function(text, options)
		local Popups = getPopups()
		local opts: any = options or {}
		local voteId = opts.voteId
		local fields = if typeof(opts.fields) == "table" then opts.fields else {}
		local duration = if typeof(opts.duration) == "number" then opts.duration else 20
		local endTime = os.clock() + duration
		local votedIndex = Popups.value(nil :: number?)
		local centreHandle: any = nil
		local function submitVote(optionIndex: number)
			votedIndex:set(optionIndex)
			if typeof(voteId) ~= "string" then
				return
			end
			task.spawn(function()
				local remote = Remote.get("VoteSubmit")
				if remote then
					remote:fireServer(voteId, optionIndex)
				end
			end)
		end
		opts.keepOpenOnActivate = true
		local existingOnClosed = opts.onClosed
		opts.onClosed = function()
			if typeof(voteId) == "string" and os.clock() < endTime then
				task.spawn(function()
					local remote = Remote.get("VoteSubmit")
					if remote then
						remote:fireServer(voteId, "dismiss")
					end
				end)
			end
			if existingOnClosed then
				existingOnClosed()
			end
		end
		opts.onActivate = function()
			local remaining = endTime - os.clock()
			if remaining <= 0.5 then
				return
			end
			centreHandle = Popups.push("centre", {
				kind = "vote",
				text = text,
				options = {
					duration = remaining,
					progressScale = remaining / duration,
					userOpened = true,
					fromServer = opts.fromServer,
					fromUserId = opts.fromUserId,
					fromUserName = opts.fromUserName,
					fromUserImage = opts.fromUserImage,
					fromUserDisplayName = opts.fromUserDisplayName,
					fromUserTopRole = opts.fromUserTopRole,
					fromUserTopRoleColor = opts.fromUserTopRoleColor,
					voteConfig = {
						mode = "voting",
						options = fields,
						votedIndex = votedIndex,
						endTime = endTime,
						onVote = submitVote,
						colorSeed = opts.colorSeed,
					},
				},
			})
		end
		local teaserHandle = Popups.push("sidebar", {kind = "vote", text = text, options = opts})
		local function destroy()
			if centreHandle then
				centreHandle.Destroy()
			end
			teaserHandle.Destroy()
		end
		return {
			Destroy = destroy,
			Disconnect = destroy,
		}
	end, ...)
end

function Prompt.voteResults(...: Player? | string | PromptOptions?): Disconnect
	return handleClient("voteResults", function(text, options)
		local Popups = getPopups()
		local opts: any = options or {}
		local results = if typeof(opts.results) == "table" then opts.results else {}
		local function buildCentreOptions()
			return {
				duration = 0,
				userOpened = true,
				fromServer = opts.fromServer,
				fromUserId = opts.fromUserId,
				fromUserName = opts.fromUserName,
				fromUserImage = opts.fromUserImage,
				fromUserDisplayName = opts.fromUserDisplayName,
				fromUserTopRole = opts.fromUserTopRole,
				fromUserTopRoleColor = opts.fromUserTopRoleColor,
				voteConfig = {
					mode = "results",
					results = results,
					colorSeed = opts.colorSeed,
				},
			}
		end
		local centreHandle: any = nil
		opts.duration = 0
		opts.keepOpenOnActivate = true
		opts.onActivate = function()
			centreHandle = Popups.push("centre", {kind = "voteResults", text = text, options = buildCentreOptions()})
		end
		local teaserHandle = Popups.push("sidebar", {kind = "voteResults", text = text, options = opts})
		local function destroy()
			if centreHandle then
				centreHandle.Destroy()
			end
			teaserHandle.Destroy()
		end
		return {
			Destroy = destroy,
			Disconnect = destroy,
		}
	end, ...)
end

function Prompt.action(...: Player? | string | PromptOptions?): Disconnect
	return handleClient("action", function(text, options)
		local Popups = getPopups()
		local opts: any = options or {}
		local votePreview = if typeof(opts.votePreview) == "table" then opts.votePreview else nil
		if not votePreview then
			return Popups.push("sidebar", {kind = "action", text = text, options = opts})
		end
		local question = if typeof(votePreview.question) == "string" then votePreview.question else text
		local fields = if typeof(votePreview.options) == "table" then votePreview.options else {}
		local previewDuration = if typeof(votePreview.duration) == "number" then votePreview.duration else 20
		local endTime = os.clock() + previewDuration
		local centreHandle: any = nil
		local function openDetails()
			local remaining = endTime - os.clock()
			if remaining <= 0.5 then
				return
			end
			centreHandle = Popups.push("centre", {
				kind = "vote",
				text = question,
				options = {
					duration = remaining,
					progressScale = remaining / previewDuration,
					userOpened = true,
					fromUserId = votePreview.fromUserId,
					fromUserName = votePreview.fromUserName,
					fromUserImage = votePreview.fromUserImage,
					fromUserDisplayName = votePreview.fromUserDisplayName,
					fromUserTopRole = votePreview.fromUserTopRole,
					fromUserTopRoleColor = votePreview.fromUserTopRoleColor,
					voteConfig = {
						mode = "voting",
						preview = true,
						options = fields,
						endTime = endTime,
						colorSeed = votePreview.colorSeed,
					},
				},
			})
		end
		opts.clientButtons = {
			{label = "View", onActivate = openDetails},
		}
		local cardHandle = Popups.push("sidebar", {kind = "action", text = text, options = opts})
		local function destroy()
			if centreHandle then
				centreHandle.Destroy()
			end
			cardHandle.Destroy()
		end
		return {
			Destroy = destroy,
			Disconnect = destroy,
		}
	end, ...)
end


-- TYPES
export type Disconnect = createConnection.Disconnect
export type PromptType = "info" | "success" | "warn" | "error" | "message" | "hint" | "privateMessage" | "alert" | "vote" | "voteResults" | "action"
export type PromptOptions = {
	title: string?,
	duration: number?,
	color: Color3?,
	icon: string?,
	openPage: string?,
	localEpoch: number?,
	openImage: {image: string, title: string?, ratio: number?}?,
	roleBadges: {{name: string, color: Color3}}?,
	subtext: string?,
	linkButtons: {{label: string, page: string?, profile: boolean?, unlockRole: string?, style: ("Primary" | "Neutral")?}}?,
	openProfile: boolean?,
	promptProduct: string?,
	openVetting: boolean?,
	dismissable: boolean?,
	fields: {string}?,
	voteId: string?,
	votePreview: {question: string, options: {string}, duration: number, fromUserId: number?, colorSeed: string?}?,
	results: {any}?,
	colorSeed: string?,
	countdown: number?,
	controls: {any}?,
	buttons: {any}?,
	equip: {label: string, onActivate: () -> ()}?,
	toggleable: boolean?,
	state: string?,
	fromServer: boolean?,
	fromUserId: number? | string?,
	fromUserName: string?,
	fromUserImage: string?,
	fromUserDisplayName: string?,
	fromUserTopRole: string?,
	fromUserTopRoleColor: Color3?,
}


return Prompt