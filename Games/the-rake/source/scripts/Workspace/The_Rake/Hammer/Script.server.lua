local Smashed = script.Parent.Parent.Head.Smashed
local HeadMesh = script.Parent.Parent.Head
local AnchorPart = script.Parent.Parent
local Debounce = false

while true do
	wait()
	if script.Parent.Value == true and Debounce == false then
		Debounce = true
		Smashed.HeadPart.Transparency = 0
		Smashed.HeadTexture.Transparency = 0.75
		Smashed.Eye1.Transparency = 0
		Smashed.Eye1Base.Transparency = 0
		Smashed.Eye2.Transparency = 0
		Smashed.Eye2Base.Transparency = 0
		HeadMesh.HeadPart.Transparency = 1
		HeadMesh.HeadTexture.Transparency = 1
		HeadMesh.Eye1.Transparency = 1
		HeadMesh.Eye1Base.Transparency = 1
		HeadMesh.Eye2.Transparency = 1
		HeadMesh.Eye2Base.Transparency = 1
		AnchorPart.Head.Anchored = true
		AnchorPart.Torso.Anchored = true
		AnchorPart["Right Arm"].Anchored = true
		AnchorPart["Right Leg"].Anchored = true
		AnchorPart["Left Arm"].Anchored = true
		AnchorPart["Left Leg"].Anchored = true
		Smashed.HeadPart.BillboardGui.Enabled = true
		wait(0.5)
		Smashed.HeadPart.BillboardGui.Enabled = false
		wait(4.5)
		Smashed.HeadPart.Transparency = 1
		Smashed.HeadTexture.Transparency = 1
		Smashed.Eye1.Transparency = 1
		Smashed.Eye1Base.Transparency = 1
		Smashed.Eye2.Transparency = 1
		Smashed.Eye2Base.Transparency = 1
		HeadMesh.HeadPart.Transparency = 0
		HeadMesh.HeadTexture.Transparency = 0.75
		HeadMesh.Eye1.Transparency = 0
		HeadMesh.Eye1Base.Transparency = 0
		HeadMesh.Eye2.Transparency = 0
		HeadMesh.Eye2Base.Transparency = 0
		AnchorPart.Head.Anchored = false
		AnchorPart.Torso.Anchored = false
		AnchorPart["Right Arm"].Anchored = false
		AnchorPart["Right Leg"].Anchored = false
		AnchorPart["Left Arm"].Anchored = false
		AnchorPart["Left Leg"].Anchored = false
		script.Parent.Value = false
		Debounce = false
	end
end