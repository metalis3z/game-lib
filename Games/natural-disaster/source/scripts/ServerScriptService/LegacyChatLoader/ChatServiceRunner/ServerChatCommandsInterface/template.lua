-- // The basic template for commands on the server. Meant to be used as a reference; should not actually be run.

local template = {}

--[[
IMPORTANT REMINDER:
The only sanity check done before this was making sure the player
had permission to send a message to the channel.

Any other required permissions still need to be checked here.
]]

function template.onFired(player: Player, args: {string}?, metadataAfterCommandName: string?): {
	text: string,
	textColor: Color3?,
	}?
	-- Triggered when a remote event is fired with this command specified.
	-- This function can be deleted if you don't need this behavior.
	
	-- Optional return value displays a system message to the player.
	return {
		text = `Successfully ran command! Arguments: {table.concat(args, ", ")} | Metadata: {metadataAfterCommandName}`,
		textColor = Color3.new(0, 1, 0),
	}
end

function template.metadataTriggeredShouldDeliverCallback(textChatMessage: TextChatMessage, targetTextSource: TextSource, metadataAfterCommandName: string): boolean
	-- Triggered on ShouldDeliverCallback when a message contains metadata such as "commandname:data".
	-- This function can be deleted if you don't need this behavior.
	
	return true -- Return value decides if the message should be sent to this player. See ShouldDeliverCallbackRegistration for more information.
end

return template