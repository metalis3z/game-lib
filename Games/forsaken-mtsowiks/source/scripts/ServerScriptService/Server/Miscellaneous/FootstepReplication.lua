local module = {
	FootstepRenaming = {
		[Enum.Material.Carpet] = "Carpet",
		[Enum.Material.Fabric] = "Carpet",
		[Enum.Material.Grass] = "Grass",
		[Enum.Material.Sand] = "Grass",
		[Enum.Material.LeafyGrass] = "Grass",
		[Enum.Material.Snow] = "Grass",
		[Enum.Material.Metal] = "Metal",
		[Enum.Material.DiamondPlate] = "Metal",
		[Enum.Material.CorrodedMetal] = "Metal",
		[Enum.Material.RoofShingles] = "Metal",
		[Enum.Material.Wood] = "Wood",
		[Enum.Material.WoodPlanks] = "Wood",
	}
}

local Network = require(game.ReplicatedStorage.Modules.Network)
local Sounds = require(game.ReplicatedStorage.Modules.Sounds)
local Actors = require(game.ReplicatedStorage.Modules.Actors)

module.Start = function()
	Network:SetConnection("FootstepPlayed", "UREMOTE_EVENT", function(Player : Player)
		local Character = Player.Character
		if (not Character) or (not Character.Parent) then return end
		if Character.Parent.Name ~= "Killers" and Character.Parent.Name ~= "Survivors" then return end
		if (not Character.PrimaryPart) then return end
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")
		if not Humanoid then return end
		
		local Actor = Actors.CurrentActors[Player]
		local footsteps : {string} = Actor and Actor.Config and Actor.Config.Sounds and Actor.Config.Sounds.Footsteps
		local footstep
		
		if footsteps and type(footsteps) == "table" and #footsteps > 0 then
			footstep = footsteps[math.random(1, #footsteps)]
		else
			footstep = ("footstep%*"):format(module.FootstepRenaming[Humanoid.FloorMaterial] or "Cement")
		end
		
		Sounds:Play(footstep, {
			["Parent"] = Character.PrimaryPart,
			["PlaybackSpeed"] = Random.new():NextNumber(0.9, 1.1),
			["Volume"] = 0.25
		})
	end)
end

return module