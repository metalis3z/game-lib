local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v1 = require(l_ReplicatedStorage_0.Packages.EmitModule);
local v2 = require(l_ReplicatedStorage_0.Packages.Net);
local v3 = require(l_ReplicatedStorage_0.UserGenerated.Lang.Janitor);
local v4 = l_ReplicatedStorage_0:WaitForChild("Assets"):WaitForChild("Tools"):WaitForChild("Flash Teleport");
local l_lightningdissapear_0 = v4:WaitForChild("lightningdissapear");
local l_lightningtrail_0 = v4:WaitForChild("lightningtrail");
local l_lightningappear_0 = v4:WaitForChild("lightningappear");
v2:RemoteEvent("Tools/Flash/Effects").OnClientEvent:Connect(function(v8, v9, v10)
    local l_Character_0 = v8.Character;
    if not l_Character_0 then
        return;
    elseif not l_Character_0.PrimaryPart then
        return;
    elseif not l_Character_0:FindFirstChildWhichIsA("Humanoid") then
        return;
    else
        local v12 = v3.new();
        local v13 = v12:Add(l_lightningdissapear_0:Clone());
        local v14 = v12:Add(l_lightningtrail_0:Clone());
        local v15 = v12:Add(l_lightningappear_0:Clone());
        v13:PivotTo(v9);
        v14:PivotTo(CFrame.lookAt(v10.Position, v9.Position) * CFrame.fromOrientation(-1.5707963267948966, 0, 0));
        v14.Size = Vector3.new(v14.Size.X, (v9.Position - v10.Position).Magnitude, v14.Size.Z);
        v15:PivotTo(v10);
        v13.Parent = workspace;
        v14.Parent = workspace;
        v15.Parent = workspace;
        v1.emit(v13, v14, v15).Finished:andThenCall(function()
            v12:Destroy();
        end);
        return;
    end;
end);
