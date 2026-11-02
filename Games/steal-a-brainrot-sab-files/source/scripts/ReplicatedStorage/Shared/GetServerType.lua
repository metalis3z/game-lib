local GetServerType = {}

function GetServerType:IsPrivateServer()
    return false
end

function GetServerType:IsReservedServer()
	return false
end

function GetServerType:IsPublicServer()
	return false
end

return GetServerType