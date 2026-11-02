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
-- CQMRB1ByZXNldHMMU3ByaW5nQnJlZXplA0dldAVwYWlycwV0YWJsZQZpbnNlcnQEc29ydA5HZXRQcmVzZXROYW1lcwpHb2xkZW5EdXN0ClRveGljU3BvcmULZGlzcGxheU5hbWUNU3ByaW5nIEJyZWV6ZQp0cmFpbENvbG9yBkNvbG9yMwdmcm9tUkdCC0dvbGRlbiBEdXN0C1RveGljIFNwb3JlAAMDAQEAAAAL+wIAAE0CAlIAAAAAhwECACsBBQD7AgAATQICUgAAAABNAQKfAQAAAIIBAgACAwEDAgAYAwEYAAAAAAAAAAAAAAAZAAAAAAkAAQAAABf/AAAAAAAAAKQBAQAAAABA+wIAAE0CAlICAAAAnwECBBcBBwCeNAAFBAAAAFIHAABSCAQApAYFAAAQMICfBgMBbgH4/wEAAACkAQcAABgwgFICAACfAQIBggACAAgDBAQAAABAAwEDBQMGBAAQMIADBwQAGDCAABwIARgAAAEAAAAAAAABAAAAAAAA/wADAAAAAR0AAAAABwAAAQIAMKMAAAD/AAMAAAAAAOIBAwDiAgcApAMKAAAkgICMBJAAjAXuAIwGkACfAwQCMAMChwYAAAAwAgGfAAAAAOICDACkAwoAACSAgIwE/wCMBdcAjAYAAJ8DBAIwAwKHBgAAADACAYsBAAAA4gIOAKQDCgAAJICAjASUAIwFAACMBtMAnwMEAjADAocGAAAAMAIBBQIAAAAwAQBSDwAAAMABEAASAAAAMAEAfxEAAADAARIAEgAAADABAHkTAAAAggACABQDAgMJAwoFAwABAgMLAwwDDQgCBAUAAAAG/////wMOAw8EACSAgAMQCAIECwAAAAb/////AxEIAgQNAAAABv////8DAQYAAwMGAQMIAgABAQABGAAEAAIBAgAAAAAAAAD+AAUCAAAAAAAAAP4ABQIAAAAAAAAA/gD1ABEAAAAEAAAACQEAAAAAAjDrxMzVYKjT/5qCQ5FxAeVA89O4Ai+uzQ==

-- https://lua.expert/
local t = {
	Presets = {
		SpringBreeze = {
			displayName = "Spring Breeze",
			trailColor = Color3.fromRGB(144, 238, 144)
		},
		GoldenDust = {
			displayName = "Golden Dust",
			trailColor = Color3.fromRGB(255, 215, 0)
		},
		ToxicSpore = {
			displayName = "Toxic Spore",
			trailColor = Color3.fromRGB(148, 0, 211)
		}
	}
}

function t.Get(p1) --[[ Get | Line: 24 | Upvalues: t (copy) ]]
	return t.Presets[p1] or t.Presets.SpringBreeze
end
function t.GetPresetNames() --[[ GetPresetNames | Line: 28 | Upvalues: t (copy) ]]
	local t2 = {}

	for k in pairs(t.Presets) do
		table.insert(t2, k)
	end

	table.sort(t2)

	return t2
end

return t