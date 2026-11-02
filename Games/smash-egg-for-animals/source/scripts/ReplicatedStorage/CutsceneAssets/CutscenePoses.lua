-- CutscenePoses : animation procédurale des avatars R15 de la cinématique (rotation des articulations Motor6D)
-- Angles en degrés {x, y, z} dans le repère de l'articulation :
--   épaules / hanches : x > 0 = membre vers l'avant ; épaule droite z > 0 = bras écarté sur le côté (gauche : z < 0)
--   coudes : x > 0 = plie l'avant-bras vers l'avant ; genoux : x < 0 = plie le tibia vers l'arrière
--   taille (Waist) : x < 0 = se penche en avant ; cou (Neck) : x > 0 = lève la tête
local M = {}

local JOINTS = {
	Root = "LowerTorso", Waist = "UpperTorso", Neck = "Head",
	LeftShoulder = "LeftUpperArm", LeftElbow = "LeftLowerArm", LeftWrist = "LeftHand",
	RightShoulder = "RightUpperArm", RightElbow = "RightLowerArm", RightWrist = "RightHand",
	LeftHip = "LeftUpperLeg", LeftKnee = "LeftLowerLeg", LeftAnkle = "LeftFoot",
	RightHip = "RightUpperLeg", RightKnee = "RightLowerLeg", RightAnkle = "RightFoot",
}

local R = math.rad
local function rot(v) return CFrame.Angles(R(v[1] or 0), R(v[2] or 0), R(v[3] or 0)) end

