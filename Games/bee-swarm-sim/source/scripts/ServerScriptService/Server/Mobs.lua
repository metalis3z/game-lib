local Mobs = {}; do
	local WorldMobs = {}
	local Total = 0
	
	local function CreateMover()
		local Mover = Instance.new("Part", workspace)
		Mover.Size = Vector3.one
		Mover.Anchored = true
		Mover.CanCollide = false
		Mover.Name = "Mob Mover"
		Mover.Color = Color3.fromRGB(255,0,0)
		return Mover
	end
	
	function Mobs.Spawn(Player: Player?, MobName: string, Info: {Spawn: BasePart | Vector3, Level: number})
		-- Player может быть "Server" если моб серверный
		Total += 1
		local ID = "ID: "..Total
		local MobData = require(game.ReplicatedStorage.Modules.Mobs[MobName])
		local Mover = CreateMover()
		local Position = typeof(Info.Spawn) == "Vector3" and Info.Spawn or Info.Spawn.Position
		Mover.Position = Position
		local Mob = {
			Owner = Player,
			Name = MobName,
			Mover = Mover,
			Position = Position,
			Level = Info.Level or 1,
			Hp = type(MobData.Hp) == "function" and MobData.Hp(Info.Level or 1) or MobData.Hp,
		}
		WorldMobs[ID] = Mob
		require(script[MobName]).Spawn(Mob)
	end
	
	function Mobs.Remove(ID: string)
		local Mob, Index
		for i, MobData in WorldMobs do
			if MobData.ID == ID then
				Index = i
				Mob = MobData
				break
			end
		end
		
		if not Mob then
			return warn("Mob doesnt found")
		end
		
		table.remove(WorldMobs, Index)
		print("mob removed")
		print(ID)
	end
end

return Mobs