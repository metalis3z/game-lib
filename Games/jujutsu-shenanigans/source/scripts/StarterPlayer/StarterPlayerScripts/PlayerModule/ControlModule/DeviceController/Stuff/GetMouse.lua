local LocalPlayer = game.Players.LocalPlayer

local Mouse = LocalPlayer:GetMouse()
LocalPlayer:GetMouse().TargetFilter = workspace.Effects
local module = {}

function module.GetMouseTarget(arg1, arg2)

		local CurrentCamera_3 = workspace.CurrentCamera
		local var38
		if var38 == nil then
			var38 = 300
		end
		if arg1.LastInput ~= "Mobile" then
			local Position = Mouse.Hit.Position
			local var40 = Position - CurrentCamera_3.CFrame.Position
			if var38 < var40.Magnitude then
				Position = CurrentCamera_3.CFrame.Position + var40.Unit * var38
			end
			return Position
		end
		local RaycastParams_new_result1 = RaycastParams.new()
		RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
		RaycastParams_new_result1.FilterDescendantsInstances = {LocalPlayer.Character, workspace.Effects}
		local var43 = CurrentCamera_3.CFrame.LookVector * var38
		local workspace_Raycast_result1 = workspace:Raycast((CurrentCamera_3.CFrame + CurrentCamera_3.CFrame.UpVector * 1).Position, var43, RaycastParams_new_result1)
		if workspace_Raycast_result1 then
			return workspace_Raycast_result1.Position
		end
		return CurrentCamera_3.CFrame.Position + var43
	end


return module