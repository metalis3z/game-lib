

local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v3 = require(l_ReplicatedStorage_0.Controllers.CharacterController);
return {
    name = "control", 
    icon = "rbxassetid://136064800007852", 
    cooldown = 60, 
    description = "You are being controlled for 10 seconds!", 
    effects = {
        Executor = function(v4)
            local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
            local l_PlayerScripts_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts");
            local l_Controls_0 = require(l_PlayerScripts_0:WaitForChild("PlayerModule")):GetControls();
            workspace.CurrentCamera.CameraSubject = v4.Character and v4.Character:FindFirstChildWhichIsA("Humanoid");
            l_Controls_0.moveFunction = function(v8, v9, v10)
                v3:RequestMove(v4, v9, v10);
                v3:RequestMove(v8, Vector3.new(0, 0, 0, 0), v10);
            end;
            local _ = l_LocalPlayer_0.Character.Humanoid;
            local v12 = l_UserInputService_0.JumpRequest:Connect(function()
                v4.Character.Humanoid.Jump = true;
                l_LocalPlayer_0.Character.Humanoid.Jump = false;
            end);
            task.delay(5, function()
                l_Controls_0.moveFunction = v3.originalMoveFunction;
                if l_LocalPlayer_0 and l_LocalPlayer_0.Character then
                    workspace.CurrentCamera.CameraSubject = l_LocalPlayer_0.Character:FindFirstChildWhichIsA("Humanoid");
                end;
                if v12 then
                    v12:Disconnect();
                end;
            end);
        end, 
        Victim = function()
            local l_PlayerScripts_1 = l_Players_0.LocalPlayer:WaitForChild("PlayerScripts");
            local l_Controls_1 = require(l_PlayerScripts_1:WaitForChild("PlayerModule")):GetControls();
            local _ = l_Controls_1.moveFunction;
            l_Controls_1.moveFunction = function(_, _, _)

            end;
            task.delay(10, function()
                l_Controls_1.moveFunction = v3.originalMoveFunction;
            end);
        end
    }
};