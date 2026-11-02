-- // Creates individual chat messages in the chat window.

local TextService = game:GetService("TextService")
local Players = game:GetService("Players")
local Chat = game:GetService("Chat")
local Teams = game:GetService("Teams")

local Shared = Chat:WaitForChild("Shared")
local ChatConstants = require(Shared:WaitForChild("ChatConstants"))
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local ChatScript = script.Parent.Parent.Parent
local MessageMode = require(ChatScript.ChatInterface.MessageMode)

local localPlayer = Players.LocalPlayer

local Message = {}

local function getOverrideOrDefault(override: any, default: any)
	if override ~= nil then
		return override
	else
		return default
	end
end

function Message.create(
	textChatMessage: TextChatMessage,
	overrides: {
		SourceText: string?,
		SourceTextColor: Color3?,

		Font: Font?,
		TextSize: number?,
		MessageTextColor: Color3?,
	}?)

	local messageText: string
	local font: Font, textSize: number, messageTextColor: Color3
	local sourceText: string, sourceTextColor: Color3
	if overrides == nil then
		overrides = {}
	end

	local defaultMessageTextColor = ChatConstants.GuiColors.Text

	local speaker: Player?
	if textChatMessage.TextSource ~= nil then
		speaker = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)

		local speakerProperties = speaker.SpeakerProperties
		local chatColorObject: Color3Value = speakerProperties:FindFirstChild("ChatColor")
		if chatColorObject ~= nil then
			defaultMessageTextColor = chatColorObject.Value
		end
	end

	font = getOverrideOrDefault(overrides.Font, ChatConstants.Font)
	textSize = getOverrideOrDefault(overrides.TextSize, ChatConstants.TextSize)
	messageTextColor = getOverrideOrDefault(overrides.MessageTextColor, defaultMessageTextColor)

	sourceText = overrides.SourceText
	sourceTextColor = overrides.SourceTextColor

	if textChatMessage.Status == Enum.TextChatMessageStatus.TextFilterFailed then
		messageText = "[ Failed to filter message ]"
	else
		messageText = textChatMessage.Text
	end

	-- Gui creation
	local frame = Instance.new("Frame")
	frame.Name = textChatMessage.MessageId
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.new(1, 0, 0, 18)
	frame.AutomaticSize = Enum.AutomaticSize.Y

	local messageLabel = Instance.new("TextLabel")
	messageLabel.Name = "MessageLabel"
	messageLabel.BackgroundTransparency = 1
	messageLabel.ClipsDescendants = true
	messageLabel.Font = font
	messageLabel.TextSize = textSize
	messageLabel.Position = UDim2.fromOffset(8, 0)
	messageLabel.RichText = true
	messageLabel.Size = UDim2.new(1, -14, 0, 0)
	messageLabel.AutomaticSize = Enum.AutomaticSize.Y
	messageLabel.TextColor3 = messageTextColor
	messageLabel.TextStrokeTransparency = 0.75
	messageLabel.TextWrapped = true
	messageLabel.TextXAlignment = Enum.TextXAlignment.Left
	messageLabel.TextYAlignment = Enum.TextYAlignment.Top

	if textChatMessage.TextSource ~= nil or sourceText ~= nil then
		if textChatMessage.TextSource ~= nil then
			-- Use player's properties
			local textChannel = textChatMessage.TextChannel

			if sourceText == nil then
				if ChatConstants.UseDisplayNames then
					sourceText = string.format(ChatConstants.PlayerSourceCasing, speaker.DisplayName)
				else
					sourceText = string.format(ChatConstants.PlayerSourceCasing, speaker.Name)
				end
			end

			-- Add chat tags
			local chatTagsFolder = speaker.SpeakerProperties:FindFirstChild("Tags")
			if chatTagsFolder ~= nil then
				local tagList: {Color3Value} = chatTagsFolder:GetChildren()
				table.sort(tagList, function(a, b)
					local priorityA = a:GetAttribute("Priority") or 1
					local priorityB = b:GetAttribute("Priority") or 1

					return priorityA > priorityB
				end)

				for _,chatTagObject in tagList do
					local chatTag = string.format(ChatConstants.TagCasing, chatTagObject.Name)
					if not chatTagObject:GetAttribute("NoColor") then
						chatTag = `<font color="#{chatTagObject.Value:ToHex()}">{chatTag}</font>`
					end
					sourceText = `{chatTag} {sourceText}`
				end
			end

			if string.sub(textChannel.Name, 1, 7) == "Whisper" then
				local split = string.split(textChannel.Name, "/")
				local playerName1 = split[2]
				local playerName2 = split[3]

				local otherPlayerName
				if playerName1 == localPlayer.Name then
					otherPlayerName = playerName2
				elseif playerName2 == localPlayer.Name then
					otherPlayerName = playerName1
				end

				if otherPlayerName ~= nil then
					-- This is a whisper; add whisper tag
					local whisperTag
					if speaker == localPlayer then
						whisperTag = string.format(ChatConstants.SystemSourceCasing, `To {otherPlayerName}`)
					else
						whisperTag = string.format(ChatConstants.SystemSourceCasing, `From {speaker.Name}`)
					end
					whisperTag = `<font color="#ffffff">{whisperTag}</font>`
					sourceText = `{whisperTag} {sourceText}`
				end
			end

			if speaker.Team ~= nil then
				-- Use team color
				local teamColor3 = speaker.TeamColor.Color
				if sourceTextColor == nil then
					sourceTextColor = teamColor3
				end

				if string.sub(textChannel.Name, 1, 7) == "RBXTeam" then
					-- Add team tag
					local teamTag = string.format(ChatConstants.SystemSourceCasing, "Team")
					sourceText = `{teamTag} {sourceText}`

					-- Override message color with player's team color
					messageLabel.TextColor3 = teamColor3
				end
			else
				-- Use default color
				if sourceTextColor == nil then
					sourceTextColor = ChatUtil.getDefaultUsernameColor(speaker.Name)
				end
			end
		end

		local sourceLabel = Instance.new("TextButton")
		sourceLabel.Name = "SourceLabel"
		sourceLabel.BackgroundTransparency = 1
		sourceLabel.Font = font
		sourceLabel.TextSize = textSize
		sourceLabel.RichText = true
		sourceLabel.Selectable = false
		sourceLabel.TextColor3 = sourceTextColor
		sourceLabel.TextStrokeTransparency = 0.75
		sourceLabel.TextXAlignment = Enum.TextXAlignment.Left
		sourceLabel.TextYAlignment = Enum.TextYAlignment.Top
		sourceLabel.Parent = messageLabel
		sourceLabel.Text = sourceText

		local sourceLabelSize = TextService:GetTextSize(ChatUtil.removeRichTextTags(sourceLabel.Text), sourceLabel.TextSize, sourceLabel.Font, Vector2.new(math.huge, math.huge))
		sourceLabel.Size = UDim2.fromOffset(sourceLabelSize.X+1, sourceLabelSize.Y)

		if speaker ~= nil and speaker ~= localPlayer then
			sourceLabel.MouseButton1Down:Connect(function()
				if MessageMode.get() ~= nil then
					return
				end

				local chatGui = frame.Parent.Parent.Parent.Parent.Parent
				local chatBar: TextBox = chatGui.Frame.ChatBarParentFrame.Frame.BoxFrame.ChatBarFrame.ChatBar
				chatBar.Text = `{ChatConstants.CommandPrefix}whisper {speaker.Name}`
			end)
		end
	end

	if sourceText ~= nil then
		-- Add spacing for source text
		messageLabel.Text = `<font transparency = "1"><stroke transparency="1">{sourceText}</stroke></font> {messageText}`
	else
		messageLabel.Text = messageText
	end

	messageLabel.Parent = frame

	return frame
end

return Message