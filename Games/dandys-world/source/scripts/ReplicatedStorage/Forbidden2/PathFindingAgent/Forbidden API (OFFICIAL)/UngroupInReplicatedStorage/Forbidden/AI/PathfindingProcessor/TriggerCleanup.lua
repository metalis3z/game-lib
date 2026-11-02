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
-- CQMOE0RlbGV0ZVZpc3VhbGl6YXRpb24OVHJpZ2dlckNsZWFudXAWVHJpZ2dlckNsZWFudXBUeXBlSGVscAZzY3JpcHQGUGFyZW50B3JlcXVpcmUCQUkNQ29uZmlnSGFuZGxlcgxEaXJlY3RNb3ZlVG8UUGF0aGZpbmRpbmdQcm9jZXNzb3IOV2F5cG9pbnRMb29wZXINVmlzdWFsaXphdGlvbhZXYXlwb2ludHNWaXN1YWxpemF0aW9uBkNvbW1vbgACAwEFAAAGAwAABQEHGvsBAABNAQEIAAAAAFICAACfAQIB+wEBAE0BAX8BAAAAUgIAAJ8BAgH7AQIATQEBfwEAAABSAgAAnwECAfsBAwBNAQF/AQAAAFICAACfAQIB+wEEAE0BAbsCAAAAUgIAAJ8BAgGCAAEAAwMBAwIDAwAYAAEYAAAAAAACAAAAAAIAAAAAAgAAAAACAAAAAAIaAAAAAAgAAAECADmjAAAApAABAAAAAEBNAAAkAgAAAE0AACQCAAAATQAAJAIAAACkAQQAAAAwQE0CAEgFAAAATQIC4gYAAACfAQICpAIEAAAAMEBNAwBIBQAAAE0DA1IHAAAAnwICAqQDBAAAADBATQQASAUAAABNBATpCAAAAE0EBGAJAAAAnwMCAqQEBAAAADBATQUASAUAAABNBQUlCgAAAE0FBZ8LAAAAnwQCAqQFBAAAADBATQYAcwwAAACfBQIC/wYBAAAAAADABw0AEgAEABIAAQASAAMAEgACABIABQAwBwZ/DgAAAIIAAQAPAwQEAAAAQAMFAwYEAAAwQAMHAwgDCQMKAwsDDAMNAw4GAAMCAQABAAEYAAwAAAAAAAAAAQAAAAAAAAEAAAAAAAABAAAAAAAAAAABAAAAAAAAAAABAAAAAAQAAgAAAAAAAAANAQAAAAABA0L8uVHHRnqXWGvUdUMTNXNa680xhpa4

-- https://lua.expert/
local v1 = script.Parent.Parent.Parent
local ConfigHandler = require(v1.AI.ConfigHandler)
local DirectMoveTo = require(v1.AI.DirectMoveTo)
local WaypointLooper = require(v1.AI.PathfindingProcessor.WaypointLooper)
local WaypointsVisualization = require(v1.AI.Visualization.WaypointsVisualization)
local Common = require(v1.Common);

({}).TriggerCleanup = function(p1) --[[ Line: 24 | Upvalues: WaypointsVisualization (copy), ConfigHandler (copy), WaypointLooper (copy), DirectMoveTo (copy), Common (copy) ]]
	WaypointsVisualization.DeleteVisualization(p1)
	ConfigHandler.TriggerCleanup(p1)
	WaypointLooper.TriggerCleanup(p1)
	DirectMoveTo.TriggerCleanup(p1)
	Common.TriggerCleanupTypeHelp(p1)
end