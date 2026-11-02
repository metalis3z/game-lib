-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Potassium's decompiler.

local u1 = {
    _type = "Quaternion",
    _TO_STRING_CHAR = nil
};

local function GetType(p2) -- Line: 288
    if p2 == nil then
        return "nil";
    end;

    local v3 = getmetatable(p2);

    if type(v3) == "table" and v3._type ~= nil then
        return tostring(v3._type);
    end;

    return typeof(p2);
end;

local function _safeUnit(p4: vector, p5: vector) -- Line: 298
    if p4.Magnitude > 5e-7 then
        return p4.Unit;
    end;

    return p5;
end;

local function new(p6: number?, p7: number?, p8: number?, p9: number?) -- Line: 314
    -- upvalues: u1 (copy)
    local v10 = setmetatable({
        X = p6 or 0,
        Y = p7 or 0,
        Z = p8 or 0,
        W = p9 or 1,
        _cached = {}
    }, u1);
    table.freeze(v10);

    return v10;
end;

u1.new = new;
u1.identity = new(0, 0, 0, 1);
u1.zero = new(0, 0, 0, 0);

local function _Orthonormalize(p11: vector, p12: vector, p13: vector) -- Line: 334
    local v14 = p11.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or p11.Unit;
    local v15 = v14:Cross(p12.Magnitude <= 5e-7 and Vector3.new(0, 1, 0) or p12.Unit);
    local v16;

    if v15.Magnitude > 5e-7 then
        v16 = v15.Unit;
    else
        local v17 = v14:Cross(Vector3.new(0, 1, 0));
        v16 = v17.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v17.Unit;
    end;

    local Unit = v16:Cross(v14).Unit;

    if v16:Dot(p13) < 0 then
        v16 = -v16;
    end;

    return v14, Unit, v16;
end;

local function _fromOrthonormalizedMatrix(p18: vector, p19: vector, p20: vector) -- Line: 358
    -- upvalues: new (copy)
    local X = p18.X;
    local Y = p18.Y;
    local Z = p18.Z;
    local X2 = p19.X;
    local Y2 = p19.Y;
    local Z2 = p19.Z;
    local X3 = p20.X;
    local Y3 = p20.Y;
    local Z3 = p20.Z;
    local v21 = X + Y2 + Z3;
    local v22, v23, v24, v25;

    if v21 > 0 then
        local v26 = math.sqrt(v21 + 1) * 2;
        v22 = (Z2 - Y3) / v26;
        v23 = (X3 - Z) / v26;
        v24 = (Y - X2) / v26;
        v25 = v26 * 0.25;
    elseif Y2 < X and Z3 < X then
        local v27 = math.sqrt(X + 1 - Y2 - Z3) * 2;
        v22 = v27 * 0.25;
        v23 = (X2 + Y) / v27;
        v24 = (X3 + Z) / v27;
        v25 = (Z2 - Y3) / v27;
    elseif Z3 < Y2 then
        local v28 = math.sqrt(Y2 + 1 - X - Z3) * 2;
        v22 = (X2 + Y) / v28;
        v23 = v28 * 0.25;
        v24 = (Y3 + Z2) / v28;
        v25 = (X3 - Z) / v28;
    else
        local v29 = math.sqrt(Z3 + 1 - X - Y2) * 2;
        v22 = (X3 + Z) / v29;
        v23 = (Y3 + Z2) / v29;
        v24 = v29 * 0.25;
        v25 = (Y - X2) / v29;
    end;

    return new(v22, v23, v24, v25);
end;

function u1.fromAxisAngle(p30: vector, p31: number) -- Line: 405
    -- upvalues: new (copy)
    local v32 = p30.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or p30.Unit;
    local v33 = p31 / 2;
    local math_sin_ret = math.sin(v33);

    return new(math_sin_ret * v32.X, math_sin_ret * v32.Y, math_sin_ret * v32.Z, (math.cos(v33)));
end;

function u1.fromAxisAngleFast(p34: vector, p35: number) -- Line: 428
    -- upvalues: new (copy)
    local v36 = p35 / 2;
    local v37 = p34 * math.sin(v36);

    return new(v37.X, v37.Y, v37.Z, (math.cos(v36)));
end;

function u1.fromEulerVector(p38: vector) -- Line: 450
    -- upvalues: new (copy), u1 (copy)
    local Magnitude = p38.Magnitude;

    if Magnitude <= 0 then
        return u1.identity;
    end;

    local v39 = Magnitude / 2;
    local v40 = p38 / Magnitude * math.sin(v39);

    return new(v40.X, v40.Y, v40.Z, (math.cos(v39)));
end;

function u1.fromCFrame(p41) -- Line: 470
    -- upvalues: new (copy)
    local v42, v43 = p41:Orthonormalize():ToAxisAngle();
    local v44 = v42.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v42.Unit;
    local v45 = v43 / 2;
    local math_sin_ret = math.sin(v45);

    return new(math_sin_ret * v44.X, math_sin_ret * v44.Y, math_sin_ret * v44.Z, (math.cos(v45)));
end;

function u1.fromCFrameFast(p46) -- Line: 485
    -- upvalues: new (copy)
    local v47, v48 = p46:ToAxisAngle();
    local v49 = v48 / 2;
    local v50 = v47 * math.sin(v49);

    return new(v50.X, v50.Y, v50.Z, (math.cos(v49)));
end;

function u1.fromMatrix(p51: vector, p52: vector, p53: vector?) -- Line: 500
    -- upvalues: _fromOrthonormalizedMatrix (copy), _Orthonormalize (copy)
    return _fromOrthonormalizedMatrix(_Orthonormalize(p51, p52, p53 or p51:Cross(p52)));
end;

function u1.fromMatrixFast(p54: vector, p55: vector, p56: vector?) -- Line: 517
    -- upvalues: _fromOrthonormalizedMatrix (copy)
    return _fromOrthonormalizedMatrix(p54.Unit, p55.Unit, p56 or p54:Cross(p55).Unit);
end;

