-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2026-04-25 14:19:33
-- Luau version 7, Types version 3
-- Time taken: 0.001167 seconds

local any_Create_result1 = game:GetService("TweenService"):Create(script.Parent, TweenInfo.new(3, Enum.EasingStyle.Linear), {
	Position = UDim2.new(1.5, 0, 0, 0);
})
while true do
	script.Parent.Position = UDim2.new(0.5, 0, 0, 0)
	any_Create_result1:Play()
	any_Create_result1.Completed:Wait()
end