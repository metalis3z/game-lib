admins = {"gaberrgg1","micbryce"}

 
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

 
function onChatted(message, player)
    if message == ":start" and tableContains(admins, player.Name) then
	game.ReplicatedStorage.VALUES.Start.Value = true
	wait(.5)
	game.ReplicatedStorage.VALUES.Start.Value = false
	elseif message == ":reset" and tableContains(admins, player.Name) then
		for i,v in pairs(game.Players:GetPlayers()) do
			removefromtable(_G.players, v)
			removefromtable(_G.players, v)
			v.TeamColor = game.Teams.Lobby.TeamColor
			v:LoadCharacter()
		end
		game.ReplicatedStorage.RE.Status:FireAllClients("off")
		for i,v in pairs(game.Workspace.NamedPlatforms:GetChildren()) do
			v:Destroy()
		end
		for i,v in pairs(game.ServerStorage.lolplatform:GetChildren()) do
			v:Clone().Parent = game.Workspace.UnusedPlatforms
		end
    end
end

function checkadmin(plr)
	if plr:GetRankInGroup(8025572) >= 2000 then
		addtotable(admins, plr.Name)
	end
end


game.Players.PlayerAdded:connect(function(player)
	checkadmin(player)
    player.Chatted:connect(function(message) onChatted(message, player) end)
end)