function u1.lookAt(p57: vector, p58: vector, p59: vector?) -- Line: 534
    -- upvalues: _fromOrthonormalizedMatrix (copy)
    local v60 = p58 - p57;
    local v61 = v60.Magnitude <= 5e-7 and Vector3.new(0, 0, 1) or v60.Unit;
    local v62 = p59 or Vector3.new(0, 1, 0);
    local v63 = v61:Cross(v62.Magnitude <= 5e-7 and Vector3.new(0, 1, 0) or v62.Unit);

    if v63.Magnitude > 5e-7 then
        local Unit = v63.Unit;

        return _fromOrthonormalizedMatrix(Unit, Unit:Cross(v61).Unit, -v61);
    end;

    local v64 = v61:Cross(Vector3.new(1, 0, 0));

    if v64.Magnitude > 5e-7 then
        local Unit = v64.Unit;

        return _fromOrthonormalizedMatrix(Unit, Unit:Cross(v61).Unit, -v61);
    end;

    local v65 = (Vector3.new(0, 0, 1)):Cross(v61);
    local v66 = v65 * v65:Dot(Vector3.new(0, 1, 0));

    return _fromOrthonormalizedMatrix(v61:Cross(v66), v66, -v61);
end;

local function fromEulerAnglesXYZ(p67: number, p68: number, p69: number) -- Line: 568
    -- upvalues: new (copy)
    local math_cos_ret = math.cos(p67 / 2);
    local math_sin_ret = math.sin(p67 / 2);
    local math_cos_ret2 = math.cos(p68 / 2);
    local math_sin_ret2 = math.sin(p68 / 2);
    local math_cos_ret3 = math.cos(p69 / 2);
    local math_sin_ret3 = math.sin(p69 / 2);
    local v70 = math_sin_ret * math_cos_ret2;
    local v71 = math_cos_ret * math_sin_ret2;
    local v72 = math_cos_ret * math_cos_ret2;
    local v73 = math_sin_ret * math_sin_ret2;

    return new(v70 * math_cos_ret3 + v71 * math_sin_ret3, v71 * math_cos_ret3 - v70 * math_sin_ret3, v72 * math_sin_ret3 + v73 * math_cos_ret3, v72 * math_cos_ret3 - v73 * math_sin_ret3);
end;

u1.fromEulerAnglesXYZ = fromEulerAnglesXYZ;
u1.Angles = fromEulerAnglesXYZ;

local function fromEulerAnglesYXZ(p74: number, p75: number, p76: number) -- Line: 606
    -- upvalues: new (copy)
    local math_cos_ret = math.cos(p74 / 2);
    local math_sin_ret = math.sin(p74 / 2);
    local math_cos_ret2 = math.cos(p75 / 2);
    local math_sin_ret2 = math.sin(p75 / 2);
    local math_cos_ret3 = math.cos(p76 / 2);
    local math_sin_ret3 = math.sin(p76 / 2);
    local v77 = math_sin_ret * math_cos_ret2;
    local v78 = math_cos_ret * math_sin_ret2;
    local v79 = math_cos_ret * math_cos_ret2;
    local v80 = math_sin_ret * math_sin_ret2;

    return new(v77 * math_cos_ret3 + v78 * math_sin_ret3, v78 * math_cos_ret3 - v77 * math_sin_ret3, v79 * math_sin_ret3 - v80 * math_cos_ret3, v79 * math_cos_ret3 + v80 * math_sin_ret3);
end;

u1.fromEulerAnglesYXZ = fromEulerAnglesYXZ;
u1.fromOrientation = fromEulerAnglesYXZ;

function u1.fromEulerAngles(p81: number, p82: number, p83: number, p84: any) -- Line: 646
    -- upvalues: new (copy)
    local v85 = p84 or Enum.RotationOrder.XYZ;
    local math_cos_ret = math.cos(p81 / 2);
    local math_cos_ret2 = math.cos(p82 / 2);
    local math_cos_ret3 = math.cos(p83 / 2);
    local math_sin_ret = math.sin(p81 / 2);
    local math_sin_ret2 = math.sin(p82 / 2);
    local math_sin_ret3 = math.sin(p83 / 2);
    local v86 = math_sin_ret * math_cos_ret2;
    local v87 = math_cos_ret * math_sin_ret2;
    local v88 = math_cos_ret * math_cos_ret2;
    local v89 = math_sin_ret * math_sin_ret2;
    local v90 = nil;
    local v91 = nil;
    local v92 = nil;
    local v93 = nil;
    local Name = v85.Name;

    if Name == "XYZ" then
        v90 = v86 * math_cos_ret3 + v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 - v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 + v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 - v89 * math_sin_ret3;
    elseif Name == "YXZ" then
        v90 = v86 * math_cos_ret3 + v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 - v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 - v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 + v89 * math_sin_ret3;
    elseif Name == "ZXY" then
        v90 = v86 * math_cos_ret3 - v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 + v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 + v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 - v89 * math_sin_ret3;
    elseif Name == "ZYX" then
        v90 = v86 * math_cos_ret3 - v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 + v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 - v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 + v89 * math_sin_ret3;
    elseif Name == "YZX" then
        v90 = v86 * math_cos_ret3 + v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 + v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 - v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 - v89 * math_sin_ret3;
    elseif Name == "XZY" then
        v90 = v86 * math_cos_ret3 - v87 * math_sin_ret3;
        v91 = v87 * math_cos_ret3 - v86 * math_sin_ret3;
        v92 = v88 * math_sin_ret3 + v89 * math_cos_ret3;
        v93 = v88 * math_cos_ret3 + v89 * math_sin_ret3;
    end;

    return new(v90, v91, v92, v93);
end;

function u1.fromVector(p94: vector, p95: number?) -- Line: 711
    -- upvalues: new (copy)
    return new(p94.X, p94.Y, p94.Z, p95 or 0);
end;

function u1.RandomQuaternion(p96: number) -- Line: 724
    -- upvalues: new (copy)
    local Random_new_ret = Random.new(p96 or 1);
    local math_sqrt = math.sqrt;
    local math_sin = math.sin;
    local math_cos = math.cos;

    return function() -- Line: 732
        -- upvalues: Random_new_ret (copy), math_sqrt (copy), math_sin (copy), math_cos (copy), new (ref)
        local v97 = Random_new_ret:NextNumber(0, 1);
        local v98 = Random_new_ret:NextNumber(0, 1);
        local v99 = Random_new_ret:NextNumber(0, 1);
        local v100 = math_sqrt(v97);
        local v101 = math_sqrt(1 - v97);
        local v102 = 6.283185307179586 * v98;
        local v103 = 6.283185307179586 * v99;

        return new(v101 * math_sin(v102), v101 * math_cos(v102), v100 * math_sin(v103), v100 * math_cos(v103));
    end;
end;

local function Add(p104, p105) -- Line: 887
    -- upvalues: new (copy)
    return new(p104.X + p105.X, p104.Y + p105.Y, p104.Z + p105.Z, p104.W + p105.W);
end;

u1.__add = Add;
u1.Add = Add;

