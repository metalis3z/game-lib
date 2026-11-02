--get member data associated with a roblox entity

local PublicMembers = {}


local Data = {}


script.SyncMember.OnClientEvent:connect(function(object,memberName,value)

	if not Data[object] then 
		Data[object] = {}
	end
	Data[object][memberName] = value
	
	
	
	script.PublicMemberChanged:Fire(object,memberName,value)
end)



function PublicMembers:GetMemberValue(object,memberName)
	if Data[object] then
		return Data[object][memberName]
	end
end




return PublicMembers
