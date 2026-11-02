
local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Packages.FFlags)
local u3 = require(v1.Packages.Observers)
local u4 = script.Part
local u5 = {}
local u6 = nil
local function v11()
    if u2:GetInstant("Optimisation.EmitThroughPart", true) then
        if not u6 then
            u6 = u3.observeTag("EmitThroughPart", function(u7)
                if u2:GetInstant("Optimisation.EmitThroughPart", true) then
                    local u8 = u7.Parent
                    if u8:IsA("Attachment") then
                        local u9 = u5[u8]
                        if not u9 then
                            u9 = u4:Clone()
                            u9.RigidConstraint.Attachment0 = u8
                            u9.Parent = u8
                            local u10 = u9.__derp_a1
                            u10.ChildRemoved:Connect(function(_)
                                if u10:FindFirstChildOfClass("ParticleEmitter") == nil then
                                    u9:Destroy()
                                    u5[u8] = nil
                                end
                            end)
                            u5[u8] = u9
                        end
                        u7.Parent = u9.__derp_a1
                        return function()
                            pcall(function()
                                u7.Parent = u8
                            end)
                        end
                    end
                end
            end, { workspace })
            return
        end
    elseif u6 then
        u6()
        u6 = nil
    end
end
if u2:GetInstant("Optimisation.EmitThroughPart", true) then
    if not u6 then
        u6 = u3.observeTag("EmitThroughPart", function(u12)
            if u2:GetInstant("Optimisation.EmitThroughPart", true) then
                local u13 = u12.Parent
                if u13:IsA("Attachment") then
                    local u14 = u5[u13]
                    if not u14 then
                        u14 = u4:Clone()
                        u14.RigidConstraint.Attachment0 = u13
                        u14.Parent = u13
                        local u15 = u14.__derp_a1
                        u15.ChildRemoved:Connect(function(_)
                            if u15:FindFirstChildOfClass("ParticleEmitter") == nil then
                                u14:Destroy()
                                u5[u13] = nil
                            end
                        end)
                        u5[u13] = u14
                    end
                    u12.Parent = u14.__derp_a1
                    return function()
                        pcall(function()
                            u12.Parent = u13
                        end)
                    end
                end
            end
        end, { workspace })
    end
elseif u6 then
    u6()
    u6 = nil
end
u2:OnChange("Optimisation.EmitThroughPart", v11)