local function Sub(p106, p107) -- Line: 894
    -- upvalues: new (copy)
    return new(p106.X - p107.X, p106.Y - p107.Y, p106.Z - p107.Z, p106.W - p107.W);
end;

u1.__sub = Sub;
u1.Sub = Sub;

local function Mul(p108, p109) -- Line: 901
    -- upvalues: new (copy)
    local X = p108.X;
    local Y = p108.Y;
    local Z = p108.Z;
    local W = p108.W;
    local X2 = p109.X;
    local Y2 = p109.Y;
    local Z2 = p109.Z;
    local W2 = p109.W;

    return new(W * X2 + X * W2 + Y * Z2 - Z * Y2, W * Y2 - X * Z2 + Y * W2 + Z * X2, W * Z2 + X * Y2 - Y * X2 + Z * W2, W * W2 - X * X2 - Y * Y2 - Z * Z2);
end;

u1.__mul = Mul;
u1.Mul = Mul;

function u1.Scale(p110: any, p111: number) -- Line: 922
    -- upvalues: new (copy)
    return new(p110.X * p111, p110.Y * p111, p110.Z * p111, p110.W * p111);
end;

function u1.MulCFrameR(p112: any, p113) -- Line: 934
    return p112:ToCFrame() * p113;
end;

function u1.MulCFrameL(p114: any, p115) -- Line: 946
    return p115 * p114:ToCFrame();
end;

function u1.RotateVector(p116: any, p117: vector) -- Line: 958
    -- upvalues: Mul (copy), new (copy)
    return Mul(p116 * new(p117.X, p117.Y, p117.Z, 0), p116:Conjugate()):Vector();
end;

function u1.CombineImaginary(p118: any, p119: vector) -- Line: 971
    -- upvalues: Mul (copy), new (copy)
    return Mul(new(p119.X, p119.Y, p119.Z, 0), p118);
end;

local function Div(p120, p121) -- Line: 978
    -- upvalues: Mul (copy)
    return Mul(p120, p121:Inverse());
end;

u1.__div = Div;
u1.Div = Div;

function u1.ScaleInv(p122: any, p123: number) -- Line: 992
    -- upvalues: new (copy)
    return new(p122.X / p123, p122.Y / p123, p122.Z / p123, p122.W / p123);
end;

local function unm(p124) -- Line: 999
    -- upvalues: new (copy)
    return new(-p124.X, -p124.Y, -p124.Z, -p124.W);
end;

u1.__unm = unm;
u1.Unm = unm;
u1.Negate = unm;

local function Pow(p125: any, p126: number) -- Line: 1007
    -- upvalues: u1 (copy)
    if p126 == -1 then
        return p125:Inverse();
    end;

    local W = p125.W;
    local X = p125.X;
    local Y = p125.Y;
    local Z = p125.Z;
    local v127 = X * X + Y * Y + Z * Z;
    local math_sqrt_ret = math.sqrt(W * W + v127);
    local math_sqrt_ret2 = math.sqrt(v127);
    local v128 = math_sqrt_ret ^ p126;

    if math_sqrt_ret2 <= math_sqrt_ret * 5e-7 then
        return u1.new(0, 0, 0, v128);
    end;

    local v129 = p126 * math.atan2(math_sqrt_ret2, W);
    local math_cos_ret = math.cos(v129);
    local v130 = v128 * math.sin(v129);

    return u1.new(v130 * (X / math_sqrt_ret2), v130 * (Y / math_sqrt_ret2), v130 * (Z / math_sqrt_ret2), v128 * math_cos_ret);
end;

u1.__pow = Pow;
u1.Pow = Pow;

local function eq(p131, p132) -- Line: 1041
    local v133;

    if p131 == nil then
        v133 = "nil";
    else
        local v134 = getmetatable(p131);

        if type(v134) == "table" and v134._type ~= nil then
            v133 = tostring(v134._type);
        else
            v133 = typeof(p131);
        end;
    end;

    local v135;

    if p132 == nil then
        v135 = "nil";
    else
        local v136 = getmetatable(p132);

        if type(v136) == "table" and v136._type ~= nil then
            v135 = tostring(v136._type);
        else
            v135 = typeof(p132);
        end;
    end;

    if v133 ~= "Quaternion" or v135 ~= v133 then
        return false;
    end;

    local v137;

    if p131.X == p132.X and (p131.Y == p132.Y and p131.Z == p132.Z) then
        v137 = p131.W == p132.W;
    else
        v137 = false;
    end;

    return v137;
end;

u1.__eq = eq;
u1.Eq = eq;

local function lt(p138, p139) -- Line: 1055
    return p138:Length() < p139:Length();
end;

u1.__lt = lt;
u1.Lt = lt;

local function le(p140, p141) -- Line: 1065
    return p140:Length() <= p141:Length();
end;

u1.__le = le;
u1.Le = le;

local function Exp(p142) -- Line: 1081
    -- upvalues: new (copy)
    local X = p142.X;
    local Y = p142.Y;
    local Z = p142.Z;
    local math_exp_ret = math.exp(p142.W);
    local v143 = X * X + Y * Y + Z * Z;

    if v143 <= 0 then
        return new(0, 0, 0, math_exp_ret);
    end;

    local v144 = v143 ^ 0.5;
    local v145 = math_exp_ret * math.sin(v144) / v144;

    return new(X * v145, Y * v145, Z * v145, math_exp_ret * math.cos(v144));
end;

u1.Exp = Exp;

function u1.ExpMap(p146, p147) -- Line: 1104
    -- upvalues: Mul (copy), Exp (copy)
    return Mul(p146, (Exp(p147)));
end;

function u1.ExpMapSym(p148, p149) -- Line: 1117
    -- upvalues: Pow (copy), Mul (copy), Exp (copy)
    local v150 = Pow(p148, 0.5);

    return Mul(Mul(v150, (Exp(p149))), v150);
end;

local function Log(p151) -- Line: 1130
    -- upvalues: new (copy)
    local X = p151.X;
    local Y = p151.Y;
    local Z = p151.Z;
    local W = p151.W;
    local v152 = X * X + Y * Y + Z * Z;
    local v153 = W * W + v152;

    if v153 <= 0 then
        return new(0, 0, 0, (-1 / 0));
    end;

    if v152 <= 0 then
        return new(0, 0, 0, math.log(v153) / 2);
    end;

    local v154 = v153 ^ 0.5;
    local v155 = math.acos(W / v154) / v152 ^ 0.5;

    return new(X * v155, Y * v155, Z * v155, (math.log(v154)));
end;

u1.Log = Log;

function u1.LogMap(p156, p157) -- Line: 1156
    -- upvalues: Log (copy), Mul (copy)
    return Log((Mul(p156:Inverse(), p157)));
