
local function v_u_4(p1, p2)
    if p1:GetAttribute("__RECOLOR") ~= false then
        if p1:IsA("BasePart") then
            p1.Color = p2
        elseif p1:IsA("SurfaceAppearance") then
            p1.Color = p2
        elseif p1:IsA("Highlight") then
            p1.FillColor = p2
            p1.OutlineColor = p2
        elseif p1:IsA("ParticleEmitter") then
            p1.Color = ColorSequence.new(p2)
        end
    end
    for _, v3 in ipairs(p1:GetChildren()) do
        v_u_4(v3, p2)
    end
end
return v_u_4