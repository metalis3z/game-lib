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


while wait(2) do
	for i,v in pairs(_G.players) do
		if game.Players:FindFirstChild(v.Name) then
			else
			removefromtable(_G.players, v)
			removefromtable(_G.giveplates, v)
			if game.Workspace.NamedPlatforms:FindFirstChild(v.Name) then
				game.Workspace.PLATES:FindFirstChild(v.Name):Destroy()
			end
		end
		end
end
