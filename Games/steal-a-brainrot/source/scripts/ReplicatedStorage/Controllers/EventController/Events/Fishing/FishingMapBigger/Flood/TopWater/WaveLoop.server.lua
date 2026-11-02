-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Bytecode (Base64):
-- BgMMBnNjcmlwdAl3b3Jrc3BhY2UOSXNEZXNjZW5kYW50T2YGUGFyZW50E0FuaW1hdGlvbkNvbnRyb2xsZXIIV2F2ZUxvb3AIQW5pbWF0b3IMV2FpdEZvckNoaWxkDUxvYWRBbmltYXRpb24GTG9vcGVkBFBsYXkLQWRqdXN0U3BlZWQAAQYAAAECACujAAAApAABAAAAAECkAgMAAAAgQLwAAK0EAAAAnwADAisAAQCCAAEApAMBAAAAAEBNAgMkBQAAAE0BAiAGAAAATQABuQcAAACkAwEAAAAAQE0CAyQFAAAATQECIAYAAABvAwgAvAEB0wkAAACfAQMCUgQAALwCAZQKAAAAnwIDAqkDAQAwAwK1CwAAALwDAu4MAAAAnwMCAW8FDQC8AwLfDgAAAJ8DAwGCAAEADwMBBAAAAEADAgQAACBAAwMDBAMFAwYDBwMIAwkDCgMLAh+F61G4HtU/AwwAAQABGAAAAAAAAAAAAAEDAAAAAAAAAAEAAAAAAAAAAAADAAAAAgAAAQAAAQAAAAABAAAAAABdTyNTekrdTK/34QRHDcOsLVc0J2+LSVI=

-- decompilation:
if not script:IsDescendantOf(workspace) then
    return;
else
    local l_WaveLoop_0 = script.Parent.AnimationController.WaveLoop;
    local v1 = script.Parent.AnimationController:WaitForChild("Animator"):LoadAnimation(l_WaveLoop_0);
    v1.Looped = true;
    v1:Play();
    v1:AdjustSpeed(0.33);
    return;
end;
