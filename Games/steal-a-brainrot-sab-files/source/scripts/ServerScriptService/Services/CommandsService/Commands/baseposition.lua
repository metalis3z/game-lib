local module = function(Conch, Config)

	local Workspace = game:GetService("Workspace")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local ServerScriptService = game:GetService("ServerScriptService")
	local Players = game:GetService("Players")

	local PlotService = require(ServerScriptService.Services.PlotService)
	local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)

	Conch.register("baseposition", {
		permissions = { Config.RequiredRole or "super-user" },

		arguments = function() return { kind = "argument", type = "player", name = "Player", }, { kind = "argument", type = "number", name = "Position" } end,

		callback = function(targetPlayer: Player, position: number)
			position = tonumber(position)
			if not position or position < 1 then
				return false, "Position must be >= 1"
			end

			local playerPlot = PlotService.getPlot(targetPlayer)
			if not playerPlot then
				return false, "Player has no plot"
			end

			local targetPlot
			for _, plot in ipairs(workspace.Plots:GetChildren()) do
				if plot:GetAttribute("Order") == position then
					targetPlot = plot
					break
				end
			end

			if not targetPlot then
				return "position has to be between 2-8"
			end

			if targetPlot == playerPlot then
				return "Already on this position"
			end

			for _, plr in ipairs(Players:GetPlayers()) do
				if PlotService.getPlot(plr) == targetPlot then
					return false, "Target position is occupied"
				end
			end

			local cfA = playerPlot:GetPivot()
			local cfB = targetPlot:GetPivot()

			playerPlot:PivotTo(cfB)
			targetPlot:PivotTo(cfA)

			local orderA = playerPlot:GetAttribute("Order")
			local orderB = targetPlot:GetAttribute("Order")

			playerPlot:SetAttribute("Order", orderB)
			targetPlot:SetAttribute("Order", orderA)

			local channel = Synchronizer:Get(playerPlot.Name)
			if channel then
				channel:Set("AnimalList", channel:Get("AnimalList"))
				channel:Set("Owner", channel:Get("Owner"))
			end

			local spawn = playerPlot:FindFirstChild("Spawn")
			if spawn and targetPlayer.Character then
				local hrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					hrp.CFrame = spawn.CFrame
				end
			end

			return "set"
		end
	})
end

return module