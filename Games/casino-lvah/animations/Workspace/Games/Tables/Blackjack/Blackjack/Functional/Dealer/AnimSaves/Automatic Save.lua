-- Generated from animations/Workspace/Games/Tables/Blackjack/Blackjack/Functional/Dealer/AnimSaves/Automatic Save.rbxm by _tools/rbxm2lua.luau
-- Animation pack: require(this)() returns the KeyframeSequence / Animation instances

local function new(class, parent, name, props, attrs, tags)
	local o = Instance.new(class)
	o.Name = name
	if props then
		for k, v in props do
			o[k] = v
		end
	end
	if attrs then
		for k, v in attrs do
			o:SetAttribute(k, v)
		end
	end
	if tags then
		for _, t in tags do
			o:AddTag(t)
		end
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function build()
	local I = {}
	I[1] = new("KeyframeSequence", nil, "Automatic Save", { Loop = false, Priority = Enum.AnimationPriority.Core }, nil, { "1669599089" })
		I[2] = new("Keyframe", I[1], "Keyframe")
			I[3] = new("Pose", I[2], "HumanoidRootPart", { Weight = 0 })
				I[4] = new("Pose", I[3], "LowerTorso", { Weight = 0 })
					I[5] = new("Pose", I[4], "UpperTorso", { Weight = 0 })
						I[6] = new("Pose", I[5], "Head", { Weight = 0 })
							I[7] = new("Folder", I[6], "FaceControls")
								I[8] = new("NumberPose", I[7], "EyesLookRight")
								I[9] = new("NumberPose", I[7], "RightLipCornerPuller")
								I[10] = new("NumberPose", I[7], "EyesLookDown")
								I[11] = new("NumberPose", I[7], "EyesLookLeft")
								I[12] = new("NumberPose", I[7], "LeftLowerLipDepressor")
								I[13] = new("NumberPose", I[7], "TongueOut")
								I[14] = new("NumberPose", I[7], "LeftCheekRaiser")
								I[15] = new("NumberPose", I[7], "JawDrop")
								I[16] = new("NumberPose", I[7], "RightLowerLipDepressor")
								I[17] = new("NumberPose", I[7], "JawLeft")
								I[18] = new("NumberPose", I[7], "LeftDimpler")
								I[19] = new("NumberPose", I[7], "UpperLipSuck")
								I[20] = new("NumberPose", I[7], "LeftLipStretcher")
								I[21] = new("NumberPose", I[7], "RightLipStretcher")
								I[22] = new("NumberPose", I[7], "RightUpperLipRaiser")
								I[23] = new("NumberPose", I[7], "RightLipCornerDown")
								I[24] = new("NumberPose", I[7], "RightBrowLowerer")
								I[25] = new("NumberPose", I[7], "LeftLipCornerDown")
								I[26] = new("NumberPose", I[7], "TongueUp")
								I[27] = new("NumberPose", I[7], "LowerLipSuck")
								I[28] = new("NumberPose", I[7], "RightCheekRaiser")
								I[29] = new("NumberPose", I[7], "ChinRaiserUpperLip")
								I[30] = new("NumberPose", I[7], "JawRight")
								I[31] = new("NumberPose", I[7], "LipsTogether")
								I[32] = new("NumberPose", I[7], "MouthRight")
								I[33] = new("NumberPose", I[7], "LeftLipCornerPuller")
								I[34] = new("NumberPose", I[7], "MouthLeft")
								I[35] = new("NumberPose", I[7], "RightInnerBrowRaiser")
								I[36] = new("NumberPose", I[7], "LeftUpperLipRaiser")
								I[37] = new("NumberPose", I[7], "EyesLookUp")
								I[38] = new("NumberPose", I[7], "LeftCheekPuff")
								I[39] = new("NumberPose", I[7], "LipPresser")
								I[40] = new("NumberPose", I[7], "TongueDown")
								I[41] = new("NumberPose", I[7], "Pucker")
		I[42] = new("Keyframe", I[1], "Keyframe", { Time = 0.3333333 })
			I[43] = new("Pose", I[42], "HumanoidRootPart", { Weight = 0 })
				I[44] = new("Pose", I[43], "LowerTorso", { Weight = 0 })
					I[45] = new("Pose", I[44], "UpperTorso", { Weight = 0 })
						I[46] = new("Pose", I[45], "Head", { Weight = 0 })
							I[47] = new("Folder", I[46], "FaceControls")
								I[48] = new("NumberPose", I[47], "EyesLookRight")
								I[49] = new("NumberPose", I[47], "RightLipCornerPuller")
								I[50] = new("NumberPose", I[47], "EyesLookDown")
								I[51] = new("NumberPose", I[47], "EyesLookLeft")
								I[52] = new("NumberPose", I[47], "LeftLowerLipDepressor")
								I[53] = new("NumberPose", I[47], "TongueOut")
								I[54] = new("NumberPose", I[47], "LeftCheekRaiser")
								I[55] = new("NumberPose", I[47], "JawDrop", { Value = 1 })
								I[56] = new("NumberPose", I[47], "RightLowerLipDepressor")
								I[57] = new("NumberPose", I[47], "JawLeft")
								I[58] = new("NumberPose", I[47], "LeftDimpler")
								I[59] = new("NumberPose", I[47], "UpperLipSuck")
								I[60] = new("NumberPose", I[47], "LeftLipStretcher")
								I[61] = new("NumberPose", I[47], "RightLipStretcher")
								I[62] = new("NumberPose", I[47], "RightUpperLipRaiser")
								I[63] = new("NumberPose", I[47], "RightLipCornerDown")
								I[64] = new("NumberPose", I[47], "RightBrowLowerer")
								I[65] = new("NumberPose", I[47], "LeftLipCornerDown")
								I[66] = new("NumberPose", I[47], "TongueUp")
								I[67] = new("NumberPose", I[47], "LowerLipSuck")
								I[68] = new("NumberPose", I[47], "RightCheekRaiser")
								I[69] = new("NumberPose", I[47], "ChinRaiserUpperLip")
								I[70] = new("NumberPose", I[47], "JawRight")
								I[71] = new("NumberPose", I[47], "LipsTogether")
								I[72] = new("NumberPose", I[47], "MouthRight")
								I[73] = new("NumberPose", I[47], "LeftLipCornerPuller")
								I[74] = new("NumberPose", I[47], "MouthLeft")
								I[75] = new("NumberPose", I[47], "RightInnerBrowRaiser")
								I[76] = new("NumberPose", I[47], "LeftUpperLipRaiser")
								I[77] = new("NumberPose", I[47], "EyesLookUp")
								I[78] = new("NumberPose", I[47], "LeftCheekPuff")
								I[79] = new("NumberPose", I[47], "LipPresser")
								I[80] = new("NumberPose", I[47], "TongueDown", { Value = 1 })
								I[81] = new("NumberPose", I[47], "Pucker")
		I[82] = new("AnimationRigData", I[1], "DealerAnimationRigData")
	return I[1]
end

return build
