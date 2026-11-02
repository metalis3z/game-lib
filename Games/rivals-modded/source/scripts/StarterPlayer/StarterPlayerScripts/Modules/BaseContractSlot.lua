-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Utility = require(ReplicatedStorage.Modules.Utility);
local RewardSlot = require(Players.LocalPlayer.PlayerScripts.Modules.RewardSlot);
local ContractMilestoneSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ContractMilestoneSlot");
local ContractSlot = Players.LocalPlayer.PlayerScripts.UserInterface:WaitForChild("ContractSlot");
local UDim2_new_ret = UDim2.new(0.05, 0, 0.75, 0);
local u1 = {};
u1.__index = u1;

function u1.new(p2, p3) -- Line: 16
    -- upvalues: u1 (copy), ContractSlot (copy)
    local v4 = setmetatable({}, u1);
    v4.Frame = ContractSlot:Clone();
    v4._num_milestones = 0;
    v4._progress = 0;
    v4._scale = 1;
    v4._milestones = {};
    v4._default_tostring_function = nil;
    v4._requires_previous_milestone_completed = true;
    v4._contract_icon_image = nil;
    v4._contract_icon_size = nil;
    v4:_Init();

    return v4;
end;

function u1.SetImage(p5, p6, p7) -- Line: 39
    p5.Frame.Container.Title.Left.Image = p6;
    p5.Frame.Container.Title.Left.Size = p7 or p5.Frame.Container.Title.Left.Size;
end;

function u1.SetContractImage(p8, p9, p10) -- Line: 44
    p8._contract_icon_image = p9;
    p8._contract_icon_size = p10;
    p8:_Update();
end;

function u1.SetTitle(p11, p12) -- Line: 50
    p11.Frame.Container.Title.Text = p12;
end;

function u1.SetDescription(p13, p14, p15) -- Line: 54
    p13.Frame.Container.Description.Text = p14;
    p13.Frame.Container.Description.Size = UDim2.new(0.9, 0, 0.025 * (p15 or 1), 0);
    p13:_Update();
end;

function u1.SetScale(p16, p17) -- Line: 60
    p16._scale = p17;
    p16:_Update();
end;

function u1.SetProgress(p18, p19) -- Line: 65
    p18._progress = p19;
    p18:_Update();
end;

function u1.SetRequiresPreviousMilestoneCompleted(p20, p21) -- Line: 70
    p20._requires_previous_milestone_completed = p21;
    p20:_Update();
end;

function u1.AddMilestone(p22, p23, p24, p25) -- Line: 75
    -- upvalues: ContractMilestoneSlot (copy), RewardSlot (copy)
    p22._num_milestones = p22._num_milestones + 1;
    local v26 = ContractMilestoneSlot:Clone();
    v26.LayoutOrder = p22._num_milestones;
    v26.ZIndex = p22._num_milestones;
    v26.Goal.Visible = v26.Contract.Visible;
    v26.Parent = p22.Frame.Container.Milestones;
    table.insert(p22._milestones, {
        v26,
        p23,
        p24,
        p25 or p22._default_tostring_function
    });

    if p24 then
        RewardSlot.new(p24).Frame.Parent = v26.Reward;
    end;

    p22:_Update();
end;

function u1.Destroy(p27) -- Line: 93
    p27.Frame:Destroy();
end;

function u1._Update(p28) -- Line: 101
    -- upvalues: UDim2_new_ret (copy)
    p28.Frame.Container.Milestones.Position = UDim2.new(0, 0, 0.1 + (p28.Frame.Container.Description.Text == "" and 0 or (0.01 + p28.Frame.Container.Description.Size.Y.Scale or 0)), 0);
    p28.Frame.Container.Size = UDim2.new(1, 0, 1 * p28._scale, 0);
    p28.Frame.Size = UDim2.new(1, 0, (p28.Frame.Container.Milestones.Position.Y.Scale + 0.075 * p28._num_milestones + 0.025) * p28._scale, 0);
    local v29 = true;

    for _, v in pairs(p28._milestones) do
        local table_unpack_ret, v30, _, v31 = table.unpack(v);
        local v32 = p28._requires_previous_milestone_completed and not v29;
        v29 = v30 <= p28._progress;
        table_unpack_ret.Contract.Image = p28._contract_icon_image or "rbxassetid://17619445009";
        table_unpack_ret.Contract.Size = p28._contract_icon_size or UDim2_new_ret;
        table_unpack_ret.Progress.Bar.Visible = not v32;
        table_unpack_ret.Locked.Visible = v32;
        table_unpack_ret.Completed.Visible = not v32 and v29;
        table_unpack_ret.Contract.Visible = not v32 and not v29;
        table_unpack_ret.Progress.Bar.Size = UDim2.new(math.clamp(p28._progress / v30, 0, 1), 0, 1, 2);
        table_unpack_ret.Progress.Bar.BackgroundColor3 = v29 and Color3.fromRGB(100, 255, 50) or Color3.fromRGB(0, 190, 255);
        table_unpack_ret.Goal.Visible = not v32 and not v29;
        table_unpack_ret.Goal.Text = v31(p28._progress) .. " / " .. v31(v30);
    end;
end;

function u1._Setup(p33) -- Line: 128
    -- upvalues: Utility (copy)
    function p33._default_tostring_function(...) -- Line: 129
        -- upvalues: Utility (ref)
        return Utility:PrettyNumber(...);
    end;
end;

function u1._Init(p34) -- Line: 134
    p34:_Setup();
    p34:SetImage("");
    p34:SetTitle("");
    p34:SetDescription("");
    p34:SetScale(1);
    p34:SetProgress(0);
    p34:SetRequiresPreviousMilestoneCompleted(true);
end;

return u1;