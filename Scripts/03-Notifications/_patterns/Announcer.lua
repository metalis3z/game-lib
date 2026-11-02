--!strict
-- Announcer (clean pattern) - ModuleScript in ReplicatedStorage, used by BOTH server and client.
-- Server sends announcements (one player, whole server, or every server); client shows them as a
-- top-of-screen banner, one after another (queued, never overlapping).
--
-- Credits / ideas taken from:
--   smash-egg-for-animals  GlobalAnnounceClient  (sender name + avatar headshot + text, pop-in with UIScale)
--   steal-a-brainrot       globalplayerannounce  (cross-server broadcast, skip own JobId to avoid doubles)
--   casino-lvah            Announcer             (fade in / hold / fade out banner)
--
-- Usage:
--   -- Server Script:
--   local Announcer = require(game.ReplicatedStorage.Announcer)
--   Announcer.StartServer({ crossServer = true })      -- call once
--   Announcer.ToAll("Double coins for 10 minutes!")
--   Announcer.ToPlayer(player, "You reached level 10!", { color = Color3.fromRGB(255, 220, 80) })
--   Announcer.ToAll(text, { sender = admin.DisplayName, userId = admin.UserId }) -- shows headshot
--   Announcer.ToAllServers("Event starts in 5 minutes!")  -- needs crossServer = true
--
--   -- LocalScript:
--   require(game.ReplicatedStorage.Announcer).StartClient()
--
-- Text is shown with RichText off on purpose so player-written text cannot inject tags.
-- Filter any player-written text on the server (TextService) before announcing it.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local REMOTE_NAME = "AnnouncerEvent"
local TOPIC = "Announcer_v1"
local DEFAULT_DURATION = 5

export type Options = {
	sender: string?,
	userId: number?,
	color: Color3?,
	duration: number?,
}

local Announcer = {}

---------------------------------------------------------------- shared
local function getRemote(): RemoteEvent
	if RunService:IsServer() then
		local existing = ReplicatedStorage:FindFirstChild(REMOTE_NAME)
		if existing and existing:IsA("RemoteEvent") then
			return existing
		end
		local remote = Instance.new("RemoteEvent")
		remote.Name = REMOTE_NAME
		remote.Parent = ReplicatedStorage
		return remote
	end
	return ReplicatedStorage:WaitForChild(REMOTE_NAME) :: RemoteEvent
end

-- Only plain, serialisable values cross the network.
local function pack(text: string, options: Options?): { [string]: any }
	local o = options or {}
	return {
		text = text,
		sender = o.sender,
		userId = o.userId,
		color = o.color,
		duration = o.duration,
	}
end

---------------------------------------------------------------- server
local serverStarted = false
local crossServerEnabled = false

function Announcer.StartServer(config: { crossServer: boolean? }?)
	assert(RunService:IsServer(), "StartServer must run on the server")
	if serverStarted then
		return
	end
	serverStarted = true
	getRemote()

	if config and config.crossServer then
		local MessagingService = game:GetService("MessagingService")
		local ok, err = pcall(function()
			MessagingService:SubscribeAsync(TOPIC, function(message)
				local data = message.Data
				if type(data) ~= "table" or data.jobId == game.JobId then
					return -- our own message: already shown locally
				end
				getRemote():FireAllClients({
					text = tostring(data.text),
					sender = data.sender,
					duration = data.duration,
				})
			end)
		end)
		crossServerEnabled = ok
		if not ok then
			warn("[Announcer] cross-server subscribe failed:", err)
		end
	end
end

function Announcer.ToPlayer(player: Player, text: string, options: Options?)
	getRemote():FireClient(player, pack(text, options))
end

function Announcer.ToAll(text: string, options: Options?)
	getRemote():FireAllClients(pack(text, options))
end

-- Shows here immediately, then publishes to every other live server.
-- Color3 cannot go through MessagingService, so only text/sender/duration are sent.
function Announcer.ToAllServers(text: string, options: Options?)
	Announcer.ToAll(text, options)
	if not crossServerEnabled then
		warn("[Announcer] ToAllServers called without StartServer({crossServer = true})")
		return
	end
	local o = options or {}
	task.spawn(function()
		local MessagingService = game:GetService("MessagingService")
		local ok, err = pcall(function()
			MessagingService:PublishAsync(TOPIC, {
				text = text,
				sender = o.sender,
				duration = o.duration,
				jobId = game.JobId,
			})
		end)
		if not ok then
			warn("[Announcer] publish failed:", err)
		end
	end)
