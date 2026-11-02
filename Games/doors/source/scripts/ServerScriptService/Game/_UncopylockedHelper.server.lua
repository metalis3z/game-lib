--[[                                                                                                          
 BBBBBBBBBBBBBBBBB   UUUUUUUU     UUUUUUUU IIIIIIIIII LLLLLLLLLLL             DDDDDDDDDDDDD                GGGGGGGGGGGGG
 B::::::::::::::::B  U::::::U     U::::::U I::::::::I L:::::::::L             D::::::::::::DDD          GGG::::::::::::G
 B::::::BBBBBB:::::B U::::::U     U::::::U I::::::::I L:::::::::L             D:::::::::::::::DD      GG:::::::::::::::G
 BB:::::B     B:::::BUU:::::U     U:::::UU II::::::II LL:::::::LL             DDD:::::DDDDD:::::D    G:::::GGGGGGGG::::G
   B::::B     B:::::B U:::::U     U:::::U    I::::I    L:::::L                 D:::::D    D:::::D  G:::::G       GGGGGG
   B::::B     B:::::B U:::::D     D:::::U    I::::I    L:::::L                 D:::::D     D:::::D G:::::G              
   B::::BBBBBB:::::B  U:::::D     D:::::U    I::::I    L:::::L                 D:::::D     D:::::D G:::::G              
   B:::::::::::::BB   U:::::D     D:::::U    I::::I    L:::::L        hey      D:::::D     D:::::D G:::::G    GGGGGGGGGG
   B::::BBBBBB:::::B  U:::::D     D:::::U    I::::I    L:::::L                 D:::::D     D:::::D G:::::G    G::::::::G written by GalaxyRecry gg/cxV62BQ3
   B::::B     B:::::B U:::::D     D:::::U    I::::I    L:::::L                 D:::::D     D:::::D G:::::G    GGGGG::::G
   B::::B     B:::::B U:::::D     D:::::U    I::::I    L:::::L                 D:::::D     D:::::D G:::::G        G::::G
   B::::B     B:::::B U::::::U   U::::::U    I::::I    L:::::L         LLLLLL  D:::::D    D:::::D  G:::::G       G::::G
 BB:::::BBBBBB::::::B U:::::::UUU:::::::U  II::::::II LL:::::::LLLLLLLLL:::::L DDD:::::DDDDD:::::D    G:::::GGGGGGGG::::G
 B:::::::::::::::::B   UU:::::::::::::UU   I::::::::I L::::::::::::::::::::::L D:::::::::::::::DD      GG:::::::::::::::G
 B::::::::::::::::B      UU:::::::::UU     I::::::::I L::::::::::::::::::::::L D::::::::::::DDD          GGG::::::GGG:::G
 BBBBBBBBBBBBBBBBB         UUUUUUUUU       IIIIIIIIII LLLLLLLLLLLLLLLLLLLLLLLL DDDDDDDDDDDDD                GGGGGG   GGGG
--]]



local h = game.ReplicatedStorage.UncopylockedHelper
function dof(pt, id, val, isStudio)
	if id == "GameRun" then
		pt.PlayerStats.TypeRun.Value = val
		if isStudio == false then
			local res = game["Teleport Service"]:ReserveServer(game.PlaceId)
			game.ReplicatedStorage.EntityInfo.Loading:FireClient(pt)
			game["Teleport Service"]:TeleportToPrivateServer(game.PlaceId, res, {pt})
		elseif isStudio then
			pt:Kick("Rejoin, TypeRun value: "..val)
		end
	end
end
function check(pt, data)
	if data.id == "GameRun" then
		dof(pt, data.id, data.val, data.isStudio)
	end
end
h.UncopylockedHelper_Server.OnServerEvent:Connect(function(pt, data)
	check(pt, data)
end)
h.UncopylockedHelper_Bindable.Event:Connect(function(pt, data)
	check(pt, data)
end)

game.Players.PlayerAdded:Connect(function(pt)
	task.wait(3)
	print("brrrrrr")
	if pt:WaitForChild("PlayerStats"):WaitForChild("TypeRun").Value == "Nonil" or pt:WaitForChild("PlayerStats"):WaitForChild("TypeRun").Value == "Lobby" then
		print("grrrr")
		pt:LoadCharacter()		
        game.ReplicatedStorage.UncopylockedHelper.UncopylockedHelper_Client:FireClient(pt, "Failed_Run")
	end
end)