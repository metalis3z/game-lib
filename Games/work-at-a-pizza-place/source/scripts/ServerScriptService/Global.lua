local Global = {}
Global.Houses = {} 
Global.Players = {}
Global.AssetLibraryManager = {}
Global.Manager = {}
Global.Vehicles={}
Global.Environment={}
Global.Customers={}
Global.Door = {}
Global.Paycheck = {}

--[[function Global:SyncMemberWithClient(object,memberName,value,player)
	if player then
		game.ReplicatedStorage.PublicMembers.SyncMember:FireClient(player,object,memberName,value)
	else
		game.ReplicatedStorage.PublicMembers.SyncMember:FireAllClients(object,memberName,value)
	end
end]]

return Global
