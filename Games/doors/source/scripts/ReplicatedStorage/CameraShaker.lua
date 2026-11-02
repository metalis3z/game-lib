-- Camera Shaker
-- Stephen Leitnick
-- February 26, 2018

--[[
	
	CameraShaker.CameraShakeInstance
	
	cameraShaker = CameraShaker.new(renderPriority, callbackFunction)
	
	CameraShaker:Start()
	CameraShaker:Stop()
	CameraShaker:StopSustained([fadeOutTime])
	CameraShaker:Shake(shakeInstance)
	CameraShaker:ShakeSustain(shakeInstance)
	CameraShaker:ShakeOnce(magnitude, roughness [, fadeInTime, fadeOutTime, posInfluence, rotInfluence])
	CameraShaker:StartShake(magnitude, roughness [, fadeInTime, posInfluence, rotInfluence])
	
	
	
	EXAMPLE:
	
		local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCFrame)
			camera.CFrame = playerCFrame * shakeCFrame
		end)
		
		camShake:Start()
		
		-- Explosion shake:
		camShake:Shake(CameraShaker.Presets.Explosion)
		
		wait(1)
		
		-- Custom shake:
		camShake:ShakeOnce(3, 1, 0.2, 1.5)
		-- Sustained shake:
		camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		-- Stop all sustained shakes:
		camShake:StopSustained(1) -- Argument is the fadeout time (defaults to the same as fadein time if not supplied)
		-- Stop only one sustained shake:
		shakeInstance = camShake:ShakeSustain(CameraShaker.Presets.Earthquake)
		wait(2)
		shakeInstance:StartFadeOut(1) -- Argument is the fadeout time
	
	
	NOTE:
	
		This was based entirely on the EZ Camera Shake asset for Unity3D. I was given written
		permission by the developer, Road Turtle Games, to port this to Roblox.
		
		Original asset link: https://assetstore.unity.com/packages/tools/camera/ez-camera-shake-33148
		GitHub repository: https://github.com/Sleitnick/RbxCameraShaker
	
	
--]]


local v1 = {};
v1.__index = v1;
local v2 = require(script.CameraShakeInstance);
v1.CameraShakeInstance = v2;
v1.Presets = require(script.CameraShakePresets);
local u1 = Vector3.new();
function v1.new(p1, p2)
	assert(type(p1) == "number", "RenderPriority must be a number (e.g.: Enum.RenderPriority.Camera.Value)");
	assert(type(p2) == "function", "Callback must be a function");
	return setmetatable({
		_running = false, 
		_renderName = "CameraShaker", 
		_renderPriority = p1, 
		_posAddShake = u1, 
		_rotAddShake = u1, 
		_camShakeInstances = {}, 
		_removeInstances = {}, 
		_callback = p2
	}, v1);
end;
local l__debug_profilebegin__2 = debug.profilebegin;
local l__debug_profileend__3 = debug.profileend;
function v1.Start(p3)
	if p3._running then
		return;
	end;
	p3._running = true;
	local l___callback__4 = p3._callback;
	game:GetService("RunService"):BindToRenderStep(p3._renderName, p3._renderPriority, function(p4)
		l__debug_profilebegin__2("CameraShakerUpdate");
		local v3 = p3:Update(p4);
		l__debug_profileend__3();
		l___callback__4(v3);
	end);
end;
function v1.Stop(p5)
	if not p5._running then
		return;
	end;
	game:GetService("RunService"):UnbindFromRenderStep(p5._renderName);
	p5._running = false;
end;
function v1.StopSustained(p6, p7)
	for v4, v5 in pairs(p6._camShakeInstances) do
		if v5.fadeOutDuration == 0 then
			v5:StartFadeOut(p7 or v5.fadeInDuration);
		end;
	end;
end;
local l__CameraShakeState__5 = v2.CameraShakeState;
local l__CFrame_new__6 = CFrame.new;
local l__CFrame_Angles__7 = CFrame.Angles;
local l__math_rad__8 = math.rad;
function v1.Update(p8, p9)
	local v6 = u1;
	local v7 = u1;
	local l___camShakeInstances__8 = p8._camShakeInstances;
	for v9 = 1, #l___camShakeInstances__8 do
		local v10 = l___camShakeInstances__8[v9];
		local v11 = v10:GetState();
		if v11 == l__CameraShakeState__5.Inactive and v10.DeleteOnInactive then
			p8._removeInstances[#p8._removeInstances + 1] = v9;
		elseif v11 ~= l__CameraShakeState__5.Inactive then
			local v12 = v10:UpdateShake(p9);
			v6 = v6 + v12 * v10.PositionInfluence;
			v7 = v7 + v12 * v10.RotationInfluence;
		end;
	end;
	for v13 = #p8._removeInstances, 1, -1 do
		table.remove(l___camShakeInstances__8, p8._removeInstances[v13]);
		p8._removeInstances[v13] = nil;
	end;
	return l__CFrame_new__6(v6) * l__CFrame_Angles__7(0, l__math_rad__8(v7.Y), 0) * l__CFrame_Angles__7(l__math_rad__8(v7.X), 0, l__math_rad__8(v7.Z));
end;
function v1.Shake(p10, p11)
	local v14 = false;
	if type(p11) == "table" then
		v14 = p11._camShakeInstance;
	end;
	assert(v14, "ShakeInstance must be of type CameraShakeInstance");
	p10._camShakeInstances[#p10._camShakeInstances + 1] = p11;
	return p11;
end;
function v1.ShakeSustain(p12, p13)
	local v15 = false;
	if type(p13) == "table" then
		v15 = p13._camShakeInstance;
	end;
	assert(v15, "ShakeInstance must be of type CameraShakeInstance");
	p12._camShakeInstances[#p12._camShakeInstances + 1] = p13;
	p13:StartFadeIn(p13.fadeInDuration);
	return p13;
end;
local u9 = Vector3.new(0, 0, 0);
local u10 = Vector3.new(1, 1, 1);
function v1.ShakeOnce(p14, p15, p16, p17, p18, p19, p20)
	local v16 = v2.new(p15, p16, p17, p18);
	v16.PositionInfluence = typeof(p19) == "Vector3" and p19 or u9;
	v16.RotationInfluence = typeof(p20) == "Vector3" and p20 or u10;
	p14._camShakeInstances[#p14._camShakeInstances + 1] = v16;
	return v16;
end;
function v1.StartShake(p21, p22, p23, p24, p25, p26)
	local v17 = v2.new(p22, p23, p24);
	v17.PositionInfluence = typeof(p25) == "Vector3" and p25 or u9;
	v17.RotationInfluence = typeof(p26) == "Vector3" and p26 or u10;
	v17:StartFadeIn(p24);
	p21._camShakeInstances[#p21._camShakeInstances + 1] = v17;
	return v17;
end;
return v1;
