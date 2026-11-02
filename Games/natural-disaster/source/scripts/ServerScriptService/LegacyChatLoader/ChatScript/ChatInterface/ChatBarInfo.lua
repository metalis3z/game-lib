-- // Tracks miscellaneous chat bar information.

local ChatBarInfo = {}

export type chatBarStateType = {
	focused: boolean,
	text: string,
}

local chatBarState: chatBarStateType = {
	focused = false,
	text = "",
}

function ChatBarInfo.get()
	return chatBarState
end

function ChatBarInfo.set(property: string, value: any)
	if chatBarState[property] == value then
		return
	end
	chatBarState[property] = value
end

return ChatBarInfo