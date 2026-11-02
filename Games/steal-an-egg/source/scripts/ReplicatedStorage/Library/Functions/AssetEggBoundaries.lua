-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Boundary = ReplicatedStorage.Assets.Extra.Boundary

return {
	createBoundary = function(p1) --[[ createBoundary | Line: 17 | Upvalues: Asserts (copy), Boundary (copy), Constants (copy) ]]
		Asserts.Model(p1)

		local Boundary2 = p1:FindFirstChild("Boundary")

		if Boundary2 then
			return Boundary2
		end

		local Boundary3 = Boundary:Clone()

		Boundary3.Size = Vector3.new(0.15, Constants.MIN_PLACE_GRID_SIZE, Constants.MIN_PLACE_GRID_SIZE)
		Boundary3.CFrame = p1:GetPivot() * CFrame.fromEulerAnglesXYZ(0, 0, 1.5707963267948966)
		Boundary3.Name = "Boundary"
		Boundary3.Anchored = true
		Boundary3.CanCollide = false
		Boundary3.Color = Color3.fromRGB(248, 248, 248)
		Boundary3.Transparency = 0.9
		Boundary3:SetAttribute("MutationFXDontRender", true)
		Boundary3:SetAttribute("EggBoundary", true)
		Boundary3.Parent = p1

		return Boundary3
	end,
	createServerBoundary = function(p1) --[[ createServerBoundary | Line: 39 | Upvalues: Asserts (copy), Constants (copy) ]]
		Asserts.Model(p1)

		local ServerBoundary = p1:FindFirstChild("ServerBoundary")

		if ServerBoundary then
			return ServerBoundary
		end

		local ServerBoundary2 = Instance.new("Part")

		ServerBoundary2.Name = "ServerBoundary"
		ServerBoundary2.Size = Vector3.new(0.15, Constants.SERVER_MIN_GRID_SIZE, Constants.SERVER_MIN_GRID_SIZE)
		ServerBoundary2.CFrame = p1:GetPivot() * CFrame.fromEulerAnglesXYZ(0, 0, 1.5707963267948966)
		ServerBoundary2.Anchored = true
		ServerBoundary2.CanCollide = false
		ServerBoundary2.Transparency = 1
		ServerBoundary2:SetAttribute("MutationFXDontRender", true)
		ServerBoundary2:SetAttribute("EggBoundary", true)
		ServerBoundary2.Parent = p1

		return ServerBoundary2
	end
}