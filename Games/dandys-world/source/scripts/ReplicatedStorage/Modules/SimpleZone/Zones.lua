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
-- CQMlC0FjdGl2ZVpvbmVzDHJlZ2lzdGVyWm9uZQ5kZXJlZ2lzdGVyWm9uZQxRdWVyeU9wdGlvbnMRVGhyb3R0bGluZ0VuYWJsZWQCb3MFY2xvY2sLX2xhc3RVcGRhdGUOVXBkYXRlSW50ZXJ2YWwIRmlyZU1vZGUHT25FbnRlcgRCb3RoBE5vbmUGT25FeGl0FEluU2VwZXJhdGVRdWVyeVNwYWNlC193b3JsZE1vZGVsC19xdWVyeVNwYWNlB2R5bmFtaWMFdGFibGUGY3JlYXRlCHJlcGxpY2FzBWluZGV4BkNGcmFtZQRFbnVtDEJ1bGtNb3ZlTW9kZRFGaXJlQ0ZyYW1lQ2hhbmdlZApCdWxrTW92ZVRvC1F1ZXJ5UGFyYW1zBlVwZGF0ZQRnYW1lClJ1blNlcnZpY2UKR2V0U2VydmljZQZzY3JpcHQGUGFyZW50D1RvdGFsWm9uZVZvbHVtZQ5Qb3N0U2ltdWxhdGlvbgdDb25uZWN0AAQDAgEAAAcEAAAFAg8EBfsCAABNAgI3AAAAAGoBAgCCAAEAAQMBAA8CARgAAAAAARAAAAAAAwEBAAAABvsBAABNAQE3AAAAAMYCAABqAgEAggABAAEDAQATAwEYAAAAAAABFAAAAAATAQEAAABg+wEAAE0BATcAAAAAxgIAAMYDAABkAVcATQYF0QEAAABNBwb8AgAAAA4HDACkBwUAABAwgJ8HAQJNCQS4BgAAACYIBwlNCQZrBwAAALcISQAJAAAAMAcEuAYAAABNCAbWCAAAAPAIBgAJAAAAqQcAAE0IBtYIAAAA8AgHAAoAAIBNCAbWCAAAAPAIAgALAACAqQcAAakHAQBNCQbWCAAAAPAJBgAMAAAAqQgAAE0JBtYIAAAA8AkHAAoAAIBNCQbWCAAAAPAJAgALAACAqQgAAakIAQBNCQZqDQAAAA4JHgBNCQQSDgAAAE0KBPYPAAAATQsKUxAAAACkDBMAAEgQgU0OCxEUAAAAHA0OAJ8MAgJNDQsCFQAAAMYOAADGDwAAZA0DAE0SEYUWAAAAahIMEG4N/P8CAAAATQ8LERQAAABSEAwApBEaABlgcMG8DQnDGwAAAJ8NBQFNCwVwHAAAAFIMBwBSDQgAvAkEJh0AAACfCQUBbgGo/wIAAACCAAEAHgMBAwQDBQMGAwcEABAwgAMIAwkDCgMLAwwDDQMOAw8DEAMRAxIDEwMUBABIEIEDFQMWAxcDGAMZAxoEGWBwwQMbAxwDHQAXAAEYAAAAAAAAAQACAAABAAABAAAAAAAAAwADAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAACAAABAAEAAQACAAAAAAACAAAAAAEAAP8AAwAAAAAAAAADAAAAAAAA5QAdGAAAAAAGAAABAgAgowAAAKQAAQAAAABAbwICALwAABYDAAAAnwADAqQBBQAAAEBATQEBJAYAAADiAgoA/wMAAAAAAAAwAwI3BwAAAMADCwASAAIAMAMCwgwAAADAAw0AEgACADADAo8OAAAATQMAtg8AAADABRAAEgACALwDA8cRAAAAnwMDAYICAgASAx4EAAAAQAMfAyADIQQAAEBAAyIDAQMjAgAAAAAAAAAACAIH/////wgJAAAABgADAgYBAwMDJAYCAyUDAAECAQABGAAAAAAAAAACAAAABwEAAAAEAAAABAAAAAQAAAAAAAAgAQAAAAADSR5zKg+KP+S6EQX9VcsDfDkGZF572hkr

-- https://lua.expert/
local RunService = game:GetService("RunService")
local _ = script.Parent
local t = {
	TotalZoneVolume = 0,
	ActiveZones = {}
}

function t.registerZone(p1, p2) --[[ registerZone | Line: 15 | Upvalues: t (copy) ]]
	t.ActiveZones[p1] = p2
end
function t.deregisterZone(p1) --[[ deregisterZone | Line: 19 | Upvalues: t (copy) ]]
	t.ActiveZones[p1] = nil
end
RunService.PostSimulation:Connect(function(p1) --[[ Line: 23 | Upvalues: t (copy) ]]
	for v3, v4 in t.ActiveZones do
		local v1, v2
		local QueryOptions = v4.QueryOptions
		local v5, v6, v7

		if QueryOptions.ThrottlingEnabled then
			local v8 = os.clock()

			if not (v8 - v3._lastUpdate < QueryOptions.UpdateInterval) then
				v3._lastUpdate = v8
				v1 = if QueryOptions.FireMode == "OnEnter" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false
				v2 = if QueryOptions.FireMode == "OnExit" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false

				if QueryOptions.InSeperateQuerySpace then
					v5 = v3._worldModel
					v6 = v3._querySpace.dynamic
					v7 = table.create(#v6.replicas)

					for v9, v10 in v6.index do
						v7[v9] = v10.CFrame
					end

					v5:BulkMoveTo(v6.replicas, v7, Enum.BulkMoveMode.FireCFrameChanged)
				end

				v3:Update(v4.QueryParams, v1, v2)
			end
		else
			v1 = if QueryOptions.FireMode == "OnEnter" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false
			v2 = if QueryOptions.FireMode == "OnExit" or QueryOptions.FireMode == "Both" then if QueryOptions.FireMode == "None" then false else true else false

			if QueryOptions.InSeperateQuerySpace then
				v5 = v3._worldModel
				v6 = v3._querySpace.dynamic
				v7 = table.create(#v6.replicas)

				for v9, v10 in v6.index do
					v7[v9] = v10.CFrame
				end

				v5:BulkMoveTo(v6.replicas, v7, Enum.BulkMoveMode.FireCFrameChanged)
			end

			v3:Update(v4.QueryParams, v1, v2)
		end
	end
end)

return t