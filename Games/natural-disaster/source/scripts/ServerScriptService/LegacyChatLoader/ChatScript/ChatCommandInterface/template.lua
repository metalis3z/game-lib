-- // The basic template for commands on the client. Meant to be used as a reference; should not actually be run.

local template = {}

template.alternateNames = {"temp"} -- Alternate names can be typed in place of the full command name.

function template.onSending(message: string): (boolean, boolean)
	-- Run when command is typed out into the chat bar and enter is pressed.
	return
		true, -- If false, client will not ask the server to execute this command.
		false -- If false, client will not send this message through the chat system.
end

function template.shouldEnableMessageMode(message: string): (boolean, string, string, Color3, any)
	-- Run when the player types anything in the chat bar after the command prefix and there is no message mode currently active.
	-- This function can be nil if this command does not need a message mode.
	return
		true, -- Whether the message mode should be enabled.
		"template", -- The name of the message mode.
		`Template`, -- The display text for the message mode label; appears in the chat bar.
		Color3.fromRGB(102, 14, 102), -- The color of the message mode label.
		"Hello, world!" -- Optional metadata to be sent alongside the chat message.
end

return template