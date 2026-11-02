--██   ██  █████   ██████ ██  ██  ███████ ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██   ██
--███████ ███████ ██      ████    █████   ██████ 
--██   ██ ██   ██ ██      ██ ██   ██      ██  ██ 
--██   ██ ██   ██  ██████ ██  ██  ███████ ██   ██
--
--██████  ███████  ██████  █████  ██   ██ ██████  ███ ██      ███████ ██████ 
--██   ██ ██      ██      ██   ██ ███ ███ ██   ██ ██  ██      ██      ██   ██
--██   ██ █████   ██      ██   ██ ██ █ ██ ██████  ██  ██      █████   ██████ 
--██   ██ ██      ██      ██   ██ ██   ██ ██      ██  ██      ██      ██  ██ 
--██████  ███████  ██████  █████  ██   ██ ██      ███ ███████ ███████ ██   ██
--[[
Hacker Decompiler 
Hacker Uncopylocked Discord Link : https://discord.gg/T7BXynvdMb
Owner of Hacker Decompiler: HackerKing
Owner of Hacker Uncopylocked: HackerKing
--]]


-- Bytecode (Base64):
-- CQMUBnNjcmlwdAZQYXJlbnQEZ2FtZQxUd2VlblNlcnZpY2UKR2V0U2VydmljZQlUd2VlbkluZm8DbmV3BEVudW0LRWFzaW5nU3R5bGUEUXVhZA9FYXNpbmdEaXJlY3Rpb24DT3V0BUZyYW1lCFBvc2l0aW9uBVVEaW0yBkNyZWF0ZQ1Ud2VlblBvc2l0aW9uBHRhc2sEd2FpdAJJbgABDQAAAQAAVKMAAACkAAEAAAAAQE0AACQCAAAApAEEAAAAMEBvAwUAvAEBFgYAAACfAQMCpAIJAAAgcICMAwEApAQNAAwsoMCkBRAADzigwIwG//+pBwEAjAgAAJ8CBwJNBQCdEQAAAFIGAgDiBxMApAgVAAAgQIGMCQAAjAoAAIwLAACMDAAAnwgFAjAIBzsSAAAAvAMBlhYAAACfAwUCTQQAnREAAACkBhUAACBAgYwHAACMCAAAjAkAAIwKAACfBgUCpAcQAA84oMCkCA0ADCygwIwJAQCpCgEAvAQEPRcAAACfBAcBpAQaAABkgIGMBQEAnwQCAU0EAJ0RAAAApAYVAAAgQIGMBwAAjAgAAG8JGwCMCgAAnwYFAqQHHQAcOKDApAgNAAwsoMCMCQEAqQoBALwEBD0XAAAAnwQHAaQEGgAAZICBjAUBAJ8EAgFIANP/ggABAB4DAQQAAABAAwIDAwQAADBAAwQDBQMGAwcEACBwgAMIAwkDCgQMLKDAAwsDDAQPOKDAAw0DDgUBEgMPBAAgQIEDEAMRAxIDEwQAZICBAgAAAAAAANA/AxQEHDigwAABAAEYAAAAAAACAAAAAAADAAEBAAEAAQEB+gkAAAAAAAAAAAAAAAAAAAADAAAAAAAAAAAAAAAAAAAAAAABAAAAAQAAAAAAAAAAAAAAAAAAAAAAAQAAAPwFAQAAAAAAgBgRFJkbeBP3ieSK7kCd0PAABmCy3HsV

-- https://lua.expert/
local v1 = script.Parent
local TweenService = game:GetService("TweenService")

TweenService:Create(v1.Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, -1, true, 0), {
	Position = UDim2.new(0, 0, 0, 0)
})

while true do
	v1.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 1, true)
	task.wait(1)
	v1.Frame:TweenPosition(UDim2.new(0, 0, 0.25, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quad, 1, true)
	task.wait(1)
end