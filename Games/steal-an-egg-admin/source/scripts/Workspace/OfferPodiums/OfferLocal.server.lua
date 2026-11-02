-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local v1 = require(ReplicatedStorage:WaitForChild("Data"):WaitForChild("MonetizationConfig"))
local Parent = script.Parent
local v2 = {}

local function track(v3) -- line 6 | captures: Parent, v2
    if v3:IsA("Model") and v3.Name == "Model" then
        local Parent_2 = v3.Parent
        if Parent_2 and Parent_2.Name == "OfferModel" and Parent_2.Parent and Parent_2.Parent.Parent == Parent then
            v2[v3] = v3:GetPivot()
        end
    end
end

for v4, v5 in Parent:GetDescendants() do
    track(v5)
end
Parent.DescendantAdded:Connect(track)
Parent.DescendantRemoving:Connect(function(v6) -- line 14 | captures: v2
    v2[v6] = nil
end)
RunService.RenderStepped:Connect(function() -- line 15 | captures: v1, Parent, v2
    local v7 = workspace:GetServerTimeNow()
    local v8 = v7 % v1.RotationSeconds * 3.141592653589793 * 2 / v1.RotationSeconds
    local v9 = v7 % v1.BobSeconds * 3.141592653589793 * 2 / v1.BobSeconds
    local v10 = math.sin(v9) * v1.BobHeight
    for v11, v12 in v2 do
        if v11:IsDescendantOf(Parent) then
            v11:PivotTo(CFrame.new(v12.Position + Vector3.new(0, v10, 0)) * CFrame.Angles(0, v8, 0) * v12.Rotation)
        else
            v2[v11] = nil
        end
    end
end)
