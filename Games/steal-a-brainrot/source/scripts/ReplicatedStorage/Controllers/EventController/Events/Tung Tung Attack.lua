local _ = game:GetService("PathfindingService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v7 = {};
local v8 = require(l_ReplicatedStorage_0.Controllers.EventController.ClientEventUtils);
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v10 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local v11 = require(l_ReplicatedStorage_0.Controllers.EventController);
local v12 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local _ = require(l_ReplicatedStorage_0.Packages.Synchronizer);
local v14 = require(l_ReplicatedStorage_0.Shared.TweenPivot);
local v15 = require(l_ReplicatedStorage_0.Packages.Observers);
local v16 = require(l_ReplicatedStorage_0.Datas.ServerData);
local v17 = require(l_ReplicatedStorage_0.Packages.Trove);
local v18 = require(l_ReplicatedStorage_0.Packages.Net);
local _ = require(l_ReplicatedStorage_0.Shared.VFX);
local l_Name_0 = script.Name;
local v21 = v18:RemoteEvent("EventService/Tung Tung Attack/Hit");
local v22 = v17.new();
local v23 = {
    script.Tung1, 
    script.Tung2
};
v7.OnStart = function(_)
    local l_v11_ActiveEventData_0 = v11:GetActiveEventData(l_Name_0);
    assert(l_v11_ActiveEventData_0);
    local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
    v12:Update();
    v10:UpdateOST();
    local v27 = script["Tung Tung Tung Sahur"]:Clone();
    local v28 = v27:GetPivot() - Vector3.new(0, 0, v16.IsBiggerServer() and 251 or 0);
    v27:PivotTo(v28 - Vector3.new(0, 40, 0, 0));
    v27.Parent = workspace;
    local v29 = if v16.IsBiggerServer() then script.VFXBigger:Clone() else script.VFX:Clone();
    v29.Parent = workspace;
    local v30 = v27.AnimationController.Animator:LoadAnimation(script.GiantTungTung);
    v30.Looped = false;
    v30.Priority = Enum.AnimationPriority.Action4;
    v30:Play(0);
    local v31 = v27.AnimationController.Animator:LoadAnimation(script.GiantTungTungIdle);
    v31.Looped = true;
    v31.Priority = Enum.AnimationPriority.Idle;
    v31:Play(0);
    v22:Add(task.spawn(function()
        while v30.Length == 0 do
            task.wait();
        end;
        v10:PlaySound("Sounds.Events.Tung Tung Attack.BigTungTungSpawn");
        v30:Stop(0);
        v30.TimePosition = 0;
        v30:Play(0);
        v22:Add(v14(v27, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), v28)):Play();
    end));
    v22:Add(function()
        v14(v27, TweenInfo.new(3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), v28 - Vector3.new(0, 40, 0, 0)):Play();
        for _, v33 in v29:GetDescendants() do
            if v33:IsA("ParticleEmitter") then
                v33.Enabled = false;
            end;
        end;
        task.wait(5);
        v29:Destroy();
        v27:Destroy();
        v31:Stop(0);
        v31:Destroy();
        v30:Stop(0);
        v30:Destroy();
    end);
    local v34 = Random.new();
    v22:Add(v15.observeTag("BabyTungTung", function(v35)
        local v36 = true;
        local v38 = task.spawn(function()
            while v36 do
                local v37 = v23[v34:NextInteger(1, #v23)]:Clone();
                v37.Parent = v35:FindFirstChild("HumanoidRootPart") or v35;
                v37:Play();
                v37.Ended:Once(function()
                    task.wait(0.1);
                    v37:Destroy();
                end);
                task.wait(v34:NextNumber(2, 4));
            end;
        end);
        return function()
            v36 = false;
            pcall(task.cancel, v38);
        end;
    end));
    if not v16.IsTsunamiServer() then
        local v39 = l_v11_ActiveEventData_0.startedAt + 10 - l_workspace_ServerTimeNow_0;
        local v40 = script.Caves:Clone();
        local v41 = script.Caves2:Clone();
        for _, v43 in {
            v40["1"], 
            v40["2"], 
            v40["3"], 
            v41["4"], 
            v41["5"], 
            v41["6"]
        } do
            v10:PlaySound("Sounds.Events.Tung Tung Attack.Cave", v43:GetPivot().Position);
        end;
        v40.Parent = workspace;
        v41.Parent = workspace;
        local l_v40_Pivot_0 = v40:GetPivot();
        local l_v41_Pivot_0 = v41:GetPivot();
        v22:Add(v14(v40, TweenInfo.new(v39, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), l_v40_Pivot_0 * CFrame.new(0, 0, 6))):Play();
        v22:Add(v14(v41, TweenInfo.new(v39, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), l_v41_Pivot_0 * CFrame.new(0, 0, 6))):Play();
        v22:Add(function()
            v14(v40, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), l_v40_Pivot_0):Play();
            v14(v41, TweenInfo.new(5, Enum.EasingStyle.Quint, Enum.EasingDirection.In), l_v41_Pivot_0):Play();
            task.wait(5);
            v40:Destroy();
            v41:Destroy();
        end);
        v22:Add(task.delay(v39, function()
            for _, v47 in v29.Cave:GetDescendants() do
                if v47:IsA("ParticleEmitter") then
                    v47.Enabled = true;
                end;
            end;
        end));
    end;
end;
v7.OnStop = function(_)
    v22:Destroy();
end;
v7.OnLoad = function(_)
    v21.OnClientEvent:Connect(function(v50)
        v8.playBurst(script.TungTungHit, v50);
    end);
end;
return v7;