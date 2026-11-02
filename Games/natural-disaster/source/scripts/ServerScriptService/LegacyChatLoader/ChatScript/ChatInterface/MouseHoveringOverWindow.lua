-- // Tracks whether the mouse is hovering over the chat window.

local MouseHoveringOverWindow = {}

local isHovering: boolean = false

function MouseHoveringOverWindow.get()
	return isHovering
end

function MouseHoveringOverWindow.set(newState: boolean)
	if newState == isHovering then 
		return
	end
	isHovering = newState
end

return MouseHoveringOverWindow