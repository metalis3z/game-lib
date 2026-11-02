-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Library = game:GetService("ReplicatedStorage").Library
local Network = require(Library.Client.Network)

require(Library.Items.AbstractItem)

local ExistCountUtil = require(Library.Util.ExistCountUtil)
local t = {}
local t2 = {}

function t.Get(p1) --[[ Get | Line: 25 | Upvalues: ExistCountUtil (copy), t2 (copy) ]]
	return t2[ExistCountUtil.hashKey(p1.Class.Name, p1:StackKey())] or 0
end
function t.GetByClassAndStackKey(p1, p2) --[[ GetByClassAndStackKey | Line: 32 | Upvalues: ExistCountUtil (copy), t2 (copy) ]]
	return t2[ExistCountUtil.hashKey(p1, p2)] or 0
end
Network.Fired(Network.NET_MAP.ExistCounts.UPDATE):Connect(function(p1) --[[ Line: 40 | Upvalues: ExistCountUtil (copy), t2 (copy) ]]
	for k, v in pairs((ExistCountUtil.decode(p1))) do
		t2[k] = v
	end
end)

return t