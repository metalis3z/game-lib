-- // Tracks whether the window should be visible or transparent.

-- Fade in/out behavior is under GuiCreator.

local Chat = game:GetService("Chat")

local Shared = Chat:WaitForChild("Shared")
local ChatUtil = require(Shared:WaitForChild("ChatUtil"))

local WindowFocusedModule = {}

local windowFocused: boolean = true
local automaticDefocusThread: thread? = nil

local MouseHoveringOverWindow = require(script.Parent.MouseHoveringOverWindow)
local ChatBarInfo = require(script.Parent.ChatBarInfo)

local changedBindable = Instance.new("BindableEvent")
changedBindable.Name = "MessageModeChangedBindable"

function WindowFocusedModule.get()
	return windowFocused
end

function WindowFocusedModule.getBindable()
	return changedBindable
end

local function cancelScheduledUnfocus()
	if automaticDefocusThread ~= nil then
		task.cancel(automaticDefocusThread)
		automaticDefocusThread = nil
		-- ChatUtil.debugPrint(`Unfocus cancelled`)
	end
end

function WindowFocusedModule.set(newState: boolean)
	if newState == true and automaticDefocusThread ~= nil then
		cancelScheduledUnfocus()
	end
	if newState == windowFocused then 
		return
	end
	
	-- ChatUtil.debugPrint(if newState then "Window focused" else "Window unfocused")
	windowFocused = newState
	changedBindable:Fire(newState)
end

function WindowFocusedModule.scheduleUnfocus()
	cancelScheduledUnfocus()
	automaticDefocusThread = task.delay(4, function()
		WindowFocusedModule.set(false)
	end)
	-- ChatUtil.debugPrint(`Unfocus scheduled`)
end

function WindowFocusedModule.update()
	-- ChatUtil.debugPrint(MouseHoveringOverWindow.get())
	-- ChatUtil.debugPrint(ChatBarInfo.get().focused)
	if MouseHoveringOverWindow.get() == true or ChatBarInfo.get().focused then
		WindowFocusedModule.set(true)
	else
		WindowFocusedModule.scheduleUnfocus()
	end
end

function WindowFocusedModule.init()
	WindowFocusedModule.update()
end

return WindowFocusedModule