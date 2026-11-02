-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local t2 = {}

function t.Track(p1, p2, p3) --[[ Track | Line: 4 | Upvalues: t2 (copy) ]]
	if t2[p2] == nil then
		t2[p2] = {}
	end

	t2[p2][p1] = p3
end
function t.Cancel(p1, p2) --[[ Cancel | Line: 11 | Upvalues: t2 (copy) ]]
	if not t2[p2] then
		return
	end

	t2[p2][p1] = nil

	for k, v in pairs(t2[p2]) do
		return
	end

	t2[p2] = nil
end
function t.Get() --[[ Get | Line: 21 | Upvalues: t2 (copy) ]]
	return t2
end

return t