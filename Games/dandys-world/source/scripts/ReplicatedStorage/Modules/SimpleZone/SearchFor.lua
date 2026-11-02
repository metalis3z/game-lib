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
-- CQMUAV8Fc3BsaXQFdGFibGUGY29uY2F0FnNwbGl0UmVjdXJzaXZlUHJvcGVydHkGUGFyZW50CVNlYXJjaEZvcg5GaW5kRmlyc3RDaGlsZANUYWcGSGFzVGFnCkF0dHJpYnV0ZV8FbWF0Y2gMR2V0QXR0cmlidXRlD3Byb3BlcnR5Q2hlY2tlcgJPcgZpbnNlcnQDQW5kDmNoZWNrQ29uZGl0aW9uEkJhZCBtb2RlIGFyZ3VtZW50LgZhc3NlcnQABQgBAAAABgMAAAUBAxNvAwAAvAEA4wEAAACfAQMCEwABAFICAACpAwAAHAQBAIwFAQBgBQgABAAAAKQDBAAADCCAUgQBAG8FAACMBgIAHAcBAJ8DBQKCAgMABQMBAwIDAwMEBAAMIIAAAQUBGAAAAAACAgAAAAAAAAAAAAAAAAACAAAAABIEAAAAAHJSBAMAxgUAAMYGAABkBGsAUgsHAG8OAAC8DAvjAQAAAJ8MAwITCwwAUgkLAKkKAAAcDQwAjA4BAGAOCQANAAAApA0EAAAMIIBSDgwAbw8AAIwQAgAcEQwAnw0FAlIKDQDwCRUABQAAgA4KEwA1CwDEBgAAAP8MAAABAAAATQ0AJAUAAADFDA0CAQAAAP8NAQAAAAAAaggNClIOAQCfCwQCUgwCAE0OACQFAAAAhw0LDp8MAgFlAEEAUg0JALwLAAMHAAAAnwsDAg4LFgAOChUANQsAxAYAAAD/DAAAAQAAAFIPCQC8DQADBwAAAJ8NAwDFDA0AAQAAAP8NAQAAAAAAaggNClIOAQCfCwQCUgwCAE0OACQFAAAAhw0LDp8MAgFlACYA8AgIAAgAAIBSCwIAUg4JALwMAN4JAAAAnwwDAJ8LAAFlAB0Abw0KALwLCecLAAAAnwsDAg4LEQBvDgAAvAwJ4wEAAACfDAMCEwsMAVIPCwC8DQASDAAAAJ8NAwLxDQIACAAAAKkMAAGpDAEAUg0CAFIODACfDQIBZQAHAFILAgCHDQAJ8Q0CAAgAAACpDAABqQwBAJ8LAgFuBJT/AgAAAIIAAQANAwEDAgMDAwQEAAwggAMGAwcDCAMJAwoDCwMMAw0ACQ4BGAgAAAAB9wAAAAICAAAAAAAAAAAAAAAAAAgAAAEAAAAAAAAAAAAAAAABAAAAAAEDAAAAAAABAAAAAAAAAAAAAAAAAAABAAAAAAEDAAEAAAAAAAEDAAAAAAEAAAAAAgAAAAAAAAACAAABAwAAAAAAAOIAIAIAAAAABAEEAAAAEw4ACwD7AQAA8AEJAAAAAID7AgEA+wMCAJ40AgMDAAAApAEDAAAIEICfAQMBggABACsABQD7AQAA8AEDAAQAAICpAQEA3gEDAIIAAQAFAw8DAwMQBAAIEIADEQA0EgEYAAAAAAEAAAAAAAAAAQAAAAEAAjUAAAAAEAMBAAAIBQAABQMPBAMwqQQAAEcCCAAAAAAAqQQBAPACBQAAAAAA8AICAAEAAACpBAABqQQBAIEBBAQCAAAAbwUCAKQDBAAAADBAnwMDAf8DAAAAAAAAUgQAAMYFAADGBgAAZAQXAKkJAADZCgAAEgACABIAAwASAAgAEgEJ//sLAABSDAgAUg0CAFIOCgBSDwEAnwsFASsJCQDwAggAAQAAgJ40AwUIAAAAUgwDAFINCACkCwcAABhQgJ8LAwHBCQAAbgTo/wIAAACCAwIACAMPAxEDEwMUBAAAMEADAwMQBAAYUIABAiwHARgAAAAAAAAAAAAAAAAAAAAAAgACAAAAAQIAAAAACAAAAAAAAgAAAQAAAAAAAADyABEtAAAAAAMAAAECAAqjAAAAwAAAAMABAQDAAgIAEgABABgCAMQDAAAANQIAxAMAAACCAgIABAYABgEGAwMHAwABAwEAARgAAAgjAAAAGQAAAQAAAAAE0Q2M0dDEUsxtdZdddjXPHqEVm6XjyebQ

-- https://lua.expert/
local function splitRecursiveProperty(p1) --[[ splitRecursiveProperty | Line: 1 ]]
	local v1 = p1:split("_")

	return v1[1], if #v1 > 1 then table.concat(v1, "_", 2, #v1) else false
end

local function propertyChecker(p1, p2, p3, p4) --[[ propertyChecker | Line: 9 ]]
	for v2, v3 in p4 do
		local v1
		local v4 = v2:split("_")
		local v5 = v4[1]

		v1 = if #v4 > 1 then table.concat(v4, "_", 2, #v4) else false

		if v5 == "Parent" and v1 then
			p3(SearchFor({ p1.Parent }, {
				[v1] = v3
			}, p2)[p1.Parent])

			continue
		end

		if p1:FindFirstChild(v5) and v1 then
			p3(SearchFor({ p1:FindFirstChild(v5) }, {
				[v1] = v3
			}, p2)[p1.Parent])

			continue
		end

		if v3 == "Tag" then
			p3(p1:HasTag(v5))

			continue
		end

		if v5:match("Attribute_") then
			p3(if p1:GetAttribute(v5:split("_")[2]) == v3 then true else false)

			continue
		end

		p3(p1[v5] == v3)
	end
end

function SearchFor(p1, p2, p3) --[[ SearchFor | Line: 44 | Upvalues: propertyChecker (copy) ]]
	assert(if p3 == nil then false elseif p3 == "Or" then true elseif p3 == "And" then true else false, "Bad mode argument.")

	local t = {}

	for v2, v3 in p1 do
		local v4 = false

		propertyChecker(v3, p3, function(p1) --[[ checkCondition | Line: 52 | Upvalues: p3 (copy), t (copy), v3 (copy), v4 (ref) ]]
			if p1 and p3 == "Or" then
				table.insert(t, v3)

				return
			end

			if p1 or p3 ~= "And" then
				return
			end

			v4 = true
		end, p2)

		if not v4 and p3 == "And" then
			table.insert(t, v3)
		end
	end

	return t
end

return SearchFor