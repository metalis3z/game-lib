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
-- CQMVD0dldEFjdGl2ZUNvbmZpZwxEaXJlY3RNb3ZlVG8IVHJhY2tpbmcORHluYW1pY1JldHJhY2sGTW92ZVRvFkdldFJldHJhY2tUaW1lRnVuY3Rpb24ITWF4VGltZXIITWluVGltZXIEbWF0aAVjbGFtcAhQYXRoZmluZAR3YXJuFXRoaXMgc2hvdWxkIG5vdCBvY2N1chVTaG91bGRSZXRyYWNrRnVuY3Rpb24Gc2NyaXB0BlBhcmVudAdyZXF1aXJlAkFJDUNvbmZpZ0hhbmRsZXIWR2V0RHluYW1pY1JldHJhY2tUaW1lcg1TaG91bGRSZXRyYWNrAAMJAwEAAAgFAAAFAwcHA2n7AwAATQMDOwAAAABSBAAAnwMCAvACLgABAACATQQD3gIAAABNBATaAwAAAE0EBHcEAAAATQQEVAUAAABSBQAAUgYBAJ8EAwJHBAoAAAAAgE0FA94CAAAATQUF2gMAAABNBQV3BAAAAE0FBYAGAAAAggUCAE0HA94CAAAATQcH2gMAAABNBwd3BAAAAE0HB/sHAAAATQgD3gIAAABNCAjaAwAAAE0ICHcEAAAATQgIgAYAAAA0LgQEBwgAAFIGBACkBQoAACSAgJ8FBAKCBQIA8AIuAAsAAIBNBAPeAgAAAE0EBNoDAAAATQQEKwsAAABNBARUBQAAAFIFAABSBgEAnwQDAkcECgAAAACATQUD3gIAAABNBQXaAwAAAE0FBSsLAAAATQUFgAYAAACCBQIATQcD3gIAAABNBwfaAwAAAE0HBysLAAAATQcH+wcAAABNCAPeAgAAAE0ICNoDAAAATQgIKwsAAABNCAiABgAAADQuBAQHCAAAUgYEAKQFCgAAJICAnwUEAoIFAgCkBA0AAADAQG8FDgCfBAIBjAQBAIIEAgAPAwEDAgMDAwQDBQMGAwcDCAMJAwoEACSAgAMLAwwEAADAQAMNABsAARgAAAAAAAIAAQAAAAAAAAAAAAABAAEAAAAAAAAAAAQAAAAAAAAAAQAAAAAAAAAAAAD9AAAABwABAAAAAAAAAAAAAAEAAQAAAAAAAAAABAAAAAAAAAABAAAAAAAAAAAAAP0AAAAHAAAAAQAcAAAAAAcDAQAACAUAAAUDBwcDPfsDAABNAwM7AAAAAFIEAACfAwIC8AIYAAEAAIBNBAPeAgAAAE0EBNoDAAAATQQEdwQAAABNBAQYBQAAAFIFAABSBgEAnwQDAkcECgAAAACATQUD3gIAAABNBQXaAwAAAE0FBXcEAAAATQUFgAYAAACCBQIAggQCAPACGAAHAACATQQD3gIAAABNBATaAwAAAE0EBCsHAAAATQQEGAUAAABSBQAAUgYBAJ8EAwJHBAoAAAAAgE0FA94CAAAATQUF2gMAAABNBQUrBwAAAE0FBYAGAAAAggUCAIIEAgCkBAkAAACAQG8FCgCfBAIBqQQAAIIEAgALAwEDAgMDAwQDBQMOAwcDCwMMBAAAgEADDQA/AAEYAAAAAAAEAAEAAAAAAAAAAAAAAQABAAAAAAAAAAACAwABAAAAAAAAAAAAAAEAAQAAAAAAAAAAAgMAAAABAEAAAAAABAAAAQIAGaMAAACkAAEAAAAAQE0AACQCAAAATQAAJAIAAACkAQQAAAAwQE0CAEgFAAAATQIC4gYAAACfAQIC/wICAAAAAADAAwcAEgABADADAucIAAAAwAMJABIAAQAwAwItCgAAAIICAgALAw8EAAAAQAMQAxEEAAAwQAMSAxMGAAMUBgEDFQIAAQEAARgACAAAAAAAAQAAAAAAAAQADQAAACQAAAAZAQAAAAAC9qDUPcQ44loAPTGuB88Shoa4w0nEZL48

-- https://lua.expert/
local ConfigHandler = require(script.Parent.Parent.AI.ConfigHandler)

return {
	GetDynamicRetrackTimer = function(p1, p2, p3) --[[ Line: 27 | Upvalues: ConfigHandler (copy) ]]
		local v1 = ConfigHandler.GetActiveConfig(p1)

		if p3 == "DirectMoveTo" then
			local v2 = v1.Tracking.DynamicRetrack.MoveTo.GetRetrackTimeFunction(p1, p2)

			if v2 == nil then
				return v1.Tracking.DynamicRetrack.MoveTo.MaxTimer
			end

			return math.clamp(v2, v1.Tracking.DynamicRetrack.MoveTo.MinTimer, v1.Tracking.DynamicRetrack.MoveTo.MaxTimer)
		end

		if p3 ~= "Pathfind" then
			warn("this should not occur")

			return 1
		end

		local v3 = v1.Tracking.DynamicRetrack.Pathfind.GetRetrackTimeFunction(p1, p2)

		if v3 == nil then
			return v1.Tracking.DynamicRetrack.Pathfind.MaxTimer
		end

		return math.clamp(v3, v1.Tracking.DynamicRetrack.Pathfind.MinTimer, v1.Tracking.DynamicRetrack.Pathfind.MaxTimer)
	end,
	ShouldRetrack = function(p1, p2, p3) --[[ Line: 63 | Upvalues: ConfigHandler (copy) ]]
		local v1 = ConfigHandler.GetActiveConfig(p1)

		if p3 == "DirectMoveTo" then
			local v2 = v1.Tracking.DynamicRetrack.MoveTo.ShouldRetrackFunction(p1, p2)

			if v2 == nil then
				return v1.Tracking.DynamicRetrack.MoveTo.MaxTimer
			end

			return v2
		end

		if p3 ~= "Pathfind" then
			warn("this should not occur")

			return false
		end

		local v3 = v1.Tracking.DynamicRetrack.Pathfind.ShouldRetrackFunction(p1, p2)

		if v3 == nil then
			return v1.Tracking.DynamicRetrack.Pathfind.MaxTimer
		end

		return v3
	end
}