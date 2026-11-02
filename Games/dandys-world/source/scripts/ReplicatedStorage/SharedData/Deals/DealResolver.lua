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
-- CQMUCW93bnNUb3dlcgtvd25zVHJpbmtldAZpcGFpcnMTb3duZXJzaGlwRnJvbVRhYmxlcwZhbHdheXMEa2luZAJpZAZhbW91bnQFdGFibGUGaW5zZXJ0BWl0ZW1zBVRvd2VyB1RyaW5rZXQHaWZPd25lZAtzdWJzdGl0dXRlZAxvcmlnaW5hbEtpbmQKb3JpZ2luYWxJZBNvcmlnaW5hbERpc3BsYXlOYW1lC2Rpc3BsYXlOYW1lB3Jlc29sdmUABQQBAQAAAAf7AwAAhwIDACoCAgABAAAAqQEAAakBAQCCAQIAAAAUAQEYAAAAAAAAABQAAAAABAEBAAAAB/sDAACHAgMAKgICAAEAAACpAQABqQEBAIIBAgAAABUCARgAAAAAAAAAFQAAAAALAgAAAAAs/wIAAAAAAAD/AwAAAAAAAKQEAQAAAABAUgUAACsFAgD/BQAAAAAAAJ8EAgRRBAUAEwkIAA4JAwATCQgAqQoBAGoKAgluBPr/AgAAgKQEAQAAAABAUgUBACsFAgD/BQAAAAAAAJ8EAgRRBAUAEwkIAA4JAwATCQgAqQoBAGoKAwluBPr/AgAAgOIEBADZBQAAEgACADAFBNcCAAAA2QUBABIAAwAwBQRcAwAAAIIEAgAFAwMEAAAAQAMBAwIFAgIDAgABCwQBGAAAAAABAAAAAAAAAAEAAAAA/wADAAAAAAAAAAEAAAAA/wADAQAAAAEAAAAADAAAAAANAgAAAACDAf8CAAAAAAAApAMBAAAAAEBNBADkAgAAACsEAgD/BAAAAAAAAJ8DAgRRAxMA4goGAE0LB10DAAAAMAsKXQMAAABNCwf0BAAAADALCvQEAAAATQsHCwUAAAAwCwoLBQAAAJ40AgQKAAAAUgkCAKQICQAAIHCAnwgDAW4D7P8CAACApAMBAAAAAEBNBAAYCgAAACsEAgD/BAAAAAAAAJ8DAgRRA1cAqQgAAE0JB10DAAAA8AkIAAsAAIBNCQHXDAAAAE0KB/QEAAAAnwkCAlIICQBlAAoATQkHXQMAAADwCQcADQAAgE0JAVwOAAAATQoH9AQAAACfCQICUggJAA4IKQBNCQceDwAAAA4JPQDiCxUATQwHHg8AAABNDAxdAwAAADAMC10DAAAATQwHHg8AAABNDAz0BAAAADAMC/QEAAAATQwHHg8AAABNDAwLBQAAADAMCwsFAAAATQwHXQMAAAAwDAsMEgAAAE0MB/QEAAAAMAwL9hMAAABNDAd3FgAAADAMC1wUAAAAnjQCBAsAAABSCgIApAkJAAAgcICfCQMBZQAXAOILFwBNDAddAwAAADAMC10DAAAATQwH9AQAAAAwDAv0BAAAAE0MBwsFAAAAMAwLCwUAAABNDAd3FgAAADAMC3cWAAAAnjQCBAsAAABSCgIApAkJAAAgcICfCQMBbgOo/wIAAICCAgIAGAMDBAAAAEADBQMGAwcDCAUDAwQFAwkDCgQAIHCAAwsDDAMBAw0DAgMOAw8BAQMQAxEDEggHA/////8E/////wX/////EBEAAAAS/////xP/////FP////8DEwUEAwQFFgAdFAEYAAACAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAA/wAEAAAAAAAAAAABAQAAAAEAAAAAAAABAAAAAQAAAAAAAwEAAAEBAAAAAAABAAAAAAABAAAAAAACAAAAAQAAAAEAAAAAAAD5AAAADAAAAAAAAAAAAAAAAAAAAAAAAAAAAADqABoeAAAAAAIAAAECAAqjAAAA/wACAAAAAADAAQAAMAEAeQEAAADAAQIAMAEAHQMAAACCAAIABAYCAwQGAwMUAgIDAQABGAAFAAUAABIAACQBAAAAAAQM/dL3OPZdwR6mqW/d2GMifOXFgz45uPY=

-- https://lua.expert/
return {
	ownershipFromTables = function(p1, p2) --[[ ownershipFromTables | Line: 11 ]]
		local t = {}
		local t2 = {}

		for v3, v4 in ipairs(if p1 then p1 else {}) do
			if v4[1] then
				t[v4[1]] = true
			end
		end

		for v7, v8 in ipairs(if p2 then p2 else {}) do
			if v8[1] then
				t2[v8[1]] = true
			end
		end

		return {
			ownsTower = function(p1) --[[ ownsTower | Line: 20 | Upvalues: t (copy) ]]
				return t[p1] == true
			end,
			ownsTrinket = function(p1) --[[ ownsTrinket | Line: 21 | Upvalues: t2 (copy) ]]
				return t2[p1] == true
			end
		}
	end,
	resolve = function(p1, p2) --[[ resolve | Line: 29 ]]
		local t = {}
		local v1 = ipairs

		for v3, v4 in v1(p1.always or {}) do
			table.insert(t, {
				kind = v4.kind,
				id = v4.id,
				amount = v4.amount
			})
		end

		local v5 = ipairs

		for v7, v8 in v5(p1.items or {}) do
			local v9 = false

			if v8.kind == "Tower" then
				v9 = p2.ownsTower(v8.id)
			elseif v8.kind == "Trinket" then
				v9 = p2.ownsTrinket(v8.id)
			end

			if v9 then
				if v8.ifOwned then
					table.insert(t, {
						substituted = true,
						kind = v8.ifOwned.kind,
						id = v8.ifOwned.id,
						amount = v8.ifOwned.amount,
						originalKind = v8.kind,
						originalId = v8.id,
						originalDisplayName = v8.displayName
					})
				end

				continue
			end

			table.insert(t, {
				kind = v8.kind,
				id = v8.id,
				amount = v8.amount,
				displayName = v8.displayName
			})
		end

		return t
	end
}