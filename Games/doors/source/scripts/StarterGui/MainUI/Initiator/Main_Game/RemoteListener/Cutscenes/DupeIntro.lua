-- Decompiled with the Synapse X Luau decompiler.

local v1 = script:FindFirstAncestor("MainUI");
local l__Bricks__2 = game:GetService("ReplicatedStorage"):WaitForChild("Bricks");
local l__TweenService__1 = game:GetService("TweenService");

local runService = game:GetService("RunService")

local lodl = false

return function(p1)
	
	local l__unit__5 = (p1.finalCamCFrame.LookVector * Vector3.new(-1, 0, -1) + Vector3.new(0, 0, 0)).unit;
	
	p1 = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
	p1.freemouse = true;
	
	p1.cam.CameraSubject = p1.char:WaitForChild("Head");
	p1.ay_t = 0
	
	local camera = workspace.CurrentCamera
	local head = p1.char:WaitForChild("Head")
	
	head.LocalTransparencyModifier = 1
	
	for i,v in pairs(p1.char:GetChildren()) do
		if v:IsA("Accessory") then
			if v:FindFirstChildOfClass("Part") then
				v:FindFirstChildOfClass("Part").Transparency = 1
			elseif v:FindFirstChildOfClass("MeshPart") then
				v:FindFirstChildOfClass("MeshPart").Transparency = 1
			elseif v:FindFirstChildOfClass("BasePart") then
				v:FindFirstChildOfClass("BasePart").Transparency = 1
			end
		end
	end
	
	local event = runService.RenderStepped:Connect(function()
		camera.CFrame = head.CFrame
	end)
	
	wait(4.5)
	
	event:Disconnect()
	for i,v in pairs(p1.char:GetChildren()) do
		if v:IsA("Accessory") then
			if v:FindFirstChildOfClass("Part") then
				v:FindFirstChildOfClass("Part").Transparency = 0
			elseif v:FindFirstChildOfClass("MeshPart") then
				v:FindFirstChildOfClass("MeshPart").Transparency = 0
			elseif v:FindFirstChildOfClass("BasePart") then
				v:FindFirstChildOfClass("BasePart").Transparency = 0
			end
		end
	end
	p1.cam.CameraSubject = p1.char:WaitForChild("Humanoid");
	p1.freemouse = false;
	p1.update();
end;