-- prépare un avatar : retourne un "acteur"
function M.setup(rig)
	local hrp = rig:FindFirstChild("HumanoidRootPart")
	local hum = rig:FindFirstChildOfClass("Humanoid")
	-- hauteur du centre du corps au-dessus des pieds, mesurée sur l'avatar au repos
	local footBottom = math.huge
	for _, n in {"RightFoot", "LeftFoot"} do
		local p = rig:FindFirstChild(n)
		if p then footBottom = math.min(footBottom, p.Position.Y - p.Size.Y / 2) end
	end
	local restStand = footBottom < math.huge and hrp.Position.Y - footBottom or 3
	if hum then
		hum.AutomaticScalingEnabled = false -- sinon le Humanoid remet les articulations droites
		hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		hum.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
		pcall(function() hum.EvaluateStateMachine = false end)
		hum.PlatformStand = true
		local animator = hum:FindFirstChildOfClass("Animator")
		if animator then animator:Destroy() end
	end
	for _, d in rig:GetDescendants() do
		if d:IsA("BasePart") then
			d.CanCollide, d.CanTouch, d.CanQuery = false, false, false
			d.Massless = true
			d.Anchored = false
		end
	end
	hrp.Anchored = true
	local a = {rig = rig, hrp = hrp, joints = {}, cf = hrp.CFrame}
	for name, partName in JOINTS do
		local part = rig:FindFirstChild(partName)
		local motor = part and part:FindFirstChild(name)
		if motor and motor:IsA("Motor6D") then
			a.joints[name] = {motor = motor, base = motor.C0, cur = CFrame.identity, target = CFrame.identity}
		elseif motor and motor:IsA("AnimationConstraint") then
			-- nouveau système d'articulations Roblox : on pilote Transform, en mode rigide
			pcall(function() motor.IsKinematic = true end)
			motor.Enabled = true
			a.joints[name] = {motor = motor, constraint = true, cur = CFrame.identity, target = CFrame.identity}
		end
	end
	-- hauteurs utiles (dépendent de la taille de l'avatar)
	local function sy(n) local p = rig:FindFirstChild(n) return p and p.Size.Y or 1 end
	a.standY = restStand
	a.kneelY = a.standY - (sy("RightLowerLeg") + sy("RightFoot")) * 0.85
	a.squatY = a.standY - (sy("RightUpperLeg") + sy("RightLowerLeg")) * 0.55
	a.sitY = hrp.Size.Y / 2 + sy("RightUpperLeg") * 0.25
	a.lieY = 0.55
	return a
end

-- choisit la pose visée (les articulations absentes reviennent droites)
function M.set(a, pose, instant)
	for name, j in a.joints do
		local v = pose and pose[name]
		j.target = v and rot(v) or CFrame.identity
		if instant then j.cur = j.target end
	end
end

-- change seulement certaines articulations (sans toucher aux autres)
function M.patch(a, pose, instant)
	for name, v in pose do
		local j = a.joints[name]
		if j then
			j.target = rot(v)
			if instant then j.cur = j.target end
		end
	end
end

-- avance l'animation : les articulations glissent vers la pose visée (speed élevé = mouvement sec)
function M.step(a, dt, speed)
	local k = 1 - math.exp(-(speed or a.speed or 10) * dt)
	for _, j in a.joints do
		j.cur = j.cur:Lerp(j.target, k)
		if j.constraint then
			j.motor.Transform = j.cur
		else
			j.motor.C0 = j.base * j.cur
		end
	end
	a.hrp.CFrame = a.cf
end

-- pose de marche à la phase donnée (amp = amplitude, 1 = marche décidée)
function M.walk(phase, amp)
	amp = amp or 1
	local s = math.sin(phase)
	local c = math.cos(phase)
	return {
		-- hanches : balancier régulier ; genoux : ils plient en douceur quand la jambe passe vers l'avant, presque tendus à l'appui
		RightHip = {28 * s * amp}, LeftHip = {-28 * s * amp},
		RightKnee = {-(math.max(0, -c) ^ 1.4) * 52 * amp - 6 - 6 * math.max(0, c) ^ 2}, LeftKnee = {-(math.max(0, c) ^ 1.4) * 52 * amp - 6 - 6 * math.max(0, -c) ^ 2},
		-- chevilles : le pied se relève à l'avant et pousse à l'arrière
		RightAnkle = {10 * s * amp}, LeftAnkle = {-10 * s * amp},
		-- bras opposés aux jambes, le coude plie quand le bras part vers l'avant
		RightShoulder = {-24 * s * amp, 0, 5 + 2 * c}, LeftShoulder = {24 * s * amp, 0, -5 + 2 * c},
		RightElbow = {14 + 16 * math.max(0, -s) ^ 1.5 * amp}, LeftElbow = {14 + 16 * math.max(0, s) ^ 1.5 * amp},
		-- le buste tourne légèrement contre les jambes et se balance d'un pied sur l'autre ; la tête reste droite
		Waist = {-3 * amp, 3 * s * amp, 0}, Neck = {2, -2.5 * s * amp, 0},
	}
end

function M.run(phase, amp)
	amp = amp or 1
	local s, c = math.sin(phase), math.cos(phase)
	return {
		RightHip = {50 * s * amp + 10}, LeftHip = {-50 * s * amp + 10},
		RightKnee = {-(math.max(0, -c) ^ 1.2) * 95 * amp - 14}, LeftKnee = {-(math.max(0, c) ^ 1.2) * 95 * amp - 14},
		RightAnkle = {16 * s * amp}, LeftAnkle = {-16 * s * amp},
		RightShoulder = {-52 * s * amp, 0, 8}, LeftShoulder = {52 * s * amp, 0, -8},
		RightElbow = {82 + 14 * math.max(0, -s)}, LeftElbow = {82 + 14 * math.max(0, s)},
		Waist = {-15 * amp, 10 * s * amp, 3 * c * amp}, Neck = {12, -7 * s * amp, 0},
	}
end

M.POSES = {
	STAND = {},
	-- agenouillé, bras tendus vers les filets électriques, tête baissée (il souffre)
	KNEEL_HOLD = {
		RightHip = {0}, LeftHip = {0}, RightKnee = {-90}, LeftKnee = {-90}, RightAnkle = {-10}, LeftAnkle = {-10},
		RightShoulder = {82, 0, 14}, LeftShoulder = {82, 0, -14}, RightElbow = {8}, LeftElbow = {8},
		RightWrist = {-20}, LeftWrist = {-20}, Waist = {-12}, Neck = {-28},
	},
	KNEEL_LOOKUP = {
		RightHip = {0}, LeftHip = {0}, RightKnee = {-90}, LeftKnee = {-90}, RightAnkle = {-10}, LeftAnkle = {-10},
		RightShoulder = {78, 0, 14}, LeftShoulder = {78, 0, -14}, RightElbow = {14}, LeftElbow = {14},
		RightWrist = {-20}, LeftWrist = {-20}, Waist = {6}, Neck = {32},
	},
	-- vol « super-héros » (le corps est en plus penché en avant par le script)
	FLY = {
		Waist = {-4}, Neck = {38},
		RightShoulder = {-22, 0, 14}, LeftShoulder = {-22, 0, -14}, RightElbow = {18}, LeftElbow = {18},
		RightHip = {-6}, LeftHip = {-16}, RightKnee = {-28}, LeftKnee = {-12}, RightAnkle = {-30}, LeftAnkle = {-30},
	},
	HOVER = {
		Waist = {-6}, Neck = {6},
		RightShoulder = {10, 0, 18}, LeftShoulder = {10, 0, -18}, RightElbow = {20}, LeftElbow = {20},
		RightHip = {12}, LeftHip = {-4}, RightKnee = {-35}, LeftKnee = {-20}, RightAnkle = {-25}, LeftAnkle = {-25},
	},
	KNOCK_BACK = {
		Waist = {-8}, Neck = {4},
		RightShoulder = {95, 0, 4}, RightElbow = {80}, LeftShoulder = {25, 0, -14}, LeftElbow = {35},
		RightHip = {12}, LeftHip = {-4}, RightKnee = {-35}, LeftKnee = {-20},
	},
	KNOCK_HIT = {
		Waist = {-14}, Neck = {0},
		RightShoulder = {92, 0, 4}, RightElbow = {4}, LeftShoulder = {25, 0, -14}, LeftElbow = {35},
		RightHip = {12}, LeftHip = {-4}, RightKnee = {-35}, LeftKnee = {-20},
	},
	SWORD_DRAW = {
		Waist = {0, -25, 0}, Neck = {0, 20, 0},
		RightShoulder = {60, 0, 35}, RightElbow = {35}, LeftShoulder = {35, 0, -30}, LeftElbow = {40},
		RightHip = {20}, LeftHip = {-10}, RightKnee = {-45}, LeftKnee = {-20},
	},
	-- épée pointée droit devant (il lance l'électricité par la pointe)
	SWORD_POINT = {
		Waist = {-6, 10, 0}, Neck = {0, -8, 0},
		RightShoulder = {90, 0, 0}, RightElbow = {0}, LeftShoulder = {30, 0, -35}, LeftElbow = {45},
		RightHip = {20}, LeftHip = {-14}, RightKnee = {-40}, LeftKnee = {-18},
	},
	WINDUP = {
		Waist = {20, 15, 0}, Neck = {-14},
		RightShoulder = {172, 0, 4}, RightElbow = {12}, LeftShoulder = {160, 0, -8}, LeftElbow = {28},
		RightHip = {28}, RightKnee = {-50}, LeftHip = {-22}, LeftKnee = {-30},
	},
	SLASH = {
		Waist = {-42, -20, 0}, Neck = {22},
		RightShoulder = {18, 0, -6}, RightElbow = {4}, LeftShoulder = {22, 0, -28}, LeftElbow = {22},
		RightHip = {-32}, RightKnee = {-12}, LeftHip = {50}, LeftKnee = {-65},
	},
	FALL = {
		Waist = {10}, Neck = {-20},
		RightShoulder = {165, 0, 30}, LeftShoulder = {150, 0, -35}, RightElbow = {25}, LeftElbow = {35},
		RightHip = {25, 0, 10}, LeftHip = {-10, 0, -15}, RightKnee = {-40}, LeftKnee = {-20},
	},
	-- évanoui sur le dos (le corps est couché par le script)
	LYING = {
		Neck = {0, 30, 0},
		RightShoulder = {0, 0, 75}, LeftShoulder = {0, 0, -60}, RightElbow = {20}, LeftElbow = {35},
		RightHip = {0, 0, 12}, LeftHip = {6, 0, -10}, RightKnee = {-6}, LeftKnee = {-25},
	},
	SITTING = {
		Waist = {-12}, Neck = {6},
		RightShoulder = {-20, 0, 12}, LeftShoulder = {-20, 0, -12}, RightElbow = {10}, LeftElbow = {10},
		RightHip = {88}, LeftHip = {88}, RightKnee = {-14}, LeftKnee = {-24}, RightAnkle = {-10}, LeftAnkle = {-10},
	},
	SIT_REACH = {
		Waist = {-5}, Neck = {25},
		RightShoulder = {120, 0, 10}, RightElbow = {10}, LeftShoulder = {-25, 0, -12}, LeftElbow = {10},
		RightHip = {88}, LeftHip = {88}, RightKnee = {-14}, LeftKnee = {-24}, RightAnkle = {-10}, LeftAnkle = {-10},
	},
	SQUAT_WIND = {
		Waist = {-32, 20, 0}, Neck = {-15},
		RightShoulder = {25, 0, 95}, RightElbow = {35}, LeftShoulder = {30, 0, -20}, LeftElbow = {30},
		RightHip = {75}, LeftHip = {60}, RightKnee = {-105}, LeftKnee = {-90}, RightAnkle = {30}, LeftAnkle = {30},
	},
	SQUAT_SLAP = {
		Waist = {-36, -25, 0}, Neck = {-20},
		RightShoulder = {80, 0, -40}, RightElbow = {5}, LeftShoulder = {30, 0, -20}, LeftElbow = {30},
		RightHip = {75}, LeftHip = {60}, RightKnee = {-105}, LeftKnee = {-90}, RightAnkle = {30}, LeftAnkle = {30},
	},
	LEAN_ASK = {
		Waist = {-32}, Neck = {12},
		RightShoulder = {35, 0, 10}, LeftShoulder = {20, 0, -10}, RightElbow = {25}, LeftElbow = {25},
		RightHip = {22}, LeftHip = {22}, RightKnee = {-30}, LeftKnee = {-30},
	},
	PULL = {
		Waist = {-22}, Neck = {6},
		RightShoulder = {70, 0, 0}, RightElbow = {8}, LeftShoulder = {15, 0, -10}, LeftElbow = {20},
		RightHip = {18}, LeftHip = {-8}, RightKnee = {-25}, LeftKnee = {-10},
	},
	STAND_HOLD = {
		RightShoulder = {80, 0, 0}, RightElbow = {10}, Neck = {6},
	},
}

return M