end

---------------------------------------------------------------- client
local queue: { { [string]: any } } = {}
local showing = false
local banner: Frame? = nil

local function buildBanner(): (Frame, ImageLabel, TextLabel, TextLabel, UIScale)
	local gui = Instance.new("ScreenGui")
	gui.Name = "Announcer"
	gui.ResetOnSpawn = false
	gui.DisplayOrder = 50
	gui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

	local frame = Instance.new("Frame")
	frame.Name = "Banner"
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0, 70)
	frame.Size = UDim2.fromOffset(0, 56)
	frame.AutomaticSize = Enum.AutomaticSize.X
	frame.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
	frame.BackgroundTransparency = 0.25
	frame.Visible = false
	frame.Parent = gui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)
	local pad = Instance.new("UIPadding")
	pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 12), UDim.new(0, 16)
	pad.Parent = frame
	local row = Instance.new("UIListLayout")
	row.FillDirection = Enum.FillDirection.Horizontal
	row.VerticalAlignment = Enum.VerticalAlignment.Center
	row.SortOrder = Enum.SortOrder.LayoutOrder
	row.Padding = UDim.new(0, 10)
	row.Parent = frame
	local scale = Instance.new("UIScale")
	scale.Parent = frame

	local avatar = Instance.new("ImageLabel")
	avatar.LayoutOrder = 1
	avatar.Size = UDim2.fromOffset(44, 44)
	avatar.BackgroundTransparency = 1
	avatar.Parent = frame
	Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

	local function text(order: number, font: Enum.Font, color: Color3): TextLabel
		local l = Instance.new("TextLabel")
		l.LayoutOrder = order
		l.BackgroundTransparency = 1
		l.AutomaticSize = Enum.AutomaticSize.X
		l.Size = UDim2.fromOffset(0, 44)
		l.Font = font
		l.TextSize = 24
		l.TextColor3 = color
		l.RichText = false
		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 2
		stroke.Parent = l
		l.Parent = frame
		return l
	end
	local senderLabel = text(2, Enum.Font.GothamBlack, Color3.fromRGB(255, 216, 74))
	local bodyLabel = text(3, Enum.Font.GothamBold, Color3.new(1, 1, 1))
	local sizeLimit = Instance.new("UISizeConstraint")
	sizeLimit.MaxSize = Vector2.new(700, math.huge)
	sizeLimit.Parent = bodyLabel
	bodyLabel.TextWrapped = true

	return frame, avatar, senderLabel, bodyLabel, scale
end

local function showNext()
	if showing then
		return
	end
	showing = true
	local frame, avatar, senderLabel, bodyLabel, scale = buildBanner()
	banner = frame

	while #queue > 0 do
		local data = table.remove(queue, 1) :: { [string]: any }

		bodyLabel.Text = tostring(data.text)
		bodyLabel.TextColor3 = typeof(data.color) == "Color3" and data.color or Color3.new(1, 1, 1)
		senderLabel.Visible = type(data.sender) == "string"
		senderLabel.Text = senderLabel.Visible and (data.sender .. ":") or ""
		avatar.Visible = type(data.userId) == "number" and data.userId > 0
		avatar.Image = ""
		if avatar.Visible then
			task.spawn(function()
				local ok, img = pcall(Players.GetUserThumbnailAsync, Players, data.userId,
					Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
				if ok then
					avatar.Image = img
				end
			end)
		end

		frame.Visible = true
		scale.Scale = 0
		TweenService:Create(scale, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
		task.wait(tonumber(data.duration) or DEFAULT_DURATION)
		local out = TweenService:Create(scale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 0 })
		out:Play()
		out.Completed:Wait()
		frame.Visible = false
	end

	if frame.Parent then
		(frame.Parent :: Instance):Destroy()
	end
	banner = nil
	showing = false
end

local clientStarted = false

function Announcer.StartClient()
	assert(RunService:IsClient(), "StartClient must run on the client")
	if clientStarted then
		return
	end
	clientStarted = true
	getRemote().OnClientEvent:Connect(function(data)
		if type(data) ~= "table" or data.text == nil then
			return
		end
		table.insert(queue, data)
		task.spawn(showNext)
	end)
end

-- Client-side local announcement (no server round trip), e.g. for tutorials.
function Announcer.ShowLocal(text: string, options: Options?)
	table.insert(queue, pack(text, options))
	task.spawn(showNext)
end

return Announcer
