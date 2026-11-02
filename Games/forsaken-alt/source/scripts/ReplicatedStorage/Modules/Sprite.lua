-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
v0.Images = {};
local v1 = require(script.XML);
local v2 = require(script.Signal);
function AddPosV2(v3, v4) --[[ Line: 7 ]] --[[ Name: AddPosV2 ]]
    v3.Position = UDim2.new(v3.Position.X.Scale, v3.Position.X.Offset + v4.X, v3.Position.Y.Scale, v3.Position.Y.Offset + v4.Y);
end;
v0.new = function(v5, v6, v7, v8, v9) --[[ Line: 16 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), v0 (copy)
    local v10 = v2();
    local v11 = v2();
    local v12 = v2();
    local v13 = {
        GUI = v5, 
        Animations = {}, 
        DefaultId = nil, 
        CurrAnimation = "", 
        Timer = 0, 
        Frame = 1, 
        Alpha = 1, 
        Factor = v7 or 1, 
        Visible = true, 
        FrameRate = 60, 
        ChangeSize = v6 or false, 
        Size = {
            X = 0, 
            Y = 0
        }, 
        Scale = Vector2.new(1, 1), 
        Offset = Vector2.new(), 
        FrameOffset = Vector2.new(), 
        ClipRect = Vector2.new(), 
        Finished = false, 
        UseScale = v8 or false, 
        ScaleFactors = v9 or nil, 
        FlipHorizontally = false, 
        FlipVertically = false, 
        overrideAlpha = false, 
        AnimData = {}, 
        _NextFrame = v10, 
        NextFrame = v10.Event, 
        _AnimationFinished = v11, 
        AnimationFinished = v11.Event, 
        _AnimationLooped = v12, 
        AnimationLooped = v12.Event
    };
    setmetatable(v13, v0);
    v13:AddAnimation("default", {
        {
            Size = v5.ImageRectSize, 
            Offset = v5.ImageRectOffset
        }
    });
    v13:PlayAnimation("default");
    table.insert(v0.Images, v13);
    return v13;
end;
v0.AddAnimation = function(v14, v15, v16, v17, v18, v19) --[[ Line: 62 ]] --[[ Name: AddAnimation ]]
    v14.Animations[v15] = {
        Frames = v16 or {}, 
        Looped = v18, 
        FrameRate = v17 or 30, 
        ImageId = v19 or v14.GUI.Image
    };
    return v14.Animations[v15];
end;
local v20 = {};
local v21 = {};
v0.AddSparrowXML = function(v22, v23, v24, v25, v26, v27, v28) --[[ Line: 73 ]] --[[ Name: AddSparrowXML ]]
    -- upvalues: v21 (copy), v1 (copy), v20 (copy)
    local v29 = v28 or v22.Factor;
    local v30 = v21[v23] or v1.parse(require(v23), true);
    if v21[v23] == nil then
        v21[v23] = v30;
    end;
    local v31 = {};
    for _, v33 in next, v30.children[1].children do
        if v33.tag == "SubTexture" and v33.attrs.name:sub(1, #v25) == v25 then
            local l_attrs_0 = v33.attrs;
            local v35 = Vector2.new(tonumber(l_attrs_0.x) / v29, tonumber(l_attrs_0.y) / v29);
            local v36 = Vector2.new(tonumber(l_attrs_0.width) / v29, tonumber(l_attrs_0.height) / v29);
            local v37 = Vector2.new(tonumber(l_attrs_0.width), (tonumber(l_attrs_0.height)));
            local v38 = nil;
            v38 = if l_attrs_0.frameX and l_attrs_0.frameY and l_attrs_0.frameWidth and l_attrs_0.frameHeight then Vector2.new((tonumber(l_attrs_0.frameX) or 0) / (v29 / 3) + tonumber(l_attrs_0.frameWidth) / v29, (tonumber(l_attrs_0.frameY) or 0) / (v29 / 3) + tonumber(l_attrs_0.frameHeight) / v29) else Vector2.new();
            table.insert(v31, {
                Offset = v35, 
                Size = v36, 
                FrameSize = v37, 
                frameOffset = v38
            });
        end;
    end;
    if #v31 == 0 and not table.find(v20, v24) then
        v20[#v20 + 1] = v24;
    end;
    return v22:AddAnimation(v24, v31, v26, v27);
end;
v0.ResetAnimation = function(v39) --[[ Line: 121 ]] --[[ Name: ResetAnimation ]]
    v39.Finished = false;
    v39.Frame = 1;
    v39.Timer = 0;
    local v40 = v39.AnimData.Frames[1];
    v39.GUI.ImageRectSize = v40.Size * Vector2.new(v39.FlipHorizontally and -1 or 1, v39.FlipVertically and -1 or 1);
    v39.GUI.ImageRectOffset = v40.Offset + Vector2.new(v39.FlipHorizontally and v40.Size.X or 0, v39.FlipVertically and v40.Size.Y or 0);
    v39.FrameOffset = v40.frameOffset and v40.frameOffset * v39.Scale or Vector2.new();
    v39.Offset = v40.Offset;
    if v40.FrameSize then
        v39.Size = {
            X = v40.FrameSize.X, 
            Y = v40.FrameSize.Y
        };
        v39:UpdateSize();
    end;
end;
v0.PlayAnimation = function(v41, v42, v43) --[[ Line: 143 ]] --[[ Name: PlayAnimation ]]
    if not v41.Animations[v42] then
        warn(v42 .. " is not a valid animation");
        return;
    else
        if v41.Animations[v42].ImageId and v41.Animations[v42].ImageId ~= v41.GUI.Image then
            v41.GUI.Image = v41.Animations[v42].ImageId;
        end;
        if (v41.CurrAnimation ~= v42 or v43) and v41.Animations[v42] then
            v41.AnimData = v41.Animations[v42];
            v41.FrameRate = v41.Animations[v42].FrameRate;
            v41.CurrAnimation = v42;
            v41:ResetAnimation();
        end;
        return;
    end;
end;
v0.StopAnimation = function(v44) --[[ Line: 156 ]] --[[ Name: StopAnimation ]]
    v44:ResetAnimation();
    v44.Finished = true;
end;
v0.Reset = function(v45) --[[ Line: 161 ]] --[[ Name: Reset ]]
    -- upvalues: v0 (copy)
    v0:StopAnimation();
    v45.Destroyed = true;
    for v46 = #v0.Images, 1, -1 do
        if v0.Images[v46] == v45 then
            table.remove(v0.Images, v46);
            break;
        end;
    end;
    for v47, _ in next, v45 do
        v45[v47] = nil;
    end;
end;
v0.Destroy = function(v49) --[[ Line: 175 ]] --[[ Name: Destroy ]]
    -- upvalues: v0 (copy)
    v49.Destroyed = true;
    for v50 = #v0.Images, 1, -1 do
        if v0.Images[v50] == v49 then
            table.remove(v0.Images, v50);
            break;
        end;
    end;
    pcall(game.Destroy, v49.GUI);
    for v51, _ in next, v49 do
        v49[v51] = nil;
    end;
end;
v0.UpdateSize = function(v53) --[[ Line: 187 ]] --[[ Name: UpdateSize ]]
    if v53.ChangeSize and v53.GUI and v53.GUI.Parent then
        local v54 = v53.AnimData.Frames[v53.Frame];
        if v53.UseScale then
            v53.GUI.Size = UDim2.new(v54.FrameSize.X * v53.Scale.X / (v53.ScaleFactors or v53.GUI.Parent.AbsoluteSize).X, 0, v54.FrameSize.Y * v53.Scale.Y / (v53.ScaleFactors or v53.GUI.Parent.AbsoluteSize).Y, 0);
            return;
        else
            v53.GUI.Size = UDim2.new(0, v54.FrameSize.X * v53.Scale.X, 0, v54.FrameSize.Y * v53.Scale.Y);
        end;
    end;
end;
v0.Update = function(v55, v56) --[[ Line: 200 ]] --[[ Name: Update ]]
    if not v55.Finished then
        v55.Timer = v55.Timer + v56;
        while v55.Timer > 1 / v55.FrameRate do
            v55.Timer = v55.Timer - 1 / v55.FrameRate;
            v55.Frame = v55.Frame + 1;
            v55._NextFrame:Fire(v55.Frame);
            if v55.Frame >= #v55.AnimData.Frames then
                if v55.AnimData.Looped then
                    v55._AnimationLooped:Fire(v55.CurrAnimation);
                    v55.Frame = 1;
                else
                    v55.Frame = #v55.AnimData.Frames;
                    v55._AnimationFinished:Fire(v55.CurrAnimation);
                    v55.Finished = true;
                    v55.CurrAnimation = "";
                end;
            end;
            local v57 = v55.AnimData.Frames[v55.Frame];
            if v57.FrameSize then
                v55.Size = {
                    X = v57.FrameSize.X, 
                    Y = v57.FrameSize.Y
                };
                if v55.ChangeSize then
                    v55:UpdateSize();
                end;
            end;
            v55.FrameOffset = (v57.frameOffset or Vector2.new()) * v55.Scale;
            v55.GUI.ImageRectSize = v57.Size * Vector2.new(v55.FlipHorizontally and -1 or 1, v55.FlipVertically and -1 or 1);
            v55.GUI.ImageRectOffset = v57.Offset + Vector2.new(v55.FlipHorizontally and v57.Size.X or 0, v55.FlipVertically and v57.Size.Y or 0);
        end;
    end;
    if not v55.overrideAlpha then
        if v55.Visible then
            v55.GUI.ImageTransparency = 1 - v55.Alpha;
            return;
        else
            v55.GUI.ImageTransparency = 1;
        end;
    end;
end;
game:GetService("RunService").Heartbeat:Connect(function(v58) --[[ Line: 242 ]]
    -- upvalues: v0 (copy)
    for _, v60 in next, v0.Images do
        if v60.GUI.Parent and v60.GUI and not v60.Destroyed then
            v60:Update(v58);
        end;
    end;
end);
return v0;