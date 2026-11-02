-- // Shared constants between the client and server.

local TextChatService = game:GetService("TextChatService")

local ChatConstants
ChatConstants = {
	-- Features
	DefaultChatEnabled = true, -- If false, the chat window will not be created.
	BubbleChatEnabled = true, -- If true, chat bubbles will appear when messages are sent.
	
	UseDisplayNames = false, -- If true, display names will be shown in chat instead of usernames.
	WindowResizeable = true,
	ShowWhenPlayerIsTyping = false, -- If true, a typing indicator will appear when a player types in the chat bar.
	AllowBlankMessages = false, -- If true, players will be allowed to send messages that only consist of whitespaces.

	BlacklistedCommands = {
		-- Commands in this list will be disabled for all players.
		"commandname1",
		"commandname2",
	},

	-- Debug
	Logging = false, -- If true, additional debug messages will be printed to the output.

	-- Channels
	DefaultChannel = "RBXGeneral",
	SystemMessageChannel = "RBXSystem",

	-- Hotkeys & prefixes
	ChatKey = Enum.KeyCode.Slash,
	CommandPrefix = "/",

	-- Messages
	SystemMessages = {
		Welcome = {
			General = `Chat '%s?' or '%shelp' for a list of chat commands.`,
			Team = "This is a private channel between you and your team members.",
		},

		CommandHelp = {
			-- All instances of "%s" will be replaced with the command prefix when displayed in the chat window.
			Intro = "These are the basic chat commands.",

			-- Index (word on the left side) must be identical to the command name.
			help = "%shelp or %s? : view all available chat commands.",
			whisper = "%swhisper <speaker> or %sw <speaker> : open private message channel with speaker.",
			c = "%sc <channel> : switch channel menu tabs.",
			join = "%sjoin <channel> or %sj <channel> : join channel.",
			leave = "%sleave <channel> or %sl <channel> : leave channel. (leaves current if none specified)",
			me = "%sme <text> : roleplaying command for doing actions.",
			mute = "%smute <speaker> : mute a speaker.",
			unmute = "%sunmute <speaker> : unmute a speaker.",
			team = "%steam <message> or %st <message> : send a team chat to players on your team.",
		},
	},

	-- GUIs
	DefaultChatWindowSizeScale = Vector2.new(0.4, 0.33),

	ChatWindowSizeBoundsPixels = {
		Minimum = Vector2.new(200, 100),
		Maximum = Vector2.new(1920, 1080),
	},

	GuiColors = {
		Background = Color3.new(0, 0, 0),
		TextBoxBackground = Color3.new(1, 1, 1),
		TextBoxText = Color3.new(0, 0, 0),
		Text = Color3.new(1, 1, 1),
		ErrorText = Color3.fromRGB(245, 50, 50),

		BubbleBackground = Color3.new(1, 1, 1),
		BubbleText = Color3.new(0.105882, 0.164706, 0.207843),
	},

	DefaultUsernameColors = { -- The username colors a player can be assigned when they are not on a team.
		Color3.new(253/255, 41/255, 67/255), -- BrickColor.new("Bright red").Color,
		Color3.new(1/255, 162/255, 255/255), -- BrickColor.new("Bright blue").Color,
		Color3.new(2/255, 184/255, 87/255), -- BrickColor.new("Earth green").Color,
		BrickColor.new("Bright violet").Color,
		BrickColor.new("Bright orange").Color,
		BrickColor.new("Bright yellow").Color,
		BrickColor.new("Light reddish violet").Color,
		BrickColor.new("Brick yellow").Color,
	},

	-- Text
	TextSize = 18,
	["Font"] = Enum.Font.SourceSansBold,

	BubbleTextSize = 24,
	BubbleFont = Enum.Font.SourceSans,

	MessageCharacterLimit = 200,
	MessageLogLimit = 100,

	PlayerSourceCasing = "[%s]:",
	SystemSourceCasing = "{%s}",
	MessageModeSourceCasing = "[%s]",
	TagCasing = "[%s]",
}

table.freeze(ChatConstants)

return ChatConstants