-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local CollectionService = game:GetService("CollectionService")

return function(p1) --[[ Line: 3 | Upvalues: CollectionService (copy) ]]
	local Tag = p1.Tag
	local v1 = p1.OnInstanceAdded or (function(p1) --[[ Line: 5 ]] end)
	local v2 = p1.OnInstanceRemoved or (function(p1) --[[ Line: 6 ]] end)

	for v3, v4 in CollectionService:GetTagged(Tag) do
		v1(v4)
	end

	CollectionService:GetInstanceAddedSignal(Tag):Connect(v1)
	CollectionService:GetInstanceRemovedSignal(Tag):Connect(v2)
end