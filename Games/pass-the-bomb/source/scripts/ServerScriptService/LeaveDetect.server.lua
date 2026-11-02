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


game.Players.PlayerRemoving:Connect(function(plr)
	local name = plr.Name
	removefromtable(_G.players, plr)
	removefromtable(_G.players, plr)
	removefromtable(_G.giveplates, plr)
	removefromtable(_G.giveplates, plr)
	if game.Workspace.NamedPlatforms:FindFirstChild(name) then
		game.Workspace.NamedPlatforms:FindFirstChild(name):Destroy()
	end
end)