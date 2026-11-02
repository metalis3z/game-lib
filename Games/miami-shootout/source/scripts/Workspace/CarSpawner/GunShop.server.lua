local tp = {
	"Police Sedan",
	"SP Sedan"
}
local legacyTp = {
	"Police Explorer",
	"Police Fusion",
	"Police Impala",
	"Unmarked Sedan",
	"Unmarked Explorer",
	"SP Vic"
}
local sit = {
	"Police Explorer",
	"Police Sedan",
	"Police Fusion",
	"Police Impala",
	"Unmarked Sedan",
	"Unmarked Explorer",
	"SP Vic",
	"SP Sedan"
}


game.ReplicatedStorage.Cara.OnServerEvent:Connect(function(p,car)
	if p.Team ~= game.Teams.Police then return end
	
	if game.Workspace.PoliceCars:FindFirstChild(p.Name.. "'s Car") then

		print("destroy old car")
		game.Workspace.PoliceCars:FindFirstChild(p.Name.."'s Car"):Destroy()

	end

	local pc = game.ServerStorage.Cars[car]:Clone()
	pc.Parent = game.Workspace.PoliceCars
	pc.Name = p.Name .. "'s Car"

	wait(0.3)

	local sel = math.random(1,3)

	print(sel.. " select")

	if table.find(tp,car) then pc:SetPrimaryPartCFrame(game.Workspace:FindFirstChild("PCarSpawn"..sel).CFrame) end
	if table.find(legacyTp,car) then pc:MoveTo(game.Workspace:FindFirstChild("PCarSpawn"..sel).Position) end
	if table.find(sit,car) then pc:GetChildren()[1].DriveSeat:Sit(p.Character.Humanoid) end
end)

script.Parent.Main.ProximityPrompt.Triggered:Connect(function(Player)
	if Player.Team == game.Teams.Police then
		
		game.ReplicatedStorage.server:FireClient(Player,"togglecars") 
		--v:FindFirstChild("main"):FindFirstChild("open"):Play()
		
	end
end)
