local Event = game.ReplicatedStorage.Physics
local Camera = workspace.CurrentCamera
local Player = game:GetService("Players").LocalPlayer

Event.OnClientEvent:Connect(function(model, humanoid, plr, recovered)
    if plr == Player and not recovered then
		Camera.CameraSubject = model.Head
		humanoid:ChangeState("Physics")
	elseif plr == Player and recovered then
		Camera.CameraSubject = model.Humanoid
		humanoid:ChangeState("Ragdoll")
	end
end)