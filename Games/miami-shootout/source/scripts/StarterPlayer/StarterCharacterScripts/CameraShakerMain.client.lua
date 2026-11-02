-- Decompiled with the Synapse X Luau decompiler.

ShakeDist = 1;
local l__CurrentCamera__1 = workspace.CurrentCamera;
local u2 = require(game.ReplicatedStorage.CameraShaker).new(Enum.RenderPriority.Camera.Value, function(p1)
	l__CurrentCamera__1.CFrame = l__CurrentCamera__1.CFrame * p1;
end);
game.Workspace.DescendantAdded:Connect(function(p2)
	if p2:IsA("Explosion") and (game.Players.LocalPlayer.Character.Head.Position - p2.Position).magnitude / (p2.BlastRadius / 1) < ShakeDist then
		u2:Start();
		u2:ShakeOnce(p2.BlastRadius / 2, 10, 0, 1.5);
	end;
end);
