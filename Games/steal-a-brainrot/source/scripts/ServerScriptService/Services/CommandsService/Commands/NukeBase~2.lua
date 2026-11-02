local PlotService = require(game.ServerScriptService.Services:WaitForChild("PlotService"))
local Synchronizer = require(game.ReplicatedStorage.Packages.Synchronizer)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")


print("by dan")

local NukeBase = function(Conch, Config)


	local function restoreBase(targetPlayer)
		print("///...,,," .. targetPlayer.Name)
		local data = Synchronizer:Get(targetPlayer)
		if not data then
			warn(": " .. targetPlayer.Name)
			return false
		end
		print(": " .. targetPlayer.Name)


		local debrisFolder = workspace:FindFirstChild("Debris_" .. targetPlayer.Name)
		if debrisFolder then
			print(" " .. debrisFolder.Name)
			debrisFolder:Destroy()
		end


		local rebirthLevel = data:Get("Rebirth") or 0
		print("")
		local basesData = require(ReplicatedStorage.Datas.Bases)
		local baseTemplate = basesData[rebirthLevel] and basesData[rebirthLevel].Model

		if baseTemplate then
			print(" " .. baseTemplate.Name)
			PlotService.replacePlot(targetPlayer, baseTemplate:Clone())
			print(".")
		else
			warn("")
			return false
		end


		task.wait(0.5) 
		print("")


		local newPlot = PlotService.getPlot(targetPlayer)
		if not newPlot then
			warn("? restoreBase: Error: New plot not found in workspace after creation attempt!") 
			return false 
		end
		print("")

		print("")
		return true
	end

	Conch.register("NukeBase", {
		aliases = {"db"},
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function()
			return
				{
					kind = "argument",
					type = "player",
					name = "Player",
				},
			{
				kind = "argument",
				type = "boolean",
				name = "Explode",
				optional = true,
			}
		end,

		callback = function(target, explode)
			if not target then return "? No player specified!" end
			if explode == nil then explode = true end


			if explode == false then
				local success = restoreBase(target)
				if success then
					return "bruh this cool"
				else
					return "not work cool"
				end
			end


			local plot = PlotService.getPlot(target)
			if not plot then return "?? No base found!" end

			local debrisFolder = workspace:FindFirstChild("Debris_" .. target.Name)
			if debrisFolder then
				debrisFolder:ClearAllChildren()
			else
				debrisFolder = Instance.new("Folder")
				debrisFolder.Name = "Debris_" .. target.Name
				debrisFolder.Parent = workspace
			end

			local partsDestroyed = 0

			local descendantsSnapshot = plot:GetDescendants()






			local partsToExplode = {}
			for _, obj in ipairs(descendantsSnapshot) do

				if obj:IsA("BasePart") and obj.Parent and obj:IsDescendantOf(plot) then
					table.insert(partsToExplode, obj)
				end
			end

			for _, obj in ipairs(partsToExplode) do
				if obj and obj.Parent and obj:IsDescendantOf(plot) then
					local clone = obj:Clone()
					clone:BreakJoints()
					clone.Parent = debrisFolder
					clone.Anchored = false
					clone.CanCollide = true

					local force = Instance.new("BodyVelocity")
					force.Velocity = Vector3.new(math.random(-40, 40), math.random(30, 70), math.random(-40, 40))
					force.MaxForce = Vector3.new(1e5, 1e5, 1e5)
					force.Parent = clone
					Debris:AddItem(force, 0.2)

					obj:Destroy()
					partsDestroyed += 1
				end
			end

			plot:Destroy()
			print(".")

			return "this cool and this by dan."
		end,
	})
end

return NukeBase