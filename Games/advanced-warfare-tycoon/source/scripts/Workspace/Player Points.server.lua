--Created by Ornahx3
PointsService = game:GetService("PointsService")
Stat = "KOs" --Change to the stats name
Needed = 1 --Change to the amount needed to get the playerpoints.
game.Players.PlayerAdded:connect(function(p)
        repeat wait() until p:FindFirstChild("leaderstats") ~= nil
        print("Found \"leaderstats\" object!")
        repeat wait() until p.leaderstats:findFirstChild(Stat) ~= nil
        print("Found "..Stat.." object!")
        p.leaderstats[Stat].Changed:connect(function(prop)
                print("Value changed!")
                if prop >= Needed then
                        game:GetService("PointsService"):AwardPoints(p.userId,15)
                end
        end)
end)
--Created by Ornahx3, Please give me Credit. It is not need but will be much Appriciated.