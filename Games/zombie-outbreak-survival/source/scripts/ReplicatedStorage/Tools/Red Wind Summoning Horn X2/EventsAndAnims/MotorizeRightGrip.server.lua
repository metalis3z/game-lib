-- MotorizeRightGrip (Improved & Expanded)
-- stravant's AnimEdit helper, to make sure tools actually animate.

function Create(ty)
    return function(data)
        local obj = Instance.new(ty)
        for k, v in data do
            if type(k) == 'number' then
                v.Parent = obj
            else
                obj[k] = v
            end
        end
        return obj
    end
end

local Tool = script.Parent.Parent

local armChildRemovedConn = nil
local Motor6DGrip = nil
local EquippedNum = 0

Tool.Equipped:Connect(function()
    EquippedNum = EquippedNum + 1
    local myEquip = EquippedNum
    local Player = game.Players:GetPlayerFromCharacter(Tool.Parent)
    local Character = Player and Player.Character or nil

    local rightarm = Character and Character:FindFirstChild('Right Arm') or nil
    if rightarm and rightarm:FindFirstChild('RightGrip') then
        local rightGrip = rightarm['RightGrip']
        local handle = rightGrip.Part1

        if armChildRemovedConn then
            armChildRemovedConn:Disconnect()
            armChildRemovedConn = nil
        end

        armChildRemovedConn = rightarm.ChildRemoved:Connect(function(ch)
            if ch == rightGrip then
                if Motor6DGrip then
                    Motor6DGrip:Remove()
                    Motor6DGrip = nil
                end
                if handle and Character and Character:FindFirstChild('Torso') then
                    if Tool.Parent.Parent:IsA('Player') then
                        handle.CFrame = CFrame.new(100000, 100000, 100000)
                    else
                        handle.CFrame = Character.Torso.CFrame * CFrame.new(0, 0, -(handle.Size.magnitude+2))
                    end
                end
            end
        end)

        Motor6DGrip = Create'Motor6D'{
            Name = 'RightGrip_Motor';
            Part0 = rightarm;
            Part1 = handle;
            C0 = CFrame.new(0, -1, 0, 1, 0, -0, 0, 0, 1, 0, -1, -0);
            C1 = CFrame.new(0.1, -0.6, 0.4, 1, 0, 0, 0, 0, -1, 0, 1, 0);
        }
        rightGrip.Part1 = nil
        rightGrip.Part0 = nil
        Motor6DGrip.Parent = rightGrip.Parent
    end
end)

Tool.Unequipped:Connect(function()
    EquippedNum = EquippedNum + 1
    if armChildRemovedConn then
        armChildRemovedConn:Disconnect()
        armChildRemovedConn = nil
    end
end)

