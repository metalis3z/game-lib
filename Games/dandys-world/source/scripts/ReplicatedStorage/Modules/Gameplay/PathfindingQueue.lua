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
-- CQMZBHdhcm49W1BhdGhmaW5kaW5nUXVldWVdIFF1ZXVlIGZ1bGwsIHByb2Nlc3NpbmcgcmVxdWVzdCBpbW1lZGlhdGVseQ1TbWFydFBhdGhmaW5kB21vbnN0ZXIGdGFyZ2V0BnlpZWxkcwdvcHRpb25zCXRpbWVzdGFtcAR0aWNrBXRhYmxlBmluc2VydAR0YXNrBXNwYXduDFByb2Nlc3NRdWV1ZRBRdWV1ZVBhdGhmaW5kaW5nBnJlbW92ZQZQYXJlbnQEd2FpdAxHZXRRdWV1ZVNpemUKQ2xlYXJRdWV1ZQdyZXF1aXJlBnNjcmlwdAlGb3JiaWRkZW4CQUkMV2FpdEZvckNoaWxkAAUJBAQAAAA++wUAABwEBQCMBTIAfQUOAAQAAACkBAEAAAAAQG8FAgCfBAIB+wQBAE0EBIMDAAAAUgUAAFIGAQBSBwIAUggDAJ8EBQGCAAEA+wUAABwEBQANBAwABAAAgPsEAgArBAkA+wQBAE0EBIMDAAAAUgUAAFIGAQBSBwIAUggDAJ8EBQGCAAEA+wUAAOIGCgAwAAbQBQAAADABBgwGAAAAMAIGbgcAAAAwAwbSCAAAAKQHDAAAALBAnwcBAjAHBp0JAAAAnjQFAwYAAACkBA8AADjQgJ8EAwH7BAIAKwQGAKQEEgAARACB+wUDAE0FBWQTAAAAnwQCAYIAAQAUAwEEAAAAQAMCAwMCAAAAAAAAAAADBAMFAwYDBwMIBQUFBgcICQMJBAAAsEADCgMLBAA40IADDAMNBABEAIEDDgARDwEYAAAAAAABAAAAAQAAAAAAAAABBAAAAAAAAQAAAAAAAAABBAABAAEAAQABAAEAAAAAAAD7AAAJAAEAAAAAAAITAAAAAAYAAwAAADCpAAEA3gAAAPsBAQAcAAEAjAEAAGABJwAAAAAApAACAAAEAID7AQEAjAIBAJ8AAwJNAQDQAwAAAA4BFABNAQDQAwAAAE0BASQEAAAADgEPAE0BAAwFAAAADgEMAPsBAgBNAQGDBgAAAE0CANADAAAATQMADAUAAABNBABuBwAAAE0FANIIAAAAnwEFAfsCAQAcAQIAjAIAAGACBQABAAAApAELAAAokIBvAgwAnwECAUgA1f+pAAAA3gAAAIIAAQANAwoDEAQABACAAwQDEQMFAwMDBgMHAwwDEgQAKJCAApqZmZmZmak/AC8OARgAAAIAAAAAAQAAAAADAAAAAAAAAAAAAAIAAAAAAAAAAAAAAAQAAAAAAQAAAPUPAAEwAAAAAAIAAQAAAAP7AQAAHAABAIIAAgAAAEUTARgAAABGAAAAAAEAAgAAAAb/AAAAAAAAAN4AAACpAAAA3gABAIIAAQAAAEoUARgAAAABAAFLAAAAAAcAAAECAC2jAAAA/wADAAAAAAD/AQAAAAAAAKkCAACkAwEAAAAAQKQEAwAAACBATQQEJAQAAABNBAQkBAAAAE0EBMkFAAAAbwYGALwEBNMHAAAAnwQDAJ8DAALZBAAAEgEB/xIAAwASAQL/EgAAADAEAP8IAAAA2QQBABIBAv8SAQH/EgADADAEAGQJAAAA2QQCABIBAf8wBACfCgAAANkEAwASAQH/EgEC/zAEAAsLAAAAwQEAAIIAAgAMAxUEAAAAQAMWBAAAIEADEQMXAxgDGQMPAw4DEwMUBAABAgMBAAEYAAQABwABAQAAAAAAAAAAAAAAAAAAAwAAAAAAAB4AAAAAABYAAAAFAAAAAAUAAQAAAAAEy9fb7enD9yT8DJo5W+fXC7vPzJn5E7Hs

-- https://lua.expert/
local t = {}
local t2 = {}
local v1 = false
local AI = require(script.Parent.Parent.Forbidden:WaitForChild("AI"))

function t.QueuePathfinding(p1, p2, p3, p4) --[[ QueuePathfinding | Line: 17 | Upvalues: t2 (ref), AI (copy), v1 (ref), t (copy) ]]
	if #t2 >= 50 then
		warn("[PathfindingQueue] Queue full, processing request immediately")
		AI.SmartPathfind(p1, p2, p3, p4)

		return
	end

	if #t2 == 0 and not v1 then
		AI.SmartPathfind(p1, p2, p3, p4)

		return
	end

	table.insert(t2, {
		monster = p1,
		target = p2,
		yields = p3,
		options = p4,
		timestamp = tick()
	})

	if v1 then
		return
	end

	task.spawn(t.ProcessQueue)
end
function t.ProcessQueue() --[[ ProcessQueue | Line: 47 | Upvalues: v1 (ref), t2 (ref), AI (copy) ]]
	v1 = true

	while #t2 > 0 do
		local v12 = table.remove(t2, 1)

		if v12.monster and (v12.monster.Parent and v12.target) then
			AI.SmartPathfind(v12.monster, v12.target, v12.yields, v12.options)
		end

		if not (#t2 > 0) then
			continue
		end

		task.wait(0.05)
	end

	v1 = false
end
function t.GetQueueSize() --[[ GetQueueSize | Line: 69 | Upvalues: t2 (ref) ]]
	return #t2
end
function t.ClearQueue() --[[ ClearQueue | Line: 74 | Upvalues: t2 (ref), v1 (ref) ]]
	t2 = {}
	v1 = false
end

return t