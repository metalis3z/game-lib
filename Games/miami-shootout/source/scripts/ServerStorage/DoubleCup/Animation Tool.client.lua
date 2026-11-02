--Instert in Tool
local tool = script.Parent
local anim = Instance.new("Animation")
anim.AnimationId = "http://www.roblox.com/Asset?ID=15058933946" --Animation ID
local track
tool.Equipped:Connect(function()
    track = script.Parent.Parent.Humanoid:LoadAnimation(anim)
    track.Priority = Enum.AnimationPriority.Action3
    track.Looped = true
    track:Play()
end)
tool.Unequipped:Connect(function()
    if track then
        track:Stop()
    end
end)

--NicolasBTS90




































--ABDUZCAN!