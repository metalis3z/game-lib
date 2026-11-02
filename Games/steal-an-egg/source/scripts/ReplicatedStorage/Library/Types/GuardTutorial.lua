-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local t = require(ReplicatedStorage.Library.Modules.Packages.t)
local t2 = {
	StepIds = {
		StealEgg = "StealEgg",
		HeadToPen = "HeadToPen",
		EquipEgg = "EquipEgg",
		PlaceEgg = "PlaceEgg",
		HatchEgg = "HatchEgg",
		PlacePet = "PlacePet",
		ExpandPen = "ExpandPen",
		TreadmillIntro = "TreadmillIntro"
	},
	RunGuidanceStates = {
		Inactive = "Inactive",
		ForwardRun = "ForwardRun"
	},
	DEFAULT_PROGRESS = {
		Completed = false,
		CurrentStepId = nil
	}
}
local v1 = t.union(t.literal(t2.StepIds.StealEgg), t.literal(t2.StepIds.HeadToPen), t.literal(t2.StepIds.EquipEgg), t.literal(t2.StepIds.PlaceEgg), t.literal(t2.StepIds.HatchEgg), t.literal(t2.StepIds.PlacePet), t.literal(t2.StepIds.ExpandPen), t.literal(t2.StepIds.TreadmillIntro))

t2.SchemaValidation = {
	RunGuidanceState = t.union(t.literal(t2.RunGuidanceStates.Inactive), t.literal(t2.RunGuidanceStates.ForwardRun)),
	StepId = v1,
	Progress = t.interface({
		Completed = t.boolean,
		CurrentStepId = t.optional(v1)
	})
}
t2.SchemaValidation.ProgressUpdatePayload = t2.SchemaValidation.Progress
function t2.IsStepId(p1) --[[ IsStepId | Line: 90 | Upvalues: t2 (copy) ]]
	return t2.SchemaValidation.StepId(p1)
end
function t2.IsRunGuidanceState(p1) --[[ IsRunGuidanceState | Line: 94 | Upvalues: t2 (copy) ]]
	return t2.SchemaValidation.RunGuidanceState(p1)
end
function t2.CloneProgress(p1) --[[ CloneProgress | Line: 98 ]]
	local t = {}

	t.Completed = p1.Completed == true
	t.CurrentStepId = p1.CurrentStepId

	return t
end
function t2.NormalizeProgress(p1) --[[ NormalizeProgress | Line: 105 | Upvalues: t2 (copy) ]]
	if p1 == nil then
		return t2.CloneProgress(t2.DEFAULT_PROGRESS)
	end

	if not t2.SchemaValidation.Progress(p1) then
		return t2.CloneProgress(t2.DEFAULT_PROGRESS)
	end

	local t = {}

	t.Completed = p1.Completed == true
	t.CurrentStepId = p1.CurrentStepId

	if t.Completed then
		t.CurrentStepId = nil
	end

	return t
end

return t2