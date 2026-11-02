_G.players = {}
_G.giveplates = {}


function tablefind(tab,el)
    for index, value in pairs(tab) do
        if value == el then
            return index
        end
    end
end


function removefromtable(tablee, plr)
	if tableContains(tablee, plr) then
		table.remove(tablee, tablefind(tablee, plr))
	end
end

function tableContains(t, value)
    for _, v in pairs(t) do
        if v == value then 
            return true
        end
    end
    return false
end


function addtotable(tablee, plr)
	if tableContains(tablee, plr) then
	else
		table.insert(tablee, plr)
	end
end


function randomizeplayerplatforms()
	for i,v in pairs(game.Teams.Lobby:GetPlayers()) do
		addtotable(_G.giveplates, v)
	end
	repeat wait()
		local ranplayer = _G.giveplates[math.random(1,#_G.giveplates)]
		local plates = game.Workspace.UnusedPlatforms:GetChildren()
		local ranplate = plates[math.random(1, #plates)]
		if ranplayer.Character and ranplayer.Character.Humanoid.Health > 0 then
			ranplayer.Character.Humanoid.WalkSpeed = 0
			wait()
			ranplayer.Character:MoveTo(ranplate.TP.Position)
			ranplayer.TeamColor = game.Teams.Players.TeamColor
			addtotable(_G.players, ranplayer)
			removefromtable(_G.giveplates, ranplayer)
			ranplate.Name = ranplayer.Name
			ranplate.Parent = game.Workspace.NamedPlatforms
		else
		end
	until #_G.giveplates == 0
	game.Workspace.UnusedPlatforms:ClearAllChildren()
end

game.ReplicatedStorage.VALUES.Start.Changed:Connect(function()
	if game.ReplicatedStorage.VALUES.Start.Value == true then
		game.ReplicatedStorage.RE.Status:FireAllClients("DROP STARTING...")
		wait(2.5)
		randomizeplayerplatforms()
		wait(2.5)
		game.ReplicatedStorage.RE.Status:FireAllClients("DROP HAS BEGUN, GOOD LUCK!")
		repeat wait()
			if #_G.players > 1 then
			for i = 3,0,-1 do
					game.ReplicatedStorage.RE.CD:FireAllClients(""..i)
					game.ReplicatedStorage.RE.PL:FireAllClients(""..i)
				wait(1)
			end
		local ranplayer = _G.players[math.random(1,#_G.players)]
		local name = ranplayer.Name
		local stringg = string.upper(name.." has been dropped!")
		game.ReplicatedStorage.RE.Status:FireAllClients(stringg)
		game.Workspace.NamedPlatforms:FindFirstChild(name):Destroy()
		removefromtable(_G.players, ranplayer)
		ranplayer.TeamColor = game.Teams.Lobby.TeamColor
		end
		until #_G.players == 1
		wait(1.5)
		game.ReplicatedStorage.RE.CD:FireAllClients("off")
		game.ReplicatedStorage.RE.PL:FireAllClients("off")
		local nameupper = string.upper(_G.players[1].Name)
		game.ReplicatedStorage.RE.Status:FireAllClients("THE WINNER IS "..nameupper.."!")
		_G.players[1].Character:MoveTo(game.Workspace.Host.TP.Position)
	end
end)