end;

function u1.LogMapSym(p158, p159) -- Line: 1169
    -- upvalues: Pow (copy), Log (copy), Mul (copy)
    local v160 = Pow(p158, -0.5);

    return Log((Mul(Mul(v160, p159), v160)));
end;

local function Length(p161) -- Line: 1182
    local X = p161.X;
    local Y = p161.Y;
    local Z = p161.Z;
    local W = p161.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
end;

u1.Length = Length;
u1.__len = Length;

function u1.LengthSquared(p162) -- Line: 1196
    local X = p162.X;
    local Y = p162.Y;
    local Z = p162.Z;
    local W = p162.W;

    return X * X + Y * Y + Z * Z + W * W;
end;

function u1.Hypot(p163) -- Line: 1209
    -- upvalues: new (copy)
    local math_max_ret = math.max(p163.X, p163.Y, p163.Z, p163.W);

    if math_max_ret <= 0 then
        return 0;
    end;

    local v164 = new(p163.X / math_max_ret, p163.Y / math_max_ret, p163.Z / math_max_ret, p163.W / math_max_ret);
    local X = v164.X;
    local Y = v164.Y;
    local Z = v164.Z;
    local W = v164.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5 * math_max_ret;
end;

function u1.Normalize(p165) -- Line: 1230
    -- upvalues: new (copy), u1 (copy)
    local X = p165.X;
    local Y = p165.Y;
    local Z = p165.Z;
    local W = p165.W;
    local v166 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;

    if v166 > 0 then
        return new(p165.X / v166, p165.Y / v166, p165.Z / v166, p165.W / v166);
    end;

    return u1.identity;
end;

function u1.IsUnit(p167: any, p168: number) -- Line: 1248
    local X = p167.X;
    local Y = p167.Y;
    local Z = p167.Z;
    local W = p167.W;

    return (p168 or 5e-7) > math.abs(1 - (X * X + Y * Y + Z * Z + W * W) ^ 0.5);
end;

function u1.ToCFrame(p169: any, p170: vector?) -- Line: 1263
    -- upvalues: new (copy), u1 (copy)
    local X = p169.X;
    local Y = p169.Y;
    local Z = p169.Z;
    local W = p169.W;
    local v171 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v172;

    if v171 > 0 then
        v172 = new(p169.X / v171, p169.Y / v171, p169.Z / v171, p169.W / v171);
    else
        v172 = u1.identity;
    end;

    local v173 = p170 or Vector3.new();

    return CFrame.new(v173.X, v173.Y, v173.Z, v172.X, v172.Y, v172.Z, v172.W);
end;

function u1.Dot(p174, p175) -- Line: 1281
    return p174.X * p175.X + p174.Y * p175.Y + p174.Z * p175.Z + p174.W * p175.W;
end;

function u1.Conjugate(p176) -- Line: 1294
    -- upvalues: new (copy)
    return new(-p176.X, -p176.Y, -p176.Z, p176.W);
end;

function u1.Inverse(p177) -- Line: 1307
    -- upvalues: new (copy)
    local X = p177.X;
    local Y = p177.Y;
    local Z = p177.Z;
    local W = p177.W;
    local v178 = X * X + Y * Y + Z * Z + W * W;

    return new(-p177.X / v178, -p177.Y / v178, -p177.Z / v178, p177.W / v178);
end;

local function Negate(p179) -- Line: 1322
    -- upvalues: new (copy)
    return new(-p179.X, -p179.Y, -p179.Z, -p179.W);
end;

u1.Negate = Negate;
u1.__unm = Negate;

function u1.Difference(p180, p181) -- Line: 1340
    -- upvalues: new (copy), Mul (copy)
    if p180.X * p181.X + p180.Y * p181.Y + p180.Z * p181.Z + p180.W * p181.W < 0 then
        p180 = new(-p180.X, -p180.Y, -p180.Z, -p180.W);
    end;

    local X = p180.X;
    local Y = p180.Y;
    local Z = p180.Z;
    local W = p180.W;
    local v182 = X * X + Y * Y + Z * Z + W * W;

    return Mul(new(-p180.X / v182, -p180.Y / v182, -p180.Z / v182, p180.W / v182), p181);
end;

function u1.Distance(p183, p184) -- Line: 1356
    -- upvalues: Log (copy), Mul (copy)
    local v185 = Log((Mul(p183:Inverse(), p184)));
    local X = v185.X;
    local Y = v185.Y;
    local Z = v185.Z;
    local W = v185.W;

    return (X * X + Y * Y + Z * Z + W * W) ^ 0.5 * 2;
end;

