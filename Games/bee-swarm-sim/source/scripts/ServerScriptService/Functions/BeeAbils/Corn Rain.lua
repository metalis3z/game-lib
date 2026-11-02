local Token = {}; do
	local DataServer = require(game.ServerScriptService.Server.Data)
	local Flowers = require(game.ServerScriptService.Server.FlowerRegister)
	local TS = game:GetService("TweenService")
	function Token.Run(Player, Position)
		local PlayerData = DataServer:Get(Player)
		for i = 1, PlayerData.IStats.TotalSlots do
			local Corn = script.Corn:Clone()
			local X = math.random(-25, 25)
			local Z = math.random(-25, 25)
			Corn.Position = Position + Vector3.new(X, 25, Z)
			Corn.Parent = workspace
			TS:Create(Corn, TweenInfo.new(1), {Position = Corn.Position - Vector3.new(0, 25, 0)})
			spawn(function()
				wait(1)
				Corn:Destroy()
				Flowers:CollectPatches(Player, {
					Position = Corn.Position + Vector3.new(0, 1, 0),
					Stamp = "Bomb",
					StatsModule = {
						Collecting = 100,
						Power = 1.5,
						Color = "White",
						ColorMutltiplier = 1.5
					}
				})
			end)
			wait(1)
		end
	end
end

return Token