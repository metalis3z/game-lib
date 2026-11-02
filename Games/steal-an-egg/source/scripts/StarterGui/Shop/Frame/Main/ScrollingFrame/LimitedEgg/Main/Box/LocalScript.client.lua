-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local TweenService = game:GetService("TweenService")
local v1 = script.Parent
local Position = v1.Position
local v2 = UDim2.fromScale(0, -0.16)
local v3 = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
local v4 = TweenService:Create(v1, v3, {
	Position = Position + v2
})
local v5 = TweenService:Create(v1, v3, {
	Position = Position
})

while true do
	v4:Play()
	v4.Completed:Wait()
	v5:Play()
	v5.Completed:Wait()
end