function u1.DistanceSym(p186, p187) -- Line: 1369
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p186.X * p187.X + p186.Y * p187.Y + p186.Z * p187.Z + p186.W * p187.W < 0 then
        p186 = new(-p186.X, -p186.Y, -p186.Z, -p186.W);
    end;

    local X = p186.X;
    local Y = p186.Y;
    local Z = p186.Z;
    local W = p186.W;
    local v188 = X * X + Y * Y + Z * Z + W * W;
    local v189 = Log((Mul(new(-p186.X / v188, -p186.Y / v188, -p186.Z / v188, p186.W / v188), p187)));
    local X2 = v189.X;
    local Y2 = v189.Y;
    local Z2 = v189.Z;
    local W2 = v189.W;

    return (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2;
end;

function u1.DistanceChord(p190, p191) -- Line: 1382
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p190.X * p191.X + p190.Y * p191.Y + p190.Z * p191.Z + p190.W * p191.W < 0 then
        p190 = new(-p190.X, -p190.Y, -p190.Z, -p190.W);
    end;

    local X = p190.X;
    local Y = p190.Y;
    local Z = p190.Z;
    local W = p190.W;
    local v192 = X * X + Y * Y + Z * Z + W * W;
    local v193 = Log((Mul(new(-p190.X / v192, -p190.Y / v192, -p190.Z / v192, p190.W / v192), p191)));
    local X2 = v193.X;
    local Y2 = v193.Y;
    local Z2 = v193.Z;
    local W2 = v193.W;

    return math.sin((X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2 / 2) * 2;
end;

function u1.DistanceAbs(p194, p195) -- Line: 1395
    -- upvalues: new (copy)
    local v196 = new(p194.X - p195.X, p194.Y - p195.Y, p194.Z - p195.Z, p194.W - p195.W);
    local v197 = new(p194.X + p195.X, p194.Y + p195.Y, p194.Z + p195.Z, p194.W + p195.W);
    local X = v196.X;
    local Y = v196.Y;
    local Z = v196.Z;
    local W = v196.W;
    local v198 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local X2 = v197.X;
    local Y2 = v197.Y;
    local Z2 = v197.Z;
    local W2 = v197.W;
    local v199 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;

    if v198 < v199 then
        return v198;
    end;

    return v199;
end;

function u1.Slerp(p200: any, p201: any, p202: number) -- Line: 1417
    -- upvalues: new (copy), u1 (copy)
    local X = p200.X;
    local Y = p200.Y;
    local Z = p200.Z;
    local W = p200.W;
    local v203 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v204;

    if v203 > 0 then
        v204 = new(p200.X / v203, p200.Y / v203, p200.Z / v203, p200.W / v203);
    else
        v204 = u1.identity;
    end;

    local X2 = p201.X;
    local Y2 = p201.Y;
    local Z2 = p201.Z;
    local W2 = p201.W;
    local v205 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;
    local v206;

    if v205 > 0 then
        v206 = new(p201.X / v205, p201.Y / v205, p201.Z / v205, p201.W / v205);
    else
        v206 = u1.identity;
    end;

    local v207 = v204.X * v206.X + v204.Y * v206.Y + v204.Z * v206.Z + v204.W * v206.W;

    if v207 < 0 then
        v204 = new(-v204.X, -v204.Y, -v204.Z, -v204.W);
        v207 = -v207;
    end;

    if v207 >= 1 then
        local v208 = new(v206.X - v204.X, v206.Y - v204.Y, v206.Z - v204.Z, v206.W - v204.W);
        local v209 = new(v208.X * p202, v208.Y * p202, v208.Z * p202, v208.W * p202);
        local v210 = new(v204.X + v209.X, v204.Y + v209.Y, v204.Z + v209.Z, v204.W + v209.W);
        local X3 = v210.X;
        local Y3 = v210.Y;
        local Z3 = v210.Z;
        local W3 = v210.W;
        local v211 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

        if v211 > 0 then
            return new(v210.X / v211, v210.Y / v211, v210.Z / v211, v210.W / v211);
        end;

        return u1.identity;
    end;

    local math_acos_ret = math.acos(v207);
    local math_sin_ret = math.sin(math_acos_ret);
    local v212 = math_acos_ret * p202;
    local math_sin_ret2 = math.sin(v212);
    local v213 = math.cos(v212) - v207 * math_sin_ret2 / math_sin_ret;
    local v214 = math_sin_ret2 / math_sin_ret;
    local v215 = new(v204.X * v213, v204.Y * v213, v204.Z * v213, v204.W * v213);
    local v216 = new(v206.X * v214, v206.Y * v214, v206.Z * v214, v206.W * v214);
    local v217 = new(v215.X + v216.X, v215.Y + v216.Y, v215.Z + v216.Z, v215.W + v216.W);
    local X3 = v217.X;
    local Y3 = v217.Y;
    local Z3 = v217.Z;
    local W3 = v217.W;
    local v218 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

    if v218 > 0 then
        return new(v217.X / v218, v217.Y / v218, v217.Z / v218, v217.W / v218);
    end;

    return u1.identity;
end;

function u1.IdentitySlerp(p219: any, p220: number) -- Line: 1455
    -- upvalues: Pow (copy)
    if p219.W < 0 then
        return -Pow(-p219, p220);
    end;

    return Pow(p219, p220);
end;

local function SlerpFunction(p221, p222) -- Line: 1473
    -- upvalues: new (copy), u1 (copy)
    local v223 = p221;
    local X = v223.X;
    local Y = v223.Y;
    local Z = v223.Z;
    local W = v223.W;
    local v224 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local u225;

    if v224 > 0 then
        u225 = new(v223.X / v224, v223.Y / v224, v223.Z / v224, v223.W / v224);
    else
        u225 = u1.identity;
    end;

    local v226 = p222;
    local X2 = v226.X;
    local Y2 = v226.Y;
    local Z2 = v226.Z;
    local W2 = v226.W;
    local v227 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;
    local u228;

    if v227 > 0 then
        u228 = new(v226.X / v227, v226.Y / v227, v226.Z / v227, v226.W / v227);
    else
        u228 = u1.identity;
    end;

    local v229 = u228;
    local u230 = u225.X * v229.X + u225.Y * v229.Y + u225.Z * v229.Z + u225.W * v229.W;

    if u230 < 0 then
        u225 = new(-u225.X, -u225.Y, -u225.Z, -u225.W);
        u230 = -u230;
    end;

    if u230 < 1 then
        local math_acos_ret = math.acos(u230);
        local math_sin_ret = math.sin(math_acos_ret);

        return function(p231: number) -- Line: 1495
            -- upvalues: math_acos_ret (copy), u230 (ref), math_sin_ret (copy), u225 (ref), new (ref), u228 (ref), u1 (ref)
            local v232 = math_acos_ret * p231;
            local math_sin_ret2 = math.sin(v232);
            local v233 = math.cos(v232) - u230 * math_sin_ret2 / math_sin_ret;
            local v234 = math_sin_ret2 / math_sin_ret;
            local v235 = u225;
            local v236 = new(v235.X * v233, v235.Y * v233, v235.Z * v233, v235.W * v233);
            local v237 = u228;
            local v238 = new(v237.X * v234, v237.Y * v234, v237.Z * v234, v237.W * v234);
            local v239 = new(v236.X + v238.X, v236.Y + v238.Y, v236.Z + v238.Z, v236.W + v238.W);
            local X3 = v239.X;
            local Y3 = v239.Y;
            local Z3 = v239.Z;
            local W3 = v239.W;
            local v240 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

            if v240 > 0 then
                return new(v239.X / v240, v239.Y / v240, v239.Z / v240, v239.W / v240);
            end;

            return u1.identity;
        end;
    end;

    local v241 = u228;
    local v242 = u225;
    local u243 = new(v241.X - v242.X, v241.Y - v242.Y, v241.Z - v242.Z, v241.W - v242.W);

    return function(p244: number) -- Line: 1487
        -- upvalues: u225 (ref), u243 (copy), new (ref), u1 (ref)
        local v245 = u225;
        local v246 = u243;
        local v247 = new(v246.X * p244, v246.Y * p244, v246.Z * p244, v246.W * p244);
        local v248 = new(v245.X + v247.X, v245.Y + v247.Y, v245.Z + v247.Z, v245.W + v247.W);
        local X3 = v248.X;
        local Y3 = v248.Y;
        local Z3 = v248.Z;
        local W3 = v248.W;
        local v249 = (X3 * X3 + Y3 * Y3 + Z3 * Z3 + W3 * W3) ^ 0.5;

        if v249 > 0 then
            return new(v248.X / v249, v248.Y / v249, v248.Z / v249, v248.W / v249);
        end;

        return u1.identity;
    end;
end;

u1.SlerpFunction = SlerpFunction;

function u1.Intermediates(p250: any, p251: any, p252: number, p253: boolean?) -- Line: 1515
    -- upvalues: SlerpFunction (copy)
    local v254 = p253 or false;
    local v255 = 1 / (p252 + 1);
    local v256 = SlerpFunction(p250, p251);
    local v257 = v254 and { p250 } or {};

    for i = 1, p252 do
        local v258 = v256(v255 * i);
        table.insert(v257, v258);
        local _ = i;
    end;

    if v254 then
        table.insert(v257, p251);
    end;

    return v257;
end;

function u1.Derivative(p259: any, p260: vector) -- Line: 1547
    -- upvalues: Mul (copy), new (copy)
    return Mul(new(p259.X * 0.5, p259.Y * 0.5, p259.Z * 0.5, p259.W * 0.5), (new(p260.X, p260.Y, p260.Z, 0)));
end;

function u1.Integrate(p261: any, p262: vector, p263: number) -- Line: 1562
    -- upvalues: new (copy), u1 (copy), Mul (copy)
    local X = p261.X;
    local Y = p261.Y;
    local Z = p261.Z;
    local W = p261.W;
    local v264 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v265;

    if v264 > 0 then
        v265 = new(p261.X / v264, p261.Y / v264, p261.Z / v264, p261.W / v264);
    else
        v265 = u1.identity;
    end;

    local v266 = p262 * p263;
    local Magnitude = v266.Magnitude;

    if Magnitude <= 0 then
        return v265;
    end;

    local v267 = v266 / Magnitude;
    local v268 = v267.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v267.Unit;
    local v269 = Magnitude / 2;
    local math_sin_ret = math.sin(v269);
    local v270 = Mul(v265, (new(math_sin_ret * v268.X, math_sin_ret * v268.Y, math_sin_ret * v268.Z, (math.cos(v269)))));
    local X2 = v270.X;
    local Y2 = v270.Y;
    local Z2 = v270.Z;
    local W2 = v270.W;
    local v271 = (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5;

    if v271 > 0 then
        return new(v270.X / v271, v270.Y / v271, v270.Z / v271, v270.W / v271);
    end;

    return u1.identity;
end;

function u1.AngularVelocity(p272: any, p273: any, p274: number) -- Line: 1587
    if p274 > 0 then
        return p272:Difference(p273):ToEulerVector() / p274;
    end;

    return Vector3.new();
end;

function u1.MinimalRotation(p275, p276) -- Line: 1606
    -- upvalues: new (copy)
    local _, v277, _ = p275:ToMatrixVectors();
    local _, v278, _ = p276:ToMatrixVectors();
    local v279 = v277:Cross(v278);
    local Magnitude = v279.Magnitude;
    local v280 = v277:Dot(v278);
    local math_atan2_ret = math.atan2(Magnitude, v280);
    local v281 = v279.Magnitude <= 5e-7 and Vector3.new(1, 0, 0) or v279.Unit;
    local v282 = math_atan2_ret / 2;
    local math_sin_ret = math.sin(v282);

    return new(math_sin_ret * v281.X, math_sin_ret * v281.Y, math_sin_ret * v281.Z, (math.cos(v282)));
end;

function u1.ApproxEq(p283: any, p284: any, p285: number?) -- Line: 1623
    -- upvalues: Log (copy), new (copy), Mul (copy)
    if p283.X * p284.X + p283.Y * p284.Y + p283.Z * p284.Z + p283.W * p284.W < 0 then
        p283 = new(-p283.X, -p283.Y, -p283.Z, -p283.W);
    end;

    local X = p283.X;
    local Y = p283.Y;
    local Z = p283.Z;
    local W = p283.W;
    local v286 = X * X + Y * Y + Z * Z + W * W;
    local v287 = Log((Mul(new(-p283.X / v286, -p283.Y / v286, -p283.Z / v286, p283.W / v286), p284)));
    local X2 = v287.X;
    local Y2 = v287.Y;
    local Z2 = v287.Z;
    local W2 = v287.W;

    return (X2 * X2 + Y2 * Y2 + Z2 * Z2 + W2 * W2) ^ 0.5 * 2 < (p285 or 5e-7);
end;

function u1.IsNaN(p288) -- Line: 1636
    local X = p288.X;
    local Y = p288.Y;
    local Z = p288.Z;
    local W = p288.W;

    return (X ~= X or (Y ~= Y or Z ~= Z)) and true or W ~= W;
end;

local function _toRotationMatrix(p289) -- Line: 1643
    -- upvalues: new (copy), u1 (copy)
    local X = p289.X;
    local Y = p289.Y;
    local Z = p289.Z;
    local W = p289.W;
    local v290 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v291;

    if v290 > 0 then
        v291 = new(p289.X / v290, p289.Y / v290, p289.Z / v290, p289.W / v290);
    else
        v291 = u1.identity;
    end;

    local X2 = v291.X;
    local Y2 = v291.Y;
    local Z2 = v291.Z;
    local W2 = v291.W;
    local v292 = X2 * X2;
    local v293 = Y2 * Y2;
    local v294 = Z2 * Z2;
    local v295 = W2 * W2;
    local v296 = X2 * Y2;
    local v297 = Z2 * W2;
    local v298 = X2 * Z2;
    local v299 = Y2 * W2;
    local v300 = Y2 * Z2;
    local v301 = X2 * W2;

    return v292 - v293 - v294 + v295, 2 * (v296 - v297), 2 * (v298 + v299), 2 * (v296 + v297), -v292 + v293 - v294 + v295, 2 * (v300 - v301), 2 * (v298 - v299), 2 * (v300 + v301), -v292 - v293 + v294 + v295;
end;

function u1.ToAxisAngle(p302) -- Line: 1681
    -- upvalues: new (copy), u1 (copy)
    local X = p302.X;
    local Y = p302.Y;
    local Z = p302.Z;
    local W = p302.W;
    local v303 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v304;

    if v303 > 0 then
        v304 = new(p302.X / v303, p302.Y / v303, p302.Z / v303, p302.W / v303);
    else
        v304 = u1.identity;
    end;

    local X2 = v304.X;
    local Y2 = v304.Y;
    local Z2 = v304.Z;
    local W2 = v304.W;
    local v305 = math.acos(W2) * 2;
    local math_sqrt_ret = math.sqrt(1 - W2 * W2);

    if math_sqrt_ret < 5e-7 then
        return Vector3.new(X2, Y2, Z2), v305;
    end;

    return Vector3.new(X2 / math_sqrt_ret, Y2 / math_sqrt_ret, Z2 / math_sqrt_ret), v305;
end;

function u1.ToEulerVector(p306) -- Line: 1704
    -- upvalues: new (copy), u1 (copy)
    local X = p306.X;
    local Y = p306.Y;
    local Z = p306.Z;
    local W = p306.W;
    local v307 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v308;

    if v307 > 0 then
        v308 = new(p306.X / v307, p306.Y / v307, p306.Z / v307, p306.W / v307);
    else
        v308 = u1.identity;
    end;

    local X2 = v308.X;
    local Y2 = v308.Y;
    local Z2 = v308.Z;
    local W2 = v308.W;
    local v309 = math.acos(W2) * 2;
    local math_sqrt_ret = math.sqrt(1 - W2 * W2);

    if math_sqrt_ret < 5e-7 then
        return Vector3.new(X2, Y2, Z2) * v309;
    end;

    return Vector3.new(X2 / math_sqrt_ret, Y2 / math_sqrt_ret, Z2 / math_sqrt_ret) * v309;
end;

function u1.ToMatrix(p310) -- Line: 1728
    -- upvalues: _toRotationMatrix (copy)
    return _toRotationMatrix(p310);
end;

function u1.ToMatrixVectors(p311) -- Line: 1743
    -- upvalues: _toRotationMatrix (copy)
    local v312, v313, v314, v315, v316, v317, v318, v319, v320 = _toRotationMatrix(p311);

    return Vector3.new(v312, v315, v318), Vector3.new(v313, v316, v319), Vector3.new(v314, v317, v320);
end;

function u1.Vector(p321) -- Line: 1758
    return Vector3.new(p321.X, p321.Y, p321.Z);
end;

function u1.Real(p322) -- Line: 1771
    -- upvalues: new (copy)
    return new(0, 0, 0, p322.W);
end;

function u1.Imaginary(p323) -- Line: 1784
    -- upvalues: new (copy)
    return new(p323.X, p323.Y, p323.Z, 0);
end;

local function ToEulerAnglesXYZ(p324) -- Line: 1797
    -- upvalues: new (copy), u1 (copy)
    local X = p324.X;
    local Y = p324.Y;
    local Z = p324.Z;
    local W = p324.W;
    local v325 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v326;

    if v325 > 0 then
        v326 = new(p324.X / v325, p324.Y / v325, p324.Z / v325, p324.W / v325);
    else
        v326 = u1.identity;
    end;

    local X2 = v326.X;
    local Y2 = v326.Y;
    local Z2 = v326.Z;
    local W2 = v326.W;
    local v327 = Y2 * W2 + X2 * Z2;

    if math.abs(v327) > 0.4999995 then
        local v328 = v327 > 0 and 1 or -1;

        return v328 * 2 * math.atan2(Z2, W2), v328 * 3.141592653589793 / 2, 0;
    end;

    local v329 = Y2 * Y2;

    return math.atan2(2 * (X2 * W2 - Y2 * Z2), 1 - 2 * (X2 * X2 + v329)), math.asin(2 * v327), math.atan2(2 * (Z2 * W2 - X2 * Y2), 1 - 2 * (Z2 * Z2 + v329));
end;

local function ToEulerAnglesYXZ(p330) -- Line: 1848
    -- upvalues: new (copy), u1 (copy)
    local X = p330.X;
    local Y = p330.Y;
    local Z = p330.Z;
    local W = p330.W;
    local v331 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    local v332;

    if v331 > 0 then
        v332 = new(p330.X / v331, p330.Y / v331, p330.Z / v331, p330.W / v331);
    else
        v332 = u1.identity;
    end;

    local X2 = v332.X;
    local Y2 = v332.Y;
    local Z2 = v332.Z;
    local W2 = v332.W;
    local v333 = X2 * W2 - Y2 * Z2;

    if math.abs(v333) > 0.4999995 then
        local v334 = v333 >= 0 and 1 or -1;

        return v334 * 3.141592653589793 / 2, v334 * 2 * -math.atan2(Z2, W2), 0;
    end;

    local v335 = X2 * X2;

    return math.asin(2 * v333), math.atan2(2 * (X2 * Z2 + Y2 * W2), 1 - 2 * (Y2 * Y2 + v335)), math.atan2(2 * (X2 * Y2 + Z2 * W2), 1 - 2 * (Z2 * Z2 + v335));
end;

local u360 = {
    XYZ = ToEulerAnglesXYZ,

    XZY = function(p336) -- Line: 1819, Name: ToEulerAnglesXZY
        -- upvalues: new (copy), u1 (copy)
        local X = p336.X;
        local Y = p336.Y;
        local Z = p336.Z;
        local W = p336.W;
        local v337 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v338;

        if v337 > 0 then
            v338 = new(p336.X / v337, p336.Y / v337, p336.Z / v337, p336.W / v337);
        else
            v338 = u1.identity;
        end;

        local X2 = v338.X;
        local Y2 = v338.Y;
        local Z2 = v338.Z;
        local W2 = v338.W;
        local v339 = Z2 * W2 - X2 * Y2;

        if math.abs(v339) > 0.4999995 then
            local v340 = v339 >= 0 and 1 or -1;

            return v340 * 2 * -math.atan2(Y2, W2), 0, v340 * 3.141592653589793 / 2;
        end;

        local v341 = Z2 * Z2;

        return math.atan2(2 * (X2 * W2 + Y2 * Z2), 1 - 2 * (X2 * X2 + v341)), math.atan2(2 * (X2 * Z2 + Y2 * W2), 1 - 2 * (Y2 * Y2 + v341)), math.asin(2 * v339);
    end,

    YZX = function(p342) -- Line: 1870, Name: ToEulerAnglesYZX
        -- upvalues: new (copy), u1 (copy)
        local X = p342.X;
        local Y = p342.Y;
        local Z = p342.Z;
        local W = p342.W;
        local v343 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v344;

        if v343 > 0 then
            v344 = new(p342.X / v343, p342.Y / v343, p342.Z / v343, p342.W / v343);
        else
            v344 = u1.identity;
        end;

        local X2 = v344.X;
        local Y2 = v344.Y;
        local Z2 = v344.Z;
        local W2 = v344.W;
        local v345 = Z2 * W2 + X2 * Y2;

        if math.abs(v345) > 0.4999995 then
            local v346 = v345 >= 0 and 1 or -1;

            return 0, v346 * 2 * math.atan2(X2, W2), v346 * 3.141592653589793 / 2;
        end;

        local v347 = Z2 * Z2;

        return math.atan2(2 * (X2 * W2 - Y2 * Z2), 1 - 2 * (X2 * X2 + v347)), math.atan2(2 * (Y2 * W2 - X2 * Z2), 1 - 2 * (Y2 * Y2 + v347)), math.asin(2 * v345);
    end,

    YXZ = ToEulerAnglesYXZ,

    ZXY = function(p348) -- Line: 1892, Name: ToEulerAnglesZXY
        -- upvalues: new (copy), u1 (copy)
        local X = p348.X;
        local Y = p348.Y;
        local Z = p348.Z;
        local W = p348.W;
        local v349 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v350;

        if v349 > 0 then
            v350 = new(p348.X / v349, p348.Y / v349, p348.Z / v349, p348.W / v349);
        else
            v350 = u1.identity;
        end;

        local X2 = v350.X;
        local Y2 = v350.Y;
        local Z2 = v350.Z;
        local W2 = v350.W;
        local v351 = X2 * W2 + Y2 * Z2;

        if math.abs(v351) > 0.4999995 then
            local v352 = v351 >= 0 and 1 or -1;

            return v352 * 3.141592653589793 / 2, 0, v352 * 2 * math.atan2(Y2, W2);
        end;

        local v353 = X2 * X2;

        return math.asin(2 * v351), math.atan2(2 * (Y2 * W2 - X2 * Z2), 1 - 2 * (Y2 * Y2 + v353)), math.atan2(2 * (Z2 * W2 - X2 * Y2), 1 - 2 * (Z2 * Z2 + v353));
    end,

    ZYX = function(p354) -- Line: 1914, Name: ToEulerAnglesZYX
        -- upvalues: new (copy), u1 (copy)
        local X = p354.X;
        local Y = p354.Y;
        local Z = p354.Z;
        local W = p354.W;
        local v355 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v356;

        if v355 > 0 then
            v356 = new(p354.X / v355, p354.Y / v355, p354.Z / v355, p354.W / v355);
        else
            v356 = u1.identity;
        end;

        local X2 = v356.X;
        local Y2 = v356.Y;
        local Z2 = v356.Z;
        local W2 = v356.W;
        local v357 = Y2 * W2 - X2 * Z2;

        if math.abs(v357) > 0.4999995 then
            local v358 = v357 >= 0 and 1 or -1;

            return 0, v358 * 3.141592653589793 / 2, v358 * 2 * -math.atan2(X2, W2);
        end;

        local v359 = Y2 * Y2;

        return math.atan2(2 * (X2 * W2 + Y2 * Z2), 1 - 2 * (X2 * X2 + v359)), math.asin(2 * v357), math.atan2(2 * (X2 * Y2 + Z2 * W2), 1 - 2 * (Z2 * Z2 + v359));
    end
};

function u1.ToEulerAngles(p361, p362) -- Line: 1953
    -- upvalues: u360 (copy)
    return u360[(p362 or Enum.RotationOrder.XYZ).Name](p361);
end;

u1.ToEulerAnglesXYZ = ToEulerAnglesXYZ;
u1.ToEulerAnglesYXZ = ToEulerAnglesYXZ;
u1.ToOrientation = ToEulerAnglesYXZ;

local function GetComponents(p363) -- Line: 1976
    return p363.X, p363.Y, p363.Z, p363.W;
end;

u1.GetComponents = GetComponents;
u1.components = GetComponents;

local function round(p364: number, p365: number?) -- Line: 1989
    if not p365 then
        return tostring(p364);
    end;

    local math_max_ret = math.max(0, p365);
    local string_format_ret = string.format("%%.%df", math_max_ret);

    return string.format(string_format_ret, p364);
end;

local function ToString(p366: any, p367: number?) -- Line: 2007
    -- upvalues: u1 (copy)
    if u1._TO_STRING_CHAR then
        p367 = u1._TO_STRING_CHAR;
    end;

    local X = p366.X;
    local v368;

    if p367 then
        local math_max_ret = math.max(0, p367);
        local string_format_ret = string.format("%%.%df", math_max_ret);
        v368 = string.format(string_format_ret, X);
    else
        v368 = tostring(X);
    end;

    local Y = p366.Y;
    local v369;

    if p367 then
        local math_max_ret = math.max(0, p367);
        local string_format_ret = string.format("%%.%df", math_max_ret);
        v369 = string.format(string_format_ret, Y);
    else
        v369 = tostring(Y);
    end;

    local Z = p366.Z;
    local v370;

    if p367 then
        local math_max_ret = math.max(0, p367);
        local string_format_ret = string.format("%%.%df", math_max_ret);
        v370 = string.format(string_format_ret, Z);
    else
        v370 = tostring(Z);
    end;

    local W = p366.W;
    local v371;

    if p367 then
        local math_max_ret = math.max(0, p367);
        local string_format_ret = string.format("%%.%df", math_max_ret);
        v371 = string.format(string_format_ret, W);
    else
        v371 = tostring(W);
    end;

    return v368 .. ", " .. v369 .. ", " .. v370 .. ", " .. v371;
end;

u1.__tostring = ToString;
u1.ToString = ToString;

function u1.__index(p372, p373) -- Line: 2022
    -- upvalues: u1 (copy), new (copy)
    local v374 = u1[p373];

    if v374 then
        return v374;
    end;

    local string_lower_ret = string.lower(p373);
    local v375 = rawget(p372, "_cached");

    if string_lower_ret == "unit" then
        if v375.unit then
            return v375.unit;
        end;

        local X = p372.X;
        local Y = p372.Y;
        local Z = p372.Z;
        local W = p372.W;
        local v376 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
        local v377;

        if v376 > 0 then
            v377 = new(p372.X / v376, p372.Y / v376, p372.Z / v376, p372.W / v376);
        else
            v377 = u1.identity;
        end;

        v375.unit = v377;

        return v377;
    end;

    if string_lower_ret ~= "magnitude" then
        return nil;
    end;

    if v375.magnitude then
        return v375.magnitude;
    end;

    local X = p372.X;
    local Y = p372.Y;
    local Z = p372.Z;
    local W = p372.W;
    local v378 = (X * X + Y * Y + Z * Z + W * W) ^ 0.5;
    v375.magnitude = v378;

    return v378;
end;

function u1.__newindex(p379, p380) -- Line: 2047
    error(tostring(p380) .. " cannot be assigned to");
end;

table.freeze(u1);

return u1;