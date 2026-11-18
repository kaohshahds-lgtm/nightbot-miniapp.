Library = Library or {}
Library.ShowLoader = false
local u, L, O = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("RunService")
local _ = u.LocalPlayer
do
local function d(aa)
local ab = type(aa) == "table" and rawget(aa, "gethui")
if type(ab) ~= "function" or rawget(aa, "nightcchui") then
return
end
local ac, ad = pcall(ab)
if not (ac and (typeof(ad) == "Instance" and ad:IsA("LayerCollector"))) then
return
end
rawset(aa, "nightcchui", true)
rawset(aa, "gethui", function()
local ae = ab()
if typeof(ae) == "Instance" and ae:IsA("LayerCollector") then
return ae.Parent or game:GetService("CoreGui")
end
return ae
end)
end
pcall(d, getfenv and getfenv(1))
pcall(d, getgenv and getgenv())
end
local aa = {
unloaded = false,
conns = {},
cleanups = {},
}
do
local ab = getgenv and getgenv() or _G
if type(ab.nightcc) == "table" and type(ab.nightcc.unload) == "function" then
pcall(ab.nightcc.unload)
end
if type(ab.__nightccUnload) == "function" then
pcall(ab.__nightccUnload)
end
function aa.connect(ac, ad)
local ae, af = ac:Connect(ad), aa.conns
af[#af + 1] = ae
if #af % 200 == 0 then
local ag = {}
for ah, ai in ipairs(af) do
if ai.Connected then
ag[#ag + 1] = ai
end
end
aa.conns = ag
end
if aa.unloaded then
ae:Disconnect()
end
return ae
end
function aa.onUnload(ac)
aa.cleanups[#aa.cleanups + 1] = ac
end
function aa.unload()
if aa.unloaded then
return
end
aa.unloaded = true
for ac, ad in ipairs(aa.conns) do
pcall(function()
ad:Disconnect()
end)
end
aa.conns = {}
for ac = #aa.cleanups, 1, -1 do
pcall(aa.cleanups[ac])
end
aa.cleanups = {}
if type(ab.nightcc) == "table" and ab.nightcc.unload == aa.unload then
ab.nightcc = nil
end
end
ab.__nightccUnload = nil
ab.nightcc = {
unload = aa.unload,
}
end
local ab = true
do
local ac, ad = "NightCCHubHandle", {}
pcall(function()
ad[#ad + 1] = game:GetService("CoreGui")
end)
pcall(function()
if gethui then
ad[#ad + 1] = gethui()
end
end)
for ae, af in ipairs(ad) do
local ag = af:FindFirstChild(ac)
if ag and ag:IsA("BindableFunction") then
pcall(function()
ag:Invoke()
end)
pcall(function()
ag:Destroy()
end)
end
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
local ae = Instance.new("BindableFunction")
ae.Name = ac
ae.OnInvoke = function()
aa.unload()
end
ae.Parent = ad[1]
aa.onUnload(function()
pcall(function()
ae:Destroy()
end)
end)
end
do
local ac = {
WindUI = true,
["WindUI/Notifications"] = true,
["WindUI/Dropdowns"] = true,
["WindUI/Tooltips"] = true,
NightCCNametags = true,
NightCCOverlay = true,
NightCCKeybinds = true,
NightCCBindPopup = true,
NightCCNametags = true,
NightCC_DISABLED_SPEC = true,
}
local function E(ad)
if not ad then
return
end
for ae, af in ipairs(ad:GetChildren()) do
if ac[af.Name] then
pcall(function()
af:Destroy()
end)
end
end
end
pcall(function()
E(gethui and gethui())
end)
pcall(function()
E(game:GetService("CoreGui"))
end)
pcall(function()
E(_:FindFirstChildOfClass("PlayerGui"))
end)
end
pcall(function()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
if not (isfolder and (listfiles and (makefolder and isfile))) then
return
end
for ac, ad in ipairs({
"nightcc",
"nightcc",
"WindUI",
"WindUI/nightcc",
}) do
if not isfolder(ad) then
makefolder(ad)
end
end
if isfile("nightcc/.migrated") then
return
end
local ac = "NightCC"
local function E(ad, ae)
if not isfolder(ad) then
return
end
if not isfolder(ae) then
makefolder(ae)
end
for af, ag in ipairs(listfiles(ad)) do
local ah = (ag:gsub("\\", "/")):match("[^/]+$")
if isfolder(ag) then
E(ad .. ("/" .. ah), ae .. ("/" .. ah))
elseif not isfile(ae .. ("/" .. ah)) then
pcall(function()
writefile(ae .. ("/" .. ah), readfile(ag))
end)
end
end
end
E(ac, "nightcc")
E("WindUI/" .. ac, "WindUI/nightcc")
writefile("nightcc/.migrated", "1")
end)
local _NL = (function()
local FONT = Enum.Font.Gotham
local FONT_BOLD = Enum.Font.GothamBold
pcall(function()
FONT = Enum.Font.Gotham
FONT_BOLD = Enum.Font.GothamBold
end)
local LoadAcrylic = function()
local GuiSystem = {};
local acrylicId = 0
local Twen = game:GetService('TweenService');
local RunService = game:GetService('RunService');
function GuiSystem:Hash()
acrylicId = acrylicId + 1
return "NightUIAcrylic_" .. tostring(acrylicId)
end
local function Hiter(planePos, planeNormal, rayOrigin, rayDirection)
local n = planeNormal
local d = rayDirection
local v = rayOrigin - planePos
local num = (n.x*v.x) + (n.y*v.y) + (n.z*v.z)
local den = (n.x*d.x) + (n.y*d.y) + (n.z*d.z)
if math.abs(den) < 0.000001 then
return nil
end
local a = -num / den
if a ~= a or math.abs(a) > 1e6 then
return nil
end
return rayOrigin + (a * rayDirection), a
end;
local sharedDepthOfField = nil
local function GetSharedDepthOfField()
if sharedDepthOfField and sharedDepthOfField.Parent then return sharedDepthOfField end
local ok, effect = pcall(function()
return Instance.new('DepthOfFieldEffect', game:GetService('Lighting'))
end)
if ok and effect then
effect.Enabled = true
effect.FarIntensity = 0
effect.FocusDistance = 51.6
effect.InFocusRadius = 50
effect.NearIntensity = 1
effect.Name = "NightCCUIDepthOfField"
sharedDepthOfField = effect
end
return sharedDepthOfField
end
function GuiSystem.new(frame,NoAutoBackground)
local Part = Instance.new('Part',workspace);
local DepthOfField = GetSharedDepthOfField()
local SurfaceGui = Instance.new('SurfaceGui',Part);
local BlockMesh = Instance.new("BlockMesh");
BlockMesh.Parent = Part;
Part.Material = Enum.Material.Glass;
Part.Transparency = 1;
Part.Reflectance = 0.1
Part.CastShadow = false
Part.Anchored = true
Part.CanCollide = false
Part.CanQuery = false
pcall(function()
local PhysicsService = game:GetService('PhysicsService')
if PhysicsService:IsCollisionGroupRegistered('NightUIGui') then
Part.CollisionGroup = 'NightUIGui'
else
PhysicsService:RegisterCollisionGroup('NightUIGui')
Part.CollisionGroup = 'NightUIGui'
end
end)
Part.Size = Vector3.new(1, 1, 1) * 0.01;
Part.Color = Color3.fromRGB(0,0,0);
if DepthOfField then
DepthOfField.Enabled = true
DepthOfField.FarIntensity = 0
DepthOfField.FocusDistance = 51.6
DepthOfField.InFocusRadius = 50
DepthOfField.NearIntensity = 1
end
SurfaceGui.AlwaysOnTop = true;
SurfaceGui.Adornee = Part;
SurfaceGui.Active = true;
SurfaceGui.Face = Enum.NormalId.Front;
SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Global;
if DepthOfField and not sharedDepthOfField then DepthOfField.Name = GuiSystem:Hash() end
Part.Name = GuiSystem:Hash();
SurfaceGui.Name = GuiSystem:Hash();
local C4 = {
Update = nil,
Collection = SurfaceGui,
Enabled = true,
Instances = {
BlockMesh = BlockMesh,
Part = Part,
DepthOfField = DepthOfField,
SurfaceGui = SurfaceGui,
},
Signal = nil
};
local lastQuality = nil
local lastTransparency = nil
local function resolveQualityTransparency()
local qualityLevel, target = nil, nil
pcall(function()
local userSettings = UserSettings():GetService("UserGameSettings")
qualityLevel = userSettings.SavedQualityLevel.Value
target = (qualityLevel == 0 or qualityLevel >= 8) and 0.8 or 1
end)
if type(qualityLevel) ~= "number" or type(target) ~= "number" then return nil end
return qualityLevel, target
end
local initialQuality, initialTarget = resolveQualityTransparency()
lastQuality = initialQuality
lastTransparency = initialTarget
Part.Transparency = initialTarget or 0.8
Part:SetAttribute("TargetTransparency", Part.Transparency)
local function syncQualityTransparency()
local qualityLevel, target = resolveQualityTransparency()
if not qualityLevel then return end
if lastQuality == qualityLevel and lastTransparency and math.abs(lastTransparency - target) < 0.001 then return end
lastQuality = qualityLevel
lastTransparency = target
pcall(function() Part:SetAttribute("TargetTransparency", target) end)
local ok, tween = pcall(function()
return Twen:Create(Part,TweenInfo.new(1,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Transparency = target})
end)
if ok and tween then pcall(function() tween:Play() end) end
end
local Update = function()
local camera = workspace.CurrentCamera
if not frame.Parent or not camera or not camera.Parent or frame.AbsoluteSize.X <= 0 or frame.AbsoluteSize.Y <= 0 then return end
syncQualityTransparency()
local ok, result0, result1 = pcall(function()
local corner0 = frame.AbsolutePosition
local corner1 = corner0 + frame.AbsoluteSize
local ray0 = camera:ScreenPointToRay(corner0.X, corner0.Y, 1)
local ray1 = camera:ScreenPointToRay(corner1.X, corner1.Y, 1)
local planeOrigin = camera.CFrame.Position + camera.CFrame.LookVector * (0.05 - camera.NearPlaneZ)
local planeNormal = camera.CFrame.LookVector
local pos0 = Hiter(planeOrigin, planeNormal, ray0.Origin, ray0.Direction)
local pos1 = Hiter(planeOrigin, planeNormal, ray1.Origin, ray1.Direction)
if not pos0 or not pos1 then return nil end
local a = camera.CFrame:PointToObjectSpace(pos0)
local b = camera.CFrame:PointToObjectSpace(pos1)
if a.X ~= a.X or a.Y ~= a.Y or a.Z ~= a.Z then return nil end
if b.X ~= b.X or b.Y ~= b.Y or b.Z ~= b.Z then return nil end
return a, b
end)
if not ok or not result0 or not result1 then return end
local size = result1 - result0
local center = (result0 + result1) / 2
local scaleX = math.clamp(math.abs(size.X) / 0.0101, 0.01, 4000)
local scaleY = math.clamp(math.abs(size.Y) / 0.0101, 0.01, 4000)
local scaleZ = math.clamp(math.abs(size.Z) / 0.0101, 0.01, 4000)
BlockMesh.Offset = center
BlockMesh.Scale = Vector3.new(scaleX, scaleY, scaleZ)
Part.CFrame = camera.CFrame
end
C4.Update = Update;
pcall(function()
C4.Signal2 = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
local camera = workspace.CurrentCamera
if camera and camera.Parent then Part.CFrame = camera.CFrame end
end)
end)
C4.Destroy = function()
if C4.Signal then C4.Signal:Disconnect() end
if C4.Signal2 then C4.Signal2:Disconnect() end
C4.Signal = nil
C4.Signal2 = nil
C4.Update = function() end
pcall(function()
Twen:Create(Part,TweenInfo.new(1),{
Transparency = 1
}):Play()
end)
Part:Destroy()
end;
return C4;
end;
return GuiSystem;
end;
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players:GetPlayers()[1] or {Name = "Player", DisplayName = "Player", UserId = 0}
local RunService = game:GetService('RunService')
local _windowConfigCounter = 0
local function IsPrimaryInput(input)
return input and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch)
end
local function GetPointerPosition()
local ok, position = pcall(function() return UserInputService:GetMouseLocation() end)
if ok and position then return position end
return Vector2.new(0, 0)
end
local function GetInputPosition(input)
if input and input.Position then return input.Position end
return GetPointerPosition()
end
local function InvokeCallback(callback, ...)
if type(callback) == "function" then pcall(callback, ...) end
end
local function IsAncestorVisible(object)
local current = object and object.Parent
while current do
local ok, visible = pcall(function() return current.Visible end)
if ok and visible == false then return false end
current = current.Parent
end
return true
end
local function IsPointInside(object, point)
if not object or not point then return false end
local ok, isGui = pcall(function() return object:IsA("GuiObject") end)
if not ok or not isGui or not object.Visible then return false end
if not IsAncestorVisible(object) then return false end
local size = object.AbsoluteSize
if size.X <= 0 or size.Y <= 0 then return false end
local position = object.AbsolutePosition
return point.X >= position.X and point.X <= position.X + size.X
and point.Y >= position.Y and point.Y <= position.Y + size.Y
end
local function IsPointInsideTree(object, point)
if IsPointInside(object, point) then return true end
if not object or not object.Parent then return false end
local ok, descendants = pcall(function() return object:GetDescendants() end)
if not ok then return false end
for _, descendant in ipairs(descendants) do
if IsPointInside(descendant, point) then return true end
end
return false
end
local function ClampRatio(value, maximum)
if maximum == nil or maximum <= 0 then return 0 end
return math.clamp(value / maximum, 0, 1)
end
local function NormalizeOptions(options)
local result = {}
if type(options) == "table" then
for _, value in ipairs(options) do
if value ~= nil then table.insert(result, tostring(value)) end
end
end
if #result == 0 then table.insert(result, "Auto") end
return result
end
local function NormalizeColor(value)
if typeof(value) == "Color3" then
return Color3.new(math.clamp(value.R, 0, 1), math.clamp(value.G, 0, 1), math.clamp(value.B, 0, 1))
end
return Color3.fromRGB(255, 255, 255)
end
local function ColorToHex(value)
local c = NormalizeColor(value)
return string.format("#%02X%02X%02X", math.clamp(math.round(c.R * 255), 0, 255), math.clamp(math.round(c.G * 255), 0, 255), math.clamp(math.round(c.B * 255), 0, 255))
end
local function NormalizeRange(min, max, default)
min = type(min) == "number" and min or 0
max = type(max) == "number" and max or 100
if min ~= min then min = 0 end
if max ~= max then max = 100 end
if max <= min then max = min + 1 end
local value = type(default) == "number" and default or min
if value ~= value then value = min end
return min, max, math.clamp(value, min, max)
end
local function GetValidOption(options, value)
for _, option in ipairs(options) do
if option == value then return value end
end
return options[1]
end
local function AddTextConstraint(object, minimum, maximum, force)
if not object or not object:IsA("GuiObject") then return end
if not (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")) then return end
if not object.TextScaled then return end
local constraint = object:FindFirstChild("ReadableTextConstraint")
if constraint and not force then return end
if not constraint then
constraint = Instance.new("UITextSizeConstraint")
constraint.Name = "ReadableTextConstraint"
constraint.Parent = object
end
constraint.MinTextSize = minimum or 9
constraint.MaxTextSize = maximum or 16
end
local function MakeReadableText(root, minimum, maximum)
if not root then return end
AddTextConstraint(root, minimum, maximum)
for _, object in ipairs(root:GetDescendants()) do
AddTextConstraint(object, minimum, maximum)
end
end
local function SerializeValue(v)
local t = type(v)
if t == "boolean" or t == "number" or t == "string" then
return v
elseif typeof(v) == "Color3" then
return { __type = "Color3", r = v.R, g = v.G, b = v.B }
elseif t == "table" then
local items = {}
for _, item in ipairs(v) do
local it = type(item)
if it == "string" or it == "number" or it == "boolean" then table.insert(items, item) end
end
return { __type = "List", v = items }
end
return nil
end
local function DeserializeValue(v)
if type(v) == "table" and v.__type == "Color3" then
local ok, color = pcall(Color3.new, tonumber(v.r) or 1, tonumber(v.g) or 1, tonumber(v.b) or 1)
if ok then return color end
elseif type(v) == "table" and v.__type == "List" then
return type(v.v) == "table" and v.v or {}
end
return v
end
local function GetImageData(name, image)
if not image then return end
name = type(name) == "string" and name:lower() or "ads"
local NigImage = "rbxassetid://3926305904"
if name == "ads" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(205,565); image.ImageRectSize = Vector2.new(35,35)
elseif name == "list" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(485,205); image.ImageRectSize = Vector2.new(35,35)
elseif name == "folder" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(805,45); image.ImageRectSize = Vector2.new(35,35)
elseif name == "earth" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(604,324); image.ImageRectSize = Vector2.new(35,35)
elseif name == "locked" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(524,644); image.ImageRectSize = Vector2.new(35,35)
elseif name == "home" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(964,205); image.ImageRectSize = Vector2.new(35,35)
elseif name == "mouse" then image.Image = "rbxassetid://94866180901611"
elseif name == "user" then image.Image = "rbxassetid://10494577250"
elseif name == "cosmetics" then image.Image = "rbxassetid://111448140849101"
elseif name == "sun" then image.Image = "rbxassetid://119948798441279"
elseif name == "shop" then image.Image = "rbxassetid://97513888174732"
elseif name == "farm" then image.Image = "rbxassetid://88262334591015"
elseif name == "code" then image.Image = "rbxassetid://137998322875646"
elseif name == "crosshair" then image.Image = "rbxassetid://107944169329467"
elseif name == "image" then image.Image = "rbxassetid://111273759419615"
elseif name == "layers" then image.Image = "rbxassetid://99581501168713"
elseif name == "side" then image.Image = "rbxassetid://109111534633587"
elseif name == "grenade" then image.Image = "rbxassetid://106253651509472"
elseif name == "bio" then image.Image = "rbxassetid://78652086695674"
elseif name == "camera" then image.Image = "rbxassetid://103880096339912"
elseif name == "car" then image.Image = "rbxassetid://116283987324457"
elseif name == "run" then image.Image = "rbxassetid://117007794770586"
elseif name == "box" then image.Image = "rbxassetid://140255234172865"
elseif name == "carcolor" then image.Image = "rbxassetid://135983067514338"
elseif name == "avacolor" then image.Image = "rbxassetid://88738565686900"
elseif name == "locker" then image.Image = "rbxassetid://87534652127926"
elseif name == "retry" then image.Image = "rbxassetid://85334730366974"
elseif name == "gun" then image.Image = "rbxassetid://93001822915827"
elseif name == "sword" then image.Image = "rbxassetid://82635240213192"
elseif name == "knife" then image.Image = "rbxassetid://94102397172403"
elseif name == "egg" then image.Image = "rbxassetid://110250017854460"
elseif name == "sprinkler" then image.Image = "rbxassetid://139620040051222"
elseif name == "gear" then image.Image = "rbxassetid://134488580093972"
elseif name == "aimbot" or name == "rage" or name == "combat" then image.Image = "rbxassetid://107944169329467"
elseif name == "legit" then image.Image = ""
elseif name == "visuals" then image.Image = "rbxassetid://111273759419615"
elseif name == "inventory" or name == "other" then image.Image = "rbxassetid://99581501168713"
elseif name == "miscellaneous" or name == "settings" then image.Image = "rbxassetid://134488580093972"
elseif name == "profile" or name == "account" then image.Image = "rbxassetid://10494577250"
elseif name == "configs" or name == "config" then
image.Image = NigImage; image.ImageRectOffset = Vector2.new(805,45); image.ImageRectSize = Vector2.new(35,35)
end
end
local Library = {}
Library.__index = Library
Library.ProfileIcons = {
language     = "rbxassetid://121978468376124",
menuScale    = "rbxassetid://114499998778667",
espScale     = "rbxassetid://127234874352422",
windowsScale = "rbxassetid://114499998778667",
units        = "rbxassetid://82464660673318",
style        = "rbxassetid://109485777305919",
safeMode     = "rbxassetid://127234874352422",
sync         = "rbxassetid://104941258142372",
about        = "rbxassetid://136533241128438",
chat         = "rbxassetid://121978468376124",
developer    = "rbxassetid://137998322875646",
}
Library.DaysLeft = nil
local _liveTweensByObject = setmetatable({}, { __mode = "k" })
local function Tween(obj, props, t, style, dir, delay)
if not obj or not obj.Parent or type(props) ~= "table" then return nil end
style = style or Enum.EasingStyle.Quad
dir = dir or Enum.EasingDirection.Out
local bucket = _liveTweensByObject[obj]
if not bucket then bucket = {}; _liveTweensByObject[obj] = bucket end
local cancel = {}
for property in pairs(props) do
local running = bucket[property]
if running then cancel[running] = true end
end
for running in pairs(cancel) do pcall(function() running:Cancel() end) end
bucket = _liveTweensByObject[obj]
if not bucket then bucket = {}; _liveTweensByObject[obj] = bucket end
local ok, tween = pcall(function()
return TweenService:Create(obj, TweenInfo.new(t or 0.2, style, dir, 0, false, delay or 0), props)
end)
if not ok or not tween then return nil end
for property in pairs(props) do bucket[property] = tween end
tween.Completed:Connect(function()
local current = _liveTweensByObject[obj]
if not current then return end
for property in pairs(props) do
if current[property] == tween then current[property] = nil end
end
if next(current) == nil then _liveTweensByObject[obj] = nil end
end)
tween:Play()
return tween
end
local CenterElement
local SizeSliderChip
local STROKE = { Color = Color3.fromRGB(255, 255, 255), Transparency = 0.92, Thickness = 1 }
local strokeScale = 1
local function ApplyStrokeScale(stroke, scale)
if not stroke or not stroke:IsA("UIStroke") then return end
stroke.Thickness = STROKE.Thickness
end
local function Stroke(parent, name)
local stroke = Instance.new("UIStroke")
stroke.Name = name or "Stroke"
stroke.Color = STROKE.Color
stroke.Transparency = STROKE.Transparency
stroke.Thickness = STROKE.Thickness
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
if parent then stroke.Parent = parent end
ApplyStrokeScale(stroke, strokeScale)
return stroke
end
local function RescaleStrokes(root, scale)
strokeScale = scale
if not root then return end
ApplyStrokeScale(root, scale)
for _, d in ipairs(root:GetDescendants()) do ApplyStrokeScale(d, scale) end
end
local function IsNightCCMenu(parent)
local current = parent
while current do
if current.Name == "NightCCUICS2" and current:IsA("ScreenGui") then
return true
end
current = current.Parent
end
return false
end
local function New(class, props, parent)
local obj = Instance.new(class)
if obj:IsA("GuiObject") and obj.BorderSizePixel == 1 then obj.BorderSizePixel = 0 end
for k, v in pairs(props or {}) do
pcall(function() obj[k] = v end)
end
if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
obj.TextYAlignment = Enum.TextYAlignment.Center
obj.TextScaled = false
local roleSizes = { Title = 17, GameTitle = 12, TabLabel = 12, TabText = 16, STLabel = 15, SectionLabel = 12,
TextToggle = 15, TextDropdown = 15, TextDefault = 14, TopBar = 15, SliderValue = 13,
Username = 15, SubLabel = 12, SaveText = 15, HeaderLabel = 12, SearchBox = 15 }
obj.TextSize = roleSizes[obj.Name] or ((props and props.TextSize) or 13)
if IsNightCCMenu(parent) then
obj.Font = (obj.Name == "Title" or obj.Name == "HeaderTitle" or obj.Name == "BadgeText" or obj.Name == "LoaderTitle") and FONT_BOLD or FONT
end
if obj.Name == "SectionLabel" or obj.Name == "TabLabel" then
obj.TextColor3 = Color3.fromRGB(92, 96, 106)
elseif obj.Name == "GameTitle" or obj.Name == "SubLabel" or obj.Name == "HeaderLabel" or obj.Name == "SearchEmptyState" then
obj.TextColor3 = Color3.fromRGB(112, 116, 138)
elseif obj.Name == "TextToggle" or obj.Name == "TextDropdown" or obj.Name == "TextDefault" or obj.Name == "TopBar" or obj.Name == "SaveText" then
obj.TextColor3 = Color3.fromRGB(230, 230, 230)
end
if obj.Name == "TextToggle" or obj.Name == "TextDropdown" or obj.Name == "TextDefault" or obj.Name == "TopBar" or obj.Name == "TabText" or obj.Name == "SaveText" then
obj.TextTruncate = Enum.TextTruncate.AtEnd
end
end
if parent then obj.Parent = parent end
if obj.Name == "TextToggle" and obj:IsA("TextLabel") then
obj.TextColor3 = Color3.fromRGB(235, 236, 241)
elseif obj.Name == "TopBarText" and obj:IsA("TextLabel") then
obj.TextColor3 = Color3.fromRGB(205, 208, 218)
elseif (obj.Name == "TopBar" or obj.Name == "SliderValue") and obj:IsA("GuiObject") then
local isValue = obj.Name == "SliderValue"
obj.BackgroundColor3 = isValue and Color3.fromRGB(22, 22, 31) or Color3.fromRGB(26, 26, 36)
obj.BackgroundTransparency = 0
if obj:IsA("TextLabel") then
obj.TextColor3 = isValue and Color3.fromRGB(176, 178, 188) or Color3.fromRGB(205, 208, 218)
obj.TextTransparency = 0
end
local fieldStroke = Instance.new("UIStroke")
fieldStroke.Name = "FieldOutline"
fieldStroke.Color = Color3.fromRGB(255, 255, 255)
fieldStroke.Transparency = isValue and 0.96 or 0.93
fieldStroke.Thickness = 1
fieldStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
fieldStroke.Parent = obj
elseif obj.Name == "TextDefault" and obj:IsA("TextLabel") and obj.Parent and obj.Parent.Name == "Selection" then
obj.AnchorPoint = Vector2.new(1, 0.5)
obj.Position = UDim2.new(1, -24, 0.5, 0)
obj.Size = UDim2.new(0.5, 0, 1, 0)
obj.TextXAlignment = Enum.TextXAlignment.Right
obj.TextColor3 = Color3.fromRGB(200, 203, 213)
elseif obj.Name == "TextArrow" and obj:IsA("ImageLabel") and obj.Parent and obj.Parent.Name == "Selection" then
obj.Position = UDim2.new(1, -8, 0.5, 0)
obj.Rotation = -90
obj.ImageTransparency = 0.3
elseif obj.Name == "Arrow" and obj:IsA("ImageLabel") then
obj.Size = UDim2.fromOffset(12, 12)
obj.ImageTransparency = 0.15
elseif obj.Name == "Line" and obj:IsA("Frame") then
obj.BackgroundColor3 = Color3.fromRGB(40, 42, 54)
elseif type(obj.Name) == "string" and obj.Name:match("^Dot%d$") and obj:IsA("Frame") then
obj.BackgroundColor3 = Color3.fromRGB(150, 154, 166)
local dotCorner = Instance.new("UICorner")
dotCorner.CornerRadius = UDim.new(1, 0)
dotCorner.Parent = obj
end
if obj:IsA("UIStroke") then
obj.Color = STROKE.Color
obj.Transparency = STROKE.Transparency
obj.Thickness = STROKE.Thickness
obj.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ApplyStrokeScale(obj, strokeScale)
end
AddTextConstraint(obj, 7, 16)
return obj
end
local function AttachRowHover(row)
if not row or not row:IsA("GuiObject") or row:GetAttribute("NLRowHoverAttached") then return end
local ok, baseTransparency = pcall(function() return row.BackgroundTransparency end)
if not ok or type(baseTransparency) ~= "number" or baseTransparency < 0.98 then return end
local baseColor = row.BackgroundColor3
row:SetAttribute("NLRowHoverAttached", true)
if not row:FindFirstChildOfClass("UICorner") then
New("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
end
row.MouseEnter:Connect(function()
if not row.Parent then return end
Tween(row, { BackgroundColor3 = Color3.fromRGB(245, 247, 255), BackgroundTransparency = 0.97 }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
row.MouseLeave:Connect(function()
if not row.Parent then return end
Tween(row, { BackgroundColor3 = baseColor, BackgroundTransparency = baseTransparency }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
end
local function CleanBorders(root)
if not root then return end
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("GuiObject") and d.BorderSizePixel ~= 0 then
d.BorderSizePixel = 0
end
end
end
CenterElement = function(el)
if not el or not el:IsA("GuiObject") then return end
local function place(child, center, h)
if not child or not child:IsA("GuiObject") then return end
local top = center - h * (0.5 - child.AnchorPoint.Y)
child.Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset, top, 0)
child.Size = UDim2.new(child.Size.X.Scale, child.Size.X.Offset, h, 0)
end
local function placeText(child, center, h)
if not child or not (child:IsA("TextLabel") or child:IsA("TextButton")) then return end
child.TextYAlignment = Enum.TextYAlignment.Center
if child.TextXAlignment ~= Enum.TextXAlignment.Right then child.TextXAlignment = Enum.TextXAlignment.Left end
place(child, center, h)
end
for _, name in ipairs({ "TextToggle", "TextDefault", "TextAccordion", "TextDropdown", "TextAccordionLabel" }) do
placeText(el:FindFirstChild(name), 0.5, 0.5)
end
local toggleLabel = el:FindFirstChild("TextToggle")
if toggleLabel and toggleLabel:IsA("GuiObject") then
toggleLabel.Size = UDim2.new(0.58, toggleLabel.Size.X.Offset, toggleLabel.Size.Y.Scale, toggleLabel.Size.Y.Offset)
end
local effect = el:FindFirstChild("Effect")
local sliderEffect = effect and effect:IsA("GuiObject") and effect:FindFirstChild("Line") and effect:FindFirstChild("SliderValue")
if effect and effect:IsA("GuiObject") then
if effect:FindFirstChild("Icon") then
effect.AnchorPoint = Vector2.new(1, 0.5)
effect.Position = UDim2.new(1, -14, 0.5, 0)
effect.Size = UDim2.fromOffset(33, 20)
elseif sliderEffect then
if SizeSliderChip then SizeSliderChip(effect, effect:FindFirstChild("Line"), effect:FindFirstChild("SliderValue")) end
else
place(effect, 0.5, 0.7)
end
end
if not sliderEffect then
place(el:FindFirstChild("Line"), 0.5, 0.24)
place(el:FindFirstChild("SliderValue"), 0.5, 0.8)
end
local cp = el:FindFirstChild("colorpickerButton")
if cp and cp:IsA("GuiObject") then
local cpOffset = -14
if el:FindFirstChild("TopBar") then
cpOffset = -155
elseif effect and effect:FindFirstChild("Icon") then
cpOffset = -55
end
cp.AnchorPoint = Vector2.new(1, 0.5)
cp.Position = UDim2.new(1, cpOffset, 0.5, 0)
cp.Size = UDim2.fromOffset(16, 16)
end
local rowLabel = el:FindFirstChild("TextToggle") or el:FindFirstChild("TextDropdown")
if rowLabel and rowLabel:IsA("GuiObject") then
local width = 0.55
if el.Name == "Dropdown" or sliderEffect then width = 0.42 end
if el:FindFirstChild("ColorpickerOpenButton") then width = 0.36 end
if effect and effect:FindFirstChild("Icon") and cp then width = 0.36 end
rowLabel.Size = UDim2.new(width, 0, 0.5, 0)
rowLabel.TextTruncate = Enum.TextTruncate.AtEnd
end
place(el:FindFirstChild("DropdownArrow") or el:FindFirstChild("TextboxArrow"), 0.5, 0.5)
end
local ELLIPSIS = "..."
local TextService = game:GetService("TextService")
local MEASURE_SIZE = Vector2.new(10000, 10000)
local function MeasureText(text, fontSize, font)
local ok, size = pcall(TextService.GetTextSize, TextService, text, fontSize or 14, font or FONT, MEASURE_SIZE)
if ok and size then return size.X end
return 0
end
SizeSliderChip = function(effect, line, value)
if not effect or not line or not value or not effect.Parent then return end
local textWidth = MeasureText(tostring(value.Text or ""), 14, FONT)
local chipWidth = math.max(30, math.ceil(textWidth) + 10)
value.AnchorPoint = Vector2.new(1, 0.5)
value.Position = UDim2.new(1, 0, 0.5, 0)
value.Size = UDim2.fromOffset(chipWidth, 22)
value.BackgroundColor3 = Color3.fromRGB(22, 22, 31)
value.TextScaled = false
value.TextSize = 13
value.Font = FONT
value.TextColor3 = Color3.fromRGB(176, 178, 188)
value.TextTransparency = 0
value.TextXAlignment = Enum.TextXAlignment.Center
effect.AnchorPoint = Vector2.new(0, 0.5)
local inPlate = effect:FindFirstAncestor("SettingsFrame") or effect:FindFirstAncestor("AccordionFrame")
if inPlate then
effect.Position = UDim2.new(0, 104, 0.5, 0)
effect.Size = UDim2.new(1, -116, 0, 22)
else
effect.Position = UDim2.new(0, 150, 0.5, 0)
effect.Size = UDim2.new(1, -164, 0, 22)
end
line.AnchorPoint = Vector2.new(0, 0.5)
line.Position = UDim2.new(0, 0, 0.5, 0)
line.Size = UDim2.new(1, -(chipWidth + 10), 0, 3)
line.BackgroundColor3 = Color3.fromRGB(45, 48, 64)
line.BorderSizePixel = 0
if not value:GetAttribute("NLSliderChipWatch") then
value:SetAttribute("NLSliderChipWatch", true)
value:GetPropertyChangedSignal("Text"):Connect(function()
if value.Parent and effect.Parent then task.defer(function()
if value.Parent and effect.Parent then SizeSliderChip(effect, line, value) end
end) end
end)
end
end
local function BindKeyName(key)
if not key then return "—" end
local n
if type(key) == "string" then
n = key
else
local ok, keyName = pcall(function() return key.Name end)
if ok then n = keyName end
end
if type(n) ~= "string" then return tostring(key) end
if n == "MouseButton3" then return "Mouse 3" end
if n == "MouseButton4" then return "Mouse 4" end
if n == "MouseButton5" then return "Mouse 5" end
if n == "MouseWheelUp" then return "Wheel Up" end
if n == "MouseWheelDown" then return "Wheel Down" end
return n
end
local function EllipsizeTo(label, maxWidth)
if not label or not label:IsA("TextLabel") and not label:IsA("TextButton") then return end
if type(maxWidth) ~= "number" or maxWidth <= 0 then return end
local full = label:GetAttribute("FullText")
if type(full) ~= "string" or full == "" then
full = label.Text
label:SetAttribute("FullText", full)
end
if full == "" then return end
local fontSize = label.TextSize or 14
local font = label.Font or FONT
local unscaled = MeasureText(full, fontSize, font)
if unscaled <= 0 then return end
local scale = 1
if label.TextScaled and label.TextBounds.X > 0 then
scale = label.TextBounds.X / unscaled
if scale <= 0 or scale ~= scale then scale = 1 end
end
local function rendered(text)
return MeasureText(text, fontSize, font) * scale
end
if rendered(full) <= maxWidth then
if label.Text ~= full then label.Text = full end
return
end
local low, high, best = 1, #full, ""
while low <= high do
local mid = math.floor((low + high) / 2)
local candidate = full:sub(1, mid) .. ELLIPSIS
if rendered(candidate) <= maxWidth then
best = candidate
low = mid + 1
else
high = mid - 1
end
end
label.Text = best ~= "" and best or ELLIPSIS
end
local Z_BASE = 10000
local THEME = {
plate = Color3.fromRGB(20, 23, 34),
row = Color3.fromRGB(28, 31, 45),
stroke = Color3.fromRGB(255, 255, 255),
strokeAlpha = 0.92,
text = Color3.fromRGB(230, 230, 230),
dim = Color3.fromRGB(112, 116, 138),
danger = Color3.fromRGB(233, 90, 110),
radius = 12,
}
local _popupZStep = 0
local function TweenShadowLayers(frame, show, dur, dir)
for _, node in ipairs(frame:GetDescendants()) do
if node:GetAttribute("IsShadowLayer") then
local alpha = node:GetAttribute("ShadowAlpha") or 0.8
Tween(node, { BackgroundTransparency = show and alpha or 1 }, dur or 0.2, Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out)
end
end
end
local Z_RUNG = 100
local function NextPopupZ()
_popupZStep = _popupZStep + 1
if _popupZStep > 40 then _popupZStep = 1 end
return Z_BASE + _popupZStep * Z_RUNG
end
local function ApplyZIndexLadder(root, base)
if not root or not root:IsA("GuiObject") then return end
local queue = { { instance = root, depth = 0 } }
local index = 0
while index < #queue do
local entry = queue[index + 1]
index = index + 1
local instance = entry.instance
local depth = entry.depth
if instance:IsA("GuiObject") then
instance.ZIndex = base + depth
if instance:GetAttribute("IsShadowLayer") then
instance.ZIndex = base + depth - 2
elseif instance.Name == "InputSink" then
instance.ZIndex = base + depth - 1
end
end
for _, child in ipairs(instance:GetChildren()) do
table.insert(queue, { instance = child, depth = depth + 1 })
end
end
end
local function GetDragShield(frame)
if not frame then return nil end
local shield = frame:FindFirstChild("DragShield")
if not shield then
shield = New("TextButton", {
Name = "DragShield",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text = "",
AutoButtonColor = false,
Active = true,
Visible = false,
ZIndex = 4990,
}, frame)
end
return shield
end
local function AddInputSink(frame)
if not frame or not frame:IsA("GuiObject") or frame:IsA("ScrollingFrame") then return end
if frame:FindFirstChild("InputSink") then return end
if frame:FindFirstChildOfClass("UIListLayout") or frame:FindFirstChildOfClass("UIGridLayout") then
frame.Active = true
return
end
New("TextButton", {
Name = "InputSink",
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text = "",
AutoButtonColor = false,
Active = true,
ZIndex = frame.ZIndex,
}, frame)
end
local function StartPlateGroup(container)
if not container:GetAttribute("NLGrouped") then
container:SetAttribute("NLGrouped", true)
container.BackgroundTransparency = 1
local outline = container:FindFirstChild("CardOutline")
if outline then outline.Enabled = false end
local layout = container:FindFirstChildOfClass("UIListLayout")
if layout then layout.Padding = UDim.new(0, 8) end
local rows = {}
for _, child in ipairs(container:GetChildren()) do
if child:IsA("GuiObject") then table.insert(rows, child) end
end
if #rows > 0 then
local first = StartPlateGroup(container)
for _, row in ipairs(rows) do row.Parent = first end
end
end
local order = (container:GetAttribute("NLGroupCount") or 0) + 1
container:SetAttribute("NLGroupCount", order)
local card = New("Frame", {
Name = "PlateGroup" .. order,
Size = UDim2.new(1, 0, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = Color3.fromRGB(27, 27, 36),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = order * 1000,
ZIndex = container.ZIndex,
}, container)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, card)
Stroke(card, "CardOutline").Transparency = 0.955
New("UIListLayout", { Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder }, card)
New("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, card)
return card
end
local function MeasureRowsHeight(container)
local count = 0
local total = 0
for _, child in ipairs(container:GetChildren()) do
if child:IsA("GuiObject") then
local okSize, sizeValue = pcall(function() return child.AbsoluteSize end)
if okSize and sizeValue and sizeValue.Y > 0 then total = total + sizeValue.Y end
count = count + 1
end
end
if count == 0 then return 0, 0 end
local padding = 0
local okLayout, layout = pcall(function() return container:FindFirstChildOfClass("UIListLayout") end)
if okLayout and layout then padding = layout.Padding.Offset or 0 end
return total + padding * (count - 1), count
end
local function EstimateRowsHeight(container, count, aspect)
if count <= 0 then return 0 end
local okSize, sizeValue = pcall(function() return container.AbsoluteSize end)
if not okSize or not sizeValue or sizeValue.X <= 0 then return 0 end
local padding = 0
local okLayout, layout = pcall(function() return container:FindFirstChildOfClass("UIListLayout") end)
if okLayout and layout then padding = layout.Padding.Offset or 0 end
return count * (sizeValue.X / (aspect or 7.5)) + padding * (count - 1)
end
local function RefreshRowDividers(listFrame)
if not listFrame or not listFrame.Parent then return end
local rows = {}
for _, child in ipairs(listFrame:GetChildren()) do
if child:IsA("GuiObject") then
if listFrame:GetAttribute("NLGroupOutlineInset") and not child:GetAttribute("NLGroupInsetApplied") then
child:SetAttribute("NLGroupInsetApplied", true)
end
local divider = child:FindFirstChild("Lines")
if divider and divider:IsA("GuiObject") then
divider.Visible = true
divider.Position = UDim2.new(0, 14, 1, -1)
divider.Size = UDim2.new(1, -28, 0, 1)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BackgroundTransparency = 0.965
divider.BorderSizePixel = 0
table.insert(rows, divider)
end
end
end
if #rows > 0 then
rows[#rows].Visible = false
end
end
local _watchedDividers = {}
local function WatchRowDividers(listFrame)
if not listFrame or _watchedDividers[listFrame] then return end
_watchedDividers[listFrame] = true
RefreshRowDividers(listFrame)
listFrame.ChildAdded:Connect(function() task.defer(RefreshRowDividers, listFrame) end)
listFrame.ChildRemoved:Connect(function() task.defer(RefreshRowDividers, listFrame) end)
table.insert(_watchedDividers, listFrame)
end
task.spawn(function()
while true do
task.wait(2)
for i = #_watchedDividers, 1, -1 do
local frame = _watchedDividers[i]
if not frame or not frame.Parent then table.remove(_watchedDividers, i) end
end
end
end)
local _contentAlphaState = setmetatable({}, { __mode = "k" })
local _contentRevealTokens = setmetatable({}, { __mode = "k" })
local function ContentAlphaTargets(object)
local state = _contentAlphaState[object]
if state then return state end
state = {}
if (object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox")) and object.Text ~= "" then
state.TextTransparency = object.TextTransparency
end
if object:IsA("UIStroke") and object.Name ~= "GroupOutline" then
state.Transparency = object.Transparency
end
_contentAlphaState[object] = state
return state
end
local function HasVisiblePath(object, root)
local current = object
while current and current ~= root do
if current:IsA("GuiObject") and not current.Visible then return false end
current = current.Parent
end
return current == root
end
local function RevealContentRows(elements)
if not elements or not elements.Parent or not elements:IsA("GuiObject") or not elements.Visible then return end
local token = (_contentRevealTokens[elements] or 0) + 1
_contentRevealTokens[elements] = token
local rows = {}
for _, child in ipairs(elements:GetChildren()) do
if child:IsA("GuiObject") then table.insert(rows, child) end
end
table.sort(rows, function(a, b) return a.LayoutOrder < b.LayoutOrder end)
for index, row in ipairs(rows) do
if row.Visible then
local delaySeconds = math.min((index - 1) * 0.012, 0.10)
task.delay(delaySeconds, function()
if not elements.Parent or not row.Parent or _contentRevealTokens[elements] ~= token then return end
local objects = { row }
for _, descendant in ipairs(row:GetDescendants()) do
table.insert(objects, descendant)
end
for _, object in ipairs(objects) do
if object.Parent and HasVisiblePath(object, elements) then
local targets = ContentAlphaTargets(object)
local props = {}
for property, target in pairs(targets) do
if type(target) == "number" and target < 0.995 then
props[property] = target
pcall(function() object[property] = 1 end)
end
end
if next(props) then
Tween(object, props, 0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
end
end
end)
end
end
end
local function AnimateSectionColumn(column)
if not column or not column.Parent or not column.Visible then return end
local token = (column:GetAttribute("NLSectionMotionToken") or 0) + 1
column:SetAttribute("NLSectionMotionToken", token)
local columnPadding = column:FindFirstChildOfClass("UIPadding")
if columnPadding then
local delaySeconds = column.Name == "Right" and 0.035 or 0
columnPadding.PaddingTop = UDim.new(0, 12)
Tween(columnPadding, { PaddingTop = UDim.new(0, 0) }, 0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, delaySeconds)
end
local sections = {}
for _, section in ipairs(column:GetChildren()) do
if section:IsA("GuiObject") and section.Visible then
table.insert(sections, section)
end
end
table.sort(sections, function(a, b) return a.LayoutOrder < b.LayoutOrder end)
for index, section in ipairs(sections) do
local delaySeconds = math.min((index - 1) * 0.018, 0.054)
task.delay(delaySeconds, function()
if not column.Parent or not column.Visible or column:GetAttribute("NLSectionMotionToken") ~= token then return end
if not section.Parent or not section.Visible then return end
local motionScale = section:FindFirstChild("SectionMotionScale")
if motionScale and motionScale:IsA("UIScale") then motionScale.Scale = 1 end
local list = section:FindFirstChild("Elements") or section:FindFirstChild("Container")
if list and list:IsA("GuiObject") then
local outline = list:FindFirstChild("GroupOutline")
if outline and outline:IsA("UIStroke") then
local target = outline:GetAttribute("NLBaseTransparency")
if type(target) ~= "number" then
target = outline.Transparency
outline:SetAttribute("NLBaseTransparency", target)
end
outline.Transparency = math.min(0.84, target + 0.16)
Tween(outline, { Transparency = target }, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end
end
local heading = section:FindFirstChild("SectionLabel", true)
if heading and heading:IsA("TextLabel") then
local baseColor = heading:GetAttribute("NLBaseTextColor")
if typeof(baseColor) ~= "Color3" then
baseColor = heading.TextColor3
heading:SetAttribute("NLBaseTextColor", baseColor)
end
heading.TextColor3 = Color3.fromRGB(190, 199, 224)
Tween(heading, { TextColor3 = baseColor }, 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
end)
end
end
local function GetSliderStep(min, max)
local span = max - min
if span <= 0 then return 1 end
if span >= 20 then return 1 end
return 0.1
end
local function Quantize(value, min, max, step)
local clamped = math.clamp(value, min, max)
local snapped = min + math.round((clamped - min) / step) * step
if math.abs(snapped - max) < step * 0.001 then snapped = max end
if math.abs(snapped - math.round(snapped)) < 0.0001 then snapped = math.round(snapped) end
return snapped
end
local function FormatSliderValue(value, suffix)
suffix = tostring(suffix or ""):gsub("^%s+", ""):gsub("%s+$", "")
local text
if string.find(suffix, "°", 1, true) then
text = string.format("%.1f", value)
elseif math.abs(value - math.round(value)) < 0.0001 then
text = tostring(math.round(value))
else
text = string.format("%.1f", value)
end
return text .. (suffix or "")
end
local RepositionOpenPopups
local function MakeDraggable(frame, handle)
handle = handle or frame
frame.Draggable = false
local dragging = false
local dragInput, pointerPos, framePos
local function update(input)
if not input or not input.Position then return end
local delta = input.Position - pointerPos
local position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
local camera = workspace.CurrentCamera
if camera and camera.ViewportSize.X > frame.AbsoluteSize.X and camera.ViewportSize.Y > frame.AbsoluteSize.Y then
local anchor = frame.AnchorPoint
local x = position.X.Scale * camera.ViewportSize.X + position.X.Offset
local y = position.Y.Scale * camera.ViewportSize.Y + position.Y.Offset
x = math.clamp(x, frame.AbsoluteSize.X * anchor.X, camera.ViewportSize.X - frame.AbsoluteSize.X * (1 - anchor.X))
y = math.clamp(y, frame.AbsoluteSize.Y * anchor.Y, camera.ViewportSize.Y - frame.AbsoluteSize.Y * (1 - anchor.Y))
position = UDim2.fromOffset(x, y)
end
frame.Position = position
if RepositionOpenPopups then RepositionOpenPopups() end
end
handle.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then
dragging = true
dragInput = input
pointerPos = input.Position
framePos = frame.Position
local shield = GetDragShield(frame)
if shield then shield.Visible = true end
end
end)
handle.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
dragInput = input
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and input == dragInput then update(input) end
end)
UserInputService.InputEnded:Connect(function(input)
if IsPrimaryInput(input) then
dragging = false
dragInput = nil
local shield = frame:FindFirstChild("DragShield")
if shield then shield.Visible = false end
end
end)
end
local _openPopups = {}
local _popupClipRestore = {}
local _popupClipCounts = {}
local UnregisterPopup
local RestorePopupClipping
local function IsPopupAncestor(ancestor, descendant)
if not ancestor or not descendant or ancestor == descendant then return false end
local ok, result = pcall(function() return descendant:IsDescendantOf(ancestor) end)
return ok and result
end
local function RegisterPopup(frame, closeFn, trigger)
if not frame or type(closeFn) ~= "function" then return end
AddInputSink(frame)
for i = #_openPopups, 1, -1 do
local entry = _openPopups[i]
if not entry.frame or not entry.frame.Parent then
if entry.connection then pcall(function() entry.connection:Disconnect() end) end
RestorePopupClipping(entry.frame)
table.remove(_openPopups, i)
elseif entry.frame == frame then
entry.closeFn = closeFn
entry.trigger = trigger
return
end
end
local parentFrame
if trigger then
for _, entry in ipairs(_openPopups) do
if entry.frame ~= frame and IsPopupAncestor(entry.frame, trigger) then
parentFrame = entry.frame
end
end
end
local connection
if frame.Destroying and frame.Destroying.Connect then
local ok, result = pcall(function()
return frame.Destroying:Connect(function()
UnregisterPopup(frame)
if connection then pcall(function() connection:Disconnect() end) end
end)
end)
if ok then connection = result end
end
table.insert(_openPopups, {frame = frame, closeFn = closeFn, trigger = trigger, parent = parentFrame, connection = connection})
end
local function IsLogicalChild(frame, root)
local guard = 0
while frame and guard < 16 do
guard = guard + 1
local parentFrame
for _, entry in ipairs(_openPopups) do
if entry.frame == frame then parentFrame = entry.parent end
end
if parentFrame == root then return true end
frame = parentFrame
end
return false
end
UnregisterPopup = function(frame)
local copy = {}
for i, entry in ipairs(_openPopups) do copy[i] = entry end
for _, entry in ipairs(copy) do
if entry.frame ~= frame and IsLogicalChild(entry.frame, frame) and type(entry.closeFn) == "function" then
pcall(entry.closeFn)
end
end
for i = #_openPopups, 1, -1 do
if _openPopups[i].frame == frame then
if _openPopups[i].connection then pcall(function() _openPopups[i].connection:Disconnect() end) end
table.remove(_openPopups, i)
end
end
task.delay(0.22, function()
for _, entry in ipairs(_openPopups) do
if entry.frame == frame then return end
end
RestorePopupClipping(frame)
end)
end
local function KeepPopupChain(keep, frame)
local guard = 0
while frame and not keep[frame] and guard < 16 do
keep[frame] = true
guard = guard + 1
local parentFrame
for _, entry in ipairs(_openPopups) do
if entry.frame == frame then parentFrame = entry.parent end
end
frame = parentFrame
end
end
local function CloseAllPopupsExcept(exceptFrame)
local copy = {}
for i, entry in ipairs(_openPopups) do copy[i] = entry end
local keep = {}
local pointer = GetPointerPosition()
for _, entry in ipairs(copy) do
if entry.frame and entry.frame.Parent and entry.frame.Visible and pointer and IsPointInsideTree(entry.frame, pointer) then
KeepPopupChain(keep, entry.frame)
end
end
for _, entry in ipairs(copy) do
if entry.frame and entry.frame.Parent and entry.frame ~= exceptFrame and not keep[entry.frame]
and not IsPopupAncestor(entry.frame, exceptFrame) and type(entry.closeFn) == "function" then
pcall(entry.closeFn)
end
end
end
local function HideAllPopupsNow(instant)
local copy = {}
for i, entry in ipairs(_openPopups) do copy[i] = entry end
for _, entry in ipairs(copy) do
local frame = entry.frame
if frame and frame.Parent then
if entry.connection then pcall(function() entry.connection:Disconnect() end) end
RestorePopupClipping(frame)
if instant then
frame.Visible = false
else
local token = (frame:GetAttribute("PopupToken") or 0) + 1
frame:SetAttribute("PopupToken", token)
Tween(frame, { BackgroundTransparency = 1 }, 0.18)
TweenShadowLayers(frame, false, 0.18, Enum.EasingDirection.In)
task.delay(0.19, function()
if not frame.Parent or frame:GetAttribute("PopupToken") ~= token then return end
frame.Visible = false
local home = frame.Parent
if home and home:IsA("GuiObject") then ApplyZIndexLadder(frame, home.ZIndex) end
end)
end
end
end
table.clear(_openPopups)
end
local function ClosePopupsUnder(root)
if not root then return end
local copy = {}
for i, entry in ipairs(_openPopups) do copy[i] = entry end
for _, entry in ipairs(copy) do
if entry.frame and entry.frame ~= root and (IsPopupAncestor(root, entry.frame) or IsLogicalChild(entry.frame, root))
and type(entry.closeFn) == "function" then
pcall(entry.closeFn)
end
end
end
UserInputService.InputBegan:Connect(function(input)
if not IsPrimaryInput(input) then return end
local point = GetInputPosition(input)
local toClose = {}
local keep = {}
for _, entry in ipairs(_openPopups) do
local frame = entry.frame
if frame and frame.Parent and frame.Visible then
local inside = IsPointInsideTree(frame, point)
if entry.trigger and entry.trigger.Parent then
inside = inside or IsPointInsideTree(entry.trigger, point)
end
if inside then KeepPopupChain(keep, frame) end
end
end
for _, entry in ipairs(_openPopups) do
local frame = entry.frame
if frame and frame.Parent and frame.Visible and not keep[frame] and type(entry.closeFn) == "function" then
table.insert(toClose, entry.closeFn)
end
end
for _, fn in ipairs(toClose) do pcall(fn) end
end)
local _activePopupTweens = setmetatable({}, { __mode = "k" })
local function CancelPopupTween(frame)
if not frame then return end
local running = _activePopupTweens[frame]
_activePopupTweens[frame] = nil
if running then
pcall(function() running:Cancel() end)
end
end
local function PlayPopupTween(frame, info, props)
if not frame or not frame.Parent then return end
local ok, tween = pcall(function() return TweenService:Create(frame, info, props) end)
if not ok or not tween then return end
_activePopupTweens[frame] = tween
tween.Completed:Connect(function()
if _activePopupTweens[frame] == tween then
_activePopupTweens[frame] = nil
end
end)
tween:Play()
end
local function GetPopupScale(frame)
if not frame or not frame.Parent then return nil end
local pop = frame:FindFirstChild("_PopScale")
if pop and pop:IsA("UIScale") then return pop end
local existing = frame:FindFirstChildOfClass("UIScale")
if existing then return nil end
return New("UIScale", { Name = "_PopScale", Scale = 1 }, frame)
end
local function FadePopupContent(frame, show, dur)
for _, d in ipairs(frame:GetDescendants()) do
if not d:GetAttribute("IsShadowLayer") then
local prop, key
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
prop, key = "TextTransparency", "NLFadeText"
elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
prop, key = "ImageTransparency", "NLFadeImage"
end
if prop then
if show then
local base = d:GetAttribute(key)
if type(base) ~= "number" then base = d[prop] end
d:SetAttribute(key, nil)
d[prop] = 1
Tween(d, { [prop] = base }, dur, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
else
if d:GetAttribute(key) == nil then d:SetAttribute(key, d[prop]) end
Tween(d, { [prop] = 1 }, dur, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end
end
end
end
end
local function SmoothOpen(frame, targetAlpha, dur, style, dir)
if not frame or not frame.Parent then return end
local token = (frame:GetAttribute("PopupToken") or 0) + 1
frame:SetAttribute("PopupToken", token)
CancelPopupTween(frame)
frame.BackgroundTransparency = 1
frame.Visible = true
TweenShadowLayers(frame, true, dur or 0.2)
FadePopupContent(frame, true, dur or 0.17)
local scale = GetPopupScale(frame)
if scale then
scale.Scale = 0.965
Tween(scale, { Scale = 1 }, dur or 0.17, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end
PlayPopupTween(frame, TweenInfo.new(dur or 0.17, style or Enum.EasingStyle.Quint, dir or Enum.EasingDirection.Out), {BackgroundTransparency = targetAlpha})
end
local function SmoothClose(frame, dur, cb)
if not frame or not frame.Parent then return end
local token = (frame:GetAttribute("PopupToken") or 0) + 1
frame:SetAttribute("PopupToken", token)
CancelPopupTween(frame)
TweenShadowLayers(frame, false, dur or 0.18, Enum.EasingDirection.In)
FadePopupContent(frame, false, dur or 0.14)
local scale = GetPopupScale(frame)
if scale then
Tween(scale, { Scale = 0.985 }, dur or 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
end
PlayPopupTween(frame, TweenInfo.new(dur or 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1})
task.delay((dur or 0.14) + 0.01, function()
if frame.Parent and frame:GetAttribute("PopupToken") == token then
frame.Visible = false
if scale then scale.Scale = 1 end
local home = frame.Parent
if home and home:IsA("GuiObject") then ApplyZIndexLadder(frame, home.ZIndex) end
if cb then cb() end
end
end)
end
function Library:AddWindow(hubTitle, hubImage, gameTitle)
hubTitle = tostring(hubTitle or "night.cc")
hubImage = tostring(hubImage or "rbxassetid://8942361531")
gameTitle = tostring(gameTitle or "night.cc")
if string.lower(hubTitle) == "nightcc" and string.lower(gameTitle) == "blockstrike" then
hubTitle, gameTitle = gameTitle, hubTitle
end
local daysLeft = tonumber(Library.DaysLeft) or "night.cc"
_windowConfigCounter = _windowConfigCounter + 1
local windowConfigId = tostring(_windowConfigCounter)
local _registeredElements = {}
local configKeyCounts = {}
local function RegisterConfigElement(prefix, label, object)
local base = tostring(prefix) .. tostring(label or "item")
local count = (configKeyCounts[base] or 0) + 1
configKeyCounts[base] = count
table.insert(_registeredElements, {key = base .. "#" .. count, obj = object})
end
local mainColor = Color3.fromRGB(255, 255, 255)
local tabs = {}
local activeTabIndex = nil
local tabOrder = 0
local WindowObj = {}
WindowObj._configExtras = {}
WindowObj._loaderActive = false and Library.ShowLoader ~= false
local _coloredElements = {}
local logoVisible = true
local customization = {
font = FONT,
textColor = Color3.fromRGB(230, 230, 230),
sectionTitleSize = 12,
sectionTitleColor = Color3.fromRGB(92, 96, 106),
sectionTitleTransparency = 0,
watermarkText = "night.cc",
watermarkVisible = false,
cornerRadius = 14,
showContextDots = true,
}
local screenGuiParent
pcall(function() screenGuiParent = game.CoreGui end)
if not screenGuiParent then
local ok, coreGui = pcall(function() return game:GetService("CoreGui") end)
if ok then screenGuiParent = coreGui end
end
if not screenGuiParent and LocalPlayer and LocalPlayer.FindFirstChildOfClass then
local ok, playerGui = pcall(function() return LocalPlayer:FindFirstChildOfClass("PlayerGui") end)
if ok then screenGuiParent = playerGui end
end
if not screenGuiParent then
pcall(function() screenGuiParent = game:GetService("CoreGui") end)
end
local NightUICS2 = New("ScreenGui", {
Name = "NightCCUICS2",
ResetOnSpawn = false,
ClipToDeviceSafeArea = false,
DisplayOrder = 100,
ZIndexBehavior = Enum.ZIndexBehavior.Global,
}, screenGuiParent)
local MainFrame = New("Frame", {
Name = "MainFrame",
Active = true,
Draggable = false,
AnchorPoint = Vector2.new(0.5, 0.43),
Size = UDim2.new(0.78, 0, 0.78, 0),
Position = UDim2.new(0.5, 0, 0.43, 0),
BackgroundColor3 = Color3.fromRGB(8, 10, 17),
BackgroundTransparency = 0.25,
BorderSizePixel = 0,
ClipsDescendants = false,
}, NightUICS2)
local MainFrameUIScale
local windowTargetSize = MainFrame.Size
local windowAnimSize = UDim2.new(
windowTargetSize.X.Scale * 0.97, windowTargetSize.X.Offset * 0.97,
windowTargetSize.Y.Scale * 0.97, windowTargetSize.Y.Offset * 0.97
)
local _windowContextTargets = {}
GetDragShield(MainFrame)
local Watermark = New("TextLabel", {
Name = "Watermark",
Visible = false,
Position = UDim2.new(0.982, 0, 0.984, 0),
Size = UDim2.new(0.150, 0, 0.026, 0),
AnchorPoint = Vector2.new(1, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.94,
Text = "night.cc  •  UI",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextTransparency = 0.35,
TextScaled = false,
TextSize = 11,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Center,
TextYAlignment = Enum.TextYAlignment.Center,
ZIndex = 6000,
}, MainFrame)
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = Watermark end
local watermarkConstraint = Watermark:FindFirstChild("ReadableTextConstraint")
if watermarkConstraint then
watermarkConstraint.MinTextSize = 9
watermarkConstraint.MaxTextSize = 11
end
customization.watermark = Watermark
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 14); c.Parent = MainFrame end
do local windowStroke = Stroke(MainFrame, "WindowOutline"); windowStroke.Transparency = 0.95 end
local DragHandle = New("Frame", {
Name = "DragHandle",
Position = UDim2.new(0.2, 0, 0, 0),
Size = UDim2.new(0.6, 0, 0, 54),
BackgroundTransparency = 1,
Active = true,
ZIndex = 1,
}, MainFrame)
New("UISizeConstraint", {
MinSize = Vector2.new(220, 180),
MaxSize = Vector2.new(1600, 1200),
}, MainFrame)
local AcrylicLib = LoadAcrylic()
local AcrylicBlur = AcrylicLib.new(MainFrame)
WindowObj._blurs = {}
WindowObj._makeDraggable = function(handle, target, saveKey)
if saveKey then
WindowObj._configExtras["pos_" .. saveKey] = {
get = function()
if not target:GetAttribute("Dragged") then return nil end
local p = target.Position
return { p.X.Scale, p.X.Offset, p.Y.Scale, p.Y.Offset }
end,
set = function(v)
if type(v) ~= "table" or type(v[4]) ~= "number" then return end
target.Position = UDim2.new(v[1], v[2], v[3], v[4])
target:SetAttribute("Dragged", true)
end,
}
end
local drag
handle.InputBegan:Connect(function(input)
if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
if not MainFrame.Visible then return end
drag = { point = input.Position, pos = target.Position }
target:SetAttribute("Dragged", true)
input.Changed:Connect(function()
if input.UserInputState == Enum.UserInputState.End then drag = nil end
end)
end)
UserInputService.InputChanged:Connect(function(input)
if not drag then return end
if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
local d = input.Position - drag.point
target.Position = UDim2.new(drag.pos.X.Scale, drag.pos.X.Offset + d.X, drag.pos.Y.Scale, drag.pos.Y.Offset + d.Y)
end)
UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then drag = nil end
end)
end
WindowObj._softShadow = function(frame, alpha, spread)
spread = spread or 18
local img = Instance.new("ImageLabel")
img.Name = "SoftShadow"
img.AnchorPoint = Vector2.new(0.5, 0.5)
img.Position = UDim2.new(0.5, 0, 0.5, 2)
img.Size = UDim2.new(1, spread, 1, spread)
img.BackgroundTransparency = 1
img.Image = "rbxassetid://6014261993"
img.ImageColor3 = Color3.new(0, 0, 0)
img.ImageTransparency = alpha or 0.5
img.ScaleType = Enum.ScaleType.Slice
img.SliceCenter = Rect.new(49, 49, 450, 450)
img.SliceScale = spread / 60
img.ZIndex = math.max(1, frame.ZIndex - 1)
img:SetAttribute("ImageAlpha", img.ImageTransparency)
img.Parent = frame
return img
end
WindowObj._edgeShadow = function(host, z)
for i = 1, 5 do
local spread = i
local layer = Instance.new("Frame")
layer.Name = "ShadowLayer" .. i
layer.Position = UDim2.new(0, -spread, 0, 1 - spread)
layer.Size = UDim2.new(1, spread * 2, 1, spread * 2)
layer.BackgroundColor3 = Color3.fromRGB(4, 5, 7)
layer.BackgroundTransparency = 0.88
layer.BorderSizePixel = 0
layer.ZIndex = z
layer:SetAttribute("IsShadowLayer", true)
layer:SetAttribute("ShadowAlpha", 0.88)
local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = layer
layer.Parent = host
end
end
WindowObj._textLogo = function(parent, textSize, z)
local label = Instance.new("TextLabel")
label.Name = "LogoText"
label.Size = UDim2.fromScale(1, 1)
label.BackgroundTransparency = 1
label.Text = ""
label.TextColor3 = Color3.fromRGB(240, 240, 250)
label.TextSize = textSize
label.Font = FONT_BOLD
label.ZIndex = z + 1
label.Parent = parent
local shade = label:Clone()
shade.Name = "LogoShade"
shade.Position = UDim2.fromOffset(-1, 1)
shade.TextColor3 = Color3.fromRGB(150, 164, 255)
shade.ZIndex = z
shade.Parent = label
return label
end
WindowObj._imageFallback = function(img, fallbackText, isAvatar)
if not img then return end
if isAvatar then
task.spawn(function()
local ok, url = pcall(function()
return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)
if ok and type(url) == "string" and img.Parent then img.Image = url end
end)
end
task.delay(6, function()
if not img.Parent or img.IsLoaded then return end
if img:FindFirstChild("ImageFallback") then return end
local label = Instance.new("TextLabel")
label.Name = "ImageFallback"
label.Size = UDim2.fromScale(1, 1)
label.BackgroundTransparency = 1
label.Text = fallbackText
label.TextColor3 = Color3.fromRGB(235, 236, 241)
label.TextScaled = true
label.Font = FONT_BOLD
label.ZIndex = img.ZIndex + 1
local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0.2, 0); pad.PaddingBottom = UDim.new(0.2, 0)
pad.PaddingLeft = UDim.new(0.15, 0); pad.PaddingRight = UDim.new(0.15, 0)
pad.Parent = label
label.Parent = img
local function check()
if img.IsLoaded and label.Parent then label:Destroy() end
end
img:GetPropertyChangedSignal("IsLoaded"):Connect(check)
img:GetPropertyChangedSignal("Image"):Connect(function() task.delay(1, check) end)
check()
end)
end
WindowObj._logoWithFallback = function(parent, textSize, z, corner)
local text = WindowObj._textLogo(parent, textSize, z)
local img = Instance.new("ImageLabel")
img.Name = "HubGlyph"
img.Size = UDim2.fromScale(1, 1)
img.BackgroundTransparency = 1
img.Image = "rbxthumb://type=Asset&id=118608145176297&w=420&h=420"
img.ImageRectOffset = Vector2.new(48, 48)
img.ImageRectSize = Vector2.new(324, 324)
img.ScaleType = Enum.ScaleType.Stretch
img.ZIndex = z + 2
img.Parent = parent
local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, corner or 8); c.Parent = img
local function check()
if img.IsLoaded then text.Visible = false end
end
img:GetPropertyChangedSignal("IsLoaded"):Connect(check)
check()
return img
end
WindowObj._attachBlur = function(frame, inset)
local area = frame
if inset and inset > 0 and not frame:FindFirstChildWhichIsA("UIGridStyleLayout") then
area = Instance.new("Frame")
area.Name = "BlurArea"
area.BackgroundTransparency = 1
area.Position = UDim2.fromOffset(inset, 0)
area.Size = UDim2.new(1, -inset * 2, 1, 0)
area.Parent = frame
end
local ok, blur = pcall(AcrylicLib.new, area)
if not ok or not blur then return end
table.insert(WindowObj._blurs, { frame = frame, blur = blur, group = frame:FindFirstAncestorWhichIsA("CanvasGroup") })
if WindowObj._blurLoop then return end
WindowObj._blurLoop = RunService.RenderStepped:Connect(function()
local list = WindowObj._blurs
for i = #list, 1, -1 do
local e = list[i]
local part = e.blur.Instances.Part
if not e.frame.Parent or not part.Parent then
pcall(e.blur.Destroy)
table.remove(list, i)
elseif e.frame.Visible and e.frame.BackgroundTransparency < 0.98 and IsAncestorVisible(e.frame)
and not (e.group and e.group.GroupTransparency > 0.6) then
pcall(e.blur.Update)
part.Transparency = part:GetAttribute("TargetTransparency") or 0.8
else
part.Transparency = 1
end
end
end)
end
local function GetMainFrameScale()
local scale = MainFrameUIScale and MainFrameUIScale.Scale or 1
if type(scale) ~= "number" or scale ~= scale or scale <= 0 then return 1 end
return scale
end
local function GetVisualScale(object)
local scale = 1
local current = object
while current do
local ok, uiScale = pcall(function()
return current:FindFirstChildOfClass("UIScale")
end)
if (not ok or not uiScale) and current == MainFrame then uiScale = MainFrameUIScale end
if (ok or current == MainFrame) and uiScale and type(uiScale.Scale) == "number" and uiScale.Scale > 0 then
scale = scale * uiScale.Scale
end
if current == MainFrame then break end
current = current.Parent
end
if type(scale) ~= "number" or scale ~= scale or scale <= 0 then return 1, 1 end
scale = math.clamp(scale, 0.01, 100)
return scale, scale
end
local function GetPopupParentOrigin(popup)
local parent = popup and popup.Parent
if parent and parent:IsA("GuiObject") then
return parent.AbsolutePosition.X, parent.AbsolutePosition.Y,
parent.AbsoluteSize.X, parent.AbsoluteSize.Y
end
return 0, 0, 0, 0
end
local function AbsoluteFromPosition(popup)
local baseX, baseY, sizeX, sizeY = GetPopupParentOrigin(popup)
local scaleX, scaleY = GetVisualScale(popup)
local position = popup.Position
return baseX + (position.X.Scale * sizeX + position.X.Offset) * scaleX,
baseY + (position.Y.Scale * sizeY + position.Y.Offset) * scaleY
end
local function MovePopupToAbsolute(popup, x, y)
if not popup or not popup.Parent then return end
if popup.AbsoluteSize.X <= 0 or popup.AbsoluteSize.Y <= 0 then return end
local scaleX, scaleY = GetVisualScale(popup)
local position = popup.Position
local dx = (x - popup.AbsolutePosition.X) / scaleX
local dy = (y - popup.AbsolutePosition.Y) / scaleY
if math.abs(dx) < 0.5 and math.abs(dy) < 0.5 then return end
popup.Position = UDim2.new(position.X.Scale, position.X.Offset + dx, position.Y.Scale, position.Y.Offset + dy)
end
WindowObj._tooltip = function(target, text)
if not target or type(text) ~= "string" or text == "" then return end
target:SetAttribute("Tooltip", text)
if target:GetAttribute("TooltipHooked") then return end
target:SetAttribute("TooltipHooked", true)
local tip = WindowObj._tooltipFrame
if not tip then
tip = New("TextLabel", {
Name = "Tooltip", Size = UDim2.fromOffset(0, 28), AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = Color3.fromRGB(18, 18, 25), BackgroundTransparency = 1, Text = "", TextColor3 = Color3.fromRGB(235, 236, 241),
TextTransparency = 1, TextSize = 13, Font = FONT, Visible = false, ZIndex = 9500,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, tip)
local outline = Stroke(tip)
outline:SetAttribute("Base", outline.Transparency)
New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, tip)
WindowObj._tooltipFrame = tip
WindowObj._tooltipToken = 0
end
local function hide()
WindowObj._tooltipToken = WindowObj._tooltipToken + 1
local token = WindowObj._tooltipToken
Tween(tip, { BackgroundTransparency = 1, TextTransparency = 1 }, 0.1)
task.delay(0.11, function() if token == WindowObj._tooltipToken then tip.Visible = false end end)
end
target.MouseEnter:Connect(function()
WindowObj._tooltipToken = WindowObj._tooltipToken + 1
local token = WindowObj._tooltipToken
task.delay(1.5, function()
if token ~= WindowObj._tooltipToken or not target.Parent or not MainFrame.Visible then return end
tip.Text = target:GetAttribute("Tooltip") or ""
local point = GetPointerPosition()
local inset = WindowObj._topInset or 0
tip.Visible = true
ApplyZIndexLadder(tip, NextPopupZ())
MovePopupToAbsolute(tip, point.X + 14, point.Y - inset + 10)
Tween(tip, { BackgroundTransparency = 0.04, TextTransparency = 0 }, 0.14)
end)
end)
target.MouseLeave:Connect(hide)
target.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 then hide() end
end)
end
local function PopupSafeArea()
local gui = MainFrame and MainFrame.Parent
if gui and gui:IsA("ScreenGui") and gui.AbsoluteSize.X > 0 and gui.AbsoluteSize.Y > 0 then
return gui.AbsolutePosition, gui.AbsoluteSize
end
if MainFrame and MainFrame.AbsoluteSize.X > 0 and MainFrame.AbsoluteSize.Y > 0 then
return MainFrame.AbsolutePosition, MainFrame.AbsoluteSize
end
return Vector2.new(0, 0), Vector2.new(0, 0)
end
local function ConstrainPopupToMainFrame(popup, margin, knownSize)
margin = type(margin) == "number" and math.max(0, margin) or 6
if not popup or not popup.Parent or not popup:IsA("GuiObject") then return end
local size = knownSize or popup.AbsoluteSize
if size.X <= 0 or size.Y <= 0 then return end
local mainPosition, mainSize = PopupSafeArea()
if mainSize.X <= 0 or mainSize.Y <= 0 then return end
local minX = mainPosition.X + margin
local minY = mainPosition.Y + margin
local maxX = mainPosition.X + mainSize.X - size.X - margin
local maxY = mainPosition.Y + mainSize.Y - size.Y - margin
if maxX < minX then minX, maxX = mainPosition.X, mainPosition.X end
local currentX, currentY = AbsoluteFromPosition(popup)
local x = maxX < minX and minX or math.clamp(currentX, minX, maxX)
local y = maxY < minY and minY or math.clamp(currentY, minY, maxY)
MovePopupToAbsolute(popup, x, y)
end
local function FindClippingAncestors(popup)
local ancestors = {}
local current = popup and popup.Parent
while current and current ~= MainFrame do
local ok, clips = pcall(function() return current.ClipsDescendants end)
if ok and clips == true then table.insert(ancestors, current) end
current = current.Parent
end
return ancestors
end
local function ForceLiftClipping(popup)
local current = popup and popup.Parent
while current and current ~= MainFrame do
pcall(function() current.ClipsDescendants = false end)
current = current.Parent
end
end
local function RememberPopupClipping(popup)
if not popup or not popup.Parent or _popupClipRestore[popup] then return end
local ancestors = FindClippingAncestors(popup)
if #ancestors == 0 then return end
local restored = {}
for _, ancestor in ipairs(ancestors) do
local okClip, wasClipping = pcall(function() return ancestor.ClipsDescendants end)
table.insert(restored, { frame = ancestor, clipping = okClip and wasClipping == true })
_popupClipCounts[ancestor] = (_popupClipCounts[ancestor] or 0) + 1
ancestor.ClipsDescendants = false
end
_popupClipRestore[popup] = restored
end
RestorePopupClipping = function(popup)
local ancestors = popup and _popupClipRestore[popup]
if not ancestors then return end
_popupClipRestore[popup] = nil
for _, entry in ipairs(ancestors) do
local ancestor = entry.frame
local count = (_popupClipCounts[ancestor] or 1) - 1
if count > 0 then
_popupClipCounts[ancestor] = count
else
_popupClipCounts[ancestor] = nil
if ancestor.Parent then ancestor.ClipsDescendants = entry.clipping == true end
end
end
end
local function positionPopupNow(popup, preferBelow, margin, anchorOverride, knownSize)
if not popup or not popup.Parent then return end
local parent = popup.Parent
local anchor = anchorOverride or (parent and (parent:FindFirstChild("TopBar") or parent:FindFirstChild("OpenBtn") or parent:FindFirstChild("ScaleOpenBtn") or parent:FindFirstChild("LangOpenBtn")))
local parentPosition = (anchor or parent).AbsolutePosition
local parentSize = (anchor or parent).AbsoluteSize
local mainPosition, mainSize = PopupSafeArea()
if mainSize.X <= 0 or mainSize.Y <= 0 or parentSize.X <= 0 or parentSize.Y <= 0 then return end
local popupSize = knownSize or popup.AbsoluteSize
if popupSize.X <= 0 or popupSize.Y <= 0 then return end
local edge = type(margin) == "number" and math.max(0, margin) or 6
local minX = mainPosition.X + edge
local minY = mainPosition.Y + edge
local maxX = mainPosition.X + mainSize.X - popupSize.X - edge
local maxY = mainPosition.Y + mainSize.Y - popupSize.Y - edge
if maxX < minX then minX, maxX = mainPosition.X, mainPosition.X end
local y = preferBelow and parentPosition.Y + parentSize.Y + edge or parentPosition.Y - popupSize.Y - edge
if preferBelow and y > maxY then
local flipped = parentPosition.Y - popupSize.Y - edge
if flipped >= minY then y = flipped end
elseif not preferBelow and y < minY then
local flipped = parentPosition.Y + parentSize.Y + edge
if flipped <= maxY then y = flipped end
end
local currentX = select(1, AbsoluteFromPosition(popup))
local x = maxX < minX and minX or math.clamp(anchor and anchor.AbsolutePosition.X or currentX, minX, maxX)
if maxY < minY then y = minY end
MovePopupToAbsolute(popup, x, math.clamp(y, minY, math.max(minY, maxY)))
end
RepositionOpenPopups = function()
local copy = {}
for i, entry in ipairs(_openPopups) do copy[i] = entry end
for _, entry in ipairs(copy) do
local frame = entry.frame
if frame and frame.Parent and frame.Visible then
ConstrainPopupToMainFrame(frame, 6)
end
end
end
local function PositionPopupWithinMain(popup, preferBelow, margin, anchorOverride, knownSize)
if not popup or not popup.Parent then return end
RememberPopupClipping(popup)
local wasVisible = popup.Visible
local savedTransparency = popup.BackgroundTransparency
if not wasVisible then
popup.Visible = true
popup.BackgroundTransparency = 1
end
positionPopupNow(popup, preferBelow, margin, anchorOverride, knownSize)
ConstrainPopupToMainFrame(popup, margin, knownSize)
if not wasVisible then
popup.BackgroundTransparency = savedTransparency
popup.Visible = false
task.defer(function()
if popup.Parent and popup.Visible then
PositionPopupWithinMain(popup, preferBelow, margin, anchorOverride)
end
end)
end
end
WindowObj._drawTabGlyph = function(kind, icon)
kind = string.lower(tostring(kind or ""))
local isRage = kind == "crosshair" or kind == "rage" or kind == "aimbot"
local isMouse = kind == "mouse" or kind == "legit"
local isUser = kind == "user" or kind == "player" or kind == "players"
local isGlobe = false
local isMisc = kind == "gear" or kind == "misc" or kind == "miscellaneous" or kind == "settings"
if not (isRage or isMouse or isUser or isGlobe or isMisc) then return false end
local CUT = Color3.fromRGB(16, 16, 16)
local grid = Instance.new("Frame")
grid.Name = "GlyphGrid"
grid.AnchorPoint = Vector2.new(0.5, 0.5)
grid.Position = UDim2.fromScale(0.5, 0.5)
grid.Size = UDim2.fromOffset(18, 18)
grid.BackgroundTransparency = 1
grid.ZIndex = icon.ZIndex + 1
grid.Parent = icon
local fit = Instance.new("UIScale")
fit.Parent = grid
local function refit()
local gw, iw = grid.AbsoluteSize.X, icon.AbsoluteSize.X
if gw > 0 and iw > 0 then fit.Scale = fit.Scale * iw / gw end
end
icon:GetPropertyChangedSignal("AbsoluteSize"):Connect(refit)
task.defer(refit)
local fills, rings = {}, {}
local function part(parent, x, y, w, h, radius, isCut)
local f = Instance.new("Frame")
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(w, h)
f.BorderSizePixel = 0
f.BackgroundColor3 = isCut and CUT or icon.ImageColor3
f.ZIndex = icon.ZIndex + (isCut and 3 or 2)
f.Parent = parent
if radius then local c = Instance.new("UICorner"); c.CornerRadius = radius; c.Parent = f end
if not isCut then table.insert(fills, f) end
return f
end
local ROUND = UDim.new(1, 0)
if isRage then
local ring = Instance.new("Frame")
ring.Position = UDim2.fromOffset(3, 3)
ring.Size = UDim2.fromOffset(12, 12)
ring.BackgroundTransparency = 1
ring.ZIndex = icon.ZIndex + 2
ring.Parent = grid
local rc = Instance.new("UICorner"); rc.CornerRadius = ROUND; rc.Parent = ring
local stroke = Instance.new("UIStroke"); stroke.Thickness = 2; stroke.Color = icon.ImageColor3; stroke.Parent = ring
table.insert(rings, stroke)
part(grid, 8, 0, 2, 5)
part(grid, 8, 13, 2, 5)
part(grid, 0, 8, 5, 2)
part(grid, 13, 8, 5, 2)
part(grid, 8, 8, 2, 2)
elseif isMouse then
local body = part(grid, 4, 1, 11, 16, UDim.new(0.5, 0))
part(body, 0, 6, 11, 1, nil, true)
part(body, 5, 0, 1, 6, nil, true)
elseif isUser then
part(grid, 5, 1, 8, 8, ROUND)
part(grid, 2, 10, 14, 7, UDim.new(0, 5))
elseif isGlobe then
local globe = part(grid, 1, 1, 16, 16, ROUND)
part(globe, 3, 3, 5, 4, ROUND, true)
part(globe, 8, 10, 6, 3, ROUND, true)
part(globe, 10, 3, 3, 3, ROUND, true)
elseif isMisc then
local plate = part(grid, 2, 2, 14, 14, UDim.new(0, 4))
part(plate, 3, 4, 8, 2, nil, true)
part(plate, 3, 8, 8, 2, nil, true)
part(plate, 8, 3, 4, 4, ROUND, true)
part(plate, 2, 7, 4, 4, ROUND, true)
end
icon.Image = ""
local function sync()
for _, f in ipairs(fills) do
f.BackgroundColor3 = icon.ImageColor3
f.BackgroundTransparency = icon.ImageTransparency
end
for _, r in ipairs(rings) do
r.Color = icon.ImageColor3
r.Transparency = icon.ImageTransparency
end
end
icon:GetPropertyChangedSignal("ImageColor3"):Connect(sync)
icon:GetPropertyChangedSignal("ImageTransparency"):Connect(sync)
sync()
return true
end
WindowObj._drawGlyph = function(kind, host, color)
local function bar(x, y, w, h, rot)
local f = Instance.new("Frame")
f.AnchorPoint = Vector2.new(0.5, 0.5)
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(w, h)
f.Rotation = rot or 0
f.BackgroundColor3 = color
f.BorderSizePixel = 0
f.ZIndex = host.ZIndex + 1
f.Parent = host
return f
end
local function box(x, y, w, h)
local f = Instance.new("Frame")
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(w, h)
f.BackgroundTransparency = 1
f.ZIndex = host.ZIndex + 1
f.Parent = host
local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 2); c.Parent = f
local o = Instance.new("UIStroke"); o.Color = color; o.Thickness = 1.4; o.Parent = f
return f
end
local function pix(x, y, w, h)
local f = Instance.new("Frame")
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(w, h)
f.BackgroundColor3 = color
f.BorderSizePixel = 0
f.ZIndex = host.ZIndex + 1
f.Parent = host
return f
end
local function image(asset)
local img = Instance.new("ImageLabel")
img.Size = UDim2.fromScale(1, 1)
img.BackgroundTransparency = 1
img.Image = asset
img.ImageColor3 = color
img.ScaleType = Enum.ScaleType.Fit
img.ZIndex = host.ZIndex + 1
img.Parent = host
return img
end
if kind == "share" then
pix(1, 5, 2, 8); pix(1, 12, 8, 2); pix(7, 9, 2, 5); pix(1, 5, 4, 2)
pix(8, 1, 5, 2); pix(11, 1, 2, 5)
pix(9, 3, 2, 2); pix(7, 5, 2, 2); pix(5, 7, 2, 2)
elseif kind == "copy" then
box(1, 4, 8, 9)
box(5, 1, 8, 9)
elseif kind == "trash" then
image("rbxassetid://116396312853810")
elseif kind == "restore" then
image("rbxassetid://106497040962250")
end
end
WindowObj._centerPopupOnField = function(popup, field)
if not popup or not popup.Parent or not field or not field.Parent then return end
if WindowObj._styleListPopup then WindowObj._styleListPopup(popup) end
RememberPopupClipping(popup)
ForceLiftClipping(popup)
local size = popup.AbsoluteSize
local fieldPos, fieldSize = field.AbsolutePosition, field.AbsoluteSize
if size.X <= 0 or size.Y <= 0 or fieldSize.X <= 0 then return end
local x = fieldPos.X + (fieldSize.X - size.X) / 2
local y = fieldPos.Y + (fieldSize.Y - size.Y) / 2
MovePopupToAbsolute(popup, x, y)
ConstrainPopupToMainFrame(popup, 6)
end
AcrylicBlur.CreateColorPicker = function(anchorButton, initialColor, onChange)
local currentColor = NormalizeColor(initialColor)
local hue, saturation, value = Color3.toHSV(currentColor)
local dragPart = nil
local isOpen = false
local frame = New("Frame", {
Name = "ColorPickerFrame",
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromOffset(212, 246),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BackgroundTransparency = 0.02,
BorderSizePixel = 0,
Visible = false,
ClipsDescendants = false,
ZIndex = Z_BASE + 800,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, frame)
Stroke(frame, "ColorPickerOutline")
New("UIPadding", {
PaddingLeft = UDim.new(0, 10),
PaddingRight = UDim.new(0, 10),
PaddingTop = UDim.new(0, 10),
PaddingBottom = UDim.new(0, 10),
}, frame)
New("UIListLayout", {
FillDirection = Enum.FillDirection.Vertical,
Padding = UDim.new(0, 10),
SortOrder = Enum.SortOrder.LayoutOrder,
}, frame)
local svSquare = New("ImageButton", {
Name = "SVSquare",
Size = UDim2.fromOffset(192, 136),
BackgroundColor3 = Color3.fromHSV(hue, 1, 1),
BorderSizePixel = 0,
AutoButtonColor = false,
Image = "",
ClipsDescendants = true,
LayoutOrder = 1,
ZIndex = Z_BASE + 801,
}, frame)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, svSquare)
local svWhite = New("Frame", {
Name = "SVWhite",
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = Z_BASE + 802,
}, svSquare)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, svWhite)
New("UIGradient", {
Rotation = 0,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0),
NumberSequenceKeypoint.new(1, 1),
}),
}, svWhite)
local svBlack = New("Frame", {
Name = "SVBlack",
Size = UDim2.new(1, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
BorderSizePixel = 0,
ZIndex = Z_BASE + 803,
}, svSquare)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, svBlack)
New("UIGradient", {
Rotation = 90,
Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(1, 0),
}),
}, svBlack)
local svShadow = New("Frame", {
Name = "SVCursorShadow",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(saturation, 0, 1 - value, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundColor3 = Color3.fromRGB(10, 12, 18),
BackgroundTransparency = 0,
BorderSizePixel = 0,
ZIndex = Z_BASE + 804,
}, svSquare)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, svShadow)
local svRing = New("Frame", {
Name = "SVCursorRing",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(saturation, 0, 1 - value, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = Z_BASE + 805,
}, svSquare)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, svRing)
local svCursor = New("Frame", {
Name = "SVCursor",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(saturation, 0, 1 - value, 0),
Size = UDim2.fromOffset(8, 8),
BackgroundColor3 = currentColor,
BorderSizePixel = 0,
ZIndex = Z_BASE + 806,
}, svSquare)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, svCursor)
local hueBar = New("ImageButton", {
Name = "HueBar",
Size = UDim2.fromOffset(192, 10),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
AutoButtonColor = false,
Image = "",
ClipsDescendants = false,
Active = true,
LayoutOrder = 2,
ZIndex = Z_BASE + 801,
}, frame)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, hueBar)
New("UIGradient", {
Name = "HueSpectrum",
Rotation = 0,
Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
}),
}, hueBar)
local hueThumb = New("Frame", {
Name = "HueThumb",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(hue, 0, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BorderSizePixel = 0,
ZIndex = Z_BASE + 805,
}, hueBar)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, hueThumb)
local hueThumbInner = New("Frame", {
Name = "HueThumbInner",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = Z_BASE + 806,
}, hueThumb)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, hueThumbInner)
local hexRow = New("Frame", {
Name = "HexRow",
Size = UDim2.fromOffset(192, 28),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = 3,
ZIndex = Z_BASE + 801,
}, frame)
local hexField = New("Frame", {
Name = "HexField",
Position = UDim2.fromOffset(0, 0),
Size = UDim2.fromOffset(156, 28),
BackgroundColor3 = Color3.fromRGB(28, 31, 45),
BorderSizePixel = 0,
ZIndex = Z_BASE + 802,
}, hexRow)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, hexField)
local hexPreview = New("Frame", {
Name = "HexPreview",
Position = UDim2.fromOffset(8, 7),
Size = UDim2.fromOffset(14, 14),
BackgroundColor3 = currentColor,
BorderSizePixel = 0,
ZIndex = Z_BASE + 803,
}, hexField)
New("UICorner", { CornerRadius = UDim.new(0, 4) }, hexPreview)
local hexLabel = New("TextLabel", {
Name = "HexValue",
Position = UDim2.fromOffset(30, 0),
Size = UDim2.fromOffset(118, 28),
BackgroundTransparency = 1,
Text = ColorToHex(currentColor),
TextColor3 = Color3.fromRGB(230, 230, 230),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = Z_BASE + 803,
}, hexField)
local copyButton = New("ImageButton", {
Name = "CopyHex",
Position = UDim2.fromOffset(164, 0),
Size = UDim2.fromOffset(28, 28),
BackgroundColor3 = Color3.fromRGB(28, 31, 45),
BorderSizePixel = 0,
AutoButtonColor = false,
Image = "",
ZIndex = Z_BASE + 802,
}, hexRow)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, copyButton)
local copyBack = New("Frame", {
Name = "CopyIconBack",
Position = UDim2.fromOffset(7, 6),
Size = UDim2.fromOffset(9, 11),
BackgroundTransparency = 1,
BorderSizePixel = 1,
BorderColor3 = Color3.fromRGB(230, 230, 230),
ZIndex = Z_BASE + 803,
}, copyButton)
New("UICorner", { CornerRadius = UDim.new(0, 2) }, copyBack)
local copyFront = New("Frame", {
Name = "CopyIconFront",
Position = UDim2.fromOffset(11, 10),
Size = UDim2.fromOffset(9, 11),
BackgroundColor3 = Color3.fromRGB(28, 31, 45),
BorderSizePixel = 1,
BorderColor3 = Color3.fromRGB(230, 230, 230),
ZIndex = Z_BASE + 804,
}, copyButton)
New("UICorner", { CornerRadius = UDim.new(0, 2) }, copyFront)
for _, part in ipairs({ copyBack, copyFront }) do
part.BorderSizePixel = 0
local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(230, 230, 230)
outline.Thickness = 1
outline.Parent = part
end
for _, field in ipairs({ hexField, copyButton }) do
field.BackgroundColor3 = Color3.fromRGB(27, 28, 38)
local outline = Instance.new("UIStroke")
outline.Color = Color3.fromRGB(255, 255, 255)
outline.Transparency = 0.93
outline.Thickness = 1
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outline.Parent = field
end
Library._recentColors = Library._recentColors or {}
local swatchRow = New("Frame", {
Name = "RecentSwatches",
Size = UDim2.fromOffset(192, 22),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = 4,
ZIndex = Z_BASE + 801,
}, frame)
New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, swatchRow)
local swatchButtons = {}
for i = 1, 7 do
local swatch = New("TextButton", {
Name = "Swatch" .. i,
Size = UDim2.fromOffset(22, 22),
BackgroundColor3 = Color3.fromRGB(27, 28, 38),
BorderSizePixel = 0,
AutoButtonColor = false,
Text = "",
LayoutOrder = i,
ZIndex = Z_BASE + 802,
}, swatchRow)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, swatch)
swatchButtons[i] = swatch
end
local function refreshDisplay(notify)
currentColor = Color3.fromHSV(hue, saturation, value)
svSquare.BackgroundColor3 = Color3.fromHSV(hue, 1, 1)
svShadow.Position = UDim2.new(saturation, 0, 1 - value, 0)
svRing.Position = UDim2.new(saturation, 0, 1 - value, 0)
svCursor.Position = UDim2.new(saturation, 0, 1 - value, 0)
svCursor.BackgroundColor3 = currentColor
hueThumb.Position = UDim2.new(hue, 0, 0.5, 0)
hexPreview.BackgroundColor3 = currentColor
hexLabel.Text = ColorToHex(currentColor)
if anchorButton and anchorButton.Parent then anchorButton.BackgroundColor3 = currentColor end
if notify then InvokeCallback(onChange, currentColor) end
end
local function setColor(color)
currentColor = NormalizeColor(color)
hue, saturation, value = Color3.toHSV(currentColor)
refreshDisplay(false)
end
local function refreshSwatches()
for i, swatch in ipairs(swatchButtons) do
local color = Library._recentColors[i]
swatch.BackgroundColor3 = color or Color3.fromRGB(27, 28, 38)
swatch.Active = color ~= nil
end
end
local function pushRecent(color)
local list = Library._recentColors
for i = #list, 1, -1 do
if ColorToHex(list[i]) == ColorToHex(color) then table.remove(list, i) end
end
table.insert(list, 1, color)
while #list > #swatchButtons do table.remove(list) end
refreshSwatches()
end
for i, swatch in ipairs(swatchButtons) do
swatch.MouseButton1Click:Connect(function()
local color = Library._recentColors[i]
if not color then return end
setColor(color)
InvokeCallback(onChange, currentColor)
end)
end
local function updateSV(input)
local point = GetInputPosition(input)
local pos = svSquare.AbsolutePosition
local size = svSquare.AbsoluteSize
if size.X <= 0 or size.Y <= 0 then return end
saturation = math.clamp((point.X - pos.X) / size.X, 0, 1)
value = 1 - math.clamp((point.Y - pos.Y) / size.Y, 0, 1)
refreshDisplay(true)
end
local function updateHue(input)
local point = GetInputPosition(input)
local pos = hueBar.AbsolutePosition
local size = hueBar.AbsoluteSize
if size.X <= 0 then return end
hue = math.clamp((point.X - pos.X) / size.X, 0, 1)
refreshDisplay(true)
end
local function positionFrame()
if not frame.Parent or not anchorButton or not anchorButton.Parent then return end
local safePos, safeSize = PopupSafeArea()
if safeSize.X <= 0 or safeSize.Y <= 0 then return end
local anchorPos, anchorSize = anchorButton.AbsolutePosition, anchorButton.AbsoluteSize
local popupW = frame.AbsoluteSize.X > 0 and frame.AbsoluteSize.X or 212
local popupH = frame.AbsoluteSize.Y > 0 and frame.AbsoluteSize.Y or 246
local x = anchorPos.X + anchorSize.X - popupW
local y = anchorPos.Y + anchorSize.Y + 6
if y + popupH > safePos.Y + safeSize.Y - 6 then y = anchorPos.Y - popupH - 6 end
x = math.clamp(x, safePos.X + 6, math.max(safePos.X + 6, safePos.X + safeSize.X - popupW - 6))
y = math.clamp(y, safePos.Y + 6, math.max(safePos.Y + 6, safePos.Y + safeSize.Y - popupH - 6))
MovePopupToAbsolute(frame, x, y)
end
local function closePicker()
if not isOpen and not frame.Visible then return end
isOpen = false
UnregisterPopup(frame)
SmoothClose(frame, 0.12)
end
local function openPicker()
if isOpen then return end
CloseAllPopupsExcept(frame)
isOpen = true
frame.Visible = true
ApplyZIndexLadder(frame, NextPopupZ())
positionFrame()
refreshSwatches()
SmoothOpen(frame, 0.02, 0.16)
task.defer(function()
if frame.Visible and isOpen then positionFrame() end
end)
RegisterPopup(frame, closePicker, anchorButton)
end
local picker = { frame = frame }
function picker.Set(color) setColor(color) end
function picker.Get() return currentColor end
function picker.Close() closePicker() end
function picker.Toggle()
if isOpen then closePicker() else openPicker() end
end
anchorButton.MouseButton1Click:Connect(function() picker.Toggle() end)
svSquare.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then dragPart = "sv"; updateSV(input) end
end)
hueBar.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then dragPart = "hue"; updateHue(input) end
end)
UserInputService.InputChanged:Connect(function(input)
if not dragPart then return end
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
if dragPart == "sv" then updateSV(input) else updateHue(input) end
end
end)
UserInputService.InputEnded:Connect(function(input)
if dragPart and IsPrimaryInput(input) then
dragPart = nil
pushRecent(currentColor)
end
end)
copyButton.MouseButton1Click:Connect(function()
if setclipboard then setclipboard(hexLabel.Text) end
end)
setColor(currentColor)
return picker
end
local Stats = game:GetService('Stats')
local FPSText, MSText, TimeText, RamText, SignalImage
local ACCENT = mainColor or Color3.fromRGB(78, 139, 255)
local GOOD = Color3.fromRGB(120, 220, 140)
local WARN = Color3.fromRGB(240, 180, 80)
local BAD = Color3.fromRGB(233, 90, 130)
do
local GameInfo = Instance.new('Frame')
GameInfo.Name = "GameInfo"
GameInfo.AnchorPoint = Vector2.new(1, 0)
GameInfo.Position = UDim2.new(1, -6, 0, 2)
GameInfo.Size = UDim2.fromOffset(0, 35)
GameInfo.AutomaticSize = Enum.AutomaticSize.None
GameInfo.BackgroundColor3 = Color3.fromRGB(8, 9, 12)
GameInfo.BackgroundTransparency = 0.3
GameInfo.BorderSizePixel = 0
GameInfo.Active = true
GameInfo.Draggable = false
GameInfo.ClipsDescendants = false
GameInfo.Parent = NightUICS2
GameInfo.ZIndex = Z_BASE + 900
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = GameInfo end
if WindowObj._attachBlur then WindowObj._attachBlur(GameInfo) end
do local pd = Instance.new("UIPadding"); pd.PaddingLeft = UDim.new(0, 14); pd.PaddingRight = UDim.new(0, 5); pd.PaddingTop = UDim.new(0, 0); pd.PaddingBottom = UDim.new(0, 0); pd.Parent = GameInfo end
local ICON_LAYERS   = "rbxassetid://114499998778667"
local ICON_WIFI     = "rbxassetid://104941258142372"
local ICON_RAM      = "rbxassetid://82464660673318"
local ICON_CLOCK    = "rbxassetid://136533241128438"
local ICON_EYE      = "rbxassetid://127234874352422"
local ICON_KEYBOARD = "rbxassetid://121978468376124"
local function WMCell(name, order, iconAsset, text, iconSize, iconCorner)
local cell = Instance.new("Frame")
cell.Name = name .. "Cell"
cell.LayoutOrder = order
cell.Size = UDim2.fromOffset(0, 35)
cell.AutomaticSize = Enum.AutomaticSize.X
cell.BackgroundTransparency = 1
cell.BorderSizePixel = 0
cell.ZIndex = Z_BASE + 901
cell.Parent = GameInfo
do local ly = Instance.new("UIListLayout"); ly.FillDirection = Enum.FillDirection.Horizontal; ly.VerticalAlignment = Enum.VerticalAlignment.Center; ly.Padding = UDim.new(0, 7); ly.SortOrder = Enum.SortOrder.LayoutOrder; ly.Parent = cell end
do local pd = Instance.new("UIPadding"); pd.PaddingLeft = UDim.new(0, 7); pd.PaddingRight = UDim.new(0, 7); pd.Parent = cell end
local icon
if iconAsset then
icon = Instance.new("ImageLabel")
icon.Name = name .. "Icon"
icon.LayoutOrder = 1
icon.Size = UDim2.fromOffset(iconSize or 15, iconSize or 15)
icon.BackgroundTransparency = 1
icon.BorderSizePixel = 0
icon.Image = iconAsset
icon.ImageColor3 = ACCENT
icon.ImageTransparency = 0
icon.ScaleType = Enum.ScaleType.Fit
icon.ZIndex = Z_BASE + 901
icon.Parent = cell
if iconCorner then do local c = Instance.new("UICorner"); c.CornerRadius = iconCorner; c.Parent = icon end end
end
local label = Instance.new("TextLabel")
label.Name = name
label.LayoutOrder = 2
label.Size = UDim2.fromOffset(0, 35)
label.AutomaticSize = Enum.AutomaticSize.X
label.BackgroundTransparency = 1
label.BorderSizePixel = 0
label.Text = text
label.TextColor3 = Color3.fromRGB(180, 182, 188)
label.TextTransparency = 0
label.TextScaled = false
label.TextSize = 15
label.Font = FONT
label.TextXAlignment = Enum.TextXAlignment.Left
label.TextYAlignment = Enum.TextYAlignment.Center
label.ZIndex = Z_BASE + 901
label.Parent = cell
return cell, icon, label
end
local function WMDivider()
local d = Instance.new("Frame")
d.Name = "Divider"
d.Size = UDim2.fromOffset(1, 14)
d.BackgroundColor3 = Color3.fromRGB(120, 126, 150)
d.BackgroundTransparency = 0.58
d.BorderSizePixel = 0
d.Visible = false
d.ZIndex = Z_BASE + 901
d.Parent = GameInfo
return d
end
local BrandCell = Instance.new("Frame")
BrandCell.Name = "BrandCell"
BrandCell.LayoutOrder = 2
BrandCell.Size = UDim2.fromOffset(0, 35)
BrandCell.AutomaticSize = Enum.AutomaticSize.X
BrandCell.BackgroundTransparency = 1
BrandCell.BorderSizePixel = 0
BrandCell.ZIndex = Z_BASE + 901
BrandCell.Parent = GameInfo
do local ly = Instance.new("UIListLayout"); ly.FillDirection = Enum.FillDirection.Horizontal; ly.VerticalAlignment = Enum.VerticalAlignment.Center; ly.Padding = UDim.new(0, 8); ly.SortOrder = Enum.SortOrder.LayoutOrder; ly.Parent = BrandCell end
do local pd = Instance.new("UIPadding"); pd.PaddingLeft = UDim.new(0, 0); pd.PaddingRight = UDim.new(0, 7); pd.Parent = BrandCell end
local NeverIcon = Instance.new("ImageLabel")
NeverIcon.Name = "NeverIcon"
NeverIcon.LayoutOrder = 1
NeverIcon.Size = UDim2.fromOffset(16, 16)
NeverIcon.BackgroundTransparency = 1
NeverIcon.BorderSizePixel = 0
NeverIcon.Image = ""
NeverIcon.ImageColor3 = Color3.new(1, 1, 1)
NeverIcon.ScaleType = Enum.ScaleType.Fit
NeverIcon.ZIndex = Z_BASE + 901
NeverIcon.Parent = BrandCell
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 5); c.Parent = NeverIcon end
NeverIcon.Visible = false
do
local brandText = Instance.new("TextLabel")
brandText.Name = "BrandText"
brandText.LayoutOrder = 2
brandText.Size = UDim2.fromOffset(0, 35)
brandText.AutomaticSize = Enum.AutomaticSize.X
brandText.BackgroundTransparency = 1
brandText.BorderSizePixel = 0
brandText.Text = ""
brandText.TextColor3 = Color3.fromRGB(240, 240, 250)
brandText.TextSize = 18
brandText.Font = FONT_BOLD
brandText.ZIndex = Z_BASE + 901
brandText.Parent = BrandCell
do local pd = Instance.new("UIPadding"); pd.PaddingBottom = UDim.new(0, 2); pd.Parent = brandText end
brandText.ZIndex = Z_BASE + 903
local brandShade = brandText:Clone()
brandShade.Name = "BrandShade"
brandShade.Position = UDim2.fromOffset(-1, 1)
brandShade.Size = UDim2.fromScale(1, 1)
brandShade.AutomaticSize = Enum.AutomaticSize.None
brandShade.TextColor3 = Color3.fromRGB(150, 164, 255)
brandShade.ZIndex = brandText.ZIndex - 1
brandShade.Parent = brandText
end
local UserCell = WMCell("Username", 4, nil, LocalPlayer.DisplayName or "Player")
local UserIcon = Instance.new("ImageLabel")
UserIcon.Name = "UserIcon"
UserIcon.LayoutOrder = 1
UserIcon.Size = UDim2.fromOffset(24, 24)
UserIcon.BackgroundTransparency = 1
UserIcon.BorderSizePixel = 0
UserIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId or 0) .. "&w=150&h=150"
UserIcon.ZIndex = Z_BASE + 901
UserIcon.Parent = UserCell
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = UserIcon end
WindowObj._imageFallback(UserIcon, string.upper(string.sub(tostring(LocalPlayer.Name or "?"), 1, 1)), true)
local Username = UserCell:FindFirstChild("Username")
Username.Visible = false
do local pd = UserCell:FindFirstChildOfClass("UIPadding"); if pd then pd.PaddingRight = UDim.new(0, 0) end end
local FpsCell, FpsCellIcon
FpsCell, FpsCellIcon, FPSText = WMCell("FPS", 6, ICON_LAYERS, "0 FPS")
local PingCell
PingCell, SignalImage, MSText = WMCell("Ping", 8, ICON_WIFI, "VAR ±0 MS")
local RamCell, RamCellIcon
RamCell, RamCellIcon, RamText = WMCell("RAM", 10, ICON_RAM, "0 MB")
local TimeCell, TimeCellIcon
TimeCell, TimeCellIcon, TimeText = WMCell("Time", 12, ICON_CLOCK, os.date("%H:%M"))
do
local cell, icon, text = WMCell("Speed", 5, ICON_LAYERS, "0 SPEED")
WindowObj._wmSpeed = { cell = cell, icon = icon }
WindowObj._wmSpeedText = text
end
WindowObj._wmGlyph = function(icon, kind)
if not icon then return end
icon.Image = ""
local fills, rings = {}, {}
local function part(x, y, w, h, round)
local f = Instance.new("Frame")
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(w, h)
f.BorderSizePixel = 0
f.ZIndex = icon.ZIndex + 1
f.Parent = icon
if round then local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = f end
table.insert(fills, f)
return f
end
local function ring(x, y, size, thickness)
local f = Instance.new("Frame")
f.Position = UDim2.fromOffset(x, y)
f.Size = UDim2.fromOffset(size, size)
f.BackgroundTransparency = 1
f.ZIndex = icon.ZIndex + 1
f.Parent = icon
local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(1, 0); c.Parent = f
local st = Instance.new("UIStroke"); st.Thickness = thickness; st.Parent = f
table.insert(rings, st)
end
if kind == "speed" then
ring(1, 1, 13, 1.8)
part(6, 6, 3, 3, true)
elseif kind == "ping" then
for k = 0, 5 do part(1 + k * 2, 11 - k * 2, 2, 3 + k * 2) end
elseif kind == "time" then
ring(1, 1, 13, 1.6)
part(7, 4, 1, 4); part(7, 7, 4, 1)
end
icon.ImageTransparency = 0.18
local function sync()
for _, f in ipairs(fills) do
f.BackgroundColor3 = icon.ImageColor3
f.BackgroundTransparency = icon.ImageTransparency
end
for _, r in ipairs(rings) do
r.Color = icon.ImageColor3
r.Transparency = icon.ImageTransparency
end
end
icon:GetPropertyChangedSignal("ImageColor3"):Connect(sync)
icon:GetPropertyChangedSignal("ImageTransparency"):Connect(sync)
sync()
end
WindowObj._wmSpeed.icon.Image = "rbxassetid://10723395708"
SignalImage.Image = "rbxassetid://10734949856"
TimeCellIcon.Image = "rbxassetid://10709805144"
for _, icon in ipairs({ WindowObj._wmSpeed.icon, TimeCellIcon }) do icon.ImageTransparency = 0.12 end
do
local cell, icon, text = WMCell("Name", 3, "rbxassetid://10747373176", LocalPlayer.DisplayName or "Player")
icon.ImageColor3 = Color3.fromRGB(150, 164, 255)
WindowObj._wmName = { cell = cell, icon = icon, text = text }
end
SignalImage.ImageColor3 = Color3.fromRGB(225, 165, 135)
MSText.TextColor3 = Color3.fromRGB(225, 165, 135)
local WMCells = { brand = BrandCell, name = WindowObj._wmName.cell, user = UserCell, speed = WindowObj._wmSpeed.cell, fps = FpsCell, ping = PingCell, ram = RamCell, time = TimeCell }
local WMDefaultOrder = { "brand", "name", "ping", "speed", "time", "fps", "user", "ram" }
local WMShowMap = { logo = true, name = true, user = true, speed = false, fps = false, ping = true, ram = false, time = false }
local WMDividers = {}
for key in pairs(WMCells) do WMDividers[key] = WMDivider() end
local WMShadowSync
local WMLastOrder
local function ApplyWatermarkLayout(orderList, showMap)
if type(orderList) == "table" and #orderList > 0 then WMLastOrder = orderList else orderList = WMLastOrder end
if type(showMap) == "table" then
for key in pairs(WMShowMap) do
if showMap[key] ~= nil then WMShowMap[key] = showMap[key] == true end
end
end
local function normalize(k) return k == "logo" and "brand" or k end
local order, seen = {}, {}
local source = (type(orderList) == "table" and #orderList > 0) and orderList or WMDefaultOrder
for _, raw in ipairs(source) do
local key = normalize(raw)
if WMCells[key] and not seen[key] then
seen[key] = true
table.insert(order, key)
end
end
for _, key in ipairs(WMDefaultOrder) do
if not seen[key] then table.insert(order, key) end
end
local shown = {}
for i, key in ipairs(order) do
local cell = WMCells[key]
local hidden = WMShowMap[key] == false or (key == "brand" and WMShowMap.logo == false)
cell.Visible = not hidden
cell.LayoutOrder = i * 2
if not hidden then table.insert(shown, { key = key, index = i }) end
end
for _, divider in pairs(WMDividers) do divider.Visible = false end
GameInfo.Visible = #shown > 0 and not WindowObj._loaderActive
if WindowObj._wmRelayout then WindowObj._wmRelayout() end
if WMShadowSync then WMShadowSync() end
end
ApplyWatermarkLayout(nil, nil)
do
local WMShadowHost = Instance.new("Frame")
WMShadowHost.Name = "WMShadow"
WMShadowHost.AnchorPoint = Vector2.new(1, 0)
WMShadowHost.Position = UDim2.new(1, -6, 0, 2)
WMShadowHost.Size = UDim2.fromOffset(10, 36)
WMShadowHost.BackgroundTransparency = 1
WMShadowHost.BorderSizePixel = 0
WMShadowHost.ZIndex = Z_BASE + 899
WMShadowHost.Parent = NightUICS2
local layers = {}
WindowObj._edgeShadow(WMShadowHost, Z_BASE + 898)
WMShadowSync = function()
local w, h = GameInfo.AbsoluteSize.X, GameInfo.AbsoluteSize.Y
WMShadowHost.AnchorPoint = GameInfo.AnchorPoint
WMShadowHost.Position = GameInfo.Position
WMShadowHost.Visible = GameInfo.Visible and w > 0 and h > 0
if not WMShadowHost.Visible then return end
WMShadowHost.Size = UDim2.fromOffset(w, h)
for i, layer in ipairs(layers) do
local s = i * 0.65
layer.Position = UDim2.new(0, -s, 0, 1 - s)
layer.Size = UDim2.new(1, s * 2, 1, s * 2 + 2)
end
end
GameInfo:GetPropertyChangedSignal("AbsoluteSize"):Connect(WMShadowSync)
GameInfo:GetPropertyChangedSignal("Visible"):Connect(WMShadowSync)
GameInfo:GetPropertyChangedSignal("Position"):Connect(WMShadowSync)
GameInfo:GetPropertyChangedSignal("AnchorPoint"):Connect(WMShadowSync)
task.defer(WMShadowSync)
end
WindowObj._buildWatermarkUI = function()
local ICON = {
logo = "rbxassetid://10723407092", kd = "rbxassetid://10709818534", speed = "rbxassetid://10723395708",
fps = "rbxassetid://10734896881", gpu = "rbxassetid://10723424505", cpu = "rbxassetid://10709813383",
cpufreq = "rbxassetid://10709752035", ram = "rbxassetid://10709770317", latency = "rbxassetid://10734961133",
ping = "rbxassetid://10734949856", loss = "rbxassetid://10747382268", issues = "rbxassetid://10709753149",
server = "rbxassetid://10723404337", preset = "rbxassetid://10723387563", name = "rbxassetid://10747373176",
time = "rbxassetid://10709805144",
}
local LAVENDER, SALMON = Color3.fromRGB(150, 164, 255), Color3.fromRGB(225, 165, 135)
local extra = {}
for _, def in ipairs({
{ "kd", "KD", "0.00 KD" }, { "gpu", "GPU", "0% GPU" }, { "cpu", "CPU", "0% CPU" },
{ "cpufreq", "CPUFreq", "0 HZ" }, { "latency", "Latency", "0 MS" }, { "loss", "Loss", "0% LOSS" },
{ "issues", "Issues", "LAG" }, { "server", "Server", "LOCAL" }, { "preset", "Preset", "Default" },
}) do
local cell, icon, text = WMCell(def[2], 20, ICON[def[1]], def[3])
icon.ImageColor3 = LAVENDER
extra[def[1]] = { cell = cell, icon = icon, text = text }
WMCells[def[1]] = cell
table.insert(WMDefaultOrder, def[1])
WMShowMap[def[1]] = false
end
extra.issues.icon.ImageColor3 = SALMON
extra.issues.text.TextColor3 = SALMON
extra.latency.icon.ImageColor3 = SALMON
extra.latency.text.TextColor3 = SALMON
local GLIDE = TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
WindowObj._wmRelayout = function()
local keys = {}
for key, cell in pairs(WMCells) do
if cell.Visible then table.insert(keys, key) else cell:SetAttribute("Placed", false) end
end
table.sort(keys, function(a, b) return WMCells[a].LayoutOrder < WMCells[b].LayoutOrder end)
local x = 0
for _, key in ipairs(keys) do
local cell = WMCells[key]
local slot = UDim2.fromOffset(x, 0)
if cell:GetAttribute("Placed") and GameInfo.Visible then
if cell.Position ~= slot then TweenService:Create(cell, GLIDE, { Position = slot }):Play() end
else
cell.Position = slot
cell:SetAttribute("Placed", true)
end
x = x + cell.AbsoluteSize.X
end
local size = UDim2.fromOffset(x + 14 + 5, 35)
if GameInfo.Visible and GameInfo.Size ~= size and GameInfo.AbsoluteSize.X > 0 then
TweenService:Create(GameInfo, GLIDE, { Size = size }):Play()
else
GameInfo.Size = size
end
end
for _, cell in pairs(WMCells) do
cell:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() WindowObj._wmRelayout() end)
end
do
local jobId = tostring(game.JobId or "")
extra.server.text.Text = jobId ~= "" and string.upper(string.sub(jobId, 1, 8)) or "LOCAL"
end
ApplyWatermarkLayout(nil, nil)
WindowObj._wmUpdateExtra = function(fps)
local function stat(name)
local ok, v = pcall(function() return Stats[name] end)
if not ok or type(v) ~= "number" then return nil end
return v < 0.5 and v * 1000 or v
end
local frameMs = (fps and fps > 0) and (1000 / fps) or 16.7
local gpuMs, cpuMs = stat("RenderGPUFrameTime"), stat("RenderCPUFrameTime")
extra.gpu.text.Text = (gpuMs and math.clamp(math.floor(gpuMs / frameMs * 100 + 0.5), 0, 100) or 0) .. "% GPU"
extra.cpu.text.Text = (cpuMs and math.clamp(math.floor(cpuMs / frameMs * 100 + 0.5), 0, 100) or 0) .. "% CPU"
local okHz, hz = pcall(function() return workspace:GetRealPhysicsFPS() end)
extra.cpufreq.text.Text = (okHz and math.floor(hz + 0.5) or 0) .. " HZ"
local ping = WindowObj._lastPing or 0
extra.latency.text.Text = tostring(ping) .. " MS"
local stats = LocalPlayer:FindFirstChild("leaderstats")
local kills = stats and (stats:FindFirstChild("Kills") or stats:FindFirstChild("K"))
local deaths = stats and (stats:FindFirstChild("Deaths") or stats:FindFirstChild("D"))
local k, d = kills and tonumber(kills.Value) or 0, deaths and tonumber(deaths.Value) or 0
extra.kd.text.Text = string.format("%.2f KD", d > 0 and k / d or k)
local loss = 0
pcall(function()
local item = Stats.Network.ServerStatsItem["Packet Loss"]
if item then loss = math.floor(item:GetValue() + 0.5) end
end)
extra.loss.text.Text = tostring(loss) .. "% LOSS"
extra.preset.text.Text = tostring(WindowObj._activePresetName or "Default")
local hist, spread = WindowObj._pingHistory, 0
if hist and #hist > 1 then
local lo, hi = math.huge, -math.huge
for _, v in ipairs(hist) do lo = math.min(lo, v); hi = math.max(hi, v) end
spread = hi - lo
end
extra.issues.cell.Visible = WMShowMap.issues == true and GameInfo.Visible and (ping > 200 or spread > 80 or loss > 2)
end
local ITEMS = {
{ "logo", "Logo" }, { "kd", "KD Ratio" }, { "speed", "Speed" }, { "fps", "Framerate" }, { "gpu", "GPU Load" },
{ "cpu", "CPU Load" }, { "cpufreq", "CPU Frequency" }, { "ram", "Memory Load" }, { "latency", "Latency" },
{ "ping", "Var" }, { "loss", "Loss" }, { "issues", "Connectivity Issues" }, { "server", "Server Address" },
{ "preset", "Preset" }, { "name", "Username" }, { "time", "Time" },
}
local TEXT, MUTED = Color3.fromRGB(235, 236, 241), Color3.fromRGB(150, 152, 162)
local settingsFrame, itemsFrame, colorSwatch, avatarSwitch, positionFrame, positionValue
local PRESETS = { "Top Right", "Top Center", "Top Left", "Bottom Right", "Bottom Center", "Bottom Left", "Custom" }
local function topInset()
local ok, inset = pcall(function() return game:GetService("GuiService"):GetGuiInset() end)
WindowObj._topInset = ok and inset and inset.Y or 0
return WindowObj._topInset
end
WindowObj._wmPlace = function(name)
local top = 8 - topInset()
local spots = {
["Top Right"] = { Vector2.new(1, 0), UDim2.new(1, -8, 0, top) },
["Top Center"] = { Vector2.new(0.5, 0), UDim2.new(0.5, 0, 0, top) },
["Top Left"] = { Vector2.new(0, 0), UDim2.new(0, 8, 0, top) },
["Bottom Right"] = { Vector2.new(1, 1), UDim2.new(1, -8, 1, -8) },
["Bottom Center"] = { Vector2.new(0.5, 1), UDim2.new(0.5, 0, 1, -8) },
["Bottom Left"] = { Vector2.new(0, 1), UDim2.new(0, 8, 1, -8) },
}
if name == "Custom" then
local saved = WindowObj._wmCustom
if saved then
GameInfo.AnchorPoint = saved[1]
GameInfo.Position = saved[2]
end
GameInfo:SetAttribute("Dragged", true)
GameInfo:SetAttribute("Preset", "Custom")
if positionValue then positionValue.Text = "Custom" end
return
end
local spot = spots[name]
if not spot then return end
GameInfo.AnchorPoint = spot[1]
GameInfo.Position = spot[2]
GameInfo:SetAttribute("Dragged", false)
GameInfo:SetAttribute("Preset", name)
if positionValue then positionValue.Text = name end
end
WindowObj._wmPlace("Top Right")
local wmColor = LAVENDER
local function paintIcons(color)
wmColor = color
for key, cell in pairs(WMCells) do
if key ~= "brand" and key ~= "user" and key ~= "issues" and key ~= "latency" and key ~= "ping" then
for _, child in ipairs(cell:GetChildren()) do
if child:IsA("ImageLabel") then child.ImageColor3 = color end
end
end
end
if colorSwatch then colorSwatch.BackgroundColor3 = color end
end
local function plate(name, w, h)
local f = New("Frame", {
Name = name, Size = UDim2.fromOffset(w, h), BackgroundColor3 = Color3.fromRGB(24, 25, 33),
BorderSizePixel = 0, Visible = false, ZIndex = 9000, ClipsDescendants = false,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, f)
Stroke(f)
if WindowObj._attachShadow then WindowObj._attachShadow(f, { radius = 10, layers = 5, step = 1.6, bias = 3 }) end
return f
end
local function closeFrame(frame)
if not frame or not frame.Visible then return end
UnregisterPopup(frame)
SmoothClose(frame, 0.14)
end
local function openFrame(frame, x, y, trigger, closeFn, free)
ApplyZIndexLadder(frame, NextPopupZ())
SmoothOpen(frame, 0, 0.2)
MovePopupToAbsolute(frame, x, y)
if not free then ConstrainPopupToMainFrame(frame, 8) end
local settled = frame.Position
frame.Position = UDim2.new(settled.X.Scale, settled.X.Offset, settled.Y.Scale, settled.Y.Offset - 8)
TweenService:Create(frame, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = settled }):Play()
RegisterPopup(frame, closeFn, trigger)
end
local function setSwitch(track, on)
Tween(track, { BackgroundColor3 = on and mainColor or Color3.fromRGB(8, 10, 16) }, 0.15)
local knob = track:FindFirstChild("Knob")
if knob then
Tween(knob, {
Position = on and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2),
BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
}, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end
end
local function buildItems()
itemsFrame = plate("WatermarkItems", 180, 8 + #ITEMS * 22)
local list = New("Frame", { Name = "List", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 9001 }, itemsFrame)
New("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }, list)
New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, list)
for i, item in ipairs(ITEMS) do
local key, label = item[1], item[2]
local row = New("TextButton", {
Name = "Item_" .. key, LayoutOrder = i, Size = UDim2.new(1, 0, 0, 22), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = 9002,
}, list)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, row)
local check = New("ImageLabel", {
Name = "Check", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(12, 12),
BackgroundTransparency = 1, Image = "rbxassetid://10709790644", ImageColor3 = TEXT, ZIndex = 9003,
}, row)
New("ImageLabel", {
Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 24, 0.5, 0), Size = UDim2.fromOffset(13, 13),
BackgroundTransparency = 1, Image = ICON[key], ImageColor3 = MUTED, ZIndex = 9003,
}, row)
local text = New("TextLabel", {
Name = "Label", Position = UDim2.fromOffset(44, 0), Size = UDim2.new(1, -48, 1, 0), BackgroundTransparency = 1,
Text = label, TextColor3 = TEXT, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9003,
}, row)
local function paint()
local on = WMShowMap[key] == true
check.Visible = on
text.TextColor3 = on and TEXT or MUTED
end
paint()
row.MouseEnter:Connect(function() Tween(row, { BackgroundTransparency = 0.97 }, 0.08) end)
row.MouseLeave:Connect(function() Tween(row, { BackgroundTransparency = 1 }, 0.12) end)
row.MouseButton1Click:Connect(function()
WMShowMap[key] = not (WMShowMap[key] == true)
ApplyWatermarkLayout(nil, nil)
paint()
end)
end
end
local function buildSettings()
settingsFrame = plate("WatermarkSettings", 230, 36 + 4 * 30 + 8)
New("TextLabel", {
Name = "Title", Position = UDim2.fromOffset(14, 6), Size = UDim2.new(1, -28, 0, 26), BackgroundTransparency = 1,
Text = "Watermark", TextColor3 = TEXT, TextSize = 14, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9001,
}, settingsFrame)
New("Frame", {
Name = "TitleRule", Position = UDim2.fromOffset(10, 34), Size = UDim2.new(1, -20, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.93, BorderSizePixel = 0, ZIndex = 9001,
}, settingsFrame)
local function row(order, icon, label)
local r = New("TextButton", {
Name = "Row" .. order, Position = UDim2.fromOffset(6, 38 + (order - 1) * 30), Size = UDim2.new(1, -12, 0, 30),
BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = 9001,
}, settingsFrame)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, r)
New("ImageLabel", {
Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1, Image = icon, ImageColor3 = Color3.fromRGB(200, 201, 210), ZIndex = 9002,
}, r)
New("TextLabel", {
Name = "Label", Position = UDim2.fromOffset(32, 0), Size = UDim2.new(0.6, -32, 1, 0), BackgroundTransparency = 1,
Text = label, TextColor3 = TEXT, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9002,
}, r)
r.MouseEnter:Connect(function() Tween(r, { BackgroundTransparency = 0.97 }, 0.08) end)
r.MouseLeave:Connect(function() Tween(r, { BackgroundTransparency = 1 }, 0.12) end)
return r
end
local itemsRow = row(1, "rbxassetid://10723433811", "Items")
New("TextLabel", {
Name = "Value", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -24, 0.5, 0), Size = UDim2.fromOffset(60, 20),
BackgroundTransparency = 1, Text = "Select", TextColor3 = MUTED, TextSize = 13, Font = FONT,
TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 9002,
}, itemsRow)
New("ImageLabel", {
Name = "Chevron", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(12, 12),
BackgroundTransparency = 1, Image = "rbxassetid://10709791437", ImageColor3 = MUTED, ZIndex = 9002,
}, itemsRow)
itemsRow.MouseButton1Click:Connect(function()
if not itemsFrame then buildItems() end
if itemsFrame.Visible then closeFrame(itemsFrame) return end
openFrame(itemsFrame, settingsFrame.AbsolutePosition.X + settingsFrame.AbsoluteSize.X + 6, itemsRow.AbsolutePosition.Y - 4,
itemsRow, function() closeFrame(itemsFrame) end)
end)
local colorRow = row(2, "rbxassetid://10734910430", "Additional Colors")
colorSwatch = New("TextButton", {
Name = "ColorSwatch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = wmColor, Text = "", AutoButtonColor = false, ZIndex = 9003,
}, colorRow)
New("UICorner", { CornerRadius = UDim.new(0, 4) }, colorSwatch)
if AcrylicBlur and AcrylicBlur.CreateColorPicker then
AcrylicBlur.CreateColorPicker(colorSwatch, wmColor, function(c) paintIcons(c) end)
end
local avatarRow = row(3, "rbxassetid://10747373176", "Display Avatar")
avatarSwitch = New("Frame", {
Name = "Switch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(32, 18),
BackgroundColor3 = Color3.fromRGB(8, 10, 16), BorderSizePixel = 0, ZIndex = 9002,
}, avatarRow)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, avatarSwitch)
local knob = New("Frame", {
Name = "Knob", Position = UDim2.fromOffset(2, 2), Size = UDim2.fromOffset(14, 14),
BackgroundColor3 = Color3.fromRGB(139, 145, 157), BorderSizePixel = 0, ZIndex = 9003,
}, avatarSwitch)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
setSwitch(avatarSwitch, WMShowMap.user == true)
avatarRow.MouseButton1Click:Connect(function()
WMShowMap.user = not (WMShowMap.user == true)
ApplyWatermarkLayout(nil, nil)
setSwitch(avatarSwitch, WMShowMap.user)
end)
local positionRow = row(4, "rbxassetid://10734900011", "Position")
positionValue = New("TextLabel", {
Name = "Value", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -24, 0.5, 0), Size = UDim2.fromOffset(100, 20),
BackgroundTransparency = 1, Text = GameInfo:GetAttribute("Preset") or "Custom", TextColor3 = MUTED, TextSize = 13, Font = FONT,
TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 9002,
}, positionRow)
New("ImageLabel", {
Name = "Chevron", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(12, 12),
BackgroundTransparency = 1, Image = "rbxassetid://10709791437", ImageColor3 = MUTED, ZIndex = 9002,
}, positionRow)
positionRow.MouseButton1Click:Connect(function()
if not positionFrame then
positionFrame = plate("WatermarkPositions", 150, 8 + #PRESETS * 24)
local list = New("Frame", { Name = "List", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 9001 }, positionFrame)
New("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 4) }, list)
New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, list)
for i, name in ipairs(PRESETS) do
local item = New("TextButton", {
Name = "Preset_" .. i, LayoutOrder = i, Size = UDim2.new(1, 0, 0, 24), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1, AutoButtonColor = false, Text = name, TextColor3 = TEXT, TextSize = 13, Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 9002,
}, list)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, item)
New("UIPadding", { PaddingLeft = UDim.new(0, 10) }, item)
item.MouseEnter:Connect(function() Tween(item, { BackgroundTransparency = 0.97 }, 0.08) end)
item.MouseLeave:Connect(function() Tween(item, { BackgroundTransparency = 1 }, 0.12) end)
item.MouseButton1Click:Connect(function()
WindowObj._wmPlace(name)
closeFrame(positionFrame)
end)
end
end
if positionFrame.Visible then closeFrame(positionFrame) return end
openFrame(positionFrame, settingsFrame.AbsolutePosition.X + settingsFrame.AbsoluteSize.X + 6, positionRow.AbsolutePosition.Y - 4,
positionRow, function() closeFrame(positionFrame) end)
end)
end
local function openSettings(point)
if not settingsFrame then buildSettings() end
if settingsFrame.Visible then closeFrame(settingsFrame) return end
setSwitch(avatarSwitch, WMShowMap.user == true)
if positionValue then positionValue.Text = GameInfo:GetAttribute("Preset") or "Custom" end
local gui = GameInfo.Parent
local low = gui and gui.AbsoluteSize.Y > 0 and GameInfo.AbsolutePosition.Y > gui.AbsoluteSize.Y / 2
local y = low and (GameInfo.AbsolutePosition.Y - settingsFrame.AbsoluteSize.Y - 4) or (GameInfo.AbsolutePosition.Y + GameInfo.AbsoluteSize.Y + 4)
openFrame(settingsFrame, point.X - 20, y, GameInfo, function()
if itemsFrame then closeFrame(itemsFrame) end
if positionFrame then closeFrame(positionFrame) end
closeFrame(settingsFrame)
end, true)
end
local drag
local function cellAt(point)
for key, cell in pairs(WMCells) do
if cell.Visible and IsPointInside(cell, point) then return key end
end
return nil
end
local function currentOrder()
local keys = {}
for key in pairs(WMCells) do table.insert(keys, key) end
table.sort(keys, function(a, b) return WMCells[a].LayoutOrder < WMCells[b].LayoutOrder end)
return keys
end
local function reorder(key, x)
local order = currentOrder()
for i, k in ipairs(order) do if k == key then table.remove(order, i) break end end
local index = 1
for i, k in ipairs(order) do
local cell = WMCells[k]
if cell.Visible and x > cell.AbsolutePosition.X + cell.AbsoluteSize.X / 2 then index = i + 1 end
end
table.insert(order, index, key)
ApplyWatermarkLayout(order, nil)
end
GameInfo.InputBegan:Connect(function(input)
if not MainFrame.Visible then return end
if input.UserInputType == Enum.UserInputType.MouseButton2 then
openSettings(input.Position)
return
end
if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
drag = { point = input.Position, pos = GameInfo.Position, key = cellAt(input.Position), moved = false }
end)
UserInputService.InputChanged:Connect(function(input)
if not drag then return end
if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
local d = input.Position - drag.point
if not drag.moved and d.Magnitude < 5 then return end
drag.moved = true
if drag.key then
reorder(drag.key, input.Position.X)
else
GameInfo.Position = UDim2.new(drag.pos.X.Scale, drag.pos.X.Offset + d.X, drag.pos.Y.Scale, drag.pos.Y.Offset + d.Y)
GameInfo:SetAttribute("Dragged", true)
GameInfo:SetAttribute("Preset", "Custom")
WindowObj._wmCustom = { GameInfo.AnchorPoint, GameInfo.Position }
end
end)
UserInputService.InputEnded:Connect(function(input)
if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
drag = nil
end)
WindowObj._configExtras.pos_watermark = {
get = function()
local preset = GameInfo:GetAttribute("Preset")
if preset and preset ~= "Custom" then return { preset = preset } end
if not GameInfo:GetAttribute("Dragged") then return nil end
local p, a = GameInfo.Position, GameInfo.AnchorPoint
return { p.X.Scale, p.X.Offset, p.Y.Scale, p.Y.Offset, a.X, a.Y }
end,
set = function(v)
if type(v) ~= "table" then return end
if type(v.preset) == "string" then WindowObj._wmPlace(v.preset) return end
if type(v[4]) ~= "number" then return end
if type(v[6]) == "number" then GameInfo.AnchorPoint = Vector2.new(v[5], v[6]) end
GameInfo.Position = UDim2.new(v[1], v[2], v[3], v[4])
GameInfo:SetAttribute("Dragged", true)
GameInfo:SetAttribute("Preset", "Custom")
WindowObj._wmCustom = { GameInfo.AnchorPoint, GameInfo.Position }
end,
}
WindowObj._configExtras.watermark = {
get = function()
local show = {}
for k, v in pairs(WMShowMap) do show[k] = v == true end
return { order = currentOrder(), show = show, color = { wmColor.R, wmColor.G, wmColor.B } }
end,
set = function(v)
if type(v) ~= "table" then return end
if type(v.show) == "table" then
for k, on in pairs(v.show) do if WMShowMap[k] ~= nil then WMShowMap[k] = on == true end end
end
ApplyWatermarkLayout(type(v.order) == "table" and v.order or nil, nil)
if type(v.color) == "table" and #v.color == 3 then paintIcons(Color3.new(v.color[1], v.color[2], v.color[3])) end
end,
}
paintIcons(wmColor)
end
WindowObj._buildWatermarkUI()
WindowObj.Watermark = {
frame = GameInfo,
logo = NeverIcon,
user = Username,
avatar = UserIcon,
fps = FPSText,
time = TimeText,
ping = MSText,
ram = RamText,
speed = WindowObj._wmSpeedText,
icons = { NeverIcon, UserIcon, WindowObj._wmSpeed.icon, FpsCellIcon, SignalImage, RamCellIcon, TimeCellIcon },
cells = WMCells,
applyLayout = ApplyWatermarkLayout,
isShown = function(key)
key = key == "logo" and "logo" or key
return WMShowMap[key] == true
end,
toggle = function(key, on)
WMShowMap[key] = on == true
ApplyWatermarkLayout(nil, nil)
end,
}
end
function WindowObj:SetWatermark(options)
local wm = WindowObj.Watermark
if type(options) ~= "table" then return wm end
if type(options.positionPreset) == "string" and WindowObj._wmPlace then
WindowObj._wmPlace(options.positionPreset)
elseif options.position then
if options.anchorPoint then
wm.frame.AnchorPoint = options.anchorPoint
end
wm.frame.Position = options.position
end
if options.background then wm.frame.BackgroundColor3 = options.background end
if type(options.backgroundTransparency) == "number" then
wm.frame.BackgroundTransparency = options.backgroundTransparency
end
if type(options.title) == "string" and wm.title then
wm.title.Text = options.title
end
local keys = { "user", "speed", "fps", "ping", "ram", "time" }
if type(options.textSize) == "number" then
for _, key in ipairs(keys) do
if wm[key] then wm[key].TextSize = options.textSize end
end
end
if options.accent and typeof(options.accent) == "Color3" then
for _, icon in ipairs(wm.icons) do
if icon and icon:IsA("ImageLabel") and icon ~= wm.logo and icon ~= wm.avatar then
icon.ImageColor3 = options.accent
icon.ImageTransparency = 0.15
end
end
end
if type(options.show) == "table" or type(options.order) == "table" then
wm.applyLayout(options.order, options.show)
end
return wm
end
local _smoothTextBaseTransparency = setmetatable({}, { __mode = "k" })
local function setTextSmooth(label, newText)
if not label or not label.Parent then return end
newText = tostring(newText or "")
if label:GetAttribute("shownText") == newText then return end
if _smoothTextBaseTransparency[label] == nil then
_smoothTextBaseTransparency[label] = label.TextTransparency
end
local targetTransparency = _smoothTextBaseTransparency[label]
label:SetAttribute("shownText", newText)
local token = (label:GetAttribute("SmoothTextToken") or 0) + 1
label:SetAttribute("SmoothTextToken", token)
local fadeOut = Tween(label, {
TextTransparency = math.max(targetTransparency, 0.82),
}, 0.085, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
if not fadeOut then
label.Text = newText
label.TextTransparency = targetTransparency
return
end
fadeOut.Completed:Connect(function(playbackState)
if playbackState ~= Enum.PlaybackState.Completed then return end
if not label.Parent or label:GetAttribute("SmoothTextToken") ~= token then return end
label.Text = newText
Tween(label, {
TextTransparency = targetTransparency,
}, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
end
local fpsBuffer = {}
local clockAcc = 0
local statAcc = 0
local lastFps
local lastMs
RunService.RenderStepped:Connect(function(dt)
if type(dt) ~= "number" or dt <= 0 then return end
table.insert(fpsBuffer, dt)
if #fpsBuffer > 20 then table.remove(fpsBuffer, 1) end
clockAcc = clockAcc + dt
if clockAcc >= 1 then
clockAcc = 0
setTextSmooth(TimeText, os.date("%H:%M"))
end
WindowObj._wmSpeedAcc = (WindowObj._wmSpeedAcc or 0) + dt
if WindowObj._wmSpeedAcc >= 0.2 and WindowObj._wmSpeedText then
WindowObj._wmSpeedAcc = 0
local char = LocalPlayer.Character
local root = char and char:FindFirstChild("HumanoidRootPart")
local speed = 0
if root then
local v = root.AssemblyLinearVelocity
speed = math.floor(Vector3.new(v.X, 0, v.Z).Magnitude + 0.5)
end
WindowObj._wmSpeedText.Text = tostring(speed) .. " SPEED"
end
statAcc = statAcc + dt
if statAcc < 1 then return end
statAcc = 0
local avg = 0
for _, v in ipairs(fpsBuffer) do avg = avg + v end
if avg > 0 then
local fps = math.round(#fpsBuffer / avg)
if fps ~= lastFps then
lastFps = fps
setTextSmooth(FPSText, tostring(fps) .. " FPS")
end
end
if WindowObj._wmUpdateExtra then pcall(WindowObj._wmUpdateExtra, lastFps) end
local ping = nil
pcall(function()
if Stats and Stats.Network then
local si = rawget(Stats.Network, "ServerStatsItem") or Stats.Network:FindFirstChild("ServerStatsItem")
if si then ping = si["Data Ping"] end
end
end)
if ping then
local ok, value = pcall(function() return ping:GetValue() end)
if ok and type(value) == "number" then
local ms = math.round(value)
lastMs = ms
WindowObj._lastPing = ms
local hist = WindowObj._pingHistory or {}
WindowObj._pingHistory = hist
table.insert(hist, ms)
if #hist > 6 then table.remove(hist, 1) end
local lo, hi = math.huge, -math.huge
for _, v in ipairs(hist) do lo = math.min(lo, v); hi = math.max(hi, v) end
setTextSmooth(MSText, "VAR ±" .. tostring(math.floor((hi - lo) / 2 + 0.5)) .. " MS")
end
end
local okMem, memMb = pcall(function() return game:GetTotalMemoryUsageMb() end)
if okMem and type(memMb) == "number" then
setTextSmooth(RamText, tostring(math.floor(memMb)) .. " MB")
end
end)
local function AttachShadow(frame, opts)
WindowObj._attachShadow = WindowObj._attachShadow or AttachShadow
if not frame or not frame.Parent then return end
if frame:FindFirstChildWhichIsA("UIListLayout") or frame:FindFirstChildWhichIsA("UIGridLayout") then
warn("[ui] AttachShadow: " .. frame.Name .. " has a layout, shadow skipped")
return
end
opts = opts or {}
local layers = math.clamp(opts.layers or 6, 1, 8)
local step = opts.step or 2.0
local bias = opts.bias or 2
local radius = opts.radius or 16
for i = 1, layers do
local spread = math.floor(i * step + 0.5)
local inner = opts.strength or 0.76
local alpha = math.clamp(inner + (i - 1) * ((0.98 - inner) / math.max(1, layers - 1)), inner, 0.98)
local shadow = New("Frame", {
Name = "ShadowLayer" .. i,
Position = UDim2.new(0, -spread, 0, bias - spread),
Size = UDim2.new(1, spread * 2, 1, spread * 2),
BackgroundColor3 = Color3.new(0, 0, 0),
BackgroundTransparency = alpha,
BorderSizePixel = 0,
ZIndex = frame.ZIndex - 1,
}, frame)
shadow:SetAttribute("IsShadowLayer", true)
shadow:SetAttribute("ShadowAlpha", alpha)
New("UICorner", { CornerRadius = UDim.new(0, radius + spread) }, shadow)
end
end
AttachShadow(MainFrame, { radius = 20, layers = 6, step = 2.0, bias = 2 })
WindowObj._styleListPopup = function(popup)
if popup:GetAttribute("NLListStyled") then return end
popup:SetAttribute("NLListStyled", true)
popup.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
popup.ClipsDescendants = false
if not popup:FindFirstChildWhichIsA("UIListLayout") then
AttachShadow(popup, { radius = 10, layers = 5, step = 1.6, bias = 3 })
end
end
local RefreshKeybindOverlay
do
local ICON_EYE = "rbxassetid://127234874352422"
local ICON_KEYBOARD = "rbxassetid://121978468376124"
local OverlayStack = New("Frame", {
Name = "OverlayStack",
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -6, 0, 46),
Size = UDim2.fromOffset(220, 0),
AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
ZIndex = Z_BASE + 880,
}, NightUICS2)
New("UIListLayout", {
FillDirection = Enum.FillDirection.Vertical,
HorizontalAlignment = Enum.HorizontalAlignment.Right,
VerticalAlignment = Enum.VerticalAlignment.Top,
Padding = UDim.new(0, 8),
SortOrder = Enum.SortOrder.LayoutOrder,
}, OverlayStack)
local OV = { h = 24, head = 32, header = 0.3, entryAlpha = 0.38, glass = Color3.fromRGB(8, 9, 12), entry = Color3.fromRGB(23, 23, 31) }
function OV.pill(name, parent, alpha, radius, height, flat)
local pill = New("Frame", {
Name = name, Size = UDim2.fromOffset(height or OV.h, height or OV.h), BackgroundColor3 = OV.glass,
BackgroundTransparency = alpha, BorderSizePixel = 0, ZIndex = Z_BASE + 891,
}, parent)
pill:SetAttribute("PillAlpha", alpha)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, pill)
if not flat then WindowObj._edgeShadow(pill, Z_BASE + 890) end
if WindowObj._attachBlur then WindowObj._attachBlur(pill, math.floor(radius * 0.6)) end
return pill
end
OV.pad = 12
do
local ok, inset = pcall(function() return game:GetService("GuiService"):GetGuiInset() end)
OV.inset = ok and inset and inset.Y or 0
end
local function MakeOverlayPanel(name, iconAsset, title)
local panel = New("CanvasGroup", {
Name = name,
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -8 + OV.pad, 0, 53 - (OV.inset or 0) - OV.pad),
Size = UDim2.fromOffset(120, OV.head + OV.pad * 2),
BackgroundTransparency = 1,
BorderSizePixel = 0,
GroupTransparency = 1,
Visible = false,
ZIndex = Z_BASE + 890,
}, NightUICS2)
New("UIPadding", { PaddingLeft = UDim.new(0, OV.pad), PaddingRight = UDim.new(0, OV.pad), PaddingTop = UDim.new(0, OV.pad), PaddingBottom = UDim.new(0, OV.pad) }, panel)
New("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Left, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, panel)
New("UIScale", { Name = "PopScale", Scale = 1 }, panel)
local header = OV.pill("Header", panel, OV.header, 16, OV.head)
header.LayoutOrder = 1
header.Active = true
local content = New("Frame", { Name = "Content", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = Z_BASE + 892 }, header)
New("UIPadding", { PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14) }, content)
New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, content)
New("ImageLabel", {
Name = "HeaderIcon", Size = UDim2.fromOffset(15, 15), BackgroundTransparency = 1,
Image = iconAsset, ImageColor3 = Color3.fromRGB(150, 164, 255), ScaleType = Enum.ScaleType.Fit, LayoutOrder = 1, ZIndex = Z_BASE + 892,
}, content)
local divider = New("Frame", {
Name = "HeaderDivider", Size = UDim2.fromOffset(1, 14), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.88, BorderSizePixel = 0, LayoutOrder = 2, ZIndex = Z_BASE + 892,
}, content)
divider:SetAttribute("PillAlpha", 0.88)
New("TextLabel", {
Name = "HeaderTitle", Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
BackgroundTransparency = 1, Text = title, TextColor3 = Color3.fromRGB(235, 236, 241), TextTransparency = 0,
TextSize = 14, Font = FONT_BOLD, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 3, ZIndex = Z_BASE + 892,
}, content)
local headerW = math.ceil(14 + 15 + 8 + 1 + 8 + MeasureText(title, 14, FONT_BOLD) + 14)
header.Size = UDim2.fromOffset(headerW, OV.head)
panel:SetAttribute("HeaderWidth", headerW)
panel.AnchorPoint = Vector2.new(0, 0)
panel.Position = UDim2.new(1, -8 + OV.pad - (headerW + OV.pad * 2), panel.Position.Y.Scale, panel.Position.Y.Offset)
if WindowObj._makeDraggable then WindowObj._makeDraggable(header, panel, name) end
local rows = New("Frame", {
Name = "Rows", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
BackgroundTransparency = 1, LayoutOrder = 2, ZIndex = Z_BASE + 891,
}, panel)
New("UIListLayout", { FillDirection = Enum.FillDirection.Vertical, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, rows)
return panel, rows
end
function OV.row(rows, order, text, leftText, iconRight)
local leftW = leftText and math.max(OV.h, math.ceil(MeasureText(leftText, 12, FONT) + 14)) or OV.h
local nameW = math.ceil(MeasureText(text, 12, FONT) + 24)
local row = New("Frame", {
Name = "OverlayRow", Size = UDim2.fromOffset(leftW + 4 + nameW, OV.h), BackgroundTransparency = 1,
LayoutOrder = order, ZIndex = Z_BASE + 891,
}, rows)
local leftPill = OV.pill("IconPill", row, OV.entryAlpha, 12, nil, true)
leftPill.Size = UDim2.fromOffset(leftW, OV.h)
local iconX, nameX = 0, leftW + 4
if iconRight then iconX, nameX = nameW + 4, 0 end
leftPill.Position = UDim2.fromOffset(iconX, 0)
if leftText then
New("TextLabel", {
Name = "EntryValue", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = leftText,
TextColor3 = Color3.fromRGB(235, 236, 241), TextTransparency = 0, TextSize = 12, Font = FONT,
ZIndex = Z_BASE + 892,
}, leftPill)
end
local namePill = OV.pill("NamePill", row, OV.entryAlpha, 12, nil, true)
namePill.Position = UDim2.fromOffset(nameX, 0)
namePill.Size = UDim2.fromOffset(nameW, OV.h)
New("TextLabel", {
Name = "EntryName", Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 1, 0),
BackgroundTransparency = 1, Text = text, TextColor3 = Color3.fromRGB(180, 182, 188), TextTransparency = 0,
TextSize = 12, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = Z_BASE + 892,
}, namePill)
row:SetAttribute("NameX", nameX)
row:SetAttribute("IconX", iconX)
return row, leftPill
end
OV.ease = TweenInfo.new(0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
OV.easeIn = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
local function FadeOverlayContents(root, show)
local info = show and OV.ease or OV.easeIn
local function go(node, props) TweenService:Create(node, info, props):Play() end
for _, node in ipairs(root:GetDescendants()) do
if node:IsA("TextLabel") then
if show then node.TextTransparency = 1 end
go(node, { TextTransparency = show and 0 or 1 })
elseif node:IsA("ImageLabel") then
if show then node.ImageTransparency = 1 end
go(node, { ImageTransparency = show and (node:GetAttribute("ImageAlpha") or 0) or 1 })
elseif node:IsA("UIStroke") then
if show then node.Transparency = 1 end
go(node, { Transparency = show and (node:GetAttribute("StrokeAlpha") or STROKE.Transparency) or 1 })
elseif node:IsA("Frame") and node:GetAttribute("PillAlpha") then
if show then node.BackgroundTransparency = 1 end
go(node, { BackgroundTransparency = show and node:GetAttribute("PillAlpha") or 1 })
elseif node:IsA("Frame") and node:GetAttribute("IsShadowLayer") then
if show then node.BackgroundTransparency = 1 end
go(node, { BackgroundTransparency = show and (node:GetAttribute("ShadowAlpha") or 0.9) or 1 })
elseif node:IsA("Frame") and node:GetAttribute("NLOverlayAccentPart") then
if show then node.BackgroundTransparency = 1 end
go(node, { BackgroundTransparency = show and 0 or 1 })
end
end
end
function OV.animateRow(row, show, onGone)
local icon, name = row:FindFirstChild("IconPill"), row:FindFirstChild("NamePill")
local nameX = row:GetAttribute("NameX") or 0
local iconX = row:GetAttribute("IconX") or 0
local width = row.Size.X.Offset
local info = show and OV.ease or OV.easeIn
FadeOverlayContents(row, show)
if show then
row.Size = UDim2.fromOffset(width, 0)
if icon then icon.Position = UDim2.fromOffset(iconX + 12, 0) end
if name then name.Position = UDim2.fromOffset(nameX + 12, 0) end
end
TweenService:Create(row, info, { Size = UDim2.fromOffset(width, show and OV.h or 0) }):Play()
if icon then TweenService:Create(icon, info, { Position = UDim2.fromOffset(iconX + (show and 0 or 12), 0) }):Play() end
if name then TweenService:Create(name, info, { Position = UDim2.fromOffset(nameX + (show and 0 or 12), 0) }):Play() end
if not show then
task.delay(info.Time, function()
if row.Parent then row:Destroy() end
if onGone then onGone() end
end)
end
end
function OV.layout(panel, rows)
local w, n = panel:GetAttribute("HeaderWidth") or 0, 0
for _, row in ipairs(rows:GetChildren()) do
if row:IsA("Frame") and not row:GetAttribute("Leaving") then
w = math.max(w, row.Size.X.Offset)
n = n + 1
end
end
local h = OV.head + (n > 0 and (8 + n * OV.h + (n - 1) * 4) or 0)
if panel:GetAttribute("TargetW") == w and panel:GetAttribute("TargetH") == h then return end
panel:SetAttribute("TargetW", w)
panel:SetAttribute("TargetH", h)
local size = UDim2.fromOffset(w + OV.pad * 2, h + OV.pad * 2)
local gui = panel.Parent
if gui and gui.AbsoluteSize.X > 0 and panel.AbsoluteSize.X > 0 then
local over = panel.AbsolutePosition.X + size.X.Offset - (gui.AbsoluteSize.X - 2)
if over > 0 then
local pos = panel.Position
panel.Position = UDim2.new(pos.X.Scale, pos.X.Offset - over, pos.Y.Scale, pos.Y.Offset)
end
end
if panel.Visible then TweenService:Create(panel, OV.ease, { Size = size }):Play() else panel.Size = size end
if OV.place then OV.place(true) end
end
local function SetOverlayPanelShown(panel, shown)
local pop = panel:FindFirstChild("PopScale")
if shown then
if panel.Visible and panel:GetAttribute("Shown") then return end
panel:SetAttribute("Shown", true)
if panel.GroupTransparency > 0.95 and pop then pop.Scale = 0.95 end
panel.Visible = true
TweenService:Create(panel, OV.ease, { GroupTransparency = 0 }):Play()
if pop then TweenService:Create(pop, OV.ease, { Scale = 1 }):Play() end
else
if not panel:GetAttribute("Shown") then return end
panel:SetAttribute("Shown", false)
TweenService:Create(panel, OV.easeIn, { GroupTransparency = 1 }):Play()
if pop then TweenService:Create(pop, OV.easeIn, { Scale = 0.97 }):Play() end
task.delay(OV.easeIn.Time, function()
if panel.Parent and not panel:GetAttribute("Shown") then panel.Visible = false end
end)
end
end
function OV.sync(panel, rows, cache, entries, build)
local seen = {}
for i, entry in ipairs(entries) do
seen[entry.id] = true
local held = cache[entry.id]
if held and held.row.Parent and held.sig == entry.sig then
held.row.LayoutOrder = 10 + i
else
local fresh = held == nil or not held.row.Parent
if held and held.row.Parent then held.row:Destroy() end
local row = build(entry.data, 10 + i)
cache[entry.id] = { row = row, sig = entry.sig }
if fresh and panel.Visible then OV.animateRow(row, true) end
end
end
for id, held in pairs(cache) do
if not seen[id] then
cache[id] = nil
if held.row.Parent then
held.row:SetAttribute("Leaving", true)
if panel.Visible then OV.animateRow(held.row, false) else held.row:Destroy() end
end
end
end
OV.layout(panel, rows)
end
OV.icons = {
list = "rbxassetid://10723433811", eye = "rbxassetid://10723346959",
toggleOn = "rbxassetid://10734985040", toggleOff = "rbxassetid://10734984834",
hold = "rbxassetid://10723405649", always = "rbxassetid://10709797837",
}
local KBPanel, KBRows = MakeOverlayPanel("Keybinds", OV.icons.list, "Hotkeys")
local kbEnabled = true
local kbRowCache = {}
function OV.modeGlyph(pill, mode, off)
if mode ~= "hold" and mode ~= "always" then
local track = New("Frame", {
Name = "SwitchTrack", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromOffset(16, 10), BackgroundColor3 = off and Color3.fromRGB(96, 100, 112) or Color3.fromRGB(240, 240, 244),
BackgroundTransparency = 0, BorderSizePixel = 0, ZIndex = Z_BASE + 892,
}, pill)
track:SetAttribute("NLOverlayAccentPart", true)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, track)
local knob = New("Frame", {
Name = "SwitchKnob", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, off and 2 or 8, 0.5, 0),
Size = UDim2.fromOffset(6, 6), BackgroundColor3 = OV.entry, BackgroundTransparency = 0, BorderSizePixel = 0,
ZIndex = Z_BASE + 893,
}, track)
knob:SetAttribute("NLOverlayAccentPart", true)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
return
end
local asset = mode == "hold" and OV.icons.hold or OV.icons.always
New("ImageLabel", {
Name = "StateIcon", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromOffset(16, 16), BackgroundTransparency = 1, Image = asset,
ImageColor3 = off and Color3.fromRGB(120, 124, 136) or Color3.fromRGB(240, 240, 244),
ScaleType = Enum.ScaleType.Fit, ZIndex = Z_BASE + 892,
}, pill)
end
local function BuildBindRow(entry, order)
local row, leftPill = OV.row(KBRows, order, entry.label, entry.value)
row.Name = "BindRow"
if not entry.value then OV.modeGlyph(leftPill, entry.mode, entry.on == false) end
return row
end
RefreshKeybindOverlay = function()
if not KBPanel.Parent then return end
local snapshot = {}
if WindowObj._bindSnapshot then
local ok, result = pcall(WindowObj._bindSnapshot)
if ok and type(result) == "table" then snapshot = result end
end
local menuShown = WindowObj._menuOpen
if menuShown == nil then menuShown = MainFrame.Visible end
local target = kbEnabled and not WindowObj._loaderActive and (menuShown or #snapshot > 0)
local entries = {}
for i, entry in ipairs(snapshot) do
entries[i] = {
id = entry.label .. "|" .. tostring(entry.key),
sig = tostring(entry.mode) .. ":" .. tostring(entry.value) .. ":" .. tostring(entry.on),
data = entry,
}
end
OV.sync(KBPanel, KBRows, kbRowCache, entries, BuildBindRow)
SetOverlayPanelShown(KBPanel, target)
end
WindowObj.KeybindList = {
frame = KBPanel,
setEnabled = function(enabled)
kbEnabled = enabled == true
RefreshKeybindOverlay()
end,
refresh = function() RefreshKeybindOverlay() end,
}
local SpecPanel, SpecRows = MakeOverlayPanel("DisabledSpec", OV.icons.eye, "DisabledSpec")
local specEnabled = true
local specAuto = true
local specList = {}
local specRowCache = {}
function OV.place(animated)
if SpecPanel:GetAttribute("Dragged") or KBPanel:GetAttribute("Dragged") then return end
local kb = KBPanel.Position
local shown = KBPanel:GetAttribute("Shown") == true
local below = shown and ((KBPanel:GetAttribute("TargetH") or OV.head) + 10) or 0
local pos = UDim2.new(kb.X.Scale, kb.X.Offset, kb.Y.Scale, kb.Y.Offset + below)
if animated == true and SpecPanel.Visible then
TweenService:Create(SpecPanel, OV.ease, { Position = pos }):Play()
else
SpecPanel.Position = pos
end
end
KBPanel:GetPropertyChangedSignal("Position"):Connect(function() OV.place(false) end)
KBPanel:GetAttributeChangedSignal("Shown"):Connect(function() OV.place(true) end)
local function BuildSpecRow(person, order)
local row, leftPill = OV.row(SpecRows, order, person.name)
row.Name = "SpecRow"
if person.id and person.id > 0 then
local avatar = New("ImageLabel", {
Name = "SpecAvatar",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.fromScale(0.5, 0.5),
Size = UDim2.fromOffset(16, 16),
BackgroundTransparency = 1,
Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(person.id) .. "&w=150&h=150",
ZIndex = Z_BASE + 892,
}, leftPill)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, avatar)
end
return row
end
local function RefreshSpectatorOverlay()
return
end
local function NormalizeSpectatorList(list)
local out = {}
if type(list) ~= "table" then return out end
for _, item in ipairs(list) do
if typeof(item) == "Instance" and item:IsA("Player") then
table.insert(out, { id = item.UserId, name = item.DisplayName })
elseif type(item) == "table" and item.name then
table.insert(out, { id = tonumber(item.id) or 0, name = tostring(item.name) })
elseif type(item) == "string" then
table.insert(out, { id = 0, name = item })
end
end
return out
end
local function UpdateAutoDisabledSpec()
if not specAuto then return end
local list = {}
for _, p in ipairs(Players:GetPlayers()) do
if p ~= LocalPlayer then
local char = p.Character
local dead = false
if char then
local humanoid = char:FindFirstChildOfClass("Humanoid")
dead = humanoid == nil or humanoid.Health <= 0
end
if not char or dead then
table.insert(list, { id = p.UserId, name = p.DisplayName })
end
end
end
specList = list
end
WindowObj.SpectatorList = { visible = false,
frame = SpecPanel,
setEnabled = function(enabled)
specEnabled = enabled == true
RefreshSpectatorOverlay()
end,
refresh = function()
UpdateAutoDisabledSpec()
RefreshSpectatorOverlay()
end,
}
function WindowObj:SetDisabledSpec(list)
specAuto = false
specList = NormalizeSpectatorList(list)
RefreshSpectatorOverlay()
return SpecPanel
end
function WindowObj:SetDisabledSpecAuto(enabled)
specAuto = enabled == true
if specAuto then UpdateAutoDisabledSpec() end
RefreshSpectatorOverlay()
return specAuto
end
MainFrame:GetPropertyChangedSignal("Visible"):Connect(function()
OverlayStack.Visible = true
if RefreshKeybindOverlay then RefreshKeybindOverlay() end
RefreshSpectatorOverlay()
end)
task.spawn(function()
while OverlayStack.Parent do
task.wait(0.3)
if not OverlayStack.Parent then break end
pcall(function()
if specAuto then UpdateAutoDisabledSpec() end
end)
pcall(RefreshSpectatorOverlay)
if RefreshKeybindOverlay then pcall(RefreshKeybindOverlay) end
end
end)
task.defer(function()
if RefreshKeybindOverlay then RefreshKeybindOverlay() end
RefreshSpectatorOverlay()
end)
end
local Aspect = Instance.new("UIAspectRatioConstraint")
Aspect.Parent = MainFrame
Aspect.AspectRatio = 798 / 610
local HubIcon = New("Frame", {
Name = "HubIcon",
Position = UDim2.fromOffset(13, 7),
Size = UDim2.fromOffset(38, 38),
BackgroundColor3 = Color3.fromRGB(13, 15, 22),
BackgroundTransparency = 0,
BorderSizePixel = 0,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, HubIcon)
if hubImage ~= "" then
New("ImageLabel", {
Name = "HubGlyph",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 0),
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Image = hubImage,
ScaleType = Enum.ScaleType.Stretch,
}, HubIcon)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, HubIcon:FindFirstChild("HubGlyph"))
WindowObj._imageFallback(HubIcon:FindFirstChild("HubGlyph"), "n")
else
WindowObj._logoWithFallback(HubIcon, 19, HubIcon.ZIndex + 1, 8)
end
New("TextLabel", {
Name = "Title",
Position = UDim2.fromOffset(59, 10),
Size = UDim2.fromOffset(110, 20),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Text = hubTitle,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextTruncate = Enum.TextTruncate.AtEnd,
TextScaled = false,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
}, MainFrame)
New("TextLabel", {
Name = "GameTitle",
Position = UDim2.fromOffset(59, 30),
Size = UDim2.fromOffset(110, 12),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Text = gameTitle,
TextColor3 = Color3.fromRGB(112, 116, 138),
TextTruncate = Enum.TextTruncate.AtEnd,
TextScaled = false,
TextSize = 11,
TextTransparency = 0,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
}, MainFrame)
local Info = Instance.new('Frame')
Info.Name = "Info"
Info.AnchorPoint = Vector2.new(0, 1)
Info.Position = UDim2.new(0, 15, 1, -13)
Info.Size = UDim2.new(0, 150, 0, 30)
Info.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Info.BackgroundTransparency = 1
Info.BorderSizePixel = 0
Info.Active = true
Info.Parent = MainFrame
local UserImageEl = Instance.new('ImageLabel')
UserImageEl.Name = "UserImage"
UserImageEl.Position = UDim2.fromOffset(0, 0)
UserImageEl.Size = UDim2.fromOffset(30, 30)
UserImageEl.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
UserImageEl.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=150&h=150"
UserImageEl.Parent = Info
New("UICorner", { CornerRadius = UDim.new(1,0) }, UserImageEl)
New("UIAspectRatioConstraint", { AspectType = Enum.AspectType.ScaleWithParentSize }, UserImageEl)
local UserImageStroke = Stroke(UserImageEl)
WindowObj._imageFallback(UserImageEl, string.upper(string.sub(tostring(LocalPlayer.Name or "?"), 1, 1)), true)
local User = Instance.new('TextLabel')
User.Name = "Username"
User.Position = UDim2.fromOffset(42, 0)
User.Size = UDim2.fromOffset(88, 16)
User.TextTruncate = Enum.TextTruncate.AtEnd
User.BackgroundColor3 = Color3.fromRGB(162,162,162)
User.BackgroundTransparency = 1
User.Text = LocalPlayer.Name
User.TextColor3 = Color3.fromRGB(255,255,255)
User.TextScaled = false
User.TextSize = 14
User.Font = FONT
User.TextTransparency = 0
User.TextXAlignment = Enum.TextXAlignment.Left
User.TextYAlignment = Enum.TextYAlignment.Center
User.Parent = Info
local DaysLeft = Instance.new('TextLabel')
DaysLeft.Name = "SubLabel"
DaysLeft.Position = UDim2.fromOffset(42, 17)
DaysLeft.Size = UDim2.fromOffset(88, 13)
DaysLeft.TextTruncate = Enum.TextTruncate.AtEnd
DaysLeft.BackgroundColor3 = Color3.fromRGB(162,162,162)
DaysLeft.BackgroundTransparency = 1
DaysLeft.Text = type(daysLeft) == "number" and (tostring(daysLeft) .. " days left") or "night.cc"
DaysLeft.TextColor3 = Color3.fromRGB(255,255,255)
DaysLeft.TextScaled = false
DaysLeft.TextSize = 12
DaysLeft.Font = FONT
DaysLeft.TextTransparency = 0
DaysLeft.TextColor3 = Color3.fromRGB(112, 116, 138)
DaysLeft.TextXAlignment = Enum.TextXAlignment.Left
DaysLeft.TextYAlignment = Enum.TextYAlignment.Center
DaysLeft.Parent = Info
local WindowSettings = Instance.new('TextButton')
WindowSettings.Name = "WindowSettings"
WindowSettings.Position = UDim2.new(0, 0, 0, 0)
WindowSettings.Size = UDim2.new(1, 0, 1, 0)
WindowSettings.BackgroundColor3 = Color3.fromRGB(255,255,255)
WindowSettings.BackgroundTransparency = 1
WindowSettings.Text = ""
WindowSettings.TextColor3 = Color3.fromRGB(255,255,255)
WindowSettings.TextScaled = false
WindowSettings.TextXAlignment = Enum.TextXAlignment.Right
WindowSettings.Parent = Info
local SettingsArrow = New("ImageLabel", {
Name = "UserSettingsArrow",
Position = UDim2.new(1, -9, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
AnchorPoint = Vector2.new(1, 0.5),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageTransparency = 0.3,
ScaleType = Enum.ScaleType.Fit,
Rotation = -90,
ZIndex = 102,
}, WindowSettings)
do
New("Frame", {
Name = "ProfileDivider",
Position = UDim2.new(0, -3, 0, -14),
Size = UDim2.new(1, 6, 0, 1),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.93,
BorderSizePixel = 0,
}, Info)
local hoverPlate = New("Frame", {
Name = "HoverPlate",
Position = UDim2.new(0, -6, 0, -6),
Size = UDim2.new(1, 6, 1, 12),
BackgroundColor3 = Color3.fromRGB(18, 18, 18),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 0,
}, Info)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, hoverPlate)
Info.MouseEnter:Connect(function()
Tween(hoverPlate, {BackgroundTransparency = 0.8}, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Tween(SettingsArrow, {ImageTransparency = 0}, 0.15)
end)
Info.MouseLeave:Connect(function()
Tween(hoverPlate, {BackgroundTransparency = 1}, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Tween(SettingsArrow, {ImageTransparency = 0.3}, 0.15)
end)
end
local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1
UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
UIAspectRatioConstraint.Parent = SettingsArrow
local WindowSettingsFrame = Instance.new('Frame')
WindowSettingsFrame.Name = "WindowSettingsFrame"
WindowSettingsFrame.AnchorPoint = Vector2.new(0, 1)
WindowSettingsFrame.Position = UDim2.new(0, 168, 1, -13)
WindowSettingsFrame.Size = UDim2.fromOffset(240, 0)
WindowSettingsFrame.AutomaticSize = Enum.AutomaticSize.Y
WindowSettingsFrame.ClipsDescendants = false
WindowSettingsFrame.BackgroundColor3 = Color3.fromRGB(24, 25, 33)
WindowSettingsFrame.BackgroundTransparency = 0
WindowSettingsFrame.ZIndex = 101
do Stroke(WindowSettingsFrame) end
WindowSettingsFrame.Visible = false
WindowSettingsFrame.Parent = MainFrame
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = WindowSettingsFrame end
AttachShadow(WindowSettingsFrame, { radius = 10, layers = 5, step = 1.6, bias = 3 })
local WSScale = New("UIScale", { Scale = 1 }, WindowSettingsFrame)
local UIScale = Instance.new("UIScale")
MainFrameUIScale = UIScale
UIScale.Scale = 0.9
UIScale.Parent = MainFrame
local manualScale = 0.9
local automaticScale = true
local syncScaleSelection
local applyMainColorProxy
local applyLogoProxy
local scaleViewportConnection
local function GetAutomaticScale()
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
if viewport.X <= 0 or viewport.Y <= 0 then viewport = Vector2.new(1280, 720) end
local isMobileDevice = pcall(function()
return game:GetService("UserInputService").TouchEnabled
end) and game:GetService("UserInputService").TouchEnabled
local shortSide = math.min(viewport.X, viewport.Y)
if isMobileDevice or shortSide <= 500 then
return math.clamp(math.min(viewport.X / 1280, viewport.Y / 700) * 0.85, 0.5, 0.85)
end
return math.clamp(math.min(viewport.X / 1280, viewport.Y / 760) * 0.8, 0.55, 0.8)
end
local function ApplyScale(value)
if type(value) ~= "number" or value ~= value then return end
local touchDevice = game:GetService("UserInputService").TouchEnabled
UIScale.Scale = math.clamp(value, 0.45, 1.1)
if touchDevice then
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize or Vector2.new(390, 844)
local scale = UIScale.Scale
-- Keep the whole menu inside the phone screen in both portrait and landscape.
local targetWidth = math.min(viewport.X * 0.94, 920)
local targetHeight = math.min(viewport.Y * 0.90, 900)
windowTargetSize = UDim2.fromOffset(targetWidth / scale, targetHeight / scale)
windowAnimSize = UDim2.fromOffset(targetWidth * 0.97 / scale, targetHeight * 0.97 / scale)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.Size = windowTargetSize
end
RescaleStrokes(MainFrame, UIScale.Scale)
if RepositionOpenPopups then RepositionOpenPopups() end
end
local function UpdateScale()
ApplyScale(automaticScale and GetAutomaticScale() or manualScale)
end
local function ConnectScaleCamera()
if scaleViewportConnection then pcall(function() scaleViewportConnection:Disconnect() end) end
scaleViewportConnection = nil
local camera = workspace.CurrentCamera
if camera and camera.GetPropertyChangedSignal then
local ok, connection = pcall(function() return camera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale) end)
if ok then scaleViewportConnection = connection end
end
end
local function OnCurrentCameraChanged()
ConnectScaleCamera()
UpdateScale()
end
UpdateScale()
ConnectScaleCamera()
pcall(function() workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(OnCurrentCameraChanged) end)
local SettingsContainer = Instance.new("Frame")
SettingsContainer.Name = "SettingsContainer"
SettingsContainer.Position = UDim2.new(0,10,0,0)
SettingsContainer.Size = UDim2.new(1,-20,0,50)
SettingsContainer.BackgroundColor3 = Color3.fromRGB(162,162,162)
SettingsContainer.BackgroundTransparency = 1
SettingsContainer.ZIndex = 13
SettingsContainer.AutomaticSize = Enum.AutomaticSize.Y
SettingsContainer.Parent = WindowSettingsFrame
WindowSettingsFrame.AutomaticSize = Enum.AutomaticSize.None
SettingsContainer:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
local frameWidth = WindowSettingsFrame.AbsoluteSize.X
if frameWidth <= 0 then return end
local unit = frameWidth / 240
WindowSettingsFrame.Size = UDim2.fromOffset(240, math.ceil(SettingsContainer.AbsoluteSize.Y / unit))
end)
do
local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0, 1)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = SettingsContainer
local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 8)
pad.PaddingBottom = UDim.new(0, 8)
pad.Parent = SettingsContainer
end
do
local header = Instance.new("Frame")
header.Name = "ProfileHeader"
header.Size = UDim2.new(1, 0, 0, 58)
header.BackgroundTransparency = 1
header.BorderSizePixel = 0
header.LayoutOrder = 0
header.ZIndex = 120
header.Parent = SettingsContainer
local avatar = Instance.new("ImageLabel")
avatar.Name = "ProfileAvatar"
avatar.Position = UDim2.new(0, 7, 0, 12)
avatar.Size = UDim2.fromOffset(34, 34)
avatar.BackgroundColor3 = Color3.fromRGB(28, 31, 44)
avatar.BackgroundTransparency = 0
avatar.BorderSizePixel = 0
avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId or 0) .. "&w=150&h=150"
avatar.ScaleType = Enum.ScaleType.Crop
avatar.ZIndex = 121
avatar.Parent = header
local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1, 0)
avatarCorner.Parent = avatar
local avatarStroke = Stroke(avatar, "ProfileAvatarStroke")
local name = Instance.new("TextLabel")
name.Name = "ProfileName"
name.Position = UDim2.new(0, 48, 0, 8)
name.Size = UDim2.new(1, -56, 0, 17)
name.BackgroundTransparency = 1
name.BorderSizePixel = 0
name.Text = tostring(LocalPlayer.Name or "Player")
name.TextColor3 = Color3.fromRGB(232, 234, 242)
name.TextSize = 14
name.Font = FONT
name.TextXAlignment = Enum.TextXAlignment.Left
name.TextYAlignment = Enum.TextYAlignment.Center
name.TextTruncate = Enum.TextTruncate.AtEnd
name.ZIndex = 121
name.Parent = header
local plan = Instance.new("TextLabel")
plan.Name = "ProfilePlan"
plan.Position = UDim2.new(0, 48, 0, 26)
plan.Size = UDim2.new(1, -56, 0, 14)
plan.BackgroundTransparency = 1
plan.BorderSizePixel = 0
plan.Text = type(daysLeft) == "number" and ("Till: " .. os.date("%B %d %Y", os.time() + daysLeft * 86400)) or "Till: night.cc"
plan.TextColor3 = Color3.fromRGB(151, 157, 175)
plan.TextSize = 12
plan.Font = FONT
plan.TextXAlignment = Enum.TextXAlignment.Left
plan.TextYAlignment = Enum.TextYAlignment.Center
plan.TextTruncate = Enum.TextTruncate.AtEnd
plan.ZIndex = 121
plan.Parent = header
local renew = Instance.new("TextLabel")
renew.Name = "RenewLabel"
renew.Position = UDim2.new(0, 48, 0, 42)
renew.Size = UDim2.new(1, -56, 0, 14)
renew.BackgroundTransparency = 1
renew.BorderSizePixel = 0
renew.Text = "Renew"
renew.TextColor3 = mainColor
renew.TextSize = 12
renew.Font = FONT
renew.TextXAlignment = Enum.TextXAlignment.Left
renew.TextYAlignment = Enum.TextYAlignment.Center
renew.ZIndex = 121
renew.Parent = header
for _, spacerOrder in ipairs({ 5, 55, 65, 85 }) do
local gap = New("Frame", { Name = "ProfileGroupGap", Size = UDim2.new(1, 0, 0, 9), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = spacerOrder }, SettingsContainer)
New("Frame", { Name = "GroupLine", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -8, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.93, BorderSizePixel = 0 }, gap)
end
end
local menuBind = Enum.KeyCode.RightShift
local menuBindProxy = function(key)
if key == nil then return menuBind end
menuBind = key
return menuBind
end
local WSColorpicker = Instance.new("Frame")
WSColorpicker.Name = "Colorpicker"
WSColorpicker.Size = UDim2.new(1, 0, 0, 31)
WSColorpicker.BackgroundTransparency = 1
WSColorpicker.BorderSizePixel = 0
WSColorpicker.ZIndex = 130
WSColorpicker.LayoutOrder = 60
WSColorpicker.Parent = SettingsContainer
do
New("ImageLabel", { Name = "ProfileIcon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Image = Library.ProfileIcons.style, ImageColor3 = Color3.fromRGB(200,200,206), ScaleType = Enum.ScaleType.Fit, ZIndex = 130 }, WSColorpicker)
local lbl = Instance.new("TextLabel")
lbl.Name = "colorpickerLabel"
lbl.Position = UDim2.fromOffset(34, 0)
lbl.Size = UDim2.new(1, -104, 1, 0)
lbl.AnchorPoint = Vector2.new(0,0)
lbl.BackgroundTransparency = 1
lbl.Text = "Style"
lbl.TextColor3 = Color3.fromRGB(205,205,211)
lbl.TextScaled = false
lbl.TextSize = 14
lbl.Font = FONT
lbl.TextTransparency = 0
lbl.ZIndex = 130
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = WSColorpicker
end
local wsColorBtn = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -8, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundColor3 = mainColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 130,
}, WSColorpicker)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, wsColorBtn)
Stroke(wsColorBtn, "ColorpickerButtonStroke")
local wsPicker = AcrylicBlur.CreateColorPicker(wsColorBtn, mainColor, function(c)
if applyMainColorProxy then applyMainColorProxy(c) end
end)
local WSScaleRow = Instance.new("Frame")
WSScaleRow.Name = "Selection"
WSScaleRow.Size = UDim2.new(1,0,0,31)
WSScaleRow.BackgroundColor3 = Color3.fromRGB(162,162,162)
WSScaleRow.BackgroundTransparency = 1
WSScaleRow.ZIndex = 120
WSScaleRow.LayoutOrder = 20
WSScaleRow.Parent = SettingsContainer
do
New("ImageLabel", { Name = "ProfileIcon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Image = Library.ProfileIcons.menuScale, ImageColor3 = Color3.fromRGB(200,200,206), ScaleType = Enum.ScaleType.Fit, ZIndex = 130 }, WSScaleRow)
local lbl = Instance.new("TextLabel"); lbl.Name = "Text"
lbl.Position = UDim2.fromOffset(34, 0)
lbl.Size = UDim2.new(1, -104, 1, 0)
lbl.AnchorPoint = Vector2.new(0,0)
lbl.BackgroundTransparency = 1
lbl.Text = "Menu Scale"; lbl.TextColor3 = Color3.fromRGB(205,205,211)
lbl.TextScaled = false; lbl.TextSize = 14; lbl.Font = FONT
lbl.TextTransparency = 0; lbl.ZIndex = 130
lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = WSScaleRow
end
local ScaleArrow = Instance.new("ImageLabel")
ScaleArrow.Name = "TextArrow"
ScaleArrow.AnchorPoint = Vector2.new(1, 0.5)
ScaleArrow.Position = UDim2.new(1, -4, 0.5, 0)
ScaleArrow.Size = UDim2.fromOffset(10, 10)
ScaleArrow.BackgroundTransparency = 1
ScaleArrow.Image = "rbxassetid://10709790948"
ScaleArrow.ImageTransparency = 0.4000000059604645
ScaleArrow.ImageColor3 = Color3.fromRGB(255,255,255)
ScaleArrow.ScaleType = Enum.ScaleType.Fit
ScaleArrow.Rotation = -90
ScaleArrow.ZIndex = 1000
ScaleArrow.Parent = WSScaleRow
local ScaleDefault = Instance.new("TextLabel")
ScaleDefault.Name = "TextDefault"
ScaleDefault.AnchorPoint = Vector2.new(1, 0.5)
ScaleDefault.Position = UDim2.new(1, -18, 0.5, 0)
ScaleDefault.Size = UDim2.new(0, 70, 1, 0)
ScaleDefault.TextTruncate = Enum.TextTruncate.AtEnd
ScaleDefault.BackgroundTransparency = 1
ScaleDefault.Text = "Auto"
ScaleDefault:SetAttribute("FullText", ScaleDefault.Text)
ScaleDefault.TextColor3 = Color3.fromRGB(216,216,221)
ScaleDefault.TextScaled = false
ScaleDefault.TextSize = 13
ScaleDefault.Font = FONT
ScaleDefault.TextTransparency = 0
ScaleDefault.ZIndex = 150
ScaleDefault.TextXAlignment = Enum.TextXAlignment.Right
ScaleDefault.Parent = WSScaleRow
local ScaleDownBar = Instance.new("Frame")
ScaleDownBar.Name = "Dropdown"
ScaleDownBar.Position = UDim2.new(0.60, 0, 1, 4)
ScaleDownBar.Size = UDim2.fromOffset(150, 0)
ScaleDownBar.BackgroundColor3 = Color3.fromRGB(17, 19, 28)
ScaleDownBar.BackgroundTransparency = 0
ScaleDownBar.BorderSizePixel = 0
ScaleDownBar.Visible = false
ScaleDownBar.ZIndex = 1000
ScaleDownBar.Parent = WSScaleRow
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = ScaleDownBar end
do Stroke(ScaleDownBar) end
local ScaleContainer = Instance.new("ScrollingFrame")
ScaleContainer.Name = "Container"
ScaleContainer.Position = UDim2.fromOffset(6, 6)
ScaleContainer.Size = UDim2.new(1, -12, 1, -12)
ScaleContainer.BackgroundTransparency = 1
ScaleContainer.ZIndex = 1000
ScaleContainer.Active = true
ScaleContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScaleContainer.CanvasSize = UDim2.new()
ScaleContainer.ScrollingDirection = Enum.ScrollingDirection.Y
ScaleContainer.ScrollBarThickness = 2
ScaleContainer.ScrollBarImageTransparency = 0.5
ScaleContainer.Parent = ScaleDownBar
do local ll = Instance.new("UIListLayout"); ll.FillDirection = Enum.FillDirection.Vertical; ll.SortOrder = Enum.SortOrder.LayoutOrder; ll.Padding = UDim.new(0,2); ll.Parent = ScaleContainer end
local ScaleOpenBtn = Instance.new("TextButton"); ScaleOpenBtn.Name = "OpenBtn"
ScaleOpenBtn.Size = UDim2.new(1,0,1,0); ScaleOpenBtn.BackgroundTransparency = 1
ScaleOpenBtn.Text = ""; ScaleOpenBtn.ZIndex = 500; ScaleOpenBtn.Parent = WSScaleRow
local function SetLogoState(visible)
logoVisible = visible == true
HubIcon.Visible = logoVisible
end
applyLogoProxy = SetLogoState
local WSLangRow = Instance.new("Frame")
WSLangRow.Name = "Selection"
WSLangRow.Size = UDim2.new(1,0,0,31)
WSLangRow.BackgroundColor3 = Color3.fromRGB(162,162,162)
WSLangRow.BackgroundTransparency = 1
WSLangRow.ZIndex = 120
WSLangRow.LayoutOrder = 10
WSLangRow.Parent = SettingsContainer
do
New("ImageLabel", { Name = "ProfileIcon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Image = Library.ProfileIcons.language, ImageColor3 = Color3.fromRGB(200,200,206), ScaleType = Enum.ScaleType.Fit, ZIndex = 130 }, WSLangRow)
local lbl = Instance.new("TextLabel"); lbl.Name = "Text"
lbl.Position = UDim2.fromOffset(34, 0)
lbl.Size = UDim2.new(1, -104, 1, 0)
lbl.AnchorPoint = Vector2.new(0,0)
lbl.BackgroundTransparency = 1
lbl.Text = "Language"; lbl.TextColor3 = Color3.fromRGB(205,205,211)
lbl.TextScaled = false; lbl.TextSize = 14; lbl.Font = FONT
lbl.TextTransparency = 0; lbl.ZIndex = 130
lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = WSLangRow
end
local LangArrow = Instance.new("ImageLabel")
LangArrow.Name = "TextArrow"
LangArrow.AnchorPoint = Vector2.new(1, 0.5)
LangArrow.Position = UDim2.new(1, -4, 0.5, 0)
LangArrow.Size = UDim2.fromOffset(10, 10)
LangArrow.BackgroundTransparency = 1
LangArrow.Image = "rbxassetid://10709790948"
LangArrow.ImageTransparency = 0.4000000059604645
LangArrow.ImageColor3 = Color3.fromRGB(255,255,255)
LangArrow.ScaleType = Enum.ScaleType.Fit
LangArrow.Rotation = -90
LangArrow.ZIndex = 1000
LangArrow.Parent = WSLangRow
local LangDefault = Instance.new("TextLabel")
LangDefault.Name = "TextDefault"
LangDefault.AnchorPoint = Vector2.new(1, 0.5)
LangDefault.Position = UDim2.new(1, -18, 0.5, 0)
LangDefault.Size = UDim2.new(0, 70, 1, 0)
LangDefault.TextTruncate = Enum.TextTruncate.AtEnd
LangDefault.BackgroundTransparency = 1
LangDefault.Text = "English"
LangDefault:SetAttribute("FullText", LangDefault.Text)
LangDefault.TextColor3 = Color3.fromRGB(216,216,221)
LangDefault.TextScaled = false
LangDefault.TextSize = 13
LangDefault.Font = FONT
LangDefault.TextTransparency = 0
LangDefault.ZIndex = 150
LangDefault.TextXAlignment = Enum.TextXAlignment.Right
LangDefault.Parent = WSLangRow
local LangDownBar = Instance.new("Frame")
LangDownBar.Name = "Dropdown"
LangDownBar.Position = UDim2.new(0.60, 0, 1, 4)
LangDownBar.Size = UDim2.fromOffset(150, 0)
LangDownBar.BackgroundColor3 = Color3.fromRGB(17, 19, 28)
LangDownBar.BackgroundTransparency = 0
LangDownBar.BorderSizePixel = 0
LangDownBar.Visible = false
LangDownBar.ZIndex = 1000
LangDownBar.Parent = WSLangRow
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0,10); c.Parent = LangDownBar end
do Stroke(LangDownBar) end
local LangContainer = Instance.new("ScrollingFrame")
LangContainer.Name = "Container"
LangContainer.Position = UDim2.fromOffset(6, 6)
LangContainer.Size = UDim2.new(1, -12, 1, -12)
LangContainer.BackgroundTransparency = 1
LangContainer.ZIndex = 1000
LangContainer.Active = true
LangContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
LangContainer.CanvasSize = UDim2.new()
LangContainer.ScrollingDirection = Enum.ScrollingDirection.Y
LangContainer.ScrollBarThickness = 2
LangContainer.ScrollBarImageTransparency = 0.5
LangContainer.Parent = LangDownBar
do local ll = Instance.new("UIListLayout"); ll.FillDirection = Enum.FillDirection.Vertical; ll.SortOrder = Enum.SortOrder.LayoutOrder; ll.Padding = UDim.new(0,2); ll.Parent = LangContainer end
local LangOpenBtn = Instance.new("TextButton"); LangOpenBtn.Name = "OpenBtn"
LangOpenBtn.Size = UDim2.new(1,0,1,0); LangOpenBtn.BackgroundTransparency = 1
LangOpenBtn.Text = ""; LangOpenBtn.ZIndex = 500; LangOpenBtn.Parent = WSLangRow
do
local function wsApplyColor(c)
c = NormalizeColor(c)
for i, tabEntry in ipairs(tabs) do
pcall(function()
if i == activeTabIndex then
tabEntry.icon.ImageColor3 = c
tabEntry.icon.ImageTransparency = 0
else
tabEntry.icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
tabEntry.icon.ImageTransparency = 0.6
end
end)
end
local old = mainColor
local _, oldSat, oldVal = old:ToHSV()
local oldIsColour = oldSat > 0.2 and oldVal > 0.2
local function isAccent(color, object, prop)
local same = math.abs(color.R - old.R) < 0.02 and math.abs(color.G - old.G) < 0.02 and math.abs(color.B - old.B) < 0.02
if not same then return false end
if oldIsColour or object:GetAttribute("AccentTint_" .. prop) then
object:SetAttribute("AccentTint_" .. prop, true)
return true
end
return false
end
for _, object in ipairs(NightUICS2:GetDescendants()) do
local lowerName = string.lower(object.Name)
local isSwatch = lowerName:find("colorpicker") or lowerName:find("swatch") or lowerName:find("preview") or lowerName:find("svcursor")
or object:FindFirstAncestor("ColorPickerFrame")
if not isSwatch then pcall(function()
if object.Name == "InLine" and object:IsA("Frame") then
object.BackgroundColor3 = c
elseif object:IsA("GuiObject") and object.BackgroundTransparency < 1 and isAccent(object.BackgroundColor3, object, "Bg") then
object.BackgroundColor3 = c
end
if (object:IsA("ImageLabel") or object:IsA("ImageButton")) and isAccent(object.ImageColor3, object, "Image") then
object.ImageColor3 = c
end
if (object:IsA("TextLabel") or object:IsA("TextButton")) and isAccent(object.TextColor3, object, "Text") then
object.TextColor3 = c
end
if object:IsA("UIStroke") and isAccent(object.Color, object, "Stroke") then object.Color = c end
end) end
end
mainColor = c
if wsPicker then wsPicker.Set(c) end
end
applyMainColorProxy = wsApplyColor
wsPicker.Set(mainColor)
end
local scales = {"Auto", "100%", "90%", "80%", "70%", "60%", "50%"}
local scaleVals = {nil, 1, 0.9, 0.8, 0.7, 0.6, 0.5}
local scaleOpen = false
local scaleSelectedBtns = {}
syncScaleSelection = function(selectedLabel)
selectedLabel = tostring(selectedLabel or "Auto")
ScaleDefault.Text = selectedLabel
ScaleDefault:SetAttribute("FullText", selectedLabel)
for label, check in pairs(scaleSelectedBtns) do
local isSelected = label == selectedLabel
check.Visible = false
local row = check.Parent
if row then
row.BackgroundTransparency = 1
local optionLabel = row:FindFirstChild("Label")
if optionLabel then optionLabel.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180) end
end
end
end
local function closeScaleDropdown()
scaleOpen = false
Tween(ScaleArrow, {ImageTransparency = 0.15, Rotation = -90}, 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
UnregisterPopup(ScaleDownBar)
SmoothClose(ScaleDownBar, 0.18)
end
for i, scaleLabel in ipairs(scales) do
local sv = scaleVals[i]
local BtnRow = Instance.new("Frame")
BtnRow.Name = "Buttons"
BtnRow.Size = UDim2.new(1, 0, 0, 28)
BtnRow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BtnRow.BackgroundTransparency = 1
BtnRow.BorderSizePixel = 0
BtnRow.ZIndex = 1001
BtnRow.LayoutOrder = i
BtnRow.Parent = ScaleContainer
New("UICorner", { CornerRadius = UDim.new(0, 6) }, BtnRow)
local lbl = Instance.new("TextLabel")
lbl.Name = "Label"
lbl.Position = UDim2.new(0, 28, 0, 0)
lbl.Size = UDim2.new(1, -36, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = scaleLabel
lbl.TextColor3 = Color3.fromRGB(200, 204, 218)
lbl.TextScaled = false
lbl.TextSize = 14
lbl.Font = FONT
lbl.TextTransparency = 0
lbl.TextTruncate = Enum.TextTruncate.AtEnd
lbl.ZIndex = 1002
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = BtnRow
local SelBtn = Instance.new("ImageLabel")
SelBtn.Name = "Selected"
SelBtn.AnchorPoint = Vector2.new(0, 0.5)
SelBtn.Position = UDim2.new(0, 4, 0.5, 0)
SelBtn.Size = UDim2.fromOffset(14, 14)
SelBtn.BackgroundTransparency = 1
SelBtn.BorderSizePixel = 0
SelBtn.Image = "rbxassetid://138494545053627"
SelBtn.ImageColor3 = mainColor
SelBtn.Visible = false
SelBtn.ZIndex = 1004
SelBtn.Parent = BtnRow
scaleSelectedBtns[scaleLabel] = SelBtn
local RowBtn = Instance.new("TextButton")
RowBtn.Name = "OptionHit"
RowBtn.Size = UDim2.new(1, 0, 1, 0)
RowBtn.BackgroundTransparency = 1
RowBtn.Text = ""
RowBtn.ZIndex = 1003
RowBtn.Parent = BtnRow
RowBtn.MouseEnter:Connect(function() Tween(BtnRow, { BackgroundTransparency = 0.97 }, 0.08) end)
RowBtn.MouseLeave:Connect(function() Tween(BtnRow, { BackgroundTransparency = 1 }, 0.12) end)
local function selectScale()
syncScaleSelection(scaleLabel)
if scaleLabel == "Auto" then
automaticScale = true
UpdateScale()
else
automaticScale = false
manualScale = sv
ApplyScale(sv)
end
closeScaleDropdown()
end
RowBtn.MouseButton1Click:Connect(selectScale)
end
syncScaleSelection("Auto")
ScaleOpenBtn.MouseButton1Click:Connect(function()
if scaleOpen then closeScaleDropdown()
else
CloseAllPopupsExcept(ScaleDownBar)
scaleOpen = true
local popupH = math.min(#scales, 8) * 30 + 10
ScaleDownBar.Size = UDim2.fromOffset(150, popupH)
ApplyZIndexLadder(ScaleDownBar, NextPopupZ())
ScaleDownBar.Visible = true
WindowObj._centerPopupOnField(ScaleDownBar, ScaleDefault)
SmoothOpen(ScaleDownBar, 0.02, 0.16)
Tween(ScaleArrow, {ImageTransparency = 0, Rotation = -90}, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
RegisterPopup(ScaleDownBar, closeScaleDropdown, ScaleOpenBtn)
end
end)
local langs = {"English", "Filipino", "Chinese", "Russian", "Italian"}
local langOpen = false
local langSelectedBtns = {}
local selectedLang = "English"
WindowObj._closeLangDropdown = function()
langOpen = false
Tween(LangArrow, {ImageTransparency = 0.15, Rotation = -90}, 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
UnregisterPopup(LangDownBar)
SmoothClose(LangDownBar, 0.18)
end
local function syncLangSelection()
LangDefault.Text = selectedLang
LangDefault:SetAttribute("FullText", selectedLang)
for language, check in pairs(langSelectedBtns) do
local isSelected = language == selectedLang
check.Visible = false
local row = check.Parent
if row then
row.BackgroundTransparency = 1
local optionLabel = row:FindFirstChild("Label")
if optionLabel then optionLabel.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180) end
end
end
end
for i, lang in ipairs(langs) do
local BtnRow = Instance.new("Frame")
BtnRow.Name = "Buttons"
BtnRow.Size = UDim2.new(1, 0, 0, 28)
BtnRow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BtnRow.BackgroundTransparency = 1
BtnRow.BorderSizePixel = 0
BtnRow.ZIndex = 1001
BtnRow.LayoutOrder = i
BtnRow.Parent = LangContainer
New("UICorner", { CornerRadius = UDim.new(0, 6) }, BtnRow)
local lbl = Instance.new("TextLabel")
lbl.Name = "Label"
lbl.Position = UDim2.new(0, 28, 0, 0)
lbl.Size = UDim2.new(1, -36, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = lang
lbl.TextColor3 = Color3.fromRGB(200, 204, 218)
lbl.TextScaled = false
lbl.TextSize = 14
lbl.Font = FONT
lbl.TextTransparency = 0
lbl.TextTruncate = Enum.TextTruncate.AtEnd
lbl.ZIndex = 1002
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = BtnRow
local SelBtn = Instance.new("ImageLabel")
SelBtn.Name = "Selected"
SelBtn.AnchorPoint = Vector2.new(0, 0.5)
SelBtn.Position = UDim2.new(0, 4, 0.5, 0)
SelBtn.Size = UDim2.fromOffset(14, 14)
SelBtn.BackgroundTransparency = 1
SelBtn.BorderSizePixel = 0
SelBtn.Image = "rbxassetid://138494545053627"
SelBtn.ImageColor3 = mainColor
SelBtn.Visible = false
SelBtn.ZIndex = 1004
SelBtn.Parent = BtnRow
langSelectedBtns[lang] = SelBtn
local RowBtn = Instance.new("TextButton")
RowBtn.Name = "OptionHit"
RowBtn.Size = UDim2.new(1, 0, 1, 0)
RowBtn.BackgroundTransparency = 1
RowBtn.Text = ""
RowBtn.ZIndex = 1003
RowBtn.Parent = BtnRow
RowBtn.MouseEnter:Connect(function() Tween(BtnRow, { BackgroundTransparency = 0.97 }, 0.08) end)
RowBtn.MouseLeave:Connect(function() Tween(BtnRow, { BackgroundTransparency = 1 }, 0.12) end)
local function selectLang()
selectedLang = lang
syncLangSelection()
WindowObj._closeLangDropdown()
end
RowBtn.MouseButton1Click:Connect(selectLang)
end
local function AddProfileDisplayRow(order, name, title, value, iconAsset, kind)
local row = New("Frame", { Name = "Profile_" .. name, Size = UDim2.new(1, 0, 0, 31), BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = order, ZIndex = 120 }, SettingsContainer)
New("ImageLabel", { Name = "ProfileIcon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 8, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Image = iconAsset, ImageColor3 = Color3.fromRGB(200,200,206), ScaleType = Enum.ScaleType.Fit, ZIndex = 130 }, row)
local labelWidth = (kind == "switch-off" or kind == "switch-on") and UDim2.new(1, -72, 1, 0) or UDim2.new(1, -104, 1, 0)
New("TextLabel", { Name = "ProfileLabel", Position = UDim2.fromOffset(34, 0), Size = labelWidth, BackgroundTransparency = 1, Text = title, TextColor3 = Color3.fromRGB(205,205,211), TextScaled = false, TextSize = 14, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 130 }, row)
if kind == "switch-off" or kind == "switch-on" then
local on = kind == "switch-on"
local track = New("Frame", { Name = "Switch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(32, 18), BackgroundColor3 = on and mainColor or Color3.fromRGB(8, 10, 16), BorderSizePixel = 0, ZIndex = 131 }, row)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, track)
local knob = New("Frame", { Name = "Knob", Position = on and UDim2.fromOffset(16,2) or UDim2.fromOffset(2,2), Size = UDim2.fromOffset(14,14), BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157), BorderSizePixel = 0, ZIndex = 132 }, track)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
else
if value and value ~= "" then
New("TextLabel", { Name = "ProfileValue", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, kind == "arrow" and -18 or -8, 0.5, 0), Size = UDim2.fromOffset(70, 27), BackgroundTransparency = 1, Text = value, TextColor3 = Color3.fromRGB(216,216,221), TextScaled = false, TextSize = 14, Font = FONT, TextXAlignment = Enum.TextXAlignment.Right, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 130 }, row)
end
if kind == "arrow" then
New("ImageLabel", { Name = "Chevron", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0), Size = UDim2.fromOffset(10, 10), BackgroundTransparency = 1, Image = "rbxassetid://10709790948", ImageColor3 = Color3.fromRGB(255,255,255), ImageTransparency = 0.15, Rotation = -90, ScaleType = Enum.ScaleType.Fit, ZIndex = 131 }, row)
end
end
return row
end
AddProfileDisplayRow(30, "ESPScale", "ESP Scale", "150%", Library.ProfileIcons.espScale, "arrow")
AddProfileDisplayRow(40, "WindowsScale", "Windows Scale", "Auto", Library.ProfileIcons.windowsScale, "arrow")
AddProfileDisplayRow(50, "Units", "Units", "Auto", Library.ProfileIcons.units, "arrow")
AddProfileDisplayRow(70, "SafeMode", "Safe Mode", "Automatic", Library.ProfileIcons.safeMode, "arrow")
AddProfileDisplayRow(80, "Synchronization", "Synchronization", nil, Library.ProfileIcons.sync, "switch-on")
AddProfileDisplayRow(82, "DeveloperMode", "Developer Mode", nil, Library.ProfileIcons.developer, "switch-off")
AddProfileDisplayRow(90, "About", "About", nil, Library.ProfileIcons.about, "plain")
AddProfileDisplayRow(100, "Chat", "Chat", nil, Library.ProfileIcons.chat, "plain")
do
local settings = { ESPScale = "150%", WindowsScale = "Auto", Units = "Auto", SafeMode = "Automatic", Synchronization = true, DeveloperMode = false }
local choices = {
ESPScale = { "50%", "75%", "100%", "125%", "150%", "200%" },
WindowsScale = { "Auto", "75%", "100%", "125%", "150%" },
Units = { "Auto", "Metric", "Imperial" },
SafeMode = { "Automatic", "Enabled", "Disabled" },
}
local function notify(key, value)
if type(WindowObj._onProfileSetting) == "function" then InvokeCallback(WindowObj._onProfileSetting, key, value) end
end
local function applyWindowsScale(value)
local factor = tonumber(tostring(value):match("^(%d+)%%$"))
factor = factor and factor / 100 or 1
for _, name in ipairs({ "OverlayStack", "GameInfo", "WMShadow" }) do
local target = NightUICS2:FindFirstChild(name)
if target then
local scale = target:FindFirstChild("ProfileWindowsScale") or New("UIScale", { Name = "ProfileWindowsScale" }, target)
scale.Scale = factor
end
end
end
local openList
local function closeList()
if not openList then return end
local list = openList
openList = nil
UnregisterPopup(list)
SmoothClose(list, 0.1, function() list:Destroy() end)
end
local function openChoiceList(field, options, current, onPick)
closeList()
local list = New("Frame", {
Name = "ProfileChoices", Size = UDim2.fromOffset(150, #options * 30 + 10), BackgroundColor3 = Color3.fromRGB(18, 18, 27),
BorderSizePixel = 0, Visible = false, ZIndex = 9000,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, list)
Stroke(list)
local rows = New("Frame", { Name = "Rows", Position = UDim2.fromOffset(5, 5), Size = UDim2.new(1, -10, 1, -10), BackgroundTransparency = 1 }, list)
New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder }, rows)
for index, option in ipairs(options) do
local item = New("TextButton", {
Name = "Choice", LayoutOrder = index, Size = UDim2.new(1, 0, 0, 30), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1, AutoButtonColor = false, Text = option,
TextColor3 = option == current and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180),
TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
}, rows)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, item)
New("UIPadding", { PaddingLeft = UDim.new(0, 12) }, item)
item.MouseEnter:Connect(function() Tween(item, { BackgroundTransparency = 0.97 }, 0.08) end)
item.MouseLeave:Connect(function() Tween(item, { BackgroundTransparency = 1 }, 0.1) end)
if onPick then
item.MouseButton1Click:Connect(function()
closeList()
onPick(option)
end)
end
end
openList = list
ApplyZIndexLadder(list, NextPopupZ())
list.Visible = true
WindowObj._centerPopupOnField(list, field)
SmoothOpen(list, 0, 0.14)
RegisterPopup(list, closeList, field)
end
for key, options in pairs(choices) do
local row = SettingsContainer:FindFirstChild("Profile_" .. key)
local valueLabel = row and row:FindFirstChild("ProfileValue")
if row and valueLabel then
local hit = New("TextButton", { Name = "ProfileHit", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 140 }, row)
hit.MouseButton1Click:Connect(function()
if openList then closeList() return end
openChoiceList(valueLabel, options, settings[key], function(option)
settings[key] = option
valueLabel.Text = option
if key == "WindowsScale" then applyWindowsScale(option) end
notify(key, option)
end)
end)
end
end
for _, key in ipairs({ "Synchronization", "DeveloperMode" }) do
local row = SettingsContainer:FindFirstChild("Profile_" .. key)
local track = row and row:FindFirstChild("Switch")
local knob = track and track:FindFirstChild("Knob")
if row and track and knob then
local hit = New("TextButton", { Name = "ProfileHit", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 140 }, row)
hit.MouseButton1Click:Connect(function()
local on = not settings[key]
settings[key] = on
Tween(track, { BackgroundColor3 = on and mainColor or Color3.fromRGB(8, 10, 16) }, 0.15)
Tween(knob, {
Position = on and UDim2.fromOffset(16, 2) or UDim2.fromOffset(2, 2),
BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
}, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
notify(key, on)
end)
end
end
for _, key in ipairs({ "About", "Chat" }) do
local row = SettingsContainer:FindFirstChild("Profile_" .. key)
local label = row and row:FindFirstChild("ProfileLabel")
if row and label then
local hit = New("TextButton", { Name = "ProfileHit", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 140 }, row)
hit.MouseButton1Click:Connect(function()
if type(WindowObj._onProfileAction) == "function" then
InvokeCallback(WindowObj._onProfileAction, key)
elseif key == "About" then
openChoiceList(label, { "night.cc", "t.me/shizukuscripts" }, nil, function(choice)
if type(setclipboard) == "function" then pcall(setclipboard, "https://" .. tostring(choice)) end
end)
else
openChoiceList(label, { "Chat is not connected" }, nil, nil)
end
end)
end
end
function WindowObj:GetProfileSetting(key) return settings[key] end
function WindowObj:OnProfileSetting(callback) WindowObj._onProfileSetting = callback return self end
function WindowObj:OnProfileAction(callback) WindowObj._onProfileAction = callback return self end
end
for _, profileRow in ipairs(SettingsContainer:GetChildren()) do
if profileRow:IsA("Frame") and profileRow.Name ~= "ProfileHeader" and profileRow.Name ~= "ProfileGroupGap" and profileRow.Name ~= "WatermarkRow" then
AttachRowHover(profileRow)
end
end
syncLangSelection()
LangOpenBtn.MouseButton1Click:Connect(function()
if langOpen then WindowObj._closeLangDropdown()
else
CloseAllPopupsExcept(LangDownBar)
langOpen = true
local popupH = math.min(#langs, 8) * 30 + 10
LangDownBar.Size = UDim2.fromOffset(150, popupH)
ApplyZIndexLadder(LangDownBar, NextPopupZ())
LangDownBar.Visible = true
WindowObj._centerPopupOnField(LangDownBar, LangDefault)
SmoothOpen(LangDownBar, 0.02, 0.16)
Tween(LangArrow, {Rotation = -90, ImageTransparency = 0}, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
RegisterPopup(LangDownBar, WindowObj._closeLangDropdown, LangOpenBtn)
end
end)
local wsOpen = false
local function closeWS()
wsOpen = false
ClosePopupsUnder(WindowSettingsFrame)
UnregisterPopup(WindowSettingsFrame)
local anchorCenterX = Info.AbsolutePosition.X + Info.AbsoluteSize.X * 0.5
local popupCenterX = WindowSettingsFrame.AbsolutePosition.X + WindowSettingsFrame.AbsoluteSize.X * 0.5
local closeOffsetX = popupCenterX >= anchorCenterX and -6 or 6
local closingPosition = WindowSettingsFrame.Position
Tween(WindowSettingsFrame, {
Position = UDim2.new(closingPosition.X.Scale, closingPosition.X.Offset + closeOffsetX, closingPosition.Y.Scale, closingPosition.Y.Offset + 2),
}, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
Tween(WSScale, { Scale = 0.975 }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
SmoothClose(WindowSettingsFrame, 0.14)
Tween(SettingsArrow, { Rotation = -90 }, 0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
WindowSettings.MouseButton1Click:Connect(function()
wsOpen = not wsOpen
if wsOpen then
CloseAllPopupsExcept(WindowSettingsFrame)
WindowSettingsFrame.BackgroundTransparency = 1
WindowSettingsFrame.Visible = false
WSScale.Scale = 1
ApplyZIndexLadder(WindowSettingsFrame, NextPopupZ())
task.spawn(function()
task.wait()
if not wsOpen or not WindowSettingsFrame.Parent then return end
local popupSize = WindowSettingsFrame.AbsoluteSize
if popupSize.X <= 0 or popupSize.Y <= 0 then
task.wait()
if not wsOpen or not WindowSettingsFrame.Parent then return end
popupSize = WindowSettingsFrame.AbsoluteSize
end
if popupSize.X <= 0 or popupSize.Y <= 0 then
WindowSettingsFrame.Visible = true
PositionPopupWithinMain(WindowSettingsFrame, false, 8, WindowSettings)
popupSize = WindowSettingsFrame.AbsoluteSize
WindowSettingsFrame.Visible = false
end
if not wsOpen or popupSize.X <= 0 or popupSize.Y <= 0 then return end
local anchorPos = Info.AbsolutePosition
local anchorSize = Info.AbsoluteSize
local popupAppearsOnRight = true
local gui = NightUICS2
if gui and gui.AbsoluteSize.X > 0 and gui.AbsoluteSize.Y > 0 then
local edge = 8
local safeLeft = gui.AbsolutePosition.X + edge
local safeTop = gui.AbsolutePosition.Y + edge
local safeRight = gui.AbsolutePosition.X + gui.AbsoluteSize.X - edge
local safeBottom = gui.AbsolutePosition.Y + gui.AbsoluteSize.Y - edge
local x = anchorPos.X + anchorSize.X + edge
if x + popupSize.X > safeRight then x = anchorPos.X - popupSize.X - edge end
local maxX = math.max(safeLeft, safeRight - popupSize.X)
local maxY = math.max(safeTop, safeBottom - popupSize.Y)
x = math.clamp(x, safeLeft, maxX)
popupAppearsOnRight = x >= (anchorPos.X + anchorSize.X * 0.5)
local y = math.clamp(anchorPos.Y + anchorSize.Y - popupSize.Y, safeTop, maxY)
MovePopupToAbsolute(WindowSettingsFrame, x, y)
else
WindowSettingsFrame.Position = UDim2.new(0, 168, 1, -13)
end
local settled = WindowSettingsFrame.Position
local entranceOffsetX = popupAppearsOnRight and -7 or 7
WindowSettingsFrame.Position = UDim2.new(settled.X.Scale, settled.X.Offset + entranceOffsetX, settled.Y.Scale, settled.Y.Offset + 3)
WSScale.Scale = 0.955
WindowSettingsFrame.Visible = true
ApplyZIndexLadder(WindowSettingsFrame, NextPopupZ())
SmoothOpen(WindowSettingsFrame, 0, 0.17, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(WSScale, { Scale = 1 }, 0.17, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(WindowSettingsFrame, { Position = settled }, 0.17, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
RegisterPopup(WindowSettingsFrame, closeWS, WindowSettings)
Tween(SettingsArrow, { Rotation = -90 }, 0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
else
closeWS()
end
end)
RegisterConfigElement("window_", "logo", {
Get = function() return logoVisible end,
Set = function(_, value) if applyLogoProxy then applyLogoProxy(value == true) end end,
})
RegisterConfigElement("window_", "scale", {
Get = function() return automaticScale and "Auto" or UIScale.Scale end,
Set = function(_, value)
if value == "Auto" then
automaticScale = true
UpdateScale()
if syncScaleSelection then syncScaleSelection("Auto") end
elseif type(value) == "number" and value == value then
automaticScale = false
manualScale = math.clamp(value, 0.5, 1.1)
ApplyScale(manualScale)
if syncScaleSelection then syncScaleSelection(tostring(math.round(manualScale * 100)) .. "%") end
end
end,
})
RegisterConfigElement("window_", "mainColor", {
Get = function() return mainColor end,
Set = function(_, value)
if applyMainColorProxy then applyMainColorProxy(NormalizeColor(value)) end
end,
})
do
local WMRow = Instance.new("Frame")
WMRow.Name = "WatermarkRow"
WMRow.Size = UDim2.new(1, 0, 0, 60)
WMRow.BackgroundColor3 = Color3.fromRGB(140, 140, 140)
WMRow.BackgroundTransparency = 1
WMRow.ZIndex = 120
WMRow.LayoutOrder = 50
WMRow.Visible = false
WMRow.Parent = SettingsContainer
local wmLabel = Instance.new("TextLabel")
wmLabel.Name = "Text"
wmLabel.Position = UDim2.new(0.05, 0, 0, 2)
wmLabel.Size = UDim2.new(0.9, 0, 0, 14)
wmLabel.BackgroundTransparency = 1
wmLabel.Text = "Watermark"
wmLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
wmLabel.TextTransparency = 0.1
wmLabel.TextSize = 13
wmLabel.Font = FONT
wmLabel.TextXAlignment = Enum.TextXAlignment.Left
wmLabel.ZIndex = 150
wmLabel.Parent = WMRow
local chipsHost = Instance.new("Frame")
chipsHost.Name = "Chips"
chipsHost.Position = UDim2.new(0, 12, 0, 20)
chipsHost.Size = UDim2.new(1, -24, 0, 38)
chipsHost.ClipsDescendants = true
chipsHost.BackgroundTransparency = 1
chipsHost.ZIndex = 150
chipsHost.Parent = WMRow
local chipsLayout = Instance.new("UIGridLayout")
chipsLayout.FillDirection = Enum.FillDirection.Horizontal
chipsLayout.FillDirectionMaxCells = 3
chipsLayout.CellSize = UDim2.new(0.31, 0, 0, 17)
chipsLayout.CellPadding = UDim2.fromOffset(4, 3)
chipsLayout.SortOrder = Enum.SortOrder.LayoutOrder
chipsLayout.Parent = chipsHost
local chipDefs = { { "logo", "Logo" }, { "user", "User" }, { "fps", "FPS" }, { "ping", "Ping" }, { "ram", "RAM" }, { "time", "Time" } }
for index, def in ipairs(chipDefs) do
local key, caption = def[1], def[2]
local chip = Instance.new("TextButton")
chip.Name = "Chip_" .. caption
chip.Size = UDim2.new(1, 0, 1, 0)
chip.BackgroundColor3 = Color3.fromRGB(28, 31, 44)
chip.BackgroundTransparency = 0.2
chip.BorderSizePixel = 0
chip.AutoButtonColor = false
chip.Text = caption
chip.TextColor3 = Color3.fromRGB(150, 154, 172)
chip.TextSize = 11
chip.Font = FONT
chip.ZIndex = 151
chip.LayoutOrder = index
chip.Parent = chipsHost
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 4); c.Parent = chip end
do local p = Instance.new("UIPadding"); p.PaddingLeft = UDim.new(0, 5); p.PaddingRight = UDim.new(0, 5); p.Parent = chip end
local hovered = false
local function paintChip()
local on = WindowObj.Watermark.isShown and WindowObj.Watermark.isShown(key)
chip.BackgroundColor3 = on and mainColor or (hovered and Color3.fromRGB(40, 45, 62) or Color3.fromRGB(28, 31, 44))
chip.BackgroundTransparency = on and 0.12 or (hovered and 0.08 or 0.2)
chip.TextColor3 = on and Color3.fromRGB(255, 255, 255) or (hovered and Color3.fromRGB(224, 228, 239) or Color3.fromRGB(150, 154, 172))
end
chip.MouseEnter:Connect(function() hovered = true; Tween(chip, {BackgroundTransparency = 0.08}, 0.09, Enum.EasingStyle.Sine, Enum.EasingDirection.Out); paintChip() end)
chip.MouseLeave:Connect(function() hovered = false; paintChip() end)
paintChip()
chip.MouseButton1Click:Connect(function()
local on = WindowObj.Watermark.isShown and WindowObj.Watermark.isShown(key)
if WindowObj.Watermark.toggle then
WindowObj.Watermark.toggle(key, not on)
end
paintChip()
end)
end
end
local UsageContainer = Instance.new("Frame")
UsageContainer.Name = "UsageContainer"
UsageContainer.Position = UDim2.new(0,0,0,0)
UsageContainer.Size = UDim2.new(1,0,0,0)
UsageContainer.BackgroundColor3 = Color3.fromRGB(162,162,162)
UsageContainer.BackgroundTransparency = 1
UsageContainer.BorderSizePixel = 0
UsageContainer.ZIndex = 120
UsageContainer.LayoutOrder = 120
UsageContainer.AutomaticSize = Enum.AutomaticSize.Y
UsageContainer.Parent = SettingsContainer
do
local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0, 3)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = UsageContainer
end
local UsageObj = {}
local usageElemCount = 0
function UsageObj:AddSelection(text, options, default, callback)
if type(default) == "function" then callback = default; default = nil end
options = NormalizeOptions(options)
usageElemCount = usageElemCount + 1
local selected = GetValidOption(options, default)
local dropOpen = false
local selectedBtns = {}
local Row = Instance.new("Frame")
Row.Name = "Selection"
Row.Size = UDim2.new(1,0,0,28)
Row.BackgroundColor3 = Color3.fromRGB(162,162,162)
Row.BackgroundTransparency = 1
Row.ZIndex = 120
Row.LayoutOrder = usageElemCount
Row.Parent = UsageContainer
do
local ln = Instance.new("Frame"); ln.Name = "Lines"
ln.Position = UDim2.new(0.06,0,1,-1)
ln.Size = UDim2.new(0.9,0,0,1)
ln.BackgroundColor3 = Color3.fromRGB(162,162,162)
ln.BackgroundTransparency = 0.9
ln.BorderSizePixel = 0; ln.ZIndex = 150; ln.Parent = Row
end
do
local lbl = Instance.new("TextLabel"); lbl.Name = "Text"
lbl.Position = UDim2.new(0.04,0,0.5,0)
lbl.Size = UDim2.new(0.65,0,0.5,0)
lbl.AnchorPoint = Vector2.new(0,0.5)
lbl.BackgroundTransparency = 1
lbl.Text = text; lbl.TextColor3 = Color3.fromRGB(255,255,255)
lbl.TextScaled = false; lbl.Font = FONT
lbl.TextTransparency = 0.5; lbl.ZIndex = 130
lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.Parent = Row
end
local Arrow = Instance.new("ImageLabel")
Arrow.Name = "TextArrow"
Arrow.AnchorPoint = Vector2.new(1, 0.5)
Arrow.Position = UDim2.new(1, -12, 0.5, 0)
Arrow.Size = UDim2.fromOffset(10, 10)
Arrow.BackgroundTransparency = 1
Arrow.Image = "rbxassetid://10709790948"
Arrow.ImageTransparency = 0.4
Arrow.ImageColor3 = Color3.fromRGB(255,255,255)
Arrow.ScaleType = Enum.ScaleType.Fit
Arrow.Rotation = 0
Arrow.ZIndex = 1000
Arrow.Parent = Row
local TextDefault = Instance.new("TextLabel")
TextDefault.Name = "TextDefault"
TextDefault.Position = UDim2.new(0.60, 0, 0.17, 0)
TextDefault.Size = UDim2.new(0.25, 0, 0.6, 0)
TextDefault.TextTruncate = Enum.TextTruncate.AtEnd
TextDefault.BackgroundTransparency = 1
TextDefault.Text = selected
TextDefault.TextColor3 = Color3.fromRGB(255,255,255)
TextDefault.TextScaled = false
TextDefault.Font = FONT
TextDefault.TextTransparency = 0
TextDefault.ZIndex = 150
TextDefault.TextXAlignment = Enum.TextXAlignment.Left
TextDefault.Parent = Row
local DropPopup = Instance.new("Frame")
DropPopup.Name = "Dropdown"
DropPopup.Position = UDim2.new(0.60, 0, 1, 4)
DropPopup.Size = UDim2.fromOffset(150, 0)
DropPopup.BackgroundColor3 = Color3.fromRGB(17, 19, 28)
DropPopup.BackgroundTransparency = 0
DropPopup.BorderSizePixel = 0
DropPopup.Visible = false
DropPopup.ZIndex = 1000
DropPopup.Parent = Row
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = DropPopup end
do Stroke(DropPopup) end
local DropContainer = Instance.new("ScrollingFrame")
DropContainer.Name = "Container"
DropContainer.Position = UDim2.fromOffset(6, 6)
DropContainer.Size = UDim2.new(1, -12, 1, -12)
DropContainer.BackgroundTransparency = 1
DropContainer.ZIndex = 1000
DropContainer.Active = true
DropContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
DropContainer.CanvasSize = UDim2.new()
DropContainer.ScrollingDirection = Enum.ScrollingDirection.Y
DropContainer.ScrollBarThickness = 2
DropContainer.ScrollBarImageTransparency = 0.5
DropContainer.Parent = DropPopup
do local ll = Instance.new("UIListLayout"); ll.SortOrder = Enum.SortOrder.LayoutOrder; ll.Padding = UDim.new(0, 2); ll.Parent = DropContainer end
local function closeDropdown()
dropOpen = false
Tween(Arrow, {ImageTransparency = 0.4, Rotation = 0}, 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
UnregisterPopup(DropPopup)
SmoothClose(DropPopup, 0.18)
end
local function updateCheckmarks()
for opt, sb in pairs(selectedBtns) do
local isSelected = opt == selected
sb.Visible = false
sb.ImageColor3 = mainColor
local row = sb.Parent
if row then
row.BackgroundTransparency = 1
local label = row:FindFirstChildWhichIsA("TextLabel")
if label then label.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180) end
end
end
end
for i, opt in ipairs(options) do
local BtnRow = Instance.new("Frame")
BtnRow.Name = "Buttons"
BtnRow.Size = UDim2.new(1, 0, 0, 28)
BtnRow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BtnRow.BackgroundTransparency = 1
BtnRow.ZIndex = 1001
BtnRow.LayoutOrder = i
BtnRow.Parent = DropContainer
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = BtnRow end
local lbl = Instance.new("TextLabel")
lbl.Position = UDim2.new(0, 28, 0, 0)
lbl.Size = UDim2.new(1, -36, 1, 0)
lbl.BackgroundTransparency = 1
lbl.Text = opt
lbl.TextColor3 = Color3.fromRGB(200, 204, 218)
lbl.TextScaled = false
lbl.TextSize = 14
lbl.Font = FONT
lbl.TextTruncate = Enum.TextTruncate.AtEnd
lbl.TextTransparency = 0
lbl.ZIndex = 1002
lbl.TextXAlignment = Enum.TextXAlignment.Left
lbl.Parent = BtnRow
local SelBtn = Instance.new("ImageButton")
SelBtn.Name = "Selected"
SelBtn.AnchorPoint = Vector2.new(0, 0.5)
SelBtn.Position = UDim2.new(0, 4, 0.5, 0)
SelBtn.Size = UDim2.fromOffset(14, 14)
SelBtn.BackgroundTransparency = 1
SelBtn.BorderSizePixel = 0
SelBtn.Image = "rbxassetid://138494545053627"
SelBtn.ImageColor3 = mainColor
SelBtn.Visible = false
SelBtn.ZIndex = 1006
SelBtn.Parent = BtnRow
selectedBtns[opt] = SelBtn
local RowBtn = Instance.new("TextButton")
RowBtn.Size = UDim2.new(1,0,1,0)
RowBtn.BackgroundTransparency = 1
RowBtn.Text = ""
RowBtn.ZIndex = 1005
RowBtn.Parent = BtnRow
RowBtn.MouseEnter:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 0.97 }, 0.08)
end)
RowBtn.MouseLeave:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 1 }, 0.12)
end)
local function selectOpt()
selected = opt
TextDefault.Text = opt;
updateCheckmarks()
closeDropdown()
InvokeCallback(callback, opt)
end
RowBtn.MouseButton1Click:Connect(selectOpt)
SelBtn.MouseButton1Click:Connect(selectOpt)
end
local OpenBtn = Instance.new("TextButton")
OpenBtn.Name = "OpenBtn"
OpenBtn.Size = UDim2.new(1,0,1,0)
OpenBtn.BackgroundTransparency = 1
OpenBtn.Text = ""
OpenBtn.ZIndex = 500
OpenBtn.Parent = Row
OpenBtn.MouseButton1Click:Connect(function()
if dropOpen then closeDropdown()
else
CloseAllPopupsExcept(DropPopup)
dropOpen = true
local popupH = math.min(#options, 8) * 30 + 10
DropPopup.Size = UDim2.fromOffset(150, popupH)
DropPopup.BackgroundTransparency = 0
DropPopup.Visible = true
Tween(Arrow, {ImageTransparency = 0}, 0.2)
WindowObj._centerPopupOnField(DropPopup, TextDefault); SmoothOpen(DropPopup, 0, 0.14); RegisterPopup(DropPopup, closeDropdown, OpenBtn)
end
end)
updateCheckmarks()
local obj = {}
function obj:Set(val, silent)
val = GetValidOption(options, val)
selected = val
TextDefault.Text = val
updateCheckmarks()
if not silent then InvokeCallback(callback, val) end
end
function obj:Get() return selected end
RegisterConfigElement("usage_selection_", text, obj)
MakeReadableText(Row, 10, 18)
return obj
end
function UsageObj:AddColorpicker(text, defaultColor, callback)
usageElemCount = usageElemCount + 1
local initialColor = NormalizeColor(defaultColor)
local Row = New("Frame", {
Name = "Colorpicker",
Size = UDim2.new(1, 0, 0, 28),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = usageElemCount,
ZIndex = 130,
}, UsageContainer)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04, 0, 0.5, 0),
AnchorPoint = Vector2.new(0, 0.5),
Size = UDim2.new(0.65, 0, 0, 18),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(230, 230, 230),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 130,
}, Row)
local cpBtn = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = initialColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 131,
}, Row)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, cpBtn)
Stroke(cpBtn, "ColorpickerButtonStroke")
local picker = AcrylicBlur.CreateColorPicker(cpBtn, initialColor, function(c)
InvokeCallback(callback, c)
end)
local obj = {}
function obj:Set(c)
local normalized = NormalizeColor(c)
picker.Set(normalized)
InvokeCallback(callback, normalized)
end
function obj:Get() return picker.Get() end
RegisterConfigElement("usage_colorpicker_", text, obj)
MakeReadableText(Row, 10, 18)
return obj
end
function WindowObj:GetUsage() return UsageObj end
local Tab = New("ScrollingFrame", {
Name = "Tab",
Position = UDim2.fromOffset(0, 62),
Size = UDim2.new(0, 170, 1, -115),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BorderSizePixel = 0,
BackgroundTransparency = 1,
ScrollBarThickness = 0,
ScrollBarImageTransparency = 0.35,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
}, MainFrame)
New("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 11) }, Tab)
New("UIListLayout", {
Padding = UDim.new(0, 5),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Tab)
local Frame2 = New("Frame", {
Name = "Frame2",
Position = UDim2.fromOffset(170, 0),
Size = UDim2.new(1, -170, 1, 0),
BackgroundColor3 = Color3.fromRGB(15, 17, 24),
BackgroundTransparency = 0.5,
BorderSizePixel = 0,
ClipsDescendants = true,
}, MainFrame)
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 14); c.Parent = Frame2 end
do local panelStroke = Stroke(Frame2, "PanelOutline"); panelStroke.Transparency = 0.94 end
New("Frame", { Name = "HeaderDivider", Position = UDim2.new(0, 11, 0, 53), Size = UDim2.new(1, -22, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.95, BorderSizePixel = 0 }, Frame2)
local Header = New("Frame", {
Name = "Header",
Size = UDim2.new(1, 0, 0, 54),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
ClipsDescendants = false,
}, Frame2)
local SearchBtn = New("ImageButton", {
Name = "Search",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -20, 0.5, 0),
Size = UDim2.fromOffset(18, 18),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Image = "rbxassetid://6031154871",
ImageColor3 = Color3.fromRGB(200, 204, 218),
ImageTransparency = 0.2,
}, Header)
local asss = Instance.new("UIAspectRatioConstraint")
asss.Parent = SearchBtn
local function SanitizeConfigName(name)
name = tostring(name or "Default"):gsub("[^%w%-%_ ]", "_")
name = name:gsub("^%s+", ""):gsub("%s+$", "")
if #name == 0 then name = "Default" end
return name:sub(1, 64)
end
local function GetConfigPath(name)
return "NightUIConfig_" .. windowConfigId .. "_" .. SanitizeConfigName(name) .. ".json"
end
local function SaveNamedConfig(name)
if type(writefile) ~= "function" then return false end
local data = {}
for _, entry in ipairs(_registeredElements) do
if entry.obj and type(entry.obj.Get) == "function" then
local ok, value = pcall(function() return entry.obj:Get() end)
if ok then
local serialized = SerializeValue(value)
if serialized ~= nil then data[entry.key] = serialized end
end
end
end
for key, extra in pairs(WindowObj._configExtras) do
local okGet, value = pcall(extra.get)
if okGet and value ~= nil then data["__extra_" .. key] = value end
end
local http = game:GetService("HttpService")
local ok, encoded = pcall(http.JSONEncode, http, data)
if not ok or type(encoded) ~= "string" then return false end
local writeOk, writeResult = pcall(writefile, GetConfigPath(name), encoded)
if writeOk and writeResult ~= false then
pcall(writefile, "NightUIConfig_" .. windowConfigId .. "__last.txt", SanitizeConfigName(name))
end
return writeOk and writeResult ~= false
end
local function LoadNamedConfig(name)
if type(readfile) ~= "function" or type(isfile) ~= "function" then return false end
local path = GetConfigPath(name)
local existsOk, exists = pcall(isfile, path)
if not existsOk or not exists then return false end
local ok, content = pcall(readfile, path)
if not ok or type(content) ~= "string" or #content > 2097152 then return false end
local http = game:GetService("HttpService")
local decodedOk, data = pcall(http.JSONDecode, http, content)
if not decodedOk or type(data) ~= "table" then return false end
pcall(writefile, "NightUIConfig_" .. windowConfigId .. "__last.txt", SanitizeConfigName(name))
local success = true
for _, entry in ipairs(_registeredElements) do
local saved = data[entry.key]
if saved ~= nil then
if not entry.obj or type(entry.obj.Set) ~= "function" then
success = false
else
local setOk = pcall(function() entry.obj:Set(DeserializeValue(saved)) end)
if not setOk then success = false end
end
end
end
for key, extra in pairs(WindowObj._configExtras) do
local saved = data["__extra_" .. key]
if saved ~= nil then pcall(extra.set, saved) end
end
return success
end
do
local B64 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function encode(data)
return ((data:gsub(".", function(x)
local r, b = "", x:byte()
for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0") end
return r
end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
if #x < 6 then return "" end
local c = 0
for i = 1, 6 do c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0) end
return B64:sub(c + 1, c + 1)
end) .. ({ "", "==", "=" })[#data % 3 + 1])
end
local function decode(data)
data = data:gsub("[^" .. B64 .. "=]", "")
return (data:gsub(".", function(x)
if x == "=" then return "" end
local r, f = "", (B64:find(x, 1, true) - 1)
for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and "1" or "0") end
return r
end):gsub("%d%d%d?%d?%d?%d?%d?%d?", function(x)
if #x ~= 8 then return "" end
local c = 0
for i = 1, 8 do c = c + (x:sub(i, i) == "1" and 2 ^ (8 - i) or 0) end
return string.char(c)
end))
end
local http = game:GetService("HttpService")
WindowObj._makeShareCode = function(name)
local data
if type(readfile) == "function" and type(isfile) == "function" then
local okExists, exists = pcall(isfile, GetConfigPath(name))
if okExists and exists then
local okRead, content = pcall(readfile, GetConfigPath(name))
if okRead and type(content) == "string" then
local okDecode, decoded = pcall(http.JSONDecode, http, content)
if okDecode and type(decoded) == "table" then data = decoded end
end
end
end
if not data then return nil end
local okEncode, json = pcall(http.JSONEncode, http, { name = name, data = data })
if not okEncode then return nil end
return "NL1:" .. encode(json)
end
WindowObj._importShareCode = function(text)
text = tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
if string.sub(text, 1, 4) ~= "NL1:" or type(writefile) ~= "function" then return nil end
local okDecode, payload = pcall(function() return http:JSONDecode(decode(string.sub(text, 5))) end)
if not okDecode or type(payload) ~= "table" or type(payload.data) ~= "table" then return nil end
local base = SanitizeConfigName(payload.name or "Shared")
local finalName, n = base, 1
while type(isfile) == "function" and select(2, pcall(isfile, GetConfigPath(finalName))) == true do
n = n + 1
finalName = base .. " (" .. n .. ")"
end
local okJson, json = pcall(http.JSONEncode, http, payload.data)
if not okJson then return nil end
local okWrite = pcall(writefile, GetConfigPath(finalName), json)
return okWrite and finalName or nil
end
WindowObj._exportLiveShare = function(name)
local data = {}
for _, entry in ipairs(_registeredElements) do
if entry.obj and type(entry.obj.Get) == "function" then
local ok, value = pcall(function() return entry.obj:Get() end)
if ok then
local serialized = SerializeValue(value)
if serialized ~= nil then data[entry.key] = serialized end
end
end
end
for key, extra in pairs(WindowObj._configExtras) do
local okGet, value = pcall(extra.get)
if okGet and value ~= nil then data["__extra_" .. key] = value end
end
local okEncode, json = pcall(http.JSONEncode, http, {
name = SanitizeConfigName(name or "Shared"),
ver = 1,
data = data,
})
if not okEncode or type(json) ~= "string" then return nil end
return "NCC1:" .. encode(json)
end
WindowObj._importLiveShare = function(text)
text = tostring(text or ""):gsub("%s+", "")
if string.sub(text, 1, 4) == "NL1:" then
local imported = WindowObj._importShareCode(text)
if imported then
LoadNamedConfig(imported)
return imported
end
return nil
end
if string.sub(text, 1, 5) ~= "NCC1:" then return nil end
local okDecode, payload = pcall(function()
return http:JSONDecode(decode(string.sub(text, 6)))
end)
if not okDecode or type(payload) ~= "table" or type(payload.data) ~= "table" then return nil end
local data = payload.data
local applied = 0
for _, entry in ipairs(_registeredElements) do
local saved = data[entry.key]
if saved ~= nil and entry.obj and type(entry.obj.Set) == "function" then
local setOk = pcall(function() entry.obj:Set(DeserializeValue(saved)) end)
if setOk then applied = applied + 1 end
end
end
for key, extra in pairs(WindowObj._configExtras) do
local saved = data["__extra_" .. key]
if saved ~= nil then
local okSet = pcall(extra.set, saved)
if okSet then applied = applied + 1 end
end
end
local base = SanitizeConfigName(payload.name or "Shared")
local finalName, n = base, 1
if type(writefile) == "function" then
while type(isfile) == "function" and select(2, pcall(isfile, GetConfigPath(finalName))) == true do
n = n + 1
finalName = base .. " (" .. n .. ")"
end
local okJson, json = pcall(http.JSONEncode, http, data)
if okJson then pcall(writefile, GetConfigPath(finalName), json) end
end
return applied, finalName
end
end
local function ListConfigs()
if type(listfiles) ~= "function" then return {} end
local result = {}
local ok, files = pcall(listfiles, "")
if not ok or type(files) ~= "table" then return result end
local prefix = "NightUIConfig_" .. windowConfigId .. "_"
for _, fileName in ipairs(files) do
if type(fileName) == "string" and string.sub(fileName, 1, #prefix) == prefix then
local name = fileName:match("^" .. prefix .. "(.+)%.json$")
if name then table.insert(result, name) end
end
end
return result
end
local GlobalPreset
local Save = Instance.new("Frame")
Save.Name = "Save"
Save.Position = UDim2.fromOffset(11, 13)
Save.Size = UDim2.fromOffset(150, 28)
Save.BackgroundColor3 = Color3.fromRGB(20, 23, 34)
Save.BackgroundTransparency = 0
Save.BorderSizePixel = 0
Save.Parent = Header
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = Save end
do Stroke(Save) end
WindowObj._saveBox = New("Frame", {
Name = "SaveSegmentBox", Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(32, 28),
BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = Save.ZIndex + 1,
}, Save)
New("Frame", {
Name = "SaveDivider", Position = UDim2.fromOffset(32, 5), Size = UDim2.new(0, 1, 1, -10), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.9, BorderSizePixel = 0,
}, Save)
local SaveIcon = Instance.new('ImageLabel')
SaveIcon.Name = "SaveIcon"
SaveIcon.AnchorPoint = Vector2.new(0.5, 0.5)
SaveIcon.Position = UDim2.fromScale(0.5, 0.5)
SaveIcon.Size = UDim2.fromOffset(13, 13)
SaveIcon.BackgroundTransparency = 1
SaveIcon.Image = "rbxassetid://6035067857"
SaveIcon.ImageTransparency = 0.20000000298023224
SaveIcon.Parent = WindowObj._saveBox
local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.Parent = SaveIcon
local SaveText = Instance.new('TextLabel')
SaveText.Name = "SaveText"
SaveText.Position = UDim2.fromOffset(43, 0)
SaveText.Size = UDim2.new(1, -83, 1, 0)
SaveText.BackgroundTransparency = 1
SaveText.Text = "Default"
SaveText.TextColor3 = Color3.fromRGB(230, 230, 230)
SaveText.TextScaled = false
SaveText.TextSize = 14
SaveText.Font = FONT
SaveText.TextTransparency = 0.20000000298023224
SaveText.TextXAlignment = Enum.TextXAlignment.Left
SaveText.TextTruncate = Enum.TextTruncate.AtEnd
SaveText.Parent = Save
local function UpdateSavePillWidth(textValue)
local textWidth = MeasureText(tostring(textValue or SaveText.Text or "Default"), 15, FONT)
local width = math.clamp(math.ceil(textWidth) + 43 + 40, 150, 266)
Save.Size = UDim2.fromOffset(width, 28)
Save.Position = UDim2.fromOffset(11, 13)
SaveText.Size = UDim2.new(1, -83, 1, 0)
if GlobalPreset then GlobalPreset.Position = UDim2.fromOffset(11 + width + 12, 13) end
end
UpdateSavePillWidth(SaveText.Text)
WindowObj._savedCheck = function(icon)
if not icon then return end
local pop = icon:FindFirstChild("SavedPop") or New("UIScale", { Name = "SavedPop", Scale = 1 }, icon)
local token = (icon:GetAttribute("SavedToken") or 0) + 1
icon:SetAttribute("SavedToken", token)
if token == 1 or not icon:GetAttribute("Checking") then
icon:SetAttribute("RestImage", icon.Image)
icon:SetAttribute("RestColor", icon.ImageColor3)
end
icon:SetAttribute("Checking", true)
icon.Image = "rbxassetid://10709790644"
icon.ImageColor3 = Color3.fromRGB(120, 220, 150)
pop.Scale = 0.4
Tween(pop, { Scale = 1 }, 0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
task.delay(1.3, function()
if icon:GetAttribute("SavedToken") ~= token then return end
Tween(pop, { Scale = 0.6 }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
task.delay(0.12, function()
if icon:GetAttribute("SavedToken") ~= token then return end
icon.Image = icon:GetAttribute("RestImage")
icon.ImageColor3 = icon:GetAttribute("RestColor")
icon:SetAttribute("Checking", false)
Tween(pop, { Scale = 1 }, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end)
end)
end
local function FlashSaved()
WindowObj._savedCheck(SaveIcon)
end
local activeConfigName = nil
local function ShowSavedName()
if not SaveText then return end
SaveText.Text = activeConfigName or "Default"
UpdateSavePillWidth(SaveText.Text)
end
local Lines = Instance.new('Frame')
Lines.Name = "Lines"
Lines.Position = UDim2.new(0, -10, 0.15, 0)
Lines.Size = UDim2.new(0, 1, 0.70, 0)
Lines.BackgroundColor3 = Color3.fromRGB(255,255,255)
Lines.BackgroundTransparency = 0.92
Lines.BorderSizePixel = 0
Lines.Parent = SaveText
Lines.Visible = false
local Lines_2 = Instance.new('Frame')
Lines_2.Name = "Lines"
Lines_2.Position = UDim2.new(1,0,-0.19000010192394257,0)
Lines_2.Size = UDim2.new(-0.0010000000474974513,1,1.2000000476837158,3)
Lines_2.Visible = false
Lines_2.BackgroundColor3 = Color3.fromRGB(255,255,255)
Lines_2.BackgroundTransparency = 1
Lines_2.BorderSizePixel = 0
Lines_2.Parent = SaveText
local SaveArrow = Instance.new('ImageLabel')
SaveArrow.Name = "PresetArrow"
SaveArrow.AnchorPoint = Vector2.new(1, 0.5)
SaveArrow.Position = UDim2.new(1, -17, 0.5, 0)
SaveArrow.Size = UDim2.fromOffset(12, 12)
SaveArrow.ImageTransparency = 0
SaveArrow.BackgroundTransparency = 1
SaveArrow.Image = "rbxassetid://10709790948"
SaveArrow.ImageColor3 = Color3.fromRGB(255,255,255)
SaveArrow.ScaleType = Enum.ScaleType.Fit
SaveArrow.Rotation = 0
SaveArrow.ZIndex = 15
SaveArrow.Parent = Save
GlobalPreset = New("Frame", {
Name = "GlobalPreset",
Position = UDim2.fromOffset(178, 13),
Size = UDim2.fromOffset(83, 28),
BackgroundColor3 = Color3.fromRGB(20, 23, 34),
BackgroundTransparency = 0,
BorderSizePixel = 0,
}, Header)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, GlobalPreset)
Stroke(GlobalPreset)
New("TextLabel", {
Name = "GlobalPresetLabel",
Position = UDim2.fromOffset(11, 0),
Size = UDim2.new(1, -34, 1, 0),
BackgroundTransparency = 1,
Text = "Global",
TextColor3 = Color3.fromRGB(230, 230, 230),
TextSize = 14,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
}, GlobalPreset)
New("ImageLabel", {
Name = "GlobalPresetArrow",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageColor3 = Color3.fromRGB(160, 160, 160),
ScaleType = Enum.ScaleType.Fit,
Rotation = 0,
}, GlobalPreset)
GlobalPreset.Visible = false
UpdateSavePillWidth(SaveText.Text)
local function ShouldShowGlobalPreset(tabName)
local normalized = string.lower(tostring(tabName or ""))
return string.find(normalized, "legit", 1, true) ~= nil
or string.find(normalized, "rage", 1, true) ~= nil
end
local UIAspectRatioConstraint = Instance.new('UIAspectRatioConstraint')
UIAspectRatioConstraint.Name = "UIAspectRatioConstraint"
UIAspectRatioConstraint.AspectRatio = 1
UIAspectRatioConstraint.AspectType = Enum.AspectType.ScaleWithParentSize
UIAspectRatioConstraint.Parent = SaveArrow
local TriggerSaveConfig = Instance.new("TextButton")
TriggerSaveConfig.Name = "TriggerSaveConfig"
TriggerSaveConfig.Size = UDim2.new(1, 0, 1, 0)
TriggerSaveConfig.BackgroundTransparency = 1
TriggerSaveConfig.Text = ""
TriggerSaveConfig.ZIndex = 15
TriggerSaveConfig.Parent = Save
local ConfigMainFrame = Instance.new("Frame")
ConfigMainFrame.Name = "ConfigMainFrame"
ConfigMainFrame.Position = UDim2.fromOffset(11, 47)
ConfigMainFrame.Size = UDim2.fromOffset(320, 104)
ConfigMainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
ConfigMainFrame.BackgroundTransparency = 0.045
ConfigMainFrame.BorderSizePixel = 0
ConfigMainFrame.ZIndex = 110
ConfigMainFrame.AutomaticSize = Enum.AutomaticSize.None
ConfigMainFrame.ClipsDescendants = false
ConfigMainFrame.Active = true
ConfigMainFrame.Visible = false
ConfigMainFrame.Parent = Frame2
local ConfigScale = Instance.new("UIScale")
ConfigScale.Scale = 1
ConfigScale.Parent = ConfigMainFrame
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = ConfigMainFrame end
do Stroke(ConfigMainFrame) end
AttachShadow(ConfigMainFrame, { radius = 10, layers = 4, step = 1.25, bias = 2 })
local CMHeader = Instance.new("Frame")
CMHeader.Name = "Header"
CMHeader.Size = UDim2.new(1, 0, 0, 44)
CMHeader.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
CMHeader.BackgroundTransparency = 1
CMHeader.BorderSizePixel = 0
CMHeader.ClipsDescendants = true
CMHeader.ZIndex = 100
CMHeader.Parent = ConfigMainFrame
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = CMHeader end
do
local CMHeaderRule = Instance.new("Frame")
CMHeaderRule.Name = "HeaderRule"
CMHeaderRule.Position = UDim2.new(0, 14, 1, -1)
CMHeaderRule.Size = UDim2.new(1, -28, 0, 1)
CMHeaderRule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
CMHeaderRule.BackgroundTransparency = 0.92
CMHeaderRule.BorderSizePixel = 0
CMHeaderRule.ZIndex = 1000
CMHeaderRule.Parent = CMHeader
end
local CloudIcon = Instance.new("ImageLabel")
CloudIcon.Name = "CloudIcon"
CloudIcon.AnchorPoint = Vector2.new(0, 0.5)
CloudIcon.Position = UDim2.new(0, 16, 0.5, 0)
CloudIcon.Size = UDim2.fromOffset(18, 18)
CloudIcon.BackgroundTransparency = 1
CloudIcon.Image = ""
CloudIcon.ImageColor3 = mainColor
CloudIcon.ScaleType = Enum.ScaleType.Fit
CloudIcon.ZIndex = 1000
CloudIcon.Parent = CMHeader
CloudIcon.Image = ""
do
local tint = mainColor:Lerp(Color3.new(1, 1, 1), 0.35)
for _, part in ipairs({
{ UDim2.fromOffset(1, 8), UDim2.fromOffset(16, 7), UDim.new(0, 4) },
{ UDim2.fromOffset(2, 5), UDim2.fromOffset(8, 8), UDim.new(1, 0) },
{ UDim2.fromOffset(6, 2), UDim2.fromOffset(10, 10), UDim.new(1, 0) },
}) do
local piece = Instance.new("Frame")
piece.Name = "CloudPart"
piece.Position = part[1]
piece.Size = part[2]
piece.BackgroundColor3 = tint
piece.BorderSizePixel = 0
piece.ZIndex = 1001
piece.Parent = CloudIcon
local c = Instance.new("UICorner"); c.CornerRadius = part[3]; c.Parent = piece
end
end
do
local tabPill = Instance.new("Frame")
tabPill.Name = "PresetsTabPill"
tabPill.AnchorPoint = Vector2.new(0, 0.5)
tabPill.Position = UDim2.new(0, 9, 0.5, 0)
tabPill.Size = UDim2.fromOffset(104, 28)
tabPill.BackgroundColor3 = mainColor
tabPill.BackgroundTransparency = 0.86
tabPill.BorderSizePixel = 0
tabPill.ZIndex = 999
tabPill.Parent = CMHeader
local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 7); c.Parent = tabPill
end
local CMTitle = Instance.new("TextLabel")
CMTitle.Name = "TitleLabel"
CMTitle.Position = UDim2.new(0, 44, 0, 0)
CMTitle.Size = UDim2.new(1, -154, 1, 0)
CMTitle.BackgroundTransparency = 1
CMTitle.Text = "PRESETS"
CMTitle.TextColor3 = mainColor:Lerp(Color3.new(1, 1, 1), 0.35)
CMTitle.TextSize = 13
CMTitle.Font = FONT_BOLD
CMTitle.TextTransparency = 0.05
CMTitle.ZIndex = 1000
CMTitle.TextXAlignment = Enum.TextXAlignment.Left
CMTitle.Parent = CMHeader
local CMHeaderRight = Instance.new("Frame")
CMHeaderRight.Name = "HeaderRight"
CMHeaderRight.AnchorPoint = Vector2.new(1, 0)
CMHeaderRight.Position = UDim2.new(1, -14, 0, 0)
CMHeaderRight.Size = UDim2.fromOffset(96, 44)
CMHeaderRight.BackgroundTransparency = 1
CMHeaderRight.ZIndex = 1000
CMHeaderRight.Parent = CMHeader
do
local ll = Instance.new("UIListLayout")
ll.FillDirection = Enum.FillDirection.Horizontal
ll.HorizontalAlignment = Enum.HorizontalAlignment.Right
ll.VerticalAlignment = Enum.VerticalAlignment.Center
ll.Padding = UDim.new(0, 10)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = CMHeaderRight
end
local IDLE_ICON_TINT = Color3.fromRGB(176, 180, 198)
local autoSaveEnabled = false
local AutoSaveBtn, RecentlyDeletedBtn, InsertConfigBtn
do
local function HeaderIconButton(name, asset, order)
local btn = Instance.new("ImageButton")
btn.Name = name
btn.Size = UDim2.fromOffset(18, 18)
btn.BackgroundTransparency = 1
btn.Image = asset
btn.ImageColor3 = IDLE_ICON_TINT
btn.ScaleType = Enum.ScaleType.Fit
btn.ZIndex = 1000
btn.LayoutOrder = order
btn.Parent = CMHeaderRight
btn.MouseEnter:Connect(function()
Tween(btn, { ImageColor3 = Color3.fromRGB(255, 255, 255) }, 0.1)
end)
btn.MouseLeave:Connect(function()
if btn:GetAttribute("Pinned") ~= true then
Tween(btn, { ImageColor3 = IDLE_ICON_TINT }, 0.15)
end
end)
return btn
end
AutoSaveBtn = HeaderIconButton("AutomaticSave", "", 1)
RecentlyDeletedBtn = HeaderIconButton("RecentlyDeleted", "rbxassetid://3926305904", 2)
RecentlyDeletedBtn.ImageRectOffset = Vector2.new(805, 45)
RecentlyDeletedBtn.ImageRectSize = Vector2.new(35, 35)
InsertConfigBtn = HeaderIconButton("InsertConfig", "rbxassetid://101123124881873", 3)
end
local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Position = UDim2.new(0, 12, 0, 50)
SearchContainer.Size = UDim2.new(1, -52, 0, 30)
SearchContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 38)
SearchContainer.BorderSizePixel = 0
SearchContainer.ZIndex = 1000
SearchContainer.Parent = ConfigMainFrame
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = SearchContainer end
do Stroke(SearchContainer) end
local SearchIconImg = Instance.new("ImageLabel")
SearchIconImg.Name = "SearchIcon"
SearchIconImg.AnchorPoint = Vector2.new(0, 0.5)
SearchIconImg.Position = UDim2.new(0, 10, 0.5, 0)
SearchIconImg.Size = UDim2.fromOffset(16, 16)
SearchIconImg.BackgroundTransparency = 1
SearchIconImg.Image = "rbxassetid://6031154871"
SearchIconImg.ImageColor3 = Color3.fromRGB(130, 134, 152)
SearchIconImg.ScaleType = Enum.ScaleType.Fit
SearchIconImg.ZIndex = 1000
SearchIconImg.Parent = SearchContainer
local ConfigSearchBox = Instance.new("TextBox")
ConfigSearchBox.Name = "SearchBox"
ConfigSearchBox.Position = UDim2.new(0, 34, 0, 0)
ConfigSearchBox.Size = UDim2.new(1, -44, 1, 0)
ConfigSearchBox.BackgroundTransparency = 1
ConfigSearchBox.Text = ""
ConfigSearchBox.PlaceholderText = "Search"
ConfigSearchBox.PlaceholderColor3 = Color3.fromRGB(130, 134, 152)
ConfigSearchBox.TextColor3 = Color3.fromRGB(228, 230, 238)
ConfigSearchBox.TextSize = 14
ConfigSearchBox.Font = FONT
ConfigSearchBox.ZIndex = 1000
ConfigSearchBox.TextXAlignment = Enum.TextXAlignment.Left
ConfigSearchBox.ClearTextOnFocus = false
ConfigSearchBox.Parent = SearchContainer
local NameInputContainer = Instance.new("Frame")
NameInputContainer.Name = "NameInputContainer"
NameInputContainer.Position = UDim2.new(0, 12, 0, 50)
NameInputContainer.Size = UDim2.new(1, -52, 0, 30)
NameInputContainer.BackgroundColor3 = Color3.fromRGB(26, 26, 38)
NameInputContainer.BorderSizePixel = 0
NameInputContainer.ZIndex = 1001
NameInputContainer.Visible = false
NameInputContainer.Parent = ConfigMainFrame
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = NameInputContainer end
do Stroke(NameInputContainer) end
local NameOfConfig = Instance.new("TextBox")
NameOfConfig.Name = "NameOfConfig"
NameOfConfig.Position = UDim2.new(0, 12, 0, 0)
NameOfConfig.Size = UDim2.new(1, -96, 1, 0)
NameOfConfig.BackgroundTransparency = 1
NameOfConfig.Text = ""
NameOfConfig.PlaceholderText = "Name or share code..."
NameOfConfig.PlaceholderColor3 = Color3.fromRGB(130, 134, 152)
NameOfConfig.TextColor3 = Color3.fromRGB(228, 230, 238)
NameOfConfig.TextSize = 14
NameOfConfig.Font = FONT
NameOfConfig.ZIndex = 1001
NameOfConfig.TextXAlignment = Enum.TextXAlignment.Left
NameOfConfig.ClearTextOnFocus = false
NameOfConfig.Parent = NameInputContainer
local ConfirmAddBtn = Instance.new("TextButton")
ConfirmAddBtn.Name = "ConfirmAdd"
ConfirmAddBtn.AnchorPoint = Vector2.new(1, 0.5)
ConfirmAddBtn.Position = UDim2.new(1, -14, 0.5, 0)
ConfirmAddBtn.Size = UDim2.new(0, 72, 0, 24)
ConfirmAddBtn.BackgroundColor3 = mainColor
ConfirmAddBtn.BackgroundTransparency = 0.1
ConfirmAddBtn.Text = "Create"
ConfirmAddBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ConfirmAddBtn.TextSize = 12
ConfirmAddBtn.Font = FONT
ConfirmAddBtn.ZIndex = 1002
ConfirmAddBtn.Parent = NameInputContainer
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = ConfirmAddBtn end
local ListContainer = Instance.new("ScrollingFrame")
ListContainer.Name = "ListContainer"
ListContainer.Position = UDim2.new(0, 10, 0, 90)
ListContainer.Size = UDim2.new(1, -16, 1, -98)
ListContainer.BackgroundTransparency = 1
ListContainer.BorderSizePixel = 0
ListContainer.ZIndex = 100
ListContainer.Active = true
ListContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
ListContainer.CanvasSize = UDim2.new()
ListContainer.ScrollingDirection = Enum.ScrollingDirection.Y
ListContainer.ScrollBarThickness = 2
ListContainer.ScrollBarImageColor3 = Color3.fromRGB(110, 112, 124)
ListContainer.ScrollBarImageTransparency = 0.3
ListContainer.Parent = ConfigMainFrame
ListContainer.ClipsDescendants = true
do
local ll = Instance.new("UIListLayout")
ll.Name = "UIListLayout"
ll.Padding = UDim.new(0, 4)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = ListContainer
New("UIPadding", { PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 2), PaddingLeft = UDim.new(0, 2), PaddingBottom = UDim.new(0, 6) }, ListContainer)
end
do
local sortDesc = false
local function applyConfigSort()
local rows = {}
for _, c in ipairs(ListContainer:GetChildren()) do
if c:IsA("Frame") and string.sub(c.Name, 1, 10) == "ConfigRow_" then table.insert(rows, c) end
end
table.sort(rows, function(a, b)
local x, y = string.lower(a.Name), string.lower(b.Name)
if sortDesc then return x > y end
return x < y
end)
for index, row in ipairs(rows) do row.LayoutOrder = index end
end
ListContainer.ChildAdded:Connect(function() task.defer(applyConfigSort) end)
local sortBtn = New("TextButton", {
Name = "SortButton",
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, -10, 0, 50),
Size = UDim2.fromOffset(30, 30),
BackgroundTransparency = 1,
Text = "⇅",
TextColor3 = Color3.fromRGB(150, 154, 166),
TextSize = 17,
AutoButtonColor = false,
ZIndex = 1000,
}, ConfigMainFrame)
sortBtn.MouseEnter:Connect(function() Tween(sortBtn, { TextColor3 = Color3.fromRGB(235, 236, 241) }, 0.1) end)
sortBtn.MouseLeave:Connect(function() Tween(sortBtn, { TextColor3 = Color3.fromRGB(150, 154, 166) }, 0.12) end)
sortBtn.MouseButton1Click:Connect(function()
sortDesc = not sortDesc
applyConfigSort()
end)
end
local Space = Instance.new("Frame")
Space.Name = "Space"
Space.Size = UDim2.new(1, 0, 0, 0)
Space.BackgroundTransparency = 1
Space.ZIndex = 100
Space.Parent = ListContainer
local SAVE_ICON = ""
local LOAD_ICON = "rbxassetid://109698732019071"
local DELETED_FILE = "NightUIDeleted_" .. windowConfigId .. ".json"
local _deletedConfigs = {}
local function LoadDeletedList()
if type(readfile) ~= "function" or type(isfile) ~= "function" then return end
local existsOk, exists = pcall(isfile, DELETED_FILE)
if not existsOk or not exists then return end
local ok, content = pcall(readfile, DELETED_FILE)
if not ok or not content then return end
local dok, data = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), content)
if dok and type(data) == "table" then
local safe = {}
for _, entry in ipairs(data) do
if type(entry) == "table" and type(entry.name) == "string" and type(entry.data) == "table" then
table.insert(safe, {name = SanitizeConfigName(entry.name), data = entry.data})
end
end
while #safe > 20 do table.remove(safe) end
_deletedConfigs = safe
end
end
local function SaveDeletedList()
if type(writefile) ~= "function" then return end
local ok, encoded = pcall(game:GetService("HttpService").JSONEncode, game:GetService("HttpService"), _deletedConfigs)
if ok then pcall(writefile, DELETED_FILE, encoded) end
end
LoadDeletedList()
local RecentlyDeletedPanel = Instance.new("Frame")
RecentlyDeletedPanel.Name = "RecentlyDeletedPanel"
RecentlyDeletedPanel.Position = UDim2.new(0.012, 0, 0.075, 0)
RecentlyDeletedPanel.Size = UDim2.new(0.34, 0, 0.42, 0)
RecentlyDeletedPanel.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
RecentlyDeletedPanel.BackgroundTransparency = 0.045
RecentlyDeletedPanel.BorderSizePixel = 0
RecentlyDeletedPanel.ZIndex = 120
RecentlyDeletedPanel.AutomaticSize = Enum.AutomaticSize.None
RecentlyDeletedPanel.ClipsDescendants = false
RecentlyDeletedPanel.Active = true
RecentlyDeletedPanel.Visible = false
RecentlyDeletedPanel.Parent = Frame2
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = RecentlyDeletedPanel end
do Stroke(RecentlyDeletedPanel) end
AttachShadow(RecentlyDeletedPanel, { radius = 10, layers = 4, step = 1.25, bias = 2 })
local RDHeader = Instance.new("Frame")
RDHeader.Name = "RDHeader"
RDHeader.Size = UDim2.new(1, 0, 0, 46)
RDHeader.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
RDHeader.BorderSizePixel = 0
RDHeader.ClipsDescendants = true
RDHeader.ZIndex = 121
RDHeader.Parent = RecentlyDeletedPanel
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = RDHeader end
do
local rule = Instance.new("Frame")
rule.Name = "HeaderRule"
rule.Position = UDim2.new(0, 14, 1, -1)
rule.Size = UDim2.new(1, -28, 0, 1)
rule.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
rule.BackgroundTransparency = 0.92
rule.BorderSizePixel = 0
rule.ZIndex = 122
rule.Parent = RDHeader
end
local RDTitle = Instance.new("TextLabel")
RDTitle.Name = "RDTitle"
RDTitle.Position = UDim2.new(0, 16, 0, 0)
RDTitle.Size = UDim2.new(1, -130, 1, 0)
RDTitle.BackgroundTransparency = 1
RDTitle.Text = "Recently Deleted"
RDTitle.TextColor3 = Color3.fromRGB(255, 100, 100)
RDTitle.TextSize = 14
RDTitle.Font = FONT
RDTitle.TextXAlignment = Enum.TextXAlignment.Left
RDTitle.ZIndex = 122
RDTitle.Parent = RDHeader
local RDBackBtn = Instance.new("TextButton")
RDBackBtn.Name = "RDBackBtn"
RDBackBtn.AnchorPoint = Vector2.new(1, 0.5)
RDBackBtn.Position = UDim2.new(1, -14, 0.5, 0)
RDBackBtn.Size = UDim2.fromOffset(84, 26)
RDBackBtn.BackgroundColor3 = Color3.fromRGB(28, 31, 44)
RDBackBtn.BackgroundTransparency = 0.1
RDBackBtn.Text = "← Back"
RDBackBtn.TextColor3 = Color3.fromRGB(210, 212, 222)
RDBackBtn.TextSize = 12
RDBackBtn.Font = FONT
RDBackBtn.ZIndex = 122
RDBackBtn.Parent = RDHeader
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = RDBackBtn end
local RDList = Instance.new("ScrollingFrame")
RDList.Name = "RDList"
RDList.Position = UDim2.new(0, 14, 0, 60)
RDList.Size = UDim2.new(1, -28, 1, -74)
RDList.BackgroundTransparency = 1
RDList.BorderSizePixel = 0
RDList.ZIndex = 121
RDList.Active = true
RDList.AutomaticCanvasSize = Enum.AutomaticSize.Y
RDList.CanvasSize = UDim2.new()
RDList.ScrollingDirection = Enum.ScrollingDirection.Y
RDList.ScrollBarThickness = 3
RDList.ScrollBarImageTransparency = 0.35
RDList.Parent = RecentlyDeletedPanel
do local ll = Instance.new("UIListLayout"); ll.Padding = UDim.new(0, 6); ll.Parent = RDList end
RDHeader.Visible = false
RDList.Position = UDim2.fromOffset(8, 8)
RDList.Size = UDim2.new(1, -16, 1, -16)
RDList.ScrollBarThickness = 2
RecentlyDeletedPanel.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
RecentlyDeletedPanel.BackgroundTransparency = 0
local function RefreshDeletedList()
for _, c in ipairs(RDList:GetChildren()) do
if c:IsA("GuiObject") then c:Destroy() end
end
if #_deletedConfigs == 0 then
New("TextLabel", {
Name = "EmptyState", Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1,
Text = "Nothing deleted", TextColor3 = Color3.fromRGB(130, 134, 148), TextSize = 14, ZIndex = 123,
}, RDList)
end
for i = #_deletedConfigs, 1, -1 do
local entry = _deletedConfigs[i]
local drow = New("Frame", {
Name = "DeletedRow", Size = UDim2.new(1, 0, 0, 38), BackgroundColor3 = Color3.fromRGB(21, 21, 29),
BorderSizePixel = 0, ZIndex = 122,
}, RDList)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, drow)
Stroke(drow).Transparency = 0.95
New("TextLabel", {
Name = "DeletedName", Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -80, 1, 0), BackgroundTransparency = 1,
Text = entry.name, TextColor3 = Color3.fromRGB(214, 216, 224), TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 123,
}, drow)
local function iconButton(kind, color, x)
local btn = New("TextButton", {
Name = kind, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, x, 0.5, 0), Size = UDim2.fromOffset(22, 22),
BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = 124,
}, drow)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, btn)
local glyph = New("Frame", { Name = "Glyph", Position = UDim2.fromOffset(4, 4), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, ZIndex = 125 }, btn)
WindowObj._drawGlyph(kind, glyph, color)
btn.MouseEnter:Connect(function() Tween(btn, { BackgroundTransparency = 0.97 }, 0.08) end)
btn.MouseLeave:Connect(function() Tween(btn, { BackgroundTransparency = 1 }, 0.1) end)
return btn
end
local purgeBtn = iconButton("trash", Color3.fromRGB(233, 90, 110), -36)
local restoreBtn = iconButton("restore", Color3.fromRGB(200, 203, 213), -10)
local idx = i
purgeBtn.MouseButton1Click:Connect(function()
table.remove(_deletedConfigs, idx)
SaveDeletedList()
RefreshDeletedList()
end)
restoreBtn.MouseButton1Click:Connect(function()
local restored = false
local encodedOk, encoded = pcall(game:GetService("HttpService").JSONEncode, game:GetService("HttpService"), entry.data)
if encodedOk and type(encoded) == "string" and type(writefile) == "function" then
local writeOk, writeResult = pcall(writefile, GetConfigPath(entry.name), encoded)
restored = writeOk and writeResult ~= false
end
if restored then
table.remove(_deletedConfigs, idx)
SaveDeletedList()
RefreshDeletedList()
end
end)
end
end
local closeConfigPanel
local configOpen = false
RDBackBtn.MouseButton1Click:Connect(function()
UnregisterPopup(RecentlyDeletedPanel)
Tween(RecentlyDeletedPanel, {BackgroundTransparency = 1}, 0.2)
task.delay(0.22, function()
if not configOpen then return end
RecentlyDeletedPanel.Visible = false
ConfigMainFrame.BackgroundTransparency = 1
ConfigMainFrame.Visible = true
ConstrainPopupToMainFrame(ConfigMainFrame); task.defer(function() ConstrainPopupToMainFrame(ConfigMainFrame) end); RegisterPopup(ConfigMainFrame, closeConfigPanel, TriggerSaveConfig)
ConfigScale.Scale = 0.94
Tween(ConfigScale, { Scale = 1 }, 0.16, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(ConfigMainFrame, { BackgroundTransparency = 0.045 }, 0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end)
end)
local activeRow = nil
local activeLoadBtn = nil
activeConfigName = nil
do
local function hoverPlate(parent, position, size)
local plate = New("Frame", {
Name = "HoverPlate", Position = position, Size = size, BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 14,
}, parent)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, plate)
return plate
end
local function bindHover(target, plate)
target.MouseEnter:Connect(function() Tween(plate, { BackgroundTransparency = 0.97 }, 0.1) end)
target.MouseLeave:Connect(function() Tween(plate, { BackgroundTransparency = 1 }, 0.14) end)
end
local savePlate = hoverPlate(WindowObj._saveBox, UDim2.fromOffset(0, 0), UDim2.fromScale(1, 1))
local namePlate = hoverPlate(Save, UDim2.fromOffset(33, 0), UDim2.new(1, -33, 1, 0))
local saveButton = New("TextButton", {
Name = "SaveSegment", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 16,
}, WindowObj._saveBox)
bindHover(saveButton, savePlate)
TriggerSaveConfig.MouseEnter:Connect(function() Tween(namePlate, { BackgroundTransparency = 0.97 }, 0.1) end)
TriggerSaveConfig.MouseLeave:Connect(function() Tween(namePlate, { BackgroundTransparency = 1 }, 0.14) end)
saveButton.MouseButton1Click:Connect(function()
if SaveNamedConfig(activeConfigName or "Default") then
FlashSaved()
end
end)
local presets = { "Global" }
local selectedPreset = "Global"
local globalPlate = hoverPlate(GlobalPreset, UDim2.fromOffset(0, 0), UDim2.fromScale(1, 1))
local globalHit = New("TextButton", {
Name = "GlobalPresetHit", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "", ZIndex = 16,
}, GlobalPreset)
bindHover(globalHit, globalPlate)
local popup = New("Frame", {
Name = "WeaponPresets", Position = UDim2.new(0, 0, 1, 6),
Size = UDim2.fromOffset(230, 0), AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = Color3.fromRGB(18, 18, 27), BorderSizePixel = 0, Visible = false, ZIndex = 120,
}, GlobalPreset)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, popup)
Stroke(popup)
AttachShadow(popup, { radius = 10, layers = 5, step = 1.6, bias = 3 })
New("TextLabel", {
Name = "PlateTitle", Position = UDim2.fromOffset(14, 10), Size = UDim2.new(1, -60, 0, 20), BackgroundTransparency = 1,
Text = "Weapon Presets", TextColor3 = Color3.fromRGB(226, 227, 233), TextSize = 15,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 121,
}, popup)
local addBtn = New("TextButton", {
Name = "AddPreset", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 8), Size = UDim2.fromOffset(24, 24),
BackgroundTransparency = 1, Text = "+", TextColor3 = Color3.fromRGB(200, 203, 213), TextSize = 20, ZIndex = 122,
}, popup)
local list = New("Frame", {
Name = "PresetList", Position = UDim2.fromOffset(10, 38), Size = UDim2.new(1, -20, 0, 0),
AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, ZIndex = 121,
}, popup)
New("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }, list)
New("UIPadding", { PaddingBottom = UDim.new(0, 10) }, list)
local function selectPreset(name)
selectedPreset = name
GlobalPreset.GlobalPresetLabel.Text = name
for _, row in ipairs(list:GetChildren()) do
if row:IsA("TextButton") then
local isSel = row.Text == name
row.BackgroundColor3 = isSel and Color3.fromRGB(27, 27, 35) or Color3.fromRGB(21, 21, 29)
local outline = row:FindFirstChild("RowOutline")
if outline then
outline.Color = isSel and Color3.fromRGB(73, 79, 117) or Color3.fromRGB(255, 255, 255)
outline.Transparency = isSel and 0 or 0.95
end
end
end
if type(WindowObj._onWeaponPreset) == "function" then InvokeCallback(WindowObj._onWeaponPreset, name) end
end
local function addRow(name)
local row = New("TextButton", {
Name = "Preset", Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Color3.fromRGB(21, 21, 29),
AutoButtonColor = false, Text = name, TextColor3 = Color3.fromRGB(214, 216, 224), TextSize = 14,
TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = #list:GetChildren(), ZIndex = 122,
}, list)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, row)
New("UIPadding", { PaddingLeft = UDim.new(0, 12) }, row)
local outline = Instance.new("UIStroke")
outline.Name = "RowOutline"
outline.Color = Color3.fromRGB(255, 255, 255)
outline.Transparency = 0.95
outline.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
outline.Parent = row
row.MouseButton1Click:Connect(function() selectPreset(name) end)
return row
end
for _, name in ipairs(presets) do addRow(name) end
selectPreset(selectedPreset)
addBtn.MouseButton1Click:Connect(function()
local input = New("TextBox", {
Name = "NewPreset", Size = UDim2.new(1, 0, 0, 34), BackgroundColor3 = Color3.fromRGB(26, 26, 38),
Text = "", PlaceholderText = "Preset name", PlaceholderColor3 = Color3.fromRGB(130, 134, 152),
TextColor3 = Color3.fromRGB(228, 230, 238), TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
ClearTextOnFocus = false, LayoutOrder = 9999, ZIndex = 122,
}, list)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, input)
New("UIPadding", { PaddingLeft = UDim.new(0, 12) }, input)
input:CaptureFocus()
input.FocusLost:Connect(function(enter)
local name = tostring(input.Text or ""):gsub("^%s+", ""):gsub("%s+$", "")
input:Destroy()
if enter and name ~= "" and not table.find(presets, name) then
table.insert(presets, name)
addRow(name)
selectPreset(name)
end
end)
end)
local presetsOpen = false
local function closePresets()
presetsOpen = false
UnregisterPopup(popup)
SmoothClose(popup, 0.12)
end
globalHit.MouseButton1Click:Connect(function()
if presetsOpen then closePresets() return end
CloseAllPopupsExcept(popup)
presetsOpen = true
RememberPopupClipping(popup)
ApplyZIndexLadder(popup, NextPopupZ())
SmoothOpen(popup, 0, 0.16)
local scale = popup:FindFirstChild("_PopScale")
if scale then
scale.Scale = 0.92
Tween(scale, { Scale = 1 }, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
RegisterPopup(popup, closePresets, globalHit)
end)
function WindowObj:SetWeaponPresets(names)
for _, row in ipairs(list:GetChildren()) do
if row:IsA("TextButton") then row:Destroy() end
end
presets = {}
for _, name in ipairs(type(names) == "table" and names or { "Global" }) do
table.insert(presets, tostring(name))
addRow(tostring(name))
end
selectPreset(presets[1] or "Global")
return self
end
function WindowObj:OnWeaponPreset(callback)
WindowObj._onWeaponPreset = callback
return self
end
function WindowObj:GetWeaponPreset() return selectedPreset end
end
local function SetActiveConfigName(name)
if type(name) == "string" and name ~= "" and name ~= "Save" then
activeConfigName = name
else
activeConfigName = nil
end
WindowObj._activePresetName = activeConfigName
SaveText.Text = activeConfigName or "Default"
UpdateSavePillWidth(SaveText.Text)
end
WindowObj._autoLoad = function()
if WindowObj._autoLoaded or type(readfile) ~= "function" or type(isfile) ~= "function" then return end
WindowObj._autoLoaded = true
local path = "NightUIConfig_" .. windowConfigId .. "__last.txt"
local okExists, exists = pcall(isfile, path)
if not okExists or not exists then return end
local ok, name = pcall(readfile, path)
if not ok or type(name) ~= "string" or name == "" then return end
if LoadNamedConfig(name) and name ~= "Default" then SetActiveConfigName(name) end
end
local function ClearActiveConfig()
activeRow = nil
activeLoadBtn = nil
SetActiveConfigName(nil)
end
local function DeactivateRow(rowFrame, loadBtn)
Tween(rowFrame, {BackgroundColor3 = Color3.fromRGB(21, 21, 29)}, 0.15)
local outline = rowFrame:FindFirstChild("ConfigRowStroke")
if outline then Tween(outline, { Color = STROKE.Color, Transparency = 0.95 }, 0.15) end
loadBtn.Image = LOAD_ICON
Tween(loadBtn, {ImageColor3 = Color3.fromRGB(128, 132, 146)}, 0.15)
end
local function MakeConfigButton(name)
local row = Instance.new("Frame")
row.Name = "ConfigRow_" .. name
row.Size = UDim2.new(1, 0, 0, 38)
row.BackgroundColor3 = Color3.fromRGB(21, 21, 29)
row.BackgroundTransparency = 0
row.BorderSizePixel = 0
row.ZIndex = 1000
row.Parent = ListContainer
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 8); c.Parent = row end
Stroke(row, "ConfigRowStroke").Transparency = 0.95
row.MouseEnter:Connect(function()
Tween(row, { BackgroundColor3 = Color3.fromRGB(27, 27, 35) }, 0.1, Enum.EasingStyle.Sine)
end)
row.MouseLeave:Connect(function()
Tween(row, { BackgroundColor3 = activeRow == row and Color3.fromRGB(27, 27, 35) or Color3.fromRGB(21, 21, 29) }, 0.13, Enum.EasingStyle.Sine)
end)
local Rename = Instance.new("TextBox")
Rename.Name = "Rename"
Rename.Position = UDim2.new(0, 14, 0, 0)
Rename.Size = UDim2.new(1, -84, 1, 0)
Rename.BackgroundTransparency = 1
Rename.Text = name
Rename.PlaceholderText = "No Name"
Rename.PlaceholderColor3 = Color3.fromRGB(130, 134, 152)
Rename.TextColor3 = Color3.fromRGB(210, 212, 220)
Rename.TextSize = 14
Rename.Font = FONT
Rename.ZIndex = 1000
Rename.TextXAlignment = Enum.TextXAlignment.Left
Rename.TextTruncate = Enum.TextTruncate.AtEnd
Rename.ClearTextOnFocus = false
pcall(function() Rename.ReadOnly = true end)
Rename.Parent = row
local SettingsBtn = Instance.new("TextButton")
SettingsBtn.Name = "Settings"
SettingsBtn.AnchorPoint = Vector2.new(1, 0)
SettingsBtn.Position = UDim2.new(1, -36, 0, 0)
SettingsBtn.Size = UDim2.fromOffset(26, 38)
SettingsBtn.BackgroundTransparency = 1
SettingsBtn.Text = ""
SettingsBtn.ZIndex = 3000
SettingsBtn.Parent = row
do
local dotsIcon = Instance.new("ImageLabel")
dotsIcon.Name = "DotsIcon"
dotsIcon.AnchorPoint = Vector2.new(0.5, 0.5)
dotsIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
dotsIcon.Size = UDim2.fromOffset(14, 14)
dotsIcon.BackgroundTransparency = 1
dotsIcon.Image = "rbxassetid://95127553964880"
dotsIcon.ImageColor3 = Color3.fromRGB(128, 132, 146)
dotsIcon.ScaleType = Enum.ScaleType.Fit
dotsIcon.ZIndex = 3001
dotsIcon.Parent = SettingsBtn
end
local LoadConfigBtn = Instance.new("ImageButton")
LoadConfigBtn.Name = "LoadConfig"
LoadConfigBtn.AnchorPoint = Vector2.new(1, 0.5)
LoadConfigBtn.Position = UDim2.new(1, -12, 0.5, 0)
LoadConfigBtn.Size = UDim2.fromOffset(15, 15)
LoadConfigBtn.BackgroundTransparency = 1
LoadConfigBtn.Image = LOAD_ICON
LoadConfigBtn.ImageColor3 = Color3.fromRGB(128, 132, 146)
LoadConfigBtn.ScaleType = Enum.ScaleType.Fit
LoadConfigBtn.ZIndex = 3000
LoadConfigBtn.Parent = row
local SettingsFrame = Instance.new("Frame")
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Position = UDim2.new(0, 0, 0, 0)
SettingsFrame.Size = UDim2.fromOffset(160, 0)
SettingsFrame.AutomaticSize = Enum.AutomaticSize.Y
SettingsFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 27)
SettingsFrame.BackgroundTransparency = 0
SettingsFrame.BorderSizePixel = 0
SettingsFrame.ZIndex = 6000
SettingsFrame.Visible = false
SettingsFrame.ClipsDescendants = false
SettingsFrame.Active = true
SettingsFrame.Parent = row
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = SettingsFrame end
local SettingsFrameStroke = Stroke(SettingsFrame, "SettingsFrameStroke")
local SettingsFrameItems = Instance.new("Frame")
SettingsFrameItems.Name = "Items"
SettingsFrameItems.Size = UDim2.new(1, 0, 0, 0)
SettingsFrameItems.AutomaticSize = Enum.AutomaticSize.Y
SettingsFrameItems.BackgroundTransparency = 1
SettingsFrameItems.ZIndex = 6001
SettingsFrameItems.Parent = SettingsFrame
do
local ll = Instance.new("UIListLayout")
ll.Padding = UDim.new(0, 1)
ll.SortOrder = Enum.SortOrder.LayoutOrder
ll.Parent = SettingsFrameItems
local pad = Instance.new("UIPadding")
pad.PaddingTop = UDim.new(0, 5); pad.PaddingBottom = UDim.new(0, 5)
pad.PaddingLeft = UDim.new(0, 5); pad.PaddingRight = UDim.new(0, 5)
pad.Parent = SettingsFrameItems
end
AttachShadow(SettingsFrame, { radius = 10, layers = 5, step = 1.6, bias = 3 })
local sfOpen = false
local closeSfRow
local sfOrder = 0
local function MakeSettingBtn(text, textColor, iconKind, callback)
sfOrder = sfOrder + 1
local btn = Instance.new("TextButton")
btn.Name = "MenuItem"
btn.LayoutOrder = sfOrder
btn.Size = UDim2.new(1, 0, 0, 30)
btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
btn.BackgroundTransparency = 1
btn.AutoButtonColor = false
btn.Text = text
btn.TextColor3 = textColor
btn.TextSize = 14
btn.Font = FONT
btn.TextXAlignment = Enum.TextXAlignment.Left
btn.ZIndex = 6002
btn.Parent = SettingsFrameItems
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 6); c.Parent = btn end
do local pad = Instance.new("UIPadding"); pad.PaddingLeft = UDim.new(0, 34); pad.Parent = btn end
local glyph = Instance.new("Frame")
glyph.Name = "Glyph"
glyph.AnchorPoint = Vector2.new(0, 0.5)
glyph.Position = UDim2.new(0, -24, 0.5, 0)
glyph.Size = UDim2.fromOffset(14, 14)
glyph.BackgroundTransparency = 1
glyph.ZIndex = 6003
glyph.Parent = btn
WindowObj._drawGlyph(iconKind, glyph, textColor)
btn.MouseEnter:Connect(function()
Tween(btn, {BackgroundTransparency = 0.97}, 0.1)
end)
btn.MouseLeave:Connect(function()
Tween(btn, {BackgroundTransparency = 1}, 0.12)
end)
btn.MouseButton1Click:Connect(function()
if closeSfRow then closeSfRow() else SettingsFrame.Visible = false end
InvokeCallback(callback)
end)
return btn
end
MakeSettingBtn("Share", Color3.fromRGB(214, 216, 224), "share", function()
local code = WindowObj._makeShareCode and WindowObj._makeShareCode(name)
if code and type(setclipboard) == "function" then
pcall(setclipboard, code)
local before = Rename.Text
Rename.Text = "Share code copied"
task.delay(1.2, function() if Rename.Parent then Rename.Text = before end end)
end
end)
MakeSettingBtn("Duplicate", Color3.fromRGB(214, 216, 224), "copy", function()
local dupName = name .. " (Copy)"
local saved = false
local path = GetConfigPath(name)
if type(readfile) == "function" and type(isfile) == "function" and type(writefile) == "function" then
local existsOk, exists = pcall(isfile, path)
if existsOk then
if exists then
local readOk, content = pcall(readfile, path)
if readOk and type(content) == "string" then
local writeOk, writeResult = pcall(writefile, GetConfigPath(dupName), content)
saved = writeOk and writeResult ~= false
end
else
saved = SaveNamedConfig(dupName)
end
end
else
saved = SaveNamedConfig(dupName)
end
if saved then MakeConfigButton(dupName) end
end)
do
sfOrder = sfOrder + 1
local divider = Instance.new("Frame")
divider.Name = "Divider"
divider.LayoutOrder = sfOrder
divider.Size = UDim2.new(1, -12, 0, 1)
divider.Position = UDim2.fromOffset(6, 0)
divider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
divider.BackgroundTransparency = 0.93
divider.BorderSizePixel = 0
divider.ZIndex = 6002
divider.Parent = SettingsFrameItems
end
MakeSettingBtn("Delete", Color3.fromRGB(233, 90, 110), "trash", function()
local configData = {}
for _, entry in ipairs(_registeredElements) do
local ok, val = pcall(function() return entry.obj:Get() end)
if ok then
local s = SerializeValue(val)
if s ~= nil then configData[entry.key] = s end
end
end
local path = GetConfigPath(name)
if type(readfile) == "function" and type(isfile) == "function" then
local existsOk, exists = pcall(isfile, path)
if existsOk and exists then
local ok2, content = pcall(readfile, path)
if ok2 and type(content) == "string" and #content <= 2097152 then
local dok, data = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), content)
if dok and type(data) == "table" then configData = data end
end
if type(delfile) == "function" then pcall(delfile, path) end
end
end
table.insert(_deletedConfigs, { name = name, data = configData })
if #_deletedConfigs > 20 then table.remove(_deletedConfigs, 1) end
SaveDeletedList()
if activeRow == row then
ClearActiveConfig()
end
row.ClipsDescendants = true
FadePopupContent(row, false, 0.18)
Tween(row, {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
task.delay(0.24, function() row:Destroy() end)
end)
closeSfRow = function()
sfOpen = false
UnregisterPopup(SettingsFrame)
SmoothClose(SettingsFrame, 0.12)
local menuScale = SettingsFrame:FindFirstChild("_PopScale")
if menuScale then Tween(menuScale, { Scale = 0.94 }, 0.12) end
end
SettingsBtn.MouseButton1Click:Connect(function()
sfOpen = not sfOpen
if sfOpen then
CloseAllPopupsExcept(SettingsFrame)
RememberPopupClipping(SettingsFrame)
ForceLiftClipping(SettingsFrame)
ApplyZIndexLadder(SettingsFrame, NextPopupZ())
SettingsFrame.Visible = true
MovePopupToAbsolute(SettingsFrame,
SettingsBtn.AbsolutePosition.X + SettingsBtn.AbsoluteSize.X + 4,
SettingsBtn.AbsolutePosition.Y + 2)
ConstrainPopupToMainFrame(SettingsFrame, 6)
SmoothOpen(SettingsFrame, 0, 0.16)
local menuScale = SettingsFrame:FindFirstChild("_PopScale")
if menuScale then
menuScale.Scale = 0.9
Tween(menuScale, { Scale = 1 }, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
RegisterPopup(SettingsFrame, closeSfRow, SettingsBtn)
else
closeSfRow()
end
end)
local RowOverlay = Instance.new("TextButton")
RowOverlay.Name = "RowOverlay"
RowOverlay.Size = UDim2.new(1, -72, 1, 0)
RowOverlay.BackgroundTransparency = 1
RowOverlay.Text = ""
RowOverlay.ZIndex = 2500
RowOverlay.Parent = row
RowOverlay.MouseButton1Click:Connect(function()
if sfOpen then closeSfRow() end
end)
LoadConfigBtn.MouseButton1Click:Connect(function()
if activeRow == row then
if SaveNamedConfig(name) then WindowObj._savedCheck(LoadConfigBtn) end
else
local loaded = LoadNamedConfig(name)
if not loaded then
Tween(LoadConfigBtn, {ImageColor3 = Color3.fromRGB(255, 80, 80)}, 0.2)
return
end
if activeRow and activeLoadBtn then
DeactivateRow(activeRow, activeLoadBtn)
end
activeRow = row
activeLoadBtn = LoadConfigBtn
SetActiveConfigName(name)
Tween(row, {BackgroundColor3 = Color3.fromRGB(27, 27, 35)}, 0.2)
local outline = row:FindFirstChild("ConfigRowStroke")
if outline then Tween(outline, { Color = Color3.fromRGB(73, 79, 117), Transparency = 0 }, 0.2) end
LoadConfigBtn.Image = SAVE_ICON
Tween(LoadConfigBtn, {ImageColor3 = Color3.fromRGB(205, 208, 218)}, 0.2)
end
end)
local query = string.lower(tostring(ConfigSearchBox.Text or "")):gsub("^%s+", ""):gsub("%s+$", "")
row.Visible = query == "" or string.lower(Rename.Text or ""):find(query, 1, true) ~= nil
if name == activeConfigName then
activeRow = row
activeLoadBtn = LoadConfigBtn
row.BackgroundColor3 = Color3.fromRGB(27, 27, 35)
local outline = row:FindFirstChild("ConfigRowStroke")
if outline then outline.Color = Color3.fromRGB(73, 79, 117); outline.Transparency = 0 end
LoadConfigBtn.Image = SAVE_ICON
LoadConfigBtn.ImageColor3 = Color3.fromRGB(205, 208, 218)
end
return row
end
local function UpdateConfigPanelHeight()
local frame2H = Frame2.AbsoluteSize.Y
local maxH = math.min(400, math.max(104, (frame2H > 0 and frame2H or 480) - 53))
local function countRows(container)
local count = 0
for _, c in ipairs(container:GetChildren()) do
if c:IsA("Frame") and c.Name ~= "Space" and c.Visible then count = count + 1 end
end
return count
end
local cfgH = 106 + math.min(countRows(ListContainer), 7) * 42
local rdH = 16 + math.max(countRows(RDList), 1) * 42
ConfigMainFrame.Size = UDim2.fromOffset(320, math.clamp(cfgH, 104, maxH))
if countRows(ListContainer) <= 7 then ListContainer.CanvasPosition = Vector2.new(0, 0) end
RDList.CanvasPosition = Vector2.new(0, 0)
RecentlyDeletedPanel.Size = UDim2.fromOffset(280, math.clamp(rdH, 54, maxH))
end
ListContainer.ChildAdded:Connect(function() task.defer(UpdateConfigPanelHeight) end)
ListContainer.ChildRemoved:Connect(function() task.defer(UpdateConfigPanelHeight) end)
RDList.ChildAdded:Connect(function() task.defer(UpdateConfigPanelHeight) end)
do
local function liftAndAnimate(panel, list, child)
if not panel.Visible or not child:IsA("GuiObject") then return end
task.defer(function()
if not child.Parent or not panel.Visible then return end
ApplyZIndexLadder(panel, panel.ZIndex)
local openedAt = panel:GetAttribute("NLOpenedAt") or 0
if child:IsA("Frame") and child.Name ~= "Space" and os.clock() - openedAt > 0.35 then
local full = child.Size
child.ClipsDescendants = true
child.Size = UDim2.new(full.X.Scale, full.X.Offset, 0, 0)
Tween(child, { Size = full }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
task.delay(0.24, function() if child.Parent then child.ClipsDescendants = false end end)
end
end)
end
ListContainer.ChildAdded:Connect(function(child) liftAndAnimate(ConfigMainFrame, ListContainer, child) end)
RDList.ChildAdded:Connect(function(child) liftAndAnimate(RecentlyDeletedPanel, RDList, child) end)
end
RDList.ChildRemoved:Connect(function() task.defer(UpdateConfigPanelHeight) end)
local function RefreshConfigList()
activeRow = nil
activeLoadBtn = nil
for _, c in ipairs(ListContainer:GetChildren()) do
if c:IsA("Frame") and c.Name ~= "Space" then c:Destroy() end
end
local list = ListConfigs()
for _, n in ipairs(list) do
MakeConfigButton(n)
end
UpdateConfigPanelHeight()
end
local insertMode = false
InsertConfigBtn.MouseButton1Click:Connect(function()
insertMode = not insertMode
SearchContainer.Visible = not insertMode
NameInputContainer.Visible = insertMode
if insertMode then
InsertConfigBtn:SetAttribute("Pinned", true)
Tween(InsertConfigBtn, {ImageColor3 = mainColor}, 0.2)
task.spawn(function() NameOfConfig:CaptureFocus() end)
else
InsertConfigBtn:SetAttribute("Pinned", false)
Tween(InsertConfigBtn, {ImageColor3 = IDLE_ICON_TINT}, 0.2)
end
end)
ConfirmAddBtn.MouseButton1Click:Connect(function()
local n = NameOfConfig.Text
local imported = WindowObj._importShareCode(n)
if imported then
n = imported
else
if n == "" then n = "Config " .. tostring(#ListContainer:GetChildren()) end
if not SaveNamedConfig(n) then return end
end
NameOfConfig.Text = ""
MakeConfigButton(n)
insertMode = false
SearchContainer.Visible = true
NameInputContainer.Visible = false
Tween(InsertConfigBtn, {ImageColor3 = Color3.fromRGB(200, 200, 220)}, 0.2)
end)
ConfigSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
local query = string.lower(tostring(ConfigSearchBox.Text or "")):gsub("^%s+", ""):gsub("%s+$", "")
for _, c in ipairs(ListContainer:GetChildren()) do
if c:IsA("Frame") and c.Name ~= "Space" then
local rename = c:FindFirstChild("Rename")
if rename then
local name = string.lower(tostring(rename.Text or ""))
c.Visible = query == "" or name:find(query, 1, true) ~= nil
end
end
end
task.defer(UpdateConfigPanelHeight)
end)
local function SaveActiveConfig()
if not autoSaveEnabled then return end
if not activeRow or not activeLoadBtn then return end
local n = activeConfigName
if type(n) ~= "string" or n == "" or n == "Save" then return end
SaveNamedConfig(n)
ShowSavedName()
FlashSaved()
end
AutoSaveBtn.MouseButton1Click:Connect(function()
autoSaveEnabled = not autoSaveEnabled
if autoSaveEnabled then
AutoSaveBtn:SetAttribute("Pinned", true)
Tween(AutoSaveBtn, {ImageColor3 = mainColor}, 0.2)
SaveActiveConfig()
else
AutoSaveBtn:SetAttribute("Pinned", false)
Tween(AutoSaveBtn, {ImageColor3 = IDLE_ICON_TINT}, 0.2)
end
end)
if type(writefile) == "function" then
task.spawn(function()
while true do
task.wait(30)
SaveActiveConfig()
end
end)
end
if LocalPlayer and LocalPlayer.CharacterRemoving then
LocalPlayer.CharacterRemoving:Connect(function()
SaveActiveConfig()
end)
end
do
local function closeDeleted()
UnregisterPopup(RecentlyDeletedPanel)
SmoothClose(RecentlyDeletedPanel, 0.12)
end
RecentlyDeletedBtn.MouseButton1Click:Connect(function()
if RecentlyDeletedPanel.Visible then closeDeleted() return end
RefreshDeletedList()
UpdateConfigPanelHeight()
RecentlyDeletedPanel.Position = UDim2.fromOffset(
ConfigMainFrame.Position.X.Offset + ConfigMainFrame.Size.X.Offset + 8,
ConfigMainFrame.Position.Y.Offset)
ApplyZIndexLadder(RecentlyDeletedPanel, NextPopupZ())
RecentlyDeletedPanel:SetAttribute("NLOpenedAt", os.clock())
RememberPopupClipping(RecentlyDeletedPanel)
SmoothOpen(RecentlyDeletedPanel, 0, 0.16)
local rdScale = GetPopupScale(RecentlyDeletedPanel)
if rdScale then
rdScale.Scale = 0.92
Tween(rdScale, { Scale = 1 }, 0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end
task.defer(function() ConstrainPopupToMainFrame(RecentlyDeletedPanel) end)
RegisterPopup(RecentlyDeletedPanel, closeDeleted, RecentlyDeletedBtn)
end)
end
closeConfigPanel = function()
configOpen = false
ClosePopupsUnder(ConfigMainFrame)
ClosePopupsUnder(RecentlyDeletedPanel)
UnregisterPopup(ConfigMainFrame)
UnregisterPopup(RecentlyDeletedPanel)
Tween(ConfigMainFrame, { BackgroundTransparency = 1 }, 0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
Tween(ConfigScale, { Scale = 0.96 }, 0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
WindowObj._fadeTree(ConfigMainFrame, false, 0.16)
Tween(RecentlyDeletedPanel, { BackgroundTransparency = 1 }, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local rdScale = RecentlyDeletedPanel:FindFirstChild("_PopScale")
if rdScale and rdScale:IsA("UIScale") then Tween(rdScale, { Scale = 0.94 }, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.In) end
task.delay(0.22, function()
if configOpen then return end
ConfigMainFrame.Visible = false
RecentlyDeletedPanel.Visible = false
end)
end
TriggerSaveConfig.MouseButton1Click:Connect(function()
configOpen = not configOpen
if configOpen then
CloseAllPopupsExcept(ConfigMainFrame)
RecentlyDeletedPanel.Visible = false
WindowObj._fadeTree(ConfigMainFrame, true, 0)
RefreshConfigList()
WindowObj._fadeTree(ConfigMainFrame, false, 0)
ConfigMainFrame.BackgroundTransparency = 1
ConfigMainFrame.Visible = false
ConfigMainFrame.ZIndex = 7000
ApplyZIndexLadder(ConfigMainFrame, NextPopupZ())
ConstrainPopupToMainFrame(ConfigMainFrame); task.defer(function() ConstrainPopupToMainFrame(ConfigMainFrame) end); RegisterPopup(ConfigMainFrame, closeConfigPanel, TriggerSaveConfig)
task.delay(0.26, function()
if not ConfigMainFrame.Visible then return end
local safe = PopupSafeArea()
local w = ConfigMainFrame.AbsoluteSize.X
if w > 0 and safe.X > 0 and w > safe.X - 12 then
ConfigScale.Scale = math.max(0.5, (safe.X - 12) / w)
end
end)
ConfigMainFrame.Visible = true
ConfigMainFrame:SetAttribute("NLOpenedAt", os.clock())
ConfigScale.Scale = 0.95
Tween(ConfigScale, { Scale = 1 }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
WindowObj._fadeTree(ConfigMainFrame, true, 0.22)
Tween(ConfigMainFrame, { BackgroundTransparency = 0.045 }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local cfgSettled = ConfigMainFrame.Position
ConfigMainFrame.Position = UDim2.new(cfgSettled.X.Scale, cfgSettled.X.Offset, cfgSettled.Y.Scale, cfgSettled.Y.Offset - 6)
Tween(ConfigMainFrame, { Position = cfgSettled }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
else
closeConfigPanel()
end
end)
local SearchBox = New("TextBox", {
Name = "SearchBox",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -11, 0.5, 0),
Size = UDim2.new(0, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(0, 0, 0),
Text = "",
PlaceholderText = "Search",
PlaceholderColor3 = Color3.fromRGB(130, 134, 152),
TextColor3 = Color3.fromRGB(228, 230, 238),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0.05,
Visible = false,
TextXAlignment = Enum.TextXAlignment.Left,
ClipsDescendants = true,
ZIndex = 20,
}, Header)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, SearchBox)
Stroke(SearchBox)
New("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 36) }, SearchBox)
SearchBtn.ZIndex = 22
New("TextLabel", {
Name = "CloseGlyph",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.5, 0),
Size = UDim2.fromScale(1, 1),
BackgroundTransparency = 1,
Text = "×",
TextColor3 = Color3.fromRGB(200, 204, 218),
TextSize = 22,
Visible = false,
ZIndex = 23,
}, SearchBtn)
local ApplySearch
local searchOpen = false
local searchTransitionToken = 0
SearchBtn.MouseButton1Click:Connect(function()
searchOpen = not searchOpen
searchTransitionToken = searchTransitionToken + 1
local token = searchTransitionToken
SearchBtn.ImageTransparency = searchOpen and 1 or 0.2
SearchBtn.CloseGlyph.Visible = searchOpen
if searchOpen then
SearchBox.Visible = true
SearchBox.BackgroundTransparency = 1
SearchBox.Size = UDim2.new(0, 0, 0, 34)
Tween(SearchBox, { BackgroundTransparency = 0 }, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
Tween(SearchBox, { Size = UDim2.new(1, -22, 0, 34) }, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
task.delay(0.16, function()
if searchOpen and searchTransitionToken == token and SearchBox.Visible then pcall(function() SearchBox:CaptureFocus() end) end
end)
else
pcall(function() SearchBox:ReleaseFocus() end)
Tween(SearchBox, { Size = UDim2.new(0, 0, 0, 34), BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
task.delay(0.13, function()
if searchOpen or searchTransitionToken ~= token then return end
SearchBox.Visible = false
SearchBox.Text = ""
if ApplySearch then ApplySearch("") end
end)
end
end)
local TabHose = New("Frame", {
Name = "TabHose",
Position = UDim2.new(0, 11, 0, 61),
Size = UDim2.new(1, -22, 1, -71),
BackgroundColor3 = Color3.fromRGB(162, 162, 161),
BackgroundTransparency = 1,
ClipsDescendants = false,
}, Frame2)
New("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
Padding = UDim.new(0, 12),
SortOrder = Enum.SortOrder.LayoutOrder,
}, TabHose)
local SubTabHose = New("Frame", {
Name = "SubTabHose",
Position = UDim2.new(0, 11, 0, 61),
Size = UDim2.new(1, -22, 1, -71),
BackgroundColor3 = Color3.fromRGB(162, 162, 161),
BackgroundTransparency = 1,
ClipsDescendants = false,
}, Frame2)
New("UIListLayout", {
FillDirection = Enum.FillDirection.Horizontal,
Padding = UDim.new(0, 12),
SortOrder = Enum.SortOrder.LayoutOrder,
}, SubTabHose)
New("TextLabel", {
Name = "SearchEmptyState",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, 0, 0.54, 0),
Size = UDim2.new(0.72, 0, 0, 44),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text = "NO MATCHING SETTINGS",
TextColor3 = Color3.fromRGB(126, 133, 154),
TextSize = 12,
Font = FONT,
TextWrapped = true,
TextXAlignment = Enum.TextXAlignment.Center,
TextYAlignment = Enum.TextYAlignment.Center,
Visible = false,
Active = false,
ZIndex = 5,
}, Frame2)
local function GetSearchText(object)
local pieces = {}
if not object then return "" end
if object:IsA("TextLabel") or object:IsA("TextButton") or object:IsA("TextBox") then
table.insert(pieces, object.Text or "")
end
local ok, descendants = pcall(function() return object:GetDescendants() end)
if ok then
for _, child in ipairs(descendants) do
if child:IsA("TextLabel") or child:IsA("TextButton") or child:IsA("TextBox") then
local childName = string.lower(child.Name)
if childName == "text" or childName == "texttoggle" or childName == "textdefault" or childName == "label" or childName == "textdropdown" then
table.insert(pieces, child.Text or "")
end
end
end
end
return string.lower(table.concat(pieces, " "))
end
local function IsSearchColumnActive(column)
local tabIndex = column:GetAttribute("TabIndex")
if tabIndex ~= activeTabIndex then return false end
local tab = tabs[tabIndex]
if not tab then return false end
local subTabIndex = column:GetAttribute("SubTabIndex")
if tab.activeSubTabIndex ~= nil then return subTabIndex == tab.activeSubTabIndex end
return subTabIndex == nil
end
local function SearchMatches(haystack, query)
haystack = string.lower(tostring(haystack or ""))
query = string.lower(tostring(query or "")):gsub("^%s+", ""):gsub("%s+$", "")
if query == "" then return true end
for word in query:gmatch("%S+") do
if not haystack:find(word, 1, true) then return false end
end
return true
end
local function ColumnHasSearchMatch(column, query)
if not column or query == "" then return query == "" end
for _, section in ipairs(column:GetChildren()) do
if section:IsA("Frame") and section.Name == "Section" then
local elementsFrame = section:FindFirstChild("Elements")
local sectionLabel = section:FindFirstChild("SectionLabel", true) or section:FindFirstChild("SectionTitle", true)
if sectionLabel and SearchMatches(GetSearchText(sectionLabel), query) then return true end
if elementsFrame then
for _, element in ipairs(elementsFrame:GetChildren()) do
if element:IsA("GuiObject") then
local baseVisible = element:GetAttribute("NLSearchBaseVisible")
if baseVisible == nil then baseVisible = element.Visible end
if baseVisible and SearchMatches(GetSearchText(element), query) then return true end
end
end
end
end
end
return false
end
local function FindSearchTarget(query)
if query == "" then return nil, nil, false end
for _, holder in ipairs({ TabHose, SubTabHose }) do
for _, column in ipairs(holder:GetChildren()) do
if column:IsA("ScrollingFrame")
and column:GetAttribute("TabIndex") == activeTabIndex
and IsSearchColumnActive(column)
and ColumnHasSearchMatch(column, query) then
return activeTabIndex, holder == SubTabHose and column:GetAttribute("SubTabIndex") or nil, false
end
end
end
for _, holder in ipairs({ TabHose, SubTabHose }) do
for _, column in ipairs(holder:GetChildren()) do
if column:IsA("ScrollingFrame") and ColumnHasSearchMatch(column, query) then
return column:GetAttribute("TabIndex"), holder == SubTabHose and column:GetAttribute("SubTabIndex") or nil, false
end
end
end
for _, tab in ipairs(tabs) do
if SearchMatches(tab.name, query) then return tab.tabIndex, nil, true end
for _, subtab in ipairs(tab.subTabs or {}) do
if SearchMatches(subtab.name, query) then return tab.tabIndex, subtab.index, true end
end
end
return nil, nil, false
end
local function _applySearchImpl(query)
query = string.lower(tostring(query or "")):gsub("^%s+", ""):gsub("%s+$", "")
local targetTab, targetSubTab, navOnly
if query ~= "" then
targetTab, targetSubTab, navOnly = FindSearchTarget(query)
if navOnly and targetTab == activeTabIndex then query = "" end
end
local columnHasMatch = false
for _, holder in ipairs({ TabHose, SubTabHose }) do
for _, column in ipairs(holder:GetChildren()) do
if column:IsA("ScrollingFrame") and (column.Name == "Left" or column.Name == "Right" or string.sub(column.Name, 1, 6) == "STLeft" or string.sub(column.Name, 1, 7) == "STRight") then
local activeColumn = IsSearchColumnActive(column)
if not activeColumn then
column.Visible = false
else
local columnMatch = query == ""
for _, section in ipairs(column:GetChildren()) do
if section:IsA("Frame") and section.Name == "Section" then
local elementsFrame = section:FindFirstChild("Elements")
local sectionLabel = section:FindFirstChild("SectionLabel", true) or section:FindFirstChild("SectionTitle", true)
local sectionText = sectionLabel and GetSearchText(sectionLabel) or ""
local sectionBaseVisible = section:GetAttribute("NLSearchBaseVisible")
if sectionBaseVisible == nil then
sectionBaseVisible = section.Visible
section:SetAttribute("NLSearchBaseVisible", sectionBaseVisible)
end
local sectionMatch = query == "" or SearchMatches(sectionText, query)
local anyVisible = false
if elementsFrame then
local elementsBaseVisible = elementsFrame:GetAttribute("NLSearchBaseVisible")
if elementsBaseVisible == nil then
elementsBaseVisible = elementsFrame.Visible
elementsFrame:SetAttribute("NLSearchBaseVisible", elementsBaseVisible)
end
for _, element in ipairs(elementsFrame:GetChildren()) do
if element:IsA("GuiObject") then
local baseVisible = element:GetAttribute("NLSearchBaseVisible")
if baseVisible == nil then
baseVisible = element.Visible
element:SetAttribute("NLSearchBaseVisible", baseVisible)
end
local elementText = GetSearchText(element)
local matches = baseVisible and (query == "" or sectionMatch or SearchMatches(elementText, query))
element.Visible = matches
if matches then anyVisible = true end
end
end
elementsFrame.Visible = elementsBaseVisible and anyVisible and (query ~= "" or not elementsFrame:GetAttribute("NLCollapsed"))
end
if sectionLabel then
local labelBaseVisible = sectionLabel:GetAttribute("NLSearchBaseVisible")
if labelBaseVisible == nil then
labelBaseVisible = sectionLabel.Visible
sectionLabel:SetAttribute("NLSearchBaseVisible", labelBaseVisible)
end
sectionLabel.Visible = labelBaseVisible and anyVisible
end
section.Visible = sectionBaseVisible and anyVisible
if anyVisible then columnMatch = true end
end
end
column.Visible = columnMatch
if columnMatch and query ~= "" then columnHasMatch = true end
end
end
end
end
for _, row in ipairs(Tab:GetChildren()) do
if row.Name == "TabButton" then
local label = row:FindFirstChild("TabText")
local matches = query == "" or (label and SearchMatches(label.Text, query)) or false
if not matches and query ~= "" then
local rowTabIndex = row:GetAttribute("TabIndex")
for _, holder in ipairs({ TabHose, SubTabHose }) do
for _, column in ipairs(holder:GetChildren()) do
if column:IsA("ScrollingFrame") and column:GetAttribute("TabIndex") == rowTabIndex and ColumnHasSearchMatch(column, query) then
matches = true; break
end
end
if matches then break end
end
end
row.Visible = matches
local searchIndicator = row:FindFirstChild("SelectedIndicator")
if searchIndicator and row:GetAttribute("TabIndex") ~= activeTabIndex then
local matchedRail = query ~= "" and matches
Tween(searchIndicator, { BackgroundTransparency = matchedRail and 0.42 or 1 }, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
elseif row.Name == "SubTabContainer" then
if row:GetAttribute("TabIndex") ~= activeTabIndex then
row.Visible = false
else
local anyVisible = false
for _, child in ipairs(row:GetChildren()) do
if child:IsA("Frame") and string.sub(child.Name, 1, 6) == "STRow" then
local label = child:FindFirstChild("STLabel")
local matches = query == "" or (label and SearchMatches(label.Text, query)) or false
if not matches and query ~= "" then
local rowTabIndex = child:GetAttribute("TabIndex")
local rowSubTabIndex = child:GetAttribute("SubTabIndex")
for _, column in ipairs(SubTabHose:GetChildren()) do
if column:IsA("ScrollingFrame") and column:GetAttribute("TabIndex") == rowTabIndex and column:GetAttribute("SubTabIndex") == rowSubTabIndex and ColumnHasSearchMatch(column, query) then
matches = true; break
end
end
end
child.Visible = matches
local subtabIndex = child:GetAttribute("SubTabIndex")
local selectedSubtab = row:GetAttribute("TabIndex") == activeTabIndex and tabs[activeTabIndex] and tabs[activeTabIndex].activeSubTabIndex == subtabIndex
local searchIndicator = child:FindFirstChild("SelectedIndicator")
if searchIndicator and not selectedSubtab then
local matchedRail = query ~= "" and matches
Tween(searchIndicator, { BackgroundTransparency = matchedRail and 0.42 or 1 }, 0.12, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
if matches then anyVisible = true end
end
end
row.Visible = query == "" or anyVisible
end
end
end
local emptyState = Frame2:FindFirstChild("SearchEmptyState")
if emptyState and emptyState:IsA("TextLabel") then
if query == "" or columnHasMatch then
emptyState.Visible = false
else
if targetTab and tabs[targetTab] then
if targetSubTab and tabs[targetTab].subTabs and tabs[targetTab].subTabs[targetSubTab] then
emptyState.Text = "MATCH IN " .. string.upper(tostring(tabs[targetTab].name)) .. " / " .. string.upper(tostring(tabs[targetTab].subTabs[targetSubTab].name)) .. "\nSELECT THE HIGHLIGHTED TAB"
else
emptyState.Text = "MATCH IN " .. string.upper(tostring(tabs[targetTab].name)) .. "\nSELECT THE HIGHLIGHTED TAB"
end
else
emptyState.Text = "NO MATCHING SETTINGS"
end
emptyState.Visible = true
end
end
return columnHasMatch
end
ApplySearch = _applySearchImpl
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
SearchBox:SetAttribute("SearchApplyToken", (SearchBox:GetAttribute("SearchApplyToken") or 0) + 1)
local token = SearchBox:GetAttribute("SearchApplyToken")
task.delay(0.075, function()
if SearchBox.Parent and SearchBox:GetAttribute("SearchApplyToken") == token and ApplySearch then
ApplySearch(SearchBox.Text)
end
end)
end)
WindowObj._setupWindowToggle = function()
local Line9 = Instance.new('Frame')
Line9.Name = "Line9"
Line9.Position = UDim2.new(0.008, 0, 0, 53)
Line9.Size = UDim2.new(0.222, 0, 0, 1)
Line9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Line9.BackgroundTransparency = 0.93
Line9.BorderSizePixel = 0
Line9.Parent = MainFrame
Line9.Visible = false
MakeDraggable(MainFrame, DragHandle)
WindowObj._configExtras.pos_menu = {
get = function()
local pos, size = MainFrame.Position, windowTargetSize
return { pos.X.Scale, pos.X.Offset, pos.Y.Scale, pos.Y.Offset, size.X.Scale, size.X.Offset, size.Y.Scale, size.Y.Offset }
end,
set = function(v)
if type(v) ~= "table" or type(v[4]) ~= "number" then return end
MainFrame.Position = UDim2.new(v[1], v[2], v[3], v[4])
if type(v[8]) == "number" then
windowTargetSize = UDim2.new(v[5], v[6], v[7], v[8])
MainFrame.Size = windowTargetSize
end
end,
}
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.AnchorPoint = Vector2.new(0.5, 0.5)
ToggleBtn.Position = UDim2.new(0.88, 0, 0.78, 0)
ToggleBtn.BackgroundTransparency = 0.06
ToggleBtn.Active = true
ToggleBtn.Draggable = false
ToggleBtn.Size = UDim2.fromOffset(54, 54)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Text = "×"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextScaled = false
ToggleBtn.TextSize = 28
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.AutoButtonColor = true
ToggleBtn.ZIndex = 999
ToggleBtn.Parent = NightUICS2
do
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(1, 0)
c.Parent = ToggleBtn
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.72
stroke.Thickness = 1
stroke.Parent = ToggleBtn
end
WindowObj._toggleBtn = ToggleBtn
local _uis = game:GetService("UserInputService")
local _ok, _touch = pcall(function() return _uis.TouchEnabled end)
if _ok and _touch then
ToggleBtn.Visible = true
else
ToggleBtn.Visible = false
end

-- The floating phone button can be moved with a finger and stays inside the screen.
local toggleDragging, toggleMoved = false, false
local toggleDragInput, toggleStartPointer, toggleStartPosition
ToggleBtn.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
toggleDragging = true
toggleMoved = false
toggleDragInput = input
toggleStartPointer = input.Position
toggleStartPosition = ToggleBtn.Position
end
end)
_uis.InputChanged:Connect(function(input)
if not toggleDragging then return end
if input == toggleDragInput or input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
local delta = input.Position - toggleStartPointer
if math.abs(delta.X) + math.abs(delta.Y) > 8 then toggleMoved = true end
if toggleMoved then
local camera = workspace.CurrentCamera
local viewport = camera and camera.ViewportSize
if viewport then
local x = toggleStartPosition.X.Scale * viewport.X + toggleStartPosition.X.Offset + delta.X
local y = toggleStartPosition.Y.Scale * viewport.Y + toggleStartPosition.Y.Offset + delta.Y
local halfX, halfY = ToggleBtn.AbsoluteSize.X / 2, ToggleBtn.AbsoluteSize.Y / 2
x = math.clamp(x, halfX + 4, viewport.X - halfX - 4)
y = math.clamp(y, halfY + 4, viewport.Y - halfY - 4)
ToggleBtn.Position = UDim2.fromOffset(x, y)
end
end
end
end)
_uis.InputEnded:Connect(function(input)
if toggleDragging and (input == toggleDragInput or input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1) then
toggleDragging = false
toggleDragInput = nil
end
end)
local guiOpen = true
WindowObj._fadeTree = function(root, show, dur)
if show == (root:GetAttribute("TreeFaded") ~= true) then return end
root:SetAttribute("TreeFaded", not show)
local info = TweenInfo.new(dur, Enum.EasingStyle.Sine, show and Enum.EasingDirection.Out or Enum.EasingDirection.In)
for _, d in ipairs(root:GetDescendants()) do
local props
if d:IsA("GuiObject") then
props = { "BackgroundTransparency" }
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then table.insert(props, "TextTransparency") end
if d:IsA("ImageLabel") or d:IsA("ImageButton") or d:IsA("ViewportFrame") then table.insert(props, "ImageTransparency") end
elseif d:IsA("UIStroke") then
props = { "Transparency" }
end
if props then
local goal
for _, prop in ipairs(props) do
local key = "FB_" .. root.Name .. "_" .. prop
if show then
local base = d:GetAttribute(key)
if base ~= nil then
goal = goal or {}
goal[prop] = base
d:SetAttribute(key, nil)
end
elseif d[prop] < 1 then
d:SetAttribute(key, d[prop])
goal = goal or {}
goal[prop] = 1
end
end
if goal then TweenService:Create(d, info, goal):Play() end
end
end
end
WindowObj._fadeColumn = function(column)
if MainFrame:GetAttribute("TreeFaded") then return end
WindowObj._fadeTree(column, true, 0)
WindowObj._fadeTree(column, false, 0)
WindowObj._fadeTree(column, true, 0.2)
end
local function AnimateWindow(open)
local dur = open and 0.3 or 0.2
local part = AcrylicBlur and AcrylicBlur.Instances and AcrylicBlur.Instances.Part
local dof = AcrylicBlur and AcrylicBlur.Instances and AcrylicBlur.Instances.DepthOfField
WindowObj._menuOpen = open
if WindowObj.KeybindList then pcall(WindowObj.KeybindList.refresh) end
if WindowObj.SpectatorList then pcall(WindowObj.SpectatorList.refresh) end
if open then
local rest = WindowObj._menuRestPos or MainFrame.Position
WindowObj._menuRestPos = nil
MainFrame.Position = UDim2.new(rest.X.Scale, rest.X.Offset, rest.Y.Scale, rest.Y.Offset + 14)
Tween(MainFrame, { Position = rest }, dur, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
MainFrame.Visible = true
WindowObj._fadeTree(MainFrame, true, dur)
MainFrame.BackgroundTransparency = 1
MainFrame.Size = windowAnimSize
Tween(MainFrame, { BackgroundTransparency = 0.25 }, dur, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Tween(MainFrame, { Size = windowTargetSize }, dur, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
else
local rest = WindowObj._menuRestPos or MainFrame.Position
WindowObj._menuRestPos = rest
Tween(MainFrame, { Position = UDim2.new(rest.X.Scale, rest.X.Offset, rest.Y.Scale, rest.Y.Offset + 10) }, dur, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
WindowObj._fadeTree(MainFrame, false, dur)
Tween(MainFrame, { BackgroundTransparency = 1 }, dur, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
Tween(MainFrame, { Size = windowAnimSize }, dur, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
task.delay(dur + 0.02, function()
if guiOpen then return end
HideAllPopupsNow(true)
if ConfigMainFrame then ConfigMainFrame.Visible = false end
if WindowSettingsFrame then WindowSettingsFrame.Visible = false end
if Save then Save.Visible = false end
if RecentlyDeletedPanel then RecentlyDeletedPanel.Visible = false end
MainFrame.Visible = false
MainFrame.Size = windowTargetSize
if WindowObj._menuRestPos then MainFrame.Position = WindowObj._menuRestPos end
if part then part.Transparency = 1 end
if dof and #WindowObj._blurs == 0 then dof.Enabled = false end
end)
end
if part then
local target = open and (part:GetAttribute("TargetTransparency") or 0.8) or 1
Tween(part, { Transparency = target }, dur)
end
if dof then dof.Enabled = open or #WindowObj._blurs > 0 end
end
AcrylicBlur.toggleGui = function()
guiOpen = not guiOpen
do
local _uis2 = game:GetService("UserInputService")
local _ok2, _touch2 = pcall(function() return _uis2.TouchEnabled end)
if _ok2 and _touch2 then
ToggleBtn.Text = guiOpen and "×" or "☰"
else
ToggleBtn.Text = guiOpen and "Close [RShift]" or "Open  [RShift]"
end
end
Tween(ToggleBtn, {
BackgroundColor3 = guiOpen and Color3.fromRGB(17, 19, 27) or Color3.fromRGB(33,37,53)
}, 0.1)
if guiOpen then
if Save then Save.Visible = true end
if AcrylicBlur.Signal then
pcall(function() AcrylicBlur.Signal:Disconnect() end)
AcrylicBlur.Signal = nil
end
AcrylicBlur.Signal = game:GetService("RunService").RenderStepped:Connect(AcrylicBlur.Update)
else
if AcrylicBlur.Signal then
AcrylicBlur.Signal:Disconnect()
AcrylicBlur.Signal = nil
end
end
AnimateWindow(guiOpen)
end
ToggleBtn.MouseButton1Click:Connect(function()
if toggleMoved then
toggleMoved = false
return
end
AcrylicBlur.toggleGui()
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if menuBind and input.KeyCode == menuBind then
local focused = UserInputService:GetFocusedTextBox()
if focused then pcall(focused.ReleaseFocus, focused) end
AcrylicBlur.toggleGui()
return
end
if gameProcessed then return end
end)
if false and Library.ShowLoader ~= false then
guiOpen = false
MainFrame.Visible = false
local part = AcrylicBlur.Instances and AcrylicBlur.Instances.Part
if part then part.Transparency = 1 end
if AcrylicBlur.Instances and AcrylicBlur.Instances.DepthOfField then AcrylicBlur.Instances.DepthOfField.Enabled = false end
else
if not AcrylicBlur.Signal then
AcrylicBlur.Signal = game:GetService("RunService").RenderStepped:Connect(AcrylicBlur.Update)
end
MainFrame.BackgroundTransparency = 1
Tween(MainFrame, { BackgroundTransparency = 0.25 }, 0.18)
end
end
WindowObj._setupWindowToggle()
WindowObj._setupWindowToggle = nil
if false and Library.ShowLoader ~= false then task.spawn(function()
local toast = New("Frame", {
Name = "NightCCUILoader",
AnchorPoint = Vector2.new(1, 0),
Position = UDim2.new(1, 360, 0, 8 - (WindowObj._topInset or 0)),
Size = UDim2.fromOffset(320, 60),
BackgroundColor3 = Color3.fromRGB(8, 9, 12),
BackgroundTransparency = 0.3,
BorderSizePixel = 0,
ZIndex = Z_BASE + 990,
}, NightUICS2)
New("UICorner", { CornerRadius = UDim.new(0, 18) }, toast)
if WindowObj._attachBlur then WindowObj._attachBlur(toast, 8) end
local glowGradients = {}
for i = 1, 10 do
local spread = i * 2
local layer = New("Frame", {
Name = "LoaderGlow" .. i, Position = UDim2.fromOffset(-spread, -spread), Size = UDim2.new(1, spread * 2, 1, spread * 2),
BackgroundColor3 = mainColor, BackgroundTransparency = 0.72 + i * 0.026, BorderSizePixel = 0, ZIndex = Z_BASE + 989 - i,
}, toast)
New("UICorner", { CornerRadius = UDim.new(0, 18 + spread) }, layer)
local g = Instance.new("UIGradient")
g.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.5, 0.45), NumberSequenceKeypoint.new(1, 0.85),
})
g.Rotation = 120
g.Parent = layer
table.insert(glowGradients, g)
end
task.spawn(function()
local angle = 120
while toast.Parent do
local dt = RunService.RenderStepped:Wait()
angle = (angle + dt * 90) % 360
for _, g in ipairs(glowGradients) do g.Rotation = angle end
end
end)
local badge = New("Frame", {
Name = "Badge", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0),
Size = UDim2.fromOffset(38, 38), BackgroundColor3 = Color3.fromRGB(14, 17, 30), BorderSizePixel = 0, ZIndex = Z_BASE + 991,
}, toast)
New("UICorner", { CornerRadius = UDim.new(0, 11) }, badge)
if hubImage ~= "" then
local badgeLogo = New("ImageLabel", {
Name = "BadgeLogo", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
Image = hubImage, ScaleType = Enum.ScaleType.Stretch, ZIndex = Z_BASE + 992,
}, badge)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, badgeLogo)
else
WindowObj._logoWithFallback(badge, 17, Z_BASE + 992, 11)
end
New("TextLabel", {
Name = "LoaderTitle", Position = UDim2.fromOffset(60, 11), Size = UDim2.new(1, -140, 0, 20), BackgroundTransparency = 1,
Text = tostring(hubTitle), TextColor3 = Color3.fromRGB(240, 241, 246), TextSize = 16, Font = FONT_BOLD,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = Z_BASE + 991,
}, toast)
local status = New("TextLabel", {
Name = "LoaderStatus", Position = UDim2.fromOffset(60, 31), Size = UDim2.new(1, -84, 0, 16), BackgroundTransparency = 1,
Text = "Initialization in progress", TextColor3 = Color3.fromRGB(160, 162, 172), TextSize = 13,
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = Z_BASE + 991,
}, toast)
local counter = New("TextLabel", {
Name = "LoaderCounter", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -24, 0, 11), Size = UDim2.fromOffset(70, 20),
BackgroundTransparency = 1, Text = "0 of 10", TextColor3 = Color3.fromRGB(225, 227, 234), TextSize = 14, Font = FONT_BOLD,
TextXAlignment = Enum.TextXAlignment.Right, ZIndex = Z_BASE + 991,
}, toast)
counter.Font = FONT_BOLD
WindowObj._loaderActive = true
local watermarkFrame = WindowObj.Watermark and WindowObj.Watermark.frame
if watermarkFrame then watermarkFrame.Visible = false end
if WindowObj._toggleBtn then WindowObj._toggleBtn.Visible = false end
do
local done = false
task.spawn(function()
pcall(function() game:GetService("ContentProvider"):PreloadAsync(badge:GetDescendants()) end)
done = true
end)
local waited = 0
while not done and waited < 1.5 do waited = waited + task.wait() end
end
WindowObj._fadeTree(toast, false, 0)
local toastAlpha = toast.BackgroundTransparency
toast.BackgroundTransparency = 1
Tween(toast, { Position = UDim2.new(1, -8, 0, 8 - (WindowObj._topInset or 0)), BackgroundTransparency = toastAlpha }, 0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
WindowObj._fadeTree(toast, true, 0.4)
do
local seen, assets = {}, {}
for _, d in ipairs(NightUICS2:GetDescendants()) do
if (d:IsA("ImageLabel") or d:IsA("ImageButton")) and d.Image ~= "" and not seen[d.Image] then
seen[d.Image] = true
table.insert(assets, d)
end
end
local stepNames = { "Loading interface", "Loading icons", "Loading icons", "Loading icons", "Loading images",
"Loading images", "Loading avatar", "Loading fonts", "Loading configs", "Finishing" }
local per = math.max(1, math.ceil(#assets / 8))
local ContentProvider = game:GetService("ContentProvider")
for step = 1, 10 do
status.Text = stepNames[step] .. "..."
local started = os.clock()
if step <= 8 then
local batch = {}
for i = (step - 1) * per + 1, math.min(step * per, #assets) do table.insert(batch, assets[i]) end
if #batch > 0 then pcall(function() ContentProvider:PreloadAsync(batch) end) end
elseif step == 9 and type(listfiles) == "function" then
pcall(listfiles, "")
end
local left = 0.12 - (os.clock() - started)
if left > 0 then task.wait(left) end
counter.Text = tostring(step) .. " of 10"
end
end
status.Text = "Initialization complete"
task.wait(0.5)
if AcrylicBlur.toggleGui then AcrylicBlur.toggleGui() end
WindowObj._loaderActive = false
if WindowObj._autoLoad then task.defer(WindowObj._autoLoad) end
if watermarkFrame and WindowObj.Watermark.applyLayout then WindowObj.Watermark.applyLayout(nil, nil) end
if WindowObj.KeybindList then WindowObj.KeybindList.refresh() end
if WindowObj.SpectatorList then WindowObj.SpectatorList.refresh() end
task.wait(0.8)
Tween(toast, { Position = UDim2.new(1, 380, 0, 8 - (WindowObj._topInset or 0)), BackgroundTransparency = 1 }, 0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
WindowObj._fadeTree(toast, false, 0.3)
task.wait(0.42)
toast:Destroy()
end) end
function WindowObj:AddTabLabel(text)
text = tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", "")
local hasPreviousCategory = false
for _, child in ipairs(Tab:GetChildren()) do
if child:IsA("TextLabel") and child.Name == "TabLabel" then
hasPreviousCategory = true
break
end
end
if hasPreviousCategory then
tabOrder = tabOrder + 1
New("Frame", {
Name = "TabCategorySpacer",
Size = UDim2.new(1, 0, 0, 7),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = tabOrder,
}, Tab)
end
tabOrder = tabOrder + 1
local lbl = New("TextLabel", {
Name = "TabLabel",
Size = UDim2.new(1, 0, 0, 17),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Text = text:upper(),
TextColor3 = Color3.fromRGB(112, 116, 138),
TextScaled = false,
TextSize = 11,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
TextYAlignment = Enum.TextYAlignment.Center,
LayoutOrder = tabOrder,
}, Tab)
New("UIPadding", {
PaddingLeft = UDim.new(0, 11),
}, lbl)
return lbl
end
WindowObj._buildESPPreview = function(leftCol, rightCol, options)
options = type(options) == "table" and options or {}
local LAVENDER, MUTED, TEXT = Color3.fromRGB(150, 164, 255), Color3.fromRGB(176, 178, 188), Color3.fromRGB(235, 236, 241)
local GROUPS = type(options.groups) == "table" and options.groups or {
{ "Main", { "Bounding Box", "Name", "Distance", "Health Bar", "Ammo Bar", "Skeleton" } },
{ "Flags", { "Unarmored", "Defuser", "Blind", "Scoped", "Reload", "Immunity", "Slowed", "Vulnerable", "Bomb",
"Hostage", "Defuse", "Pin Pulled", "Money", "Order Priority", "Delay" } },
{ "Weapon", { "Text", "Icon", "Readiness Bar", "Bomb", "Defuser", "Taser" } },
{ "Aimbot", { "Hit Chance", "Hitboxes" } },
}
local TEAMS = { { "Enemies", "rbxassetid://10747373176" }, { "Teammates", "rbxassetid://10747372346" } }
local team = options.team == "Teammates" and "Teammates" or "Enemies"
local state = { Enemies = {}, Teammates = {} }
local showItems, scaleTogether = false, options.scaleTogether ~= false
local page = New("Frame", { Name = "ESPPreview", Size = UDim2.new(1, 0, 0, 420), BackgroundTransparency = 1, LayoutOrder = 100 }, rightCol)
local function fit()
local h = rightCol.AbsoluteSize.Y - 14
if h > 100 then page.Size = UDim2.new(1, 0, 0, h) end
end
rightCol:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit)
task.defer(fit)
local bar = New("Frame", { Name = "PreviewBar", Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1 }, page)
local teamButtons, tools = {}, {}
local function iconButton(name, icon)
local b = New("TextButton", {
Name = name, Size = UDim2.fromOffset(24, 24), BackgroundColor3 = Color3.fromRGB(18, 18, 18), BackgroundTransparency = 1,
AutoButtonColor = false, Text = "", BorderSizePixel = 0, ClipsDescendants = true,
}, bar)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, b)
New("ImageLabel", {
Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 5, 0.5, 0), Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1, Image = icon, ImageColor3 = MUTED, ScaleType = Enum.ScaleType.Fit,
}, b)
return b
end
for _, def in ipairs(TEAMS) do
local b = iconButton("Team_" .. def[1], def[2])
local title = New("TextLabel", {
Name = "TeamTitle", Position = UDim2.fromOffset(25, 0), Size = UDim2.new(0, 90, 1, 0), BackgroundTransparency = 1,
Text = def[1], TextColor3 = LAVENDER, TextSize = 14, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1,
}, b)
teamButtons[def[1]] = { button = b, title = title, icon = b:FindFirstChild("Icon") }
end
tools.items = iconButton("ESPItems", "rbxassetid://10723424963")
tools.expand = iconButton("ScaleItems", "rbxassetid://10734886496")
local function layoutBar(instant)
local widths, total = {}, 0
for _, def in ipairs(TEAMS) do
local open = def[1] == team
widths[def[1]] = open and math.ceil(25 + MeasureText(def[1], 14, FONT) + 8) or 24
total = total + widths[def[1]] + 6
end
total = total + 10 + 24 + 6 + 24
local x = math.max(0, math.floor((bar.AbsoluteSize.X - total) / 2))
for _, def in ipairs(TEAMS) do
local entry, open = teamButtons[def[1]], def[1] == team
local goal = { Size = UDim2.fromOffset(widths[def[1]], 24), Position = UDim2.fromOffset(x, 2) }
if instant then
entry.button.Size, entry.button.Position = goal.Size, goal.Position
entry.title.TextTransparency = open and 0 or 1
else
Tween(entry.button, goal, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(entry.title, { TextTransparency = open and 0 or 1 }, 0.18)
end
Tween(entry.icon, { ImageColor3 = open and LAVENDER or MUTED }, 0.15)
x = x + widths[def[1]] + 6
end
x = x + 10
for _, key in ipairs({ "items", "expand" }) do
local b = tools[key]
local goal = { Position = UDim2.fromOffset(x, 2) }
if instant then b.Position = goal.Position else Tween(b, goal, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out) end
x = x + 30
end
Tween(tools.items, { BackgroundTransparency = showItems and 0 or 1 }, 0.15)
Tween(tools.items.Icon, { ImageColor3 = showItems and TEXT or MUTED }, 0.15)
Tween(tools.expand.Icon, { ImageColor3 = scaleTogether and LAVENDER or MUTED }, 0.15)
end
bar:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() layoutBar(true) end)
local body = New("Frame", { Name = "Body", Position = UDim2.fromOffset(0, 34), Size = UDim2.new(1, 0, 1, -34), BackgroundTransparency = 1 }, page)
local viewport = New("ViewportFrame", {
Name = "PlayerView", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
Ambient = Color3.fromRGB(150, 150, 165), LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(-0.6, -1, -0.8),
}, body)
local world = Instance.new("WorldModel")
world.Parent = viewport
local camera = Instance.new("Camera")
camera.FieldOfView = 30
camera.Parent = viewport
viewport.CurrentCamera = camera
local model
local function fitCamera()
if not model then return end
local cf, size = model:GetBoundingBox()
local view = viewport.AbsoluteSize
local aspect = (view.X > 0 and view.Y > 0) and view.X / view.Y or 0.75
local span = math.max(size.Y, math.max(size.X, size.Z) / aspect)
camera.CFrame = CFrame.new(cf.Position + Vector3.new(0, 0, span / 2 / math.tan(math.rad(15)) * 1.3), cf.Position)
end
viewport:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitCamera)
local function loadModel()
world:ClearAllChildren()
model = nil
local char = LocalPlayer.Character
if not char then return end
local was = char.Archivable
char.Archivable = true
local ok, clone = pcall(function() return char:Clone() end)
char.Archivable = was
if not ok or not clone then return end
local links = {}
for _, d in ipairs(clone:GetDescendants()) do
if d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound") then
d:Destroy()
elseif d:IsA("BasePart") then
d.Anchored = true
d.CanCollide = false
elseif (d:IsA("Motor6D") or d:IsA("Weld")) and d.Part0 and d.Part1 then
table.insert(links, { a = d.Part0, b = d.Part1, rel = d.C0 * d.C1:Inverse() })
elseif d:IsA("WeldConstraint") and d.Part0 and d.Part1 then
table.insert(links, { a = d.Part0, b = d.Part1, rel = d.Part0.CFrame:ToObjectSpace(d.Part1.CFrame) })
end
end
local root = clone:FindFirstChild("HumanoidRootPart") or clone.PrimaryPart
if root then
local placed, progress = { [root] = true }, true
while progress do
progress = false
for _, l in ipairs(links) do
if l.a.Parent and l.b.Parent then
if placed[l.a] and not placed[l.b] then
l.b.CFrame = l.a.CFrame * l.rel
placed[l.b], progress = true, true
elseif placed[l.b] and not placed[l.a] then
l.a.CFrame = l.b.CFrame * l.rel:Inverse()
placed[l.a], progress = true, true
end
end
end
end
end
local humanoid = clone:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
clone.Parent = world
clone:PivotTo(CFrame.Angles(0, math.pi, 0))
model = clone
fitCamera()
end
loadModel()
LocalPlayer.CharacterAdded:Connect(function(char)
char:WaitForChild("HumanoidRootPart", 10)
task.wait(0.5)
loadModel()
end)
local itemsCard = New("Frame", {
Name = "ESPItems", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.fromRGB(18, 18, 25), BackgroundTransparency = 0.04,
BorderSizePixel = 0, Visible = false,
}, body)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, itemsCard)
Stroke(itemsCard)
New("TextLabel", {
Name = "ItemsTitle", Position = UDim2.fromOffset(14, 0), Size = UDim2.new(1, -28, 0, 40), BackgroundTransparency = 1,
Text = "ESP Items", TextColor3 = TEXT, TextSize = 15, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left,
}, itemsCard)
New("Frame", {
Name = "ItemsRule", Position = UDim2.fromOffset(0, 40), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 0.93, BorderSizePixel = 0,
}, itemsCard)
local scroller = New("ScrollingFrame", {
Name = "ItemsList", Position = UDim2.fromOffset(6, 46), Size = UDim2.new(1, -12, 1, -52), BackgroundTransparency = 1,
BorderSizePixel = 0, ScrollBarThickness = 2, AutomaticCanvasSize = Enum.AutomaticSize.Y, CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
}, itemsCard)
New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, scroller)
New("UIPadding", { PaddingBottom = UDim.new(0, 4), PaddingRight = UDim.new(0, 2) }, scroller)
local chips = {}
for g, group in ipairs(GROUPS) do
local groupCard = New("Frame", {
Name = "Group_" .. group[1], LayoutOrder = g, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
BackgroundColor3 = Color3.fromRGB(23, 23, 31), BackgroundTransparency = 0, BorderSizePixel = 0,
}, scroller)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, groupCard)
Stroke(groupCard)
New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10), PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 10) }, groupCard)
New("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }, groupCard)
New("TextLabel", {
Name = "GroupTitle", LayoutOrder = 1, Size = UDim2.new(1, 0, 0, 18), BackgroundTransparency = 1,
Text = group[1], TextColor3 = TEXT, TextSize = 14, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left,
}, groupCard)
local wrap = New("Frame", { Name = "Chips", LayoutOrder = 2, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1 }, groupCard)
New("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, Wraps = true, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder }, wrap)
for i, item in ipairs(group[2]) do
local chip = New("TextButton", {
Name = "Chip", LayoutOrder = i, Size = UDim2.fromOffset(math.ceil(MeasureText(item, 13, FONT) + 18), 26),
BackgroundColor3 = Color3.fromRGB(24, 24, 24), BackgroundTransparency = 0.2, AutoButtonColor = false,
Text = item, TextColor3 = MUTED, TextSize = 13, Font = FONT, BorderSizePixel = 0,
}, wrap)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, chip)
Stroke(chip, "ChipOutline")
local key = group[1] .. "/" .. item
chips[key] = chip
chip.MouseButton1Click:Connect(function()
local on = not state[team][key]
state[team][key] = on or nil
Tween(chip, { BackgroundColor3 = on and Color3.fromRGB(44, 48, 66) or Color3.fromRGB(24, 24, 24), TextColor3 = on and TEXT or MUTED }, 0.12)
local outline = chip:FindFirstChild("ChipOutline")
if outline then Tween(outline, { Color = on and LAVENDER or STROKE.Color, Transparency = on and 0.35 or STROKE.Transparency }, 0.12) end
if type(options.onItem) == "function" then pcall(options.onItem, team, group[1], item, on) end
end)
end
end
local function paintChips()
for key, chip in pairs(chips) do
local on = state[team][key] == true
chip.BackgroundColor3 = on and Color3.fromRGB(44, 48, 66) or Color3.fromRGB(24, 24, 24)
chip.TextColor3 = on and TEXT or MUTED
local outline = chip:FindFirstChild("ChipOutline")
if outline then
outline.Color = on and LAVENDER or STROKE.Color
outline.Transparency = on and 0.35 or STROKE.Transparency
end
end
end
local bound = { Enemies = {}, Teammates = {} }
if type(options.sections) == "table" then
for _, which in ipairs({ "Enemies", "Teammates" }) do
for _, sec in ipairs(options.sections[which] or {}) do table.insert(bound[which], sec) end
end
end
local swapToken = 0
local function applySections(animated)
local hide, show = {}, {}
for which, list in pairs(bound) do
for _, sec in ipairs(list) do
local frame = type(sec) == "table" and sec.frame or sec
if typeof(frame) == "Instance" then
if which == team then table.insert(show, frame) else table.insert(hide, frame) end
end
end
end
if not animated then
for _, f in ipairs(hide) do f.Visible = false end
for _, f in ipairs(show) do f.Visible = true end
return
end
swapToken = swapToken + 1
local token = swapToken
for _, f in ipairs(hide) do
if f.Visible then WindowObj._fadeTree(f, false, 0.14) end
end
task.delay(0.14, function()
if token ~= swapToken then return end
for _, f in ipairs(hide) do
f.Visible = false
WindowObj._fadeTree(f, true, 0)
end
for _, f in ipairs(show) do
f.Visible = true
WindowObj._fadeTree(f, false, 0)
WindowObj._fadeTree(f, true, 0.22)
end
AnimateSectionColumn(leftCol)
end)
end
local api = { frame = page }
function api:GetTeam() return team end
function api:SetTeam(which)
team = which == "Teammates" and "Teammates" or "Enemies"
layoutBar(false)
applySections(true)
paintChips()
if type(options.onTeam) == "function" then pcall(options.onTeam, team) end
return self
end
function api:Bind(section, which)
table.insert(bound[which == "Teammates" and "Teammates" or "Enemies"], section)
applySections()
return self
end
function api:IsItemOn(which, group, item) return state[which][group .. "/" .. item] == true end
for which, entry in pairs(teamButtons) do
entry.button.MouseButton1Click:Connect(function() if team ~= which then api:SetTeam(which) end end)
entry.button.MouseEnter:Connect(function() if team ~= which then Tween(entry.button, { BackgroundTransparency = 0.6 }, 0.1) end end)
entry.button.MouseLeave:Connect(function() Tween(entry.button, { BackgroundTransparency = 1 }, 0.14) end)
end
tools.items.MouseButton1Click:Connect(function()
showItems = not showItems
itemsCard.Visible = true
if showItems then
itemsCard.BackgroundTransparency = 1
FadePopupContent(itemsCard, true, 0.18)
Tween(itemsCard, { BackgroundTransparency = 0.04 }, 0.18)
Tween(viewport, { ImageTransparency = 1 }, 0.18)
else
FadePopupContent(itemsCard, false, 0.16)
Tween(itemsCard, { BackgroundTransparency = 1 }, 0.16)
Tween(viewport, { ImageTransparency = 0 }, 0.18)
task.delay(0.17, function() if not showItems then itemsCard.Visible = false end end)
end
layoutBar(false)
end)
local tip = New("TextLabel", {
Name = "ScaleTip", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(0, 26), AutomaticSize = Enum.AutomaticSize.X,
BackgroundColor3 = Color3.fromRGB(18, 18, 25), BackgroundTransparency = 1, Text = "When disabled, ESP items are scaled individually",
TextColor3 = TEXT, TextTransparency = 1, TextSize = 13, Font = FONT, Visible = false, ZIndex = 40,
}, page)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, tip)
New("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, tip)
local tipToken = 0
tools.expand.MouseEnter:Connect(function()
tipToken = tipToken + 1
local token = tipToken
task.delay(0.35, function()
if token ~= tipToken then return end
local b = tools.expand
tip.Position = UDim2.fromOffset(b.AbsolutePosition.X - page.AbsolutePosition.X + b.AbsoluteSize.X + 8, b.AbsolutePosition.Y - page.AbsolutePosition.Y + b.AbsoluteSize.Y / 2)
tip.Visible = true
Tween(tip, { BackgroundTransparency = 0.04, TextTransparency = 0 }, 0.14)
end)
end)
tools.expand.MouseLeave:Connect(function()
tipToken = tipToken + 1
Tween(tip, { BackgroundTransparency = 1, TextTransparency = 1 }, 0.1)
local token = tipToken
task.delay(0.11, function() if token == tipToken then tip.Visible = false end end)
end)
tools.expand.MouseButton1Click:Connect(function()
scaleTogether = not scaleTogether
layoutBar(false)
if type(options.onScale) == "function" then pcall(options.onScale, scaleTogether) end
end)
function api:GetScaleTogether() return scaleTogether end
WindowObj._configExtras["esp_" .. tostring(options.id or "players")] = {
get = function()
local out = { team = team, scale = scaleTogether, Enemies = {}, Teammates = {} }
for which, items in pairs(state) do for key in pairs(items) do table.insert(out[which], key) end end
return out
end,
set = function(v)
if type(v) ~= "table" then return end
for _, which in ipairs({ "Enemies", "Teammates" }) do
state[which] = {}
for _, key in ipairs(type(v[which]) == "table" and v[which] or {}) do state[which][key] = true end
end
if type(v.scale) == "boolean" then scaleTogether = v.scale end
api:SetTeam(v.team)
end,
}
layoutBar(true)
applySections()
paintChips()
return api
end
function WindowObj:AddTab(name, icon)
local function TintTabIcon(iconObject, color, transparency, duration, style, direction)
Tween(iconObject, { ImageColor3 = color, ImageTransparency = transparency }, duration, style, direction)
end
name = tostring(name or "Tab")
if icon ~= nil and type(icon) ~= "string" then icon = "" end
tabOrder = tabOrder + 1
local tabIndex = #tabs + 1
local isFirst = tabIndex == 1
local TabButtonFrame = New("Frame", {
Name = "TabButton",
Size = UDim2.new(1, 0, 0, 32),
BackgroundColor3 = Color3.fromRGB(18, 18, 18),
BackgroundTransparency = isFirst and 0.08 or 1,
LayoutOrder = tabOrder,
}, Tab)
TabButtonFrame:SetAttribute("TabIndex", tabIndex)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, TabButtonFrame)
local TabScale = New("UIScale", { Scale = 1 }, TabButtonFrame)
local TabIndicator = New("Frame", {
Name = "SelectedIndicator",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.fromOffset(0, 0),
BackgroundColor3 = mainColor,
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 3,
}, TabButtonFrame)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, TabIndicator)
local TabIcon = New("ImageLabel", {
Name = "TabIcon",
Position = UDim2.new(0, 18, 0.5, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
Size = UDim2.fromOffset(18, 18),
BackgroundColor3 = Color3.fromRGB(255, 191, 255),
BackgroundTransparency = 1,
Image = "",
ImageColor3 = isFirst and mainColor or Color3.fromRGB(160, 160, 160),
ImageTransparency = 0,
}, TabButtonFrame)
if icon and icon ~= "" then
GetImageData(icon, TabIcon)
end
WindowObj._drawTabGlyph(icon, TabIcon)
table.insert(_coloredElements, { type = "tabicon", ref = TabIcon })
New("UIAspectRatioConstraint", {
AspectRatio = 1,
}, TabIcon)
local TabText = New("TextLabel", {
Name = "TabText",
Position = UDim2.new(0, 38, 0, 0),
Size = UDim2.new(1, -46, 1, 0),
BackgroundColor3 = Color3.fromRGB(191, 255, 255),
BackgroundTransparency = 1,
Text = name,
TextColor3 = isFirst and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
}, TabButtonFrame)
local ClickArea = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 5,
}, TabButtonFrame)
local Left = New("ScrollingFrame", {
Name = "Left",
Size = UDim2.new(0.49, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
ClipsDescendants = true,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
}, TabHose)
local Right = New("ScrollingFrame", {
Name = "Right",
Size = UDim2.new(0.49, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = 1,
ClipsDescendants = true,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
}, TabHose)
Left:SetAttribute("SearchName", name)
Right:SetAttribute("SearchName", name)
Left:SetAttribute("TabIndex", tabIndex)
Right:SetAttribute("TabIndex", tabIndex)
New("UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 12) }, Left)
New("UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 12) }, Right)
New("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder }, Left)
New("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder }, Right)
if not isFirst then
Left.Visible = false
Right.Visible = false
end
local			function HideContent()
Left.Visible = false
Right.Visible = false
end
local function ShowContent()
Left.Position = UDim2.new(0, 0, 0, 0)
Right.Position = UDim2.new(0, 0, 0, 0)
Left.Visible = true
Right.Visible = true
AnimateSectionColumn(Left)
AnimateSectionColumn(Right)
if WindowObj._fadeColumn then WindowObj._fadeColumn(Left); WindowObj._fadeColumn(Right) end
end
local function ActivateTab()
CloseAllPopupsExcept(nil)
for _, t in ipairs(tabs) do
Tween(t.btn, {
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
}, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
if t.indicator then Tween(t.indicator, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) end
t.hide()
if t.btn ~= TabButtonFrame then
TintTabIcon(t.icon, Color3.fromRGB(160, 160, 160), 0, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
t.txt.TextColor3 = Color3.fromRGB(160, 160, 160)
Tween(t.txt, { TextTransparency = 0 }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
end
Tween(TabButtonFrame, {
BackgroundColor3 = Color3.fromRGB(18, 18, 18),
BackgroundTransparency = 0.08,
}, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(TabIndicator, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
TintTabIcon(TabIcon, mainColor, 0, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
TabText.TextColor3 = Color3.fromRGB(255, 255, 255)
Tween(TabText, { TextTransparency = 0 }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
TabScale.Scale = 0.985
Tween(TabScale, { Scale = 1 }, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
activeTabIndex = tabIndex
ShowContent()
local tabState = tabs[tabIndex]
GlobalPreset.Visible = ShouldShowGlobalPreset(name)
if ApplySearch then task.defer(function() ApplySearch(SearchBox.Text) end) end
end
ClickArea.MouseButton1Click:Connect(ActivateTab)
TabButtonFrame.MouseEnter:Connect(function()
if activeTabIndex == tabIndex then return end
Tween(TabButtonFrame, { BackgroundTransparency = 0.8 }, 0.11, Enum.EasingStyle.Sine)
end)
TabButtonFrame.MouseLeave:Connect(function()
if activeTabIndex == tabIndex then return end
Tween(TabButtonFrame, { BackgroundTransparency = 1 }, 0.14, Enum.EasingStyle.Sine)
end)
table.insert(tabs, {
btn = TabButtonFrame,
icon = TabIcon,
indicator = TabIndicator,
txt = TabText,
hide = HideContent,
show = ShowContent,
tabIndex = tabIndex,
name = name,
activeSubTabIndex = nil,
activate = ActivateTab,
})
if isFirst then
activeTabIndex = 1
GlobalPreset.Visible = ShouldShowGlobalPreset(name)
end
local TabObj = {}
local sectionOrder = { left = 0, right = 0 }
function TabObj:AddLoadout(options)
options = type(options) == "table" and options or {}
local WEAPONS = {
CT = {
Pistols = { "USP-S", "Dual Berettas", "P250", "Five-SeveN", "Desert Eagle" },
["Mid-Tier"] = { "Nova", "XM1014", "MP9", "MP7", "P90" },
Rifles = { "FAMAS", "M4A4", "SSG 08", "AUG", "AWP" },
},
T = {
Pistols = { "Glock-18", "Dual Berettas", "P250", "Tec-9", "Desert Eagle" },
["Mid-Tier"] = { "Nova", "Sawed-Off", "MAC-10", "MP7", "P90" },
Rifles = { "Galil AR", "AK-47", "SSG 08", "SG 553", "AWP" },
},
}
local CATEGORIES = { "Pistols", "Mid-Tier", "Rifles" }
local GEAR = {
{ "Agent", "rbxassetid://10747373176" }, { "Patch", "rbxassetid://10709769406" }, { "Music Kit", "rbxassetid://10734905958" },
{ "Knife", "rbxassetid://10734975486" }, { "Gloves", "rbxassetid://10723405649" }, { "Zeus", "rbxassetid://10734951847" },
}
local TEAM_COLOR = { CT = Color3.fromRGB(110, 150, 255), T = Color3.fromRGB(230, 180, 90) }
local TEAM_ICON = type(options.icons) == "table" and options.icons or {}
local CARD, MUTED, TEXT = Color3.fromRGB(23, 23, 31), Color3.fromRGB(150, 152, 162), Color3.fromRGB(235, 236, 241)
local team = options.team == "T" and "T" or "CT"
Left.Size = UDim2.new(1, -12, 1, 0)
Right.Size = UDim2.new(0, 0, 1, 0)
local page = New("Frame", { Name = "Loadout", Size = UDim2.new(1, 0, 0, 420), BackgroundTransparency = 1, LayoutOrder = 1 }, Left)
local function fitHeight()
local h = Left.AbsoluteSize.Y - 14
if h > 100 then page.Size = UDim2.new(1, 0, 0, h) end
end
Left:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitHeight)
task.defer(fitHeight)
local function card(parent, name)
local c = New("TextButton", {
Name = name, BackgroundColor3 = Color3.fromRGB(16, 18, 25), BackgroundTransparency = 0.15, AutoButtonColor = false,
Text = "", BorderSizePixel = 0,
}, parent)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, c)
Stroke(c).Transparency = 0.95
local bar = New("Frame", {
Name = "GradeBar", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.new(1, -6, 0, 3),
BackgroundColor3 = Color3.fromRGB(176, 180, 192), BackgroundTransparency = 0.25, BorderSizePixel = 0,
}, c)
New("UICorner", { CornerRadius = UDim.new(0, 2) }, bar)
c.MouseEnter:Connect(function() Tween(c, { BackgroundColor3 = Color3.fromRGB(24, 27, 36) }, 0.1) end)
c.MouseLeave:Connect(function() Tween(c, { BackgroundColor3 = Color3.fromRGB(16, 18, 25) }, 0.14) end)
return c
end
local side = New("Frame", { Name = "AgentSide", Size = UDim2.new(0.32, 0, 1, 0), BackgroundTransparency = 1 }, page)
local teamButtons = {}
for index, which in ipairs({ "CT", "T" }) do
local b = New("TextButton", {
Name = "Team_" .. which, Position = UDim2.fromOffset(0, 2), Size = UDim2.fromOffset(24, 24),
BackgroundColor3 = Color3.fromRGB(32, 36, 50), BackgroundTransparency = 1, AutoButtonColor = false, Text = "", BorderSizePixel = 0,
ClipsDescendants = true,
}, side)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, b)
local logo = New("Frame", {
Name = "TeamLogo", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(18, 18),
BackgroundColor3 = Color3.fromRGB(92, 96, 110), BackgroundTransparency = 0.35, BorderSizePixel = 0,
}, b)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, logo)
if TEAM_ICON[which] then
logo.BackgroundTransparency = 1
New("ImageLabel", {
Name = "TeamLogoIcon", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Image = TEAM_ICON[which],
ScaleType = Enum.ScaleType.Fit,
}, logo)
end
local title = New("TextLabel", {
Name = "TeamTitle", Position = UDim2.fromOffset(26, 0), Size = UDim2.new(0, 90, 1, 0), BackgroundTransparency = 1,
Text = which .. " Loadout", TextColor3 = TEAM_COLOR[which]:Lerp(Color3.new(1, 1, 1), 0.2), TextSize = 14, Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left, TextTransparency = 1,
}, b)
b.MouseEnter:Connect(function() if team ~= which then Tween(b, { BackgroundTransparency = 0.6 }, 0.1) end end)
b.MouseLeave:Connect(function() if team ~= which then Tween(b, { BackgroundTransparency = 1 }, 0.14) end end)
teamButtons[which] = { button = b, title = title, index = index }
end
local function layoutTeams(instant)
local total = -8
for _, which in ipairs({ "CT", "T" }) do
total = total + (which == team and math.ceil(26 + MeasureText(which .. " Loadout", 14, FONT) + 10) or 24) + 8
end
local x = math.max(0, math.floor((side.AbsoluteSize.X - total) / 2))
for _, which in ipairs({ "CT", "T" }) do
local entry = teamButtons[which]
local open = which == team
local width = open and math.ceil(26 + MeasureText(which .. " Loadout", 14, FONT) + 10) or 24
local size = UDim2.fromOffset(width, 24)
local pos = UDim2.fromOffset(x, 2)
local plate = open and 0 or 1
if instant then
entry.button.Size, entry.button.Position, entry.button.BackgroundTransparency = size, pos, plate
entry.title.TextTransparency = open and 0 or 1
else
Tween(entry.button, { Size = size, Position = pos, BackgroundTransparency = plate }, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(entry.title, { TextTransparency = open and 0 or 1 }, 0.18)
end
x = x + width + 8
end
end
layoutTeams(true)
side:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() layoutTeams(true) end)
local agent = New("Frame", { Name = "Agent", Position = UDim2.fromOffset(0, 38), BackgroundTransparency = 1, Active = true }, side)
local viewport = New("ViewportFrame", {
Name = "AgentView", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1,
Ambient = Color3.fromRGB(150, 150, 165), LightColor = Color3.fromRGB(255, 255, 255), LightDirection = Vector3.new(-0.6, -1, -0.8),
}, agent)
local world = Instance.new("WorldModel")
world.Parent = viewport
local camera = Instance.new("Camera")
camera.FieldOfView = 30
camera.Parent = viewport
viewport.CurrentCamera = camera
local gear = New("Frame", { Name = "Gear", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1 }, side)
New("UIAspectRatioConstraint", { AspectRatio = 1.5, DominantAxis = Enum.DominantAxis.Width }, gear)
New("UIGridLayout", { CellSize = UDim2.new(1 / 3, -6, 0.5, -4), CellPadding = UDim2.fromOffset(8, 8), SortOrder = Enum.SortOrder.LayoutOrder }, gear)
for i, item in ipairs(GEAR) do
local slot = card(gear, "Gear_" .. item[1])
slot.LayoutOrder = i
slot.MouseButton1Click:Connect(function()
if type(options.onSelect) == "function" then pcall(options.onSelect, team, "Gear", i, item[1]) end
end)
end
local function fitAgent()
local gearH = gear.AbsoluteSize.Y
if gearH > 0 then agent.Size = UDim2.new(1, 0, 1, -(38 + gearH + 8)) end
end
gear:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitAgent)
task.defer(fitAgent)
local yaw, model = 0, nil
local function pose()
if not model then return end
model:PivotTo(CFrame.Angles(0, math.pi + yaw, 0))
end
local function fitCamera()
if not model then return end
local cf, size = model:GetBoundingBox()
local view = viewport.AbsoluteSize
local aspect = (view.X > 0 and view.Y > 0) and view.X / view.Y or 0.75
local span = math.max(size.Y, math.max(size.X, size.Z) / aspect)
local distance = span / 2 / math.tan(math.rad(camera.FieldOfView / 2)) * 1.25
camera.CFrame = CFrame.new(cf.Position + Vector3.new(0, 0, distance), cf.Position)
end
viewport:GetAttributeChangedSignal("Refit"):Connect(fitCamera)
viewport:GetPropertyChangedSignal("AbsoluteSize"):Connect(fitCamera)
local function loadAgent()
world:ClearAllChildren()
model = nil
local char = LocalPlayer.Character
if not char then return end
local was = char.Archivable
char.Archivable = true
local ok, clone = pcall(function() return char:Clone() end)
char.Archivable = was
if not ok or not clone then return end
for _, d in ipairs(clone:GetDescendants()) do
if d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound") then
d:Destroy()
elseif d:IsA("BasePart") then
d.Anchored = true
d.CanCollide = false
end
end
local humanoid = clone:FindFirstChildOfClass("Humanoid")
if humanoid then humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None end
do
local root = clone:FindFirstChild("HumanoidRootPart") or clone.PrimaryPart
local links = {}
for _, j in ipairs(clone:GetDescendants()) do
if (j:IsA("Motor6D") or j:IsA("Weld")) and j.Part0 and j.Part1 then
table.insert(links, { a = j.Part0, b = j.Part1, rel = j.C0 * j.C1:Inverse() })
elseif j:IsA("WeldConstraint") and j.Part0 and j.Part1 then
table.insert(links, { a = j.Part0, b = j.Part1, rel = j.Part0.CFrame:ToObjectSpace(j.Part1.CFrame) })
end
end
if root then
local placed, progress = { [root] = true }, true
while progress do
progress = false
for _, l in ipairs(links) do
if placed[l.a] and not placed[l.b] then
l.b.CFrame = l.a.CFrame * l.rel
placed[l.b], progress = true, true
elseif placed[l.b] and not placed[l.a] then
l.a.CFrame = l.b.CFrame * l.rel:Inverse()
placed[l.a], progress = true, true
end
end
end
end
end
clone.Parent = world
model = clone
pose()
model:SetAttribute("Fit", true)
viewport:SetAttribute("Refit", (viewport:GetAttribute("Refit") or 0) + 1)
end
loadAgent()
LocalPlayer.CharacterAdded:Connect(function(char)
char:WaitForChild("HumanoidRootPart", 10)
task.wait(0.5)
loadAgent()
end)
do
local turning
agent.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
turning = { x = input.Position.X, yaw = yaw }
end
end)
UserInputService.InputChanged:Connect(function(input)
if not turning or input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end
yaw = turning.yaw + (input.Position.X - turning.x) * 0.012
pose()
end)
UserInputService.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then turning = nil end
end)
end
local grid = New("Frame", { Name = "Weapons", Position = UDim2.new(0.32, 12, 0, 0), Size = UDim2.new(0.68, -12, 1, 0), BackgroundTransparency = 1 }, page)
for i, category in ipairs(CATEGORIES) do
New("TextLabel", {
Name = "Header_" .. category, Position = UDim2.new((i - 1) / 3, 0, 0, 0), Size = UDim2.new(1 / 3, -8, 0, 28),
BackgroundTransparency = 1, Text = category, TextColor3 = TEXT, TextSize = 14, Font = FONT,
}, grid)
end
local slots = New("Frame", { Name = "Slots", Position = UDim2.fromOffset(0, 36), Size = UDim2.new(1, 0, 1, -36), BackgroundTransparency = 1 }, grid)
New("UIGridLayout", {
CellSize = UDim2.new(1 / 3, -8, 0.2, -8), CellPadding = UDim2.fromOffset(8, 8),
FillDirection = Enum.FillDirection.Vertical, FillDirectionMaxCells = 5, SortOrder = Enum.SortOrder.LayoutOrder,
}, slots)
for c, category in ipairs(CATEGORIES) do
for i = 1, 5 do
local slot = card(slots, category .. "_" .. i)
slot.LayoutOrder = (c - 1) * 5 + i
slot.MouseButton1Click:Connect(function()
if type(options.onSelect) == "function" then
pcall(options.onSelect, team, category, i, WEAPONS[team][category][i])
end
end)
end
end
local api = { frame = page }
function api:GetTeam() return team end
function api:SetTeam(newTeam)
team = newTeam == "T" and "T" or "CT"
layoutTeams(false)
if type(options.onTeam) == "function" then pcall(options.onTeam, team) end
return self
end
for which, entry in pairs(teamButtons) do
entry.button.MouseButton1Click:Connect(function() if team ~= which then api:SetTeam(which) end end)
end
return api
end
function TabObj:AddESPPreview(options)
return WindowObj._buildESPPreview(Left, Right, options)
end
function TabObj:AddSection(title, side)
title = tostring(title or "Section")
side = side == "right" and "right" or "left"
sectionOrder[side] = sectionOrder[side] + 1
local col = side == "right" and Right or Left
local Section = New("Frame", {
Name = "Section",
Size = UDim2.new(1, 0, 0, 0),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
LayoutOrder = sectionOrder[side],
}, col)
Section:SetAttribute("NLTabName", tostring(name))
Section:SetAttribute("NLSectionName", title)
New("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }, Section)
local SectionTitle = Instance.new('Frame')
SectionTitle.Name = "SectionTitle"
SectionTitle.Size = UDim2.new(1, 0, 0, 22)
SectionTitle.BackgroundTransparency = 1
SectionTitle.ClipsDescendants = false
SectionTitle.Visible = true
SectionTitle.Parent = Section
local SectionLabel = Instance.new('TextLabel')
SectionLabel.Name = "SectionLabel"
SectionLabel.Position = UDim2.new(0,0,0,0)
SectionLabel.Size = UDim2.new(1,0,1,0)
SectionLabel.Visible = true
SectionLabel.ClipsDescendants = false
SectionLabel.BackgroundColor3 = Color3.fromRGB(162,162,162)
SectionLabel.BackgroundTransparency = 1
SectionLabel.BorderSizePixel = 0
SectionLabel.Text = tostring(title or "Section"):upper()
SectionLabel.TextColor3 = customization.sectionTitleColor or Color3.fromRGB(112, 116, 138)
SectionLabel.TextScaled = false
SectionLabel.TextSize = customization.sectionTitleSize or 11
SectionLabel.Font = FONT
SectionLabel.TextTransparency = customization.sectionTitleTransparency or 0.15
SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
SectionLabel.TextYAlignment = Enum.TextYAlignment.Center
SectionLabel.Parent = SectionTitle
do
local pad = Instance.new("UIPadding")
pad.PaddingLeft = UDim.new(0, 13)
pad.PaddingRight = UDim.new(0, 4)
pad.Parent = SectionLabel
end
AddTextConstraint(SectionLabel, 10, 14, true)
do
local limit = SectionLabel:FindFirstChild("ReadableTextConstraint")
if not limit then
limit = Instance.new("UITextSizeConstraint")
limit.Name = "ReadableTextConstraint"
limit.Parent = SectionLabel
end
limit.MinTextSize = 10
limit.MaxTextSize = 14
end
local Elements = New("Frame", {
Name = "Elements",
Size = UDim2.new(1, 0, 0, 0),
Position = UDim2.new(0, 0, 0, 0),
BackgroundColor3 = Color3.fromRGB(23, 23, 31),
BackgroundTransparency = 0.1,
BorderSizePixel = 0,
AutomaticSize = Enum.AutomaticSize.Y,
LayoutOrder = 1,
ClipsDescendants = false,
}, Section)
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 14); c.Parent = Elements end
Elements:SetAttribute("NLGroupOutlineInset", true)
do local groupStroke = Stroke(Elements, "GroupOutline"); groupStroke:SetAttribute("NLBaseTransparency", 0.92) end
New("UIPadding", {
PaddingLeft = UDim.new(0, 1),
PaddingRight = UDim.new(0, 1),
PaddingTop = UDim.new(0, 0),
PaddingBottom = UDim.new(0, 0),
}, Elements)
New("UIListLayout", {
Padding = UDim.new(0, 0),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Elements)
WatchRowDividers(Elements)
do
local headerButton = Instance.new("TextButton")
headerButton.Name = "CollapseButton"
headerButton.BackgroundTransparency = 1
headerButton.Text = ""
headerButton.AutoButtonColor = false
headerButton.Size = UDim2.fromScale(1, 1)
headerButton.ZIndex = 5
headerButton.Parent = SectionTitle
local arrow = Instance.new("TextLabel")
arrow.Name = "CollapseArrow"
arrow.BackgroundTransparency = 1
arrow.AnchorPoint = Vector2.new(1, 0.5)
arrow.Position = UDim2.new(1, -10, 0.5, 0)
arrow.Size = UDim2.fromOffset(18, 18)
arrow.Font = FONT
arrow.TextSize = 14
arrow.TextColor3 = customization.sectionTitleColor or Color3.fromRGB(112, 116, 138)
arrow.ZIndex = 5
arrow.Parent = SectionTitle
local expanded = false
local function applyCollapse()
Elements:SetAttribute("NLCollapsed", not expanded)
Elements.Visible = expanded
arrow.Text = expanded and "-" or "+"
end
Elements:SetAttribute("NLSearchBaseVisible", true)
applyCollapse()
headerButton.MouseButton1Click:Connect(function()
expanded = not expanded
applyCollapse()
end)
end
local SectionObj = {}
SectionObj.frame = Section
local elemCount = 0
local _openDropdown = nil
local _openAccordion = nil
local _openAccordionDropdown = nil
local settingsCache = {}
local BindElementContext
local function MakeSettings(parentFrame, elementType, label)
if settingsCache[parentFrame] then return settingsCache[parentFrame] end
label = tostring(label or "")
local settingsOpen = false
local settingsLayoutConnection = nil
local hasLeftControl = elementType == "slider" or elementType == "dropdown" or parentFrame.Name == "Selection"
local SettingsBtn = New("Frame", {
Name = "SettingsGear",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = hasLeftControl and UDim2.new(0, 132, 0.5, 0) or UDim2.new(1, -65, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
ZIndex = 2000,
}, parentFrame)
for i = 0, 2 do
New("Frame", {
Name = "Dot" .. tostring(i + 1),
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(0.5, (i - 1) * 5, 0.5, 0),
Size = UDim2.new(0, 3, 0, 3),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ZIndex = 2001,
}, SettingsBtn)
end
local SettingsHit = New("TextButton", {
Name = "SettingsHit",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
AutoButtonColor = false,
ZIndex = 2002,
}, SettingsBtn)
for _, dot in ipairs(SettingsBtn:GetChildren()) do
if dot:IsA("GuiObject") and string.sub(dot.Name, 1, 3) == "Dot" then
dot.BackgroundTransparency = 1
end
end
local function SetDotsTransparency(value)
for _, dot in ipairs(SettingsBtn:GetChildren()) do
if dot:IsA("GuiObject") and string.sub(dot.Name, 1, 3) == "Dot" then
Tween(dot, { BackgroundTransparency = value }, 0.15)
end
end
end
SettingsHit.MouseEnter:Connect(function() SetDotsTransparency(0) end)
SettingsHit.MouseLeave:Connect(function() SetDotsTransparency(0.1) end)
SetDotsTransparency(0.1)
local SettingsFrame = Instance.new('Frame')
SettingsFrame.Name = "SettingsFrame"
SettingsFrame.Position = UDim2.new(0.02, 0, 1, 4)
SettingsFrame.Size = UDim2.new(0.96, 0, 0, 0)
SettingsFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
SettingsFrame.BackgroundTransparency = 0.045
SettingsFrame.BorderSizePixel = 0
SettingsFrame.Visible = false
SettingsFrame.ZIndex = 5000
SettingsFrame.AutomaticSize = Enum.AutomaticSize.None
SettingsFrame.ClipsDescendants = false
local SFScale = New("UIScale", { Scale = 1 }, SettingsFrame)
SettingsFrame.Parent = parentFrame
local UICorner = Instance.new('UICorner')
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0, THEME.radius)
UICorner.Parent = SettingsFrame
local UIStroke = Stroke(SettingsFrame, "UIStroke")
AttachShadow(SettingsFrame, { radius = 12, layers = 5, step = 1.6, bias = 3 })
local PLATE_HEADER = 40
New("TextLabel", {
Name = "PlateTitle",
Position = UDim2.new(0, 16, 0, 13),
Size = UDim2.new(1, -32, 0, 20),
BackgroundTransparency = 1,
Text = label,
TextColor3 = Color3.fromRGB(226, 227, 233),
TextSize = 16,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = 5001,
}, SettingsFrame)
local SFContainer = Instance.new('ScrollingFrame')
SFContainer.Name = "Container"
SFContainer.AnchorPoint = Vector2.new(0, 0)
SFContainer.Position = UDim2.new(0.04, 0, 0, PLATE_HEADER + 3 / GetMainFrameScale())
SFContainer.Size = UDim2.new(0.92, 0, 1, -(PLATE_HEADER + 10 / GetMainFrameScale()))
SFContainer.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
SFContainer.BackgroundTransparency = 1
SFContainer.LayoutOrder = 1
SFContainer.ZIndex = 5001
SFContainer.Active = true
SFContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
SFContainer.CanvasSize = UDim2.new()
SFContainer.ScrollingEnabled = false
SFContainer.ScrollingDirection = Enum.ScrollingDirection.Y
SFContainer.ScrollBarThickness = 0
SFContainer.ScrollBarImageTransparency = 1
SFContainer.ClipsDescendants = false
SFContainer.Parent = SettingsFrame
local SFLayout = Instance.new('UIListLayout')
SFLayout.Name = "UIListLayout"
SFLayout.Padding = UDim.new(0, 0)
SFLayout.SortOrder = Enum.SortOrder.LayoutOrder
SFLayout.Parent = SFContainer
SFContainer.DescendantAdded:Connect(function(d)
if d.Name == "Lines" and d:IsA("GuiObject") then d.Visible = false end
end)
for _, d in ipairs(SFContainer:GetDescendants()) do
if d.Name == "Lines" and d:IsA("GuiObject") then d.Visible = false end
end
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = SFContainer end
Stroke(SFContainer, "CardOutline").Transparency = 0.955
New("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, SFContainer)
local function UpdateSettingsLayout()
local scale = GetMainFrameScale()
SFContainer.Position = UDim2.new(0.04, 0, 0, PLATE_HEADER + 3 / scale)
SFContainer.Size = UDim2.new(0.92, 0, 1, -(PLATE_HEADER + 10 / scale))
end
local function GetSettingsContentHeight()
local measured = MeasureRowsHeight(SFContainer)
if measured > 0 then return measured end
local rowCount = 0
for _, child in ipairs(SFContainer:GetChildren()) do
if child:IsA("GuiObject") then rowCount = rowCount + 1 end
end
if rowCount <= 0 then return 0 end
local estimated = EstimateRowsHeight(SFContainer, rowCount, 8.5)
if estimated > 0 then return estimated end
return rowCount * 34 * GetMainFrameScale()
end
local function getSettingsHeight()
UpdateSettingsLayout()
local scale = GetMainFrameScale()
local contentVisual = GetSettingsContentHeight()
local desiredVisual = math.max(34 * scale, contentVisual + (18 + PLATE_HEADER) * scale)
return desiredVisual / scale
end
local function placeSettings(height)
local scale = GetMainFrameScale()
UpdateSettingsLayout()
local mainPosition, mainSize = PopupSafeArea()
local minHeight = 30
local width = 280
local edge = 5 * scale
height = math.max(minHeight, type(height) == "number" and height == height and height or minHeight)
local parentPosition = parentFrame.AbsolutePosition
local parentSize = parentFrame.AbsoluteSize
if mainSize.X <= 0 or mainSize.Y <= 0 or parentSize.X <= 0 or parentSize.Y <= 0 then return end
local visualHeight = height * scale
local mainLeft = mainPosition.X
local mainRight = mainPosition.X + mainSize.X
local mainTop = mainPosition.Y
local mainBottom = mainPosition.Y + mainSize.Y
local panelWidth = width * scale
local leftX = SettingsBtn.AbsolutePosition.X + SettingsBtn.AbsoluteSize.X + 8 * scale
leftX = math.clamp(leftX, mainLeft + edge, math.max(mainLeft + edge, mainRight - panelWidth - edge))
local y = parentPosition.Y - 6 * scale
y = math.clamp(y, mainTop + edge, math.max(mainTop + edge, mainBottom - visualHeight - edge))
SettingsFrame.Position = UDim2.new(0, (leftX - parentPosition.X) / scale, 0, (y - parentPosition.Y) / scale)
SettingsFrame.Size = UDim2.fromOffset(width, height)
task.defer(function()
if SettingsFrame.Parent and SettingsFrame.Visible and visualHeight <= mainSize.Y then
ConstrainPopupToMainFrame(SettingsFrame)
end
end)
end
local function closeSF()
settingsOpen = false
ClosePopupsUnder(SettingsFrame)
UnregisterPopup(SettingsFrame)
SmoothClose(SettingsFrame, 0.13)
Tween(SFScale, {Scale = 0.94}, 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
Tween(SettingsBtn, { BackgroundTransparency = 1 }, 0.12)
end
local SettingsObj = {}
SettingsHit.MouseButton1Click:Connect(function()
if settingsOpen then closeSF() else SettingsObj:Open() end
end)
local settingsElemCount = 0
local SettingsFrame_Container = SFContainer
function SettingsObj:AddGroup()
SettingsFrame_Container = StartPlateGroup(SFContainer)
return self
end
function SettingsObj:Open()
if settingsOpen then return self end
settingsOpen = true
CloseAllPopupsExcept(SettingsFrame)
RememberPopupClipping(SettingsFrame)
ForceLiftClipping(SettingsFrame)
SettingsFrame.Visible = false
SFScale.Scale = 0.9
ApplyZIndexLadder(SettingsFrame, NextPopupZ())
placeSettings(getSettingsHeight())
SmoothOpen(SettingsFrame, 0, 0.18)
Tween(SFScale, {Scale = 1}, 0.26, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
if not SettingsBtn:FindFirstChildOfClass("UICorner") then New("UICorner", { CornerRadius = UDim.new(0, 5) }, SettingsBtn) end
SettingsBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Tween(SettingsBtn, { BackgroundTransparency = 0.9 }, 0.12)
RegisterPopup(SettingsFrame, closeSF, SettingsBtn)
local function settle()
if not settingsOpen or not SettingsFrame.Parent then return end
placeSettings(getSettingsHeight())
end
task.defer(settle)
task.delay(0.05, settle)
task.delay(0.25, function() if settingsOpen then SettingsFrame.BackgroundTransparency = 0 end end)
if not settingsLayoutConnection then
local okLayout, layout = pcall(function() return SFContainer:FindFirstChildOfClass("UIListLayout") end)
if okLayout and layout then
pcall(function()
settingsLayoutConnection = layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
if settingsOpen then task.defer(function() if settingsOpen then placeSettings(getSettingsHeight()) end end) end
end)
end)
end
end
return self
end
function SettingsObj:Close()
if settingsOpen then closeSF() end
return self
end
function SettingsObj:AddToggle(text, default, callback)
settingsElemCount = settingsElemCount + 1
local enabled = default == true
local Toggle = New("Frame", {
Name = "Toggle",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = settingsElemCount,
}, SettingsFrame_Container)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 1000,
BorderSizePixel = 0,
}, Toggle)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04800000086426735, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.7600000262260437, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 1001,
}, Toggle)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(1, -14, 0.5, 0),
AnchorPoint = Vector2.new(1, 0.5),
Size = UDim2.fromOffset(33, 20),
BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16),
ZIndex = 1001,
}, Toggle)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Effect)
local Icon = New("Frame", {
Name = "Icon",
Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2),
Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
BackgroundTransparency = 0,
ZIndex = 1002,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Icon)
New("UIAspectRatioConstraint", {}, Icon)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 1010,
}, Toggle)
local function Set(val)
enabled = val == true
Tween(Effect, { BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16) }, 0.16, Enum.EasingStyle.Sine)
Tween(Icon, { Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2), BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157), BackgroundTransparency = 0 }, 0.16, Enum.EasingStyle.Quad)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
RegisterConfigElement("settings_toggle_", text, obj)
return obj
end
function SettingsObj:AddCheckbox(text, default, callback)
settingsElemCount = settingsElemCount + 1
local enabled = default == true
local CheckBoxToggle = New("Frame", {
Name = "CheckBoxToggle",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = settingsElemCount,
}, SettingsFrame_Container)
local CheckBox = New("Frame", {
Name = "CheckBox",
Position = UDim2.new(0.04, 0, 0.3, 0),
Size = UDim2.new(0.075, 0, 0.7, 0),
BackgroundTransparency = 1,
ZIndex = 1001,
}, CheckBoxToggle)
New("UICorner", {}, CheckBox)
New("UIAspectRatioConstraint", {}, CheckBox)
local Check = New("ImageLabel", {
Name = "Check",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Image = "rbxassetid://138494545053627",
ImageTransparency = enabled and 0.1 or 1,
ZIndex = 1001,
}, CheckBox)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.15, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.7600000262260437, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 1001,
}, CheckBoxToggle)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 1010,
}, CheckBoxToggle)
local function Set(val)
enabled = val == true
Tween(Check, { ImageTransparency = enabled and 0.1 or 1 }, 0.2)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
RegisterConfigElement("settings_checkbox_", text, obj)
return obj
end
function SettingsObj:AddSlider(text, min, max, default, callback, suffix)
settingsElemCount = settingsElemCount + 1
if type(suffix) ~= "string" then suffix = "" end
local value
min, max, value = NormalizeRange(min, max, default)
value = Quantize(value, min, max, GetSliderStep(min, max))
local initRatio = (value - min) / (max - min)
local dragging = false
local Slider = New("Frame", {
Name = "Slider",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = settingsElemCount,
ZIndex = 1000,
}, SettingsFrame_Container)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 1002,
BorderSizePixel = 0,
}, Slider)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04800000086426735, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.36, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = 1001,
}, Slider)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(0.4980000042915344, 0, 0.25, 0),
Size = UDim2.new(0.5, 0, 0.6990000009536743, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
ZIndex = 1001,
}, Slider)
local SliderValue = New("TextLabel", {
Name = "SliderValue",
Position = UDim2.new(0.6990000009536743, 0, 0.10000000149011612, 0),
Size = UDim2.new(0.25, 0, 0.8080000281333923, 0),
BackgroundColor3 = Color3.fromRGB(33,37,53),
Text = FormatSliderValue(value, suffix),
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.20000000298023224,
ZIndex = 1002,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, SliderValue)
local Line = New("Frame", {
Name = "Line",
Active = true,
Position = UDim2.new(0.03999999910593033, 0, 0.3190000057220459, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.24, 0),
BackgroundColor3 = Color3.fromRGB(33,37,53),
ZIndex = 1001,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Line)
local InLine = New("Frame", {
Name = "InLine",
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = mainColor,
ZIndex = 1002,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, InLine)
SizeSliderChip(Effect, Line, SliderValue)
Effect.AnchorPoint = Vector2.new(0, 0.5)
Effect.Position = UDim2.new(0.45, 0, 0.5, 0)
Effect.Size = UDim2.new(0.55, -14, 0, 22)
Line.Size = UDim2.new(1, -(SliderValue.Size.X.Offset + 10), 0, 3)
Line.Position = UDim2.new(0, 0, 0.5, 0)
local Trigger = New("TextButton", {
Name = "Trigger",
Position = UDim2.new(0.10000000149011612, 0, -1.8000000715255737, 0),
Size = UDim2.new(1.1999999284744263, 0, 4.200000286102295, 0),
AnchorPoint = Vector2.new(0.800000011920929, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
Active = false,
Text = "",
ZIndex = 1003,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Trigger)
New("UIAspectRatioConstraint", {}, Trigger)
local Thumb = New("Frame", {
Name = "Thumb",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(initRatio, 0, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(248, 250, 255),
BorderSizePixel = 0,
ZIndex = Line.ZIndex + 3,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Thumb)
Stroke(Thumb)
Line.MouseEnter:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(14, 14) }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
Line.MouseLeave:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(12, 12) }, 0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
local initialValue = value
task.defer(function()
if value ~= initialValue then return end
InLine.Size = UDim2.fromScale(initRatio, 1)
Thumb.Position = UDim2.new(initRatio, 0, 0.5, 0)
Trigger.Position = UDim2.new(initRatio, 0, -1.8000000715255737, 0)
end)
local function update(input)
local pointer = GetInputPosition(input)
local lineSize = Line.AbsoluteSize.X
if lineSize <= 0 then return end
local sizeScale = ClampRatio(pointer.X - Line.AbsolutePosition.X, lineSize)
local nextValue = Quantize(((max - min) * sizeScale) + min, min, max, GetSliderStep(min, max))
local changed = nextValue ~= value
value = nextValue
local span = max - min
local snappedRatio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
InLine.Size = UDim2.fromScale(snappedRatio, 1)
Trigger.Position = UDim2.new(snappedRatio, 0, -1.8000000715255737, 0)
Thumb.Position = UDim2.new(snappedRatio, 0, 0.5, 0)
SliderValue.Text = FormatSliderValue(value, suffix)
if changed then InvokeCallback(callback, value) end
end
Line.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then
dragging = true; update(input)
end
end)
UserInputService.InputEnded:Connect(function(input)
if IsPrimaryInput(input) then
dragging = false
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
update(input)
end
end)
local obj = {}
function obj:Set(val)
local numeric = type(val) == "number" and val == val and val or min
value = math.clamp(numeric, min, max)
value = Quantize(value, min, max, GetSliderStep(min, max))
local span = max - min
local ratio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
Tween(InLine, { Size = UDim2.fromScale(ratio, 1) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Trigger.Position = UDim2.new(ratio, 0, -1.8000000715255737, 0)
Tween(Thumb, { Position = UDim2.new(ratio, 0, 0.5, 0) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
SliderValue.Text = FormatSliderValue(value, suffix)
InvokeCallback(callback, value)
end
function obj:Get() return value end
RegisterConfigElement("settings_slider_", text, obj)
return obj
end
function SettingsObj:AddDropdown(text, options, default, callback)
if type(default) == "function" then callback = default; default = nil end
options = NormalizeOptions(options)
settingsElemCount = settingsElemCount + 1
local selected = GetValidOption(options, default)
local dropOpen = false
local selectedBtns = {}
local Selection = New("Frame", {
Name = "Selection",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = settingsElemCount,
ClipsDescendants = false,
ZIndex = 1000,
}, SettingsFrame_Container)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.05000000074505806, 0, 1, 0),
Size = UDim2.new(0.8999999761581421, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 1000,
}, Selection)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04800000041723251, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 1001,
}, Selection)
local SelArrow = New("ImageLabel", {
Name = "TextArrow",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageColor3 = Color3.fromRGB(255, 255, 255),
ImageTransparency = 0.10000000149011612,
ScaleType = Enum.ScaleType.Fit,
Rotation = 0,
ZIndex = 1000,
}, Selection)
local TextDefault = New("TextLabel", {
Name = "TextDefault",
Position = UDim2.new(0.60, 0, 0.25, 0),
Size = UDim2.new(0.29, 0, 0.6, 0),
TextTruncate = Enum.TextTruncate.AtEnd,
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = options[1] or "Auto",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0,
TextTruncate = Enum.TextTruncate.AtEnd,
TextSize = 14,
ZIndex = 1001,
TextXAlignment = Enum.TextXAlignment.Left,
}, Selection)
local DropPopup = New("Frame", {
Name = "Dropdown",
Position = UDim2.new(0.60, 0, 1, 4),
Size = UDim2.fromOffset(150, 0),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BackgroundTransparency = 0,
BorderSizePixel = 0,
Visible = false,
ZIndex = 5000,
}, Selection)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, DropPopup)
do Stroke(DropPopup) end
local DropContainer = New("ScrollingFrame", {
AutomaticCanvasSize = Enum.AutomaticSize.Y,
Name = "Container",
Position = UDim2.fromOffset(6, 6),
Size = UDim2.new(1, -12, 1, -12),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
ZIndex = 5000,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 2,
ScrollBarImageTransparency = 0.5,
}, DropPopup)
New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) }, DropContainer)
local function closeDropdown()
dropOpen = false
Tween(SelArrow, {Rotation = -90}, 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
UnregisterPopup(DropPopup)
SmoothClose(DropPopup, 0.18)
end
local function updateCheckmarks()
for opt, selBtn in pairs(selectedBtns) do
local isSelected = opt == selected
selBtn.Visible = isSelected
selBtn.ImageColor3 = mainColor
local row = selBtn.Parent
if row then
row.BackgroundTransparency = 1
local label = row:FindFirstChild("Label") or row:FindFirstChildWhichIsA("TextLabel")
if label then label.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180) end
end
end
end
for i, opt in ipairs(options) do
local BtnRow = New("Frame", {
Name = "Buttons",
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
ZIndex = 5001,
LayoutOrder = i,
}, DropContainer)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, BtnRow)
New("TextLabel", {
Name = "Label",
Position = UDim2.new(0, 28, 0, 0),
Size = UDim2.new(1, -36, 1, 0),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Text = opt,
TextColor3 = Color3.fromRGB(200, 204, 218),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTruncate = Enum.TextTruncate.AtEnd,
TextTransparency = 0,
ZIndex = 5002,
TextXAlignment = Enum.TextXAlignment.Left,
}, BtnRow)
local SelBtn = New("ImageButton", {
Name = "Selected",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 4, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Image = "rbxassetid://138494545053627",
ImageColor3 = mainColor,
Visible = false,
ZIndex = 5006,
}, BtnRow)
selectedBtns[opt] = SelBtn
local RowBtn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 5005,
}, BtnRow)
RowBtn.MouseEnter:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 0.97 }, 0.08)
end)
RowBtn.MouseLeave:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 1 }, 0.12)
end)
RowBtn.MouseButton1Click:Connect(function()
selected = opt
TextDefault.Text = opt
updateCheckmarks()
closeDropdown()
InvokeCallback(callback, opt)
end)
SelBtn.MouseButton1Click:Connect(function()
selected = opt
TextDefault.Text = opt
updateCheckmarks()
closeDropdown()
InvokeCallback(callback, opt)
end)
end
local OpenBtn = New("TextButton", {
Name = "OpenBtn",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 1500,
}, Selection)
OpenBtn.MouseButton1Click:Connect(function()
if dropOpen then closeDropdown()
else
CloseAllPopupsExcept(DropPopup)
dropOpen = true
local popupW = math.max(TextDefault.AbsoluteSize.X, 150)
local popupH = math.min(#options, 8) * 30 + 10
DropPopup.Size = UDim2.fromOffset(popupW, popupH)
DropPopup.BackgroundTransparency = 0
DropPopup.Visible = false
ApplyZIndexLadder(DropPopup, NextPopupZ())
DropPopup.Visible = true
WindowObj._centerPopupOnField(DropPopup, TextDefault)
SmoothOpen(DropPopup, 0, 0.14)
RegisterPopup(DropPopup, closeDropdown, OpenBtn)
end
end)
TextDefault.Text = selected;
updateCheckmarks()
local obj = {}
function obj:Set(val, silent)
val = GetValidOption(options, val)
selected = val
TextDefault.Text = val
updateCheckmarks()
if not silent then InvokeCallback(callback, val) end
end
function obj:Get() return selected end
RegisterConfigElement("settings_dropdown_", text, obj)
return obj
end
function SettingsObj:AddColorpicker(text, defaultColor, callback)
settingsElemCount = settingsElemCount + 1
local initialColor = NormalizeColor(defaultColor)
local Colorpicker = New("Frame", {
Name = "Colorpicker",
Size = UDim2.new(1, 0, 0, 34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = settingsElemCount,
ClipsDescendants = false,
ZIndex = 1000,
}, SettingsFrame_Container)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.68, 0, 1, 0),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(230, 230, 230),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 1001,
}, Colorpicker)
local colorpickerButton = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = initialColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 1010,
}, Colorpicker)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, colorpickerButton)
Stroke(colorpickerButton, "ColorpickerButtonStroke")
local picker = AcrylicBlur.CreateColorPicker(colorpickerButton, initialColor, function(c)
InvokeCallback(callback, c)
end)
local obj = {}
function obj:Set(c)
local normalized = NormalizeColor(c)
picker.Set(normalized)
InvokeCallback(callback, normalized)
end
function obj:Get() return picker.Get() end
RegisterConfigElement("settings_colorpicker_", text, obj)
return obj
end
MakeReadableText(SettingsFrame, 10, 18)
settingsCache[parentFrame] = SettingsObj
return SettingsObj
end
local _contextTargets = _windowContextTargets
local _contextMenu
local _contextOpen = false
local _contextTarget
local _bindTarget
local _bindMenu
local _keybinds = {}
local _bindListener
local function GetTargetBindLabel(target)
if not target or not target.key then return "Not bound" end
return BindKeyName(target.key)
end
local function PaintBindDots(owner)
if not owner or not owner.dots then return end
owner.dots.Visible = true
local indicator = owner.dots:FindFirstChild("BindLabel")
if not indicator then return end
local text = ""
for _, b in ipairs(owner.binds or {}) do
if b.key then text = BindKeyName(b.key) break end
end
indicator.Text = text
end
local function SetTargetBind(target, key)
if not target or not target.obj then return end
if target.key and _keybinds[target.key] == target then _keybinds[target.key] = nil end
if key then
local previous = _keybinds[key]
if previous and previous ~= target then
previous.key = nil
PaintBindDots(previous.owner or previous)
end
end
target.key = key
if key then _keybinds[key] = target end
PaintBindDots(target.owner or target)
if RefreshKeybindOverlay then
task.defer(RefreshKeybindOverlay)
end
end
WindowObj._bindSnapshot = function()
local out = {}
for key, target in pairs(_keybinds) do
if target and target.label and key and not target.hideInList then
local value
local numberBind = rawget(target, "bindValue") ~= nil
if numberBind then
local n = rawget(target, "bindValue")
value = (n % 1 == 0) and tostring(n) or string.format("%.1f", n)
local readout = target.row and target.row:FindFirstChild("SliderValue", true)
local unit = readout and readout:IsA("TextLabel") and string.gsub(readout.Text, "[%d%.%-%s]", "") or ""
value = value .. unit
elseif target.showValue and target.obj and type(target.obj.Get) == "function" then
local ok, v = pcall(target.obj.Get, target.obj)
if ok and type(v) == "number" then
value = (v % 1 == 0) and tostring(v) or string.format("%.1f", v)
elseif ok and type(v) == "string" and v ~= "" then
value = #v > 12 and (v:sub(1, 11) .. "…") or v
end
end
local state, listed = nil, true
if numberBind then
listed = rawget(target, "active") == true
elseif target.obj and type(target.obj.Get) == "function" then
local ok, v = pcall(target.obj.Get, target.obj)
if ok and type(v) == "boolean" then
state = v
listed = v
end
end
if not target.listLabel then
local label = target.label
local generic = { enabled = true, enable = true, active = true, on = true, toggle = true }
if generic[string.lower(label)] then
local node = target.row
while node and not node:GetAttribute("NLTabName") do node = node.Parent end
if node then
local section = tostring(node:GetAttribute("NLSectionName") or "")
local plain = { [""] = true, main = true, general = true, other = true, settings = true, misc = true }
label = plain[string.lower(section)] and tostring(node:GetAttribute("NLTabName")) or section
end
end
target.listLabel = label
end
if listed then
table.insert(out, { label = target.listLabel, key = BindKeyName(key), mode = target.bindMode or "toggle", value = value, on = state })
end
end
end
table.sort(out, function(a, b) return a.label:lower() < b.label:lower() end)
return out
end
local bindRefs = {}
local function CloseBindMenu()
UnregisterPopup(_bindMenu)
bindRefs.listening = false
if not _bindMenu then return end
if _bindMenu.Visible then SmoothClose(_bindMenu, 0.14) end
_bindTarget = nil
end
local BIND_MODES = { "toggle", "hold", "always" }
local function CurrentBindMode(target)
return target and target.bindMode or "toggle"
end
local function BindValueText(target)
if target and target.obj and type(target.obj.Get) == "function" then
local ok, value = pcall(target.obj.Get, target.obj)
if ok and value ~= nil then
if typeof(value) == "Color3" then return ColorToHex(value) end
if type(value) == "boolean" then return value and "On" or "Off" end
if type(value) == "number" or type(value) == "string" then
local text = tostring(value)
return #text > 12 and (string.sub(text, 1, 11) .. "…") or text
end
end
end
return "—"
end
local function PaintBindMenu(target)
local keyText = bindRefs.listening and "..." or (target.key and BindKeyName(target.key) or "-")
bindRefs.key.Text = keyText
bindRefs.key.Size = UDim2.fromOffset(math.max(20, math.ceil(MeasureText(keyText, 12, FONT) + 12)), 20)
local mode = CurrentBindMode(target)
bindRefs.modeText.Text = mode:sub(1, 1):upper() .. mode:sub(2)
bindRefs.modeChip.Size = UDim2.fromOffset(math.ceil(MeasureText(bindRefs.modeText.Text, 13, FONT) + 34), 22)
for name, glyph in pairs(bindRefs.modeGlyphs) do glyph.Visible = name == mode end
local item = bindRefs.itemFor and bindRefs.itemFor[target]
if item and item.Parent then item.Text = target.key and BindKeyName(target.key) or "None" end
bindRefs.setSwitch("value", target.showValue == true)
local numeric = target.min ~= nil and target.max ~= nil
local valueSwitch = bindRefs.switches and bindRefs.switches.value
if valueSwitch then valueSwitch.track.Visible = not numeric end
if bindRefs.valueBox then
bindRefs.valueBox.Visible = numeric
if numeric then
if rawget(target, "bindValue") == nil then
local ok, v = pcall(target.obj.Get, target.obj)
target.bindValue = ok and tonumber(v) or target.min
end
local n = target.bindValue
bindRefs.valueBox.Text = (n % 1 == 0) and tostring(n) or string.format("%.1f", n)
end
end
bindRefs.setSwitch("visible", not target.hideInList)
end
local function BuildBindMenu()
if _bindMenu then return _bindMenu end
local ICON = Color3.fromRGB(200, 201, 210)
local TEXT = Color3.fromRGB(235, 236, 241)
local RED = Color3.fromRGB(226, 96, 116)
_bindMenu = New("Frame", {
Name = "BindPrompt",
Size = UDim2.fromOffset(196, 166),
BackgroundColor3 = Color3.fromRGB(18, 18, 25),
BackgroundTransparency = 0,
BorderSizePixel = 0,
Visible = false,
ZIndex = Z_BASE + 950,
ClipsDescendants = false,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, _bindMenu)
Stroke(_bindMenu)
AttachShadow(_bindMenu, { radius = 10, layers = 5, step = 1.6, bias = 3 })
local body = New("Frame", { Name = "Body", Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = Z_BASE + 951 }, _bindMenu)
New("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, body)
New("UIListLayout", { Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder }, body)
local function makeRow(order, icon, text, color)
local row = New("TextButton", {
Name = "Row" .. order, LayoutOrder = order, Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 1, AutoButtonColor = false, Text = "", ZIndex = Z_BASE + 952,
}, body)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
if icon then
New("ImageLabel", {
Name = "Icon", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1, Image = icon, ImageColor3 = color == RED and RED or ICON, ScaleType = Enum.ScaleType.Fit, ZIndex = Z_BASE + 953,
}, row)
end
New("TextLabel", {
Name = "Label", Position = UDim2.new(0, 36, 0, 0), Size = UDim2.new(0, 70, 1, 0), BackgroundTransparency = 1,
Text = text, TextColor3 = color, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = Z_BASE + 953,
}, row)
row.MouseEnter:Connect(function() Tween(row, { BackgroundTransparency = 0.97 }, 0.08) end)
row.MouseLeave:Connect(function() Tween(row, { BackgroundTransparency = 1 }, 0.12) end)
return row
end
local function gap(order)
New("Frame", { Name = "Gap" .. order, LayoutOrder = order, Size = UDim2.new(1, 0, 0, 6), BackgroundTransparency = 1, ZIndex = Z_BASE + 952 }, body)
end
local keyRow = makeRow(1, "rbxassetid://10734974522", "Key", TEXT)
bindRefs.key = New("TextLabel", {
Name = "KeyChip", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = Color3.fromRGB(28, 29, 39), BackgroundTransparency = 0, Text = "-", TextColor3 = Color3.fromRGB(190, 192, 202),
TextSize = 12, Font = FONT, ZIndex = Z_BASE + 953,
}, keyRow)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, bindRefs.key)
keyRow.MouseButton1Click:Connect(function()
if not _bindTarget then return end
bindRefs.listening = true
PaintBindMenu(_bindTarget)
end)
local modeRow = makeRow(2, "rbxassetid://10723416765", "Mode", TEXT)
bindRefs.modeChip = New("Frame", {
Name = "ModeChip", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -30, 0.5, 0), Size = UDim2.fromOffset(74, 22),
BackgroundColor3 = Color3.fromRGB(28, 29, 39), BackgroundTransparency = 0, ZIndex = Z_BASE + 953,
}, modeRow)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, bindRefs.modeChip)
bindRefs.modeText = New("TextLabel", {
Name = "ModeText", Position = UDim2.fromOffset(26, 0), Size = UDim2.new(1, -30, 1, 0), BackgroundTransparency = 1,
Text = "Toggle", TextColor3 = mainColor, TextSize = 13, Font = FONT, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = Z_BASE + 954,
}, bindRefs.modeChip)
bindRefs.modeGlyphs = {}
for mode, asset in pairs({ toggle = "rbxassetid://10734985040", hold = "rbxassetid://10723405649", always = "rbxassetid://10709797837" }) do
bindRefs.modeGlyphs[mode] = New("ImageLabel", {
Name = "ModeGlyph_" .. mode, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0), Size = UDim2.fromOffset(15, 15),
BackgroundTransparency = 1, Image = asset, ImageColor3 = mainColor, ScaleType = Enum.ScaleType.Fit,
ZIndex = Z_BASE + 954, Visible = false,
}, bindRefs.modeChip)
end
New("ImageLabel", {
Name = "ModeMore", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1, Image = "rbxassetid://10709790948", ImageColor3 = ICON, ScaleType = Enum.ScaleType.Fit,
ZIndex = Z_BASE + 953,
}, modeRow)
modeRow.MouseButton1Click:Connect(function()
if not _bindTarget then return end
local current, index = CurrentBindMode(_bindTarget), 1
for i, m in ipairs(BIND_MODES) do if m == current then index = i break end end
_bindTarget.bindMode = BIND_MODES[(index % #BIND_MODES) + 1]
PaintBindMenu(_bindTarget)
if RefreshKeybindOverlay then task.defer(RefreshKeybindOverlay) end
end)
gap(3)
bindRefs.switches = {}
bindRefs.setSwitch = function(name, on)
local s = bindRefs.switches[name]
if not s then return end
Tween(s.track, { BackgroundColor3 = on and mainColor or Color3.fromRGB(8, 10, 16) }, 0.15)
Tween(s.knob, {
Position = on and UDim2.fromOffset(14, 2) or UDim2.fromOffset(2, 2),
BackgroundColor3 = on and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
}, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end
local function switchRow(order, icon, text, name, onClick)
local row = makeRow(order, icon, text, TEXT)
local track = New("Frame", {
Name = "Switch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(28, 16),
BackgroundColor3 = Color3.fromRGB(8, 10, 16), BorderSizePixel = 0, ZIndex = Z_BASE + 953,
}, row)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, track)
local knob = New("Frame", {
Name = "Knob", Position = UDim2.fromOffset(2, 2), Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(139, 145, 157), BorderSizePixel = 0, ZIndex = Z_BASE + 954,
}, track)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, knob)
bindRefs.switches[name] = { track = track, knob = knob }
row.MouseButton1Click:Connect(function()
if not _bindTarget then return end
onClick(_bindTarget)
PaintBindMenu(_bindTarget)
if RefreshKeybindOverlay then task.defer(RefreshKeybindOverlay) end
end)
end
switchRow(4, "rbxassetid://10723426722", "Value", "value", function(t)
if t.min ~= nil and t.max ~= nil then
if bindRefs.valueBox then bindRefs.valueBox:CaptureFocus() end
return
end
t.showValue = not t.showValue
end)
do
local valueRow = body:FindFirstChild("Row4")
local box = New("TextBox", {
Name = "ValueBox", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(52, 20),
BackgroundColor3 = Color3.fromRGB(28, 29, 39), BackgroundTransparency = 0, Text = "", PlaceholderText = "0",
TextColor3 = Color3.fromRGB(235, 236, 241), TextSize = 12, Font = FONT, ClearTextOnFocus = false,
Visible = false, ZIndex = Z_BASE + 954,
}, valueRow)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, box)
bindRefs.valueBox = box
box.FocusLost:Connect(function()
local t = _bindTarget
if not t or t.min == nil or t.max == nil then return end
local n = tonumber((string.gsub(box.Text, "[^%d%.%-]", "")))
if n then
t.bindValue = math.clamp(n, t.min, t.max)
if t.active then t.obj:Set(t.bindValue) end
end
PaintBindMenu(t)
if RefreshKeybindOverlay then task.defer(RefreshKeybindOverlay) end
end)
end
switchRow(5, "rbxassetid://10723346959", "Visible", "visible", function(t) t.hideInList = not t.hideInList end)
gap(6)
local delRow = makeRow(7, "rbxassetid://10747362241", "Delete", RED)
delRow.MouseButton1Click:Connect(function()
local t = _bindTarget
CloseBindMenu()
if t then bindRefs.removeBind(t) end
end)
return _bindMenu
end
local function OpenBindMenu(target, anchor, trigger)
if not anchor then CloseAllPopupsExcept(nil) end
_bindTarget = target
bindRefs.listening = false
BuildBindMenu()
PaintBindMenu(target)
ApplyZIndexLadder(_bindMenu, NextPopupZ())
SmoothOpen(_bindMenu, 0, 0.16)
if anchor and anchor.Parent and anchor.Visible then
MovePopupToAbsolute(_bindMenu, anchor.AbsolutePosition.X + anchor.AbsoluteSize.X + 6, anchor.AbsolutePosition.Y)
else
local row = target.row
MovePopupToAbsolute(_bindMenu,
row.AbsolutePosition.X + row.AbsoluteSize.X - _bindMenu.AbsoluteSize.X,
row.AbsolutePosition.Y + row.AbsoluteSize.Y + 4)
end
ConstrainPopupToMainFrame(_bindMenu, 8)
RegisterPopup(_bindMenu, CloseBindMenu, trigger)
end
local function CloseContextMenu()
if not _contextMenu then return end
_contextOpen = false
_contextTarget = nil
UnregisterPopup(_contextMenu)
SmoothClose(_contextMenu, 0.15)
end
local function BuildContextMenu()
if _contextMenu then return _contextMenu end
_contextMenu = New("Frame", {
Name = "ElementContextMenu",
Position = UDim2.new(0.5, 0, 0.5, 0),
Size = UDim2.fromOffset(136, 102),
BackgroundColor3 = Color3.fromRGB(18, 18, 25),
BackgroundTransparency = 0,
BorderSizePixel = 0,
Visible = false,
ZIndex = 8000,
ClipsDescendants = false,
}, MainFrame)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, _contextMenu)
Stroke(_contextMenu)
AttachShadow(_contextMenu, { radius = 10, layers = 5, step = 1.6, bias = 3 })
local list = New("Frame", { Name = "Items", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, ZIndex = 8001 }, _contextMenu)
New("UIListLayout", { Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder }, list)
New("UIPadding", { PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, list)
return _contextMenu
end
local contextItemOrder = 0
local function AddContextItem(labelText, iconAsset, callback, keepOpen)
contextItemOrder = contextItemOrder + 1
local isReset = labelText == "Reset"
local list = _contextMenu:FindFirstChild("Items")
local item = New("TextButton", {
LayoutOrder = contextItemOrder,
Name = "MenuItem",
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
AutoButtonColor = false,
Text = labelText,
TextColor3 = isReset and Color3.fromRGB(226, 96, 116) or Color3.fromRGB(235, 236, 241),
TextScaled = false,
TextSize = 13,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 8002,
}, list)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, item)
New("UIPadding", { PaddingLeft = UDim.new(0, 36) }, item)
local icon = New("ImageLabel", {
Name = "MenuIcon",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, -26, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Image = iconAsset or "",
ImageColor3 = isReset and Color3.fromRGB(226, 96, 116) or Color3.fromRGB(200, 201, 210),
ScaleType = Enum.ScaleType.Fit,
ZIndex = 8003,
}, item)
item.MouseEnter:Connect(function()
Tween(item, { BackgroundTransparency = 0.97 }, 0.08)
end)
item.MouseLeave:Connect(function()
Tween(item, { BackgroundTransparency = 1 }, 0.12)
end)
item.MouseButton1Click:Connect(function()
local target = _contextTarget
if not keepOpen then CloseContextMenu() end
if target and callback then callback(target, item) end
end)
return item, icon
end
bindRefs.newBind = function(owner)
local bind = setmetatable({ owner = owner }, { __index = owner })
table.insert(owner.binds, bind)
return bind
end
bindRefs.removeBind = function(bind)
SetTargetBind(bind, nil)
local owner = bind.owner
if owner then
for i, b in ipairs(owner.binds) do
if b == bind then table.remove(owner.binds, i) break end
end
PaintBindDots(owner)
if _contextOpen and _contextTarget == owner then bindRefs.fillContext(owner) end
end
end
bindRefs.fillContext = function(target)
local list = _contextMenu:FindFirstChild("Items")
for _, child in ipairs(list:GetChildren()) do
if child:IsA("GuiObject") then child:Destroy() end
end
contextItemOrder = 0
bindRefs.itemFor = {}
AddContextItem("All Hotkeys", "rbxassetid://10723433811", function()
if WindowObj.KeybindList then WindowObj.KeybindList.setEnabled(true) end
end)
for _, bind in ipairs(target.binds) do
local item = AddContextItem(bind.key and BindKeyName(bind.key) or "None", "rbxassetid://10723416765", function(_, it)
OpenBindMenu(bind, _contextMenu, it)
end, true)
bindRefs.itemFor[bind] = item
end
AddContextItem("New Hotkey", "rbxassetid://10734923868", function(current)
local bind = bindRefs.newBind(current)
bindRefs.fillContext(current)
OpenBindMenu(bind, _contextMenu, bindRefs.itemFor[bind])
end, true)
New("Frame", { Name = "Gap", LayoutOrder = contextItemOrder + 1, Size = UDim2.new(1, 0, 0, 6), BackgroundTransparency = 1, ZIndex = 8001 }, list)
contextItemOrder = contextItemOrder + 1
AddContextItem("Reset", "rbxassetid://10734940376", function(current)
if current.obj and current.obj.Set and current.defaultValue ~= nil then
current.obj:Set(current.defaultValue)
end
end)
local count = 3 + #target.binds
_contextMenu.Size = UDim2.fromOffset(136, 6 + 28 * count + 6 + 6)
if _contextMenu.Visible then ApplyZIndexLadder(_contextMenu, _contextMenu.ZIndex) end
end
local function OpenContextMenu(target, point)
BuildContextMenu()
CloseAllPopupsExcept(_contextMenu)
_contextTarget = target
bindRefs.fillContext(target)
ApplyZIndexLadder(_contextMenu, NextPopupZ())
SmoothOpen(_contextMenu, 0, 0.15)
MovePopupToAbsolute(_contextMenu, point.X + 4, point.Y + 4)
ConstrainPopupToMainFrame(_contextMenu, 8)
local settled = _contextMenu.Position
_contextMenu.Position = UDim2.new(settled.X.Scale, settled.X.Offset, settled.Y.Scale, settled.Y.Offset - 6)
Tween(_contextMenu, { Position = settled }, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
_contextOpen = true
RegisterPopup(_contextMenu, CloseContextMenu, target.dots)
end
local function IsEditableTarget()
local ok, focused = pcall(function() return UserInputService:GetFocusedTextBox() end)
return not (ok and focused)
end
local function RunBoundFunction(target, phase)
if not target or not target.obj then return end
task.delay(0.05, function() if RefreshKeybindOverlay then pcall(RefreshKeybindOverlay) end end)
local value = target.obj.Get and target.obj:Get()
if type(value) == "number" and rawget(target, "bindValue") ~= nil then
local function apply(on)
if on then
target.prevValue = value
target.obj:Set(target.bindValue)
else
target.obj:Set(target.prevValue or value)
end
target.active = on
end
if phase == "up" then
if target.bindMode == "hold" and target.active then apply(false) end
elseif target.bindMode == "hold" then
if not target.active then apply(true) end
else
apply(not target.active)
end
return
end
if phase == "up" then
if target.bindMode == "hold" and type(value) == "boolean" then
target.obj:Set(false)
end
return
end
if target.bindMode == "hold" and type(value) == "boolean" then
target.obj:Set(true)
return
end
if type(value) == "boolean" then
target.obj:Set(not value)
elseif type(value) == "number" and target.min and target.max then
local step = (target.max - target.min) / 10
target.obj:Set(math.clamp(value + step, target.min, target.max))
elseif type(value) == "string" and target.options then
for index, option in ipairs(target.options) do
if option == value then
target.obj:Set(target.options[index % #target.options + 1] or target.options[1])
break
end
end
end
end
BindElementContext = function(row, kind, label, obj, defaultValue, options, min, max)
if not row or not obj then return end
CleanBorders(row)
local target = {
row = row,
kind = kind,
label = tostring(label or "Function"),
obj = obj,
defaultValue = defaultValue,
options = options,
min = min,
max = max,
}
target.binds = {}
bindRefs.keyCounts = bindRefs.keyCounts or {}
do
local base = tostring(kind) .. ":" .. target.label
bindRefs.keyCounts[base] = (bindRefs.keyCounts[base] or 0) + 1
target.cfgKey = base .. "#" .. bindRefs.keyCounts[base]
end
_contextTargets[row] = target
local dots = row:FindFirstChild("ContextDots")
target.dots = dots
PaintBindDots(target)
if not row:GetAttribute("NightRMBBound") then
row:SetAttribute("NightRMBBound", true)
row.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton2 then
pcall(function()
OpenContextMenu(target, input.Position)
end)
end
end)
local btn = row:FindFirstChildWhichIsA("TextButton", true)
if btn then
btn.MouseButton2Click:Connect(function()
local pos = game:GetService("UserInputService"):GetMouseLocation()
pcall(function()
OpenContextMenu(target, pos)
end)
end)
end
end
if not obj.SetTooltip then
function obj:SetTooltip(text) WindowObj._tooltip(row, text) return self end
end
if obj.Bind then return end
function obj:Bind(key)
local normalized = type(key) == "string" and Enum.KeyCode[key] or key
if normalized and normalized ~= Enum.KeyCode.Unknown then
SetTargetBind(target.binds[1] or bindRefs.newBind(target), normalized)
end
return self:GetBind()
end
function obj:Unbind()
while target.binds[1] do bindRefs.removeBind(target.binds[1]) end
return self:GetBind()
end
function obj:GetBind() return target.binds[1] and target.binds[1].key end
end
WindowObj._configExtras.hotkeys = {
get = function()
local out = {}
for _, target in pairs(_contextTargets) do
if target.cfgKey and target.binds and #target.binds > 0 then
local list = {}
for _, b in ipairs(target.binds) do
local k = rawget(b, "key")
local text = typeof(k) == "EnumItem" and tostring(k) or (type(k) == "string" and k or nil)
table.insert(list, { k = text, m = rawget(b, "bindMode"), h = rawget(b, "hideInList") == true, v = rawget(b, "showValue") == true, n = rawget(b, "bindValue") })
end
out[target.cfgKey] = list
end
end
return out
end,
set = function(saved)
if type(saved) ~= "table" then return end
for _, target in pairs(_contextTargets) do
while target.binds and target.binds[1] do bindRefs.removeBind(target.binds[1]) end
local list = target.cfgKey and saved[target.cfgKey]
if type(list) == "table" then
for _, item in ipairs(list) do
local b = bindRefs.newBind(target)
b.bindMode = item.m
b.hideInList = item.h == true
b.showValue = item.v == true
if type(item.n) == "number" then b.bindValue = item.n end
local key
if type(item.k) == "string" then
local enumType, enumName = item.k:match("^Enum%.(%w+)%.(%w+)$")
if enumType then
pcall(function() key = Enum[enumType][enumName] end)
else
key = item.k
end
end
if key then SetTargetBind(b, key) end
end
end
end
if RefreshKeybindOverlay then task.defer(RefreshKeybindOverlay) end
end,
}
local function IsExtraMouseType(t)
local name
local ok = pcall(function() name = t and t.Name end)
if not ok or type(name) ~= "string" then
name = tostring(t):match("([^%.]+)$")
end
return name == "MouseButton4" or name == "MouseButton5"
end
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if _bindTarget and bindRefs.listening then
local isKeyboard = input.UserInputType == Enum.UserInputType.Keyboard
if isKeyboard or IsExtraMouseType(input.UserInputType) then
local key = isKeyboard and input.KeyCode or input.UserInputType
if key == Enum.KeyCode.Backspace or key == Enum.KeyCode.Delete then
SetTargetBind(_bindTarget, nil)
elseif key ~= Enum.KeyCode.Escape and key ~= Enum.KeyCode.Unknown then
SetTargetBind(_bindTarget, key)
end
bindRefs.listening = false
PaintBindMenu(_bindTarget)
return
end
end
if input.UserInputType == Enum.UserInputType.MouseButton2
or input.UserInputType == Enum.UserInputType.MouseButton3 then
if not MainFrame.Visible then return end
local point = GetInputPosition(input)
for _, entry in ipairs(_openPopups) do
if entry.frame and entry.frame.Visible and IsPointInsideTree(entry.frame, point) then return end
end
for row, target in pairs(_contextTargets) do
if row.Parent and row.Visible and IsPointInsideTree(row, point) then
OpenContextMenu(target, point)
return
end
end
end
end)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
if bindRefs.listening then return end
local key = input.KeyCode
if key == nil or key == Enum.KeyCode.Unknown then
local t = input.UserInputType
if not IsExtraMouseType(t) then return end
key = t
end
if not IsEditableTarget() then return end
local target = _keybinds[key]
if target and target.bindMode ~= "always" then
RunBoundFunction(target, "down")
end
end)
UserInputService.InputChanged:Connect(function(input, gameProcessed)
local wheelType = input.UserInputType
if wheelType ~= Enum.UserInputType.MouseWheel then return end
local wheelKey = input.Position.Z > 0 and "MouseWheelUp" or "MouseWheelDown"
if input.Position.Z == 0 then return end
if _bindTarget and bindRefs.listening then
SetTargetBind(_bindTarget, wheelKey)
bindRefs.listening = false
PaintBindMenu(_bindTarget)
return
end
if gameProcessed or not IsEditableTarget() then return end
local target = _keybinds[wheelKey]
if target then RunBoundFunction(target, "down") end
end)
UserInputService.InputEnded:Connect(function(input)
if not IsEditableTarget() then return end
local key = input.KeyCode
if key == nil or key == Enum.KeyCode.Unknown then key = input.UserInputType end
local target = key and _keybinds[key] or nil
if target and target.bindMode == "hold" then
RunBoundFunction(target, "up")
end
end)
function SectionObj:AddToggle(text, default, callback)
elemCount = elemCount + 1
local enabled = default == true
local Toggle = New("Frame", {
Name = "Toggle",
Size = UDim2.new(1, 0, 0, 39),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 100,
BorderSizePixel = 0,
}, Toggle)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04800000086426735, 0, 0.3, 0),
Size = UDim2.new(0.6600000262260437, 0, 0.5000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
}, Toggle)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(1, -14, 0.5, 0),
AnchorPoint = Vector2.new(1, 0.5),
Size = UDim2.fromOffset(33, 20),
BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16),
}, Toggle)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Effect)
local Icon = New("Frame", {
Name = "Icon",
Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2),
Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
BackgroundTransparency = 0,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Icon)
New("UIAspectRatioConstraint", {}, Icon)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 5,
}, Toggle)
local function Set(val)
enabled = val == true
Tween(Effect, { BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16) }, 0.16, Enum.EasingStyle.Sine)
Tween(Icon, { Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2), BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157), BackgroundTransparency = 0 }, 0.16, Enum.EasingStyle.Quad)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
Btn.MouseButton2Click:Connect(function()
local pos = game:GetService("UserInputService"):GetMouseLocation()
local target = _contextTargets[Toggle]
if target then
pcall(function() OpenContextMenu(target, pos) end)
end
end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
function obj:AddSettings() return MakeSettings(Toggle, nil, text) end
RegisterConfigElement("toggle_", text, obj)
CenterElement(Toggle)
BindElementContext(Toggle, "toggle", text, obj, default)
return obj
end
function SectionObj:AddCheckbox(text, default, callback)
elemCount = elemCount + 1
local enabled = default == true
local CheckBoxToggle = New("Frame", {
Name = "CheckBoxToggle",
Size = UDim2.new(1, 0, 0, 39),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 100,
}, CheckBoxToggle)
local CheckBox = New("Frame", {
Name = "CheckBox",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 15, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundTransparency = 1,
ZIndex = 1001,
}, CheckBoxToggle)
New("UICorner", {}, CheckBox)
New("UIAspectRatioConstraint", {}, CheckBox)
local Check = New("ImageLabel", {
Name = "Check",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Image = "rbxassetid://138494545053627",
ImageTransparency = enabled and 0.1 or 1,
ZIndex = 1001,
}, CheckBox)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(34, 0),
Size = UDim2.new(0.55, 0, 1, 0),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 1001,
}, CheckBoxToggle)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 1010,
}, CheckBoxToggle)
local function Set(val)
enabled = val == true
Tween(Check, {ImageTransparency = enabled and 0.1 or 1}, 0.2)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
function obj:AddSettings() return MakeSettings(CheckBoxToggle, nil, text) end
RegisterConfigElement("checkbox_", text, obj)
CenterElement(CheckBoxToggle)
BindElementContext(CheckBoxToggle, "checkbox", text, obj, default)
return obj
end
function SectionObj:AddColorToggle(text, defaultColor, defaultEnabled, callback)
if type(defaultEnabled) == "function" then
callback = defaultEnabled
defaultEnabled = false
end
if type(callback) ~= "function" then callback = nil end
local state = {
enabled = defaultEnabled == true,
color = NormalizeColor(defaultColor),
}
return SectionObj:AddToggleColorpicker(text, state.enabled, state.color,
function(enabled)
state.enabled = enabled
if callback then callback(state.color, enabled) end
end,
function(newColor)
state.color = newColor
if callback then callback(newColor, state.enabled) end
end)
end
function SectionObj:AddToggleColorpicker(text, defaultEnabled, defaultColor, callback, colorCallback)
if type(callback) ~= "function" then callback = nil end
if type(colorCallback) ~= "function" then colorCallback = nil end
elemCount = elemCount + 1
local enabled = defaultEnabled == true
local color = NormalizeColor(defaultColor)
local Toggle = New("Frame", {
Name = "Toggle",
Size = UDim2.new(1, 0, 0, 39),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 3,
}, Toggle)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.6, 0, 1, 0),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 5,
}, Toggle)
local Effect = New("Frame", {
Name = "Effect",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(33, 20),
BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16),
ZIndex = 6,
}, Toggle)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Effect)
local Icon = New("Frame", {
Name = "Icon",
Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2),
Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
BorderSizePixel = 0,
ZIndex = 7,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Icon)
local cpBtn = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -55, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = color,
BorderSizePixel = 0,
Image = "",
ZIndex = 8,
}, Toggle)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, cpBtn)
Stroke(cpBtn, "ColorpickerButtonStroke")
local Btn = New("TextButton", {
Name = "ToggleHitArea",
Position = UDim2.new(0, 0, 0, 0),
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 4,
}, Toggle)
local function NotifyColor(c)
color = NormalizeColor(c)
if colorCallback then
InvokeCallback(colorCallback, color)
elseif callback then
InvokeCallback(callback, color, enabled)
end
end
local function NotifyEnabled()
if colorCallback then
if callback then InvokeCallback(callback, enabled) end
elseif callback then
InvokeCallback(callback, color, enabled)
end
end
local picker = AcrylicBlur.CreateColorPicker(cpBtn, color, NotifyColor)
local function SetEnabled(val)
enabled = val == true
Tween(Effect, { BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16) }, 0.16, Enum.EasingStyle.Sine)
Tween(Icon, { Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2), BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157), BackgroundTransparency = 0 }, 0.16, Enum.EasingStyle.Quad)
NotifyEnabled()
end
Btn.MouseButton1Click:Connect(function() SetEnabled(not enabled) end)
local obj = {}
function obj:Set(val) SetEnabled(val) end
function obj:Get() return enabled end
function obj:SetColor(c)
local normalized = NormalizeColor(c)
picker.Set(normalized)
NotifyColor(normalized)
end
function obj:GetColor() return color end
function obj:AddSettings() return MakeSettings(Toggle, nil, text) end
RegisterConfigElement("togglecolorpicker_", text, obj)
RegisterConfigElement("togglecolorpicker_color_", text, {
Get = function() return obj:GetColor() end,
Set = function(_, c) obj:SetColor(c) end,
})
CenterElement(Toggle)
BindElementContext(Toggle, "togglecolorpicker", text, obj, defaultEnabled)
return obj
end
function SectionObj:AddSlider(text, min, max, default, callback, suffix)
elemCount = elemCount + 1
if type(suffix) ~= "string" then suffix = "" end
local value
min, max, value = NormalizeRange(min, max, default)
value = Quantize(value, min, max, GetSliderStep(min, max))
local initRatio = (value - min) / (max - min)
local dragging = false
local Slider = New("Frame", {
Name = "Slider",
Size = UDim2.new(1, 0, 0, 39),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 100,
BorderSizePixel = 0,
}, Slider)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.6600000262260437, 0, 0.5000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
}, Slider)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(0.4980000042915344, 0, 0.25, 0),
Size = UDim2.new(0.5, 0, 0.6990000009536743, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
}, Slider)
local SliderValue = New("TextLabel", {
Name = "SliderValue",
Position = UDim2.new(0.6990000009536743, 0, 0.10000000149011612, 0),
Size = UDim2.new(0.25, 0, 0.8080000281333923, 0),
BackgroundColor3 = Color3.fromRGB(24, 27, 37),
Text = FormatSliderValue(value, suffix),
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.20000000298023224,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, SliderValue)
local Line = New("Frame", {
Name = "Line",
Active = true,
Position = UDim2.new(0.03999999910593033, 0, 0.3190000057220459, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.15000000596046448, 0),
BackgroundColor3 = Color3.fromRGB(33,37,53),
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Line)
local InLine = New("Frame", {
Name = "InLine",
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = mainColor,
ZIndex = 2,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, InLine)
local Trigger = New("TextButton", {
Name = "Trigger",
Position = UDim2.new(0.10000000149011612, 0, -1.8000000715255737, 0),
Size = UDim2.new(1.1999999284744263, 0, 4.200000286102295, 0),
AnchorPoint = Vector2.new(0.800000011920929, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
Active = false,
Text = "",
ZIndex = 3,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Trigger)
New("UIAspectRatioConstraint", {}, Trigger)
local Thumb = New("Frame", {
Name = "Thumb",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(initRatio, 0, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = Line.ZIndex + 3,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Thumb)
Stroke(Thumb)
Line.MouseEnter:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(14, 14) }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
Line.MouseLeave:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(12, 12) }, 0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
local initialValue = value
task.defer(function()
if value ~= initialValue then return end
InLine.Size = UDim2.fromScale(initRatio, 1)
Thumb.Position = UDim2.new(initRatio, 0, 0.5, 0)
Trigger.Position = UDim2.new(initRatio, 0, -1.8000000715255737, 0)
end)
local function update(input)
local pointer = GetInputPosition(input)
local lineSize = Line.AbsoluteSize.X
if lineSize <= 0 then return end
local sizeScale = ClampRatio(pointer.X - Line.AbsolutePosition.X, lineSize)
local nextValue = Quantize(((max - min) * sizeScale) + min, min, max, GetSliderStep(min, max))
local changed = nextValue ~= value
value = nextValue
local span = max - min
local snappedRatio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
InLine.Size = UDim2.fromScale(snappedRatio, 1)
Trigger.Position = UDim2.new(snappedRatio, 0, -1.8000000715255737, 0)
Thumb.Position = UDim2.new(snappedRatio, 0, 0.5, 0)
SliderValue.Text = FormatSliderValue(value, suffix)
if changed then InvokeCallback(callback, value) end
end
local Hitbox = New("TextButton", {
Name = "SliderHitbox",
Position = UDim2.new(0.03999999910553033, 0, 0, -10),
Size = UDim2.new(0.6000000238418579, 0, 1, 20),
BackgroundTransparency = 1,
Text = "",
AutoButtonColor = false,
ZIndex = 4,
}, Effect)
Hitbox.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then
dragging = true
update(input)
end
end)
Line.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then
dragging = true
update(input)
end
end)
UserInputService.InputEnded:Connect(function(input)
if IsPrimaryInput(input) then
dragging = false
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging then
if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
update(input)
end
end
end)
local obj = {}
function obj:Set(val)
local numeric = type(val) == "number" and val == val and val or min
value = math.clamp(numeric, min, max)
value = Quantize(value, min, max, GetSliderStep(min, max))
local span = max - min
local ratio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
Tween(InLine, { Size = UDim2.fromScale(ratio, 1) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Trigger.Position = UDim2.new(ratio, 0, -1.8000000715255737, 0)
Tween(Thumb, { Position = UDim2.new(ratio, 0, 0.5, 0) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
SliderValue.Text = FormatSliderValue(value, suffix)
InvokeCallback(callback, value)
end
function obj:Get() return value end
function obj:AddSettings() return MakeSettings(Slider, "slider", text) end
RegisterConfigElement("slider_", text, obj)
CenterElement(Slider)
BindElementContext(Slider, "slider", text, obj, value, nil, min, max)
return obj
end
function SectionObj:AddDropdown(text, options, default, callback)
if type(default) == "function" then
callback = default
default = nil
end
options = NormalizeOptions(options)
elemCount = elemCount + 1
local selected = GetValidOption(options, default)
local dropOpen = false
local Dropdown = New("Frame", {
Name = "Dropdown",
Size = UDim2.new(1, 0, 0, 39),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
ClipsDescendants = false,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 100,
BorderSizePixel = 0,
}, Dropdown)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.5000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
}, Dropdown)
local TopBar = New("TextButton", {
Name = "TopBar",
Position = UDim2.new(1, -14, 0.5, 0),
AnchorPoint = Vector2.new(1, 0.5),
Size = UDim2.fromOffset(135, 26),
BackgroundColor3 = Color3.fromRGB(30, 33, 47),
BackgroundTransparency = 0,
Text = "",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
ZIndex = 6,
}, Dropdown)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, TopBar)
local TopBarText = New("TextLabel", {
Name = "TopBarText",
Position = UDim2.new(0, 8, 0, 0),
Size = UDim2.new(1, -36, 1, 0),
BackgroundTransparency = 1,
Text = selected or "Select",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = 7,
}, TopBar)
local Arrow = New("ImageLabel", {
Name = "Arrow",
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
AnchorPoint = Vector2.new(1, 0.5),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageColor3 = Color3.fromRGB(255, 255, 255),
ScaleType = Enum.ScaleType.Fit,
Rotation = 0,
ZIndex = 7,
}, TopBar)
local DownBar = New("Frame", {
Name = "DownBar",
Position = UDim2.new(0.02, 0, 1, 4),
Size = UDim2.fromOffset(150, 0),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BackgroundTransparency = 0,
Visible = false,
ZIndex = 5000,
ClipsDescendants = true,
}, Dropdown)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, DownBar)
local PopupStroke = Stroke(DownBar)
local Scrolls = New("ScrollingFrame", {
Name = "Scrolls",
Position = UDim2.fromOffset(6, 6),
Size = UDim2.new(1, -12, 1, -12),
ScrollingEnabled = true,
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
BorderSizePixel = 0,
ScrollBarThickness = 2,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ClipsDescendants = false,
ZIndex = 5001,
}, DownBar)
New("UIListLayout", {
Padding = UDim.new(0, 2),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Scrolls)
local function closeDropdown()
if not dropOpen and not DownBar.Visible then return end
dropOpen = false
UnregisterPopup(DownBar)
DownBar:SetAttribute("CloseToken", (DownBar:GetAttribute("CloseToken") or 0) + 1)
SmoothClose(DownBar, 0.1)
if _openDropdown == closeDropdown then _openDropdown = nil end
end
local optionRows = {}
for _, opt in ipairs(options) do
local Buttons = New("TextButton", {
Name = "Buttons",
Size = UDim2.new(1, 0, 0, 28),
ClipsDescendants = false,
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
Text = opt,
TextColor3 = selected == opt and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
AutoButtonColor = false,
ZIndex = 5002,
}, Scrolls)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, Buttons)
New("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 8) }, Buttons)
New("ImageLabel", { Name = "SelectedCheck", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, -22, 0.5, 0), Size = UDim2.fromOffset(14, 14), BackgroundTransparency = 1, Image = "rbxassetid://138494545053627", ImageColor3 = Color3.fromRGB(255, 255, 255), Visible = false, ZIndex = 5003 }, Buttons)
optionRows[opt] = Buttons
Buttons.MouseEnter:Connect(function()
Tween(Buttons, { BackgroundTransparency = 0.97 }, 0.09, Enum.EasingStyle.Sine)
end)
Buttons.MouseLeave:Connect(function()
Tween(Buttons, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Sine)
end)
Buttons.MouseButton1Click:Connect(function()
selected = opt
TopBarText.Text = opt;
for option, row in pairs(optionRows) do
Tween(row, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Sine)
local check = row:FindFirstChild("SelectedCheck")
if check then check.Visible = false end
row.TextColor3 = option == selected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180)
end
InvokeCallback(callback, opt)
closeDropdown()
end)
end
TopBar.MouseButton1Click:Connect(function()
if dropOpen then
closeDropdown()
else
CloseAllPopupsExcept(DownBar)
if _openDropdown then _openDropdown() end
dropOpen = true
_openDropdown = closeDropdown
DownBar:SetAttribute("CloseToken", (DownBar:GetAttribute("CloseToken") or 0) + 1)
DownBar.Visible = false
ApplyZIndexLadder(DownBar, NextPopupZ())
local h = math.min(#options, 8) * 30 + 10
local popupWidth = math.max(TopBar.AbsoluteSize.X, 150)
local finalSize = UDim2.fromOffset(popupWidth, h)
local knownSize = Vector2.new(popupWidth, math.min(h, math.max(MainFrame.AbsoluteSize.Y, 1)))
DownBar.Size = finalSize
DownBar.BackgroundTransparency = 0
DownBar.Visible = true
WindowObj._centerPopupOnField(DownBar, TopBar)
SmoothOpen(DownBar, 0, 0.14)
RegisterPopup(DownBar, closeDropdown, TopBar)
end
end)
local obj = {}
function obj:Set(val, silent)
val = GetValidOption(options, val)
selected = val
TopBarText.Text = val
for option, row in pairs(optionRows) do
Tween(row, { BackgroundTransparency = 1 }, 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
local check = row:FindFirstChild("SelectedCheck")
if check then check.Visible = false end
row.TextColor3 = option == selected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180)
end
if not silent then InvokeCallback(callback, val) end
end
function obj:Get() return selected end
function obj:AddSettings() return MakeSettings(Dropdown, "dropdown", text) end
RegisterConfigElement("dropdown_", text, obj)
if default ~= nil then obj:Set(GetValidOption(options, default), true) end
CenterElement(Dropdown)
BindElementContext(Dropdown, "dropdown", text, obj, selected, options)
return obj
end
function SectionObj:AddDropdownColorpicker(text, options, defaultColor, callback, colorCallback)
options = NormalizeOptions(options)
if type(callback) ~= "function" then callback = nil end
if type(colorCallback) ~= "function" then colorCallback = nil end
elemCount = elemCount + 1
local selected = GetValidOption(options, options[1])
local currentColor = NormalizeColor(defaultColor)
local dropOpen = false
local Dropdown = New("Frame", {
Name = "Dropdown",
Size = UDim2.new(1, 0, 0, 39),
BackgroundTransparency = 1,
LayoutOrder = elemCount,
ClipsDescendants = false,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.05, 0, 1, -1),
Size = UDim2.new(0.9, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 3,
}, Dropdown)
New("TextLabel", {
Name = "TextDropdown",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.6, 0, 1, 0),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 5,
}, Dropdown)
local cpBtn = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -155, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = currentColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 8,
}, Dropdown)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, cpBtn)
Stroke(cpBtn, "ColorpickerButtonStroke")
local TopBar = New("TextButton", {
Name = "TopBar",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(135, 26),
BackgroundColor3 = Color3.fromRGB(30, 33, 47),
BackgroundTransparency = 0,
Text = "",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
ZIndex = 6,
}, Dropdown)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, TopBar)
local TopBarText = New("TextLabel", {
Name = "TopBarText",
Position = UDim2.new(0, 8, 0, 0),
Size = UDim2.new(1, -36, 1, 0),
BackgroundTransparency = 1,
Text = selected,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = 7,
}, TopBar)
local Arrow = New("ImageLabel", {
Name = "Arrow",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -10, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageColor3 = Color3.fromRGB(255, 255, 255),
ImageTransparency = 0,
ScaleType = Enum.ScaleType.Fit,
Rotation = 0,
ZIndex = 8,
}, TopBar)
local DownBar = New("Frame", {
Name = "DownBar",
Position = UDim2.new(0, 0, 1, 4),
Size = UDim2.fromOffset(150, 0),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BackgroundTransparency = 0,
BorderSizePixel = 0,
ClipsDescendants = true,
Visible = false,
ZIndex = Z_BASE + 500,
}, Dropdown)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, DownBar)
Stroke(DownBar, "DropdownPopupStroke")
local Scrolls = New("ScrollingFrame", {
Name = "Scrolls",
Position = UDim2.fromOffset(6, 6),
Size = UDim2.new(1, -12, 1, -12),
BackgroundTransparency = 1,
BorderSizePixel = 0,
CanvasSize = UDim2.new(),
ScrollBarThickness = 2,
Active = true,
ScrollingEnabled = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
ScrollingDirection = Enum.ScrollingDirection.Y,
ZIndex = Z_BASE + 501,
}, DownBar)
New("UIPadding", {
PaddingLeft = UDim.new(0, 0),
PaddingRight = UDim.new(0, 0),
PaddingTop = UDim.new(0, 0),
PaddingBottom = UDim.new(0, 0),
}, Scrolls)
New("UIListLayout", {
Padding = UDim.new(0, 2),
SortOrder = Enum.SortOrder.LayoutOrder,
}, Scrolls)
local optionRows = {}
local function updateSelected()
TopBarText.Text = selected
for option, row in pairs(optionRows) do
local isSelected = option == selected
row.BackgroundTransparency = 1
row.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180)
local check = row:FindFirstChild("SelectedCheck")
if check then check.Visible = false end
end
end
local function closeDropdown()
dropOpen = false
SmoothClose(DownBar, 0.1)
UnregisterPopup(DownBar)
if _openDropdown == closeDropdown then _openDropdown = nil end
end
local function CurrentColor() return currentColor end
local function NotifySelection(value)
if colorCallback then
if callback then InvokeCallback(callback, value) end
elseif callback then
InvokeCallback(callback, value, CurrentColor())
end
end
local function NotifyColor(c)
currentColor = NormalizeColor(c)
if colorCallback then
InvokeCallback(colorCallback, currentColor)
elseif callback then
InvokeCallback(callback, selected, currentColor)
end
end
for _, opt in ipairs(options) do
local row = New("TextButton", {
Name = "Option",
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
Text = opt,
TextColor3 = opt == selected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = Z_BASE + 502,
}, Scrolls)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, row)
New("UIPadding", { PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 8) }, row)
New("ImageLabel", {
Name = "SelectedCheck",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, -22, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
Image = "rbxassetid://138494545053627",
ImageColor3 = Color3.fromRGB(255, 255, 255),
Visible = opt == selected,
ZIndex = Z_BASE + 503,
}, row)
optionRows[opt] = row
row.MouseEnter:Connect(function() Tween(row, { BackgroundTransparency = 0.97 }, 0.09, Enum.EasingStyle.Sine) end)
row.MouseLeave:Connect(function() Tween(row, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Sine) end)
row.MouseButton1Click:Connect(function()
selected = opt
updateSelected()
NotifySelection(opt)
closeDropdown()
end)
end
local function openDropdown()
if dropOpen then closeDropdown(); return end
CloseAllPopupsExcept(DownBar)
if _openDropdown then _openDropdown() end
dropOpen = true
_openDropdown = closeDropdown
local popupWidth = math.max(TopBar.AbsoluteSize.X, 150)
local h = math.min(#options, 8) * 30 + 10
local finalSize = UDim2.fromOffset(popupWidth, h)
local knownSize = Vector2.new(popupWidth, math.min(h, math.max(MainFrame.AbsoluteSize.Y, 1)))
DownBar.Size = finalSize
DownBar.Visible = true
ApplyZIndexLadder(DownBar, NextPopupZ())
WindowObj._centerPopupOnField(DownBar, TopBar)
SmoothOpen(DownBar, 0, 0.14)
RegisterPopup(DownBar, closeDropdown, TopBar)
end
TopBar.MouseButton1Click:Connect(openDropdown)
local picker = AcrylicBlur.CreateColorPicker(cpBtn, currentColor, NotifyColor)
updateSelected()
local obj = {}
function obj:Set(val)
selected = GetValidOption(options, val)
updateSelected()
NotifySelection(selected)
end
function obj:Get() return selected end
function obj:SetColor(c)
currentColor = NormalizeColor(c)
picker.Set(currentColor)
NotifyColor(currentColor)
end
function obj:GetColor() return currentColor end
function obj:AddSettings() return MakeSettings(Dropdown, "dropdown", text) end
RegisterConfigElement("dropdowncolorpicker_", text, obj)
RegisterConfigElement("dropdowncolorpicker_color_", text, {
Get = function() return obj:GetColor() end,
Set = function(_, c) obj:SetColor(c) end,
})
CenterElement(Dropdown)
BindElementContext(Dropdown, "dropdowncolorpicker", text, obj, selected, options)
return obj
end
function SectionObj:AddColorpicker(text, defaultColor, callback)
elemCount = elemCount + 1
local initialColor = NormalizeColor(defaultColor)
local Colorpicker = New("Frame", {
Name = "Colorpicker",
Size = UDim2.new(1, 0, 0, 39),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = elemCount,
ClipsDescendants = false,
ZIndex = 2,
}, Elements)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.89, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 3,
}, Colorpicker)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.6, 0, 1, 0),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 5,
}, Colorpicker)
local colorpickerButton = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = initialColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 30,
}, Colorpicker)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, colorpickerButton)
Stroke(colorpickerButton, "ColorpickerButtonStroke")
local picker = AcrylicBlur.CreateColorPicker(colorpickerButton, initialColor, function(c)
InvokeCallback(callback, c)
end)
local obj = {}
function obj:Set(c)
local normalized = NormalizeColor(c)
picker.Set(normalized)
InvokeCallback(callback, normalized)
end
function obj:Get() return picker.Get() end
function obj:AddSettings() return MakeSettings(Colorpicker, nil, text) end
RegisterConfigElement("colorpicker_", text, obj)
CenterElement(Colorpicker)
BindElementContext(Colorpicker, "colorpicker", text, obj, initialColor)
return obj
end
function SectionObj:AddAccordion(text)
text = tostring(text or "Accordion")
elemCount = elemCount + 1
local DropdownSection = Instance.new('Frame')
DropdownSection.Name = "Accordion"
DropdownSection.Size = UDim2.new(1, 0, 0, 39)
DropdownSection.BackgroundColor3 = Color3.fromRGB(17, 19, 27)
DropdownSection.BackgroundTransparency = 1
DropdownSection.LayoutOrder = elemCount
DropdownSection.Parent = Elements
local TextArrow = Instance.new('ImageLabel')
TextArrow.Name = "TextArrow"
TextArrow.Position = UDim2.new(1, -12, 0.5, 0)
TextArrow.AnchorPoint = Vector2.new(1, 0.5)
TextArrow.Size = UDim2.fromOffset(10, 10)
TextArrow.BackgroundTransparency = 1
TextArrow.Image = "rbxassetid://10709790948"
TextArrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
TextArrow.ImageTransparency = 0.3
TextArrow.ScaleType = Enum.ScaleType.Fit
TextArrow.Rotation = -90
TextArrow.Parent = DropdownSection
local Text = Instance.new('TextLabel')
Text.Name = "Text"
Text.Position = UDim2.new(0.04800000041723251, 0, 0.30000001192092896, 0)
Text.Size = UDim2.new(0.6600000262260437, 0, 0.5000000238418579, 0)
Text.BackgroundColor3 = Color3.fromRGB(28,32,48)
Text.BackgroundTransparency = 1
Text.Text = text
Text.TextColor3 = Color3.fromRGB(230, 230, 230)
Text.TextScaled = false
Text.TextSize = 15
Text.TextYAlignment = Enum.TextYAlignment.Center
Text.TextTruncate = Enum.TextTruncate.AtEnd
Text.Font = FONT
Text.TextTransparency = 0.10000000149011612
Text.TextXAlignment = Enum.TextXAlignment.Left
Text.Parent = DropdownSection
local Open = Instance.new('TextButton')
Open.Name = "Open"
Open.Size = UDim2.new(1, 0, 1, 0)
Open.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Open.BackgroundTransparency = 1
Open.Text = ""
Open.ZIndex = 10
Open.Parent = DropdownSection
local Section2Frame = Instance.new('Frame')
Section2Frame.Name = "AccordionFrame"
Section2Frame.Position = UDim2.new(0.02, 0, 1, 2 / GetMainFrameScale())
Section2Frame.Size = UDim2.new(0.96, 0, 0, 0)
Section2Frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
Section2Frame.BackgroundTransparency = 0
Section2Frame.BorderSizePixel = 0
Section2Frame.Visible = false
Section2Frame.ZIndex = 5000
Section2Frame.ClipsDescendants = false
Section2Frame.AutomaticSize = Enum.AutomaticSize.None
local S2Scale = New("UIScale", { Scale = 1 }, Section2Frame)
Section2Frame.Parent = DropdownSection
local UICorner = Instance.new('UICorner')
UICorner.Name = "UICorner"
UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = Section2Frame
local UIStroke = Stroke(Section2Frame, "UIStroke")
AttachShadow(Section2Frame, { radius = 12, layers = 5, step = 1.6, bias = 3 })
local ACC_HEADER = 40
local ACC_WIDTH = 280
New("TextLabel", {
Name = "PlateTitle",
Position = UDim2.new(0, 16, 0, 13),
Size = UDim2.new(1, -32, 0, 20),
BackgroundTransparency = 1,
Text = text,
TextColor3 = Color3.fromRGB(226, 227, 233),
TextSize = 16,
TextXAlignment = Enum.TextXAlignment.Left,
TextTruncate = Enum.TextTruncate.AtEnd,
ZIndex = 5001,
}, Section2Frame)
local Container = Instance.new('ScrollingFrame')
Container.Name = "Container"
Container.Position = UDim2.new(0.04, 0, 0, ACC_HEADER + 3 / GetMainFrameScale())
Container.Size = UDim2.new(0.92, 0, 1, -(ACC_HEADER + 10 / GetMainFrameScale()))
Container.BackgroundColor3 = Color3.fromRGB(27, 27, 36)
Container.BackgroundTransparency = 1
Container.AnchorPoint = Vector2.new(0, 0)
Container.LayoutOrder = 1
Container.ZIndex = 5001
Container.Active = true
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Container.CanvasSize = UDim2.new()
Container.ScrollingEnabled = false
Container.ScrollingDirection = Enum.ScrollingDirection.Y
Container.ScrollBarThickness = 0
Container.ScrollBarImageTransparency = 0.5
Container.ClipsDescendants = true
Container.Parent = Section2Frame
local UIListLayout = Instance.new('UIListLayout')
UIListLayout.Name = "UIListLayout"
UIListLayout.Padding = UDim.new(0, 3)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = Container
do local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, 10); c.Parent = Container end
Stroke(Container, "CardOutline").Transparency = 0.955
New("UIPadding", { PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 6), PaddingRight = UDim.new(0, 6) }, Container)
Container.DescendantAdded:Connect(function(d)
if d.Name == "Lines" and d:IsA("GuiObject") then d.Visible = false end
end)
local function GetAccordionContentHeight()
local measured = MeasureRowsHeight(Container)
if measured > 0 then return measured end
local rowCount = 0
for _, child in ipairs(Container:GetChildren()) do
if child:IsA("GuiObject") then rowCount = rowCount + 1 end
end
if rowCount <= 0 then return 0 end
local estimated = EstimateRowsHeight(Container, rowCount, 7.5)
if estimated > 0 then return estimated end
return rowCount * 28 * GetMainFrameScale()
end
local function UpdateAccordionLayout()
local scale = GetMainFrameScale()
Container.Position = UDim2.new(0.04, 0, 0, ACC_HEADER + 3 / scale)
Container.Size = UDim2.new(0.92, 0, 1, -(ACC_HEADER + 10 / scale))
end
local function placeAccordion(height)
local scale = GetMainFrameScale()
local rowPosition = DropdownSection.AbsolutePosition
local rowSize = DropdownSection.AbsoluteSize
local mainPosition, mainSize = PopupSafeArea()
if rowSize.X <= 0 or mainSize.X <= 0 or mainSize.Y <= 0 then return end
local edge = 5 * scale
local panelWidth = ACC_WIDTH * scale
local visualHeight = height * scale
local x = rowPosition.X + rowSize.X * 0.48
x = math.clamp(x, mainPosition.X + edge, math.max(mainPosition.X + edge, mainPosition.X + mainSize.X - panelWidth - edge))
local y = rowPosition.Y - 6 * scale
y = math.clamp(y, mainPosition.Y + edge, math.max(mainPosition.Y + edge, mainPosition.Y + mainSize.Y - visualHeight - edge))
Section2Frame.Position = UDim2.new(0, (x - rowPosition.X) / scale, 0, (y - rowPosition.Y) / scale)
end
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 100,
BorderSizePixel = 0,
}, DropdownSection)
local accordionOpen = false
local accordionLayoutConnection = nil
local accordionRefitConnection = nil
local function getAccordionHeight()
UpdateAccordionLayout()
local scale = GetMainFrameScale()
local contentVisual = GetAccordionContentHeight()
local desiredVisual = math.max((ACC_HEADER + 34) * scale, contentVisual + (ACC_HEADER + 20) * scale)
local maxVisual = math.max(34 * scale, MainFrame.AbsoluteSize.Y * 0.92)
return math.min(desiredVisual, maxVisual) / scale
end
local function fitAccordionHeight()
if not accordionOpen or not Section2Frame.Parent then return end
local height = getAccordionHeight()
Section2Frame.Size = UDim2.fromOffset(ACC_WIDTH, height)
placeAccordion(height)
end
local function closeAccordion()
accordionOpen = false
if _openAccordionDropdown then _openAccordionDropdown() end
ClosePopupsUnder(Section2Frame)
UnregisterPopup(Section2Frame)
SmoothClose(Section2Frame, 0.14)
Tween(TextArrow, {ImageTransparency = 0.3}, 0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
if _openAccordion == closeAccordion then _openAccordion = nil end
end
Open.MouseButton1Click:Connect(function()
if accordionOpen then
closeAccordion()
else
if _openAccordion then _openAccordion() end
CloseAllPopupsExcept(Section2Frame)
accordionOpen = true
_openAccordion = closeAccordion
RememberPopupClipping(Section2Frame)
ForceLiftClipping(Section2Frame)
ApplyZIndexLadder(Section2Frame, NextPopupZ())
local accordionHeight = getAccordionHeight()
Section2Frame.Size = UDim2.fromOffset(ACC_WIDTH, accordionHeight)
placeAccordion(accordionHeight)
SmoothOpen(Section2Frame, 0, 0.17)
Tween(TextArrow, {ImageTransparency = 0}, 0.14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
RegisterPopup(Section2Frame, closeAccordion, Open)
local function settle()
if not accordionOpen or not Section2Frame.Parent then return end
fitAccordionHeight()
end
task.defer(function()
if not accordionOpen or not Section2Frame.Parent then return end
fitAccordionHeight()
Tween(S2Scale, {Scale = 1}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end)
task.delay(0.05, settle)
if not accordionRefitConnection then
local frames = 0
accordionRefitConnection = RunService.RenderStepped:Connect(function()
frames = frames + 1
if not accordionOpen then
accordionRefitConnection:Disconnect()
accordionRefitConnection = nil
return
end
fitAccordionHeight()
if frames >= 4 then
accordionRefitConnection:Disconnect()
accordionRefitConnection = nil
end
end)
end
if not accordionLayoutConnection then
local okLayout, layout = pcall(function() return Container:FindFirstChildOfClass("UIListLayout") end)
if okLayout and layout then
pcall(function()
accordionLayoutConnection = layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
task.defer(settle)
end)
end)
end
end
end
end)
local AccordionObj = {}
local AccordionTarget = Container
function AccordionObj:AddGroup()
AccordionTarget = StartPlateGroup(Container)
return self
end
local accordionElemCount = 0
function AccordionObj:AddToggle(text2, default, callback)
accordionElemCount = accordionElemCount + 1
local enabled = default == true
local Toggle = New("Frame", {
Name = "Toggle",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = accordionElemCount,
}, AccordionTarget)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 100,
BorderSizePixel = 0,
}, Toggle)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.7600000262260437, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text2,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 101,
}, Toggle)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(1, -14, 0.5, 0),
AnchorPoint = Vector2.new(1, 0.5),
Size = UDim2.fromOffset(33, 20),
BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16),
ZIndex = 101,
}, Toggle)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Effect)
local Icon = New("Frame", {
Name = "Icon",
Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2),
Size = UDim2.fromOffset(16, 16),
BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157),
BackgroundTransparency = 0,
ZIndex = 102,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Icon)
New("UIAspectRatioConstraint", {}, Icon)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 110,
}, Toggle)
local function Set(val)
enabled = val == true
Tween(Effect, { BackgroundColor3 = enabled and mainColor or Color3.fromRGB(8, 10, 16) }, 0.16, Enum.EasingStyle.Sine)
Tween(Icon, { Position = enabled and UDim2.fromOffset(15, 2) or UDim2.fromOffset(2, 2), BackgroundColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(139, 145, 157), BackgroundTransparency = 0 }, 0.16, Enum.EasingStyle.Quad)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
function obj:AddSettings() return MakeSettings(Toggle, nil, text2) end
RegisterConfigElement("accordion_toggle_", text2, obj)
CenterElement(Toggle)
BindElementContext(Toggle, "accordion_toggle", text2, obj, default)
return obj
end
function AccordionObj:AddCheckbox(text2, default, callback)
accordionElemCount = accordionElemCount + 1
local enabled = default == true
local CheckBoxToggle = New("Frame", {
Name = "CheckBoxToggle",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = accordionElemCount,
}, AccordionTarget)
local CheckBox = New("Frame", {
Name = "CheckBox",
Position = UDim2.new(0.04, 0, 0.3, 0),
Size = UDim2.new(0.075, 0, 0.7, 0),
BackgroundTransparency = 1,
ZIndex = 101,
}, CheckBoxToggle)
New("UICorner", {}, CheckBox)
New("UIAspectRatioConstraint", {}, CheckBox)
local Check = New("ImageLabel", {
Name = "Check",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Image = "rbxassetid://138494545053627",
ImageTransparency = enabled and 0.1 or 1,
ZIndex = 101,
}, CheckBox)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.15, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.7600000262260437, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text2,
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 101,
}, CheckBoxToggle)
local Btn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 110,
}, CheckBoxToggle)
local function Set(val)
enabled = val == true
Tween(Check, { ImageTransparency = enabled and 0.1 or 1 }, 0.2)
InvokeCallback(callback, enabled)
end
Btn.MouseButton1Click:Connect(function() Set(not enabled) end)
local obj = {}
function obj:Set(v) Set(v) end
function obj:Get() return enabled end
function obj:AddSettings() return MakeSettings(CheckBoxToggle, nil, text2) end
RegisterConfigElement("accordion_checkbox_", text2, obj)
CenterElement(CheckBoxToggle)
BindElementContext(CheckBoxToggle, "accordion_checkbox", text2, obj, default)
return obj
end
function AccordionObj:AddDropdown(text2, options, default, callback)
if type(default) == "function" then
callback = default
default = nil
end
options = NormalizeOptions(options)
accordionElemCount = accordionElemCount + 1
local selected = GetValidOption(options, default)
local dropOpen = false
local selectedBtns = {}
local Selection = New("Frame", {
Name = "Selection",
Size = UDim2.new(1, 0, 0, 34),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = accordionElemCount,
ClipsDescendants = false,
ZIndex = 100,
}, AccordionTarget)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.05000000074505806, 0, 1, 0),
Size = UDim2.new(0.8999999761581421, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 100,
}, Selection)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.new(0.04800000041723251, 0, 0.30000001192092896, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text2,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 101,
}, Selection)
local SelArrow = New("ImageLabel", {
Name = "TextArrow",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -12, 0.5, 0),
Size = UDim2.fromOffset(10, 10),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Image = "rbxassetid://10709790948",
ImageColor3 = Color3.fromRGB(255, 255, 255),
ImageTransparency = 0.10000000149011612,
ScaleType = Enum.ScaleType.Fit,
Rotation = 0,
ZIndex = 1000,
}, Selection)
local TextDefault = New("TextLabel", {
Name = "TextDefault",
Position = UDim2.new(0.60, 0, 0.25, 0),
Size = UDim2.new(0.29, 0, 0.6, 0),
TextTruncate = Enum.TextTruncate.AtEnd,
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = options[1] or "Auto",
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0,
TextTruncate = Enum.TextTruncate.AtEnd,
TextSize = 14,
ZIndex = 101,
TextXAlignment = Enum.TextXAlignment.Left,
}, Selection)
local DropPopup = New("Frame", {
Name = "Dropdown",
Position = UDim2.new(0.60, 0, 1, 4),
Size = UDim2.fromOffset(150, 0),
BackgroundColor3 = Color3.fromRGB(17, 19, 28),
BackgroundTransparency = 0,
BorderSizePixel = 0,
Visible = false,
ZIndex = 5000,
}, Selection)
New("UICorner", { CornerRadius = UDim.new(0, 10) }, DropPopup)
do Stroke(DropPopup) end
local DropContainer = New("ScrollingFrame", {
Name = "Container",
Position = UDim2.fromOffset(6, 6),
Size = UDim2.new(1, -12, 1, -12),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
ZIndex = 5000,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 2,
ScrollBarImageTransparency = 0.5,
}, DropPopup)
New("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2) }, DropContainer)
local function closeDropdown2()
dropOpen = false
Tween(SelArrow, { Rotation = -90 }, 0.16, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
UnregisterPopup(DropPopup)
SmoothClose(DropPopup, 0.18)
if _openAccordionDropdown == closeDropdown2 then _openAccordionDropdown = nil end
end
local function updateCheckmarks()
for opt, selBtn in pairs(selectedBtns) do
local isSelected = opt == selected
selBtn.Visible = isSelected
selBtn.ImageColor3 = mainColor
local row = selBtn.Parent
if row then
row.BackgroundTransparency = 1
local label = row:FindFirstChild("Label") or row:FindFirstChildWhichIsA("TextLabel")
if label then label.TextColor3 = isSelected and Color3.fromRGB(228, 228, 229) or Color3.fromRGB(175, 175, 180) end
end
end
end
for i, opt in ipairs(options) do
local BtnRow = New("Frame", {
Name = "Buttons",
Size = UDim2.new(1, 0, 0, 28),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
ZIndex = 1001,
LayoutOrder = i,
}, DropContainer)
New("UICorner", { CornerRadius = UDim.new(0, 6) }, BtnRow)
local Label = New("TextLabel", {
Name = "Label",
Position = UDim2.new(0, 28, 0, 0),
Size = UDim2.new(1, -36, 1, 0),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
Text = opt,
TextColor3 = Color3.fromRGB(200, 204, 218),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTruncate = Enum.TextTruncate.AtEnd,
TextTransparency = 0,
ZIndex = 1002,
TextXAlignment = Enum.TextXAlignment.Left,
}, BtnRow)
local SelBtn = New("ImageButton", {
Name = "Selected",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 4, 0.5, 0),
Size = UDim2.fromOffset(14, 14),
BackgroundTransparency = 1,
BorderSizePixel = 0,
Image = "rbxassetid://138494545053627",
ImageColor3 = mainColor,
Visible = false,
ZIndex = 1006,
}, BtnRow)
selectedBtns[opt] = SelBtn
local RowBtn = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 1005,
}, BtnRow)
RowBtn.MouseEnter:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 0.97 }, 0.08)
end)
RowBtn.MouseLeave:Connect(function()
Tween(BtnRow, { BackgroundTransparency = 1 }, 0.12)
end)
RowBtn.MouseButton1Click:Connect(function()
selected = opt
TextDefault.Text = opt;
updateCheckmarks()
closeDropdown2()
InvokeCallback(callback, opt)
end)
SelBtn.MouseButton1Click:Connect(function()
selected = opt
TextDefault.Text = opt;
updateCheckmarks()
closeDropdown2()
InvokeCallback(callback, opt)
end)
end
local OpenBtn = New("TextButton", {
Name = "OpenBtn",
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 500,
}, Selection)
OpenBtn.MouseButton1Click:Connect(function()
if dropOpen then
closeDropdown2()
else
CloseAllPopupsExcept(DropPopup)
if _openAccordionDropdown then _openAccordionDropdown() end
dropOpen = true
_openAccordionDropdown = closeDropdown2
local knownH = math.min(#options, 8) * 30 + 10
local knownW = math.max(TextDefault.AbsoluteSize.X, 150)
DropPopup.Size = UDim2.fromOffset(knownW, knownH)
DropPopup.BackgroundTransparency = 0
DropPopup.Visible = false
ApplyZIndexLadder(DropPopup, NextPopupZ())
DropPopup.Visible = true
WindowObj._centerPopupOnField(DropPopup, TextDefault)
SmoothOpen(DropPopup, 0, 0.14)
RegisterPopup(DropPopup, closeDropdown2, OpenBtn)
end
end)
local obj = {}
function obj:Set(val, silent)
val = GetValidOption(options, val)
selected = val
TextDefault.Text = val;
updateCheckmarks()
if not silent then InvokeCallback(callback, val) end
end
function obj:Get() return selected end
function obj:AddSettings() return MakeSettings(Selection, "dropdown", text2) end
if default ~= nil then obj:Set(GetValidOption(options, default), true) end
RegisterConfigElement("accordion_dropdown_", text2, obj)
CenterElement(Selection)
BindElementContext(Selection, "accordion_dropdown", text2, obj, selected, options)
return obj
end
function AccordionObj:AddSlider(text2, min, max, default, callback, suffix)
accordionElemCount = accordionElemCount + 1
if type(suffix) ~= "string" then suffix = "" end
local value
min, max, value = NormalizeRange(min, max, default)
value = Quantize(value, min, max, GetSliderStep(min, max))
local initRatio = (value - min) / (max - min)
local dragging = false
local Slider = New("Frame", {
Name = "Slider",
Size = UDim2.new(1, 0, 0, 39),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 1,
LayoutOrder = accordionElemCount,
ZIndex = 100,
}, AccordionTarget)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.88, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
ZIndex = 1002,
BorderSizePixel = 0,
}, Slider)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.7600000262260437, 0, 0.6000000238418579, 0),
BackgroundColor3 = Color3.fromRGB(28,32,48),
BackgroundTransparency = 1,
Text = text2,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
Font = FONT,
TextTransparency = 0.10000000149011612,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 101,
}, Slider)
local Effect = New("Frame", {
Name = "Effect",
Position = UDim2.new(0.4980000042915344, 0, 0.25, 0),
Size = UDim2.new(0.5, 0, 0.6990000009536743, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
ZIndex = 101,
}, Slider)
local SliderValue = New("TextLabel", {
Name = "SliderValue",
Position = UDim2.new(0.6990000009536743, 0, 0.10000000149011612, 0),
Size = UDim2.new(0.25, 0, 0.8080000281333923, 0),
BackgroundColor3 = Color3.fromRGB(33,37,53),
Text = FormatSliderValue(value, suffix),
TextColor3 = Color3.fromRGB(255, 255, 255),
TextScaled = false,
Font = FONT,
TextTransparency = 0.20000000298023224,
ZIndex = 102,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, SliderValue)
local Line = New("Frame", {
Name = "Line",
Active = true,
Position = UDim2.new(0.03999999910593033, 0, 0.3190000057220459, 0),
Size = UDim2.new(0.6000000238418579, 0, 0.24, 0),
BackgroundColor3 = Color3.fromRGB(33,37,53),
ZIndex = 101,
}, Effect)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Line)
local InLine = New("Frame", {
Name = "InLine",
Size = UDim2.new(0, 0, 1, 0),
BackgroundColor3 = mainColor,
ZIndex = 102,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, InLine)
SizeSliderChip(Effect, Line, SliderValue)
local Trigger = New("TextButton", {
Name = "Trigger",
Position = UDim2.new(0.10000000149011612, 0, -1.8000000715255737, 0),
Size = UDim2.new(1.1999999284744263, 0, 4.200000286102295, 0),
AnchorPoint = Vector2.new(0.800000011920929, 0),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BackgroundTransparency = 1,
Active = false,
Text = "",
ZIndex = 103,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Trigger)
New("UIAspectRatioConstraint", {}, Trigger)
local Thumb = New("Frame", {
Name = "Thumb",
AnchorPoint = Vector2.new(0.5, 0.5),
Position = UDim2.new(initRatio, 0, 0.5, 0),
Size = UDim2.fromOffset(12, 12),
BackgroundColor3 = Color3.fromRGB(255, 255, 255),
BorderSizePixel = 0,
ZIndex = Line.ZIndex + 3,
}, Line)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, Thumb)
Stroke(Thumb)
Line.MouseEnter:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(14, 14) }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
Line.MouseLeave:Connect(function()
Tween(Thumb, { Size = UDim2.fromOffset(12, 12) }, 0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end)
local initialValue = value
task.defer(function()
if value ~= initialValue then return end
InLine.Size = UDim2.fromScale(initRatio, 1)
Thumb.Position = UDim2.new(initRatio, 0, 0.5, 0)
Trigger.Position = UDim2.new(initRatio, 0, -1.8000000715255737, 0)
end)
local function update(input)
local pointer = GetInputPosition(input)
local lineSize = Line.AbsoluteSize.X
if lineSize <= 0 then return end
local sizeScale = ClampRatio(pointer.X - Line.AbsolutePosition.X, lineSize)
local nextValue = Quantize(((max - min) * sizeScale) + min, min, max, GetSliderStep(min, max))
local changed = nextValue ~= value
value = nextValue
local span = max - min
local snappedRatio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
InLine.Size = UDim2.fromScale(snappedRatio, 1)
Trigger.Position = UDim2.new(snappedRatio, 0, -1.8000000715255737, 0)
Thumb.Position = UDim2.new(snappedRatio, 0, 0.5, 0)
SliderValue.Text = FormatSliderValue(value, suffix)
if changed then InvokeCallback(callback, value) end
end
Line.InputBegan:Connect(function(input)
if IsPrimaryInput(input) then
dragging = true; update(input)
end
end)
UserInputService.InputEnded:Connect(function(input)
if IsPrimaryInput(input) then
dragging = false
end
end)
UserInputService.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
update(input)
end
end)
local obj = {}
function obj:Set(val)
local numeric = type(val) == "number" and val == val and val or min
value = math.clamp(numeric, min, max)
value = Quantize(value, min, max, GetSliderStep(min, max))
local span = max - min
local ratio = span ~= 0 and math.clamp((value - min) / span, 0, 1) or 0
Tween(InLine, { Size = UDim2.fromScale(ratio, 1) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Trigger.Position = UDim2.new(ratio, 0, -1.8000000715255737, 0)
Tween(Thumb, { Position = UDim2.new(ratio, 0, 0.5, 0) }, 0.14, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
SliderValue.Text = FormatSliderValue(value, suffix)
InvokeCallback(callback, value)
end
function obj:Get() return value end
function obj:AddSettings() return MakeSettings(Slider, "slider", text2) end
RegisterConfigElement("accordion_slider_", text2, obj)
CenterElement(Slider)
BindElementContext(Slider, "accordion_slider", text2, obj, value, nil, min, max)
return obj
end
function AccordionObj:AddColorpicker(text2, defaultColor, callback)
accordionElemCount = accordionElemCount + 1
local initialColor = NormalizeColor(defaultColor)
local Colorpicker = New("Frame", {
Name = "Colorpicker",
Size = UDim2.new(1, 0, 0, 34),
BackgroundTransparency = 1,
BorderSizePixel = 0,
LayoutOrder = accordionElemCount,
ClipsDescendants = false,
ZIndex = 100,
}, AccordionTarget)
New("Frame", {
Name = "Lines",
Position = UDim2.new(0.06, 0, 1, -1),
Size = UDim2.new(0.89, 0, 0, 1),
BackgroundColor3 = Color3.fromRGB(140, 140, 140),
BackgroundTransparency = 0.9,
BorderSizePixel = 0,
ZIndex = 101,
}, Colorpicker)
New("TextLabel", {
Name = "TextToggle",
Position = UDim2.fromOffset(15, 0),
Size = UDim2.new(0.66, 0, 1, 0),
BackgroundTransparency = 1,
Text = text2,
TextColor3 = Color3.fromRGB(217, 219, 226),
TextScaled = false,
TextSize = 14,
Font = FONT,
TextTransparency = 0.1,
TextXAlignment = Enum.TextXAlignment.Left,
ZIndex = 101,
}, Colorpicker)
local colorpickerButton = New("ImageButton", {
Name = "colorpickerButton",
AnchorPoint = Vector2.new(1, 0.5),
Position = UDim2.new(1, -14, 0.5, 0),
Size = UDim2.fromOffset(20, 20),
BackgroundColor3 = initialColor,
BorderSizePixel = 0,
Image = "",
ZIndex = 110,
}, Colorpicker)
New("UICorner", { CornerRadius = UDim.new(0, 5) }, colorpickerButton)
Stroke(colorpickerButton, "ColorpickerButtonStroke")
local picker = AcrylicBlur.CreateColorPicker(colorpickerButton, initialColor, function(c)
InvokeCallback(callback, c)
end)
local obj = {}
function obj:Set(c)
local normalized = NormalizeColor(c)
picker.Set(normalized)
InvokeCallback(callback, normalized)
end
function obj:Get() return picker.Get() end
function obj:AddSettings() return MakeSettings(Colorpicker, nil, text2) end
RegisterConfigElement("accordion_colorpicker_", text2, obj)
CenterElement(Colorpicker)
BindElementContext(Colorpicker, "accordion_colorpicker", text2, obj, initialColor)
return obj
end
MakeReadableText(Section2Frame, 10, 18)
return AccordionObj
end
MakeReadableText(Section, 10, 18)
return SectionObj
end
local subTabs = {}
local activeSubTabIndex = nil
local subTabContainer = nil
tabs[tabIndex].subTabs = subTabs
local function EnsureSubTabContainer()
if subTabContainer then return end
tabOrder = tabOrder + 0.5
subTabContainer = New("Frame", {
Name = "SubTabContainer",
Size = UDim2.new(1, 0, 0, 20),
BackgroundTransparency = 1,
AutomaticSize = Enum.AutomaticSize.Y,
Visible = false,
LayoutOrder = TabButtonFrame.LayoutOrder + 1,
}, Tab)
subTabContainer:SetAttribute("TabIndex", tabIndex)
New("UIListLayout", {
Padding = UDim.new(0, 4),
SortOrder = Enum.SortOrder.LayoutOrder,
HorizontalAlignment = Enum.HorizontalAlignment.Right,
}, subTabContainer)
local origHide = HideContent
local origShow = ShowContent
HideContent = function()
origHide()
subTabContainer.Visible = false
for _, st in ipairs(subTabs) do
st.left.Visible = false
st.right.Visible = false
end
end
ShowContent = function()
Left.Visible = false
Right.Visible = false
subTabContainer.Visible = true
if activeTabIndex == tabIndex then
Tween(TabButtonFrame, {
BackgroundColor3 = Color3.fromRGB(18, 18, 18),
BackgroundTransparency = 1,
}, 0.12, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(TabIcon, { ImageColor3 = mainColor, ImageTransparency = 0 }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
Tween(TabText, { TextTransparency = 0 }, 0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
for i, st in ipairs(subTabs) do
if st.scale then
local delay = math.min((i - 1) * 0.04, 0.3)
task.delay(delay, function()
if not subTabContainer.Visible then return end
st.scale.Scale = 0.985
Tween(st.scale, { Scale = 1 }, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end)
end
end
if activeSubTabIndex then
local st = subTabs[activeSubTabIndex]
if st then
st.left.Position  = UDim2.new(0, 0, 0, 0)
st.right.Position = UDim2.new(0, 0, 0, 0)
st.left.Visible  = true
st.right.Visible = true
AnimateSectionColumn(st.left)
AnimateSectionColumn(st.right)
if WindowObj._fadeColumn then WindowObj._fadeColumn(st.left); WindowObj._fadeColumn(st.right) end
end
elseif #subTabs > 0 then
subTabs[1].activate()
end
end
tabs[tabIndex].hide = HideContent
tabs[tabIndex].show = ShowContent
end
function TabObj:AddSubTab(name, icon)
name = tostring(name or "Subtab")
if icon ~= nil and type(icon) ~= "string" then icon = "" end
EnsureSubTabContainer()
local stIndex = #subTabs + 1
local isFirstST = stIndex == 1
local stLeft = New("ScrollingFrame", {
Name = "STLeft_" .. name,
Size = UDim2.new(0.49, 0, 1, 0),
BackgroundTransparency = 1,
Visible = false,
ClipsDescendants = true,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
}, SubTabHose)
New("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder }, stLeft)
local stRight = New("ScrollingFrame", {
Name = "STRight_" .. name,
Size = UDim2.new(0.49, 0, 1, 0),
BackgroundTransparency = 1,
LayoutOrder = 1,
Visible = false,
ClipsDescendants = true,
Active = true,
AutomaticCanvasSize = Enum.AutomaticSize.Y,
CanvasSize = UDim2.new(),
ScrollingDirection = Enum.ScrollingDirection.Y,
ScrollBarThickness = 0,
}, SubTabHose)
stLeft:SetAttribute("SearchName", name)
stRight:SetAttribute("SearchName", name)
stLeft:SetAttribute("TabIndex", tabIndex)
stRight:SetAttribute("TabIndex", tabIndex)
stLeft:SetAttribute("SubTabIndex", stIndex)
stRight:SetAttribute("SubTabIndex", stIndex)
New("UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 12) }, stLeft)
New("UIPadding", { PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 12) }, stRight)
New("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder }, stRight)
local STRow = New("Frame", {
Name = "STRow_" .. name,
Size = UDim2.new(0.92, 0, 1, 0),
BackgroundColor3 = Color3.fromRGB(18, 18, 18),
BackgroundTransparency = isFirstST and 0.08 or 1,
LayoutOrder = stIndex,
}, subTabContainer)
STRow:SetAttribute("TabIndex", tabIndex)
STRow:SetAttribute("SubTabIndex", stIndex)
New("UICorner", { CornerRadius = UDim.new(0, 8) }, STRow)
New("UIAspectRatioConstraint", {
AspectRatio = 4.6,
AspectType = Enum.AspectType.ScaleWithParentSize,
}, STRow)
local STScale = New("UIScale", { Scale = 1 }, STRow)
local STIndicator = New("Frame", {
Name = "SelectedIndicator",
AnchorPoint = Vector2.new(0, 0.5),
Position = UDim2.new(0, 0, 0.5, 0),
Size = UDim2.new(0, 2, 0.58, 0),
BackgroundColor3 = mainColor,
BackgroundTransparency = 1,
BorderSizePixel = 0,
Visible = false,
ZIndex = 3,
}, STRow)
New("UICorner", { CornerRadius = UDim.new(1, 0) }, STIndicator)
local iconRef = nil
if icon and icon ~= "" then
iconRef = New("ImageLabel", {
Name = "STIcon",
Position = UDim2.new(0.1, 0, 0.5, 0),
AnchorPoint = Vector2.new(0.5, 0.5),
Size = UDim2.new(0.20000000298023224, 0, 0.6500000011920929, 0),
BackgroundTransparency = 1,
ImageColor3 = isFirstST and mainColor or Color3.fromRGB(160, 160, 160),
ImageTransparency = 0,
}, STRow)
New("UIAspectRatioConstraint", { AspectRatio = 1 }, iconRef)
GetImageData(icon, iconRef)
WindowObj._drawTabGlyph(icon, iconRef)
end
local STLabel = New("TextLabel", {
Name = "STLabel",
Position = UDim2.new(0.23000000417232513, 0, 0.235, 0),
Size = UDim2.new(0.7070000171661377, 0, 0.510000011920929, 0),
BackgroundTransparency = 1,
Text = name,
TextColor3 = isFirstST and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 160, 160),
TextScaled = false,
Font = FONT,
TextTransparency = 0,
TextXAlignment = Enum.TextXAlignment.Left,
}, STRow)
local STClick = New("TextButton", {
Size = UDim2.new(1, 0, 1, 0),
BackgroundTransparency = 1,
Text = "",
ZIndex = 5,
}, STRow)
local function ActivateSubTab()
CloseAllPopupsExcept(nil)
for _, st in ipairs(subTabs) do
Tween(st.row, { BackgroundTransparency = 1 }, 0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
if st.row ~= STRow then
Tween(st.lbl, { TextColor3 = Color3.fromRGB(160, 160, 160), TextTransparency = 0 }, 0.10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
if st.icon then
Tween(st.icon, { ImageColor3 = Color3.fromRGB(160, 160, 160), ImageTransparency = 0 }, 0.10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
st.left.Visible  = false
st.right.Visible = false
end
Tween(STRow, { BackgroundTransparency = 0.08 }, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
Tween(STLabel, { TextColor3 = Color3.fromRGB(255, 255, 255), TextTransparency = 0 }, 0.10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
if iconRef then
Tween(iconRef, { ImageColor3 = mainColor, ImageTransparency = 0 }, 0.10, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
end
STScale.Scale = 0.985
Tween(STScale, { Scale = 1 }, 0.13, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
for otherIndex, other in ipairs(subTabs) do
local rank = otherIndex == stIndex and 0 or 100 + otherIndex
other.left.LayoutOrder  = rank
other.right.LayoutOrder = rank
end
stLeft.Visible  = true
stRight.Visible = true
AnimateSectionColumn(stLeft)
AnimateSectionColumn(stRight)
if WindowObj._fadeColumn then WindowObj._fadeColumn(stLeft); WindowObj._fadeColumn(stRight) end
activeSubTabIndex = stIndex
if tabs[tabIndex] then
tabs[tabIndex].activeSubTabIndex = stIndex
tabs[tabIndex].activeSubTabName = name
end
GlobalPreset.Visible = ShouldShowGlobalPreset(tabs[tabIndex] and tabs[tabIndex].name or "")
if ApplySearch then task.defer(function() ApplySearch(SearchBox.Text) end) end
end
table.insert(subTabs, {
row  = STRow,
lbl  = STLabel,
indicator = STIndicator,
icon = iconRef,
scale = STScale,
left = stLeft,
right = stRight,
activate = ActivateSubTab,
index = stIndex,
name = name,
})
STClick.MouseButton1Click:Connect(ActivateSubTab)
STRow.MouseEnter:Connect(function()
if activeSubTabIndex == stIndex then return end
Tween(STRow, { BackgroundTransparency = 0.8 }, 0.11, Enum.EasingStyle.Sine)
end)
STRow.MouseLeave:Connect(function()
if activeSubTabIndex == stIndex then return end
Tween(STRow, { BackgroundTransparency = 1 }, 0.14, Enum.EasingStyle.Sine)
end)
if isFirstST and activeTabIndex == tabIndex then
Left.Visible = false
Right.Visible = false
subTabContainer.Visible = true
ActivateSubTab()
elseif not isFirstST then
STRow.BackgroundTransparency = 1
STLabel.TextTransparency = 0.55
STScale.Scale = 0.985
if iconRef then iconRef.ImageTransparency = 0.6 end
task.defer(function()
if not STRow.Parent then return end
Tween(STScale, { Scale = 1 }, 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end)
end
local SubTabObj = {}
local stSectionOrder = { left = 0, right = 0 }
function SubTabObj:AddESPPreview(options)
return WindowObj._buildESPPreview(stLeft, stRight, options)
end
function SubTabObj:AddSection(title, side)
side = side == "right" and "right" or "left"
local savedLeft  = Left
local savedRight = Right
local savedOrder = { left = sectionOrder.left, right = sectionOrder.right }
Left  = stLeft
Right = stRight
sectionOrder.left  = stSectionOrder.left
sectionOrder.right = stSectionOrder.right
local sec = TabObj:AddSection(title, side)
stSectionOrder.left  = sectionOrder.left
stSectionOrder.right = sectionOrder.right
Left  = savedLeft
Right = savedRight
sectionOrder.left  = savedOrder.left
sectionOrder.right = savedOrder.right
return sec
end
return SubTabObj
end
return TabObj
end
function WindowObj:SetScale(value)
if value == "Auto" then
automaticScale = true
UpdateScale()
if syncScaleSelection then syncScaleSelection("Auto") end
return UIScale.Scale
end
if type(value) ~= "number" or value ~= value then return UIScale.Scale end
automaticScale = false
manualScale = math.clamp(value, 0.5, 1.1)
ApplyScale(manualScale)
if syncScaleSelection then syncScaleSelection(tostring(math.round(manualScale * 100)) .. "%") end
return UIScale.Scale
end
function WindowObj:GetScale()
return UIScale.Scale
end
function WindowObj:SetLogoVisible(visible)
if applyLogoProxy then applyLogoProxy(visible == true) end
return logoVisible
end
function WindowObj:GetLogoVisible()
return logoVisible
end
function WindowObj:GetMainFrame()
return MainFrame
end
function WindowObj:GetMenuBind()
if menuBindProxy then return menuBindProxy() end
return nil
end
function WindowObj:SetMenuBind(key)
if menuBindProxy then menuBindProxy(key) end
return self
end
WindowObj._applyCustomization = function()
if not MainFrame or not MainFrame.Parent then return end
local function eachText(root, fn)
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then fn(d) end
end
end
local previousText = customization._appliedTextColor or Color3.fromRGB(230, 230, 230)
local function isPreviousText(color)
return math.abs(color.R - previousText.R) < 0.01 and math.abs(color.G - previousText.G) < 0.01 and math.abs(color.B - previousText.B) < 0.01
end
eachText(MainFrame, function(t)
if t.Font ~= FONT_BOLD then t.Font = customization.font or FONT end
t.TextScaled = false
if t.Name ~= "GameTitle" and t.Name ~= "TabLabel" and t.Name ~= "SectionLabel"
and t.Name ~= "SubLabel" and t.Name ~= "HeaderLabel" and t.Name ~= "SearchEmptyState"
and t.Name ~= "TabText" and t.Name ~= "Watermark" and isPreviousText(t.TextColor3) then t.TextColor3 = customization.textColor end
end)
customization._appliedTextColor = customization.textColor
for _, d in ipairs(MainFrame:GetDescendants()) do
if d:IsA("TextLabel") and d.Name == "SectionLabel" then
d.TextScaled = false
d.TextSize = customization.sectionTitleSize or 11
d.TextColor3 = customization.sectionTitleColor or Color3.fromRGB(150, 150, 150)
d.TextTransparency = customization.sectionTitleTransparency or 0
end
end
if Watermark then
Watermark.Text = "night.cc"
Watermark.Visible = false
end
for _, d in ipairs(MainFrame:GetDescendants()) do
if d:IsA("UICorner") and d.Parent and d.Parent:IsA("GuiObject") then
local name = d.Parent.Name
if name == "Frame2" or name == "MainFrame" or name == "WindowSettingsFrame"
or name == "ConfigMainFrame" or name == "RecentlyDeletedPanel" then
d.CornerRadius = UDim.new(0, customization.cornerRadius)
end
end
end
for _, row in pairs(_windowContextTargets) do
if row.dots then row.dots.Visible = customization.showContextDots == true end
end
end
function WindowObj:SetCustomization(options)
if type(options) ~= "table" then return customization end
if options.accentColor and typeof(options.accentColor) == "Color3" then
customization.accentColor = options.accentColor
if applyMainColorProxy then applyMainColorProxy(options.accentColor) end
end
if options.font and typeof(options.font) == "EnumItem" then customization.font = options.font end
if options.textColor and typeof(options.textColor) == "Color3" then customization.textColor = options.textColor end
if type(options.sectionTitleSize) == "number" then
customization.sectionTitleSize = math.clamp(options.sectionTitleSize, 8, 40)
end
if type(options.elementTextSize) == "number" then
customization.elementTextSize = math.clamp(options.elementTextSize, 8, 40)
end
if type(options.watermarkText) == "string" then customization.watermarkText = options.watermarkText end
if options.watermarkVisible ~= nil then customization.watermarkVisible = false end
if type(options.cornerRadius) == "number" then
customization.cornerRadius = math.clamp(options.cornerRadius, 0, 30)
end
if options.showContextDots ~= nil then customization.showContextDots = options.showContextDots == true end
WindowObj._applyCustomization()
return customization
end
function WindowObj:GetCustomization()
return customization
end
WindowObj._customMenus = {}
function WindowObj:AddCustomMenu(name, builder, options)
options = type(options) == "table" and options or {}
name = tostring(name or "Custom")
local panel = New("Frame", {
Name = "CustomMenu_" .. name,
Position = options.position or UDim2.new(0, 0, 0, 0),
Size = options.size or UDim2.new(1, 0, 1, 0),
BackgroundColor3 = options.backgroundColor or Color3.fromRGB(0, 0, 0),
BackgroundTransparency = options.backgroundTransparency or 0.8,
BorderSizePixel = 0,
Visible = false,
Active = true,
ClipsDescendants = options.clipsDescendants == true,
}, options.parent or Frame2)
New("UICorner", { CornerRadius = UDim.new(0, options.cornerRadius or customization.cornerRadius) }, panel)
local api = {
name = name,
frame = panel,
visible = false,
}
function api:Show()
self.frame.Visible = true
self.visible = true
self.frame.BackgroundTransparency = 1
Tween(self.frame, { BackgroundTransparency = (type(options.backgroundTransparency) == "number" and options.backgroundTransparency or 0.8) }, 0.2)
return self
end
function api:Hide()
self.visible = false
Tween(self.frame, { BackgroundTransparency = 1 }, 0.18)
task.delay(0.19, function()
if not self.visible then self.frame.Visible = false end
end)
return self
end
function api:SetVisible(state)
if state then return self:Show() end
return self:Hide()
end
function api:IsVisible() return self.visible end
function api:Destroy()
if self.frame.Parent then self.frame:Destroy() end
for i = #WindowObj._customMenus, 1, -1 do
if WindowObj._customMenus[i] == self then table.remove(WindowObj._customMenus, i) end
end
end
if type(builder) == "function" then
local ok, err = pcall(builder, panel, api)
if not ok then warn("[night.cc] AddCustomMenu(" .. name .. ") builder error: " .. tostring(err)) end
end
table.insert(WindowObj._customMenus, api)
return api
end
WindowObj.AddCustomPanel = WindowObj.AddCustomMenu
function WindowObj:GetCustomMenus()
return WindowObj._customMenus
end
MakeReadableText(NightUICS2, 9, 16)
CleanBorders(MainFrame)
task.defer(function() end)
if Library.ShowLoader == false then
task.delay(1, function() if WindowObj._autoLoad then WindowObj._autoLoad() end end)
end
WindowObj._SaveConfig = SaveNamedConfig
WindowObj._LoadConfig = LoadNamedConfig
WindowObj._ExportShare = function(name)
if WindowObj._exportLiveShare then return WindowObj._exportLiveShare(name) end
return nil
end
WindowObj._ImportShare = function(code)
if WindowObj._importLiveShare then return WindowObj._importLiveShare(code) end
return nil
end
return WindowObj
end
return Library
end)()
pcall(function()
if type(Library)=="table" then
Library.ShowLoader = false
Library.DaysLeft = ""
end
end)
if type(_NL) ~= "table" or type(_NL.AddWindow) ~= "function" then
error("[night.cc] NightUI Library failed to load")
end
pcall(function()
Library.ShowLoader = false
Library.DaysLeft = ""
end)
task.defer(function()
pcall(function()
local cg = (gethui and gethui()) or game:GetService("CoreGui")
for _, gui in ipairs(cg:GetDescendants()) do
if gui:IsA("TextLabel") or gui:IsA("TextButton") then
local tx = tostring(gui.Text or "")
if tx == "NL" or tx:find("night") or tx:find("Lifetime") then
if tx == "NL" then gui.Text = ""
else gui.Text = tx:gsub("night.cc", "night.cc"):gsub("Lifetime", ""):gsub("night", "night")
end
end
end
if gui:IsA("ImageLabel") and gui.Name:lower():find("logo") then
gui.Image = ""
gui.ImageTransparency = 1
end
end
end)
end)
local ac = {}
ac._window = nil
ac._flags = {}
ac.ConfigManager = nil
local function asBool(v)
return v == true
end
local function wrapElement(kind, get, set)
return {
__type = kind,
Default = get(),
value = get(),
Value = get(),
Set = function(_, v)
set(v)
end,
get = get,
}
end
function ac:Gradient(stops, opts)
return {
stops = stops,
opts = opts or {},
}
end
function ac:AddTheme(theme)
return theme
end
local _panels = {}
local _themes = { Black = true, White = true, Dark = true }
local _currentTheme = "Black"
local _signals = {}
function ac:Notify(opts)
opts = type(opts) == "table" and opts or { Title = tostring(opts) }
local title = opts.Title or opts.title or "night.cc"
local desc = opts.Content or opts.Description or opts.desc or ""
pcall(function()
if _NL and _NL.Notify then
_NL:Notify(title, desc)
end
end)
pcall(function()
local cg = (gethui and gethui()) or game:GetService("CoreGui")
local sg = Instance.new("ScreenGui")
sg.Name = "NightNotify"
sg.ResetOnSpawn = false
sg.Parent = cg
local f = Instance.new("Frame")
f.Size = UDim2.fromOffset(260, 64)
f.Position = UDim2.new(1, -280, 0, 20)
f.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
f.Parent = sg
Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
local tl = Instance.new("TextLabel")
tl.BackgroundTransparency = 1
tl.Size = UDim2.new(1, -12, 0, 22)
tl.Position = UDim2.fromOffset(8, 6)
tl.Font = Enum.Font.Gotham
tl.TextSize = 13
tl.TextColor3 = Color3.fromRGB(255,255,255)
tl.TextXAlignment = Enum.TextXAlignment.Left
tl.Text = tostring(title)
tl.Parent = f
local d = Instance.new("TextLabel")
d.BackgroundTransparency = 1
d.Size = UDim2.new(1, -12, 0, 28)
d.Position = UDim2.fromOffset(8, 30)
d.Font = Enum.Font.Gotham
d.TextSize = 12
d.TextColor3 = Color3.fromRGB(180,180,190)
d.TextXAlignment = Enum.TextXAlignment.Left
d.TextWrapped = true
d.Text = tostring(desc)
d.Parent = f
task.delay(opts.Duration or opts.Time or 3, function()
pcall(function() sg:Destroy() end)
end)
end)
end
function ac:Panel(opts)
opts = opts or {}
local cg = (gethui and gethui()) or game:GetService("CoreGui")
local sg = Instance.new("ScreenGui")
sg.Name = opts.Name or "NightPanel"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.DisplayOrder = 200
sg.Parent = cg
local frame = Instance.new("Frame")
frame.Name = "Root"
frame.Size = opts.Size or UDim2.fromOffset(160, 80)
frame.Position = opts.Position or UDim2.fromOffset(16, 100)
frame.AnchorPoint = opts.AnchorPoint or Vector2.new(0, 0)
frame.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
frame.BackgroundTransparency = 0.15
frame.Visible = opts.Visible ~= false
frame.Parent = sg
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
local stroke = Instance.new("UIStroke")
stroke.Thickness = opts.OutlineThickness or 1
stroke.Color = Color3.fromRGB(255,255,255)
stroke.Transparency = 0.85
stroke.Parent = frame
local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1, -8, 0, 20)
title.Position = UDim2.fromOffset(6, 4)
title.Font = Enum.Font.Gotham
title.TextSize = 12
title.TextColor3 = opts.TitleColor or Color3.fromRGB(240,240,245)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Text = opts.Title or opts.Name or "panel"
title.Parent = frame
local content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundTransparency = 1
content.Position = UDim2.fromOffset(4, 26)
content.Size = UDim2.new(1, -8, 1, -30)
content.Parent = frame
local api = {}
api.Frame = frame
api.ScreenGui = sg
api.Content = content
function api:SetVisible(v) frame.Visible = v and true or false end
function api:Show() frame.Visible = true end
function api:Hide() frame.Visible = false end
function api:SetTitle(s) title.Text = tostring(s or "") end
function api:SetPosition(u) frame.Position = u end
function api:Destroy() pcall(function() sg:Destroy() end) end
function api:GetChildren() return content:GetChildren() end
do
local UIS = game:GetService("UserInputService")
local dragging, start, startPos
frame.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = true
start = input.Position
startPos = frame.Position
end
end)
UIS.InputEnded:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
UIS.InputChanged:Connect(function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local d = input.Position - start
frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
end
end)
end
_panels[#_panels+1] = api
return api
end
function ac:Connect(sig, fn)
if typeof(sig) == "RBXScriptSignal" then
return sig:Connect(fn)
end
return { Disconnect = function() end }
end
function ac:GetThemes()
local list = {}
for k in pairs(_themes) do list[#list+1] = k end
table.sort(list)
return list
end
function ac:GetCurrentTheme()
return _currentTheme
end
function ac:SetTheme(name)
_currentTheme = tostring(name or _currentTheme)
return _currentTheme
end
function ac:CreateWindow(opts)
opts = opts or {}
local title = opts.Title or "nightcc"
local Window = _NL:AddWindow("night.cc", "rbxassetid://8942361531", "night.cc")
self._window = Window
local genv = getgenv and getgenv() or _G
genv.NightCFG_Save = function(name)
if Window and Window._SaveConfig then
return Window._SaveConfig(name or "NightCC")
end
return false
end
genv.NightCFG_Load = function(name)
if Window and Window._LoadConfig then
return Window._LoadConfig(name or "NightCC")
end
return false
end
genv.NightCFG_Export = function(name)
if Window and Window._ExportShare then
return Window._ExportShare(name or "NightCC")
end
return nil
end
genv.NightCFG_Import = function(code)
if Window and Window._ImportShare then
return Window._ImportShare(code)
end
return nil
end
local proxy = {}
proxy._win = Window
proxy.ConfigManager = {
GetConfig = function() return nil end,
CreateConfig = function() return { Elements = {}, Save = function() end, SetAsCurrent = function() end, Get = function() return "{}" end, Set = function() end } end,
Parser = {},
}
ac.ConfigManager = proxy.ConfigManager
proxy.PendingFlags = {}
proxy.Elements = {}
local PRETTY_ACRONYMS = {
esp = "ESP", fov = "FOV", hp = "HP", gui = "GUI", hud = "HUD", ui = "UI", aa = "AA", fps = "FPS",
cfg = "Config", id = "ID", ms = "ms", hz = "Hz", s = "s", dmg = "Damage", cam = "Camera", nightcc = "NightCC",
}
local PRETTY_SMALL = {
a = true, an = true, ["and"] = true, ["or"] = true, of = true, on = true, ["in"] = true,
to = true, ["for"] = true, with = true, at = true, by = true, vs = true, per = true, the = true,
}
local PRETTY_TITLES = {
["aggression"] = "Rage",
["full aggression"] = "Rage Bot",
["wall penetration filter"] = "Autowall",
["min damage through walls (0 = any)"] = "Min Damage Through Walls (0 = Any)",
["force origin (studs, 0 = off)"] = "Force Origin (Studs, 0 = Off)",
["origin range"] = "Origin Scan Radius",
["origin scans"] = "Origin Scan Points",
["scan style"] = "Origin Scan Mode",
["debug points"] = "Show Origin Points",
["peek assist shoot (no peek, shoot through walls)"] = "Peek Shoot (Shoot Through Walls Without Peeking)",
["peek return after shot"] = "Return After Shot",
["tint tint"] = "Tint Color",
}
local function prettyTitle(rawTitle)
local text = tostring(rawTitle or "")
text = text:gsub("^%s+", ""):gsub("%s+$", "")
local override = PRETTY_TITLES[text:lower()]
if override then
return override
end
if text:find("%a%.%a") then
return text
end
text = text:gsub("stylel", "model")
local first = true
text = text:gsub("%a[%w']*", function(word)
local lower = word:lower()
local mapped
if PRETTY_ACRONYMS[lower] then
mapped = PRETTY_ACRONYMS[lower]
elseif word:find("%d") then
mapped = word
elseif PRETTY_SMALL[lower] and not first then
mapped = lower
else
mapped = lower:sub(1, 1):upper() .. lower:sub(2)
end
first = false
return mapped
end)
return text
end
function proxy:Tab(t)
t = t or {}
local name = t.Title or "Tab"
local icon = t.Icon or ""
local tab = Window:AddTab(name, icon)
local currentSection = nil
local tabProxy = {}
local sectionFlip = false
function tabProxy:Section(s)
s = s or {}
sectionFlip = not sectionFlip
local side = sectionFlip and "left" or "right"
currentSection = tab:AddSection(prettyTitle(s.Title or "Section"), side)
return currentSection
end
local function ensureSection()
if not currentSection then
currentSection = tab:AddSection("General", "left")
end
return currentSection
end
function tabProxy:Toggle(o)
o = o or {}
local sec = ensureSection()
local flag = o.Flag or o.Title or "toggle"
local title = o.Title or flag
local state = o.Value == true
ac._flags[flag] = state
ac._bindable = ac._bindable or {}
local el
el = sec:AddToggle(prettyTitle(title), state, function(v)
state = v == true
ac._flags[flag] = state
if o.Callback then pcall(o.Callback, state) end
end)
local obj = wrapElement("Toggle", function() return state end, function(v)
state = v == true
ac._flags[flag] = state
if o.Callback then pcall(o.Callback, state) end
end)
function obj:Set(v)
state = v == true
ac._flags[flag] = state
if o.Callback then pcall(o.Callback, state) end
end
proxy.Elements[flag] = obj
ac._bindable[flag] = {
title = tostring(title),
obj = obj,
get = function() return state end,
set = function(v)
state = v == true
ac._flags[flag] = state
if o.Callback then pcall(o.Callback, state) end
end,
}
return obj
end
function tabProxy:Slider(o)
o = o or {}
local sec = ensureSection()
local flag = o.Flag or o.Title or "slider"
local conf = o.Value or {}
local min = conf.Min or 0
local max = conf.Max or 100
local def = conf.Default or min
local state = def
ac._flags[flag] = state
pcall(function()
sec:AddSlider(prettyTitle(o.Title or flag), min, max, def, function(v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
end)
local obj = wrapElement("Slider", function() return state end, function(v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
obj.Value = { Min = min, Max = max, Default = state }
proxy.Elements[flag] = obj
return obj
end
function tabProxy:Dropdown(o)
o = o or {}
local sec = ensureSection()
local flag = o.Flag or o.Title or "dd"
local values = o.Values or { "None" }
local state = o.Value or values[1]
if type(state) == "table" then state = state[1] or values[1] end
ac._flags[flag] = state
pcall(function()
sec:AddDropdown(prettyTitle(o.Title or flag), values, state, function(v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
end)
local obj = wrapElement("Dropdown", function() return state end, function(v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
proxy.Elements[flag] = obj
return obj
end
function tabProxy:Colorpicker(o)
o = o or {}
local sec = ensureSection()
local flag = o.Flag or o.Title or "color"
local state = o.Default or Color3.fromRGB(255, 255, 255)
ac._flags[flag] = state
local el
pcall(function()
el = sec:AddColorpicker(prettyTitle(o.Title or flag), state, function(v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
end)
local obj = wrapElement("Colorpicker", function() return state end, function(v)
if el and el.Set and pcall(el.Set, el, v) then return end
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end)
obj.Default = state
obj.Apply = function(_, v)
state = v
ac._flags[flag] = v
if o.Callback then pcall(o.Callback, v) end
end
ac._colorEls = ac._colorEls or {}
ac._colorEls[#ac._colorEls + 1] = { title = tostring(o.Title or flag), flag = flag, obj = obj, get = function() return state end }
proxy.Elements[flag] = obj
return obj
end
function tabProxy:Button(o)
o = o or {}
local sec = ensureSection()
pcall(function()
if sec.AddButton then
sec:AddButton(prettyTitle(o.Title or "Button"), function()
if o.Callback then pcall(o.Callback) end
end)
elseif sec.AddToggle then
end
end)
return {}
end
function tabProxy:Keybind(o)
o = o or {}
return wrapElement("Keybind", function() return o.Value end, function() end)
end
function tabProxy:Input(o)
o = o or {}
return wrapElement("Input", function() return o.Value or "" end, function() end)
end
function tabProxy:Paragraph(o)
return {}
end
function tabProxy:Divider()
return {}
end
return tabProxy
end
function proxy:SetPanelBackground() end
function proxy:SetToggleKey() end
proxy._onDestroy = nil
proxy._onClose = nil
function proxy:OnDestroy(fn)
if type(fn) == "function" then self._onDestroy = fn end
local genv = getgenv and getgenv() or _G
local prev = genv.__nightccUnload
genv.__nightccUnload = function()
if self._onDestroy then pcall(self._onDestroy) end
if type(prev) == "function" then pcall(prev) end
end
end
function proxy:OnClose(fn)
if type(fn) == "function" then self._onClose = fn end
end
function proxy:Destroy()
if self._onDestroy then pcall(self._onDestroy) end
if self._onClose then pcall(self._onClose) end
pcall(function()
if self._win and self._win.Destroy then self._win:Destroy() end
end)
end
function proxy:Hide()
pcall(function()
if self._win then
if self._win.Hide then self._win:Hide()
elseif self._win.GetMainFrame then
local f = self._win:GetMainFrame()
if f then f.Visible = false end
end
end
end)
end
function proxy:Show()
pcall(function()
if self._win then
if self._win.Show then self._win:Show()
elseif self._win.GetMainFrame then
local f = self._win:GetMainFrame()
if f then f.Visible = true end
end
end
end)
end
function proxy:IsResizable()
return true
end
function proxy:GetChildren()
return {}
end
function proxy:Disconnect() end
return proxy
end
(function()
local function d(ad)
return Color3.fromHex(ad)
end
local function E(ad, ae, af)
return ac:Gradient({
["0"] = {
Color = d(ad),
Transparency = 0,
},
["100"] = {
Color = d(ae),
Transparency = 0,
},
}, { Rotation = af })
end
local ad = {
{
name = "Pink",
bg = {
"#1A0A14",
"#2B0D22",
},
panel = {
"#1F0C19",
"#2A1024",
},
accent = {
"#F472B6",
"#DB2777",
},
text = "#FFEAF5",
muted = "#C98BAE",
icon = "#F9A8D4",
element = "#2A1222",
hover = "#3A1830",
},
{
name = "Yellow",
bg = {
"#15120A",
"#221A06",
},
panel = {
"#1A160B",
"#241D0A",
},
accent = {
"#FACC15",
"#CA8A04",
},
text = "#FFF9E0",
muted = "#C9B77A",
icon = "#FDE68A",
element = "#262011",
hover = "#332B16",
},
{
name = "White",
bg = {
"#FAFAFA",
"#E9E9EE",
},
panel = {
"#FFFFFF",
"#F4F4F5",
},
accent = {
"#27272A",
"#71717A",
},
text = "#09090B",
muted = "#71717A",
icon = "#3F3F46",
element = "#FFFFFF",
hover = "#F1F1F3",
light = true,
},
{
name = "Black",
bg = {
"#000000",
"#0A0A0A",
},
panel = {
"#050505",
"#0D0D0D",
},
accent = {
"#FFFFFF",
"#71717A",
},
text = "#FFFFFF",
muted = "#8A8A8A",
icon = "#D4D4D8",
element = "#111111",
hover = "#1C1C1C",
},
{
name = "Orange",
bg = {
"#170C05",
"#261206",
},
panel = {
"#1C0F07",
"#26150A",
},
accent = {
"#FB923C",
"#EA580C",
},
text = "#FFF1E6",
muted = "#C9977A",
icon = "#FDBA74",
element = "#28170C",
hover = "#361F11",
},
{
name = "Lime",
bg = {
"#0A1306",
"#122008",
},
panel = {
"#0D1709",
"#13210B",
},
accent = {
"#A3E635",
"#16A34A",
},
text = "#F1FFE6",
muted = "#9DBB82",
icon = "#BEF264",
element = "#16220F",
hover = "#1F2E15",
},
{
name = "Cyan",
bg = {
"#051317",
"#072029",
},
panel = {
"#07171C",
"#0A2029",
},
accent = {
"#22D3EE",
"#0891B2",
},
text = "#E6FCFF",
muted = "#7FB3BF",
icon = "#67E8F9",
element = "#0E222A",
hover = "#142E38",
},
{
name = "Ocean",
bg = {
"#050B1A",
"#0A1733",
},
panel = {
"#08101F",
"#0C1730",
},
accent = {
"#60A5FA",
"#2563EB",
},
text = "#E8F0FF",
muted = "#8497C9",
icon = "#93C5FD",
element = "#101B33",
hover = "#172545",
},
{
name = "Grape",
bg = {
"#0F0719",
"#1C0D33",
},
panel = {
"#130A1F",
"#1B0F2E",
},
accent = {
"#C084FC",
"#7C3AED",
},
text = "#F5EDFF",
muted = "#A68CC9",
icon = "#D8B4FE",
element = "#1D1230",
hover = "#281A42",
},
{
name = "Mint",
bg = {
"#06130E",
"#0A2019",
},
panel = {
"#081711",
"#0B2018",
},
accent = {
"#6EE7B7",
"#10B981",
},
text = "#E9FFF6",
muted = "#86BFA8",
icon = "#A7F3D0",
element = "#0F2219",
hover = "#152E23",
},
{
name = "Lavender",
bg = {
"#0F0C1A",
"#1A1530",
},
panel = {
"#131020",
"#1A162D",
},
accent = {
"#DDD6FE",
"#A78BFA",
},
text = "#F4F1FF",
muted = "#A59CC9",
icon = "#C4B5FD",
element = "#1C1830",
hover = "#262040",
},
{
name = "Sunset",
bg = {
"#170812",
"#260A14",
},
panel = {
"#1B0B14",
"#240D18",
},
accent = {
"#FB923C",
"#EC4899",
},
text = "#FFEFEA",
muted = "#C98E9A",
icon = "#FDA4AF",
element = "#2A1220",
hover = "#38182A",
},
{
name = "Synthwave",
bg = {
"#12061F",
"#07142A",
},
panel = {
"#150A24",
"#0B1530",
},
accent = {
"#FF2BD6",
"#22D3EE",
},
text = "#F9EDFF",
muted = "#A38CC9",
icon = "#F0ABFC",
element = "#1E1233",
hover = "#2A1A45",
},
{
name = "Ice",
bg = {
"#08111A",
"#0E1B29",
},
panel = {
"#0B141F",
"#101C2A",
},
accent = {
"#E0F2FE",
"#38BDF8",
},
text = "#F0F9FF",
muted = "#8FB0C9",
icon = "#BAE6FD",
element = "#13202E",
hover = "#1B2C3D",
},
}
for ae, af in ipairs(ad) do
local ag, ah = af.accent[1], af.accent[2]
local ai = {
Name = af.name,
Accent = E(af.panel[1], af.panel[2], 90),
Dialog = E(af.panel[1], af.panel[2], 90),
Background = E(af.bg[1], af.bg[2], 135),
Text = d(af.text),
Placeholder = d(af.muted),
Icon = d(af.icon),
Button = E(ag, ah, 45),
Toggle = E(ag, ah, 45),
Checkbox = E(ag, ah, 45),
Slider = d(ag),
Primary = d(ag),
WindowOutline = ac:Gradient({
["0"] = {
Color = d(ag),
Transparency = 0,
},
["50"] = {
Color = d(ah),
Transparency = 0,
},
["100"] = {
Color = d(ag),
Transparency = 0,
},
}, { Rotation = 45 }),
SliderIcon = d(af.muted),
TabBackgroundActive = d(ag),
TabBackgroundActiveTransparency = af.light and 0.75 or 0.82,
TabBackgroundHover = d(ag),
TabBackgroundHoverTransparency = af.light and 0.88 or 0.92,
PanelBackground = d(af.light and "#000000" or "#FFFFFF"),
PanelBackgroundTransparency = 0.95,
ElementBackground = d(af.element),
ElementBackgroundTransparency = 0,
ElementBackgroundHover = d(af.hover),
NotificationBorder = d(ag),
NotificationBorderTransparency = 0.7,
}
if af.light then
ai.TabBackground = d("#FFFFFF")
ai.LabelBackground = d("#FFFFFF")
ai.LabelBackgroundTransparency = 0
end
pcall(function()
ac:AddTheme(ai)
end)
end
end)()
task.wait()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
local ad = ac:CreateWindow({
Title = "night.cc",
Icon = "rbxassetid://8942361531",
IconSize = 38,
Author = "night.cc",
Folder = "nightcc",
Size = (function()
local ad, ae = 900, 560
pcall(function()
if isfile and isfile("nightcc/window.json") then
local af = (game:GetService("HttpService")):JSONDecode(readfile("nightcc/window.json"))
if tonumber(af.w) and tonumber(af.h) then
ad, ae = math.max(af.w, 420), math.max(af.h, 260)
end
end
end)
return UDim2.fromOffset(ad, ae)
end)(),
MinSize = Vector2.new(420, 260),
MaxSize = Vector2.new(8192, 8192),
Theme = "Black",
Transparent = false,
Acrylic = true,
OutlineTransparency = 0,
OutlineThickness = 5,
OutlineAnimated = true,
OutlineSpeed = 90,
SideBarWidth = 200,
HideSearchBar = false,
ScrollBarEnabled = true,
ToggleKey = Enum.KeyCode.G,
NewElements = false,
OpenButton = {
Title = "night.cc",
Enabled = true,
OnlyMobile = true,
DragHandle = false,
IconSize = 30,
StrokeThickness = 5,
OutlineAnimated = true,
OutlineSpeed = 90,
},
})
ad:SetPanelBackground(false)
pcall(function()
task.defer(function()
task.wait(0.3)
local function addBg(root)
if not root then return end
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("Frame") and (d.Name == "MainFrame" or d.Name == "Main" or d.Name == "Window") then
local old = d:FindFirstChild("NightAnimeBg")
if old then old:Destroy() end
local img = Instance.new("ImageLabel")
img.Name = "NightAnimeBg"
img.BackgroundTransparency = 1
img.Image = "rbxassetid://8942361531"
img.ScaleType = Enum.ScaleType.Crop
img.ImageTransparency = 0.45
img.Size = UDim2.fromScale(1, 1)
img.Position = UDim2.fromScale(0, 0)
img.ZIndex = 0
img.Parent = d
return true
end
end
end
local roots = {}
pcall(function() if gethui then roots[#roots+1]=gethui() end end)
roots[#roots+1] = game:GetService("CoreGui")
for _, r in ipairs(roots) do addBg(r) end
end)
end)
task.spawn(function()
for _ = 1, 20 do
task.wait(0.25)
pcall(function()
local roots = {}
pcall(function() if gethui then roots[#roots+1] = gethui() end end)
pcall(function() roots[#roots+1] = game:GetService("CoreGui") end)
for _, root in ipairs(roots) do
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("ImageLabel") or d:IsA("ImageButton") then
local n = string.lower(d.Name)
local img = tostring(d.Image or "")
if n:find("logo") or n:find("badge") or n:find("nl") or img:find("118608145176297") then
d.Image = ""
d.ImageTransparency = 1
d.Visible = false
end
end
if d:IsA("TextLabel") or d:IsA("TextButton") then
local tx = tostring(d.Text or "")
if tx == "NL" or tx == "n" or tx == "N" then
d.Text = ""
d.Visible = false
end
if tx:find("tgknight") or tx:find("Lifetime") then
d.Text = (tx:gsub("tgknighthah", "night.cc"):gsub("Lifetime", ""):gsub("tgknight", "night"))
end
end
end
end
end)
end
end)
task.spawn(function()
task.wait(0.5)
pcall(function()
local function bw(c)
if typeof(c) ~= "Color3" then return c end
local g = c.R * 0.3 + c.G * 0.6 + c.B * 0.1
if g < 0.45 then return Color3.new(g*0.3, g*0.3, g*0.3) end
return Color3.new(math.min(1, g*1.1), math.min(1, g*1.1), math.min(1, g*1.1))
end
local roots = {}
pcall(function() table.insert(roots, gethui and gethui()) end)
pcall(function() table.insert(roots, game:GetService("CoreGui")) end)
for _, root in ipairs(roots) do
if not root then continue end
for _, d in ipairs(root:GetDescendants()) do
if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
pcall(function()
d.Font = Enum.Font.Gotham
if d.TextColor3.R < 0.9 or d.TextColor3.G < 0.9 then
local g = d.TextColor3.R*0.3 + d.TextColor3.G*0.5 + d.TextColor3.B*0.2
d.TextColor3 = Color3.new(g, g, g)
end
local tx = d.Text
if tx == "NL" or tx == "n" then d.Text = "" end
if type(tx)=="string" and tx:find("tgknight") then d.Text = "night.cc" end
end)
elseif d:IsA("Frame") or d:IsA("ScrollingFrame") then
pcall(function()
local c = d.BackgroundColor3
if math.abs(c.B - c.R) > 0.02 or math.abs(c.G - c.R) > 0.02 then
local g = (c.R + c.G + c.B) / 3
d.BackgroundColor3 = Color3.new(g, g, g)
end
end)
elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
pcall(function()
if d.Name:lower():find("logo") or d.Name:lower():find("badge") then
d.ImageTransparency = 1
end
d.ImageColor3 = Color3.new(1,1,1)
end)
elseif d:IsA("UIStroke") then
pcall(function()
local c = d.Color
local g = (c.R + c.G + c.B) / 3
d.Color = Color3.new(g, g, g)
end)
end
end
end
end)
end)
pcall(function()
local _uis = game:GetService("UserInputService")
local _cg = gethui and gethui() or game:GetService("CoreGui")
local _sg = Instance.new("ScreenGui")
_sg.Name = "night_ccWatermark"
_sg.ResetOnSpawn = false
_sg.Enabled = false
_sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_sg.DisplayOrder = 2147483000
_sg.IgnoreGuiInset = true
_sg.Parent = nil
local _btn = Instance.new("TextButton")
_btn.Name = "Watermark"
_btn.Size = UDim2.fromOffset(118, 22)
_btn.Position = UDim2.new(0, 14, 0, 10)
_btn.AnchorPoint = Vector2.new(0, 0)
_btn.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
_btn.BackgroundTransparency = 0.25
_btn.BorderSizePixel = 0
_btn.Font = Enum.Font.Gotham
_btn.TextSize = 12
_btn.TextColor3 = Color3.fromRGB(255, 255, 255)
_btn.Text = "night.cc"
_btn.Visible = false
_btn.AutoButtonColor = false
_btn.Parent = _sg
Instance.new("UICorner", _btn).CornerRadius = UDim.new(0, 6)
local _stroke = Instance.new("UIStroke", _btn)
_stroke.Color = Color3.fromRGB(255, 255, 255)
_stroke.Thickness = 1
_stroke.Transparency = 0.7
local _ts = game:GetService("TweenService")
_ts:Create(_stroke, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
Transparency = 0.35,
}):Play()
_btn.MouseButton1Click:Connect(function()
pcall(function()
if ad.Closed or not ad.UIElements or not ad.UIElements.Main or not ad.UIElements.Main.Visible then
ad:Show()
else
ad:Hide()
end
end)
end)
local dragging, dragStart, startPos, inputConn, endConn = false, nil, nil, nil, nil
local function stopDrag()
dragging = false
if inputConn then inputConn:Disconnect() inputConn = nil end
if endConn then endConn:Disconnect() endConn = nil end
end
_btn.InputBegan:Connect(function(inp)
if inp.UserInputType ~= Enum.UserInputType.MouseButton1 and inp.UserInputType ~= Enum.UserInputType.Touch then
return
end
dragging = true
dragStart = inp.Position
startPos = _btn.Position
if inputConn then inputConn:Disconnect() end
if endConn then endConn:Disconnect() end
inputConn = _uis.InputChanged:Connect(function(inp2)
if not dragging then return end
if inp2.UserInputType ~= Enum.UserInputType.MouseMovement and inp2.UserInputType ~= Enum.UserInputType.Touch then
return
end
local delta = inp2.Position - dragStart
_btn.Position = UDim2.new(
startPos.X.Scale, startPos.X.Offset + delta.X,
startPos.Y.Scale, startPos.Y.Offset + delta.Y
)
end)
endConn = _uis.InputEnded:Connect(function(inp2)
if inp2.UserInputType == Enum.UserInputType.MouseButton1 or inp2.UserInputType == Enum.UserInputType.Touch then
stopDrag()
end
end)
end)
aa.onUnload(function()
stopDrag()
pcall(function() _sg:Destroy() end)
end)
end)
local _nightVis = (function()
local _ts = game:GetService("TweenService")
local _uis = game:GetService("UserInputService")
local _rs = game:GetService("RunService")
local _lp = game:GetService("Players").LocalPlayer
local _cam = workspace.CurrentCamera
local _cg = gethui and gethui() or game:GetService("CoreGui")
local cfg = {
hitEffects   = true,
killEffect   = true,
tracers      = true,
hitSound     = true,
tracerColor  = Color3.fromRGB(255, 255, 255),
}
local _gui = Instance.new("ScreenGui")
_gui.Name = "night_ccVisuals"
_gui.ResetOnSpawn = false
_gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
_gui.DisplayOrder = 2147483010
_gui.IgnoreGuiInset = true
_gui.Parent = _cg
local function spawnHitEffect(pos, isHead, isKill)
local vp = _cam:WorldToViewportPoint(pos)
if not vp then return end
local sx, sy = vp.X, vp.Y
local count = isKill and 14 or (isHead and 10 or 7)
local col = isKill and Color3.fromRGB(255,50,50)
or isHead and Color3.fromRGB(255,100,100)
or Color3.fromRGB(220,220,220)
for i = 1, count do
local dot = Instance.new("Frame", _gui)
local sz = math.random(3, isKill and 8 or 5)
dot.Size = UDim2.fromOffset(sz, sz)
dot.BackgroundColor3 = col
dot.BackgroundTransparency = 0
dot.BorderSizePixel = 0
dot.Position = UDim2.fromOffset(sx - sz/2, sy - sz/2)
Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
local ang = math.random() * math.pi * 2
local spd = math.random(30, isKill and 120 or 70)
local dx = math.cos(ang) * spd
local dy = math.sin(ang) * spd - 40
local t = math.random(25, 55) / 100
_ts:Create(dot, TweenInfo.new(t, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Position = UDim2.fromOffset(sx + dx - sz/2, sy + dy - sz/2),
BackgroundTransparency = 1,
}):Play()
game:GetService("Debris"):AddItem(dot, t + 0.05)
end
if isKill then
local flash = Instance.new("Frame", _gui)
flash.Size = UDim2.fromScale(1, 1)
flash.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
flash.BackgroundTransparency = 0.82
flash.BorderSizePixel = 0
flash.ZIndex = 10
_ts:Create(flash, TweenInfo.new(0.35, Enum.EasingStyle.Quad), {
BackgroundTransparency = 1,
}):Play()
game:GetService("Debris"):AddItem(flash, 0.4)
end
end
local _killBanner = Instance.new("TextLabel", _gui)
_killBanner.Size = UDim2.fromOffset(300, 40)
_killBanner.AnchorPoint = Vector2.new(0.5, 0.5)
_killBanner.Position = UDim2.new(0.5, 0, 0.4, 0)
_killBanner.BackgroundTransparency = 1
_killBanner.Font = Enum.Font.Gotham
_killBanner.TextSize = 28
_killBanner.TextColor3 = Color3.fromRGB(255, 255, 255)
_killBanner.TextStrokeColor3 = Color3.fromRGB(200, 30, 30)
_killBanner.TextStrokeTransparency = 0
_killBanner.TextTransparency = 1
_killBanner.Text = "✦ ELIMINATED ✦"
_killBanner.ZIndex = 20
local _bannerActive = false
local function showKillBanner(name)
if _bannerActive then return end
_bannerActive = true
_killBanner.Text = "✦ " .. (name or "ELIMINATED") .. " ✦"
_killBanner.TextTransparency = 1
_killBanner.Position = UDim2.new(0.5, 0, 0.42, 0)
_ts:Create(_killBanner, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
TextTransparency = 0,
Position = UDim2.new(0.5, 0, 0.38, 0),
}):Play()
task.delay(1.1, function()
_ts:Create(_killBanner, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
TextTransparency = 1,
Position = UDim2.new(0.5, 0, 0.35, 0),
}):Play()
task.delay(0.35, function() _bannerActive = false end)
end)
end
local _tracerGui = Instance.new("ScreenGui", _cg)
_tracerGui.Name = "night_ccTracers"
_tracerGui.ResetOnSpawn = false
_tracerGui.IgnoreGuiInset = true
_tracerGui.DisplayOrder = 2147483005
_tracerGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
local _tracerFrame = Instance.new("Frame", _tracerGui)
_tracerFrame.Size = UDim2.fromScale(1, 1)
_tracerFrame.BackgroundTransparency = 1
local _tracerCanvas = Instance.new("Frame", _tracerFrame)
_tracerCanvas.Size = UDim2.fromScale(1, 1)
_tracerCanvas.BackgroundTransparency = 1
local function drawLine(x1, y1, x2, y2, col)
local dx, dy = x2 - x1, y2 - y1
local len = math.sqrt(dx*dx + dy*dy)
if len < 1 then return end
local ang = math.atan2(dy, dx)
local cx, cy = (x1 + x2) / 2, (y1 + y2) / 2
local line = Instance.new("Frame", _tracerCanvas)
line.Size = UDim2.fromOffset(len, 1)
line.AnchorPoint = Vector2.new(0.5, 0.5)
line.Position = UDim2.fromOffset(cx, cy)
line.BackgroundColor3 = col or cfg.tracerColor
line.BackgroundTransparency = 0.35
line.BorderSizePixel = 0
line.Rotation = math.deg(ang)
line.ZIndex = 5
return line
end
local _tracerLines = {}
_rs.RenderStepped:Connect(function()
for _, l in ipairs(_tracerLines) do
pcall(function() l:Destroy() end)
end
_tracerLines = {}
if not cfg.tracers then return end
local plrs = game:GetService("Players"):GetPlayers()
local vpSize = _cam.ViewportSize
local originX = vpSize.X / 2
local originY = vpSize.Y
for _, plr in ipairs(plrs) do
if plr ~= _lp then
pcall(function()
local char = plr.Character
if not char then return end
local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
local hum = char:FindFirstChildOfClass("Humanoid")
if not hum or hum.Health <= 0 then return end
local sp, onScreen = _cam:WorldToViewportPoint(hrp.Position)
if not onScreen then return end
local col = cfg.tracerColor
pcall(function()
if plr.TeamColor then
col = plr.TeamColor.Color
end
end)
local ln = drawLine(originX, originY, sp.X, sp.Y, col)
if ln then table.insert(_tracerLines, ln) end
end)
end
end
end)
local _hitSoundId  = "rbxassetid://5801404836"
local _killSoundId = "rbxassetid://5801404836"
local _hitVol  = 0.6
local _killVol = 0.9
local function playHitSound(isKill)
pcall(function()
local s = Instance.new("Sound")
s.SoundId = isKill and _killSoundId or _hitSoundId
s.Volume = isKill and _killVol or _hitVol
s.RollOffMaxDistance = 0
s.Parent = workspace
s:Play()
game:GetService("Debris"):AddItem(s, 2)
end)
end
return {
onHit = function(isHead, pos)
if cfg.hitEffects then
pcall(spawnHitEffect, pos or Vector3.new(0,0,0), isHead, false)
end
if cfg.hitSound then playHitSound(false) end
end,
onKill = function(name, pos)
if cfg.hitEffects then
pcall(spawnHitEffect, pos or Vector3.new(0,0,0), false, true)
end
if cfg.killEffect then
pcall(showKillBanner, name)
end
if cfg.hitSound then playHitSound(true) end
end,
setTracers   = function(v) cfg.tracers = v end,
setHitSound  = function(v) cfg.hitSound = v end,
setHitFx     = function(v) cfg.hitEffects = v end,
setKillFx    = function(v) cfg.killEffect = v end,
}
end)()
ad:OnDestroy(function()
aa.unload()
end)
task.wait()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
pcall(function()
local ae = "WindUI/nightcc/config/NightCC.json"
if not (isfile and isfile(ae)) then
return
end
local af = (game:GetService("HttpService")):JSONDecode(readfile(ae))
local ag = (af.__elements or af).theme
local ah = type(ag) == "table" and ag.value
if type(ah) == "table" then
ah = ah[1]
end
if type(ah) == "string" and ah ~= ac:GetCurrentTheme() then
ac:SetTheme(ah)
end
end)
local ae
pcall(function()
ae = ad.ConfigManager:CreateConfig("NightCC")
if ae then
ae:SetAsCurrent()
end
end)
local af, ag, ah, ai, aj = ae, "NightCC", nil, nil, nil
local function K()
local ak, al = pcall(function()
return ad.ConfigManager:AllConfigs()
end)
al = (ak and type(al) == "table") and al or {}
local am = false
for an, ao in ipairs(al) do
if ao == ag then
am = true
break
end
end
if not am then
table.insert(al, ag)
end
table.sort(al)
return al
end
local ak
(function()
local al, am, an, ao, ap, aq, ar, as, at, au, av, aw =
game:GetService("UserInputService"),
game:GetService("TweenService"),
game:GetService("TextService"),
game:GetService("HttpService"),
Color3.fromRGB(255, 255, 255),
{},
{},
{},
{},
nil,
nil,
{}
local function a(ax)
if ax.UserInputType == Enum.UserInputType.Keyboard then
if ax.KeyCode == Enum.KeyCode.Unknown then
return nil
end
return ax.KeyCode.Name
elseif ax.UserInputType == Enum.UserInputType.MouseButton1 then
return "MouseLeft"
elseif ax.UserInputType == Enum.UserInputType.MouseButton2 then
return "MouseRight"
elseif ax.UserInputType == Enum.UserInputType.MouseButton3 then
return "MouseMiddle"
end
return nil
end
local ax = ac:Panel({
Name = "NightCCKeybinds",
Title = "hotkeys",
TitleColor = ap,
OutlineThickness = 5,
Size = UDim2.fromOffset(160, 80),
Position = UDim2.new(0, 16, 0.5, -80),
AnchorPoint = Vector2.new(0, 0),
Visible = false,
})
pcall(function() ax:SetVisible(false) end)
pcall(function() if ax.ScreenGui then ax.ScreenGui.Enabled = false end end)
do
local ay = "nightcc/keybinds_position.json"
pcall(function()
if not (isfile and isfile(ay)) then
return
end
local az = ao:JSONDecode(readfile(ay))
if
type(az) ~= "table"
or not (tonumber(az.xs) and (tonumber(az.xo) and (tonumber(az.ys) and tonumber(az.yo))))
then
return
end
local aA = workspace.CurrentCamera.ViewportSize
local aB, aC =
math.clamp(az.xs * aA.X + az.xo, 0, math.max(0, aA.X - 60)),
math.clamp(az.ys * aA.Y + az.yo, 0, math.max(0, aA.Y - 40))
ax.Frame.Position = UDim2.fromOffset(aB, aC)
end)
local az = 0
aa.connect(ax.Frame:GetPropertyChangedSignal("Position"), function()
az = az + 1
local aA = az
task.delay(0.4, function()
if aA ~= az or not writefile then
return
end
local aB = ax.Frame.Position
pcall(function()
if isfolder and (makefolder and not isfolder("nightcc")) then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
writefile(
ay,
ao:JSONEncode({
xs = aB.X.Scale,
xo = aB.X.Offset,
ys = aB.Y.Scale,
yo = aB.Y.Offset,
})
)
end)
end)
end)
end
aa.onUnload(function()
if au then
pcall(function()
au:Destroy()
end)
end
pcall(function()
ax:Destroy()
end)
end)
local ay = Instance.new("UIListLayout")
ay.Padding = UDim.new(0, 4)
ay.SortOrder = Enum.SortOrder.LayoutOrder
ay.Parent = ax.Content
local az = Instance.new("UIPadding")
az.PaddingTop = UDim.new(0, 6)
az.Parent = ax.Content
local function e(aA, aB, aC)
return (an:GetTextSize(aA, aB, aC, Vector2.new(1000, 100))).X
end
local aA = {}
local function o(aB)
if aA[aB] then
return aA[aB]
end
local aC = Instance.new("Frame")
aC.Size = UDim2.new(1, 0, 0, 18)
aC.BackgroundTransparency = 1
aC.LayoutOrder = aB
aC.Parent = ax.Content
local aD = Instance.new("TextLabel")
aD.Size = UDim2.new(1, -56, 1, 0)
aD.BackgroundTransparency = 1
aD.Font = Enum.Font.Gotham
aD.TextSize = 14
aD.TextColor3 = ap
aD.TextXAlignment = Enum.TextXAlignment.Left
aD.Parent = aC
local aE = Instance.new("TextLabel")
aE.Size = UDim2.new(0, 56, 1, 0)
aE.Position = UDim2.new(1, -56, 0, 0)
aE.BackgroundTransparency = 1
aE.Font = Enum.Font.Gotham
aE.TextSize = 14
aE.TextColor3 = ap
aE.TextXAlignment = Enum.TextXAlignment.Right
aE.Parent = aC
aA[aB] = {
row = aC,
label = aD,
key = aE,
}
return aA[aB]
end
local function n()
local aB = {}
for aC, aD in ipairs(as) do
local aE, aF = aq[aD], ar[aD]
if aE and aF then
local aG
if aE.mode == "Always" then
aG = true
elseif aE.mode == "Hold" then
aG = at[aD] == true
else
aG = aF.isActive and aF.isActive() or false
end
if aG then
aB[#aB + 1] = {
name = (tostring(aF.title or aD)):lower(),
key = (aE.mode == "Always" and "on" or tostring(aE.key)):lower(),
}
end
end
end
return aB
end
local function G()
return ax.Frame:FindFirstChildOfClass("UIStroke")
end
local aB, aC, aD = false, 0, {}
local function Y()
for aE, aF in ipairs(aD) do
pcall(function()
aF:Cancel()
end)
end
aD = {}
end
local function H(aE, aF, aG, aH, aI)
if not aE then
return nil
end
local aJ = am:Create(aE, TweenInfo.new(aF, aH or Enum.EasingStyle.Quint, aI or Enum.EasingDirection.Out), aG)
aD[#aD + 1] = aJ
aJ:Play()
return aJ
end
local function i()
ax.Frame.BackgroundTransparency = 0.1
local aE = G()
if aE then
aE.Transparency = 0
end
if ax.Title then
ax.Title.TextTransparency = 0
end
end
local function B()
local aE = ab ~= false and n() or {}
if #aE == 0 then
if aB then
aB = false
aC = aC + 1
local aF = aC
Y()
for aG = 1, #aA, 1 do
aA[aG].row.Visible = false
end
if ax.Title then
H(ax.Title, 0.12, { TextTransparency = 1 })
end
H(ax.Frame, 0.22, { BackgroundTransparency = 1 })
local aG = G()
if aG then
H(aG, 0.22, { Transparency = 1 })
end
local aH = H(ax.Frame, 0.28, {
Size = UDim2.fromOffset(0, 0),
}, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
if aH then
aH.Completed:Once(function()
if aF == aC then
ax:SetVisible(false)
end
end)
else
ax:SetVisible(false)
end
end
return
end
for aF = 1, #aA, 1 do
aA[aF].row.Visible = false
end
local aF = e("Keybinds", 16, Enum.Font.Gotham)
for aG, aH in ipairs(aE) do
local aI = o(aG)
aI.row.Visible = true
aI.label.Text = aH.name
aI.label.TextColor3 = ap
aI.key.Text = "[" .. (aH.key .. "]")
aI.key.TextColor3 = ap
aF = math.max(
aF,
(e(aH.name, 14, Enum.Font.Gotham) + 20) + e("[" .. (aH.key .. "]"), 14, Enum.Font.Gotham)
)
end
local aG, aH = math.clamp(aF + 28, 130, 340), (34 + #aE * 22) + 8
aC = aC + 1
Y()
if not aB then
aB = true
ax:SetVisible(true)
i()
ax.Frame.Size = UDim2.fromOffset(aG, 0)
else
i()
end
H(ax.Frame, 0.2, {
Size = UDim2.fromOffset(aG, aH),
})
end
local function s(aE)
pcall(function()
local aF = af or ae
if not aF then
return
end
aF:Set("nightccBinds", ao:JSONEncode(aq))
if aE ~= false then
aF:Save()
end
end)
end
local function g(aE, aF, aG)
aq[aE] = {
key = aF,
mode = aG,
}
local aH = ar[aE]
if aH and (aG == "Always" and aH.kind == "toggle") then
aH.setState(true)
end
s()
B()
end
local function f(aE)
aq[aE] = nil
at[aE] = nil
s()
B()
end
local aE, aF, aG = nil, false, nil
local function U()
if aG and aG.Parent then
return aG
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
aG = Instance.new("ScreenGui")
aG.Name = "NightCCBindPopup"
aG.IgnoreGuiInset = true
aG.ResetOnSpawn = false
aG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
aG.DisplayOrder = 2147483025
aG.Parent = gethui and gethui() or game:GetService("CoreGui")
return aG
end
aa.onUnload(function()
if aG then
pcall(function()
aG:Destroy()
end)
end
end)
local aH = game:GetService("GuiService")
local function m()
return al:GetMouseLocation() - aH:GetGuiInset()
end
local function j(aI, aJ)
if not (aI and (aI.Parent and aI.Visible)) then
return false
end
local aK, aL = aI.AbsolutePosition, aI.AbsoluteSize
return aJ.X >= aK.X and (aJ.X <= aK.X + aL.X and (aJ.Y >= aK.Y and aJ.Y <= aK.Y + aL.Y))
end
local aI = ac.Creator
local aJ = aI and aI.Font or "rbxassetid://12187365364"
local function F(aK, aL)
local aM, aN = pcall(function()
return aI.GetThemeProperty(aK, ac.Theme)
end)
if aM then
if typeof(aN) == "Color3" then
return aN
end
if type(aN) == "table" and typeof(aN.Color) == "ColorSequence" then
return aN.Color.Keypoints[1].Value, aN
end
end
return aL
end
local function t(aK)
local aL, aM = pcall(function()
return aI.Icon("chevron-down")
end)
if not (aL and (type(aM) == "table" and aM[1])) then
return nil
end
local aN = Instance.new("ImageLabel")
aN.BackgroundTransparency = 1
aN.Image = aM[1]
aN.ImageRectSize = aM[2].ImageRectSize
aN.ImageRectOffset = aM[2].ImageRectPosition
aN.Size = UDim2.fromOffset(14, 14)
aN.AnchorPoint = Vector2.new(1, 0.5)
aN.Position = UDim2.new(1, -7, 0.5, 0)
aN.Parent = aK
return aN
end
local aK, aL, aM, aN, aO = 158, 36, 5, 26, 64
local aP, aQ = (aK - aO) - aM * 3, {
"Hold",
"Toggle",
}
local function zT(aR)
if au then
pcall(function()
au:Destroy()
end)
au = nil
end
if aE then
aE:Disconnect()
aE = nil
end
aF = false
local aS = ar[aR]
local aU = aS and aS.frame
if typeof(aU) ~= "Instance" then
return
end
local aV, aW, aX, aY =
F("Text", ap),
F("Placeholder", Color3.fromRGB(160, 160, 170)),
F("Primary", Color3.fromRGB(129, 140, 248)),
F("ElementBackground", Color3.fromRGB(30, 30, 38))
local aZ, a_, a0 = F("ElementBackgroundHover", aY:Lerp(ap, 0.06)), F("Background", Color3.fromRGB(16, 16, 20))
local function c(a1, a2)
local a3 = Instance.new("UICorner")
a3.CornerRadius = UDim.new(0, a2)
a3.Parent = a1
end
local function Q(a1, a2, a3, a4)
local a5 = Instance.new("UIStroke")
a5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
a5.Color, a5.Transparency, a5.Thickness = a2, a3, a4 or 1
a5.Parent = a1
return a5
end
local function b(a1)
a1.BackgroundColor3 = a_
a1.BackgroundTransparency = 0.02
if a0 then
local a2 = Instance.new("UIGradient")
a2.Color = a0.Color
a2.Rotation = tonumber(a0.Rotation) or 90
a2.Parent = a1
end
end
local function T(a1, a2, a3)
local a4 = Instance.new("TextLabel")
a4.BackgroundTransparency = 1
a4.FontFace = Font.new(aJ, a3 or Enum.FontWeight.SemiBold)
a4.TextSize = 14
a4.TextColor3 = aV
a4.Text = a2
a4.TextTruncate = Enum.TextTruncate.AtEnd
a4.Parent = a1
return a4
end
local function w(a1, a2, a3)
local a4 = Instance.new("TextButton")
a4.AutoButtonColor = false
a4.Text = ""
a4.BorderSizePixel = 0
a4.BackgroundColor3 = aY
a4.Position = UDim2.fromOffset(a2, aM)
a4.Size = UDim2.fromOffset(a3, aN)
a4.Parent = a1
c(a4, 8)
aa.connect(a4.MouseEnter, function()
a4.BackgroundColor3 = aZ
end)
aa.connect(a4.MouseLeave, function()
a4.BackgroundColor3 = aY
end)
return a4
end
local a1 = Instance.new("Frame")
a1.Name = "Popup"
a1.Size = UDim2.fromOffset(aK, aL)
a1.BorderSizePixel = 0
a1.Active = true
b(a1)
c(a1, 11)
Q(a1, aX, 0.55, 1.2)
local a2 = (aq[aR] and aq[aR].mode == "Hold") and "Hold" or "Toggle"
local function Z()
local a3 = aq[aR]
if not a3 then
return "none"
end
if a3.mode == "Always" then
return "always"
end
return (tostring(a3.key)):lower()
end
local a3 = w(a1, aM, aO)
local a4, a5 = Q(a3, aX, 1, 1.4), T(a3, Z())
a5.Size = UDim2.fromScale(1, 1)
local function J()
a5.Text = Z()
a5.TextColor3 = aq[aR] and aV or aW
end
J()
local a6 = w(a1, aM * 2 + aO, aP)
local a7 = T(a6, a2:lower())
a7.TextXAlignment = Enum.TextXAlignment.Left
a7.Position = UDim2.fromOffset(9, 0)
a7.Size = UDim2.new(1, -30, 1, 0)
local a8 = t(a6)
if a8 then
a8.ImageColor3 = aV
end
local a9, ba = 24, Instance.new("Frame")
ba.Position = UDim2.fromOffset(aM * 2 + aO, aL + 4)
ba.Size = UDim2.fromOffset(aP, (#aQ * a9 + (#aQ - 1) * 2) + 8)
ba.BorderSizePixel = 0
ba.Visible = false
ba.Active = true
ba.Parent = a1
b(ba)
c(ba, 10)
Q(ba, aX, 0.55, 1.2)
local bb = {}
local function s()
for bc, bd in pairs(bb) do
local be = bc == a2
bd.btn.BackgroundColor3 = be and aX or aZ
bd.btn.BackgroundTransparency = be and 0.8 or bd.hot and 0.4 or 1
bd.lbl.TextTransparency = be and 0 or 0.4
end
end
for bc, bd in ipairs(aQ) do
local be = Instance.new("TextButton")
be.AutoButtonColor = false
be.Text = ""
be.BorderSizePixel = 0
be.Position = UDim2.fromOffset(4, 4 + (bc - 1) * (a9 + 2))
be.Size = UDim2.new(1, -8, 0, a9)
be.Parent = ba
c(be, 7)
local bf = T(be, bd:lower(), Enum.FontWeight.Medium)
bf.TextXAlignment = Enum.TextXAlignment.Left
bf.Position = UDim2.fromOffset(8, 0)
bf.Size = UDim2.new(1, -8, 1, 0)
local bg = {
btn = be,
lbl = bf,
hot = false,
}
bb[bd] = bg
aa.connect(be.MouseEnter, function()
bg.hot = true
s()
end)
aa.connect(be.MouseLeave, function()
bg.hot = false
s()
end)
aa.connect(be.MouseButton1Click, function()
a2 = bd
a7.Text = bd:lower()
ba.Visible = false
if a8 then
a8.Rotation = 0
end
s()
local bh = aq[aR]
if bh and (bh.mode ~= bd and bh.key ~= "ON") then
g(aR, bh.key, bd)
end
end)
end
s()
aa.connect(a6.MouseButton1Click, function()
ba.Visible = not ba.Visible
if a8 then
a8.Rotation = ba.Visible and 180 or 0
end
end)
local bc, bd
local function k()
aF = false
if aE then
aE:Disconnect()
aE = nil
end
a4.Transparency = 1
end
local function zT()
k()
if bc then
bc:Disconnect()
bc = nil
end
if bd then
bd:Disconnect()
bd = nil
end
if au == a1 then
au = nil
end
pcall(function()
a1:Destroy()
end)
end
aa.connect(a3.MouseButton1Click, function()
if aF then
k()
J()
return
end
ba.Visible = false
if a8 then
a8.Rotation = 0
end
aF = true
a5.Text = "..."
a5.TextColor3 = aV
a4.Transparency = 0.1
if aE then
aE:Disconnect()
end
aE = aa.connect(al.InputBegan, function(be)
local bf = be.UserInputType
if bf == Enum.UserInputType.Keyboard then
if be.KeyCode == Enum.KeyCode.Escape or be.KeyCode == Enum.KeyCode.Backspace then
f(aR)
else
local bg = a(be)
if not bg then
return
end
g(aR, bg, a2)
end
elseif bf == Enum.UserInputType.MouseButton2 or bf == Enum.UserInputType.MouseButton3 then
g(aR, a(be), a2)
else
return
end
k()
J()
end)
end)
local be = U()
a1.Parent = be
au = a1
local function RT()
if not (aU.Parent and a1.Parent) then
zT()
return
end
local bf, bg, bh, bi = be.AbsolutePosition, be.AbsoluteSize, aU.AbsolutePosition, aU.AbsoluteSize
local bj = (bh.X + bi.X) + 8
if bj + aK > (bf.X + bg.X) - 4 then
bj = (bh.X - aK) - 8
end
local bk = bh.Y + (bi.Y - aL) / 2
a1.Position = UDim2.fromOffset(bj - bf.X, bk - bf.Y)
end
RT()
bc = aa.connect(O.RenderStepped, RT)
bd = aa.connect(al.InputBegan, function(bf)
if au ~= a1 then
zT()
return
end
local bg = bf.UserInputType
if bg ~= Enum.UserInputType.MouseButton1 and bg ~= Enum.UserInputType.MouseButton2 then
return
end
if aF and bg == Enum.UserInputType.MouseButton2 then
return
end
local bh = m()
if not j(a1, bh) and not j(ba, bh) then
zT()
end
end)
end
aa.connect(al.InputBegan, function(aR)
if aR.UserInputType == Enum.UserInputType.MouseButton3 and (av and not aF) then
zT(av)
end
end)
aa.connect(al.InputBegan, function(aR, aS)
if aF or al:GetFocusedTextBox() then
return
end
if aS and aR.UserInputType ~= Enum.UserInputType.Keyboard then
return
end
local aU = a(aR)
if not aU then
return
end
for aV, aW in pairs(aq) do
if aW.key == aU and aW.mode ~= "Always" then
local aX = ar[aV]
if aX then
if aW.mode == "Toggle" then
if aX.kind == "toggle" then
aX.setState(not aX.isActive())
else
aX.fire()
end
B()
elseif aW.mode == "Hold" then
at[aV] = true
if aX.kind == "toggle" then
aX.setState(true)
else
aX.fire()
end
B()
end
end
end
end
end)
aa.connect(al.InputEnded, function(aR)
local aS = a(aR)
if not aS then
return
end
for aU, aV in pairs(aq) do
if aV.key == aS and (aV.mode == "Hold" and at[aU]) then
at[aU] = false
local aW = ar[aU]
if aW and aW.kind == "toggle" then
aW.setState(false)
end
B()
end
end
end)
local aR = 0
aa.connect(O.RenderStepped, function()
if au and (ad.Closed or ad.Destroyed) then
if aE then
aE:Disconnect()
aE = nil
end
pcall(function()
au:Destroy()
end)
au = nil
end
for aS, aU in pairs(aq) do
local aV = ar[aS]
if aV then
if aU.mode == "Always" then
if aV.kind == "toggle" then
if aV.isActive and not aV.isActive() then
aV.setState(true)
end
elseif aV.fire then
aV.fire()
end
elseif aU.mode == "Hold" and (at[aS] and (aV.kind == "button" and aV.fire)) then
aV.fire()
end
end
end
if os.clock() - aR >= 0.3 then
aR = os.clock()
B()
end
end)
ak = {}
function ak.register(aS, aU, aV)
if type(aU) == "table" then
if aV.auto then
aU.__zbAuto = aS
elseif aU.__zbAuto and aU.__zbAuto ~= aS then
local aW = aU.__zbAuto
aw[aW] = aS
ar[aW] = nil
for aX = #as, 1, -1 do
if as[aX] == aW then
table.remove(as, aX)
end
end
end
end
ar[aS] = {
frame = aU and aU.ElementFrame,
kind = aV.kind,
setState = aV.setState,
isActive = aV.isActive,
fire = aV.fire,
title = aV.title or aS,
}
as[#as + 1] = aS
if aU and aU.ElementFrame then
local aW = aU.ElementFrame
aa.connect(aW.MouseEnter, function()
av = aw[aS] or aS
end)
aa.connect(aW.MouseLeave, function()
if av == aS or av == aw[aS] then
av = nil
end
end)
end
end
function ak.loadBinds()
local aS = {}
pcall(function()
local aU = af or ae
if aU then
local aV = aU:Get("nightccBinds")
if aV and aV ~= "" then
local aW = ao:JSONDecode(aV)
if type(aW) == "table" then
aS = aW
end
end
end
end)
aq = aS
table.clear(at)
for aU, aV in pairs(aq) do
if aV.mode == "Always" then
local aW = ar[aU]
if aW and (aW.kind == "toggle" and aW.setState) then
aW.setState(true)
end
end
end
B()
end
function ak.refresh()
B()
end
function ak.saveBinds(aS)
s(aS)
end
end)()
do
local al, am, an, ao, ap, aq, ar, as =
game:GetService("UserInputService"), game:GetService("TextService"), game:GetService("HttpService"), {
"Toggle",
"Slider",
"Dropdown",
"Colorpicker",
"Input",
"Button",
"Keybind",
"Section",
"Paragraph",
"Divider",
"Space",
"Code",
"Image",
}, {
Toggle = true,
Slider = true,
Dropdown = true,
Colorpicker = true,
Input = true,
Button = true,
Keybind = true,
}, {
Toggle = 1,
Button = 1,
Slider = 1.5,
Dropdown = 1.2,
Colorpicker = 1,
Input = 1.2,
Keybind = 1,
Section = 1,
Paragraph = 2,
}, 440, ad.UIElements and ad.UIElements.Main
local at, au = as and as:FindFirstAncestorOfClass("ScreenGui"), Instance.new("Frame")
au.Name = "NightCCTip"
au.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
au.BackgroundTransparency = 0.04
au.BorderSizePixel = 0
au.Visible = false
au.ZIndex = 100000
au.Parent = at;
(Instance.new("UICorner", au)).CornerRadius = UDim.new(0, 6)
local av = Instance.new("UIStroke", au)
av.Color = Color3.new(1, 1, 1)
av.Transparency = 0.8
local aw = Instance.new("TextLabel")
aw.BackgroundTransparency = 1
aw.Position = UDim2.fromOffset(8, 6)
aw.Font = Enum.Font.Gotham
aw.TextSize = 13
aw.TextColor3 = Color3.fromRGB(230, 230, 235)
aw.TextWrapped = true
aw.TextXAlignment = Enum.TextXAlignment.Left
aw.TextYAlignment = Enum.TextYAlignment.Top
aw.ZIndex = 100001
aw.Parent = au
aa.onUnload(function()
au:Destroy()
end)
local ax
local function Q(ay, az)
ax = ay
local aA = am:GetTextSize(az, 13, Enum.Font.Gotham, Vector2.new(260, 1000))
aw.Text = az
aw.Size = UDim2.fromOffset(aA.X + 2, aA.Y + 2)
au.Size = UDim2.fromOffset(aA.X + 18, aA.Y + 14)
au.Visible = true
end
local function b(ay)
if ax == ay then
ax = nil
au.Visible = false
end
end
aa.connect(O.RenderStepped, function()
if not au.Visible then
return
end
if not (ax and ax:IsDescendantOf(game)) or ad.Closed then
ax, au.Visible = nil, false
return
end
local ay, az, aA, aB =
al:GetMouseLocation(),
at and at.AbsolutePosition or Vector2.new(0, 0),
(at and at.IgnoreGuiInset) and Vector2.new(0, 0) or (game:GetService("GuiService")):GetGuiInset(),
workspace.CurrentCamera.ViewportSize
local aC, aD =
math.min(ay.X + 14, (aB.X - au.AbsoluteSize.X) - 4), math.min(ay.Y + 16, (aB.Y - au.AbsoluteSize.Y) - 4)
au.Position = UDim2.fromOffset((aC - az.X) - aA.X, (aD - az.Y) - aA.Y)
end)
local function a(ay, az)
local aA = ay:FindFirstChild("TitleFrame", true)
local aB = aA and aA:FindFirstChild("TitleFrame")
local aC = aB and aB:FindFirstChildOfClass("TextLabel")
if not aC then
return false
end
local aD = Instance.new("UIPadding")
aD.PaddingLeft = UDim.new(0, 22)
aD.Parent = aC
local aE = Instance.new("TextLabel")
aE.Name = "Info"
aE.Size = UDim2.fromOffset(15, 15)
aE.Position = UDim2.fromOffset(-22, 1)
aE.BackgroundTransparency = 1
aE.Font = Enum.Font.Gotham
aE.TextSize = 11
aE.Text = "i"
aE.TextColor3 = aC.TextColor3
aE.TextTransparency = 0.25
aE.Active = true
aE.ZIndex = aC.ZIndex + 1
aE.Parent = aC;
(Instance.new("UICorner", aE)).CornerRadius = UDim.new(1, 0)
local aF = Instance.new("UIStroke", aE)
aF.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
aF.Thickness = 1.2
aF.Color = aC.TextColor3
aF.Transparency = 0.45
aa.connect(aC:GetPropertyChangedSignal("TextColor3"), function()
aE.TextColor3, aF.Color = aC.TextColor3, aC.TextColor3
end)
aa.connect(aE.MouseEnter, function()
aE.TextTransparency, aF.Transparency = 0, 0.1
Q(aE, az)
end)
aa.connect(aE.MouseLeave, function()
aE.TextTransparency, aF.Transparency = 0.25, 0.45
b(aE)
end)
return true
end
local ay = {}
function ak.shapeTab(az, aA)
if type(az) ~= "table" or ay[az] then
return az
end
local aB = {
col = 1,
weight = { 0, 0 },
}
ay[az] = aB
local function M()
if aB.cols then
return aB.cols
end
local aC = az.UIElements and az.UIElements.ContainerFrame
if not aC then
return nil
end
local aD = aC:FindFirstChildOfClass("UIListLayout")
if not aD then
return nil
end
local aE, aF = aD.Padding, Instance.new("Frame")
aF.Name = "ZbColumns"
aF.BackgroundTransparency = 1
aF.Size = UDim2.new(1, 0, 0, 0)
aF.AutomaticSize = Enum.AutomaticSize.Y
aF.LayoutOrder = -1
aF.Parent = aC
local aG = Instance.new("UIListLayout")
aG.FillDirection = Enum.FillDirection.Horizontal
aG.SortOrder = Enum.SortOrder.LayoutOrder
aG.Padding = UDim.new(0, 10)
aG.Parent = aF
local aH = {}
for aI = 1, 2, 1 do
local aJ = Instance.new("Frame")
aJ.Name = "Column" .. aI
aJ.BackgroundTransparency = 1
aJ.AutomaticSize = Enum.AutomaticSize.Y
aJ.LayoutOrder = aI
aJ.Parent = aF
local aK = Instance.new("UIListLayout")
aK.SortOrder = Enum.SortOrder.LayoutOrder
aK.Padding = aE
aK.Parent = aJ
aH[aI] = aJ
end
local aI
local function P()
local aJ = aC.AbsoluteSize.X < ar
if aJ == aI then
return
end
aI = aJ
aG.FillDirection = aJ and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal
for aK = 1, 2, 1 do
aH[aK].Size = aJ and UDim2.new(1, 0, 0, 0) or UDim2.new(0.5, -5, 0, 0)
end
end
P()
aa.connect(aC:GetPropertyChangedSignal("AbsoluteSize"), P)
aB.cols = aH
return aH
end
for aC, aD in ipairs(ao) do
local aE = az[aD]
if type(aE) == "function" then
az[aD] = function(aF, aG, ...)
local aH, aI = type(aG) == "table", nil
if aH and (ap[aD] and (type(aG.Desc) == "string" and aG.Desc ~= "")) then
aI = aG.Desc
aG.Desc = nil
end
local aJ, aK = false, aH and aG.Callback or nil
if aH and aD == "Toggle" then
aJ = aG.Value == true
aG.Callback = function(aL, ...)
aJ = aL == true
if aK then
return aK(aL, ...)
end
end
end
local aL = aE(aF, aG, ...)
local aM = type(aL) == "table" and aL.ElementFrame
aa.breathe()
if typeof(aM) ~= "Instance" then
return aL
end
local aN = M()
if aN then
if aD == "Section" then
aB.col = aB.weight[2] < aB.weight[1] and 2 or 1
end
aB.weight[aB.col] = aB.weight[aB.col] + (aq[aD] or 1)
aM.Parent = aN[aB.col]
end
if aI and not a(aM, aI) then
pcall(function()
aL:SetDesc(aI)
end)
end
if aD == "Colorpicker" and (aH and (type(aK) == "function" and type(aL.Update) == "function")) then
local aO = aL.Update
aL.Update = function(aP, aQ, aR, ...)
local aS = aO(aP, aQ, aR, ...)
if typeof(aQ) == "Color3" then
pcall(aK, aQ, aR)
end
return aS
end
end
if aH and (type(aG.Title) == "string" and (aD == "Toggle" or aD == "Button")) then
local aO = "auto:"
.. (type(aG.Flag) == "string" and aG.Flag or tostring(aA) .. ("/" .. aG.Title))
if aD == "Toggle" then
ak.register(aO, aL, {
auto = true,
kind = "toggle",
title = aG.Title,
isActive = function()
return aJ
end,
setState = function(aP)
pcall(function()
aL:Set(aP)
end)
if aJ ~= aP then
aG.Callback(aP)
end
end,
})
elseif type(aK) == "function" then
ak.register(aO, aL, {
auto = true,
kind = "button",
title = aG.Title,
fire = function()
aK()
end,
})
end
end
return aL
end
end
end
return az
end
aa.building = true
aa.lastBreath = os.clock()
function aa.breathe()
if not aa.building or os.clock() - aa.lastBreath < 0.005 or not coroutine.isyieldable() then
return
end
task.wait()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
aa.lastBreath = os.clock()
end
do
local az
pcall(function()
az = require(L.Controllers.CameraController)
end)
local aA = false
local function x(aB)
if aB == aA then
return
end
aA = aB
if az and type(az.setForceLockOverride) == "function" then
pcall(az.setForceLockOverride, "nightcc", aB)
else
pcall(function()
al.MouseBehavior = aB and Enum.MouseBehavior.Default or Enum.MouseBehavior.LockCenter
al.MouseIconEnabled = aB
end)
end
end
aa.connect(O.RenderStepped, function()
local mainVisible = false
pcall(function()
mainVisible = as ~= nil and as.Visible == true
end)
local aB = not aa.unloaded and (not ad.Closed and (not ad.Destroyed and mainVisible))
if aB and (aA and (al.MouseBehavior ~= Enum.MouseBehavior.Default or not al.MouseIconEnabled)) then
aA = false
end
x(aB)
end)
aa.onUnload(function()
x(false)
pcall(function()
al.MouseBehavior = Enum.MouseBehavior.LockCenter
al.MouseIconEnabled = false
end)
end)
pcall(function()
if type(ad.OnClose) == "function" then
ad:OnClose(function()
pcall(function()
x(false)
al.MouseBehavior = Enum.MouseBehavior.LockCenter
al.MouseIconEnabled = false
end)
end)
end
end)
pcall(function()
local oldHide = ad.Hide
if type(oldHide) == "function" then
ad.Hide = function(...)
local r = oldHide(...)
pcall(function()
x(false)
al.MouseBehavior = Enum.MouseBehavior.LockCenter
al.MouseIconEnabled = false
end)
return r
end
end
end)
if as then
local aB = Instance.new("TextButton")
aB.Name = "NightCCModal"
aB.Size = UDim2.fromOffset(0, 0)
aB.BackgroundTransparency = 1
aB.Text = ""
aB.Modal = true
aB.Parent = as
end
end
local az = ad.Tab
ad.Tab = function(aA, aB, ...)
local aC = az(aA, aB, ...)
return ak.shapeTab(aC, type(aB) == "table" and aB.Title or "?")
end
local aA
if as then
for aB, aC in ipairs(as:GetDescendants()) do
if aC:IsA("ImageLabel") and aC.Image == "rbxassetid://120997033468887" then
aA = aC.Parent
break
end
end
end
if aA then
pcall(function()
ad:IsResizable(false)
end)
local aB, aC, aD = 420, 260, nil
aa.connect(aA.InputBegan, function(aE)
if aE.UserInputType ~= Enum.UserInputType.MouseButton1 or aD then
return
end
aD = {
mouse = al:GetMouseLocation(),
w = as.Size.X.Offset,
h = as.Size.Y.Offset,
pos = as.Position,
frozen = {},
}
local aF = ad.UIElements.MainBar
if aF then
for aG, aH in ipairs(aF:GetChildren()) do
if aH:IsA("Frame") and not aH.Visible then
aD.frozen[aH] = aH.Size
aH.Size = UDim2.fromOffset(aH.AbsoluteSize.X, aH.AbsoluteSize.Y)
end
end
end
end)
aa.connect(O.RenderStepped, function()
if not aD then
return
end
local aE = al:GetMouseLocation()
if aE == aD.last then
return
end
aD.last = aE
local aF = workspace.CurrentCamera.ViewportSize
local aG, aH =
math.clamp(aD.w + (aE.X - aD.mouse.X), aB, math.max(aB, aF.X)),
math.clamp(aD.h + (aE.Y - aD.mouse.Y), aC, math.max(aC, aF.Y))
as.Size = UDim2.fromOffset(aG, aH)
as.Position = aD.pos + UDim2.fromOffset((aG - aD.w) / 2, (aH - aD.h) / 2)
ad.Size = as.Size
end)
aa.connect(al.InputEnded, function(aE)
if aE.UserInputType ~= Enum.UserInputType.MouseButton1 or not aD then
return
end
for aF, aG in pairs(aD.frozen) do
pcall(function()
aF.Size = aG
end)
end
aD = nil
pcall(function()
if isfolder and (makefolder and not isfolder("nightcc")) then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
writefile(
"nightcc/window.json",
an:JSONEncode({
w = as.Size.X.Offset,
h = as.Size.Y.Offset,
})
)
end)
end)
end
end
local al, am = hookfunction, {}
local function Q(an, ao)
if isfunctionhooked and (restorefunction and isfunctionhooked(an)) then
pcall(restorefunction, an)
end
am[#am + 1] = an
return al(an, ao)
end
aa.onUnload(function()
if not restorefunction then
return
end
for an, ao in ipairs(am) do
pcall(restorefunction, ao)
end
end)
do
local an = require(L.Components.Weapon.Classes.Bullet)
if isfunctionhooked and (restorefunction and isfunctionhooked(an._performRaycast)) then
pcall(restorefunction, an._performRaycast)
end
end
local an, ao, ap, aq, ar, as, at, au, av, aw, ax =
game:GetService("UserInputService"),
game:GetService("ContextActionService"),
game:GetService("TweenService"),
game:GetService("SoundService"),
game:GetService("HttpService"),
game:GetService("Debris"),
workspace.CurrentCamera,
require(L.Controllers.CharacterController),
require(L.Controllers.CameraController),
require(L.Controllers.InventoryController),
require(L.Classes.Character)
local function p()
local ay, az = pcall(debug.getupvalue, aw.getInventorySlot, 1)
if ay and type(az) == "table" then
return rawget(az, "CurrentEquipped")
end
return nil
end
local ay, az, aA, aB, aC, aD =
require(L.MovementV2.Simulation.Config),
require(L.Database.Components.Libraries.Skins),
require(L.Classes.WeaponComponent.Classes.Viewmodel),
L.Database.Custom.Weapons,
{
bhop = false,
bhopCrouch = false,
aaStaticAngle = 180,
bhopSpeedBoost = false,
bhopBoostPct = 2,
bhopMaxSpeed = 80,
bhopDelay = 0,
bhopChance = 100,
bhopEdge = false,
bhopHud = false,
strafe = false,
alignDeg = 6,
strafeMode = "Rage",
fastTurn = true,
landBrake = false,
longJump = false,
boostJump = false,
duckTicks = 12,
noSpeedPenalty = false,
speed = false,
speedLimit = 25,
silentAim = false,
fov = 120,
showFov = true,
fovColor = Color3.fromRGB(255, 255, 255),
aimPart = "Head",
wallCheck = true,
teamCheck = true,
minDmg = 20,
minDmgOverride = false,
minDmgOverrideValue = 5,
noSpread = false,
noRecoil = false,
rage = false,
rageAutoFire = true,
rageAutowall = true,
rageWallMinDmg = 0,
forceOrigin = 0,
rageHitbox = "Head",
rageMaxDist = math.huge,
rapidFire = false,
rapidMult = 2,
rapidUnlimited = false,
wallbang = false,
penMod = false,
penValue = 10,
originOn = false,
originX = 0,
originY = 0,
originZ = 0,
originMarker = true,
originScan = false,
originScanRadius = 8,
originScans = 4,
originScanMode = "optimized",
originScanDebug = false,
backtrack = false,
backtrackMs = 200,
forwardTrack = false,
forwardMs = 100,
wallLimit = false,
maxWalls = 1,
bulletTp = false,
bulletTpDist = 2,
tapKill = false,
maxTaps = 3,
revolverAlt = true,
doubleTap = false,
rageRemote = true,
killAll = false,
killAllDelay = 0.1,
peekAssist = false,
peekAssistMode = "Visible",
peekAssistTarget = "Nearest",
peekAssistDist = 8,
peekAssistEnemy = 200,
peekAssistLine = true,
peekAssistColor = Color3.fromRGB(90, 255, 170),
peekShoot = false,
peekShootFov = 360,
loopKill = false,
ufoEnabled = false,
ufoSpeed = 80,
loopTarget = nil,
knifeBot = false,
knifeHeavy = false,
knifeBotRange = 3.5,
autoBuy = false,
buyPrimary = "AK-47",
buySecondary = "USP-S",
buyZeus = false,
buyNades = "",
buyDelay = 0.35,
killAllWaitRound = true,
killAllLeadMs = 100,
rageTargetMode = "Distance",
preferBodyLethal = true,
forceBody = false,
predictMs = 0,
rageMulti = false,
rageSticky = false,
rageScanHz = 300,
missAdapt = false,
missesToBody = 2,
ignoreFriends = false,
rageIndicator = false,
ragePrediction = false,
ragePredictionAmount = 0.12,
aaBase = "View",
aaManual = nil,
aaAutoManual = false,
aaAutoManualRange = 6,
aa = false,
aaYaw = "Backwards",
aaSpin = 30,
aaJitter = 90,
aaJitterDelay = 8,
aaPitch = "Down",
aaOffShot = true,
autoReload = false,
instaReload = false,
reloadSpeed = 3,
reloadAt = 1,
remoteReload = false,
esp = false,
espEnemyColor = Color3.fromRGB(255, 60, 60),
espTeam = false,
espTeamColor = Color3.fromRGB(60, 160, 255),
espFill = 0.6,
espNames = true,
espDistance = true,
espChams = true,
selfChams = false,
selfChamsColor = Color3.fromRGB(255, 255, 255),
selfChamsFill = 0.45,
selfChamsOutline = true,
selfChamsMaterial = "ForceField",
espChamsRainbow = false,
espChamsOccluded = false,
espChamsGlow = 4,
espBox = true,
espBoxStyle = "Corners",
espBoxFill = true,
espFillGrad = true,
espFillGradColor = Color3.fromRGB(255, 85, 130),
espFillGradColor2 = Color3.fromRGB(150, 95, 255),
espBoxOutline = true,
espBoxOutlineColor = Color3.new(0, 0, 0),
espBoxThickness = 2,
espBoxGrad = true,
espBoxGradColor = Color3.fromRGB(255, 85, 130),
espBoxGradColor2 = Color3.fromRGB(150, 95, 255),
espHealth = true,
espHealthText = true,
espHealthSide = "Left",
espHealthWidth = 3,
espHealthGrad = true,
espHealthColorLow = Color3.fromRGB(255, 60, 60),
espHealthColorMax = Color3.fromRGB(90, 255, 110),
espHealthOutline = true,
espArmor = true,
espArmorGrad = true,
espArmorColorLow = Color3.fromRGB(255, 120, 60),
espArmorColorMax = Color3.fromRGB(90, 170, 255),
espWeapon = true,
espSkeleton = false,
espHeadDot = true,
espSnap = false,
espSnapFrom = "Bottom",
espArrows = false,
espArrowRadius = 220,
espArrowSize = 14,
espVisCheck = false,
espVisColor = Color3.fromRGB(90, 255, 120),
espMaxDist = 3000,
espTextSize = 13,
espTextGrad = false,
espTextGradColor = Color3.fromRGB(255, 255, 255),
espTextGradColor2 = Color3.fromRGB(120, 180, 255),
espFlags = false,
espDormant = false,
espDormantTime = 4,
espFade = 0.35,
espChamsMode = "Glow",
espChamsStyle = "Material",
espChamsMaterial = "ForceField",
espChamsColor = Color3.fromRGB(255, 60, 60),
espChamsTransp = 0.2,
espColorMode = "Enemy / Teammate",
espTColor = Color3.fromRGB(255, 170, 60),
espCTColor = Color3.fromRGB(80, 150, 255),
scopeStyle = "Line",
scopeColor = Color3.fromRGB(255, 255, 255),
scopeLen = 60,
scopeGap = 12,
scopeThick = 1,
xhair = false,
xhairColor = Color3.fromRGB(0, 255, 140),
xhairLen = 6,
xhairGap = 4,
xhairThick = 2,
xhairOutline = true,
xhairT = false,
hitMarker = false,
hitMarkerColor = Color3.fromRGB(255, 255, 255),
hitMarkerKill = Color3.fromRGB(255, 70, 90),
hitMarkerTime = 0.45,
hitMarkerWhere = "Crosshair",
hitMarkerAnim = "Fade",
hitMarkerSize = 10,
hitMarkerShape = "X",
hitMarkerThick = 2,
hitMarkerGap = 4,
hitMarkerOutline = true,
hitMarkerKillScale = 1.4,
hitMarkerRise = 0,
hitMarkerDamage = false,
dmgNumbers = false,
dmgColor = Color3.fromRGB(255, 220, 90),
killFx = false,
killFxColor = Color3.fromRGB(255, 70, 120),
dot = false,
dotColor = Color3.fromRGB(255, 255, 255),
dotSize = 4,
tracer = false,
tracerWidth = 0.06,
tracerLife = 1,
impact = false,
hitSound = false,
hitSoundId = "3744371342",
hitVol = 0.6,
hitLogs = true,
killSound = false,
killSoundId = "3744371342",
killVol = 1,
skins = false,
float = 0.001,
statTrak = true,
statTrakCount = 1337,
knife = nil,
knifeSkin = nil,
glove = nil,
gloveSkin = nil,
},
Color3.fromRGB(255, 80, 200)
aC.tracerStyle, aC.tracerFrom, aC.tracerRainbow, aC.tracerOnlyHits = "Line", "Gun", false, false
aC.skins = false
aC.impactSize, aC.impactGlow = 0.35, false
local aE = Color3.fromRGB(255, 255, 255)
local function f() end
local aF, aG, aH = nil, nil, {
active = false,
eye = nil,
sentYaw = nil,
sentPitch = nil,
knife = {
yaw = 0,
pitch = 0,
samples = 0,
expires = 0,
},
}
local function U()
return aH.active and aH.eye or (workspace.CurrentCamera or at).CFrame
end
local function D(aI)
return (aI + math.pi) % (2 * math.pi) - math.pi
end
local function m()
return _:GetAttribute("IsPlayerChatting") or an:GetFocusedTextBox() ~= nil
end
local function j()
local aI = workspace:GetAttribute("ServerGamemode")
if aI == "Casual" or aI == "Deathmatch" then
return ay.CasualDeathmatch or ay.Default
elseif aI == "Surf" then
return ay.Surf or ay.Default
end
return ay.Competitive or ay.Default
end
do
local aI, aJ = pcall(require, L.Components.Common.Participants)
if not aI or type(aJ) ~= "table" or type(aJ.GetAll) ~= "function" then
aJ = nil
end
local aK = getthreadidentity or syn and syn.get_thread_identity
local function z(aL, ...)
local aM, aN, aO = aK and aK(), pcall(aL, ...)
if aM and setthreadidentity then
pcall(setthreadidentity, aM)
end
return aN, aO
end
local aL = {}
local function R(aM)
local aN = aL[aM]
if aN then
return aN
end
aN = setmetatable({
IsBot = true,
UserId = 0,
}, {
__index = function(aO, aP)
if aP == "Character" then
local aQ, aR = z(aJ.Character, aM)
return aQ and aR or nil
elseif aP == "Name" or aP == "DisplayName" then
local aQ, aR = z(aJ.Name, aM)
return (aQ and type(aR) == "string") and aR or aM.Name
elseif aP == "Parent" then
return aM.Parent
end
return nil
end,
})
function aN.GetAttribute(aO, aP)
local aQ = aM:GetAttribute(aP)
if aQ == nil then
local aR, aS = z(aJ.Character, aM)
if aR and aS then
aQ = aS:GetAttribute(aP)
end
end
return aQ
end
aL[aM] = aN
return aN
end
local aM, aN = -1
function aa.entities()
local aO = os.clock()
if aN and aO - aM < 0.2 then
return aN
end
aM = aO
local aP, aQ, aR = nil, false
if aJ then
aQ, aR = z(aJ.GetAll)
end
if aQ and type(aR) == "table" then
aP = {}
for aS, aU in pairs(aR) do
if typeof(aU) == "Instance" then
aP[#aP + 1] = aU:IsA("Player") and aU or R(aU)
end
end
else
aP = {}
for aS, aU in ipairs(u:GetPlayers()) do
if aU.Character then
aP[#aP + 1] = aU
end
end
end
for aS in pairs(aL) do
if aS.Parent == nil then
aL[aS] = nil
end
end
if workspace:FindFirstChild("HordeShells") then
aP = table.clone(aP)
for aS, aU in ipairs(aa.liveShells()) do
aP[#aP + 1] = aa.zombie(aU)
end
end
aN = aP
return aP
end
local aO
pcall(function()
aO = require(L.Controllers.HordeController)
end)
function aa.liveShells()
local aP = {}
if aO and type(aO.GetLiveShells) == "function" then
local aQ, aR = z(aO.GetLiveShells)
if aQ and type(aR) == "table" then
for aS, aU in pairs(aR) do
if typeof(aU) == "Instance" and (aU.Parent and aU:FindFirstChild("Head")) then
aP[#aP + 1] = aU
end
end
return aP
end
end
local aQ = workspace:FindFirstChild("HordeShells")
for aR, aS in ipairs(aQ and aQ:GetChildren() or {}) do
if
aS:IsA("Model")
and (
aS:GetAttribute("HordeId") ~= nil
and (not aS:GetAttribute("Ragdolled") and aS:FindFirstChild("Head"))
)
then
aP[#aP + 1] = aS
end
end
return aP
end
local aP = setmetatable({}, {
__mode = "k",
})
function aa.zombie(aQ)
local aR = aP[aQ]
if aR then
return aR
end
aR = {
IsZombie = true,
IsBot = true,
UserId = 0,
Name = "zombie",
DisplayName = "zombie",
Character = aQ,
Parent = aQ.Parent,
}
function aR.GetAttribute(aS, aU)
return aQ:GetAttribute(aU)
end
aP[aQ] = aR
return aR
end
function aa.ownerOf(aQ)
if not aQ then
return nil
end
for aR, aS in ipairs(aa.entities()) do
if aS.Character == aQ then
return aS
end
end
return nil
end
function aa.byName(aQ)
for aR, aS in ipairs(aa.entities()) do
if aS.Name == aQ then
return aS
end
end
return nil
end
end
local function k(aI)
if type(aI) == "table" and aI.IsZombie then
return false
end
if workspace:FindFirstChild("HordeShells") then
return true
end
if workspace:GetAttribute("Gamemode") == "Deathmatch" then
return false
end
local aJ = _:GetAttribute("Team")
return aJ ~= nil and aI:GetAttribute("Team") == aJ
end
local function h(aI)
if aI == _ then
return false
end
if type(aI) == "table" and aI.IsZombie then
return true
end
if workspace:FindFirstChild("HordeShells") then
return false
end
if not aC.teamCheck then
return true
end
if workspace:GetAttribute("Gamemode") == "Deathmatch" then
return true
end
local aJ = aI:GetAttribute("Team")
return (aJ == "Terrorists" or aJ == "Counter-Terrorists") and aJ ~= _:GetAttribute("Team")
end
local function F(aI, aJ)
local aK = aI.Character
if not aK or aK:GetAttribute("Dead") or aK:GetAttribute("Ragdolled") then
return nil
end
local aL = aK:GetAttribute("Health")
if type(aL) == "number" and aL <= 0 then
return nil
end
if not aK:IsDescendantOf(workspace) then
return nil
end
if not aK:FindFirstChild(aJ or "Head") then
return nil
end
return aK
end
local function t(aI)
if aI == nil then
return false
end
if aI:GetAttribute("Invincible") == true then
return true
end
local aJ = aa.ownerOf(aI)
return aJ ~= nil and aJ:GetAttribute("Invincible") == true
end
local aI, aJ = {}, setmetatable({}, {
__mode = "k",
})
local function dT(aK)
if aK == _ or aJ[aK] ~= nil then
return
end
aJ[aK] = false
task.spawn(function()
local aL, aM = pcall(_.IsFriendsWith, _, aK.UserId)
aJ[aK] = aL and aM == true
end)
end
for aK, aL in ipairs(u:GetPlayers()) do
dT(aL)
end
aa.connect(u.PlayerAdded, dT)
local function ET(aK)
if not h(aK) or aI[aK.Name] then
return false
end
if aC.ignoreFriends and aJ[aK] then
return false
end
return true
end
local aK = setmetatable({}, {
__mode = "k",
})
local function MT(aL)
for aM, aN in ipairs(aa.entities()) do
local aO = aN.Character
if aO and aL:IsDescendantOf(aO) then
return aN
end
end
return nil
end
local function AT(aL)
aL = tostring(aL or "")
if aL:find("^rbxassetid://") then
return aL
end
local aM = aL:match("%d+")
return aM and "rbxassetid://" .. aM or nil
end
local function zT(aL, aM)
local aN = AT(aL)
if not aN then
return
end
local aO = Instance.new("Sound")
aO.SoundId = aN
aO.Volume = aM or 1
aO.Parent = aq
aO:Play()
as:AddItem(aO, 6)
end
local aL = Instance.new("ScreenGui")
aL.Name = "NightCCOverlay"
aL.IgnoreGuiInset = true
aL.ResetOnSpawn = false
aL.DisplayOrder = 999
aL.Parent = gethui and gethui() or _:WaitForChild("PlayerGui")
aa.onUnload(function()
aL:Destroy()
end)
local aM = Instance.new("Frame")
aM.AnchorPoint = Vector2.new(0.5, 0.5)
aM.Position = UDim2.fromScale(0.5, 0.5)
aM.BackgroundTransparency = 1
aM.Visible = false
aM.Parent = aL;
(Instance.new("UICorner", aM)).CornerRadius = UDim.new(1, 0)
local aN = Instance.new("UIStroke", aM)
aN.Transparency = 0.35
aN.Thickness = 1
local aO = Instance.new("Frame")
aO.AnchorPoint = Vector2.new(0.5, 0.5)
aO.Position = UDim2.fromScale(0.5, 0.5)
aO.BorderSizePixel = 0
aO.Visible = false
aO.Parent = aL;
(Instance.new("UICorner", aO)).CornerRadius = UDim.new(1, 0)
local aP = Instance.new("UIStroke", aO)
aP.Color = Color3.new(0, 0, 0)
aP.Thickness = 1
aa.connect(O.RenderStepped, function()
aM.Visible = aC.silentAim and aC.showFov
aM.Size = UDim2.fromOffset(aC.fov * 2, aC.fov * 2)
aN.Color = aC.fovColor
local aQ = p()
aO.Visible = aC.dot and not (aQ and aQ.IsAiming)
aO.Size = UDim2.fromOffset(aC.dotSize, aC.dotSize)
aO.BackgroundColor3 = aC.dotColor
end)
local aQ, aR = "NightCCBhop", false
local function vT(aS)
aC.bhop = aS
if aS then
ao:BindActionAtPriority(aQ, function(aU, aV)
if aV == Enum.UserInputState.Begin then
aR = true
elseif aV == Enum.UserInputState.End or aV == Enum.UserInputState.Cancel then
aR = false
end
return Enum.ContextActionResult.Sink
end, false, Enum.ContextActionPriority.High.Value + 1000, Enum.KeyCode.Space)
else
pcall(function()
ao:UnbindAction(aQ)
end)
aR = false
end
end
aa.onUnload(function()
pcall(function()
ao:UnbindAction(aQ)
end)
end)
do
local aS, aU, aV, aW, aX, aY, aZ, a_, a0, a1 = 64, 2, 1, false, 0, false, false, 0, 0, nil
local aaSmoothAngle, aaDoubleTick, aaDoubleHigh = 0, 0, false
local function v(a2, a3, a4)
local a5, a6 = aC.speed, a1 and D(a3.LookYaw - a1) or 0
a1 = a3.LookYaw
if not (aC.strafe or a5) or a2.OnGround or m() then
return
end
if not a5 and not an:IsKeyDown(Enum.KeyCode.Space) then
return
end
if not a5 and aC.strafeMode == "Legit" then
if math.abs(a6) < 0.002 then
return
end
a3.Move = Vector2.new(a6 > 0 and -1 or 1, 0)
return
end
local a7, a8 =
(an:IsKeyDown(Enum.KeyCode.D) and 1 or 0) - (an:IsKeyDown(Enum.KeyCode.A) and 1 or 0),
(an:IsKeyDown(Enum.KeyCode.S) and 1 or 0) - (an:IsKeyDown(Enum.KeyCode.W) and 1 or 0)
if a7 == 0 and a8 == 0 then
if not a5 then
return
end
a8 = -1
end
if type(a4) ~= "table" then
a4 = nil
end
local a9 = (a4 and typeof(a4.Velocity) == "Vector3") and a4.Velocity or a2.GlobalVelocity
local ba = (Vector2.new(a9.X, a9.Z)).Magnitude
if ba < aU then
return
end
if a5 and ba >= aC.speedLimit then
a3.Move = Vector2.zero
return
end
local bb, bc = D(a3.LookYaw + math.atan2(-a7, -a8)), math.atan2(-a9.X, -a9.Z)
local bd, be = D(bb - bc), nil
local bf = math.abs(bd) > math.rad(aC.alignDeg)
if bf then
be = bd > 0 and 1 or -1
else
aV = -aV
be = aV
end
local bg = j()
local bh = bg.MaxSpeed
if a4 and type(a4.BaseMoveSpeed) == "number" then
bh = math.clamp(a4.BaseMoveSpeed, 0, bg.MaxBaseMoveSpeed or a4.BaseMoveSpeed)
end
local bi = 1
if a4 and type(a4.Stamina) == "number" then
local bj = math.max(bg.StaminaMax or 100, 1)
bi = math.clamp((a4.Stamina + (bg.StaminaRecoveryRate or 0) / aS) / bj, 0, 1)
end
local bj = 1
if a4 and (type(a4.DuckAmount) == "number" and type(bg.CrouchModifier) == "number") then
bj = 1 + (bg.CrouchModifier - 1) * math.clamp(a4.DuckAmount, 0, 1)
end
local bk, bl, bm = ((bh * bj) * bi) * bi, nil, nil
if (bg.BunnyHopAirAccelerate or 0) > 0 and (bg.BunnyHopAirSpeedCap or 0) > 0 then
bm = math.min(bk, bg.BunnyHopAirSpeedCap)
bl = (bg.BunnyHopAirAccelerate * bm) / aS
else
bm = math.min(bk, bg.AirSpeedCap)
bl = (bg.AirAccelerate * bk) / aS
end
local bn = math.min(bl, bm)
local bo = math.acos(math.clamp((bm - bn) / ba, -1, 1))
if bf and aC.fastTurn then
local bp = math.min(bl, 2 * bm)
local bq = math.acos(math.clamp((-bp / 2) / ba, -1, 1))
local br = math.atan2(bp * math.sin(bq), ba + bp * math.cos(bq))
if br <= math.abs(bd) then
bo = bq
end
end
local bp = be > 0 and bc + bo or bc - bo
local bq = Vector3.new(-math.sin(bp), 0, -math.cos(bp))
local br = (CFrame.Angles(0, a3.LookYaw, 0)):VectorToObjectSpace(bq)
a3.Move = Vector2.new(math.clamp(br.X, -1, 1), math.clamp(br.Z, -1, 1))
end
local coverParams = RaycastParams.new()
coverParams.FilterType = Enum.RaycastFilterType.Exclude
coverParams.CollisionGroup = "Bullet"
coverParams.IgnoreWater = true
local coverIgnore, coverIgnoreAt, coverIgnoreChar = nil, 0, nil
local function coverFilter()
local now = os.clock()
local char = _.Character
if coverIgnore and now - coverIgnoreAt < 0.5 and coverIgnoreChar == char then
return coverIgnore
end
local list = {}
if char then
list[#list + 1] = char
end
local chars = workspace:FindFirstChild("Characters")
if chars then
list[#list + 1] = chars
end
coverIgnore, coverIgnoreAt, coverIgnoreChar = list, now, char
return list
end
local coverSideCache, coverSideAt = nil, 0
local coverAngles = { { 90, 0 }, { 65, 0.6 }, { 115, 0.6 }, { 40, 1.6 }, { 140, 1.6 } }
local function coverSide(base)
local char = _.Character
local head = char and char:FindFirstChild("Head")
local pos = head and head.Position or (U()).Position
local range = math.clamp(tonumber(aC.aaAutoManualRange) or 6, 2, 16)
local bestLeft, bestRight = math.huge, math.huge
coverParams.FilterDescendantsInstances = coverFilter()
for i = 1, #coverAngles do
local angle = math.rad(coverAngles[i][1])
local penalty = coverAngles[i][2]
for side = -1, 1, 2 do
local yaw = base + side * angle
local dir = Vector3.new(-math.sin(yaw), 0, -math.cos(yaw))
local hit = workspace:Raycast(pos, dir * range, coverParams)
if hit then
local score = hit.Distance + penalty
if side > 0 then
if score < bestLeft then
bestLeft = score
end
elseif score < bestRight then
bestRight = score
end
end
end
end
local now = os.clock()
local pick, score = nil, math.huge
if bestLeft < math.huge or bestRight < math.huge then
if bestLeft <= bestRight then
pick, score = "Left", bestLeft
else
pick, score = "Right", bestRight
end
end
if not pick then
coverSideCache = nil
return nil
end
if coverSideCache then
local hold = coverSideCache == "Left" and bestLeft or bestRight
if hold < math.huge and (pick == coverSideCache or now - coverSideAt < 0.25 or score > hold - 1) then
return coverSideCache
end
end
coverSideCache, coverSideAt = pick, now
return pick
end
local function K(a2)
if not aC.aa then
return
end
if aC.aaOffShot then
local a3 = p()
if a3 and a3.IsShooting then
return
end
end
local a3 = a2.LookYaw
local a4 = a3
local bA = nil
if aC.aaBase == "At Targets" or aC.aaAutoManual then
local bB, bC = (U()).Position, nil
for bD, bE in ipairs(aa.entities()) do
if h(bE) then
local bF = F(bE, "HumanoidRootPart")
if bF then
local bG = bF.HumanoidRootPart.Position - bB
if not bC or bG.Magnitude < bC then
bC = bG.Magnitude
bA = math.atan2(-bG.X, -bG.Z)
end
end
end
end
end
if aC.aaBase == "At Targets" and bA then
a4 = bA
end
local bH = aC.aaManual
if not bH and aC.aaAutoManual then
bH = coverSide(bA or a4)
if bH then
a4 = bA or a4
end
end
aC.aaAutoSide = (not aC.aaManual and aC.aaAutoManual) and bH or nil
local a5 = a4
if bH == "Left" then
a5 = a4 + math.pi / 2
elseif bH == "Right" then
a5 = a4 - math.pi / 2
elseif bH == "Back" then
a5 = a4 + math.pi
elseif aC.aaYaw == "Backwards" then
a5 = a4 + math.pi
elseif aC.aaYaw == "Sideways" then
a5 = a4 + math.pi / 2
elseif aC.aaYaw == "Left" then
a5 = a4 + math.pi * 0.5
elseif aC.aaYaw == "Right" then
a5 = a4 - math.pi * 0.5
elseif aC.aaYaw == "Spin" then
aX = D(aX + math.rad(aC.aaSpin))
a5 = aX
elseif aC.aaYaw == "Jitter" then
a_ = a_ + 1
if a_ >= math.max(aC.aaJitterDelay, 1) then
a_ = 0
aY = not aY
end
a5 = (a4 + math.pi) + (aY and 1 or -1) * math.rad(aC.aaJitter)
elseif aC.aaYaw == "Random" then
if not aC._aaRandT or tick() > aC._aaRandT then
aC._aaRandT = tick() + (aC.aaJitterDelay or 1) * 0.05
aC._aaRand = math.random() * math.pi * 2
end
a5 = aC._aaRand or a4
elseif aC.aaYaw == "Sway" then
a5 = a4 + math.pi + math.sin(tick() * (aC.aaSpin or 30) * 0.15) * math.rad(aC.aaJitter or 60)
elseif aC.aaYaw == "Threeway" then
local phase = math.floor(tick() * 4) % 3
if phase == 0 then a5 = a4 + math.pi
elseif phase == 1 then a5 = a4 + math.pi * 0.5
else a5 = a4 - math.pi * 0.5 end
elseif aC.aaYaw == "Static" then
a5 = a4 + math.rad(aC.aaStaticAngle or 180)
elseif aC.aaYaw == "Smooth Random" then
if not aC._aaRandT or tick() > aC._aaRandT then
aC._aaRandT = tick() + (aC.aaJitterDelay or 1) * 0.08
aC._aaRand = math.random() * math.pi * 2
end
aaSmoothAngle = D(aaSmoothAngle + D((aC._aaRand or a4) - aaSmoothAngle) * 0.15)
a5 = aaSmoothAngle
elseif aC.aaYaw == "Double Jitter" then
a_ = a_ + 1
if a_ >= math.max(aC.aaJitterDelay, 1) then
a_ = 0
aY = not aY
if aY then aaDoubleHigh = not aaDoubleHigh end
end
local amt = aaDoubleHigh and aC.aaJitter or (aC.aaJitter * 0.45)
a5 = (a4 + math.pi) + (aY and 1 or -1) * math.rad(amt)
elseif aC.aaYaw == "Adaptive Jitter" then
local moveMag = typeof(a2.Move) == "Vector2" and a2.Move.Magnitude or 0
local active = moveMag > 0.1
a_ = a_ + (active and 2 or 1)
if a_ >= math.max(aC.aaJitterDelay, 1) then
a_ = 0
aY = not aY
end
a5 = (a4 + math.pi) + (aY and 1 or -1) * math.rad(aC.aaJitter * (active and 1 or 0.4))
end
a5 = D(a5)
local a6 = a2.Move
if typeof(a6) == "Vector2" and a6.Magnitude > 0 then
local a7 = (CFrame.Angles(0, a3, 0)):VectorToWorldSpace(Vector3.new(a6.X, 0, a6.Y))
local a8 = (CFrame.Angles(0, a5, 0)):VectorToObjectSpace(a7)
a2.Move = Vector2.new(math.clamp(a8.X, -1, 1), math.clamp(a8.Z, -1, 1))
end
a2.LookYaw = a5
if aC.aaPitch == "Down" then
a2.VerticalLook = -1
elseif aC.aaPitch == "Up" then
a2.VerticalLook = 1
elseif aC.aaPitch == "Jitter" then
a0 = a0 + 1
if a0 >= math.max(aC.aaJitterDelay, 1) then
a0 = 0
aZ = not aZ
end
a2.VerticalLook = aZ and 1 or -1
end
end
local a2, a3, a4, a5, a6, a7 = require(L.MovementV2.Buttons), nil, false, false, 0, RaycastParams.new()
a7.FilterType = Enum.RaycastFilterType.Exclude
a3 = function(a8)
local a9, ba = a8.HumanoidRootPart, a8.GlobalVelocity
if not a9 or typeof(ba) ~= "Vector3" then
return false
end
local bb = Vector3.new(ba.X, 0, ba.Z)
if bb.Magnitude < 4 then
return false
end
a7.FilterDescendantsInstances = {
_.Character,
at,
workspace:FindFirstChild("Debris"),
}
local bc = (a9.Position + bb * (2 / aS)) + bb.Unit * 0.6
return workspace:Raycast(bc, Vector3.new(0, -4.5, 0), a7) == nil
end
local a8, a9 = 0, 0
local function o(ba, bb)
if not aC.landBrake or type(bb) ~= "table" then
return
end
local bc = j()
local bd = bc.BunnyHopPenaltyThreshold or 0
if bd <= 0 then
return
end
local be, bf = bb.Velocity, bb.Position
if typeof(be) ~= "Vector3" or typeof(bf) ~= "Vector3" or be.Y > 0 then
return
end
local bg, bh = math.sqrt(be.X * be.X + be.Z * be.Z), bd - 0.15
if bg <= bh then
return
end
local bi = 1 / aS
a7.FilterDescendantsInstances = {
_.Character,
at,
workspace:FindFirstChild("Debris"),
}
local bj = bf + Vector3.new(be.X, 0, be.Z) * (4 * bi)
local bk = workspace:Raycast(bj + Vector3.new(0, 3, 0), Vector3.new(0, -90, 0), a7)
if not bk then
return
end
local bl, bm, bn = (bf.Y - bk.Position.Y) - a8, be.Y, 0
while bn < 48 do
bm = bm - bc.Gravity * bi
bl = bl + bm * bi
if bl <= 0 then
break
end
bn = bn + 1
end
local bo = bc.MaxSpeed
if type(bb.BaseMoveSpeed) == "number" then
bo = math.clamp(bb.BaseMoveSpeed, 0, bc.MaxBaseMoveSpeed or bb.BaseMoveSpeed)
end
local bp = 1
if type(bb.Stamina) == "number" then
bp = math.clamp((bb.Stamina + (bc.StaminaRecoveryRate or 0) * bi) / math.max(bc.StaminaMax or 100, 1), 0, 1)
end
local bq = (((bc.AirAccelerate * bo) * bp) * bp) * bi
if bq <= 0.01 then
return
end
local br = bg - bh
if bn > math.ceil(br / bq) + 1 then
return
end
local bs, bt = math.clamp(((bh * bh - bg * bg) - bq * bq) / ((2 * bg) * bq), -1, 1), math.atan2(-be.X, -be.Z)
local bu = bt + math.acos(bs)
local bv = Vector3.new(-math.sin(bu), 0, -math.cos(bu))
local bw = (CFrame.Angles(0, ba.LookYaw, 0)):VectorToObjectSpace(bv)
ba.Move = Vector2.new(math.clamp(bw.X, -1, 1), math.clamp(bw.Z, -1, 1))
end
local ba
ba = Q(ax.SampleInput, function(bb, ...)
local bc = not aa.unloaded and (not m() and (aC.bhop and aR or aC.speed))
if not aa.unloaded and (aC.longJump and (bb.OnGround and (not m() and a3(bb)))) then
bb.JumpPulsePending = true
a4 = true
end
local bd, be = ..., ba(bb, ...)
if aa.unloaded or be == nil then
return be
end
if bc then
local bf = bb.OnGround == true and not aW
be.Buttons = a2.with(be.Buttons, a2.Jump, bf)
aW = bf
else
aW = false
end
local bf = bb.OnGround == true
if a5 and (not bf and (aC.boostJump or a4)) then
a6 = aC.duckTicks
end
if bf then
a4 = false
end
a5 = bf
if a6 > 0 and not bf then
a6 = a6 - 1
be.Buttons = a2.with(be.Buttons, a2.Duck, true)
elseif bf then
a6 = 0
end
local bg = type(bd) == "table" and bd.State or nil
v(bb, be, bg)
if bc and type(bg) == "table" then
if bf then
if os.clock() - a9 > 1 and typeof(bg.Position) == "Vector3" then
a9 = os.clock()
a7.FilterDescendantsInstances = {
_.Character,
at,
workspace:FindFirstChild("Debris"),
}
local bh = workspace:Raycast(bg.Position + Vector3.new(0, 3, 0), Vector3.new(0, -12, 0), a7)
if bh then
a8 = bg.Position.Y - bh.Position.Y
end
end
else
pcall(o, be, bg)
end
end
if aC.speed and (bb.OnGround and (not m() and (typeof(be.Move) == "Vector2" and be.Move.Magnitude == 0))) then
be.Move = Vector2.new(0, -1)
end
K(be)
local bk = aH.knife
if bk and bk.samples > 0 then
if os.clock() <= bk.expires then
be.LookYaw = bk.yaw
be.VerticalLook = bk.pitch
bk.samples = bk.samples - 1
if bk.samples <= 0 then
bk.expires = 0
end
else
bk.samples, bk.expires = 0, 0
end
end
aH.sentYaw, aH.sentPitch = be.LookYaw, be.VerticalLook
return be
end)
end
function aa.hookSpeedPenalty()
if aa.unloaded or aa.speedPenaltyHooked then
return
end
aa.speedPenaltyHooked = true
local aS
for aU, aV in ipairs(getgc(true)) do
if type(aV) == "table" then
local aW, aX = pcall(rawget, aV, "_accumulatorSeconds")
if aW and (type(aX) == "number" and type(rawget(aV, "_options")) == "table") then
aS = aV
break
end
end
end
local aU = aS and aS._options
if aU then
aU.__zbScoped = rawget(aU, "__zbScoped") or aU.ResolveScopedState
aU.__zbBaseSpeed = rawget(aU, "__zbBaseSpeed") or aU.ResolveBaseMoveSpeed
local aV, aW, aX = aU.__zbScoped, aU.__zbBaseSpeed, ay.Default and ay.Default.MaxBaseMoveSpeed or 19.5
if aV then
aU.ResolveScopedState = function(...)
if not aa.unloaded and aC.noSpeedPenalty then
return false
end
return aV(...)
end
end
if aW then
aU.ResolveBaseMoveSpeed = function(...)
local aY, aZ = aW(...)
if not aa.unloaded and (aC.noSpeedPenalty and (type(aY) == "number" and aY > 0)) then
aY = math.max(aY, aX)
end
return aY, aZ
end
end
aa.onUnload(function()
if aV then
aU.ResolveScopedState = aV
end
if aW then
aU.ResolveBaseMoveSpeed = aW
end
end)
else
aa.speedPenaltyHooked = false
end
end
do
local aS
aS = Q(av.setWeaponRecoil, function(aU, aV)
if aa.unloaded or not aC.noRecoil then
return aS(aU, aV)
end
return aS({
Value = Vector3.zero,
Damper = aU.Damper,
Speed = aU.Speed,
}, aV)
end)
local aU
aU = Q(av.weaponKick, function(aV, aW)
if aa.unloaded or not aC.noRecoil then
return aU(aV, aW)
end
return aU({
Value = aV.Value * 0,
Damper = aV.Damper,
Speed = aV.Speed,
}, {
Value = aW.Value * 0,
Damper = aW.Damper,
Speed = aW.Speed,
})
end)
end
do
local aS = 2147483000
local aU, aV =
{
WindUI = aS,
["WindUI/Dropdowns"] = aS + 10,
["WindUI/Tooltips"] = aS + 20,
["WindUI/Notifications"] = aS + 30,
}, {}
local function M()
local aW = {
game:GetService("CoreGui"),
}
if gethui then
aW[2] = gethui()
end
for aX, aY in ipairs(aW) do
for aZ, a_ in ipairs(aY:GetChildren()) do
local a0 = aU[a_.Name]
if a0 and (a_:IsA("ScreenGui") and a_.DisplayOrder ~= a0) then
if aV[a_] == nil then
aV[a_] = a_.DisplayOrder
end
a_.DisplayOrder = a0
end
end
end
end
task.spawn(function()
while not aa.unloaded do
if setthreadidentity then
pcall(setthreadidentity, 8)
end
pcall(M)
task.wait(1)
end
end)
aa.onUnload(function()
for aW, aX in pairs(aV) do
pcall(function()
aW.DisplayOrder = aX
end)
end
end)
end
local aS = Instance.new("Folder")
aS.Name = "NightCCFX"
aS.Parent = at
aa.onUnload(function()
aS:Destroy()
end)
local aU = RaycastParams.new()
aU.FilterType = Enum.RaycastFilterType.Exclude
local function cT(aV, aW)
if not aC.wallCheck then
return true
end
local aX = (U()).Position
aU.FilterDescendantsInstances = {
_.Character,
at,
}
local aY = workspace:Raycast(aX, aV.Position - aX, aU)
return aY == nil or aY.Instance:IsDescendantOf(aW)
end
local aV, aW =
{
"Head",
"UpperTorso",
"LowerTorso",
"LeftUpperArm",
"LeftLowerArm",
"LeftHand",
"RightUpperArm",
"RightLowerArm",
"RightHand",
"LeftUpperLeg",
"LeftLowerLeg",
"LeftFoot",
"RightUpperLeg",
"RightLowerLeg",
"RightFoot",
}, {
Head = "Head",
UpperTorso = "Torso",
LowerTorso = "Torso",
HumanoidRootPart = "Torso",
Torso = "Torso",
LeftUpperArm = "Arms",
LeftLowerArm = "Arms",
LeftHand = "Arms",
RightUpperArm = "Arms",
RightLowerArm = "Arms",
RightHand = "Arms",
LeftUpperLeg = "Legs",
LeftLowerLeg = "Legs",
LeftFoot = "Legs",
RightUpperLeg = "Legs",
RightLowerLeg = "Legs",
RightFoot = "Legs",
}
local function bT(aX, aY)
local aZ, a_ = at:WorldToViewportPoint(aX)
if not a_ then
return nil
end
return (Vector2.new(aZ.X, aZ.Y) - aY).Magnitude
end
local function aT()
local aX, aY = at.ViewportSize / 2, aC.aimPart
local aZ, a_, a0, a1 = aY == "Closest to Crosshair" or aY == "Random", aC.fov
for a2, a3 in ipairs(aa.entities()) do
if h(a3) then
local a4 = F(a3, "HumanoidRootPart")
if a4 then
for a5, a6 in ipairs(aZ and aV or { aY }) do
local a7 = a4:FindFirstChild(a6)
if a7 then
local a8 = bT(a7.Position, aX)
if a8 and (a8 < a_ and cT(a7, a4)) then
a0, a_, a1 = a7, a8, a4
end
end
end
end
end
end
if aY == "Random" and a1 then
local a2 = {}
for a3, a4 in ipairs(aV) do
local a5 = a1:FindFirstChild(a4)
if a5 and cT(a5, a1) then
a2[#a2 + 1] = a5
end
end
if #a2 > 0 then
return a2[math.random(#a2)]
end
end
return a0
end
local function TT(aX, aY, aZ)
local a_ = Instance.new("Part")
a_.Anchored, a_.CanCollide, a_.CanQuery, a_.CanTouch, a_.CastShadow = true, false, false, false, false
a_.Material = Enum.Material.Neon
a_.Color = aZ
a_.Size = aX
a_.CFrame = aY
a_.Parent = aS;
(ap:Create(a_, TweenInfo.new(aC.tracerLife, Enum.EasingStyle.Quad), { Transparency = 1 })):Play()
as:AddItem(a_, aC.tracerLife + 0.1)
return a_
end
local aX, aY = {}, 0
function drawTracer(aZ, a_, a0)
local a1 = aZ
if aC.tracerFrom == "Gun" and (not aC.originScan or (aZ - U().Position).Magnitude < 1.5) then
local a2 = p()
local a3 = a2 and (a2.Viewmodel and a2.Viewmodel.Model)
local a4 = a3 and a3:FindFirstChild("Muzzle", true)
if a4 and a4:IsA("BasePart") then
a1 = a4.Position
elseif a4 and a4:IsA("Attachment") then
a1 = a4.WorldPosition
else
a1 = (U() * CFrame.new(0.35, -0.35, -1.2)).Position
end
end
local a2 = aD
if aC.tracerRainbow then
aY = (aY + 0.07) % 1
a2 = Color3.fromHSV(aY, 0.85, 1)
end
local a3, a4, a5 = aC.tracerLife, aC.tracerWidth, (a_ - a1).Magnitude
if aC.tracer and a5 > 0.5 then
if aC.tracerStyle == "Beam" then
local a6 = Instance.new("Part")
a6.Anchored, a6.CanCollide, a6.CanQuery, a6.CanTouch = true, false, false, false
a6.Transparency, a6.Size, a6.CFrame = 1, Vector3.new(0.1, 0.1, 0.1), CFrame.new(a1)
a6.Parent = aS
local a7, a8 = Instance.new("Attachment", a6), Instance.new("Attachment", a6)
a8.WorldPosition = a_
local a9 = Instance.new("Beam")
a9.Attachment0, a9.Attachment1 = a7, a8
a9.Width0, a9.Width1 = a4 * 2.5, a4 * 0.6
a9.FaceCamera = true
a9.LightEmission, a9.LightInfluence = 1, 0
a9.Color = ColorSequence.new(a2)
a9.Parent = a6
task.spawn(function()
local ba = os.clock()
while a6.Parent and os.clock() - ba < a3 do
local bb = (os.clock() - ba) / a3
a9.Transparency = NumberSequence.new(bb * 0.9, math.min(1, 0.3 + bb))
task.wait(0.03)
end
a6:Destroy()
end)
elseif aC.tracerStyle == "Lightning" then
local a6, a7 = math.clamp(math.floor(a5 / 4), 4, 14), (a_ - a1).Unit
local a8 = a7:Cross(Vector3.new(0, 1, 0))
if a8.Magnitude < 0.001 then
a8 = Vector3.new(1, 0, 0)
end
a8 = a8.Unit
local a9, ba = (a8:Cross(a7)).Unit, a1
for bb = 1, a6, 1 do
local bc = a1 + (a_ - a1) * (bb / a6)
if bb < a6 then
bc = (bc + (a8 * (math.random() - 0.5)) * 0.9) + (a9 * (math.random() - 0.5)) * 0.9
end
local bd = (bc - ba).Magnitude
if bd > 0.05 then
TT(Vector3.new(a4, a4, bd), CFrame.lookAt((ba + bc) / 2, bc), a2)
end
ba = bc
end
else
TT(Vector3.new(a4, a4, a5), CFrame.lookAt((a1 + a_) / 2, a_), a2)
end
end
if aC.impact and a0 then
local a6 = aC.impactSize
local a7 = TT(Vector3.new(a6, a6, a6), CFrame.new(a_), aE)
if aC.impactGlow then
local a8 = Instance.new("PointLight")
a8.Color, a8.Range, a8.Brightness = aE, 6, 2
a8.Parent = a7
end
end
end
local aZ = {
factor = {},
samples = {},
meta = {},
}
do
local a_ = "nightcc/damage_calibration.json"
pcall(function()
if isfile and isfile(a_) then
local a0 = ar:JSONDecode(readfile(a_))
if type(a0) == "table" then
aZ.factor, aZ.samples = a0.factor or {}, a0.samples or {}
end
end
end)
local function E()
pcall(function()
if isfolder and (makefolder and not isfolder("nightcc")) then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
writefile(
a_,
ar:JSONEncode({
factor = aZ.factor,
samples = aZ.samples,
})
)
end)
end
local a0, a1 = false, false
local function z()
a0 = true
if a1 then
return
end
a1 = true
task.delay(10, function()
a1 = false
if a0 and not aa.unloaded then
a0 = false
E()
end
end)
end
aa.onUnload(function()
if a0 then
a0 = false
E()
end
end)
function aZ.key(a2, a3, a4)
return tostring(a2) .. ("|" .. (tostring(a3) .. ("|" .. ((a4 or 0) > 0 and "wall" or "open"))))
end
function aZ.get(a2)
return math.clamp(aZ.factor[a2] or 1, 0.6, 1.4)
end
function aZ.expect(a2, a3, a4)
aZ.meta[a2] = {
key = a3,
raw = a4,
at = os.clock(),
}
end
function aZ.observe(a2, a3, a4)
local a5 = aZ.meta[a2]
aZ.meta[a2] = nil
if not a5 or os.clock() - a5.at > 1.5 or not a5.raw or a5.raw <= 0 then
return
end
if a4 and a5.raw >= a4 then
return
end
local a6, a7 = math.clamp(a3 / a5.raw, 0.05, 2), (aZ.samples[a5.key] or 0) + 1
local a8, a9 = aZ.factor[a5.key] or a6, a7 <= 3 and 1 / a7 or 0.3
aZ.factor[a5.key] = a8 + (a6 - a8) * a9
aZ.samples[a5.key] = a7
z()
end
function aZ.reset()
aZ.factor, aZ.samples, aZ.meta = {}, {}, {}
z()
end
end
local a_ = {}
do
local a0, a1, a2, a3, a4, a5, a6, a7 =
0.8, 4, 1, 8, {
hit = Color3.fromRGB(88, 170, 255),
kill = Color3.fromRGB(255, 86, 110),
miss = Color3.fromRGB(150, 150, 160),
}, {
Head = "head",
UpperTorso = "body",
LowerTorso = "body",
HumanoidRootPart = "body",
LeftUpperArm = "arm",
LeftLowerArm = "arm",
LeftHand = "arm",
RightUpperArm = "arm",
RightLowerArm = "arm",
RightHand = "arm",
LeftUpperLeg = "leg",
LeftLowerLeg = "leg",
LeftFoot = "leg",
RightUpperLeg = "leg",
RightLowerLeg = "leg",
RightFoot = "leg",
}, {}, Instance.new("Frame")
a7.Name = "NightCCHitLog"
a7.AnchorPoint = Vector2.new(0, 0)
a7.Position = UDim2.new(0, 12, 0, 96)
a7.Size = UDim2.fromOffset(0, 0)
a7.AutomaticSize = Enum.AutomaticSize.XY
a7.BackgroundTransparency = 1
a7.Parent = aL
local a8 = Instance.new("UIListLayout", a7)
a8.Padding = UDim.new(0, 4)
a8.HorizontalAlignment = Enum.HorizontalAlignment.Left
a8.SortOrder = Enum.SortOrder.LayoutOrder
local a9, ba = 0, {}
local bb = {
kill = { tag = "KILL", badgeBg = Color3.fromRGB(255, 255, 255), badgeTx = Color3.fromRGB(0, 0, 0), badgeBgT = 0, line = 0.0 },
head = { tag = "HEAD", badgeBg = Color3.fromRGB(235, 235, 235), badgeTx = Color3.fromRGB(0, 0, 0), badgeBgT = 0, line = 0.1 },
hit  = { tag = "HIT",  badgeBg = Color3.fromRGB(48, 48, 48),  badgeTx = Color3.fromRGB(255, 255, 255), badgeBgT = 0, line = 0.45 },
miss = { tag = "MISS", badgeBg = Color3.fromRGB(0, 0, 0),     badgeTx = Color3.fromRGB(150, 150, 150), badgeBgT = 1, line = 0.75 },
}
local function esc(s)
return (tostring(s):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end
local function ink(hex, s)
return "<font color=\"" .. hex .. "\">" .. s .. "</font>"
end
local function format(kind, d)
if type(d) ~= "table" then
return ink("#d8d8d8", esc(d))
end
local out = {}
out[#out + 1] = ink("#8a8a8a", kind == "kill" and "killed" or (kind == "miss" and "missed" or "hit"))
out[#out + 1] = ink("#ffffff", "<b>" .. esc(d.name or "?") .. "</b>")
if kind ~= "miss" and d.part then
out[#out + 1] = ink("#cfcfcf", esc(d.part))
end
if kind ~= "miss" and d.dmg then
out[#out + 1] = ink("#8a8a8a", "for") .. " " .. ink("#ffffff", "<b>" .. tostring(d.dmg) .. "</b>") .. ink("#8a8a8a", " dmg")
end
if d.dist then
local walls = (d.walls and d.walls > 0) and (" thru " .. d.walls .. "w") or ""
out[#out + 1] = ink("#8a8a8a", "(" .. d.dist .. "m" .. walls .. ")")
end
if d.reason then out[#out + 1] = ink("#8a8a8a", "— " .. esc(d.reason)) end
if d.note then out[#out + 1] = ink("#6e6e6e", esc(d.note)) end
return table.concat(out, " ")
end
local function N(bc, bd)
if not aC.hitLogs then return end
if setthreadidentity then pcall(setthreadidentity, 8) end
a9 = a9 + 1
local st = bb[bc] or bb.hit
local prefix = aC.rage and (ink("#6e6e6e", "<b>[RAGE]</b>") .. " ") or ""
local card = Instance.new("CanvasGroup")
card.LayoutOrder = a9
card.AutomaticSize = Enum.AutomaticSize.X
card.Size = UDim2.fromOffset(0, 24)
card.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
card.BackgroundTransparency = 0.1
card.BorderSizePixel = 0
card.GroupTransparency = 1
card.Parent = a7
Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Thickness = 1
stroke.Transparency = 0.35
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = card
local sg = Instance.new("UIGradient", stroke)
sg.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(70, 70, 70)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)),
})
local content = Instance.new("Frame")
content.Name = "Content"
content.BackgroundTransparency = 1
content.AutomaticSize = Enum.AutomaticSize.X
content.Size = UDim2.new(0, 0, 1, 0)
content.Position = UDim2.fromOffset(-12, 0)
content.Parent = card
local lay = Instance.new("UIListLayout", content)
lay.FillDirection = Enum.FillDirection.Horizontal
lay.VerticalAlignment = Enum.VerticalAlignment.Center
lay.Padding = UDim.new(0, 7)
lay.SortOrder = Enum.SortOrder.LayoutOrder
local pad = Instance.new("UIPadding", content)
pad.PaddingLeft = UDim.new(0, 6)
pad.PaddingRight = UDim.new(0, 10)
local badge = Instance.new("TextLabel")
badge.LayoutOrder = 1
badge.AutomaticSize = Enum.AutomaticSize.X
badge.Size = UDim2.fromOffset(0, 14)
badge.BackgroundColor3 = st.badgeBg
badge.BackgroundTransparency = st.badgeBgT
badge.BorderSizePixel = 0
badge.Font = Enum.Font.GothamBold
badge.TextSize = 9
badge.TextColor3 = st.badgeTx
badge.Text = st.tag
badge.Parent = content
Instance.new("UICorner", badge).CornerRadius = UDim.new(0, 3)
local bp = Instance.new("UIPadding", badge)
bp.PaddingLeft, bp.PaddingRight = UDim.new(0, 5), UDim.new(0, 5)
if st.badgeBgT >= 1 then
local bs = Instance.new("UIStroke", badge)
bs.Color = Color3.fromRGB(120, 120, 120)
bs.Thickness = 1
end
local lbl = Instance.new("TextLabel")
lbl.LayoutOrder = 2
lbl.BackgroundTransparency = 1
lbl.AutomaticSize = Enum.AutomaticSize.X
lbl.Size = UDim2.fromOffset(0, 24)
lbl.Font = Enum.Font.GothamMedium
lbl.TextSize = 11
lbl.RichText = true
lbl.TextWrapped = false
lbl.TextColor3 = Color3.fromRGB(216, 216, 216)
lbl.Text = prefix .. format(bc, bd)
lbl.Parent = content
local line = Instance.new("Frame")
line.AnchorPoint = Vector2.new(0.5, 0)
line.Position = UDim2.new(0.5, 0, 0, 0)
line.Size = UDim2.new(1, 0, 0, 1)
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BackgroundTransparency = st.line
line.BorderSizePixel = 0
line.Parent = card
local lg = Instance.new("UIGradient", line)
lg.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(0.5, 0),
NumberSequenceKeypoint.new(1, 1),
})
local life = Instance.new("Frame")
life.AnchorPoint = Vector2.new(0, 1)
life.Position = UDim2.new(0, 0, 1, 0)
life.Size = UDim2.new(1, 0, 0, 1)
life.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
life.BackgroundTransparency = 0.6
life.BorderSizePixel = 0
life.Parent = card
ap:Create(card, TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { GroupTransparency = 0 }):Play()
ap:Create(content, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(0, 0) }):Play()
ap:Create(life, TweenInfo.new(a1, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 1) }):Play()
table.insert(ba, card)
while #ba > a3 do
local old = table.remove(ba, 1)
if old then old:Destroy() end
end
task.delay(a1, function()
if not card.Parent then return end
ap:Create(card, TweenInfo.new(a2, Enum.EasingStyle.Quad), { GroupTransparency = 1 }):Play()
ap:Create(content, TweenInfo.new(a2, Enum.EasingStyle.Quad), { Position = UDim2.fromOffset(12, 0) }):Play()
task.delay(a2, function()
local i = table.find(ba, card)
if i then table.remove(ba, i) end
card:Destroy()
end)
end)
end
local bc = {}
pcall(function()
local bd = require(L.Controllers.HordeController)
aa.connect(bd.HitConfirmed, function(be, bf)
local bg = table.remove(bc, 1)
if not bg then
return
end
local bh = be and "head" or a5[bg.part] or "body"
if bh == "head" and not be then
bh = "body"
end
if a_.onConfirm then
pcall(a_.onConfirm, bf and "kill" or "hit", bg.plr, 0, bg.plr.Character, bg.pos)
end
if bf then
N("kill", ("zombie  ·  %s"):format(bh))
else
N(bh == "head" and "head" or "hit", ("zombie  ·  %s"):format(bh))
end
end)
end)
function a_.shot(bd, be, bf, bh, bi)
if not bd then
return
end
if type(bd) == "table" and bd.IsZombie then
bc[#bc + 1] = {
at = os.clock(),
part = be or "?",
pos = bf,
plr = bd,
}
return
end
if a6[bd] then
return
end
local bg = bd.Character
local bj = aZ.meta[bd]
if bj and os.clock() - bj.at > 1.5 then
bj = nil
end
local bk = 0
pcall(function()
bk = math.floor((_:GetNetworkPing() or 0) * 1000 + 0.5)
end)
a6[bd] = {
at = os.clock(),
part = be or "?",
hp = bg and tonumber(bg:GetAttribute("Health")) or 100,
pos = bf,
walls = tonumber(bh) or 0,
dist = tonumber(bi) or 0,
pred = bj and (bj.raw * aZ.get(bj.key)) or 0,
ping = bk,
}
end
aa.connect(O.Heartbeat, function()
local bd = os.clock()
while bc[1] and bd - bc[1].at > a0 do
local be = table.remove(bc, 1)
N("miss", ("zombie  ·  %s  ·  server"):format(a5[be.part] or "body"))
end
if next(a6) == nil then
return
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
for be, bf in pairs(a6) do
local bg = be.Parent and be.Character
local bh, bi = bg and tonumber(bg:GetAttribute("Health")), a5[bf.part] or "body"
if not bg then
a6[be] = nil
elseif bg:GetAttribute("Dead") == true or bh and bh <= 0 then
aK[be] = nil
if a_.onConfirm then
pcall(a_.onConfirm, "kill", be, bf.hp, bg, bf.pos)
end
N("kill", {
name = be.DisplayName,
part = bi:sub(1, 1):upper() .. bi:sub(2),
dmg = math.floor(bf.hp + 0.5),
dist = math.floor((bf.dist or 0) * 0.28 + 0.5),
walls = bf.walls or 0,
})
a6[be] = nil
elseif bh and bh < bf.hp then
aZ.observe(be, bf.hp - bh, bf.hp)
aK[be] = nil
if a_.onConfirm then
pcall(a_.onConfirm, "hit", be, bf.hp - bh, bg, bf.pos)
end
local bj = bf.hp - bh
local bk = bf.pred or 0
local bl = (bk > 0 and bj < bk * 0.6) and ("server cut: %d of ~%d"):format(
math.floor(bj + 0.5),
math.floor(bk + 0.5)
) or ""
N(
bi == "head" and "head" or "hit",
{
name = be.DisplayName,
part = bi:sub(1, 1):upper() .. bi:sub(2),
dmg = math.floor(bj + 0.5),
dist = math.floor((bf.dist or 0) * 0.28 + 0.5),
walls = bf.walls or 0,
note = bl ~= "" and bl or nil,
}
)
a6[be] = nil
elseif bd - bf.at > a0 + (bf.ping or 0) / 1000 then
aK[be] = (aK[be] or 0) + 1
local bj = bf.walls or 0
local bk = math.floor((bf.dist or 0) * 0.28 + 0.5)
local bl = bf.ping or 0
local bm
if aC.serverHits then
bm = ("server hit-mode: %s (ping %dms)"):format(
bj > 0 and ("wall path %d did not land"):format(bj) or "its ray missed",
bl
)
elseif bj > 0 then
bm = ("wallbang rejected: %d wall%s, ping %dms"):format(
bj,
bj > 1 and "s" or "",
bl
)
elseif bl > 90 then
bm = ("no damage from server, high ping %dms"):format(bl)
else
bm = ("no damage from server (ping %dms)"):format(bl)
end
N("miss", { name = be.DisplayName, dist = bk, walls = bj, reason = bm })
a6[be] = nil
end
end
end)
end
local a0, a1 = require(L.Components.Common.GetRayIgnore), { at = 0 }
local function GT()
local a2, a3 = os.clock(), _.Character
if a1.list and (a1.char == a3 and a2 - a1.at < 0.1) then
return a1.list
end
a1.at, a1.char = a2, a3
local a4, a5 = pcall(a0)
local a6 = {}
a1.list = a6
if a4 and type(a5) == "table" then
for a7, a8 in ipairs(a5) do
a6[#a6 + 1] = a8
end
end
a6[#a6 + 1] = _.Character
a6[#a6 + 1] = at
return a6
end
local function JT(a2, a3, a4, a5)
local a6 = a4[#a4]
local a7, a8 = a6 and a6.Position or a2 + a3 * a5, false
for a9, ba in ipairs(a4) do
local bb = ba.Instance and MT(ba.Instance)
if bb and (bb ~= _ and not k(bb)) then
a8 = true
break
end
end
if (aC.tracer or aC.impact) and (a8 or not aC.tracerOnlyHits) then
pcall(drawTracer, a2, a7, a6 ~= nil)
end
for a9, ba in ipairs(a4) do
local bb = ba.Instance and MT(ba.Instance)
if bb and (bb ~= _ and not k(bb)) then
local bc = 0
for bd = 1, a9 do
if a4[bd].Exit then
bc = bc + 1
end
end
aX[bb] = os.clock()
a_.shot(bb, ba.Instance.Name, ba.Position, bc, (ba.Position - a2).Magnitude)
if aC.hitSound then
zT(aC.hitSoundId, aC.hitVol)
end
break
end
end
end
aa.connect(O.Heartbeat, function()
for a2, a3 in pairs(aX) do
local a4 = a2.Parent and a2.Character
if os.clock() - a3 > 1.5 then
aX[a2] = nil
elseif not a4 or a4:GetAttribute("Dead") then
aX[a2] = nil
if aC.killSound then
zT(aC.killSoundId, aC.killVol)
end
end
end
end)
local a2 = require(L.Database.Security.Remotes)
local function ST(a3, a4)
return {
Instance = a3.Instance,
Position = a3.Position,
Normal = a3.Normal,
Material = a3.Material.Name,
Exit = a4 == true,
}
end
local function YT(a3, a4)
return {
Instance = a3,
Position = a3.Position,
Normal = -a4,
Material = a3.Material.Name,
Exit = false,
}
end
local a3, a4 =
{
[Enum.Material.Plastic] = 10,
[Enum.Material.SmoothPlastic] = 10,
[Enum.Material.Wood] = 10,
[Enum.Material.WoodPlanks] = 10,
[Enum.Material.Cardboard] = 10,
[Enum.Material.Glass] = 25,
[Enum.Material.Fabric] = 25,
}, {
["Sandy Brick"] = 0,
IndoorWall = 0,
}
local function BT(a5)
if a5 ~= 0 then
return a5
end
if workspace:GetAttribute("Map") == "Reactor" then
return -1
end
return a5
end
local function sT(a5)
local a6 = a5.Parent
if a6 and a6:HasTag("BreakableDoor") then
return Enum.Material.Metal
end
return a5.Material
end
local function gT(a5)
return a5:FindFirstAncestorWhichIsA("Accessory") ~= nil
or a5:HasTag("CharacterAccessory")
or a5.Name == "CollisionCapsule"
or a5.Name == "HumanoidRootPart"
end
local a5 = RaycastParams.new()
a5.FilterType = Enum.RaycastFilterType.Exclude
a5.CollisionGroup = "Bullet"
local a6 = RaycastParams.new()
a6.FilterType = Enum.RaycastFilterType.Include
a6.CollisionGroup = "Bullet"
local a7 = {
server = false,
notified = false,
}
pcall(function()
a7.router = require(L.Database.Security.Router)
end)
function a7.viewTick()
if not a7.router then
return nil
end
local a8, a9 = pcall(a7.router.broadcastRouter, "GetRemoteViewTick")
return a8 and (type(a9) == "number" and a9) or nil
end
function a7.setServerHits(a8)
a7.server = a8
aC.serverHits = a8
end
pcall(function()
local a8 = require(L.Shared.Raycast)
if type(a8) == "table" and type(rawget(a8, "castThroughDistance")) == "function" then
a7.setServerHits(true)
end
end)
task.spawn(function()
for a8 = 1, 40, 1 do
if aa.unloaded or a7.server then
return
end
if a7.viewTick() then
a7.setServerHits(true)
return
end
task.wait(3)
end
end)
local function uT(a8)
if a7.server then
return a8 and a8.Penetration or 0
end
if aC.wallLimit then
return math.huge
end
if aC.penMod then
return aC.penValue
end
return a8 and a8.Penetration or 0
end
local function UT(a8, a9, ba, bb, bc, bd)
a5.FilterDescendantsInstances = GT()
if bd then
local be = workspace:FindFirstChild("Characters")
if be then
a5:AddToFilter(be)
end
end
local be, bf, bg, bh, bi = {}, {}, {}, a8, 0
for bj = 1, 64, 1 do
local bk = ba - (bh - a8).Magnitude
if bk <= 0 then
break
end
local bl = workspace:Raycast(bh, a9 * bk, a5)
if not bl then
break
end
a5:AddToFilter(bl.Instance)
if not gT(bl.Instance) then
be[#be + 1] = ST(bl)
if bc and bl.Instance:IsDescendantOf(bc) then
return be, true, bi
end
if bb == math.huge then
bi = bi + 1
bh = bl.Position + a9 * 0.01
else
a6.FilterDescendantsInstances = {
bl.Instance,
}
local bm = bl.Position + a9 * 1000
local bn = workspace:Raycast(bm, bl.Position - bm, a6)
if not bn then
return be, false, bi, true
end
local bo, bp, bq = (bl.Position - bn.Position).Magnitude, bl.Instance.MaterialVariant, nil
if bp ~= "" and a4[bp] ~= nil then
bg[bp] = (bg[bp] or 0) + bo
bq = BT(a4[bp]) + bb
if bg[bp] > bq then
return be, false, bi, true
end
else
local br = sT(bl.Instance)
bf[br] = (bf[br] or 0) + bo
bq = BT(a3[br] or 0) + bb
if bf[br] > bq then
return be, false, bi, true
end
end
be[#be + 1] = ST(bn, true)
bi = bi + 1
bh = bn.Position + a9 * 0.001
end
end
end
return be, false, bi
end
local function DT(a8, a9, ba, bb, bc, bd)
local be = bc and bc.Parent
local bf, bg = UT(a8, a9, ba, bb, be)
if bd and (not a7.server and (bc and not bg)) then
bf[#bf + 1] = YT(bc, a9)
end
return bf
end
local function mT(a8, a9, ba, bb)
local bc = a9 - a8
local bd = bc.Magnitude
if bd < 0.05 or bd > ba then
return false, 0
end
local be, bf, bg, bh = UT(a8, bc.Unit, bd, bb, nil, true)
if bh then
return false, bg
end
return true, bg, be
end
local function jT(a8, a9, ba, bb, bc, bd)
local be, bf, bg = mT(a8, a9, bb, bc)
if not be then
if not bd or a7.server then
return nil
end
bg = {}
end
local bh = (a9 - a8).Unit
bg[#bg + 1] = {
Instance = ba,
Position = a9,
Normal = -bh,
Material = ba.Material.Name,
Exit = false,
}
return bg
end
local function kT(a8, a9)
local ba = a8
for bb, bc in ipairs(a9) do
bc.Distance = (bc.Position - ba).Magnitude
ba = bc.Position
end
return a9
end
local a8 = 0
local function FT(a9)
local ba = a9 and a9.Properties
if not (aC.revolverAlt and (ba and ba.ShootingOptions == "Revolver")) then
return nil
end
local bb = ba.FireModes
return type(bb) == "table" and (type(bb.Secondary) == "table" and bb.Secondary) or nil
end
local function tT(a9)
local ba = FT(a9)
if ba and type(ba.FireRate) == "number" then
return ba.FireRate
end
return a9.Properties and a9.Properties.FireRate or 0.1
end
local function OT(a9)
local ba = os.clock()
if ba - a8 < 0.016666666666667 then
return
end
a8 = ba
local bb, bc = a9.Viewmodel and a9.Viewmodel.Animation, FT(a9)
task.spawn(function()
if setthreadidentity then
pcall(setthreadidentity, 2)
end
if bb then
local bd = false
if bc and type(bc.Animation) == "string" then
bd = pcall(function()
bb:play(bc.Animation)
end)
end
if not bd then
pcall(function()
bb:play(bb:pickVariant("Shoot") or "Shoot")
end)
end
end
if bc and type(bc.CharacterAnimation) == "string" then
pcall(function()
(require(L.Components.Common.ReplicateCharacterAction))(bc.CharacterAnimation)
end)
end
end)
end
local function LT(raw)
local a9 = U()
if not aC.originOn then
return a9.Position
end
local ba, bb = a9:ToEulerAnglesYXZ()
return a9.Position + (CFrame.Angles(0, bb, 0)):VectorToWorldSpace(Vector3.new(aC.originX, aC.originY, aC.originZ))
end
local a9 = {
params = RaycastParams.new(),
last = setmetatable({}, {
__mode = "k",
}),
}
a9.params.FilterType = Enum.RaycastFilterType.Exclude
a9.params.CollisionGroup = "Bullet"
local function EU(ba)
if not aC.bulletTp or not ba or not ba.Parent then
return nil
end
local bb = ba.Position
local bc = (U()).Position - bb
local bd = Vector3.new(bc.X, 0, bc.Z)
bd = bd.Magnitude > 0.01 and bd.Unit or Vector3.new(0, 0, 1)
local be, bf, bg = bd:Cross(Vector3.new(0, 1, 0)), Vector3.new(0, 1, 0), aC.bulletTpDist
local bh = {
bd,
(bd + bf).Unit,
bf,
be,
-be,
(bd + be).Unit,
(bd - be).Unit,
-bd,
}
if a9.stamp ~= a1.at or not a1.list then
a9.params.FilterDescendantsInstances = GT()
a9.stamp = a1.at
end
local bi, bj = ba.Parent, a9.last[ba] or 1
for bk = 0, #bh - 1, 1 do
local bl = ((bj - 1) + bk) % #bh + 1
local bm = bh[bl]
local bn = bb + bm * bg
local bo = workspace:Raycast(bn, bm * -(bg + 2), a9.params)
if bo and bo.Instance:IsDescendantOf(bi) then
a9.last[ba] = bl
return bn
end
end
return nil
end
do
local ba = Instance.new("Part")
ba.Shape = Enum.PartType.Ball
ba.Size = Vector3.new(0.35, 0.35, 0.35)
ba.Anchored, ba.CanCollide, ba.CanQuery, ba.CanTouch, ba.CastShadow = true, false, false, false, false
ba.Material = Enum.Material.Neon
ba.Color = Color3.fromRGB(190, 120, 255)
ba.Transparency = 1
ba.Parent = aS
aa.connect(O.RenderStepped, function()
local bb = aC.originOn and (aC.originMarker and (aC.rage or aC.killAll or aC.loopKill))
ba.Transparency = bb and 0.3 or 1
if bb then
ba.CFrame = CFrame.new(LT())
end
end)
end
local ba, bb, bc = setmetatable({}, {
__mode = "k",
}), setmetatable({}, {
__mode = "k",
}), 0.6
do
local bd = setmetatable({}, {
__mode = "k",
})
aa.connect(O.Heartbeat, function(be)
if be <= 0 then
return
end
for bf, bg in ipairs(aa.entities()) do
local bh = bg ~= _ and bg.Character
local bi = bh and bh:FindFirstChild("HumanoidRootPart")
if bi then
local bj, bk = bi.Position, bd[bg]
if bk then
local bl = (bj - bk) / be
if bl.Magnitude > 80 then
bl = Vector3.zero
end
ba[bg] = (ba[bg] or bl):Lerp(bl, 0.35)
end
bd[bg] = bj
if aC.backtrack then
local bl = bb[bg]
if not bl then
bl = {}
bb[bg] = bl
end
local bm = {
t = os.clock(),
pos = {},
}
for bn, bo in ipairs(aV) do
local bp = bh:FindFirstChild(bo)
if bp then
bm.pos[bo] = bp.Position
end
end
bm.pos.HumanoidRootPart = bj
bl[#bl + 1] = bm
while bl[1] and bm.t - bl[1].t > bc do
table.remove(bl, 1)
end
elseif bb[bg] then
bb[bg] = nil
end
else
bd[bg], ba[bg] = nil, nil
end
end
end)
end
local aimOffs = setmetatable({}, {
__mode = "k",
})
local aimMiss = setmetatable({}, {
__mode = "k",
})
local netLeadAt, netLeadVal = 0, 0
local function netLeadMs()
local a9 = os.clock()
if a9 - netLeadAt < 0.25 then
return netLeadVal
end
netLeadAt = a9
local ba = 0
pcall(function()
local bb = game:GetService("Stats")
local bc = bb and bb.Network and bb.Network.ServerStatsItem and bb.Network.ServerStatsItem["Data Ping"]
if bc then
ba = tonumber(bc:GetValue()) or 0
end
end)
ba = math.clamp(ba * 0.5, 0, 150)
netLeadVal = netLeadVal > 0 and (netLeadVal * 0.8 + ba * 0.2) or ba
return netLeadVal
end
local function zU(bd)
local be = aC.predictMs or 0
if be == 0 then
be = netLeadMs()
end
be = math.clamp(be, 0, 250)
if be <= 0 or not bd.Parent then
return bd.Position
end
local bf = aa.ownerOf(bd.Parent)
local bg = bf and ba[bf]
if not bg then
return bd.Position
end
return bd.Position + Vector3.new(bg.X, bg.Y * ((math.abs(bg.Y) > 8) and 0.35 or 0.5), bg.Z) * (be / 1000)
end
local function aimPos(bd)
local be = zU(bd)
local bf = aimOffs[bd]
if bf then
return be + bd.CFrame:VectorToWorldSpace(bf)
end
return be
end
local function aimPoints(bk)
local bp = bk.Size * 0.5
local bq = math.clamp(math.min(bp.X, bp.Y, bp.Z) * 0.35, 0.04, 0.15)
local br = bp - Vector3.new(bq, bq, bq)
return {
Vector3.new(0, 0, 0),
Vector3.new(br.X, 0, 0),
Vector3.new(-br.X, 0, 0),
Vector3.new(0, br.Y, 0),
Vector3.new(0, -br.Y, 0),
Vector3.new(0, 0, br.Z),
Vector3.new(0, 0, -br.Z),
Vector3.new(br.X, br.Y, 0),
Vector3.new(-br.X, br.Y, 0),
Vector3.new(br.X, -br.Y, 0),
Vector3.new(-br.X, -br.Y, 0),
Vector3.new(br.X, 0, br.Z),
Vector3.new(-br.X, 0, br.Z),
Vector3.new(br.X, 0, -br.Z),
Vector3.new(-br.X, 0, -br.Z),
Vector3.new(0, br.Y, br.Z),
Vector3.new(0, -br.Y, br.Z),
Vector3.new(0, br.Y, -br.Z),
Vector3.new(0, -br.Y, -br.Z),
Vector3.new(br.X, br.Y, br.Z),
Vector3.new(-br.X, br.Y, br.Z),
Vector3.new(br.X, -br.Y, br.Z),
Vector3.new(-br.X, -br.Y, br.Z),
Vector3.new(br.X, br.Y, -br.Z),
Vector3.new(-br.X, br.Y, -br.Z),
Vector3.new(br.X, -br.Y, -br.Z),
Vector3.new(-br.X, -br.Y, -br.Z),
}
end
local function aimSample(bj, bk, bl, bexact)
local bo = zU(bk)
local bs = U().Position - bo
bs = bs.Magnitude > 0.01 and bs.Unit or U().LookVector
local bt = aimPoints(bk)
local bu, bv = nil, -2
for bw = 1, #bt do
local bx = bt[bw]
local by = bx.Magnitude > 0 and bk.CFrame:VectorToWorldSpace(bx) or Vector3.new(0, 0, 0)
if bx.Magnitude == 0 or by:Dot(bs) > 0 then
local bz = bo + by - bj
if bz.Magnitude > 0.05 then
a5.FilterDescendantsInstances = GT()
local bA = workspace:Raycast(bj, bz, a5)
if bA and (bA.Instance == bk or (not bexact and bA.Instance:IsDescendantOf(bl))) then
local bB = (-bz.Unit):Dot(bA.Normal) + (bA.Instance == bk and 0.6 or 0)
if bB > bv then
bu, bv = bx, bB
if bv > 1.45 then
break
end
end
end
end
end
if bw == 1 and bu and bv >= 0.6 then
break
end
end
return bu, bv
end
local function aimSamplePen(bj, bk, bl, bm)
local bn = zU(bk)
local bo = U().Position - bn
bo = bo.Magnitude > 0.01 and bo.Unit or U().LookVector
local bp = aimPoints(bk)
local bq = {
1,
4,
5,
2,
3,
8,
9,
10,
11,
}
local br, bs = nil, nil
for bt = 1, #bq do
local bu = bp[bq[bt]]
local bv = bu.Magnitude > 0 and bk.CFrame:VectorToWorldSpace(bu) or Vector3.new(0, 0, 0)
if bu.Magnitude == 0 or bv:Dot(bo) > 0 then
local bw, bx = mT(bj, bn + bv, bl, bm)
if bw then
return bu, 0
end
if bx and (bs == nil or bx < bs) then
br, bs = bu, bx
end
end
end
return br, bs
end
local aimScanMiss = setmetatable({}, {
__mode = "k",
})
local function aimSampleFrom(bj, bk, bl, bn, bm)
local bo = aimPoints(bk)
local bp = zU(bk)
local bq = bp - bj
bq = bq.Magnitude > 0.01 and bq.Unit or U().LookVector
for br = 1, #bo do
local bs = bo[br]
local bt = bs.Magnitude > 0 and bk.CFrame:VectorToWorldSpace(bs) or Vector3.new(0, 0, 0)
if bs.Magnitude == 0 or bt:Dot(bq) > 0 then
local bu = bp + bt - bj
if bu.Magnitude > 0.05 then
local bv, bw, bx = UT(bj, bu.Unit, bn, bm, bl)
if bw and (bx <= 0 or aC.rageAutowall or (not a7.server and (aC.wallbang or aC.wallLimit))) then
return bs, bx
end
end
end
end
return nil
end
local originCache = {
char = nil,
at = 0,
from = nil,
pos = nil,
failed = false,
}
local scanParams = RaycastParams.new()
scanParams.FilterType = Enum.RaycastFilterType.Exclude
scanParams.CollisionGroup = "Bullet"
scanParams.IgnoreWater = true
local overlapParams = OverlapParams.new()
overlapParams.FilterType = Enum.RaycastFilterType.Exclude
overlapParams.MaxParts = 8
local function originActive()
return aC.originScan or (tonumber(aC.forceOrigin) or 0) >= 0.25
end
local function originScan(bd, range, pen)
if not bd or not bd.Parent then
return nil
end
local bf = LT()
local bg = aimPos(bd)
local bh = math.clamp(tonumber(aC.originScanRadius) or 8, 1, 16)
local bi = math.clamp(math.floor(tonumber(aC.originScans) or 4), 1, 12)
local bj = aC.originScanMode or "optimized"
local bm = bg - bf
local bn = bm.Magnitude
if bn < 0.5 then
return nil
end
bh = math.min(bh, math.max(bn * 0.85, 8.5))
if bh < 0.5 then
return nil
end
local char = bd.Parent
local rng = tonumber(range) or 500
local pn = tonumber(pen) or 0
local useLand = bj ~= "default"
local now = os.clock()
local cache = originCache
scanParams.FilterDescendantsInstances = GT()
local ca = GT()
local ovl = {}
for cb = 1, #ca do
local cc = ca[cb]
if cc then
ovl[#ovl + 1] = cc
end
end
ovl[#ovl + 1] = char
overlapParams.FilterDescendantsInstances = ovl
local function clear(bu)
local bv = bg - bu
local bw = bv.Magnitude
if bw < 0.05 then
return true
end
local bx = workspace:Raycast(bu, bv, scanParams)
return bx == nil or bx.Instance == bd or bx.Instance:IsDescendantOf(char)
end
local function wallsOk(bv)
return bv <= 0 or aC.rageAutowall or (not a7.server and (aC.wallbang or aC.wallLimit))
end
local function lands(bu)
local bv = bg - bu
local bw = bv.Magnitude
if bw < 0.05 then
return true, 1
end
local bx, by, bz = UT(bu, bv.Unit, rng, pn, char)
return by == true and wallsOk(bz or 0), #bx
end
local function free(bu)
local bv = workspace:GetPartBoundsInRadius(bu, 0.15, overlapParams)
for bw = 1, #bv do
local bx = bv[bw]
if bx.CanCollide and bx.CanQuery and bx.Transparency < 0.9 and not bx:IsDescendantOf(char) then
return false
end
end
return true
end
local function test(bu)
if bj == "precise" then
local ok, n = lands(bu)
if not (ok and n > 0) then
return nil
end
return free(bu) and bu or nil
end
if clear(bu) and free(bu) then
return bu
end
if useLand then
local ok = lands(bu)
if ok and free(bu) then
return bu
end
end
return nil
end
if cache.char == char and cache.from and now - cache.at < 0.15 and (cache.from - bf).Magnitude < 2 then
if cache.pos then
if test(cache.pos) then
cache.at = now
return cache.pos
end
elseif cache.failed then
return nil
end
end
local bo = bm.Unit
local bp = bo:Cross(Vector3.new(0, 1, 0))
if bp.Magnitude < 0.01 then
bp = bo:Cross(Vector3.new(1, 0, 0))
end
bp = bp.Unit
local bq = bp:Cross(bo).Unit
local bw = test(bf)
if not bw then
local forceDist = math.clamp(tonumber(aC.forceOrigin) or 0, 0, 20)
if forceDist >= 0.25 then
local forceFlat = Vector3.new(bg.X - bf.X, 0, bg.Z - bf.Z)
local forceSide
if forceFlat.Magnitude > 0.001 then
forceFlat = forceFlat.Unit
forceSide = Vector3.new(-forceFlat.Z, 0, forceFlat.X)
else
forceSide = Vector3.new(1, 0, 0)
end
local forceOffsets = {
forceSide * (forceDist * 0.5),
-forceSide * (forceDist * 0.5),
forceSide * forceDist,
-forceSide * forceDist,
Vector3.new(0, forceDist, 0),
}
local forceTried = {}
for forceIndex = 1, #forceOffsets do
local forceOffset = forceOffsets[forceIndex]
local forceLen = forceOffset.Magnitude
local forceSpot
if forceLen >= 0.25 then
local forceHit = workspace:Raycast(bf, forceOffset, scanParams)
if forceHit then
local forceFree = (forceHit.Position - bf).Magnitude - 0.3
if forceFree >= 0.25 then
forceSpot = bf + forceOffset * (forceFree / forceLen)
end
else
forceSpot = bf + forceOffset
end
end
if forceSpot then
local duplicate = false
for triedIndex = 1, #forceTried do
if (forceTried[triedIndex] - forceSpot).Magnitude < 0.2 then
duplicate = true
break
end
end
if not duplicate then
forceTried[#forceTried + 1] = forceSpot
bw = test(forceSpot)
if bw then
break
end
end
end
end
end
end
if not bw and aC.originScan then
local rings = { 0.35, 0.6, 0.8, 1 }
local steps = math.max(bi, 8)
for ca = 1, #rings do
local cb = math.max(bh * rings[ca], 1)
for cc = 1, steps do
local cd = ((cc - 1) / steps) * 2 * math.pi
local ce = test(bf + (bp * math.cos(cd) + bq * math.sin(cd)) * cb)
if ce then
bw = ce
break
end
end
if bw then
break
end
end
end
if not bw and aC.originScan then
local ca = math.min(bh * 0.5, 2.5)
bw = test(bf + Vector3.new(0, ca, 0))
if not bw then
bw = test(bf - Vector3.new(0, ca, 0))
end
end
if not bw and aC.originScan then
local ca = math.max(bh * 0.3, 1.5)
local cb = math.max(bh * 0.45, 2.5)
local cc = math.max(bh * 0.6, 3.5)
local cd = {
bf + bo * ca,
bf + bo * ca + bp * cb,
bf + bo * ca - bp * cb,
bf + bo * cb + bp * ca,
bf + bo * cb - bp * ca,
bf + bo * cb,
bf + bp * cc,
bf - bp * cc,
bf + bo * cc,
}
for ce = 1, #cd do
bw = test(cd[ce])
if bw then
break
end
end
end
if bw then
cache.char, cache.at, cache.from, cache.pos, cache.failed = char, os.clock(), bf, bw, false
else
cache.char, cache.at, cache.from, cache.pos, cache.failed = char, os.clock(), bf, nil, true
end
if aC.originScanDebug then
if bw then
local ca = Instance.new("Part")
ca.Size = Vector3.new(0.35, 0.35, 0.35)
ca.Shape = Enum.PartType.Ball
ca.Anchored, ca.CanCollide, ca.CanQuery, ca.CanTouch, ca.CastShadow = true, false, false, false, false
ca.Material = Enum.Material.Neon
ca.Color = Color3.fromRGB(0, 255, 140)
ca.CFrame = CFrame.new(bw)
ca.Parent = workspace
game:GetService("Debris"):AddItem(ca, 0.5)
if aC and aC.originScanDebug then
end
else
end
end
return bw
end
local function xU(bd, be, bf, bg)
local bh = bd.Properties
if not (bh and (bd.Identifier and be)) then
return false
end
local bi = a7.server
local bj = {}
local bl = bh.Range or 500
local bm = uT(bh)
if bi then
bg = nil
end
local bk, fromScan = nil, false
if not bg then
bk = EU(be)
end
if not bk and originActive() then
bk = originScan(be, bl, bm)
if bk then
fromScan = true
end
end
if not bk then
bk = LT()
end
local bn = (bg or aimPos(be)) - bk
local bo = {}
if bn.Magnitude < 0.01 then
bn = (U()).LookVector
else
bn = bn.Unit
end
for bp = 1, math.max(bh.BulletsPerShot or 1, 1), 1 do
local bq
if bg then
bq = jT(bk, bg, be, bl, bm, bf)
if not bq then
return false
end
else
bq = DT(bk, bn, bl, bm, be, bf)
end
if bi then
if not (fromScan or aC.wallbang) then
local br = bq[#bq]
if not (br and (br.Instance and br.Instance:IsDescendantOf(be.Parent))) then
return false
end
end
bo[#bo + 1] = {
Direction = bn,
Origin = bk,
}
else
bo[#bo + 1] = {
Direction = bn,
Origin = bk,
Hits = kT(bk, bq),
}
end
bj[#bj + 1] = bq
end
bd.ShotSeq = (bd.ShotSeq or 0) + 1
local bp = {
IsSniperScoped = bd.IsSniperScoped,
ShootingHand = bd.ShootingHand,
Identifier = bd.Identifier,
Seq = bd.ShotSeq,
Bullets = bo,
ViewTick = bi and a7.viewTick() or nil,
__nightcc = bj,
}
local bq = pcall(a2.Inventory.ShootWeapon.Send, bp)
if bq then
bd.Rounds = math.max((bd.Rounds or 1) - 1, 0)
bd.RechargeStartTime = workspace:GetServerTimeNow()
OT(bd)
end
return bq
end
local bd = require(L.Database.Components.GameState)
local function lU()
if not aC.killAllWaitRound then
return true
end
local be, bf = pcall(bd.GetStateAtTime, workspace:GetServerTimeNow() + (aC.killAllLeadMs or 0) / 1000)
return be and bf == "Round In Progress"
end
do
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.IgnoreWater = true
local rayIgnore
pcall(function()
local mod = require(L.Components.Common.GetRayIgnore)
if type(mod) == "function" then
rayIgnore = mod
end
end)
local function equipped()
if aw and type(aw.peekCurrentEquippedForMovement) == "function" then
local ok, weapon = pcall(aw.peekCurrentEquippedForMovement)
if ok and type(weapon) == "table" and not weapon.IsDestroyed then
return weapon
end
end
return p()
end
local function aliveChar(plr)
local char = plr.Character
if not (char and char:IsDescendantOf(workspace)) then
return nil
end
if char:GetAttribute("Dead") ~= false then
return nil
end
local hp = char:GetAttribute("Health")
if typeof(hp) ~= "number" or hp <= 0 then
return nil
end
return char
end
local function enemy(plr)
if plr == _ then
return false
end
if workspace:GetAttribute("Gamemode") == "Deathmatch" then
return true
end
local mine, theirs = _:GetAttribute("Team"), plr:GetAttribute("Team")
if type(mine) ~= "string" or type(theirs) ~= "string" then
return false
end
if mine ~= "Counter-Terrorists" and mine ~= "Terrorists" then
return false
end
if theirs ~= "Counter-Terrorists" and theirs ~= "Terrorists" then
return false
end
return mine ~= theirs
end
local function ignoreList(char)
local list = {}
if rayIgnore then
local ok, res = pcall(rayIgnore)
if ok and type(res) == "table" then
for _, inst in ipairs(res) do
list[#list + 1] = inst
end
end
end
list[#list + 1] = char
local cam = workspace.CurrentCamera
if cam then
list[#list + 1] = cam
end
local debris = workspace:FindFirstChild("Debris")
if debris then
list[#list + 1] = debris
end
return list
end
local function findTarget(char, origin, reach, rayLen)
params.FilterDescendantsInstances = ignoreList(char)
local bestDist, bestChar, bestPart
for _, plr in ipairs(aa.entities()) do
if enemy(plr) then
local other = aliveChar(plr)
if other then
local part = other:FindFirstChild("Head") or other:FindFirstChild("UpperTorso") or other.PrimaryPart
if part then
local delta = ((getgenv().NightPredictPos and getgenv().NightPredictPos(part)) or part.Position) - origin
local dist = delta.Magnitude
if dist > 0.05 and dist <= reach and (bestDist == nil or dist < bestDist) then
local dir = delta.Unit * rayLen
local hit = workspace:Raycast(origin, dir, params)
if not hit then
local ok, sphere = pcall(workspace.Spherecast, workspace, origin, 1.5, dir, params)
hit = ok and sphere or nil
end
if hit and hit.Instance and hit.Instance:IsDescendantOf(other) then
bestDist, bestChar, bestPart = dist, other, part
end
end
end
end
end
end
return bestChar, bestPart
end
local function backstab(char, target)
local mine = char.PrimaryPart or char:FindFirstChild("HumanoidRootPart")
local theirs = target.PrimaryPart or target:FindFirstChild("HumanoidRootPart")
if not (mine and theirs) then
return false
end
local dot = math.clamp(theirs.CFrame.LookVector:Dot((mine.Position - theirs.Position).Unit), -1, 1)
return math.deg(math.acos(dot)) > 100
end
local last, lastWeapon = 0, nil
aa.connect(O.Heartbeat, function()
if not aC.knifeBot or aa.unloaded or m() then
return
end
local weapon = equipped()
local props = weapon and weapon.Properties
if not (props and (props.Class == "Melee" and type(weapon.shoot) == "function")) then
return
end
if weapon.IsShooting then
return
end
if weapon.WeaponEquippedTick and tick() - weapon.WeaponEquippedTick <= 1 then
return
end
local char = aliveChar(_)
if not char then
return
end
local head = char:FindFirstChild("Head") or char.PrimaryPart
if not head then
return
end
local rate = math.max(tonumber(props.FireRate) or 0, 0.05)
local now = os.clock()
if weapon == lastWeapon and now - last < rate then
return
end
local reach = math.clamp(tonumber(aC.knifeBotRange) or 3.5, 2, 5)
local rayLen = tonumber(props.Range) or 3
local target, part = findTarget(char, head.Position, reach, rayLen)
if not (target and part) then
return
end
local extra = aC.knifeHeavy and backstab(char, target) or false
local cam = workspace.CurrentCamera
if not cam then
return
end
local old, look = cam.CFrame, CFrame.lookAt(head.Position, part.Position)
local yaw = select(2, look:ToEulerAnglesYXZ())
aH.knife.yaw, aH.knife.pitch = yaw, math.clamp(look.LookVector.Y, -1, 1)
aH.knife.expires, aH.knife.samples = os.clock() + 0.12, 4
cam.CFrame = look
local ok = pcall(weapon.shoot, weapon, extra)
cam.CFrame = old
if ok then
last, lastWeapon = now, weapon
else
aH.knife.samples, aH.knife.expires = 0, 0
end
end)
end
do
local buyMenu, buyArea
local groups = {
{ "AK-47", "M4A1-S", "M4A4" },
{ "Galil AR", "FAMAS" },
{ "SG 553", "AUG" },
{ "MAC-10", "MP9" },
{ "Sawed-Off", "MAG-7" },
{ "Glock-18", "USP-S", "P2000" },
{ "Tec-9", "Five-SeveN" },
{ "Molotov", "Incendiary Grenade" },
}
local state = {
pending = {},
tried = {},
last = 0,
waitUntil = 0,
wasOpen = false,
wasInside = false,
team = "",
generation = -1,
gameState = "",
dirty = true,
}
pcall(function()
buyMenu = require(L.Interface.Screens.Gameplay.Middle.BuyMenu)
end)
pcall(function()
buyArea = require(L.Database.Components.Common.IsInBuyArea)
end)
local function alive()
local char = _ and _.Character
if not char or not char:IsDescendantOf(workspace) then
return false
end
if char:GetAttribute("Dead") ~= false then
return false
end
local health = char:GetAttribute("Health")
return typeof(health) == "number" and health > 0
end
local function loadout()
local map = {}
if aw and type(aw.GetEquippedInventoryItem) == "function" then
for _, cat in ipairs({ "Pistols", "Mid Tier", "Rifles", "Grenades" }) do
for i = 1, 8, 1 do
local key = ("Loadout.%s.Options.%d"):format(cat, i)
local ok, item = pcall(aw.GetEquippedInventoryItem, _, key)
if ok and type(item) == "table" and type(item.Name) == "string" then
map[item.Name] = key
end
end
end
local ok, item = pcall(aw.GetEquippedInventoryItem, _, "Equipped.Equipped Zeus x27")
if ok and type(item) == "table" and item.Name == "Zeus x27" then
map["Zeus x27"] = "Equipped.Equipped Zeus x27"
end
end
return map
end
local function findAlias(name, map)
if map[name] then
return name, map[name]
end
for _, group in ipairs(groups) do
if table.find(group, name) then
for _, alt in ipairs(group) do
if map[alt] then
return alt, map[alt]
end
end
break
end
end
return nil, nil
end
local function owned(name, map)
if map[name] then
return true
end
for _, group in ipairs(groups) do
if table.find(group, name) then
for _, alt in ipairs(group) do
if map[alt] then
return true
end
end
break
end
end
return false
end
local function currentWeapon()
if not (aw and type(aw.peekCurrentEquippedForMovement) == "function") then
return nil
end
local ok, weapon = pcall(aw.peekCurrentEquippedForMovement)
if not ok or not weapon or weapon.IsDestroyed then
return nil
end
return weapon
end
local function inventory()
local out, hasMelee, anyItem, resolved = {}, false, false, false
if aw and type(aw.getCurrentInventory) == "function" then
local ok, inv = pcall(aw.getCurrentInventory)
if ok and type(inv) == "table" then
for _, slot in pairs(inv) do
local items = type(slot) == "table" and slot._items
if type(items) == "table" then
local settings = slot._settings
local melee = type(settings) == "table" and settings._strict_type == "Melee"
hasMelee = melee or hasMelee
for _, item in pairs(items) do
if type(item) == "table" and item.IsDestroyed ~= true and type(item.Name) == "string" then
out[item.Name] = (out[item.Name] or 0) + 1
anyItem = true
hasMelee = melee or hasMelee
end
end
end
end
resolved = true
end
else
anyItem, resolved = true, true
end
local weapon = currentWeapon()
if weapon and type(weapon.Name) == "string" and not out[weapon.Name] then
out[weapon.Name] = 1
end
return out, resolved and (hasMelee or anyItem)
end
local function build(have)
state.pending = {}
local team = _:GetAttribute("Team")
if team ~= "Terrorists" and team ~= "Counter-Terrorists" then
return
end
local map, used, count = loadout(), {}, 0
local function add(name)
if type(name) ~= "string" or name == "" or name == "none" then
return
end
local real, path = findAlias(name, map)
if not real or not path then
return
end
if owned(real, have) or owned(real, state.tried) or used[real] then
return
end
used[real] = true
count = count + 1
state.pending[count] = {
name = real,
path = path,
fails = 0,
}
end
add(aC.buyPrimary)
add(aC.buySecondary)
if false and aC.buyZeus then
add("Zeus x27")
end
for name in tostring(aC.buyNades or ""):gmatch("[^,]+") do
add((name:gsub("^%s*(.-)%s*$", "%1")))
end
end
aa.connect(O.Heartbeat, function()
if not aC.autoBuy or aa.unloaded then
return
end
if not (buyMenu and type(buyMenu.purchase) == "function") or not buyArea then
return
end
if not alive() then
return
end
local gamemode = workspace:GetAttribute("Gamemode")
if gamemode ~= "Bomb Defusal" and gamemode ~= "Hostage Rescue" then
return
end
local team = _:GetAttribute("Team") or ""
if team ~= "Terrorists" and team ~= "Counter-Terrorists" then
return
end
local gameState = workspace:GetAttribute("GameState") or ""
local open = _:GetAttribute("BuyMenu") == true or gameState == "Buy Period"
local okArea, area = pcall(buyArea, _)
local inside = okArea and area == true
local generation = tonumber(_:GetAttribute("CharacterGeneration")) or -1
local now = tick()
local sig = ("%s|%s|%s|%s"):format(
tostring(aC.buyPrimary),
tostring(aC.buySecondary),
tostring(aC.buyZeus),
tostring(aC.buyNades)
)
if sig ~= state.sig then
state.sig = sig
state.dirty = true
end
if gameState ~= state.gameState then
if gameState == "Buy Period" then
state.tried = {}
state.dirty = true
state.waitUntil = 0
end
state.gameState = gameState
end
if open and not state.wasOpen then
state.dirty = true
end
if inside and not state.wasInside then
state.dirty = true
end
if team ~= state.team or generation ~= state.generation then
state.tried = {}
state.dirty = true
state.waitUntil = 0
end
state.wasOpen, state.wasInside, state.team, state.generation = open, inside, team, generation
if open then
if not inside then
return
end
else
return
end
local have, canBuy = inventory()
if canBuy then
if state.waitUntil > 0 then
state.waitUntil = 0
state.dirty = true
end
else
if state.waitUntil <= 0 then
state.waitUntil = now + 2
end
if now < state.waitUntil then
state.dirty = true
return
end
end
if state.dirty then
state.dirty = false
build(have)
end
local item = state.pending[1]
while item and (owned(item.name, have) or owned(item.name, state.tried)) do
table.remove(state.pending, 1)
item = state.pending[1]
end
if not item or now - state.last < 0.38 then
return
end
state.last = now
if pcall(buyMenu.purchase, item.name, item.path, false) then
state.tried[item.name] = true
table.remove(state.pending, 1)
else
item.fails = item.fails + 1
if item.fails >= 3 then
table.remove(state.pending, 1)
end
end
end)
end
local function yU(be)
local bf = be.Properties
if not (bf and (bf.Rounds and be.Identifier)) then
return false
end
local bg, bh, bi =
workspace:GetAttribute("Gamemode") == "Deathmatch", be.Capacity or 0, bf.Rounds - (be.Rounds or 0)
local bj = bg and bi or math.min(bi, bh)
if bj <= 0 then
return false
end
local bk = pcall(a2.Inventory.ReloadWeapon.Send, {
Identifier = be.Identifier,
Capacity = bh,
Rounds = be.Rounds,
})
if bk then
be.Rounds = (be.Rounds or 0) + bj
if not bg then
be.Capacity = bh - bj
end
end
return bk
end
local be = setmetatable({}, {
__mode = "k",
})
local function qU(bf)
local bg = bf and bf.WeaponEquippedTick
if type(bg) ~= "number" then
return true
end
local bh = be[bf]
if not bh then
bh = 0.5
pcall(function()
local bi = bf.Viewmodel.Animation:getAnimation("Equip")
if bi and (type(bi.Length) == "number" and bi.Length > 0) then
bh = bi.Length
be[bf] = bh
end
end)
end
return tick() - bg > bh * 0.925 + 0.03
end
local function vU(bf, bg)
if bf then
if mouse1release then
mouse1release()
end
if mouse1press then
mouse1press()
end
elseif FT(bg) and mouse2click then
mouse2click()
elseif mouse1click then
mouse1click()
end
end
local bf, bg, bh
do
local bi = {
Head = {
"Head",
},
Body = {
"UpperTorso",
"LowerTorso",
"HumanoidRootPart",
},
Multipoint = {
"Head",
"UpperTorso",
"LowerTorso",
"HumanoidRootPart",
},
["Full Body"] = aV,
}
local function E(bj, bk, bl, bm, bn)
local bo = (aimPos(bk) - bj).Unit
local bp, bq, br = UT(bj, bo, bn, bm, bl)
if bq and br > 0 and not aC.rageAutowall and (a7.server or (not aC.wallbang and not aC.wallLimit)) then
if not originActive() then
return false, 0
end
bq = nil
end
if bq then
local bs = bp and bp[#bp]
if bs and bs.Instance ~= bk and not aimOffs[bk] and (aimMiss[bk] or 0) < os.clock() then
local bt, bu = aimSample(bj, bk, bl, true)
if bt and bu and bu > 0.15 then
aimOffs[bk] = bt
aimMiss[bk] = nil
else
local bv, bw = aimSamplePen(bj, bk, bn, bm)
if bv and bw and bw < br then
aimOffs[bk] = bv
aimMiss[bk] = nil
else
aimMiss[bk] = os.clock() + 0.5
end
end
end
return true, br
end
if originActive() then
local bs = originScan(bk, bn, bm)
if bs then
local bt = (aimPos(bk) - bs).Unit
local bu, bv, bw = UT(bs, bt, bn, bm, bl)
if bv and not (bw > 0 and not aC.rageAutowall and (a7.server or (not aC.wallbang and not aC.wallLimit))) then
return true, bw
end
if a7.server and (aimScanMiss[bk] or 0) < os.clock() then
local bx, by = aimSampleFrom(bs, bk, bl, bn, bm)
if bx then
aimOffs[bk] = bx
aimScanMiss[bk] = nil
return true, by
end
aimScanMiss[bk] = os.clock() + 0.25
end
end
end
if aC.wallbang and not a7.server then
local bs, bt, bu = UT(bj, bo, bn, math.huge, bl)
return true, bu
end
local bs = aimSample(bj, bk, bl)
if bs then
aimOffs[bk] = bs
return true, 0
end
aimOffs[bk] = nil
return false, 0
end
local bj = 0.075
local function z(bk)
local bl = bk:GetAttribute("Armor")
if type(bl) ~= "string" then
return 0, false
end
local bm, bn = pcall(ar.JSONDecode, ar, bl)
if not bm or type(bn) ~= "table" then
return 0, false
end
return tonumber(bn.Health) or 0, type(bn.Type) == "string" and bn.Type:find("Helmet") ~= nil
end
local function x(bk, bl, bm, bn, bo)
local bp, bq = aW[bl], bk.DamagePerPart
if not bp or type(bq) ~= "table" or not bq[bp] then
return 0
end
local br = bq[bp]
br = br * (bk.RangeModifier or 1) ^ ((bm / bj) / 500)
if bn > 0 then
br = br * (bk.WallbangMultiplier or 0.5) ^ bn
end
local bs, bt = z(bo)
if bs > 0 and (bp ~= "Legs" and (bp ~= "Head" or bt)) then
br = br * (bk.ArmorPenetration or 1)
end
return br * (bk.BulletsPerShot or 1)
end
local function R(bk, bl, bm, bn)
local bo = aZ.key(bk, aW[bl], bm)
if a7.server then
return bn, bo
end
return bn * aZ.get(bo), bo
end
local function l()
return aC.minDmgOverride and aC.minDmgOverrideValue or aC.minDmg
end
local bk, bl, bm = nil, 0.004, 1
local function q(bn)
local bo, bp, bq = os.clock(), LT(), bn.Properties
local br, bs, bt = uT(bq), bq.Range or 500, bi[aC.rageHitbox] or bi.Head
if aC.forceBody then
bt = bi.Body
end
local bu, bv, bw = l(), {}, at.ViewportSize / 2
for bx, by in ipairs(aa.entities()) do
if ET(by) then
local bz = F(by, "HumanoidRootPart")
if bz and not t(bz) then
local bA = (bz.HumanoidRootPart.Position - bp).Magnitude
if bA < aC.rageMaxDist then
local bB = {
player = by,
char = bz,
dist = bA,
hp = tonumber(bz:GetAttribute("Health")) or 100,
}
if aC.rageTargetMode == "Crosshair" then
bB.score = bT(bz.HumanoidRootPart.Position, bw) or math.huge
elseif aC.rageTargetMode == "Lowest HP" then
bB.score = bB.hp + bA / 10000
else
bB.score = bA
end
if aC.rageSticky and by == bk then
bB.score = -math.huge
end
bv[#bv + 1] = bB
end
end
end
end
table.sort(bv, function(bx, by)
return bx.score < by.score
end)
aC.rageCands = #bv
local bx, by = {}, #bv
local bz = bm <= by and bm or 1
bm = 1
for bA = 0, by - 1, 1 do
local bB = ((bz - 1) + bA) % by + 1
local bC = bv[bB]
if bA > 0 and os.clock() - bo > bl then
bm = bB
break
end
local bD, bE = bC.hp, bt
if aC.missAdapt and (aK[bC.player] or 0) >= aC.missesToBody then
bE = bi.Body
end
if aC.rageAutowall and bE == bi.Head then
local bJ = bC.char:FindFirstChild("Head")
if bJ then
a5.FilterDescendantsInstances = GT()
local bK = workspace:Raycast(bp, zU(bJ) - bp, a5)
if bK and bK.Instance ~= bJ and not bK.Instance:IsDescendantOf(bC.char) then
bE = bi.Multipoint
end
end
end
local bF, bG = { dmg = 0 }, { dmg = 0 }
for bH, bI in ipairs(bE) do
local bJ = bC.char:FindFirstChild(bI)
if bJ then
local bK = EU(bJ)
local bL, bM = bK ~= nil, 0
if not bK then
bK = bp
bL, bM = E(bp, bJ, bC.char, br, bs)
if bL and (aC.wallLimit and not aC.rageAutowall and bM > aC.maxWalls) then
bL = false
end
end
if bL then
local bN, bO =
bK ~= bp and "TP" or nil,
x(
bq,
bI,
(bJ.Position - bK).Magnitude,
(aC.wallLimit and not a7.server) and 0 or bM,
bC.player
)
local bP, bQ = R(bn.Name, bI, bM, bO)
if bP > bF.dmg then
bF = {
part = bJ,
dmg = bP,
raw = bO,
key = bQ,
walls = bM,
track = bN,
}
end
if aW[bI] == "Torso" and bP > bG.dmg then
bG = {
part = bJ,
dmg = bP,
raw = bO,
key = bQ,
walls = bM,
track = bN,
}
end
if bG.dmg >= bD or bF.dmg >= bD and not aC.preferBodyLethal then
break
end
end
end
end
if aC.preferBodyLethal and (bG.part and bG.dmg >= bD) then
bF = bG
end
local bH = bD <= bu and 0 or bu
if aC.rageAutowall and bF.walls and bF.walls > 0 then
bH = math.max(tonumber(aC.rageWallMinDmg) or 0, 0)
end
if
not a7.server
and (not (bF.part and (bF.dmg >= bH or bF.dmg >= bD)) and (aC.backtrack or aC.forwardTrack))
then
local function d(bI, bJ, bK, bL)
local bM, bN = mT(bp, bK, bs, br)
if not bM or bN > 0 and (not aC.rageAutowall and (not aC.wallbang and not aC.wallLimit)) then
return
end
if aC.wallLimit and not aC.rageAutowall and bN > aC.maxWalls then
return
end
local bO = x(bq, bI, (bK - bp).Magnitude, aC.wallLimit and 0 or bN, bC.player)
local bP, bQ = R(bn.Name, bI, bN, bO)
if bP > bF.dmg then
bF = {
part = bJ,
dmg = bP,
raw = bO,
key = bQ,
walls = bN,
pos = bK,
track = bL,
}
end
end
if aC.backtrack then
local bI, bJ = bb[bC.player], os.clock()
if bI then
for bK = #bI - 1, 1, -2 do
local bL = bI[bK]
local bM = bJ - bL.t
if bM > aC.backtrackMs / 1000 then
break
end
if os.clock() - bo > bl then
break
end
for bN, bO in ipairs(bE) do
local bP, bQ = bC.char:FindFirstChild(bO), bL.pos[bO]
if bP and bQ then
d(bO, bP, bQ, ("BT %dms"):format(bM * 1000))
end
end
if bF.pos and (bF.dmg >= bH or bF.dmg >= bD) then
break
end
end
end
end
if aC.forwardTrack and not (bF.pos and (bF.dmg >= bH or bF.dmg >= bD)) then
local bI = ba[bC.player]
if bI and bI.Magnitude > 1 then
for bJ, bK in ipairs({ 0.5, 1 }) do
if os.clock() - bo > bl then
break
end
local bL = (aC.forwardMs * bK) / 1000
for bM, bN in ipairs(bE) do
local bO = bC.char:FindFirstChild(bN)
if bO then
d(bN, bO, bO.Position + bI * bL, ("FT %dms"):format(bL * 1000))
end
end
if bF.pos and (bF.dmg >= bH or bF.dmg >= bD) then
break
end
end
end
end
end
if bF.part and (bF.dmg >= bH or bF.dmg >= bD) then
bF.player, bF.char, bF.hp = bC.player, bC.char, bD
bx[#bx + 1] = bF
if not aC.rageMulti then
break
end
end
end
bk = bx[1] and bx[1].player or nil
return bx
end
local bn, bo = {}, 0
local function validTarget(bq, br)
if not bq or not bq.part or not bq.char then
return false
end
local bs = bq.part
if not bs.Parent or not bq.char.Parent or bq.char:GetAttribute("Dead") or t(bq.char) then
return false
end
local bt = br and br.Properties
if not bt then
return false
end
local bu = bt.Range or 500
local bv = uT(bt)
local bw = LT()
local bx = aimPos(bs)
local by = bx - bw
if by.Magnitude < 0.05 or by.Magnitude > bu then
return false
end
local bz, ca = mT(bw, bx, bu, bv)
if bz and (ca <= 0 or aC.rageAutowall or (not a7.server and (aC.wallbang or aC.wallLimit))) then
return true
end
if originActive() then
local cb = originScan(bs, bu, bv)
if cb then
local cc, cd, ce = UT(cb, (bx - cb).Unit, bu, bv, bq.char)
if cd and (ce <= 0 or aC.rageAutowall or (not a7.server and (aC.wallbang or aC.wallLimit))) then
return true
end
end
end
return false
end
local function N(bq)
local br = os.clock()
local bs = bn[1]
if bs and br - bo < (aC.rageSticky and 0.25 or 0.1) and validTarget(bs, bq) then
return bn
end
if br - bo >= 1 / math.max(aC.rageScanHz, 1) then
bo = br
bn = q(bq)
else
for bt = #bn, 1, -1 do
if not validTarget(bn[bt], bq) then
table.remove(bn, bt)
end
end
end
return bn
end
local bp = Instance.new("Highlight")
bp.FillTransparency = 1
bp.OutlineColor = Color3.fromRGB(190, 120, 255)
bp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
bp.Enabled = false
bp.Parent = aL
local bq = Instance.new("BillboardGui")
bq.Size = UDim2.fromOffset(240, 18)
bq.StudsOffset = Vector3.new(0, 4.2, 0)
bq.AlwaysOnTop = true
bq.Enabled = false
bq.Parent = aL
local br = Instance.new("TextLabel")
br.Size = UDim2.fromScale(1, 1)
br.BackgroundTransparency = 1
br.Font = Enum.Font.Gotham
br.TextSize = 12
br.TextColor3 = Color3.fromRGB(205, 160, 255)
br.TextStrokeTransparency = 0.4
br.Parent = bq
aa.onUnload(function()
bp:Destroy()
bq:Destroy()
end)
local function b(bs)
if setthreadidentity then
pcall(setthreadidentity, 8)
end
local bt = false
bp.Enabled = bt
bq.Enabled = bt
if not bt then
return
end
bp.Adornee = bs.char
bq.Adornee = bs.part
local bu, bv = aK[bs.player] or 0, bs.dmg > 0 and math.ceil(bs.hp / bs.dmg) or 0
br.Text = ("%s | %d hp | ~%d dmg | %d tap%s%s"):format(
bs.player.Name,
math.floor(bs.hp + 0.5),
math.floor(bs.dmg + 0.5),
bv,
bs.walls > 0 and " | " .. (bs.walls .. (" wall" .. (bs.walls > 1 and "s" or ""))) or "",
bu > 0 and " | " .. (bu .. " miss") or ""
) .. (bs.track and " | " .. bs.track or "")
end
local lastKillAllHit = 0
local bs, bt = 0, setmetatable({}, {
__mode = "k",
})
local function w(bu)
if aC.rapidFire and aC.rapidUnlimited then
return 0
end
local bv = tT(bu)
if aC.rapidFire then
bv = bv / math.max(aC.rapidMult, 1)
end
return bv
end
local function e()
if aC.loopKill and aC.loopTarget then
local bu = aa.byName(aC.loopTarget)
local bv = bu and F(bu, "Head")
if bv and not t(bv) then
return bv.Head
end
return nil
end
return nil
end
aa.connect(O.Heartbeat, function()
bf, bg, bh = nil, nil, nil
if m() then
return
end
local bu = aC.loopKill and aC.loopTarget ~= nil or aC.killAll
if not aC.rage and not bu then
aC.rageStatus = nil
return
end
local bv = p()
if not bv or not bv.Bullet or not bv.Properties then
aC.rageStatus = "NO GUN"
return
end
if aC.killAll and (not bv.IsReloading and (lU() and qU(bv))) then
local bw = os.clock()
local chaining = (bw - (lastKillAllHit or -10)) <= (aC.killAllChainWindow or 0.4)
for bx, by in ipairs(aa.entities()) do
if ET(by) then
local bz = F(by, "Head")
local freshTarget = (bt[by] or 0) == 0
local gate = (chaining and freshTarget) and true or (bw - (bt[by] or 0) >= aC.killAllDelay)
if bz and (not t(bz) and gate) then
if (bv.Rounds or 0) <= 0 then
yU(bv)
end
if (bv.Rounds or 0) <= 0 then
break
end
if xU(bv, bz.Head, true) then
bt[by] = bw
lastKillAllHit = bw
end
end
end
end
end
local bw = e()
local bx = (not bw and aC.rage) and N(bv) or {}
b(not bw and bx[1] or nil)
bg = bw or bx[1] and bx[1].part or nil
bh = not bw and (bx[1] and bx[1].pos) or nil
bf = bh or bg and bg.Position
if not bg then
aC.rageStatus = (aC.rageCands or 0) > 0 and "NO LINE" or "NO TARGET"
return
end
if not (bw or aC.rageAutoFire) then
aC.rageStatus = "AUTO OFF"
return
end
if (bv.Rounds or 0) <= 0 or bv.IsReloading then
aC.rageStatus = bv.IsReloading and "RELOAD" or "NO AMMO"
return
end
if not qU(bv) then
aC.rageStatus = "EQUIP"
return
end
if aC.rageRemote or bw then
local by, bz = os.clock(), w(bv)
local autoshotBoost = tonumber(aC.autoshotDelay) or 0
if autoshotBoost > 0 then
bz = math.max(bz - (autoshotBoost / 1000), 0)
end
if by - bs < bz then
aC.rageStatus = ("WAIT %.1f"):format(bz - (by - bs))
return
end
aC.rageStatus = "FIRE"
bs = by
local bA = {}
if bw then
bA[1] = { part = bw }
elseif aC.rageMulti then
bA = bx
else
bA[1] = bx[1]
end
local bB = {}
for bC, bD in ipairs(bA) do
local bE = 1
if aC.tapKill and (bD.hp and (bD.dmg and bD.dmg > 0)) then
bE = math.clamp(math.ceil(bD.hp / bD.dmg), 1, aC.maxTaps)
end
if aC.doubleTap and bE < 2 then
bE = 2
end
if bE > 1 then
bD.key = nil
end
for bF = 1, bE, 1 do
bB[#bB + 1] = bD
end
end
local bC, bD = bz == 0 and (bv.Rounds or 1) or #bB, 0
while bD < bC do
local bE = bB[bD % #bB + 1]
if (bv.Rounds or 0) <= aC.reloadAt and (aC.autoReload and aC.remoteReload) then
yU(bv)
end
if (bv.Rounds or 0) <= 0 then
break
end
if bE.player and bE.key then
aZ.expect(bE.player, bE.key, bE.raw)
end
xU(bv, bE.part, bw ~= nil or aC.wallbang, bE.pos)
bD = bD + 1
end
if aC.doubleTap and (bD >= 2 and bz > 0) then
bs = by + bz
end
elseif not aC.rapidFire and (not bv.IsShooting and not bv.IsFireHeld) then
vU(false, bv)
end
end)
do
local UP = Vector3.new(0, 1, 0)
local STEP, SCAN_GAP, MAX_HITBOXES = 0.75, 0.1, 4
local PATH_HEIGHTS = { Vector3.new(0, -2, 0), Vector3.new(0, 0, 0), Vector3.new(0, 1.5, 0) }
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.IgnoreWater = true
pcall(function()
params.RespectCanCollide = true
end)
local function camera()
return workspace.CurrentCamera or at
end
local result = { state = nil, pick = nil, target = nil, stamp = 0 }
local lastScan = 0
local function refreshFilter(myChar)
local list = { myChar, camera() }
local debris = workspace:FindFirstChild("Debris")
if debris then
list[#list + 1] = debris
end
local characters = workspace:FindFirstChild("Characters")
if characters then
list[#list + 1] = characters
end
params.FilterDescendantsInstances = list
end
local function pickEnemy(origin)
local look = camera().CFrame.LookVector
local maxDist = tonumber(aC.peekAssistEnemy) or 200
local best, bestScore
for _, plr in ipairs(aa.entities()) do
if ET(plr) then
local char = F(plr, "HumanoidRootPart")
if char and not t(char) then
local delta = char.HumanoidRootPart.Position - origin
local dist = delta.Magnitude
if dist > 0.5 and dist <= maxDist then
local score = dist
if aC.peekAssistTarget == "Crosshair" then
score = math.acos(math.clamp(look:Dot(delta.Unit), -1, 1))
end
if not bestScore or score < bestScore then
best, bestScore = { player = plr, char = char, dist = dist }, score
end
end
end
end
end
return best
end
local function hittableFrom(origin, ctx)
local bestWalls, bestName
for _, name in ipairs(ctx.names) do
local part = ctx.enemy.char:FindFirstChild(name)
if part then
local delta = part.Position - origin
local len = delta.Magnitude
if len > 0.05 and len <= ctx.range then
local _, reached, walls = UT(origin, delta.Unit, ctx.range, ctx.pen, ctx.enemy.char)
if reached and (ctx.allowWalls or walls <= 0) then
if not bestWalls or walls < bestWalls then
bestWalls, bestName = walls, name
end
end
end
end
end
return bestWalls, bestName
end
local function sideScan(sign, ctx)
local axis = ctx.right * sign
local previousRoot = ctx.rootPos
for step = 1, ctx.steps do
local dist = step * STEP
local candidateRoot = ctx.rootPos + axis * dist
for _, offset in ipairs(PATH_HEIGHTS) do
if workspace:Raycast(previousRoot + offset, candidateRoot - previousRoot, params) then
return nil
end
end
local floor = workspace:Raycast(candidateRoot + Vector3.new(0, 1.5, 0), Vector3.new(0, -9, 0), params)
if not floor then
return nil
end
local drop = floor.Position.Y - ctx.groundY
if drop < -2.5 or drop > 1.6 then
return nil
end
local walls, name = hittableFrom(ctx.eye + axis * dist, ctx)
if walls then
return {
side = sign < 0 and "Left" or "Right",
dist = dist,
spot = Vector3.new(candidateRoot.X, floor.Position.Y, candidateRoot.Z),
walls = walls,
part = name,
}
end
previousRoot = candidateRoot
end
return nil
end
local function scan()
result.enemy, result.ctx = nil, nil
local myChar = _.Character
local root = myChar and myChar:FindFirstChild("HumanoidRootPart")
if not (root and myChar:GetAttribute("Dead") == false) then
result.state = nil
return
end
refreshFilter(myChar)
local eye = LT(true)
local enemy = pickEnemy(eye)
if not enemy then
result.state = nil
return
end
local held = p()
local props = type(held) == "table" and held.Properties
if not (type(props) == "table" and props.Class ~= "Melee") then
props = nil
end
local source = bi[aC.rageHitbox] or bi.Head
if aC.forceBody then
source = bi.Body
end
local names = {}
for index = 1, math.min(#source, MAX_HITBOXES) do
names[index] = source[index]
end
local ctx = {
enemy = enemy,
names = names,
range = props and props.Range or 500,
pen = uT(props),
allowWalls = aC.peekAssistMode == "Autowall",
eye = eye,
}
result.target, result.stamp = enemy.player, os.clock()
result.enemy, result.ctx = enemy, ctx
if hittableFrom(eye, ctx) then
result.state, result.pick = "CLEAR", nil
return
end
local look = camera().CFrame.LookVector
local flat = Vector3.new(look.X, 0, look.Z)
if flat.Magnitude < 0.05 then
result.state, result.pick = nil, nil
return
end
ctx.right = flat.Unit:Cross(UP)
ctx.rootPos = root.Position
local below = workspace:Raycast(ctx.rootPos, Vector3.new(0, -12, 0), params)
ctx.groundY = below and below.Position.Y or (ctx.rootPos.Y - 3)
ctx.steps = math.max(1, math.floor((tonumber(aC.peekAssistDist) or 8) / STEP))
local left, right = sideScan(-1, ctx), sideScan(1, ctx)
local pick
if left and right then
if left.walls ~= right.walls then
pick = left.walls < right.walls and left or right
else
pick = left.dist <= right.dist and left or right
end
else
pick = left or right
end
result.state, result.pick = pick and "PEEK" or "NO SPOT", pick
end
aa.peekAssistSide = function()
if aC.peekAssist and result.state == "PEEK" and result.pick and os.clock() - result.stamp < 0.5 then
return result.pick.side
end
return nil
end
aa.connect(O.Heartbeat, function()
if aa.unloaded or not aC.peekAssist then
result.state, result.pick = nil, nil
return
end
local now = os.clock()
if now - lastScan < SCAN_GAP then
return
end
lastScan = now
if not pcall(scan) then
result.state, result.pick = nil, nil
end
end)
local function shootEnemy()
local enemy, ctx = result.enemy, result.ctx
if not (enemy and ctx) or os.clock() - result.stamp > 0.35 or m() then
return
end
local weapon = p()
if type(weapon) ~= "table" or not weapon.Bullet or not weapon.Properties or weapon.Properties.Class == "Melee" then
return
end
if weapon.IsReloading then
return
end
if (weapon.Rounds or 0) <= 0 then
if aC.autoReload and aC.remoteReload then
yU(weapon)
end
return
end
if not (lU() and qU(weapon)) then
return
end
local char = enemy.char
if not (char and char.Parent) or t(char) then
return
end
local eye = LT(true)
if typeof(eye) ~= "Vector3" then
return
end
local fov = tonumber(aC.peekShootFov) or 360
if fov < 360 then
local delta = char.HumanoidRootPart.Position - eye
if delta.Magnitude > 0.05 then
local angle = math.deg(math.acos(math.clamp(camera().CFrame.LookVector:Dot(delta.Unit), -1, 1)))
if angle > fov / 2 then
return
end
end
end
local now = os.clock()
if now - bs < w(weapon) then
return
end
local shotCtx = setmetatable({ allowWalls = true }, { __index = ctx })
local walls, name = hittableFrom(eye, shotCtx)
if not walls and a7.server then
return
end
local part = char:FindFirstChild(name or ctx.names[1] or "Head")
if not part then
return
end
bs = now
xU(weapon, part, true)
end
aa.connect(O.Heartbeat, function()
if aa.unloaded or not (aC.peekAssist and aC.peekShoot) then
return
end
pcall(shootEnemy)
end)
local function richSafe(text)
return (tostring(text):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"))
end
local function makeDisc(parent, filled)
local discPart = Instance.new("Part")
discPart.Name = "PeekAssistDisc"
discPart.Anchored, discPart.CanCollide, discPart.CanQuery, discPart.CanTouch, discPart.CastShadow =
true, false, false, false, false
discPart.Transparency = 1
discPart.Size = Vector3.new(2, 0.05, 2)
discPart.Parent = parent
local gui = Instance.new("SurfaceGui")
gui.Face = Enum.NormalId.Top
gui.AlwaysOnTop = true
gui.LightInfluence = 0
gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
gui.PixelsPerStud = 40
gui.Adornee = discPart
gui.Enabled = false
gui.Parent = discPart
local frame = Instance.new("Frame")
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Position = UDim2.fromScale(0.5, 0.5)
frame.Size = UDim2.fromScale(1, 1)
frame.BackgroundTransparency = filled and 0.8 or 1
frame.BorderSizePixel = 0
frame.Parent = gui
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = frame
local stroke = Instance.new("UIStroke")
stroke.Thickness = filled and 1.5 or 4
stroke.Parent = frame
return { part = discPart, gui = gui, frame = frame, stroke = stroke }
end
local fx
local function buildFx()
local holder = Instance.new("Part")
holder.Name = "PeekAssist"
holder.Anchored, holder.CanCollide, holder.CanQuery, holder.CanTouch, holder.CastShadow =
true, false, false, false, false
holder.Transparency = 1
holder.Size = Vector3.new(0.2, 0.2, 0.2)
holder.Parent = aS
local board = Instance.new("BillboardGui")
board.Size = UDim2.fromOffset(200, 44)
board.AlwaysOnTop = true
board.LightInfluence = 0
board.StudsOffset = Vector3.new(0, 2.6, 0)
board.Adornee = holder
board.Enabled = false
board.Parent = holder
local pill = Instance.new("Frame")
pill.AnchorPoint = Vector2.new(0.5, 0.5)
pill.Position = UDim2.fromScale(0.5, 0.5)
pill.Size = UDim2.fromScale(1, 1)
pill.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
pill.BackgroundTransparency = 0.2
pill.BorderSizePixel = 0
pill.Parent = board
local pillCorner = Instance.new("UICorner")
pillCorner.CornerRadius = UDim.new(0, 10)
pillCorner.Parent = pill
local pillStroke = Instance.new("UIStroke")
pillStroke.Thickness = 1
pillStroke.Parent = pill
local label = Instance.new("TextLabel")
label.BackgroundTransparency = 1
label.Position = UDim2.fromOffset(10, 0)
label.Size = UDim2.new(1, -20, 1, 0)
label.Font = Enum.Font.GothamSemibold
label.TextSize = 12
label.RichText = true
label.TextXAlignment = Enum.TextXAlignment.Center
label.TextYAlignment = Enum.TextYAlignment.Center
label.TextColor3 = Color3.fromRGB(232, 232, 232)
label.TextTruncate = Enum.TextTruncate.AtEnd
label.Text = ""
label.Parent = pill
local lineHolder = Instance.new("Part")
lineHolder.Name = "PeekAssistLine"
lineHolder.Anchored, lineHolder.CanCollide, lineHolder.CanQuery, lineHolder.CanTouch, lineHolder.CastShadow =
true, false, false, false, false
lineHolder.Transparency = 1
lineHolder.Size = Vector3.new(0.2, 0.2, 0.2)
lineHolder.Parent = aS
local line = Instance.new("BoxHandleAdornment")
line.Adornee = lineHolder
line.AlwaysOnTop = true
line.ZIndex = 1
line.Size = Vector3.new(0.16, 0.06, 1)
line.Visible = false
line.Parent = lineHolder
return {
holder = holder,
board = board,
pill = pill,
pillStroke = pillStroke,
label = label,
lineHolder = lineHolder,
line = line,
ring = makeDisc(holder, false),
core = makeDisc(holder, true),
alpha = 0,
shown = false,
spot = nil,
textKey = nil,
}
end
local function setShown(on)
if not fx or fx.shown == on then
return
end
fx.shown = on
fx.board.Enabled = on
fx.ring.gui.Enabled = on
fx.core.gui.Enabled = on
fx.line.Visible = on and aC.peekAssistLine ~= false
end
aa.connect(O.RenderStepped, function(dt)
local pick = result.pick
local show = aC.peekAssist and result.state == "PEEK" and pick and os.clock() - result.stamp < 0.6
if not fx then
if not show then
return
end
fx = buildFx()
end
fx.alpha = fx.alpha + ((show and 1 or 0) - fx.alpha) * math.min(1, dt * 12)
if not show then
if fx.alpha < 0.02 then
setShown(false)
return
end
pick = fx.lastPick
if not pick then
setShown(false)
return
end
else
fx.lastPick = pick
setShown(true)
end
local alpha = fx.alpha
local tint = aC.peekAssistColor
if typeof(tint) ~= "Color3" then
tint = Color3.fromRGB(90, 255, 170)
end
local now = os.clock()
if fx.spot and (fx.spot - pick.spot).Magnitude < 6 then
fx.spot = fx.spot:Lerp(pick.spot, math.min(1, dt * 16))
else
fx.spot = pick.spot
end
local floorSpot = fx.spot + Vector3.new(0, 0.08, 0)
fx.holder.CFrame = CFrame.new(floorSpot)
local pulse = 0.5 + 0.5 * math.sin(now * 5)
local ringSize = 2.6 + pulse * 0.6
fx.ring.part.Size = Vector3.new(ringSize, 0.05, ringSize)
fx.ring.part.CFrame = CFrame.new(floorSpot)
fx.ring.stroke.Color = tint
fx.ring.stroke.Transparency = 1 - alpha * 0.95
local coreSize = 1.1 + pulse * 0.25
fx.core.part.Size = Vector3.new(coreSize, 0.05, coreSize)
fx.core.part.CFrame = CFrame.new(floorSpot)
fx.core.frame.BackgroundColor3 = tint
fx.core.frame.BackgroundTransparency = 1 - alpha * 0.55
fx.core.stroke.Color = tint
fx.core.stroke.Transparency = 1 - alpha * 0.9
local myChar = _.Character
local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
local lineOn = aC.peekAssistLine ~= false and myRoot ~= nil
if fx.shown then
fx.line.Visible = lineOn
end
if lineOn then
local from = Vector3.new(myRoot.Position.X, floorSpot.Y, myRoot.Position.Z)
local length = (floorSpot - from).Magnitude
if length > 0.1 then
fx.lineHolder.CFrame = CFrame.lookAt((from + floorSpot) / 2, floorSpot)
fx.line.Size = Vector3.new(0.16, 0.06, length)
fx.line.Color3 = tint
fx.line.Transparency = 0.45 + 0.55 * (1 - alpha)
else
fx.line.Visible = false
end
end
fx.pill.BackgroundTransparency = 1 - alpha * 0.8
fx.pillStroke.Color = tint
fx.pillStroke.Transparency = 1 - alpha * 0.8
fx.label.TextTransparency = 1 - alpha
local meters = math.floor(pick.dist * 0.28 * 10 + 0.5) / 10
local targetName = result.target and result.target.Name or "?"
local key = pick.side .. "|" .. meters .. "|" .. tostring(pick.part) .. "|" .. pick.walls .. "|" .. targetName
if fx.textKey ~= key then
fx.textKey = key
local tintHex = string.format(
"#%02X%02X%02X",
math.floor(tint.R * 255 + 0.5),
math.floor(tint.G * 255 + 0.5),
math.floor(tint.B * 255 + 0.5)
)
local arrow = pick.side == "Left" and "&lt;&lt;" or "&gt;&gt;"
local status = pick.walls > 0
and string.format('<font color="#FFB347">WALLBANG x%d</font>', pick.walls)
or '<font color="#5CFF8A">CLEAN LINE</font>'
fx.label.Text = string.format(
'<b><font color="%s">PEEK %s %s</font></b>  <font color="#E8E8E8">%.1fm</font>\n<font color="#A8AEB8">%s · %s</font>  %s',
tintHex,
string.upper(pick.side),
arrow,
meters,
richSafe(targetName),
richSafe(pick.part or "?"),
status
)
end
end)
end
end
do
local bi = 0
aa.connect(O.Heartbeat, function()
if not aC.rapidFire or m() then
return
end
local bj = p()
if not bj or not bj.Bullet or not bj.Properties then
return
end
local bk, bl = bj.IsFireHeld == true, aC.rage and (aC.rageAutoFire and (bf ~= nil and not aC.rageRemote))
if not (bk or bl) or (bj.Rounds or 0) <= 0 or bj.IsReloading then
return
end
local bm = aC.rapidUnlimited and 0 or tT(bj) / math.max(aC.rapidMult, 1)
if os.clock() - bi < bm then
return
end
if bj.ShootDelayThread then
pcall(task.cancel, bj.ShootDelayThread)
end
bj.ShootDelayThread = nil
bj.IsShooting = false
bj.NextShotDue = 0
bi = os.clock()
vU(bk, bj)
end)
end
do
local bi, bj = require(L.Classes.WeaponComponent.Classes.Viewmodel.Classes.Animation), nil
bj = Q(bi.play, function(bk, bl, ...)
local bm = bj(bk, bl, ...)
if not aa.unloaded and (aC.instaReload and (bm and (type(bl) == "string" and bl:find("^Reload")))) then
pcall(function()
bm:AdjustSpeed(aC.reloadSpeed)
end)
end
return bm
end)
aa.connect(O.Heartbeat, function()
if not aC.autoReload then
return
end
local bk = p()
local bl = bk and (bk.Capacity or 0) > 0 or workspace:GetAttribute("Gamemode") == "Deathmatch"
if
bk
and (
bk.Bullet
and (
bk.Properties
and (
(bk.Rounds or 0) <= aC.reloadAt
and (
bl
and (
(bk.Rounds or 0) < (bk.Properties.Rounds or 0)
and (not bk.IsReloading and not bk.IsShooting)
)
)
)
)
)
then
if aC.remoteReload then
yU(bk)
else
task.spawn(pcall, bk.reload, bk)
end
end
end)
end
do
local bi, bj = require(L.Components.Weapon.Classes.Bullet), nil
bj = Q(bi.getTrueSpread, function(bk, ...)
if not aa.unloaded and (aC.noSpread or bg ~= nil or aC.rage) then
return 0
end
return bj(bk, ...)
end)
end
do
local bi = a2.Inventory and a2.Inventory.ShootWeapon
if bi and type(bi.Send) == "function" then
local bj
bj = Q(bi.Send, function(bk, ...)
if aa.unloaded or type(bk) ~= "table" or type(bk.Bullets) ~= "table" then
return bj(bk, ...)
end
if bk.__nightcc then
local bl = bk.__nightcc
bk.__nightcc = nil
pcall(function()
local bm = p()
local bn = bm and (bm.Properties and bm.Properties.Range) or 500
for bo, bp in ipairs(bk.Bullets) do
JT(bp.Origin, bp.Direction, bp.Hits or type(bl) == "table" and bl[bo] or {}, bn)
end
end)
return bj(bk, ...)
end
do
local bl = bk.Bullets[1]
if type(bl) == "table" then
local bm = bl.Hits == nil
if bm ~= a7.server then
a7.setServerHits(bm)
end
end
end
pcall(function()
local bl = p()
local bm = bl and bl.Properties or {}
local bn, bo, bp = bm.Range or 500, uT(bm), bg
if not bp and aC.silentAim then
bp = aT()
end
local bq, br = U(), bp ~= nil or aH.active
for bs, bt in ipairs(bk.Bullets) do
local bu
if br then
local bv = not a7.server and (bp ~= nil and (bp == bg and bh)) or nil
local bw, bx, by =
(bp ~= nil and bp == bg) and (not bv and EU(bp) or LT()) or bq.Position, nil, nil
if bv then
bx = (bv - bw).Unit
by = jT(bw, bv, bp, bn, bo, aC.wallbang) or {}
else
bx = bp and (aimPos(bp) - bw).Unit or bq.LookVector
by = DT(bw, bx, bn, bo, bp, aC.wallbang and bp ~= nil)
end
bt.Origin, bt.Direction = bw, bx
if a7.server then
bu = by
else
bt.Hits = kT(bw, by)
end
elseif a7.server then
if
typeof(bt.Origin) == "Vector3"
and (typeof(bt.Direction) == "Vector3" and bt.Direction.Magnitude > 0)
then
bu = DT(bt.Origin, bt.Direction.Unit, bn, bo, nil, false)
end
elseif
aC.penMod
and (
typeof(bt.Origin) == "Vector3"
and (typeof(bt.Direction) == "Vector3" and bt.Direction.Magnitude > 0)
)
then
bt.Hits = kT(bt.Origin, DT(bt.Origin, bt.Direction.Unit, bn, bo, nil, false))
end
if bt.Origin and bt.Direction then
JT(bt.Origin, bt.Direction, bu or bt.Hits or {}, bn)
end
end
end)
return bj(bk, ...)
end)
end
end
do
local bi = Instance.new("Folder")
bi.Name = "NightCCESP"
bi.Parent = aL
local bj = Instance.new("Frame")
bj.Name = "ESP2D"
bj.Size = UDim2.fromScale(1, 1)
bj.BackgroundTransparency = 1
bj.Parent = aL
local bk, bl, bm, bn, bo, bp =
{},
Color3.new(0, 0, 0),
Color3.fromRGB(90, 255, 110),
Color3.fromRGB(255, 60, 60),
Color3.fromRGB(90, 170, 255),
{
{
"Head",
"UpperTorso",
},
{
"UpperTorso",
"LowerTorso",
},
{
"UpperTorso",
"LeftUpperArm",
},
{
"LeftUpperArm",
"LeftLowerArm",
},
{
"LeftLowerArm",
"LeftHand",
},
{
"UpperTorso",
"RightUpperArm",
},
{
"RightUpperArm",
"RightLowerArm",
},
{
"RightLowerArm",
"RightHand",
},
{
"LowerTorso",
"LeftUpperLeg",
},
{
"LeftUpperLeg",
"LeftLowerLeg",
},
{
"LeftLowerLeg",
"LeftFoot",
},
{
"LowerTorso",
"RightUpperLeg",
},
{
"RightUpperLeg",
"RightLowerLeg",
},
{
"RightLowerLeg",
"RightFoot",
},
}
local function q(bq, br, bs)
local bt = Instance.new("Frame")
bt.BorderSizePixel = 0
bt.BackgroundColor3 = bs or bl
bt.Visible = false
bt.ZIndex = br
bt.Parent = bq
return bt
end
local function v(bq, br)
local bs = q(bq, br)
bs.AnchorPoint = Vector2.new(0.5, 0.5)
return bs
end
local function K(bq)
local br = Instance.new("TextLabel")
br.BackgroundTransparency = 1
br.Font = Enum.Font.GothamSemibold
br.TextStrokeTransparency = 0.35
br.TextStrokeColor3 = bl
br.AnchorPoint = Vector2.new(0.5, 0)
br.Visible = false
br.ZIndex = 4
br.Parent = bq
return br
end
local function N(bq, br, bs, bt, bu)
bq.Position = UDim2.fromOffset(br, bs)
bq.Size = UDim2.fromOffset(bt, bu)
bq.Visible = true
end
local function gr(bq, br, bs, bt, bu)
local bv = bq:FindFirstChildOfClass("UIGradient")
if br then
if not bv then
bv = Instance.new("UIGradient")
bv.Parent = bq
end
bv.Rotation = bu or 0
bv.Color = ColorSequence.new(bs, bt)
bq.TextStrokeTransparency = 1
else
if bv then
bv:Destroy()
end
bq.TextStrokeTransparency = 0.35
end
end
local function c(bq, br, bs, bt, bu, bv, bw)
local bx, by = bt - br, bu - bs
bq.Position = UDim2.fromOffset((br + bt) / 2, (bs + bu) / 2)
bq.Size = UDim2.fromOffset(math.sqrt(bx * bx + by * by), bv)
bq.Rotation = math.deg(math.atan2(by, bx))
bq.BackgroundColor3 = bw
bq.Visible = true
end
local chamsApply, chamsRestore, chamsCleanup
do
local chamsSet = {
Head = true,
UpperTorso = true,
LowerTorso = true,
LeftUpperArm = true,
LeftLowerArm = true,
LeftHand = true,
RightUpperArm = true,
RightLowerArm = true,
RightHand = true,
LeftUpperLeg = true,
LeftLowerLeg = true,
LeftFoot = true,
RightUpperLeg = true,
RightLowerLeg = true,
RightFoot = true,
Torso = true,
["Left Arm"] = true,
["Right Arm"] = true,
["Left Leg"] = true,
["Right Leg"] = true,
}
local chamsMul = {
UpperTorso = Vector3.new(1, 1.04, 1),
LowerTorso = Vector3.new(0.95, 1.5, 1),
Torso = Vector3.one,
}
local chamsWhite, chamsFolder, chamsAdornee, chamsInv, chamsShade, chamsCull, chamsGen =
Color3.new(1, 1, 1), nil, nil, nil, nil, nil, 0
if type(setfflag) == "function" then
pcall(setfflag, "AdornShadingAPI", "True")
end
pcall(function()
chamsShade = Enum.AdornShading.XRay
end)
pcall(function()
chamsCull = Enum.AdornCullingMode.Never
end)
local function chamsMeshScale(bq)
local br = bq:FindFirstChildOfClass("SpecialMesh")
if br then
local bs = br.Scale
if typeof(bs) == "Vector3" then
return bs
end
end
return nil
end
local function chamsBase(bq, br)
local bs = bq.Size
if bq.Name == "Head" then
local bt = chamsMeshScale(bq)
local bu = bt and bs * bt or bs
return br ~= 1 and bu * br or bu
end
local bt = chamsMeshScale(bq)
if bt then
return bs * bt
end
local bu = chamsMul[bq.Name]
if bu then
return bs * bu
end
local bv, bw, bx = bs.X, bs.Y, bs.Z
if bw >= bv and bw >= bx then
return Vector3.new(bv, bw * 1.08, bx)
elseif bv >= bw and bv >= bx then
return Vector3.new(bv * 1.08, bw, bx)
end
return Vector3.new(bv, bw, bx * 1.08)
end
local function chamsIsPart(bq, br)
if not bq or bq.Parent ~= br then
return false
end
if not chamsSet[bq.Name] or not bq:IsA("BasePart") then
return false
end
local bs = bq.Size
return bs.X > 0.05 and bs.Y > 0.05 and bs.Z > 0.05
end
local function chamsTarget()
local bq = workspace.CurrentCamera or at
if not bq then
return nil
end
if not chamsFolder or chamsFolder.Parent == nil then
chamsGen = chamsGen + 1
chamsFolder = Instance.new("Folder")
chamsFolder.Name = "nightccChams"
chamsFolder.Parent = bq
chamsAdornee = Instance.new("Part")
chamsAdornee.Size = Vector3.one
chamsAdornee.Anchored = true
chamsAdornee.CanCollide = false
chamsAdornee.CanQuery = false
chamsAdornee.CanTouch = false
chamsAdornee.CastShadow = false
chamsAdornee.Massless = true
chamsAdornee.Locked = true
chamsAdornee.Transparency = 1
chamsAdornee.Parent = chamsFolder
elseif chamsFolder.Parent ~= bq then
chamsFolder.Parent = bq
end
local br = bq.CFrame
chamsAdornee.CFrame = br
chamsInv = br:Inverse()
return bq
end
local function chamsBox(bq)
local br = Instance.new("BoxHandleAdornment")
br.Adornee = chamsAdornee
br.Transparency = 0
br.ZIndex = bq
br.Visible = false
if chamsShade then
pcall(function()
br.Shading = chamsShade
end)
end
if chamsCull then
pcall(function()
br.AdornCullingMode = chamsCull
end)
end
br.Parent = chamsFolder
return br
end
local function chamsDrop(bq, br)
local bs = bq.chams and bq.chams.slots[br]
if not bs then
return
end
bq.chams.slots[br] = nil
if bs.glow then
pcall(function()
bs.glow:Destroy()
end)
end
if bs.fill then
pcall(function()
bs.fill:Destroy()
end)
end
end
local function chamsAdd(bq, br)
local bs = bq.chams
if bs.slots[br] or not chamsIsPart(br, bs.charRef) then
return
end
local bt = {
glow = nil,
fill = nil,
base = chamsBase(br, bs.headTrim),
size = br.Size,
}
if bs.armed then
local bu, bv = chamsBox(0), chamsBox(1)
bu.Color3, bv.Color3 = bs.glowCol or chamsWhite, bs.fillCol or chamsWhite
bu.Visible, bv.Visible = bs.shown, bs.shown
bt.glow, bt.fill = bu, bv
bs.fade = nil
end
bs.parts[#bs.parts + 1] = br
bs.slots[br] = bt
end
local function chamsArm(bq)
local br = bq.chams
if br.armed then
return
end
br.armed = true
local bs, bt = br.parts, br.slots
local bu, bv = br.fillCol or chamsWhite, br.glowCol or chamsWhite
for bw = 1, #bs, 1 do
local bx = bt[bs[bw]]
if bx and not bx.fill then
local by, bz = chamsBox(0), chamsBox(1)
by.Color3, bz.Color3 = bv, bu
by.Visible, bz.Visible = false, false
bx.glow, bx.fill = by, bz
end
end
end
local function chamsClear(bq)
local br = bq.chams
if not br then
return
end
for bs = #br.links, 1, -1 do
pcall(function()
br.links[bs]:Disconnect()
end)
br.links[bs] = nil
end
for bs = #br.parts, 1, -1 do
chamsDrop(bq, br.parts[bs])
br.parts[bs] = nil
end
table.clear(br.slots)
br.charRef = nil
br.shown = false
br.armed = false
br.fade = nil
end
local function chamsBind(bq, br, bs)
chamsClear(bq)
if not br or not br.Parent then
return
end
local bt = bq.chams
bt.charRef = br
bt.headTrim = bs
local bu = br:GetChildren()
for bv = 1, #bu, 1 do
chamsAdd(bq, bu[bv])
end
bt.links[#bt.links + 1] = br.ChildAdded:Connect(function(bw)
if bq.chams and bq.chams.charRef == br then
chamsAdd(bq, bw)
end
end)
bt.links[#bt.links + 1] = br.ChildRemoved:Connect(function(bw)
if bq.chams and bq.chams.charRef == br then
chamsDrop(bq, bw)
end
end)
end
local function chamsScan(bq)
local br = bq.chams
if not br.charRef then
return
end
local bs, bt, bu = br.parts, br.slots, 0
for bv = 1, #bs, 1 do
local bw = bs[bv]
local bx = bw and bt[bw]
if bw then
if bw.Parent then
if bx then
local by = bu + 1
bs[by] = bw
local bz = bw.Size
if bx.size ~= bz then
bx.size = bz
bx.base = chamsBase(bw, br.headTrim)
end
bu = by
else
chamsDrop(bq, bw)
end
else
chamsDrop(bq, bw)
end
end
end
for bv = #bs, bu + 1, -1 do
bs[bv] = nil
end
end
local function chamsShow(bq, br)
local bs = bq.chams
bs.shown = br
for bt = 1, #bs.parts, 1 do
local bu = bs.slots[bs.parts[bt]]
if bu and bu.fill then
bu.glow.Visible = br
bu.fill.Visible = br
end
end
end
local function chamsColor(bq, br, bs)
local bt = bq.chams
bt.fillCol, bt.glowCol = br, bs
for bu = 1, #bt.parts, 1 do
local bv = bt.slots[bt.parts[bu]]
if bv and bv.fill then
bv.fill.Color3 = br
bv.glow.Color3 = bs
end
end
end
local function chamsUpdate(bq, br, bs, bw)
if not (aC.espChams and not bs.dormant and bq ~= _ and br and br.Parent) then
chamsRestore(bs)
return
end
if not chamsTarget() then
chamsRestore(bs)
return
end
local bt = bs.chams
if not bt then
bt = {
parts = {},
slots = setmetatable({}, {
__mode = "k",
}),
links = {},
charRef = nil,
shown = false,
armed = false,
fillCol = nil,
glowCol = nil,
headTrim = 1,
scanAt = 0,
gen = chamsGen,
}
bs.chams = bt
end
if bt.gen ~= chamsGen then
chamsClear(bs)
bt.gen = chamsGen
end
if bt.charRef ~= br then
local bu = bq:GetAttribute("Team")
chamsBind(bs, br, (bu == "Counter-Terrorists" or bu == "CT") and 0.88 or 1)
end
if bw - (bt.scanAt or 0) >= 0.5 then
bt.scanAt = bw
chamsScan(bs)
end
local bu = false
for bv = 1, #bt.parts, 1 do
local bx = bt.parts[bv]
if bx and bx.Parent then
bu = true
break
end
end
if not bu then
if bt.shown then
chamsShow(bs, false)
end
return
end
if not bt.armed then
chamsArm(bs)
end
if not bt.shown and aC.espChamsStyle ~= "ForceField" then
chamsShow(bs, true)
end
local bv = aC.espChamsColor or Color3.fromRGB(255, 60, 60)
local bx = math.max(tonumber(aC.espChamsGlow) or 4, 1)
local by = Color3.new(bv.R * bx, bv.G * bx, bv.B * bx)
if bt.fillCol ~= bv or bt.glowCol ~= by then
chamsColor(bs, bv, by)
end
do
local style = tostring(aC.espChamsStyle or "Mesh")
local ffDue = bt.ffStyle ~= style or bt.ffColor ~= bv or bw - (bt.ffAt or 0) >= 0.5
if ffDue then bt.ffStyle, bt.ffColor, bt.ffAt = style, bv, bw end
if style == "ForceField" or style == "Both" then
if ffDue then for _, part in ipairs(br:GetDescendants()) do
if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
if not part:GetAttribute("NightESP_FF") then
part:SetAttribute("NightESP_FF", part.Material.Name)
pcall(function()
part:SetAttribute("NightESP_FFC", part.Color:ToHex())
end)
end
pcall(function()
part.Material = Enum.Material.ForceField
part.Color = bv
end)
end
end end
if style == "ForceField" and bt.shown then
chamsShow(bs, false)
end
else
if ffDue then for _, part in ipairs(br:GetDescendants()) do
if part:IsA("BasePart") and part:GetAttribute("NightESP_FF") then
local m = part:GetAttribute("NightESP_FF")
pcall(function()
if m and Enum.Material[m] then
part.Material = Enum.Material[m]
end
end)
part:SetAttribute("NightESP_FF", nil)
part:SetAttribute("NightESP_FFC", nil)
end
end end
end
end
local bz = math.clamp(1 - bs.alpha, 0, 1)
if bt.fade ~= bz then
bt.fade = bz
for bA = 1, #bt.parts, 1 do
local bB = bt.slots[bt.parts[bA]]
if bB and bB.fill then
bB.fill.Transparency = bz
bB.glow.Transparency = bz
end
end
end
if not chamsInv then
return
end
for bA = 1, #bt.parts, 1 do
local bB = bt.parts[bA]
local bC = bB and bt.slots[bB]
if bC and bB.Parent then
local bD = chamsInv * bB.CFrame
local bE = bD.Position
local bF = math.min(0.6 / math.max(bE.Magnitude, 0.001), 1)
local bG = CFrame.new(bE * bF) * (bD - bE)
local bH = (bC.base * bF):Max(Vector3.new(0.004, 0.004, 0.004))
bC.fill.CFrame = bG
bC.fill.Size = bH
bC.glow.CFrame = bG
bC.glow.Size = bH * 1.12
end
end
end
chamsApply = chamsUpdate
chamsRestore = function(bq)
if bq.chams and bq.chams.charRef then
local char = bq.chams.charRef
pcall(function()
for _, part in ipairs(char:GetDescendants()) do
if part:IsA("BasePart") and part:GetAttribute("NightESP_FF") then
local m = part:GetAttribute("NightESP_FF")
pcall(function()
if m and Enum.Material[m] then
part.Material = Enum.Material[m]
end
end)
part:SetAttribute("NightESP_FF", nil)
part:SetAttribute("NightESP_FFC", nil)
end
end
end)
end
if not bq.chams then
return
end
chamsClear(bq)
bq.chams = nil
end
chamsCleanup = function()
if chamsFolder then
chamsFolder:Destroy()
chamsFolder, chamsAdornee = nil, nil
end
end
end
local function C(bq)
local br = bk[bq]
if br then
chamsRestore(br)
br.highlight:Destroy()
br.root:Destroy()
br.outer:Destroy()
bk[bq] = nil
end
end
local function Q()
for bq in pairs(bk) do
C(bq)
end
chamsCleanup()
end
local function b(bq, br)
C(bq)
local bs = Instance.new("Highlight")
bs.OutlineTransparency = 0
bs.Adornee = br
bs.Parent = bi
local bt = Instance.new("Frame")
bt.Size = UDim2.fromScale(1, 1)
bt.BackgroundTransparency = 1
bt.Visible = false
bt.Parent = bj
local bu = Instance.new("Frame")
bu.Size = UDim2.fromScale(1, 1)
bu.BackgroundTransparency = 1
bu.Parent = bj
local bv = {
highlight = bs,
root = bt,
outer = bu,
char = br,
vis = false,
visAt = 0,
}
bv.fill = q(bt, 1)
bv.fill.BackgroundTransparency = 0.82
bv.boxOut, bv.box = {}, {}
for bw = 1, 8, 1 do
bv.boxOut[bw] = q(bt, 2)
bv.box[bw] = q(bt, 3)
end
bv.hpBack, bv.hpBar = q(bt, 2), q(bt, 3)
bv.arBack, bv.arBar = q(bt, 2), q(bt, 3, bo)
bv.hpText = K(bt)
bv.hpText.AnchorPoint = Vector2.new(1, 0.5)
bv.name, bv.weapon, bv.dist = K(bt), K(bt), K(bt)
bv.flags = K(bt)
bv.flags.AnchorPoint = Vector2.new(0, 0)
bv.flags.RichText = true
bv.flags.TextXAlignment = Enum.TextXAlignment.Left
bv.flags.TextYAlignment = Enum.TextYAlignment.Top
bv.bones = {}
for bw = 1, #bp, 1 do
bv.bones[bw] = v(bt, 2)
end
bv.headDot = q(bt, 3)
bv.headDot.AnchorPoint = Vector2.new(0.5, 0.5)
bv.headDot.BackgroundTransparency = 1
(Instance.new("UICorner", bv.headDot)).CornerRadius = UDim.new(1, 0)
bv.headStroke = Instance.new("UIStroke", bv.headDot)
bv.headStroke.Thickness = 1
bv.snapOut, bv.snap = v(bu, 1), v(bu, 2)
bv.arrow = {
v(bu, 3),
v(bu, 3),
}
local bw = {}
local function N(bx, by, bz)
bw[#bw + 1] = { bx, by, bz }
end
N(bv.fill, "BackgroundTransparency", 0.82)
for bx = 1, 8, 1 do
N(bv.boxOut[bx], "BackgroundTransparency", 0)
N(bv.box[bx], "BackgroundTransparency", 0)
end
for bx, by in ipairs({
bv.hpBack,
bv.hpBar,
bv.arBack,
bv.arBar,
bv.snap,
bv.arrow[1],
bv.arrow[2],
}) do
N(by, "BackgroundTransparency", by == bv.hpBack and 0.35 or 0)
end
N(bv.snapOut, "BackgroundTransparency", 0.5)
for bx, by in ipairs({
bv.hpText,
bv.name,
bv.weapon,
bv.dist,
bv.flags,
}) do
N(by, "TextTransparency", 0)
N(by, "TextStrokeTransparency", 0.35)
end
for bx, by in ipairs(bv.bones) do
N(by, "BackgroundTransparency", 0)
end
N(bv.headStroke, "Transparency", 0)
bv.fade, bv.alpha, bv.fadeApplied = bw, 0, -1
bk[bq] = bv
return bv
end
local function a(bq)
local br = 1 - bq.alpha
if br == bq.fadeApplied then
return
end
bq.fadeApplied = br
for bs, bt in ipairs(bq.fade) do
bt[1][bt[2]] = bt[3] + (1 - bt[3]) * br
end
end
aa.connect(u.PlayerRemoving, C)
aa.onUnload(Q)
local function T(bq, br)
local bs = bq:GetAttribute("CurrentEquipped")
if bs ~= br.eqRaw then
br.eqRaw = bs
local bt, bu = pcall(ar.JSONDecode, ar, type(bs) == "string" and bs or "")
br.eqName = (bt and (type(bu) == "table" and type(bu.Name) == "string")) and bu.Name or nil
end
return br.eqName
end
local function w(bq, br)
local bs = bq:GetAttribute("Armor")
if bs ~= br.arRaw then
br.arRaw = bs
local bt, bu = pcall(ar.JSONDecode, ar, type(bs) == "string" and bs or "")
br.arValue = bt and (type(bu) == "table" and tonumber(bu.Health)) or 0
br.arHelmet = bt and (type(bu) == "table" and (type(bu.Type) == "string" and bu.Type:find("Helmet") ~= nil))
end
return br.arValue or 0
end
local function e(bq, br, bs, bt, bu, bv)
local style = aC.espBoxStyle
local thick = math.clamp(math.floor(aC.espBoxThickness or 1), 1, 6)
local cap = math.max(math.floor(bu * 0.05), 1)
local segs
if style == "Static" or style == "Full" then
if style == "Full" then
thick = math.max(math.min(thick, cap), math.min(2, cap))
else
thick = math.min(thick, cap)
end
segs = {
{
br,
bs,
bt,
thick,
},
{
br,
(bs + bu) - thick,
bt,
thick,
},
{
br,
bs,
thick,
bu,
},
{
(br + bt) - thick,
bs,
thick,
bu,
},
}
else
thick = math.min(thick, cap)
local bw, bh = math.ceil(bt * 0.25), math.ceil(bu * 0.25)
segs = {
{
br,
bs,
bw,
thick,
},
{
br,
bs,
thick,
bh,
},
{
(br + bt) - bw,
bs,
bw,
thick,
},
{
(br + bt) - thick,
bs,
thick,
bh,
},
{
br,
(bs + bu) - thick,
bw,
thick,
},
{
br,
(bs + bu) - bh,
thick,
bh,
},
{
(br + bt) - bw,
(bs + bu) - thick,
bw,
thick,
},
{
(br + bt) - thick,
(bs + bu) - bh,
thick,
bh,
},
}
end
local grad = aC.espBoxGrad
local colA = grad and (aC.espBoxGradColor or bv) or bv
local colB = grad and (aC.espBoxGradColor2 or colA) or colA
local span = math.max(bu, 1)
local function colAt(bw)
return colA:Lerp(colB, math.clamp((bw - bs) / span, 0, 1))
end
for bw = 1, 8, 1 do
local bx = segs[bw]
local by, bz = bq.boxOut[bw], bq.box[bw]
if bx then
if aC.espBoxOutline then
N(by, bx[1] - 1, bx[2] - 1, bx[3] + 2, bx[4] + 2)
by.BackgroundColor3 = aC.espBoxOutlineColor or bl
by.BackgroundTransparency = 0
else
by.Visible = false
end
N(bz, bx[1], bx[2], bx[3], bx[4])
bz.BackgroundColor3 = colAt(bx[2] + bx[4] / 2)
bz.BackgroundTransparency = 0
local bA = bz:FindFirstChildOfClass("UIGradient")
if grad and bx[4] > bx[3] then
if not bA then
bA = Instance.new("UIGradient")
bA.Rotation = 90
bA.Parent = bz
end
bA.Color = ColorSequence.new(colAt(bx[2]), colAt(bx[2] + bx[4]))
else
if bA then
bA:Destroy()
end
bz.BackgroundColor3 = colAt(bx[2] + bx[4] / 2)
end
else
by.Visible, bz.Visible = false, false
end
end
end
local function o(bq, br, bs, bt, bu, bv, bw)
local cam = workspace.CurrentCamera or at
local bx = br.Head
local by = br:FindFirstChild("HumanoidRootPart") or bx
local bz, bA = bx.Position, by.Position
local bB = (bz - bu).Magnitude
if bB > aC.espMaxDist and aC.espMaxDist < 3000 then
chamsRestore(bs)
bs.root.Visible, bs.outer.Visible, bs.highlight.Enabled = false, false, false
return
end
if aC.espVisCheck and (not bt and not bs.dormant) then
if bw - bs.visAt > 0.12 then
bs.visAt = bw
aU.FilterDescendantsInstances = {
_.Character,
cam,
}
local bC = workspace:Raycast(bu, bz - bu, aU)
bs.vis = bC == nil or bC.Instance:IsDescendantOf(br)
end
else
bs.vis = false
end
local bC
if aC.espColorMode == "Team Side" then
local bD = bq:GetAttribute("Team")
bC = bD == "Terrorists" and aC.espTColor
or bD == "Counter-Terrorists" and aC.espCTColor
or bt and aC.espTeamColor
or aC.espEnemyColor
elseif aC.espColorMode == "Player Color" then
local bD = bq:GetAttribute("CompetitivePlayerColor")
bC = typeof(bD) == "Color3" and bD or bt and aC.espTeamColor or aC.espEnemyColor
else
bC = bt and aC.espTeamColor or aC.espEnemyColor
end
if bs.vis then
bC = aC.espVisColor
end
if bs.dormant then
bC = Color3.fromRGB(150, 150, 160)
end
chamsApply(bq, br, bs, bw)
bs.highlight.Enabled = false
local bI, bJ, bK = bA.Y - 3, br:FindFirstChild("LeftFoot"), br:FindFirstChild("RightFoot")
if bJ and bK then
bI = math.min(bJ.Position.Y, bK.Position.Y) - bJ.Size.Y / 2
end
local bL, bM =
cam:WorldToViewportPoint(Vector3.new(bA.X, (bz.Y + bx.Size.Y / 2) + 0.25, bA.Z)),
cam:WorldToViewportPoint(Vector3.new(bA.X, bI, bA.Z))
local bN = bM.Y - bL.Y
local bO, bP = bN * 0.52, (bL.X + bM.X) / 2
local bQ = bL.Z > 0
and (bM.Z > 0 and (bN > 2 and (bP + bO / 2 > 0 and (bP - bO / 2 < bv.X and (bM.Y > 0 and bL.Y < bv.Y)))))
bs.outer.Visible = true
local bR = aC.espArrows and not bQ
bs.arrow[1].Visible, bs.arrow[2].Visible = bR, bR
if bR then
local bS = cam.CFrame:PointToObjectSpace(bA)
local bU, bV = bS.X, -bS.Y
local bW = math.sqrt(bU * bU + bV * bV)
if bW < 0.001 then
bU, bV, bW = 0, 1, 1
end
local bX = math.atan2(bV / bW, bU / bW)
local bY, bZ = bv.X / 2 + math.cos(bX) * aC.espArrowRadius, bv.Y / 2 + math.sin(bX) * aC.espArrowRadius
for b_ = 1, 2, 1 do
local b0 = (bX + math.pi) + (b_ == 1 and 0.5 or -0.5)
c(bs.arrow[b_], bY, bZ, bY + math.cos(b0) * aC.espArrowSize, bZ + math.sin(b0) * aC.espArrowSize, 2, bC)
end
end
local bS = aC.espSnap and bQ
bs.snap.Visible, bs.snapOut.Visible = bS, bS
if bS then
local bU = aC.espSnapFrom == "Top" and 0 or aC.espSnapFrom == "Center" and bv.Y / 2 or bv.Y
c(bs.snapOut, bv.X / 2, bU, bP, bM.Y, 3, bl)
bs.snapOut.BackgroundTransparency = 0.5
c(bs.snap, bv.X / 2, bU, bP, bM.Y, 1, bC)
end
bs.root.Visible = bQ
if not bQ then
return
end
local bU, bV = math.floor(bP - bO / 2), math.floor(bL.Y)
bO, bN = math.floor(bO), math.floor(bN)
local near = math.clamp(bN / 120, 0.55, 1.15)
local readable = bN >= 7
if aC.espBox then
e(bs, bU, bV, bO, bN, bC)
else
for bW = 1, 8, 1 do
bs.boxOut[bW].Visible, bs.box[bW].Visible = false, false
end
end
bs.fill.Visible = aC.espBoxFill
if aC.espBoxFill then
N(bs.fill, bU, bV, bO, bN)
bs.fill.BackgroundColor3 = bC
bs.fill.BackgroundTransparency = math.clamp(tonumber(aC.espFill) or 0.6, 0, 1)
local bX = bs.fill:FindFirstChildOfClass("UIGradient")
if aC.espFillGrad then
if not bX then
bX = Instance.new("UIGradient")
bX.Rotation = 90
bX.Parent = bs.fill
end
local fg1, fg2 = aC.espFillGradColor or bC, aC.espFillGradColor2 or aC.espFillGradColor or bC
if bs.fgC1 ~= fg1 or bs.fgC2 ~= fg2 or bs.fgInst ~= bX then
bs.fgC1, bs.fgC2, bs.fgInst = fg1, fg2, bX
bX.Color = ColorSequence.new(fg1, fg2)
end
elseif bX then
bX:Destroy()
end
end
local bW = math.clamp(tonumber(br:GetAttribute("Health")) or 100, 0, 100)
local hbSide = aC.espHealthSide == "Right"
local hbW = math.clamp(math.min(math.floor(aC.espHealthWidth or 2), math.floor(bN * 0.035)), 1, 6)
local hbOut = aC.espHealthOutline
local hbPad = hbOut and 2 or 0
bs.hpBack.Visible = aC.espHealth and hbOut
bs.hpBar.Visible = aC.espHealth
bs.hpText.Visible = aC.espHealth and (aC.espHealthText and (bW < 100 and bN > 16))
if aC.espHealth then
local bX = math.max(math.floor((bN * bW) / 100), 1)
local hbX = hbSide and (bU + bO + hbPad) or (bU - hbW - hbPad)
if hbOut then
N(bs.hpBack, hbX - 1, bV - 1, hbW + 2, bN + 2)
bs.hpBack.BackgroundColor3 = bl
bs.hpBack.BackgroundTransparency = 0.35
end
N(bs.hpBar, hbX, (bV + bN) - bX, hbW, bX)
local hpLow, hpMax = aC.espHealthColorLow or bn, aC.espHealthColorMax or bm
local bY = bs.hpBar:FindFirstChildOfClass("UIGradient")
if aC.espHealthGrad then
bs.hpBar.BackgroundColor3 = Color3.new(1, 1, 1)
if not bY then
bY = Instance.new("UIGradient")
bY.Rotation = 90
bY.Parent = bs.hpBar
end
if bs.hpGMax ~= hpMax or bs.hpGLow ~= hpLow or bs.hpGInst ~= bY then
bs.hpGMax, bs.hpGLow, bs.hpGInst = hpMax, hpLow, bY
bY.Color = ColorSequence.new(hpMax, hpLow)
end
else
bs.hpBar.BackgroundColor3 = hpLow:Lerp(hpMax, bW / 100)
if bY then
bY:Destroy()
end
end
if bs.hpText.Visible then
bs.hpText.AnchorPoint = Vector2.new(hbSide and 0 or 1, 0.5)
bs.hpText.Position = UDim2.fromOffset(
hbSide and (hbX + hbW + 4) or (hbX - 4),
(bV + bN) - bX / 2
)
bs.hpText.Size = UDim2.fromOffset(30, 10)
bs.hpText.TextXAlignment = hbSide and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
bs.hpText.TextSize = math.max(math.floor((aC.espTextSize - 2) * near), 8)
bs.hpText.TextColor3 = Color3.new(1, 1, 1)
bs.hpText.Text = tostring(math.floor(bW + 0.5))
end
end
local bX, bY = (bV + bN) + 2, aC.espArmor and w(bq, bs) or 0
local bZ = aC.espArmor and bY > 0
bs.arBack.Visible, bs.arBar.Visible = bZ, bZ
if bZ then
local arH = math.clamp(math.floor(bN * 0.04), 2, 4)
N(bs.arBack, bU - 1, bX, bO + 2, arH + 2)
N(bs.arBar, bU, bX + 1, math.max(math.floor((bO * math.clamp(bY, 0, 100)) / 100), 1), arH)
local arLow = aC.espArmorColorLow or bo
local arMax = aC.espArmorColorMax or Color3.fromRGB(140, 220, 255)
local arG = bs.arBar:FindFirstChildOfClass("UIGradient")
if aC.espArmorGrad then
bs.arBar.BackgroundColor3 = Color3.new(1, 1, 1)
if not arG then
arG = Instance.new("UIGradient")
arG.Rotation = 0
arG.Parent = bs.arBar
end
if bs.arGLow ~= arLow or bs.arGMax ~= arMax or bs.arGInst ~= arG then
bs.arGLow, bs.arGMax, bs.arGInst = arLow, arMax, arG
arG.Color = ColorSequence.new(arLow, arMax)
end
else
bs.arBar.BackgroundColor3 = arLow:Lerp(arMax, math.clamp(bY, 0, 100) / 100)
if arG then
arG:Destroy()
end
end
bX = bX + arH + 3
end
local b_ = math.max(math.floor(aC.espTextSize * near + 0.5), 8)
local tgOn = aC.espTextGrad
local tgC1 = aC.espTextGradColor or Color3.new(1, 1, 1)
local tgC2 = aC.espTextGradColor2 or Color3.fromRGB(120, 180, 255)
bs.name.Visible = aC.espNames and readable
if aC.espNames then
bs.name.Position = UDim2.fromOffset(bP, (bV - b_) - 4)
bs.name.Size = UDim2.fromOffset(200, b_ + 2)
bs.name.TextSize, bs.name.TextColor3 = b_,
(tgOn and Color3.new(1, 1, 1)) or (bs.dormant and bC or Color3.new(1, 1, 1))
bs.name.Text = bs.dormant and ("%s  %.0fs ago"):format(bq.DisplayName, bw - (bs.dormantAt or bw))
or bq.DisplayName
gr(bs.name, tgOn, tgC1, tgC2, 90)
end
local b0 = aC.espWeapon and T(bq, bs)
bs.weapon.Visible = b0 ~= nil and (b0 ~= false and readable)
if bs.weapon.Visible then
bs.weapon.Position = UDim2.fromOffset(bP, bX)
bs.weapon.Size = UDim2.fromOffset(200, b_ + 2)
bs.weapon.TextSize, bs.weapon.TextColor3, bs.weapon.Text = b_, tgOn and Color3.new(1, 1, 1) or bC, b0
bX = (bX + b_) + 1
gr(bs.weapon, tgOn, tgC1, tgC2, 90)
end
bs.dist.Visible = aC.espDistance and readable
if aC.espDistance then
bs.dist.Position = UDim2.fromOffset(bP, bX)
bs.dist.Size = UDim2.fromOffset(200, b_ + 2)
bs.dist.TextSize, bs.dist.TextColor3 = math.max(b_ - 1, 8),
tgOn and Color3.new(1, 1, 1) or Color3.fromRGB(210, 210, 215)
bs.dist.Text = math.floor(bB * 0.28) .. "m"
gr(bs.dist, tgOn, tgC1, tgC2, 90)
end
bs.flags.Visible = aC.espFlags and readable
if aC.espFlags then
local b1, b2 = {}, w(bq, bs)
local function tag(b3, b4)
return tgOn and b4 or ('<font color="%s">%s</font>'):format(b3, b4)
end
local b3 = tonumber(bq:GetAttribute("Money"))
if b3 then
b1[#b1 + 1] = tag("#7CE38B", "$" .. math.floor(b3))
end
if bq:GetAttribute("HasDefuseKit") == true then
b1[#b1 + 1] = tag("#C9A6FF", "KIT")
end
if b2 > 0 then
b1[#b1 + 1] = tag("#6FB4FF", bs.arHelmet and "HK" or "K")
end
if (tonumber(bq:GetAttribute("ScopeIncrement")) or 0) > 0 then
b1[#b1 + 1] = tag("#5CE1E6", "ZOOM")
end
if bq:GetAttribute("IsCrouching") == true then
b1[#b1 + 1] = tag("#D0D0D8", "DUCK")
end
if t(br) then
b1[#b1 + 1] = tag("#FFD35C", "IMMUNE")
end
if type(bq) == "table" and bq.IsBot then
b1[#b1 + 1] = tag("#9A9AA5", "BOT")
end
local b4 = math.max(b_ - 2, 8)
bs.flags.AnchorPoint = Vector2.new(0, 0)
bs.flags.Position = UDim2.fromOffset((bU + bO) + 4, bV - 1)
bs.flags.Size = UDim2.fromOffset(90, #b1 * (b4 + 2) + 2)
bs.flags.TextSize = b4
bs.flags.TextColor3 = Color3.new(1, 1, 1)
bs.flags.Text = table.concat(b1, "\n")
gr(bs.flags, tgOn, tgC1, tgC2, 90)
end
bs.headDot.Visible = aC.espHeadDot
if aC.espHeadDot then
local b1, b2 = cam:WorldToViewportPoint(bz), math.max(math.floor(bN * 0.13), 3)
bs.headDot.Position = UDim2.fromOffset(b1.X, b1.Y)
bs.headDot.Size = UDim2.fromOffset(b2, b2)
bs.headStroke.Color = bC
end
local boneVis = aC.espSkeleton and bN >= 6
for b1, b2 in ipairs(bp) do
local b3, b4, b5 =
bs.bones[b1], boneVis and br:FindFirstChild(b2[1]), boneVis and br:FindFirstChild(b2[2])
if b4 and b5 then
local b6, b7 = cam:WorldToViewportPoint(b4.Position), cam:WorldToViewportPoint(b5.Position)
if b6.Z > 0 and b7.Z > 0 then
c(b3, b6.X, b6.Y, b7.X, b7.Y, 1, bC)
else
b3.Visible = false
end
else
b3.Visible = false
end
end
end
aa.connect(O.RenderStepped, function(bq)
if not aC.esp then
if next(bk) then
Q()
end
return
end
local cam = workspace.CurrentCamera or at
local br, bs, bt = (aH.active and aH.eye or cam.CFrame).Position, cam.ViewportSize, os.clock()
for bu, bv in ipairs(aa.entities()) do
local bw = bv ~= _ and k(bv)
local bx = bv ~= _ and (not bw or aC.espTeam)
local by, bz = bx and F(bv), false
if not by and (bx and (not bw and aC.espDormant)) then
local bA, bB = bv.Character, bk[bv]
if
bA
and (
bB
and (
bB.char == bA
and (
not bA:IsDescendantOf(workspace)
and (
not bA:GetAttribute("Dead")
and (bv:GetAttribute("Dead") == false and bA:FindFirstChild("Head"))
)
)
)
)
then
bB.dormantAt = bB.dormantAt or bt
if bt - bB.dormantAt <= aC.espDormantTime then
by, bz = bA, true
end
end
end
local bA, bB = bk[bv], 1
if by then
if not bA or bA.char ~= by then
bA = b(bv, by)
end
if not bz then
bA.dormantAt = nil
end
bA.dormant = bz
elseif
bA
and (
bx
and (
bA.char
and (
bA.char:FindFirstChild("Head")
and (bA.char:IsDescendantOf(workspace) or (bA.alpha or 0) > 0)
)
)
)
then
bA.goneAt = bA.goneAt or bt
if bt - bA.goneAt > 3 then
C(bv)
bA = nil
else
by, bB = bA.char, 0
bA.dormant = false
end
else
C(bv)
bA = nil
end
if bA and by then
if bB == 1 then
bA.goneAt = nil
end
if aC.espFade <= 0 then
bA.alpha = bB
elseif bA.alpha < bB then
bA.alpha = math.min(bA.alpha + bq / aC.espFade, bB)
else
bA.alpha = math.max(bA.alpha - bq / aC.espFade, bB)
end
if bB == 0 and bA.alpha <= 0 then
chamsRestore(bA)
bA.root.Visible, bA.outer.Visible, bA.highlight.Enabled = false, false, false
else
local bC = pcall(o, bv, by, bA, bw, br, bs, bt)
if not bC then
bA.root.Visible, bA.outer.Visible = false, false
end
a(bA)
end
end
end
local bu = aa.entities()
for bv in pairs(bk) do
if not table.find(bu, bv) then
C(bv)
end
end
end)
end
local bi = ad:Tab({
Title = "subtle",
Icon = "target",
})
bi:Section({
Title = "precision lock",
})
do
local bj = bi:Toggle({
Title = "precision lock",
Value = false,
Flag = "silentAim",
Callback = function(bj)
aC.silentAim = bj
end,
})
ak.register("Silent Aim", bj, {
kind = "toggle",
title = "Silent Aim",
isActive = function()
return aC.silentAim
end,
setState = function(bk)
aC.silentAim = bk
pcall(function()
bj:Set(bk)
end)
end,
})
end
bi:Slider({
Title = "capture range",
Value = {
Min = 10,
Max = 600,
Default = 120,
},
Flag = "fovRadius",
Callback = function(bj)
aC.fov = bj
end,
})
bi:Toggle({
Title = "draw capture zone",
Value = true,
Flag = "showFov",
Callback = function(bj)
aC.showFov = bj
end,
})
bi:Colorpicker({
Title = "zone tint",
Default = aC.fovColor,
Flag = "fovColor",
Callback = function(bj)
aC.fovColor = bj
end,
})
bi:Dropdown({
Title = "target bone",
Values = {
"Head",
"HumanoidRootPart",
"Closest to Crosshair",
"Random",
},
Value = "Head",
Flag = "aimPart",
Callback = function(bj)
aC.aimPart = type(bj) == "table" and bj[1] or bj
end,
})
bi:Toggle({
Title = "line of sight",
Value = true,
Flag = "wallCheck",
Callback = function(bj)
aC.wallCheck = bj
end,
})
bi:Toggle({
Title = "ally filter",
Value = true,
Flag = "teamCheck",
Callback = function(bj)
aC.teamCheck = bj
end,
})
bi:Section({
Title = "loadout",
})
do
local bj = bi:Toggle({
Title = "pinpoint",
Value = false,
Flag = "noSpread",
Callback = function(bj)
aC.noSpread = bj
end,
})
ak.register("No Spread", bj, {
kind = "toggle",
title = "No Spread",
isActive = function()
return aC.noSpread
end,
setState = function(bk)
aC.noSpread = bk
pcall(function()
bj:Set(bk)
end)
end,
})
end
do
local bj = bi:Toggle({
Title = "steady hand",
Value = false,
Flag = "noRecoil",
Callback = function(bj)
aC.noRecoil = bj
if bj then
task.spawn(pcall, av.resetWeaponRecoil)
end
end,
})
ak.register("No Recoil", bj, {
kind = "toggle",
title = "No Recoil",
isActive = function()
return aC.noRecoil
end,
setState = function(bk)
aC.noRecoil = bk
if bk then
task.spawn(pcall, av.resetWeaponRecoil)
end
pcall(function()
bj:Set(bk)
end)
end,
})
end
local bj = ad:Tab({
Title = "aggression",
Icon = "flame",
})
bj:Section({
Title = "full aggression",
})
do
local bk = bj:Toggle({
Title = "full aggression",
Value = false,
Flag = "rage",
Callback = function(bk)
aC.rage = bk
end,
})
ak.register("Ragebot", bk, {
kind = "toggle",
title = "Ragebot",
isActive = function()
return aC.rage
end,
setState = function(bl)
aC.rage = bl
pcall(function()
bk:Set(bl)
end)
end,
})
end
bj:Toggle({
Title = "auto discharge",
Value = true,
Flag = "rageAutoFire",
Callback = function(bk)
aC.rageAutoFire = bk
end,
})
bj:Slider({
Title = "autoshot speed",
Value = {
Min = 0,
Max = 500,
Default = 0,
},
Step = 10,
Flag = "autoshotDelay",
Callback = function(bk)
aC.autoshotDelay = bk
end,
})
bj:Toggle({
Title = "wall penetration filter",
Value = true,
Flag = "rageAutowall",
Callback = function(bk)
aC.rageAutowall = bk
end,
})
bj:Slider({
Title = "min damage through walls (0 = any)",
Value = {
Min = 0,
Max = 150,
Default = 0,
},
Step = 1,
Flag = "rageWallMinDmg",
Callback = function(bk)
aC.rageWallMinDmg = bk
end,
})
bj:Toggle({
Title = "peek assist",
Value = false,
Flag = "peekAssist",
Callback = function(bk)
aC.peekAssist = bk
end,
})
bj:Toggle({
Title = "peek assist shoot (no peek, shoot through walls)",
Value = false,
Flag = "peekShoot",
Callback = function(bk)
aC.peekShoot = bk
end,
})
bj:Slider({
Title = "peek shoot fov (360 = all around)",
Value = { Min = 30, Max = 360, Default = 360 },
Step = 10,
Flag = "peekShootFov",
Callback = function(bk)
aC.peekShootFov = bk
end,
})
bj:Dropdown({
Title = "peek assist hit mode",
Values = { "Visible", "Autowall" },
Value = "Visible",
Flag = "peekAssistMode",
Callback = function(bk)
aC.peekAssistMode = type(bk) == "table" and bk[1] or bk
end,
})
bj:Dropdown({
Title = "peek assist target",
Values = { "Nearest", "Crosshair" },
Value = "Nearest",
Flag = "peekAssistTarget",
Callback = function(bk)
aC.peekAssistTarget = type(bk) == "table" and bk[1] or bk
end,
})
bj:Slider({
Title = "peek assist max side (studs)",
Value = { Min = 2, Max = 16, Default = 8 },
Step = 1,
Flag = "peekAssistDist",
Callback = function(bk)
aC.peekAssistDist = bk
end,
})
bj:Slider({
Title = "peek assist enemy range",
Value = { Min = 30, Max = 500, Default = 200 },
Step = 10,
Flag = "peekAssistEnemy",
Callback = function(bk)
aC.peekAssistEnemy = bk
end,
})
bj:Toggle({
Title = "peek assist path line",
Value = true,
Flag = "peekAssistLine",
Callback = function(bk)
aC.peekAssistLine = bk
end,
})
bj:Colorpicker({
Title = "peek assist color",
Default = Color3.fromRGB(90, 255, 170),
Flag = "peekAssistColor",
Callback = function(bk)
aC.peekAssistColor = bk
end,
})
bj:Slider({
Title = "force origin (studs, 0 = off)",
Value = {
Min = 0,
Max = 8,
Default = 0,
},
Step = 0.1,
Flag = "forceOrigin",
Callback = function(bk)
aC.forceOrigin = bk
end,
})
bj:Toggle({
Title = "origin scan",
Value = false,
Flag = "originScan",
Callback = function(bk)
aC.originScan = bk
end,
})
bj:Slider({
Title = "origin range",
Value = {
Min = 1,
Max = 16,
Default = 8,
},
Step = 1,
Flag = "originScanRadius",
Callback = function(bk)
aC.originScanRadius = bk
end,
})
bj:Slider({
Title = "origin scans",
Value = {
Min = 1,
Max = 12,
Default = 4,
},
Step = 1,
Flag = "originScans",
Callback = function(bk)
aC.originScans = bk
end,
})
bj:Dropdown({
Title = "scan style",
Values = {
"default",
"optimized",
"precise",
},
Value = "optimized",
Flag = "originScanMode",
Callback = function(bk)
aC.originScanMode = type(bk) == "table" and bk[1] or bk
end,
})
bj:Toggle({
Title = "debug points",
Value = false,
Flag = "originScanDebug_off",
Callback = function(bk)
aC.originScanDebug = bk
end,
})
bj:Dropdown({
Title = "hitbox",
Values = {
"Head",
"Body",
"Multipoint",
"Full Body",
},
Value = "Head",
Flag = "rageHitbox",
Callback = function(bk)
aC.rageHitbox = type(bk) == "table" and bk[1] or bk
end,
})
bj:Dropdown({
Title = "target selection",
Values = {
"Distance",
"Crosshair",
"Lowest HP",
},
Value = "Distance",
Flag = "rageTargetMode",
Callback = function(bk)
aC.rageTargetMode = type(bk) == "table" and bk[1] or bk
end,
})
bj:Toggle({
Title = "prefer body when lethal",
Value = true,
Flag = "preferBodyLethal",
Callback = function(bk)
aC.preferBodyLethal = bk
end,
})
bj:Toggle({
Title = "multi-target",
Value = false,
Flag = "rageMulti",
Callback = function(bk)
aC.rageMulti = bk
end,
})
bj:Slider({
Title = "scan rate (hz)",
Value = {
Min = 5,
Max = 300,
Default = 300,
},
Flag = "rageScanHz",
Callback = function(bk)
aC.rageScanHz = bk
end,
})
bj:Toggle({
Title = "prediction",
Value = false,
Flag = "ragePrediction",
Callback = function(v)
aC.ragePrediction = v
end,
})
bj:Slider({
Title = "prediction amount",
Value = {
Min = 0,
Max = 0.5,
Default = 0.12,
},
Flag = "ragePredictionAmount",
Callback = function(v)
aC.ragePredictionAmount = v
end,
})
bj:Slider({
Title = "min damage",
Value = {
Min = 1,
Max = 100,
Default = 20,
},
Flag = "minDmg",
Callback = function(bk)
aC.minDmg = bk
end,
})
do
local bk = bj:Toggle({
Title = "min damage override",
Value = false,
Flag = "minDmgOverride",
Callback = function(bk)
aC.minDmgOverride = bk
end,
})
ak.register("Min Dmg Override", bk, {
kind = "toggle",
title = "Min Dmg Override",
isActive = function()
return aC.minDmgOverride
end,
setState = function(bl)
aC.minDmgOverride = bl
pcall(function()
bk:Set(bl)
end)
end,
})
end
bj:Slider({
Title = "override damage",
Value = {
Min = 1,
Max = 100,
Default = 5,
},
Flag = "minDmgOverrideValue",
Callback = function(bk)
aC.minDmgOverrideValue = bk
end,
})
bj:Section({
Title = "anti-aim",
})
do
local bk = bj:Toggle({
Title = "anti-aim",
Value = false,
Flag = "aa",
Callback = function(bk)
aC.aa = bk
end,
})
ak.register("Anti-Aim", bk, {
kind = "toggle",
title = "Anti-Aim",
isActive = function()
return aC.aa
end,
setState = function(bl)
aC.aa = bl
pcall(function()
bk:Set(bl)
end)
end,
})
end
bj:Dropdown({
Title = "yaw base",
Values = {
"View",
"At Targets",
},
Value = "View",
Flag = "aaBase",
Callback = function(bk)
aC.aaBase = type(bk) == "table" and bk[1] or bk
end,
})
local aaManualBtns = {}
do
local bk = aaManualBtns
for bl, bm in ipairs({
"Left",
"Right",
"Back",
}) do
local bn
local function A(bo)
if bo then
aC.aaManual = bm
for bp, bq in pairs(bk) do
if bp ~= bm then
pcall(function()
bq:Set(false)
end)
end
end
elseif aC.aaManual == bm then
aC.aaManual = nil
end
end
bn = bj:Toggle({
Title = "manual " .. bm:lower(),
Value = false,
Callback = A,
})
bk[bm] = bn
ak.register("AA " .. bm, bn, {
kind = "toggle",
title = "AA " .. bm,
isActive = function()
return aC.aaManual == bm
end,
setState = function(bo)
A(bo)
pcall(function()
bn:Set(bo)
end)
end,
})
end
end
do
local bk = bj:Toggle({
Title = "auto manual",
Value = false,
Flag = "aaAutoManual",
Callback = function(bl)
aC.aaAutoManual = bl
if bl then
aC.aaManual = nil
for bm, bn in pairs(aaManualBtns) do
pcall(function()
bn:Set(false)
end)
end
end
end,
})
ak.register("AA Auto", bk, {
kind = "toggle",
title = "AA Auto",
isActive = function()
return aC.aaAutoManual
end,
setState = function(bl)
aC.aaAutoManual = bl
if bl then
aC.aaManual = nil
for bm, bn in pairs(aaManualBtns) do
pcall(function()
bn:Set(false)
end)
end
end
pcall(function()
bk:Set(bl)
end)
end,
})
end
bj:Slider({
Title = "auto manual range",
Value = {
Min = 2,
Max = 16,
Default = 6,
},
Step = 1,
Flag = "aaAutoManualRange",
Callback = function(bk)
aC.aaAutoManualRange = bk
end,
})
bj:Dropdown({
Title = "yaw",
Values = {
"Backwards",
"Sideways",
"Left",
"Right",
"Spin",
"Jitter",
"Random",
"Sway",
"Threeway",
"Static",
"Smooth Random",
"Double Jitter",
"Adaptive Jitter",
},
Value = "Backwards",
Flag = "aaYaw",
Callback = function(bk)
aC.aaYaw = type(bk) == "table" and bk[1] or bk
end,
})
bj:Slider({
Title = "spin tempo",
Value = {
Min = 5,
Max = 90,
Default = 30,
},
Flag = "aaSpin",
Callback = function(bk)
aC.aaSpin = bk
end,
})
bj:Slider({
Title = "jitter range",
Value = {
Min = 5,
Max = 90,
Default = 60,
},
Flag = "aaJitter",
Callback = function(bk)
aC.aaJitter = bk
end,
})
bj:Slider({
Title = "jitter delay (ticks)",
Value = {
Min = 1,
Max = 64,
Default = 8,
},
Flag = "aaJitterDelay",
Callback = function(bk)
aC.aaJitterDelay = bk
end,
})
bj:Slider({
Title = "static angle",
Value = {
Min = 0,
Max = 180,
Default = 180,
},
Step = 5,
Flag = "aaStaticAngle",
Callback = function(bk)
aC.aaStaticAngle = bk
end,
})
bj:Dropdown({
Title = "pitch",
Values = {
"None",
"Down",
"Up",
"Jitter",
},
Value = "Down",
Flag = "aaPitch",
Callback = function(bk)
aC.aaPitch = type(bk) == "table" and bk[1] or bk
end,
})
bj:Toggle({
Title = "disable while shooting",
Value = true,
Flag = "aaOffShot",
Callback = function(bk)
aC.aaOffShot = bk
end,
})
bj:Section({
Title = "loadout",
})
bj:Toggle({
Title = "auto reload",
Value = false,
Flag = "autoReload",
Callback = function(bk)
aC.autoReload = bk
end,
})
bj:Slider({
Title = "reload at",
Value = {
Min = 0,
Max = 10,
Default = 1,
},
Flag = "reloadAt",
Callback = function(bk)
aC.reloadAt = bk
end,
})
bj:Toggle({
Title = "remote reload",
Value = false,
Flag = "remoteReload",
Callback = function(bk)
aC.remoteReload = bk
end,
})
bj:Toggle({
Title = "insta reload",
Value = false,
Flag = "instaReload",
Callback = function(bk)
aC.instaReload = bk
end,
})
bj:Slider({
Title = "reload tempo",
Value = {
Min = 1,
Max = 20,
Default = 3,
},
Flag = "reloadSpeed",
Callback = function(bk)
aC.reloadSpeed = bk
end,
})
local bk = ad:Tab({
Title = "display",
Icon = "sparkles",
})
bk:Section({
Title = "overlay",
})
do
local bl = bk:Toggle({
Title = "overlay",
Value = false,
Flag = "esp",
Callback = function(bl)
aC.esp = bl
end,
})
ak.register("ESP", bl, {
kind = "toggle",
title = "ESP",
isActive = function()
return aC.esp
end,
setState = function(bm)
aC.esp = bm
pcall(function()
bl:Set(bm)
end)
end,
})
end
bk:Colorpicker({
Title = "enemy tint",
Default = aC.espEnemyColor,
Flag = "espEnemyColor",
Callback = function(bl)
aC.espEnemyColor = bl
end,
})
bk:Dropdown({
Title = "tint style",
Values = {
"Enemy / Teammate",
"Team Side",
"Player Color",
},
Value = "Enemy / Teammate",
Flag = "espColorMode",
Callback = function(bl)
aC.espColorMode = type(bl) == "table" and bl[1] or bl
end,
})
bk:Colorpicker({
Title = "terrorist tint",
Default = aC.espTColor,
Flag = "espTColor",
Callback = function(bl)
aC.espTColor = bl
end,
})
bk:Colorpicker({
Title = "counter-terrorist tint",
Default = aC.espCTColor,
Flag = "espCTColor",
Callback = function(bl)
aC.espCTColor = bl
end,
})
bk:Slider({
Title = "fade time (s)",
Value = {
Min = 0,
Max = 1.5,
Default = 0.35,
},
Step = 0.05,
Flag = "espFade",
Callback = function(bl)
aC.espFade = bl
end,
})
bk:Toggle({
Title = "drawn filter tint",
Value = false,
Flag = "espVisCheck",
Callback = function(bl)
aC.espVisCheck = bl
end,
})
bk:Colorpicker({
Title = "drawn tint",
Default = aC.espVisColor,
Flag = "espVisColor",
Callback = function(bl)
aC.espVisColor = bl
end,
})
bk:Toggle({
Title = "draw teammates",
Value = false,
Flag = "espTeam",
Callback = function(bl)
aC.espTeam = bl
end,
})
bk:Colorpicker({
Title = "teammate tint",
Default = aC.espTeamColor,
Flag = "espTeamColor",
Callback = function(bl)
aC.espTeamColor = bl
end,
})
bk:Toggle({
Title = "dormant esp",
Value = false,
Flag = "espDormant",
Callback = function(bl)
aC.espDormant = bl
end,
})
bk:Slider({
Title = "dormant time (s)",
Value = {
Min = 1,
Max = 15,
Default = 4,
},
Flag = "espDormantTime",
Callback = function(bl)
aC.espDormantTime = bl
end,
})
bk:Slider({
Title = "max range",
Value = {
Min = 100,
Max = 3000,
Default = 3000,
},
Step = 50,
Flag = "espMaxDist",
Callback = function(bl)
aC.espMaxDist = bl
end,
})
bk:Section({
Title = "esp - chams",
})
bk:Toggle({
Title = "material shell",
Value = true,
Flag = "espChams",
Callback = function(bl)
aC.espChams = bl
end,
})
bk:Dropdown({
Title = "chams style",
Values = {
"Mesh",
"ForceField",
"Both",
},
Value = "ForceField",
Flag = "espChamsStyle",
Callback = function(v)
aC.espChamsStyle = type(v) == "table" and v[1] or v
end,
})
bk:Colorpicker({
Title = "chams tint",
Default = Color3.fromRGB(255, 60, 60),
Flag = "espChamsColor",
Callback = function(bl)
aC.espChamsColor = bl
end,
})
bk:Slider({
Title = "glow",
Value = {
Min = 1,
Max = 10,
Default = 4,
},
Flag = "espChamsGlow",
Callback = function(bl)
aC.espChamsGlow = bl
end,
})
bk:Toggle({
Title = "self chams",
Value = false,
Flag = "selfChams",
Callback = function(v)
aC.selfChams = v
end,
})
bk:Slider({
Title = "self chams fill",
Value = {
Min = 0,
Max = 1,
Default = 0.45,
},
Flag = "selfChamsFill",
Callback = function(v)
aC.selfChamsFill = v
end,
})
bk:Colorpicker({
Title = "self chams color",
Default = Color3.fromRGB(255, 255, 255),
Flag = "selfChamsColor",
Callback = function(v)
aC.selfChamsColor = v
end,
})
bk:Dropdown({
Title = "self chams style",
Values = {
"Highlight",
"ForceField",
"Neon",
"Glass",
"Ice",
"Metal",
"Smooth Plastic",
"Plastic",
},
Value = "ForceField",
Flag = "selfChamsMaterial",
Callback = function(v)
aC.selfChamsMaterial = type(v) == "table" and v[1] or v
end,
})
bk:Toggle({
Title = "self chams rainbow",
Value = false,
Flag = "selfChamsRainbow",
Callback = function(v)
aC.selfChamsRainbow = v
end,
})
bk:Slider({
Title = "self chams transparency",
Value = {
Min = 0,
Max = 0.9,
Default = 0,
},
Flag = "selfChamsTransp",
Callback = function(v)
aC.selfChamsTransp = v
end,
})
bk:Toggle({
Title = "self chams accessories",
Value = true,
Flag = "selfChamsAcc",
Callback = function(v)
aC.selfChamsAcc = v
end,
})
bk:Toggle({
Title = "self chams outline",
Value = true,
Flag = "selfChamsOutline",
Callback = function(v)
aC.selfChamsOutline = v
end,
})
bk:Colorpicker({
Title = "self chams outline color",
Default = Color3.fromRGB(255, 255, 255),
Flag = "selfChamsOutlineColor",
Callback = function(v)
aC.selfChamsOutlineColor = v
end,
})
bk:Toggle({
Title = "chams rainbow",
Value = false,
Flag = "espChamsRainbow",
Callback = function(v)
aC.espChamsRainbow = v
end,
})
bk:Slider({
Title = "fill fade",
Value = {
Min = 0,
Max = 100,
Default = 60,
},
Flag = "espFill",
Callback = function(bl)
aC.espFill = bl / 100
end,
})
bk:Section({
Title = "esp - box",
})
bk:Toggle({
Title = "frame",
Value = true,
Flag = "espBox",
Callback = function(bl)
aC.espBox = bl
end,
})
bk:Dropdown({
Title = "box style",
Values = {
"Static",
"Corners",
"Full",
},
Value = "Corners",
Flag = "espBoxStyle",
Callback = function(bl)
aC.espBoxStyle = type(bl) == "table" and bl[1] or bl
end,
})
bk:Toggle({
Title = "outline",
Value = true,
Flag = "espBoxOutline",
Callback = function(bl)
aC.espBoxOutline = bl
end,
})
bk:Colorpicker({
Title = "outline tint",
Default = Color3.new(0, 0, 0),
Flag = "espBoxOutlineColor",
Callback = function(bl)
aC.espBoxOutlineColor = bl
end,
})
bk:Slider({
Title = "weight",
Value = {
Min = 1,
Max = 4,
Default = 2,
},
Flag = "espBoxThickness",
Callback = function(bl)
aC.espBoxThickness = bl
end,
})
bk:Toggle({
Title = "box gradient",
Value = true,
Flag = "espBoxGrad",
Callback = function(bl)
aC.espBoxGrad = bl
end,
})
bk:Colorpicker({
Title = "gradient tint a",
Default = Color3.fromRGB(255, 85, 130),
Flag = "espBoxGradColor",
Callback = function(bl)
aC.espBoxGradColor = bl
end,
})
bk:Colorpicker({
Title = "gradient tint b",
Default = Color3.fromRGB(150, 95, 255),
Flag = "espBoxGradColor2",
Callback = function(bl)
aC.espBoxGradColor2 = bl
end,
})
bk:Toggle({
Title = "box fill",
Value = true,
Flag = "espBoxFill",
Callback = function(bl)
aC.espBoxFill = bl
end,
})
bk:Toggle({
Title = "fill gradient",
Value = true,
Flag = "espFillGrad",
Callback = function(bl)
aC.espFillGrad = bl
end,
})
bk:Colorpicker({
Title = "fill gradient tint a",
Default = Color3.fromRGB(255, 85, 130),
Flag = "espFillGradColor",
Callback = function(bl)
aC.espFillGradColor = bl
end,
})
bk:Colorpicker({
Title = "fill gradient tint b",
Default = Color3.fromRGB(150, 95, 255),
Flag = "espFillGradColor2",
Callback = function(bl)
aC.espFillGradColor2 = bl
end,
})
bk:Toggle({
Title = "health bar",
Value = true,
Flag = "espHealth",
Callback = function(bl)
aC.espHealth = bl
end,
})
bk:Toggle({
Title = "health number",
Value = true,
Flag = "espHealthText",
Callback = function(bl)
aC.espHealthText = bl
end,
})
bk:Dropdown({
Title = "bar side",
Values = {
"Left",
"Right",
},
Value = "Left",
Flag = "espHealthSide",
Callback = function(bl)
aC.espHealthSide = type(bl) == "table" and bl[1] or bl
end,
})
bk:Slider({
Title = "bar width",
Value = {
Min = 1,
Max = 6,
Default = 3,
},
Flag = "espHealthWidth",
Callback = function(bl)
aC.espHealthWidth = bl
end,
})
bk:Toggle({
Title = "bar gradient",
Value = true,
Flag = "espHealthGrad",
Callback = function(bl)
aC.espHealthGrad = bl
end,
})
bk:Colorpicker({
Title = "low hp tint",
Default = Color3.fromRGB(255, 60, 60),
Flag = "espHealthColorLow",
Callback = function(bl)
aC.espHealthColorLow = bl
end,
})
bk:Colorpicker({
Title = "max hp tint",
Default = Color3.fromRGB(90, 255, 110),
Flag = "espHealthColorMax",
Callback = function(bl)
aC.espHealthColorMax = bl
end,
})
bk:Toggle({
Title = "bar outline",
Value = true,
Flag = "espHealthOutline",
Callback = function(bl)
aC.espHealthOutline = bl
end,
})
bk:Toggle({
Title = "armor bar",
Value = true,
Flag = "espArmor",
Callback = function(bl)
aC.espArmor = bl
end,
})
bk:Toggle({
Title = "armor gradient",
Value = true,
Flag = "espArmorGrad",
Callback = function(bl)
aC.espArmorGrad = bl
end,
})
bk:Colorpicker({
Title = "armor tint low",
Default = Color3.fromRGB(255, 120, 60),
Flag = "espArmorColorLow",
Callback = function(bl)
aC.espArmorColorLow = bl
end,
})
bk:Colorpicker({
Title = "armor tint max",
Default = Color3.fromRGB(90, 170, 255),
Flag = "espArmorColorMax",
Callback = function(bl)
aC.espArmorColorMax = bl
end,
})
bk:Section({
Title = "esp - info",
})
bk:Toggle({
Title = "callouts",
Value = true,
Flag = "espNames",
Callback = function(bl)
aC.espNames = bl
end,
})
bk:Toggle({
Title = "loadout",
Value = true,
Flag = "espWeapon",
Callback = function(bl)
aC.espWeapon = bl
end,
})
bk:Toggle({
Title = "flags",
Value = false,
Flag = "espFlags",
Callback = function(bl)
aC.espFlags = bl
end,
})
bk:Toggle({
Title = "range",
Value = true,
Flag = "espDistance",
Callback = function(bl)
aC.espDistance = bl
end,
})
bk:Slider({
Title = "text scale",
Value = {
Min = 9,
Max = 18,
Default = 13,
},
Flag = "espTextSize",
Callback = function(bl)
aC.espTextSize = bl
end,
})
bk:Toggle({
Title = "text gradient",
Value = false,
Flag = "espTextGrad",
Callback = function(bl)
aC.espTextGrad = bl
end,
})
bk:Colorpicker({
Title = "text gradient tint a",
Default = Color3.fromRGB(255, 255, 255),
Flag = "espTextGradColor",
Callback = function(bl)
aC.espTextGradColor = bl
end,
})
bk:Colorpicker({
Title = "text gradient tint b",
Default = Color3.fromRGB(120, 180, 255),
Flag = "espTextGradColor2",
Callback = function(bl)
aC.espTextGradColor2 = bl
end,
})
bk:Section({
Title = "esp - lines",
})
bk:Toggle({
Title = "bones",
Value = false,
Flag = "espSkeleton",
Callback = function(bl)
aC.espSkeleton = bl
end,
})
bk:Toggle({
Title = "head dot",
Value = true,
Flag = "espHeadDot",
Callback = function(bl)
aC.espHeadDot = bl
end,
})
bk:Toggle({
Title = "tracers",
Value = false,
Flag = "espSnap",
Callback = function(bl)
aC.espSnap = bl
end,
})
bk:Dropdown({
Title = "snapline origin",
Values = {
"Bottom",
"Center",
"Top",
},
Value = "Bottom",
Flag = "espSnapFrom",
Callback = function(bl)
aC.espSnapFrom = type(bl) == "table" and bl[1] or bl
end,
})
bk:Toggle({
Title = "off-screen arrows",
Value = false,
Flag = "espArrows",
Callback = function(bl)
aC.espArrows = bl
end,
})
bk:Slider({
Title = "arrow range",
Value = {
Min = 60,
Max = 500,
Default = 220,
},
Step = 10,
Flag = "espArrowRadius",
Callback = function(bl)
aC.espArrowRadius = bl
end,
})
bk:Slider({
Title = "arrow scale",
Value = {
Min = 8,
Max = 30,
Default = 14,
},
Flag = "espArrowSize",
Callback = function(bl)
aC.espArrowSize = bl
end,
})
bk:Section({
Title = "esp - sound",
})
do
local bl, bm, bn, bo, bp, bq, br, bs, bt =
false, Color3.fromRGB(255, 190, 60), 3, true, {}, {
"Bomb",
"Plant",
"Defus",
"Killed",
"Music",
"Hostage",
"Round",
"Win",
}, 7, 16, RaycastParams.new()
bt.FilterType = Enum.RaycastFilterType.Exclude
local function q()
local bu = {}
for bv, bw in ipairs(aa.entities()) do
if h(bw) and bw:GetAttribute("Dead") == false then
local bx = bw.Character
if not (bx and bx:IsDescendantOf(workspace)) then
local by = bw:GetAttribute("CurrentEquipped")
local bz, bA = pcall(ar.JSONDecode, ar, type(by) == "string" and by or "")
bu[#bu + 1] = {
name = bw.Name,
weapon = bz and (type(bA) == "table" and bA.Name) or nil,
}
end
end
end
return bu
end
local function v(bu, bv)
local bw = q()
if #bw == 1 then
return bw[1].name
end
if bu then
local bx
for by, bz in ipairs(bw) do
if bz.weapon == bv then
if bx then
return nil
end
bx = bz.name
end
end
return bx
end
return nil
end
local function K(bu)
pcall(function()
bu.part:Destroy()
end)
end
local function N()
local bu = Instance.new("Part")
bu.Anchored, bu.CanCollide, bu.CanQuery, bu.CanTouch, bu.CastShadow = true, false, false, false, false
bu.Transparency = 1
bu.Size = Vector3.new(0.2, 0.2, 0.2)
bu.Parent = aS
local bv = Instance.new("BillboardGui")
bv.Size = UDim2.fromOffset(200, 96)
bv.AlwaysOnTop = true
bv.LightInfluence = 0
bv.Adornee = bu
bv.Parent = bu
local function pulseRing()
local f = Instance.new("Frame")
f.AnchorPoint = Vector2.new(0.5, 0.5)
f.Position = UDim2.fromOffset(100, 22)
f.Size = UDim2.fromOffset(12, 12)
f.BackgroundTransparency = 1
f.BorderSizePixel = 0
f.Parent = bv
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(1, 0)
c.Parent = f
local st = Instance.new("UIStroke")
st.Thickness = 2
st.Parent = f
return f, st
end
local p1, s1 = pulseRing()
local p2, s2 = pulseRing()
local bw = Instance.new("Frame")
bw.AnchorPoint = Vector2.new(0.5, 0.5)
bw.Position = UDim2.fromOffset(100, 22)
bw.Size = UDim2.fromOffset(12, 12)
bw.BorderSizePixel = 0
bw.ZIndex = 3
bw.Parent = bv
local bc = Instance.new("UICorner")
bc.CornerRadius = UDim.new(1, 0)
bc.Parent = bw
local bx = Instance.new("UIStroke")
bx.Thickness = 2
bx.Color = Color3.new(1, 1, 1)
bx.Parent = bw
local pill = Instance.new("Frame")
pill.AnchorPoint = Vector2.new(0.5, 0)
pill.Position = UDim2.fromOffset(100, 46)
pill.Size = UDim2.fromOffset(160, 38)
pill.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
pill.BackgroundTransparency = 0.2
pill.BorderSizePixel = 0
pill.Parent = bv
local pc = Instance.new("UICorner")
pc.CornerRadius = UDim.new(0, 8)
pc.Parent = pill
local ps = Instance.new("UIStroke")
ps.Thickness = 1
ps.Parent = pill
local ac = Instance.new("Frame")
ac.Position = UDim2.fromOffset(6, 6)
ac.Size = UDim2.fromOffset(3, 26)
ac.BorderSizePixel = 0
ac.Parent = pill
local acc = Instance.new("UICorner")
acc.CornerRadius = UDim.new(1, 0)
acc.Parent = ac
local by = Instance.new("TextLabel")
by.BackgroundTransparency = 1
by.Position = UDim2.fromOffset(16, 0)
by.Size = UDim2.new(1, -20, 1, 0)
by.Font = Enum.Font.GothamSemibold
by.TextSize = 12
by.RichText = true
by.TextXAlignment = Enum.TextXAlignment.Left
by.TextYAlignment = Enum.TextYAlignment.Center
by.TextColor3 = Color3.fromRGB(232, 232, 232)
by.TextTruncate = Enum.TextTruncate.AtEnd
by.Text = ""
by.Parent = pill
local bz = Instance.new("BoxHandleAdornment")
bz.Adornee = bu
bz.AlwaysOnTop = true
bz.ZIndex = 1
bz.Size = Vector3.new(2.4, 5.2, 1.6)
bz.Transparency = 0.8
bz.Visible = false
bz.Parent = bu
return {
part = bu, ring = bw, stroke = bx, text = by, box = bz,
pulse1 = p1, pulseS1 = s1, pulse2 = p2, pulseS2 = s2,
pill = pill, pillStroke = ps, accent = ac,
}
end
local function c(bu)
if not bl or aa.unloaded or type(bu) ~= "table" then
return
end
local bv = bu.Position
if typeof(bv) ~= "Vector3" then
return
end
local bw = tostring(bu.Name or "")
for bx, by in ipairs(bq) do
if bw:find(by, 1, true) then
return
end
end
local bx = _.Character
local by = bx and bx:FindFirstChild("HumanoidRootPart")
if by and (by.Position - bv).Magnitude < 16 then
return
end
local bz = workspace:FindFirstChild("Characters")
if bz then
for bA, bB in ipairs(bz:GetChildren()) do
local bC = bB:IsA("Model") and bB:FindFirstChild("HumanoidRootPart")
if bC and (bC.Position - bv).Magnitude < br then
return
end
end
end
local bA, bB, bC, bD = bw == "Shoot", type(bu.Class) == "string" and bu.Class or nil, nil, nil
for bE, bF in ipairs(bp) do
local bG = (bF.pos - bv).Magnitude
if bG < bs and (not bD or bG < bD) then
bC, bD = bF, bG
end
end
if not bC then
bC = N()
bp[#bp + 1] = bC
end
local bE = os.clock()
if bC.pos and (bC.last and (bA == bC.wasShot and (bE - bC.last > 0.05 and bE - bC.last < 1.5))) then
local bF = (bv - bC.pos) / (bE - bC.last)
bF = Vector3.new(bF.X, 0, bF.Z)
bC.vel = bF.Magnitude < 32 and bF or nil
else
bC.vel = nil
end
bC.wasShot = bA
bC.pos, bC.last = bv, bE
bC.kind = bA and (bB or "shot") or "steps"
bt.FilterDescendantsInstances = {
_.Character,
at,
workspace:FindFirstChild("Debris"),
}
local bF = (U()).Position
bC.inView = workspace:Raycast(bF, (bv + Vector3.new(0, 2.5, 0)) - bF, bt) == nil
bC.who = v(bA, bB) or bC.who
bC.part.CFrame = CFrame.new(bv + Vector3.new(0, 1.5, 0))
end
local bu
pcall(function()
bu = a2.Sound.ReplicateSound.Connect(function(bv)
pcall(c, bv)
end)
end)
aa.onUnload(function()
if type(bu) == "function" then
pcall(bu)
end
for bv, bw in ipairs(bp) do
K(bw)
end
bp = {}
end)
aa.connect(O.RenderStepped, function()
if #bp == 0 then
return
end
local bv, bw = os.clock(), (U()).Position
for bx = #bp, 1, -1 do
local by = bp[bx]
local bz = bv - by.last
if not bl or bz > bn then
K(by)
table.remove(bp, bx)
else
local bA = bz / bn
local fade = math.clamp((bA - 0.55) / 0.45, 0, 1)
local meters = math.floor((by.pos - bw).Magnitude * 0.28)
local hex = string.format("#%02X%02X%02X", math.floor(bm.R * 255 + 0.5), math.floor(bm.G * 255 + 0.5), math.floor(bm.B * 255 + 0.5))
local big = by.inView and 1.25 or 1
for i = 1, 2 do
local ph = ((bz + (i - 1) * 0.6) % 1.2) / 1.2
local sz = (12 + ph * 44) * big
local ringF = i == 1 and by.pulse1 or by.pulse2
local ringS = i == 1 and by.pulseS1 or by.pulseS2
ringF.Size = UDim2.fromOffset(sz, sz)
ringS.Color = bm
ringS.Transparency = 1 - (1 - ph) * 0.85 * (1 - fade)
end
by.ring.BackgroundColor3 = bm
by.ring.BackgroundTransparency = fade
by.stroke.Transparency = fade
by.ring.Size = by.inView and UDim2.fromOffset(16, 16) or UDim2.fromOffset(12, 12)
by.pill.BackgroundTransparency = 0.2 + 0.8 * fade
by.pillStroke.Color = bm
by.pillStroke.Transparency = 0.2 + 0.8 * fade
by.accent.BackgroundColor3 = bm
by.accent.BackgroundTransparency = fade
local who = by.who and string.format('  <font color="#E8E8E8">%s</font>', tostring(by.who)) or ""
local vis = by.inView and '  <font color="#5CFF8A">VISIBLE</font>' or ""
by.text.Text = string.format('<b><font color="%s">%s</font></b>%s\n<font color="#A8AEB8">%dm</font>%s', hex, string.upper(tostring(by.kind or "steps")), who, meters, vis)
by.text.TextTransparency = fade
local bB = by.vel and by.pos + by.vel * math.min(bz, 0.6) or by.pos
by.part.CFrame = CFrame.new(bB + Vector3.new(0, 1.5, 0))
by.box.Visible = bo
by.box.Color3 = bm
by.box.Transparency = 0.7 + bA * 0.3
by.box.CFrame = CFrame.new(0, by.wasShot and -3.25 or 1.25, 0)
end
end
end)
bk:Toggle({
Title = "sound esp",
Value = false,
Flag = "soundEsp",
Callback = function(bv)
bl = bv
end,
})
bk:Colorpicker({
Title = "sound marker tint",
Default = bm,
Flag = "soundEspColor",
Callback = function(bv)
bm = bv
end,
})
bk:Toggle({
Title = "sound ghost box",
Value = true,
Flag = "soundEspBox",
Callback = function(bv)
bo = bv
end,
})
bk:Slider({
Title = "sound marker time (s)",
Value = {
Min = 1,
Max = 10,
Default = 3,
},
Step = 0.5,
Flag = "soundEspLife",
Callback = function(bv)
bn = bv
end,
})
end
do
local bl, bm, bn, bo, bp = "rbxassetid://16658221428", false, false, {}, nil
local function r()
if bp and bp.Parent then
return bp
end
bp = Instance.new("Folder")
bp.Name = "NightCCNametags"
local bq = {
function()
return gethui()
end,
function()
return game:GetService("CoreGui")
end,
function()
return _:FindFirstChildOfClass("PlayerGui")
end,
}
for br, bs in ipairs(bq) do
if pcall(function()
bp.Parent = bs()
end) and bp.Parent then
break
end
end
return bp
end
local function y()
local bq = Instance.new("BillboardGui")
bq.Name = "Tag"
bq.AlwaysOnTop = true
bq.LightInfluence = 0
bq.MaxDistance = math.huge
bq.ResetOnSpawn = false
bq.Size = UDim2.fromOffset(300, 22)
bq.StudsOffset = Vector3.new(0, 2.6, 0)
local br = Instance.new("Frame")
br.AnchorPoint = Vector2.new(0.5, 0.5)
br.Position = UDim2.fromScale(0.5, 0.5)
br.Size = UDim2.fromScale(0, 1)
br.AutomaticSize = Enum.AutomaticSize.X
br.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
br.BackgroundTransparency = 0.55
br.BorderSizePixel = 0
br.Parent = bq
local bs = Instance.new("UIPadding")
bs.PaddingLeft = UDim.new(0, 6)
bs.PaddingRight = UDim.new(0, 6)
bs.Parent = br
local bt = Instance.new("UIListLayout")
bt.FillDirection = Enum.FillDirection.Horizontal
bt.VerticalAlignment = Enum.VerticalAlignment.Center
bt.SortOrder = Enum.SortOrder.LayoutOrder
bt.Padding = UDim.new(0, 5)
bt.Parent = br
local bu = Instance.new("Frame")
bu.LayoutOrder = 1
bu.Size = UDim2.fromOffset(8, 8)
bu.BorderSizePixel = 0
local bv = Instance.new("UICorner")
bv.CornerRadius = UDim.new(1, 0)
bv.Parent = bu
bu.Parent = br
local bw = Instance.new("TextLabel")
bw.LayoutOrder = 2
bw.Size = UDim2.fromScale(0, 1)
bw.AutomaticSize = Enum.AutomaticSize.X
bw.BackgroundTransparency = 1
bw.FontFace = Font.new(bl, Enum.FontWeight.Bold)
bw.TextSize = 14
bw.TextColor3 = Color3.fromRGB(222, 222, 222)
bw.RichText = true
bw.Parent = br
return {
gui = bq,
dot = bu,
label = bw,
}
end
local function P(bq)
local br = bo[bq]
if br then
pcall(function()
br.gui:Destroy()
end)
bo[bq] = nil
end
end
local function q()
for bq in pairs(bo) do
P(bq)
end
if bp then
pcall(function()
bp:Destroy()
end)
bp = nil
end
end
aa.onUnload(q)
aa.connect(u.PlayerRemoving, P)
aa.connect(O.RenderStepped, function()
if not bm then
return
end
local bq, br = (U()).Position, r()
for bs, bt in ipairs(aa.entities()) do
local bu = bt ~= _ and k(bt)
local bv = bt ~= _ and ((not bu or aC.espTeam) and bt.Character)
if bv and (bv:GetAttribute("Dead") and not bn) then
bv = nil
end
if bv and not bv:IsDescendantOf(workspace) then
bv = nil
end
local bw = bv and (bv:FindFirstChild("Head") or bv:FindFirstChild("HumanoidRootPart"))
if bw then
local bx = bo[bt]
if not bx or not bx.gui.Parent then
P(bt)
bx = y()
bo[bt] = bx
end
bx.dot.BackgroundColor3 = bu and aC.espTeamColor or aC.espEnemyColor
if bx.gui.Adornee ~= bw then
bx.gui.Adornee = bw
end
if bx.gui.Parent ~= br then
bx.gui.Parent = br
end
local by = math.floor((bw.Position - bq).Magnitude * 0.28 + 0.5)
local bz = bt.Name .. (' <font color="#E04B4B">[' .. (by .. "m]</font>"))
if bx.text ~= bz then
bx.text = bz
bx.label.Text = bz
end
else
P(bt)
end
end
local bs = aa.entities()
for bt in pairs(bo) do
if not table.find(bs, bt) then
P(bt)
end
end
end)
ak.register("Nametags", tagToggle, {
kind = "toggle",
title = "Nametags",
isActive = function()
return bm
end,
setState = function(bq)
bm = bq
if not bq then
q()
end
pcall(function()
tagToggle:Set(bq)
end)
end,
})
end
bk:Section({
Title = "outer cam",
})
do
local bl, bm, bn, bo, bp, bq, br, bs, bt, bu, bv, bw =
"NightCCThirdPerson", false, 8, 0.5, 0, true, false, "Camera", setmetatable({}, {
__mode = "k",
}), setmetatable({}, {
__mode = "k",
}), false, RaycastParams.new()
bw.FilterType = Enum.RaycastFilterType.Exclude
local bx
local function Q(by, bz)
for bA, bB in ipairs(by:GetDescendants()) do
if bB:IsA("BasePart") and (bB.Name ~= "HumanoidRootPart" and bB.Name ~= "CameraPart") then
bB.LocalTransparencyModifier = bz
end
end
end
local function b()
for by, bz in pairs(bt) do
if by.Parent then
by.C0 = bz
end
end
table.clear(bt)
end
local function a()
for by in pairs(bu) do
if by.Parent then
by.LocalTransparencyModifier = 0
end
end
table.clear(bu)
end
local by, bz, bA, bB = require(L.Controllers.Observers.Players.Components.CreateWeaponModel), false
local function G(bC)
task.spawn(function()
if setthreadidentity then
pcall(setthreadidentity, 2)
end
pcall(bC)
end)
end
local function J()
if not bz then
return
end
bz, bA, bB = false, nil, nil
local bC = au.getCurrentCharacter()
G(function()
by.ClearPlayerCache(_)
if bC then
bC.CharacterAnimator:setWeapon(nil, nil, true)
end
end)
end
local function S()
local bC, bD = _:GetAttribute("CurrentEquipped"), au.getCurrentCharacter()
if bz and (bC == bA and bD == bB) then
return
end
bA, bB, bz = bC, bD, true
local bE, bF = pcall(ar.JSONDecode, ar, type(bC) == "string" and bC or "")
G(function()
if bE and (type(bF) == "table" and type(bF.Name) == "string") then
by(_, bF, {})
if bD then
bD.CharacterAnimator:setWeapon(bF.Name, bF.Identifier, true)
end
else
by.ClearPlayerCache(_)
if bD then
bD.CharacterAnimator:setWeapon(nil, nil, true)
end
end
end)
end
local bC
local function H()
if not bv then
return
end
bv = false
aH.active, aH.eye = false, nil
b()
a()
J()
if _.Character then
bC(_.Character)
end
local bD = _.Character
if bD then
Q(bD, 1)
end
end
local function i(bD)
return math.atan2(-bD.X, -bD.Z)
end
local bD, bE, bF =
require(L.Components.Common.CharacterPose), setmetatable({}, {
__mode = "k",
}), setmetatable({}, {
__mode = "k",
})
local function W(bG)
local bH = bE[bG]
if not bH then
local bI, bJ = pcall(bD.getJoints, bG)
if bI and type(bJ) == "table" then
bH = bJ
bE[bG] = bH
end
end
return bH
end
bC = function(bG)
if not bF[bG] then
return
end
bF[bG] = nil
local bH = W(bG)
if bH then
pcall(bD.applyVerticalLook, bH, 0, 0.003)
end
end
local function X(bG, bH)
local bI = aC.aa and aH.sentYaw ~= nil
if not br and not bI then
bC(bG)
return
end
local bJ = bG:FindFirstChild("HumanoidRootPart")
if not bJ then
return
end
local bK, bL = i(bH.LookVector), bH.LookVector.Y
if bI or bs == "Sent Angles" and aH.sentYaw then
bK, bL = aH.sentYaw, aH.sentPitch or bL
end
pcall(function()
bJ.CFrame = bD.composeRootCFrame(bJ.Position, bK)
end)
local bM = W(bG)
if bM then
pcall(bD.applyVerticalLook, bM, math.clamp(bL, -1, 1), 0.003)
bF[bG] = true
end
end
local KO = { off = true, t = 0, v = false }
function KO.knife()
local now = os.clock()
if now - KO.t > 0.1 then
KO.t = now
local ok, w = pcall(p)
local props = ok and type(w) == "table" and w.Properties
KO.v = type(props) == "table" and props.Class == "Melee"
end
return KO.v
end
local function U()
local bG = _.Character
if not bm or not bG or bG:GetAttribute("Dead") or (KO.off and KO.knife()) then
H()
return
end
local bH = at.CFrame
aH.eye, aH.active = bH, true
bv = true
local bI, bJ = bH.Position, bH:VectorToWorldSpace(Vector3.new(bp, bo, bn))
local bK = bJ.Magnitude
if bK > 0.01 then
if bq then
bw.FilterDescendantsInstances = { bG, at }
local bL = workspace:Raycast(bI, bJ, bw)
if bL then
bK = math.max((bL.Position - bI).Magnitude - 0.3, 0.2)
end
end
at.CFrame = bH.Rotation + (bI + bJ.Unit * bK)
bx = at.CFrame
end
Q(bG, 0)
local bL = p()
local bM = bL and (bL.Viewmodel and bL.Viewmodel.Model)
if bM then
for bN, bO in ipairs(bM:GetDescendants()) do
if bO:IsA("BasePart") then
bO.LocalTransparencyModifier = 1
bu[bO] = true
end
end
end
X(bG, bH)
S()
end
O:BindToRenderStep(bl, Enum.RenderPriority.Last.Value, U)
aa.connect(O.Heartbeat, function()
if bx and (aH.active and (aH.eye and at.CFrame == bx)) then
at.CFrame = aH.eye
end
bx = nil
end)
aa.onUnload(function()
pcall(function()
O:UnbindFromRenderStep(bl)
end)
H()
end)
local bG = bk:Toggle({
Title = "outer cam",
Value = false,
Flag = "thirdPerson",
Callback = function(bG)
bm = bG
end,
})
ak.register("Third Person", bG, {
kind = "toggle",
title = "Third Person",
isActive = function()
return bm
end,
setState = function(bH)
bm = bH
pcall(function()
bG:Set(bH)
end)
end,
})
bk:Toggle({
Title = "outer cam off with knife",
Value = true,
Flag = "thirdPersonKnifeOff",
Callback = function(bH)
KO.off = bH
end,
})
bk:Slider({
Title = "range",
Value = {
Min = 2,
Max = 25,
Default = 8,
},
Step = 0.5,
Flag = "tpDistance",
Callback = function(bH)
bn = bH
end,
})
bk:Slider({
Title = "height",
Value = {
Min = -2,
Max = 5,
Default = 0.5,
},
Step = 0.25,
Flag = "tpHeight",
Callback = function(bH)
bo = bH
end,
})
bk:Slider({
Title = "shoulder offset",
Value = {
Min = -4,
Max = 4,
Default = 0,
},
Step = 0.25,
Flag = "tpShoulder",
Callback = function(bH)
bp = bH
end,
})
bk:Toggle({
Title = "camera collision",
Value = true,
Flag = "tpCollide",
Callback = function(bH)
bq = bH
end,
})
bk:Toggle({
Title = "body rotation",
Value = false,
Flag = "tpHeadRot",
Callback = function(bH)
br = bH
end,
})
bk:Dropdown({
Title = "body follows",
Values = {
"Camera",
"Sent Angles",
},
Value = "Camera",
Flag = "tpHeadFollow",
Callback = function(bH)
bs = type(bH) == "table" and bH[1] or bH
end,
})
end
do
local bl, bm, bn, bo =
game:GetService("CollectionService"),
require(L.Shared.GrenadeSimulator),
require(L.Database.Security.Remotes),
L.Components.Common.VFXLibary
local bp, bq, br, bs, bt, bu, bv, bw, bx, by, bz, bA =
require(bo.FlashEffect),
require(bo.CreateVoxelSmoke),
workspace:FindFirstChild("Debris"),
0.016666666666667,
300,
20,
0.7,
{
["HE Grenade"] = {
color = Color3.fromRGB(255, 60, 60),
radius = 26,
linger = 0.6,
},
Flashbang = {
color = Color3.fromRGB(255, 255, 190),
radius = 20,
linger = 0.6,
},
["Smoke Grenade"] = {
color = Color3.fromRGB(170, 170, 170),
radius = 11,
linger = 18,
},
Molotov = {
color = Color3.fromRGB(255, 140, 40),
radius = 11,
linger = 7,
},
["Incendiary Grenade"] = {
color = Color3.fromRGB(255, 140, 40),
radius = 11,
linger = 7,
},
["Decoy Grenade"] = {
color = Color3.fromRGB(80, 200, 120),
radius = 4,
linger = 15,
},
},
{
Molotov = true,
["Incendiary Grenade"] = true,
},
{},
{
Radius = 0.25,
Restitution = 0.4,
MaxBounces = 20,
FuseTime = 0,
},
{
["HE Grenade"] = 1.6,
Flashbang = 1.6,
Molotov = 2,
["Incendiary Grenade"] = 2,
}
pcall(function()
bn.Projectile.Spawn.Listen(function(bB)
if type(bB) == "table" and (type(bB.Weapon) == "string" and type(bB.Physics) == "table") then
by[bB.Weapon] = bB.Physics
end
end)
end)
local bB, bC, bD, bE = false, false, false, Instance.new("Folder")
bE.Name = "NightCCGrenades"
bE.Parent = at
aa.onUnload(function()
bE:Destroy()
end)
local function S(bF)
local bG = Instance.new("Part")
bG.Anchored, bG.CanCollide, bG.CanQuery, bG.CanTouch, bG.CastShadow = true, false, false, false, false
bG.Material = Enum.Material.Neon
bG.Shape = bF or Enum.PartType.Block
bG.Transparency = bv
bG.Parent = bE
return bG
end
local bF, bG, bH = {}, 0, S(Enum.PartType.Ball)
bH.Transparency = 1
local function s()
for bI = 1, #bF, 1 do
bF[bI].Transparency = 1
end
bH.Transparency = 1
end
local function g(bI, bJ, bK, bL)
local bM = bF[bI]
if not bM then
bM = S()
bF[bI] = bM
end
local bN = (bK - bJ).Magnitude
bM.Size = Vector3.new(0.08, 0.08, math.max(bN, 0.01))
bM.CFrame = CFrame.lookAt(bJ, bK) * CFrame.new(0, 0, -bN / 2)
bM.Color = bL
bM.Transparency = 0.2
end
local function f()
local bI = au.getCurrentCharacter()
local bJ = bI and bI.GlobalVelocity
return typeof(bJ) == "Vector3" and bJ or Vector3.zero
end
local function W(bI, bJ)
local bK = by[bI] or bz
local bL = (bK.FuseTime and bK.FuseTime > 0) and bK.FuseTime or bA[bI]
local bM, bN =
{
rangeScale = 1,
isNearThrow = bJ == "Near",
radius = bK.Radius or bz.Radius,
restitution = bK.Restitution or bz.Restitution,
maxBounces = bK.MaxBounces or bz.MaxBounces,
fuseTime = bL,
minimumFuseTime = bx[bI] and 0.1 or nil,
explodeOnFloorImpact = bx[bI] or nil,
}, RaycastParams.new()
bN.FilterType = Enum.RaycastFilterType.Exclude
bN.FilterDescendantsInstances = {
_.Character,
at,
br,
}
bN.RespectCanCollide = false
bN.IgnoreWater = true
if bK.CollisionGroup then
bN.CollisionGroup = bK.CollisionGroup
end
local bO = U()
local bP, bQ = bm.calculateThrowParameters(bO.Position, bO.LookVector, bJ, 1)
local bR = bm.createInitialState(bP, bQ, bJ, f(), 1, tick())
local bS = {
bR.position,
}
for bU = 1, bt, 1 do
local bV = bm.simulate(bR, bM, bN, bs)
bR = bV.state
bS[#bS + 1] = bR.position
local bW = bR.isAtRest
for bX, bY in ipairs(bV.events or {}) do
if bY.type == "rest" or bY.type == "fuse" or bY.type == "floor_impact" then
bW = true
end
end
if bW then
break
end
end
return bS
end
local function X()
local bI = p()
local bJ = bI and bI.Name
if bJ and bw[bJ] then
return bJ
end
return nil
end
local bI = 0
aa.connect(O.RenderStepped, function()
if not bB then
if bG > 0 then
s()
bG = 0
end
return
end
local bJ = X()
if not bJ then
if bG > 0 then
s()
bG = 0
end
return
end
if os.clock() - bI < 1 / bu then
return
end
bI = os.clock()
local bK = an:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and "Near" or "Far"
local bL, bM = pcall(W, bJ, bK)
if not bL or #bM < 2 then
return
end
local bN, bO = bw[bJ], 0
for bP = 1, #bM - 1, 2 do
bO = bO + 1
g(bO, bM[bP], bM[math.min(bP + 2, #bM)], bN.color)
end
for bP = bO + 1, #bF, 1 do
bF[bP].Transparency = 1
end
bG = bO
local bP = bN.radius
bH.Size = Vector3.new(bP * 2, bP * 2, bP * 2)
bH.CFrame = CFrame.new(bM[#bM])
bH.Color = bN.color
bH.Transparency = bv
end)
local bJ = {}
aa.connect(O.Heartbeat, function()
local bK = os.clock()
if bC then
for bL, bM in ipairs(bl:GetTagged("Grenade")) do
local bN = bM:GetAttribute("GrenadeName")
local bO = bN and bw[bN]
if bO and bM.PrimaryPart then
local bP = bJ[bM]
if not bP then
bP = {
name = bN,
part = S(Enum.PartType.Ball),
}
bP.part.Color = bO.color
bP.part.Size = Vector3.new(bO.radius * 2, bO.radius * 2, bO.radius * 2)
bJ[bM] = bP
end
if not bP.landedAt then
bP.pos = bM.PrimaryPart.Position
if bM:GetAttribute("SimulationFinished") then
bP.landedAt = bK
end
end
end
end
end
for bL, bM in pairs(bJ) do
local bN = bw[bM.name]
local bO, bP = bM.landedAt and bK - bM.landedAt > bN.linger, not bL.Parent and not bM.landedAt
if not bC or bO or bP then
bM.part:Destroy()
bJ[bL] = nil
else
bM.part.CFrame = CFrame.new(bM.pos)
bM.part.Transparency = bv
end
end
end)
do
local bK
bK = Q(bp.Flash, function(...)
if not aa.unloaded and aC.antiFlash then
return false
end
return bK(...)
end)
aC.cancelFlash = function()
pcall(function()
if bp.IsFlashed() then
bp.CancelFlash()
end
end)
end
local bL
bL = Q(bq.Create, function(...)
if not aa.unloaded and bD then
return nil
end
return bL(...)
end)
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
ak.register("Grenade Trajectory", previewToggle, {
kind = "toggle",
title = "Grenade Trajectory",
isActive = function()
return bB
end,
setState = function(bK)
bB = bK
pcall(function()
previewToggle:Set(bK)
end)
end,
})
local bK = {
{
"HE Radius",
"HE Grenade",
26,
},
{
"Flash Radius",
"Flashbang",
20,
},
{
"Smoke Radius",
"Smoke Grenade",
11,
},
{
"Fire Radius",
"Molotov",
11,
},
}
for bL, bM in ipairs(bK) do
bk:Slider({
Title = bM[1],
Value = {
Min = 2,
Max = 40,
Default = bM[3],
},
Flag = "grenadeRadius_" .. bM[2],
Callback = function(bN)
bw[bM[2]].radius = bN
if bM[2] == "Molotov" then
bw["Incendiary Grenade"].radius = bN
end
for bO, bP in pairs(bJ) do
local bQ = bw[bP.name].radius
bP.part.Size = Vector3.new(bQ * 2, bQ * 2, bQ * 2)
end
end,
})
end
end
bk:Section({
Title = "camera",
})
do
local bl, bm, bn, bo = "NightCCCameraMods", false, 90
local bp, bq, br = false, 70
local bs, bt, bu, bv, bw, bx = false, 0, 0, 0, false, nil
local function a()
if bx and bx.Parent then
return bx
end
local by = _:FindFirstChildOfClass("PlayerGui")
bx = by and by:FindFirstChild("SniperScope", true)
return bx
end
local function T()
local by = a()
if by and by.Visible then
return true
end
local bz = p()
return bz ~= nil and (bz.IsAiming == true or bz.IsSniperScoped == true or (bz.CurrentScopeIncrement or 0) > 0)
end
do
local by, bz = require(L.Classes.WeaponComponent.Classes.Viewmodel), nil
bz = Q(by.render, function(bA, ...)
local bB = bz(bA, ...)
if bA.Player == _ then
aC.vmModel = bA.Model
end
if not aa.unloaded and (bs and (not aH.active and (bA.Player == _ and bA.Model))) then
pcall(function()
bA.Model:PivotTo(bA.Model:GetPivot() * CFrame.new(bt, bu, bv))
if bA.LargeWeaponModel and bA.SmallWeaponModel then
bA.LargeWeaponModel:PivotTo(bA.SmallWeaponModel:GetPivot())
end
end)
end
return bB
end)
end
local by = {}
for bz = 1, 4, 1 do
local bA = Instance.new("Frame")
bA.BorderSizePixel = 0
bA.Visible = false
bA.Parent = aL
local bB = Instance.new("UIGradient")
bB.Rotation = bz <= 2 and 0 or 90
bB.Parent = bA
by[bz] = bA
end
local bz, bA, bB = NumberSequence.new(0), NumberSequence.new(1, 0), NumberSequence.new(0, 1)
local function n()
local bC = aC.scopeStyle == "Gradient"
local bD, bE, bF, bG =
bC and aC.scopeGap or 0,
bC and aC.scopeLen / 100 or 1,
bC and aC.scopeThick or 1,
bC and aC.scopeColor or Color3.new(0, 0, 0)
for bH, bI in ipairs(by) do
local bJ = bI:FindFirstChildOfClass("UIGradient")
bI.BackgroundColor3 = bG
if bH == 1 then
bI.AnchorPoint = Vector2.new(1, 0.5)
bI.Position = UDim2.new(0.5, -bD, 0.5, 0)
bI.Size = UDim2.new(0.5 * bE, 0, 0, bF)
bJ.Transparency = bC and bA or bz
elseif bH == 2 then
bI.AnchorPoint = Vector2.new(0, 0.5)
bI.Position = UDim2.new(0.5, bD, 0.5, 0)
bI.Size = UDim2.new(0.5 * bE, 0, 0, bF)
bJ.Transparency = bC and bB or bz
elseif bH == 3 then
bI.AnchorPoint = Vector2.new(0.5, 1)
bI.Position = UDim2.new(0.5, 0, 0.5, -bD)
bI.Size = UDim2.new(0, bF, 0.5 * bE, 0)
bJ.Transparency = bC and bA or bz
else
bI.AnchorPoint = Vector2.new(0.5, 0)
bI.Position = UDim2.new(0.5, 0, 0.5, bD)
bI.Size = UDim2.new(0, bF, 0.5 * bE, 0)
bJ.Transparency = bC and bB or bz
end
end
end
n()
local bC = {}
local function J(bD)
for bE, bF in ipairs(bD:GetDescendants()) do
local bG = bF:IsA("Frame")
and (bF.Name == "Left" or bF.Name == "Right" or bF.Name == "Top" or bF.Name == "Bottom")
if bG or bF:IsA("ImageLabel") then
if bC[bF] == nil then
bC[bF] = {
"Visible",
bF.Visible,
}
end
bF.Visible = false
end
end
end
local function S()
for bD, bE in pairs(bC) do
if bD.Parent then
pcall(function()
bD[bE[1]] = bE[2]
end)
end
end
table.clear(bC)
end
O:BindToRenderStep(bl, Enum.RenderPriority.Last.Value + 1, function()
local bD, bE = T(), at.FieldOfView
local bF = bE < bn - 0.5 and (bo ~= nil and bE < bo - 0.5)
if not bD and not bF then
if bm then
at.FieldOfView = bn
else
bq = bE
end
br = an.MouseDeltaSensitivity
elseif bp then
at.FieldOfView = bm and bn or bq
if br then
an.MouseDeltaSensitivity = br
end
end
local bG = a()
local bH = bw and (bG ~= nil and bG.Visible)
if bH then
J(bG)
elseif next(bC) then
S()
end
for bI, bJ in ipairs(by) do
bJ.Visible = bH
end
end)
aa.onUnload(function()
pcall(function()
O:UnbindFromRenderStep(bl)
end)
S()
if bo then
at.FieldOfView = bo
end
end)
local bD = bk:Toggle({
Title = "fov changer",
Value = false,
Flag = "fovChanger",
Callback = function(bD)
if bD and not bm then
bo = at.FieldOfView
end
bm = bD
if not bD and (bo and not T()) then
at.FieldOfView = bo
end
end,
})
ak.register("FOV Changer", bD, {
kind = "toggle",
title = "FOV Changer",
isActive = function()
return bm
end,
setState = function(bE)
if bE and not bm then
bo = at.FieldOfView
end
bm = bE
if not bE and (bo and not T()) then
at.FieldOfView = bo
end
pcall(function()
bD:Set(bE)
end)
end,
})
bk:Slider({
Title = "fov",
Value = {
Min = 50,
Max = 120,
Default = 90,
},
Flag = "fovSlider",
Callback = function(bE)
bn = bE
end,
})
bk:Toggle({
Title = "no scope zoom",
Value = false,
Flag = "noScopeZoom",
Callback = function(bE)
bp = bE
end,
})
bk:Toggle({
Title = "no scope borders",
Value = false,
Flag = "noScopeBorders",
Callback = function(bE)
bw = bE
end,
})
bk:Dropdown({
Title = "scope lines",
Values = {
"Line",
"Gradient",
},
Value = "Line",
Flag = "scopeStyle",
Callback = function(bE)
aC.scopeStyle = type(bE) == "table" and bE[1] or bE
n()
end,
})
bk:Colorpicker({
Title = "scope line tint",
Default = aC.scopeColor,
Flag = "scopeColor",
Callback = function(bE)
aC.scopeColor = bE
n()
end,
})
bk:Slider({
Title = "scope line length",
Value = {
Min = 10,
Max = 100,
Default = 60,
},
Step = 5,
Flag = "scopeLen",
Callback = function(bE)
aC.scopeLen = bE
n()
end,
})
bk:Slider({
Title = "scope line gap",
Value = {
Min = 0,
Max = 80,
Default = 12,
},
Flag = "scopeGap",
Callback = function(bE)
aC.scopeGap = bE
n()
end,
})
bk:Slider({
Title = "scope line weight",
Value = {
Min = 1,
Max = 5,
Default = 1,
},
Flag = "scopeThick",
Callback = function(bE)
aC.scopeThick = bE
n()
end,
})
do
local bE = false
pcall(function()
local bF = require(L.Controllers.CameraController)
for bG, bH in ipairs({
"weaponKick",
"BombExploded",
"OnLanded",
}) do
local bI = bF[bH]
if type(bI) == "function" then
bF[bH] = function(...)
if bE and not aa.unloaded then
return
end
return bI(...)
end
aa.onUnload(function()
bF[bH] = bI
end)
end
end
end)
bk:Toggle({
Title = "remove screen shake",
Value = false,
Flag = "noShake",
Callback = function(bF)
bE = bF
end,
})
end
bk:Toggle({
Title = "anti flash",
Value = false,
Flag = "antiFlash",
Callback = function(bE)
aC.antiFlash = bE
if bE and aC.cancelFlash then
aC.cancelFlash()
end
end,
})
bk:Toggle({
Title = "viewstylel changer",
Value = false,
Flag = "vmChanger",
Callback = function(bE)
bs = bE
end,
})
for bE, bF in ipairs({
{
"x",
"vmX",
},
{
"y",
"vmY",
},
{
"z",
"vmZ",
},
}) do
bk:Slider({
Title = "viewstylel " .. bF[1],
Value = {
Min = -3,
Max = 3,
Default = 0,
},
Step = 0.05,
Flag = bF[2] .. "Slider",
Callback = function(bG)
if bF[1] == "x" then
bt = bG
elseif bF[1] == "y" then
bu = bG
else
bv = bG
end
end,
})
end
end
bk:Section({
Title = "viewstylel chams",
})
do
local bl, bm, bn, bo, bp, bq, br, bs =
false, "ForceField", Color3.fromRGB(120, 170, 255), 0, {
ForceField = Enum.Material.ForceField,
Neon = Enum.Material.Neon,
Glass = Enum.Material.Glass,
Flat = Enum.Material.SmoothPlastic,
}, {}, false, 0
local function y()
for bt, bu in pairs(bq) do
pcall(function()
bt.Material, bt.Color, bt.Transparency = bu.mat, bu.color, bu.transp
if bu.tex then
bt.TextureID = bu.tex
end
for bv, bw in ipairs(bu.sa) do
bw.Parent = bt
end
end)
end
bq = {}
end
aa.onUnload(y)
local function P(bt, bu)
for bv, bw in ipairs(bt:GetDescendants()) do
if bw:IsA("BasePart") then
local bx = bq[bw]
if not bx and bw.Transparency < 1 then
bx = {
mat = bw.Material,
color = bw.Color,
transp = bw.Transparency,
sa = {},
}
if bw:IsA("MeshPart") then
bx.tex = bw.TextureID
end
for by, bz in ipairs(bw:GetChildren()) do
if bz:IsA("SurfaceAppearance") then
bx.sa[#bx.sa + 1] = bz
end
end
bq[bw] = bx
bx.fresh = true
end
if bx and (bu or bx.fresh) then
bx.fresh = nil
pcall(function()
for by, bz in ipairs(bx.sa) do
bz.Parent = nil
end
if bx.tex then
bw.TextureID = ""
end
bw.Material = bp[bm] or Enum.Material.ForceField
bw.Color = bn
bw.Transparency = math.max(bx.transp, bo)
end)
end
end
end
end
aa.connect(O.RenderStepped, function()
if not bl then
return
end
local bt = os.clock()
if not br and bt - bs < 0.2 then
return
end
bs = bt
local bu = aC.vmModel
if bu and bu.Parent then
P(bu, br)
br = false
end
end)
bk:Toggle({
Title = "viewstylel chams",
Value = false,
Flag = "vmChams",
Callback = function(bt)
bl = bt
if bt then
br = true
else
y()
end
end,
})
bk:Dropdown({
Title = "chams material",
Values = {
"ForceField",
"Neon",
"Glass",
"Flat",
},
Value = "ForceField",
Flag = "vmChamsMaterial",
Callback = function(bt)
bm = type(bt) == "table" and bt[1] or bt
br = true
end,
})
bk:Colorpicker({
Title = "chams tint",
Default = bn,
Flag = "vmChamsColor",
Callback = function(bt)
bn = bt
br = true
end,
})
bk:Slider({
Title = "chams fade",
Value = {
Min = 0,
Max = 95,
Default = 0,
},
Step = 5,
Flag = "vmChamsTransp",
Callback = function(bt)
bo = bt / 100
br = true
end,
})
end
bk:Section({
Title = "character changer",
})
do
local bl, bm, bn, bo, bp, bq =
{
on = false,
target = "Self",
source = "Anarchist",
user = "",
avatar = nil,
avatarFor = nil,
gen = 0,
file = nil,
custom = nil,
customFor = nil,
}, "nightcc/characters", {
Torso = {
"UpperTorso",
CFrame.new(0, -0.2, 0),
},
["Left Arm"] = {
"LeftUpperArm",
CFrame.new(0, -0.45, 0),
},
["Right Arm"] = {
"RightUpperArm",
CFrame.new(0, -0.45, 0),
},
["Left Leg"] = {
"LeftUpperLeg",
CFrame.new(0, -0.6, 0),
},
["Right Leg"] = {
"RightUpperLeg",
CFrame.new(0, -0.6, 0),
},
}, {}, {
Head = true,
UpperTorso = true,
LowerTorso = true,
LeftUpperArm = true,
LeftLowerArm = true,
LeftHand = true,
RightUpperArm = true,
RightLowerArm = true,
RightHand = true,
LeftUpperLeg = true,
LeftLowerLeg = true,
LeftFoot = true,
RightUpperLeg = true,
RightLowerLeg = true,
RightFoot = true,
}, {
LeftGlove = true,
RightGlove = true,
}
local function q()
return bl.source == "IDF" or bl.source == "Anarchist"
end
local function v()
if bl.source == "Roblox Avatar" then
return bl.avatar
end
if bl.source == "Custom Model" then
return bl.custom
end
local br = L:FindFirstChild("Assets") and L.Assets:FindFirstChild("Characters")
return br and br:FindFirstChild(bl.source)
end
local function K()
if bl.source == "Roblox Avatar" then
return "avatar:" .. tostring(bl.avatarFor)
end
if bl.source == "Custom Model" then
return "custom:" .. tostring(bl.customFor)
end
return bl.source
end
local function N(br)
local bs = bo[br]
if not bs then
return
end
bo[br] = nil
pcall(function()
bs.overlay:Destroy()
end)
for bt, bu in pairs(bs.hidden) do
pcall(function()
bt.Transparency = bu
end)
end
end
local function c()
for br in pairs(bo) do
N(br)
end
end
local function C(br)
local bs = v()
if not bs then
return
end
local bt = bs:Clone()
bt.Name = "ZbCharacterOverlay"
for bu, bv in ipairs(bt:GetDescendants()) do
if bv:IsA("Humanoid") and not q() then
pcall(function()
bv.EvaluateStateMachine = false
bv.RequiresNeck = false
bv.BreakJointsOnDeath = false
bv.PlatformStand = true
bv.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
bv.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
end)
elseif
bv:IsA("Humanoid")
or bv:IsA("LuaSourceContainer")
or bv:IsA("AnimationController")
or bv:IsA("Animator")
then
bv:Destroy()
elseif bv:IsA("Motor6D") then
if bv.Part1 == nil or bp[bv.Part1.Name] or bv.Part1.Name == "HumanoidRootPart" then
bv:Destroy()
end
elseif bv:IsA("BasePart") then
bv.Anchored, bv.CanCollide, bv.CanQuery, bv.CanTouch = false, false, false, false
bv.Massless, bv.CastShadow = true, false
end
end
local bu = {}
for bv, bw in ipairs(bt:GetChildren()) do
if bw:IsA("BasePart") then
local bx = bn[bw.Name]
local by = br:FindFirstChild(bp[bw.Name] and bw.Name or bx and bx[1] or "")
if by and by:IsA("BasePart") then
local bz = bx and bx[2] or CFrame.new()
bw.CFrame = by.CFrame * bz
local bA = Instance.new("Weld")
bA.Part0, bA.Part1, bA.C0 = by, bw, bz
bA.Parent = bw
bu[bw] = { by, bz }
else
bw:Destroy()
end
end
end
for bv, bw in ipairs(bt:GetChildren()) do
if bw:IsA("Accessory") then
local bx = bw:FindFirstChild("Handle")
local by, bz = bx and bx:FindFirstChildOfClass("Attachment"), false
if by then
for bA, bB in pairs(bu) do
local bC = bA:FindFirstChild(by.Name)
local bD = bC and (bC:IsA("Attachment") and bB[1])
if bD then
for bE, bF in ipairs(bx:GetChildren()) do
if bF:IsA("JointInstance") then
bF:Destroy()
end
end
local bE = (bB[2] * bC.CFrame) * by.CFrame:Inverse()
bx.CFrame = bD.CFrame * bE
local bF = Instance.new("Weld")
bF.Part0, bF.Part1, bF.C0 = bD, bx, bE
bF.Parent = bx
bz = true
break
end
end
end
if not bz then
bw:Destroy()
end
end
end
local bv = {}
for bw, bx in ipairs(br:GetDescendants()) do
if
(bx:IsA("BasePart") or bx:IsA("Decal") or bx:IsA("Texture"))
and (not bq[bx.Name] and bx.Transparency < 1)
then
bv[bx] = bx.Transparency
bx.Transparency = 1
end
end
bt.Parent = br
bo[br] = {
key = K(),
overlay = bt,
hidden = bv,
}
end
local function Q()
bl.gen = bl.gen + 1
local br, bs = bl.gen, (bl.user:gsub("^%s+", "")):gsub("%s+$", "")
if bl.source ~= "Roblox Avatar" or bs == "" then
return
end
if bl.avatar and bl.avatarFor == bs then
return
end
bl.avatar, bl.avatarFor = nil, nil
task.spawn(function()
local bt, bu = pcall(function()
local bt = tonumber(bs) or u:GetUserIdFromNameAsync(bs)
local bu = u:GetHumanoidDescriptionFromUserId(bt)
bu.Head, bu.Torso, bu.LeftArm, bu.RightArm, bu.LeftLeg, bu.RightLeg = 0, 0, 0, 0, 0, 0
bu.BodyTypeScale, bu.ProportionScale = 0, 0
bu.HeightScale, bu.WidthScale, bu.DepthScale, bu.HeadScale = 1, 1, 1, 1
return u:CreateHumanoidModelFromDescription(bu, Enum.HumanoidRigType.R15)
end)
if br ~= bl.gen or aa.unloaded then
return
end
if bt and bu then
bl.avatar, bl.avatarFor = bu, bs
else
if setthreadidentity then
pcall(setthreadidentity, 8)
end
pcall(function()
ac:Notify({
Title = "character changer",
Content = "couldn't load an avatar for '" .. (bs .. "'"),
Duration = 4,
})
end)
end
end)
end
local br = false
local function a()
if br then
return
end
br = true
pcall(function()
if not isfolder("nightcc") then
makefolder("nightcc")
end
if not isfolder(bm) then
makefolder(bm)
end
for bs, bt in ipairs({
"nightcc/characters",
"nightcc/characters",
}) do
if isfolder(bt) then
for bu, bv in ipairs(listfiles(bt)) do
local bw = bv:match("([^/\\]+)$")
if bw and ((bw:lower()):match("%.rbxmx?$") and not isfile(bm .. ("/" .. bw))) then
writefile(bm .. ("/" .. bw), readfile(bv))
end
end
end
end
end)
end
local function T()
a()
local bs = {}
pcall(function()
if isfolder and not isfolder(bm) then
if not isfolder("nightcc") then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
makefolder(bm)
end
for bt, bu in ipairs(listfiles(bm)) do
local bv = bu:match("([^/\\]+)$")
if bv and (bv:lower()):match("%.rbxmx?$") then
bs[#bs + 1] = bv
end
end
end)
table.sort(bs)
if #bs == 0 then
bs[1] = "(no files)"
end
return bs
end
local function w()
local bs = bl.file
if bl.source ~= "Custom Model" or not bs or bs == "(no files)" then
return
end
if bl.custom and bl.customFor == bs then
return
end
bl.custom, bl.customFor = nil, nil
local bt, bu, bv =
getthreadidentity and getthreadidentity(), pcall(function()
return game:GetObjects(getcustomasset(bm .. ("/" .. bs)))
end)
if bt and setthreadidentity then
pcall(setthreadidentity, bt)
end
local bw = bu and (type(bv) == "table" and bv[1])
if bw and not bw:IsA("Model") then
bw = bw:FindFirstChildWhichIsA("Model", true)
end
if bw then
bl.custom, bl.customFor = bw, bs
else
pcall(function()
ac:Notify({
Title = "character changer",
Content = "couldn't load " .. bs,
Duration = 4,
})
end)
end
end
local function V(bs)
local bt = bs and (bs ~= "" and aa.byName(bs)) or _
local bu = bt and bt.Character
if not (bu and type(saveinstance) == "function") then
return false, "no character / no saveinstance"
end
c()
for bv, bw in ipairs(bu:GetDescendants()) do
pcall(function()
bw.Archivable = true
end)
end
bu.Archivable = true
local bv = bu:Clone()
if not bv then
return false, "could not clone"
end
for bw, bx in ipairs(bv:GetDescendants()) do
if bx:IsA("LuaSourceContainer") or bx:IsA("Sound") or bx:IsA("BillboardGui") or bx:IsA("Highlight") then
bx:Destroy()
elseif bx:IsA("BasePart") then
bx.Anchored = true
end
end
local bw = 0
pcall(function()
if not isfolder("nightcc") then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
if not isfolder(bm) then
makefolder(bm)
end
for bx, by in ipairs(listfiles(bm)) do
local bz = tonumber((by:match("([^/\\]+)$") or ""):match("^(%d+)%.rbxmx?$"))
if bz and bz > bw then
bw = bz
end
end
end)
local bx, by = tostring(bw + 1), tostring(bt.Name)
bv.Name = bx
local bz = "zb_charsave_" .. tostring(math.random(100000, 999999))
task.spawn(function()
local bA, bB, bC =
pcall(saveinstance, bv, {
FileName = bz,
mode = "model",
}), nil, os.clock() + 30
while bA and (os.clock() < bC and not bB) do
for bD, bE in ipairs({
".rbxmx",
".rbxm",
}) do
if isfile(bz .. bE) then
bB = bz .. bE
end
end
if not bB then
task.wait(0.25)
end
end
local bD = "Saving failed"
if bB then
local bE, bF = -1, 0
while bF < 3 do
local bG, bH = pcall(readfile, bB)
local bI = bG and #bH or -1
if bI == bE and bI > 0 then
bF = bF + 1
else
bF = 0
end
bE = bI
task.wait(0.2)
end
pcall(function()
if not isfolder("nightcc") then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
if not isfolder(bm) then
makefolder(bm)
end
writefile(bm .. ("/" .. (bx .. bB:match("%.%w+$"))), readfile(bB))
delfile(bB)
end)
bD = "Saved " .. (by .. (" as " .. (bx .. (bB:match("%.%w+$") .. (" in " .. bm)))))
end
pcall(function()
bv:Destroy()
end)
if setthreadidentity then
pcall(setthreadidentity, 8)
end
pcall(function()
ac:Notify({
Title = "character changer",
Content = bD,
Duration = 5,
})
end)
if bl.refreshFiles then
pcall(bl.refreshFiles)
end
end)
return true
end
local function e(bs)
if bs == _ then
return bl.target == "Self" or bl.target == "Everyone"
end
if bl.target == "Everyone" then
return true
end
local bt = k(bs)
return bl.target == "Enemies" and not bt or bl.target == "Teammates" and bt
end
local bs, bt = {}, {}
local function n()
for bu, bv in pairs(bs) do
pcall(function()
bu.Transparency = bv
end)
end
for bu in pairs(bt) do
pcall(function()
bu:Destroy()
end)
end
bs, bt = {}, {}
end
local function G()
local bu, bv = aC.vmModel, bl.on and (q() and (bl.target == "Self" or bl.target == "Everyone"))
if not (bv and (bu and bu.Parent)) then
if next(bs) or next(bt) then
n()
end
return
end
local bw = bl.source == "IDF"
if bw and next(bs) then
for bx, by in pairs(bs) do
pcall(function()
bx.Transparency = by
end)
end
bs = {}
elseif not bw and next(bt) then
for bx in pairs(bt) do
pcall(function()
bx:Destroy()
end)
end
bt = {}
end
for bx, by in ipairs({
"Left Arm",
"Right Arm",
}) do
local bz = bu:FindFirstChild(by)
if bz then
local bA = bz:FindFirstChild("Sleeve")
if bw and not bA then
local bB = L.Assets:FindFirstChild("Sleeves")
local bC = bB and bB:FindFirstChild("IDF")
local bD = bC and bC:FindFirstChild(by)
if bD then
local bE, bF, bG =
getthreadidentity and getthreadidentity(), pcall(function()
return (require(L.Database.Components.Common.AttachGlovesToViewmodel))({ bD }, bu)
end)
if bE and setthreadidentity then
pcall(setthreadidentity, bE)
end
if bF and type(bG) == "table" then
for bH, bI in ipairs(bG) do
bI.Name = "Sleeve"
bt[bI] = true
end
end
end
elseif not bw and (bA and (not bt[bA] and bA.Transparency < 1)) then
bs[bA] = bA.Transparency
bA.Transparency = 1
end
end
end
end
aa.onUnload(function()
c()
n()
end)
local bu = 0
aa.connect(O.Heartbeat, function()
local bv = os.clock()
if bv - bu < 0.3 then
return
end
bu = bv
pcall(G)
if not (bl.on and v()) then
if next(bo) then
c()
end
return
end
local bw = {}
local function I(bx, by)
if not (bx and (bx:IsDescendantOf(workspace) and bx:FindFirstChild("UpperTorso"))) then
return
end
if not (by and e(by)) then
return
end
bw[bx] = true
local bz = bo[bx]
if bz and (bz.key ~= K() or not bz.overlay.Parent) then
N(bx)
bz = nil
end
if not bz then
pcall(C, bx)
else
for bA in pairs(bz.hidden) do
if bA.Parent and bA.Transparency < 1 then
bA.Transparency = 1
end
end
end
end
for bx, by in ipairs(aa.entities()) do
local bz = by.Character
if bz and not bz:GetAttribute("Dead") then
I(bz, by)
end
end
local bx = workspace:FindFirstChild("Debris")
if bx then
for by, bz in ipairs(bx:GetChildren()) do
if bz:IsA("Model") and bz:GetAttribute("CharacterType") ~= nil then
local bA = bz.Name:gsub("^__PreparedRagdoll_", "")
I(bz, aa.byName(bA))
end
end
end
for by in pairs(bo) do
if not bw[by] then
N(by)
end
end
end)
bk:Toggle({
Title = "character changer",
Value = false,
Flag = "charChanger",
Callback = function(bv)
bl.on = bv
c()
end,
})
bk:Dropdown({
Title = "change who",
Values = {
"Self",
"Enemies",
"Teammates",
"Everyone",
},
Value = "Self",
Flag = "charChangerTarget",
Callback = function(bv)
bl.target = type(bv) == "table" and bv[1] or bv
c()
end,
})
bk:Dropdown({
Title = "character stylel",
Values = {
"Anarchist",
"IDF",
"Roblox Avatar",
"Custom Model",
},
Value = "Anarchist",
Flag = "charChangerModel",
Callback = function(bv)
bl.source = type(bv) == "table" and bv[1] or bv
c()
Q()
w()
end,
})
local bv = bk:Dropdown({
Title = "custom stylel file",
Values = T(),
Value = (T())[1],
Flag = "charChangerFile",
Callback = function(bv)
bl.file = type(bv) == "table" and bv[1] or bv
c()
w()
end,
})
bl.file = (T())[1]
function bl.refreshFiles()
local bw = T()
pcall(function()
bv:Refresh(bw)
end)
if not table.find(bw, bl.file) then
bl.file = bw[1]
end
end
bk:Button({
Title = "refresh stylel files",
Callback = function()
bl.refreshFiles()
end,
})
local bw = ""
bk:Input({
Title = "save who",
Value = "",
Placeholder = "player name (empty = you)",
Callback = function(bx)
bw = tostring(bx or "")
end,
})
bk:Button({
Title = "save character",
Callback = function()
local bx, by = V(bw)
if not bx then
pcall(function()
ac:Notify({
Title = "character changer",
Content = "can't save: " .. tostring(by),
Duration = 4,
})
end)
end
end,
})
bk:Input({
Title = "avatar account",
Value = "",
Placeholder = "username or user id",
Flag = "charChangerUser",
Callback = function(bx)
bx = tostring(bx or "")
if bx == bl.user then
return
end
bl.user = bx
c()
Q()
end,
})
end
do
local bl, bm, bn, bo, bp, bq, br =
Color3.fromRGB(88, 170, 255),
false,
false,
false,
false,
Color3.fromRGB(125, 125, 135),
Color3.fromRGB(235, 235, 240)
local function y(bs)
return string.format(
"#%02X%02X%02X",
math.floor(bs.R * 255 + 0.5),
math.floor(bs.G * 255 + 0.5),
math.floor(bs.B * 255 + 0.5)
)
end
local bs = Instance.new("Frame")
bs.Name = "night_ccWatermark"
bs.AnchorPoint = Vector2.new(1, 0)
bs.Position = UDim2.new(1, -14, 0, 120)
bs.Size = UDim2.fromOffset(0, 26)
bs.AutomaticSize = Enum.AutomaticSize.X
bs.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
bs.BackgroundTransparency = 0.1
bs.BorderSizePixel = 0
bs.Visible = false
bs.Parent = aL;
(Instance.new("UICorner", bs)).CornerRadius = UDim.new(0, 4)
local bt = Instance.new("UIPadding", bs)
bt.PaddingLeft, bt.PaddingRight = UDim.new(0, 10), UDim.new(0, 10)
local bu = Instance.new("Frame")
bu.Position = UDim2.new(0, -10, 0, 0)
bu.Size = UDim2.new(1, 20, 0, 2)
bu.BorderSizePixel = 0
bu.Parent = bs
local bv = Instance.new("UIGradient", bu)
bv.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1),
NumberSequenceKeypoint.new(0.5, 0),
NumberSequenceKeypoint.new(1, 1),
})
local bw = Instance.new("TextLabel")
bw.Size = UDim2.new(0, 0, 1, 0)
bw.AutomaticSize = Enum.AutomaticSize.X
bw.BackgroundTransparency = 1
bw.Font = Enum.Font.Gotham
bw.TextSize = 13
bw.TextColor3 = br
bw.RichText = true
bw.Parent = bs
local bx = Instance.new("Frame")
bx.AnchorPoint = Vector2.new(0.5, 0)
bx.Position = UDim2.new(0.5, 0, 0.5, 28)
bx.Size = UDim2.fromOffset(160, 0)
bx.AutomaticSize = Enum.AutomaticSize.Y
bx.BackgroundTransparency = 1
bx.Parent = aL
local by = Instance.new("UIListLayout", bx)
by.HorizontalAlignment = Enum.HorizontalAlignment.Center
by.SortOrder = Enum.SortOrder.LayoutOrder
local bz = {}
local function b(bA)
local bB = bz[bA]
if bB then
return bB
end
bB = Instance.new("TextLabel")
bB.LayoutOrder = bA
bB.Size = UDim2.fromOffset(160, 14)
bB.BackgroundTransparency = 1
bB.Font = Enum.Font.Gotham
bB.TextSize = 12
bB.TextStrokeTransparency = 0.45
bB.Visible = false
bB.Parent = bx
bz[bA] = bB
return bB
end
local bA = Instance.new("TextLabel")
bA.AnchorPoint = Vector2.new(0.5, 0.5)
bA.Position = UDim2.fromScale(0.5, 0.63)
bA.Size = UDim2.fromOffset(120, 22)
bA.BackgroundTransparency = 1
bA.Font = Enum.Font.Gotham
bA.TextSize = 18
bA.TextStrokeTransparency = 0.4
bA.Visible = false
bA.Parent = aL
local bB = {}
for bC, bD in pairs({
Left = {
"<",
-62,
0,
},
Right = {
">",
62,
0,
},
Back = {
"v",
0,
62,
},
}) do
local bE = Instance.new("TextLabel")
bE.AnchorPoint = Vector2.new(0.5, 0.5)
bE.Position = UDim2.new(0.5, bD[2], 0.5, bD[3])
bE.Size = UDim2.fromOffset(26, 26)
bE.BackgroundTransparency = 1
bE.Font = Enum.Font.Gotham
bE.TextSize = 22
bE.Text = ""
bE.TextStrokeTransparency = 1
bE.Visible = false
bE.Parent = aL
bB[bC] = bE
end
local bC, bD, bE, bF, bG = 0, 0, os.clock(), 0
local bH = 0
aa.connect(O.RenderStepped, function(bI)
bC = bC + 1
local bJ, bK = os.clock(), _.Character
local bL = bK and bK:FindFirstChild("HumanoidRootPart")
if bL and bI > 0 then
local bM = bL.Position
if bG then
local bN = bM - bG
local bO = math.sqrt(bN.X * bN.X + bN.Z * bN.Z) / bI
if bO < 200 then
bF = bF + (bO - bF) * math.min(bI * 12, 1)
end
end
bG = bM
else
bG, bF = nil, 0
end
bA.Visible = bo and bL ~= nil
if bA.Visible then
bA.Text = tostring(math.floor(bF + 0.5))
bA.TextColor3 = br:Lerp(bl, math.clamp((bF - 17) / 8, 0, 1))
end
if bJ - bH < 0.12 then
return
end
bH = bJ
if bJ - bE >= 0.5 then
bD = math.floor(bC / (bJ - bE) + 0.5)
bC, bE = 0, bJ
end
bs.Visible = bm
if bm then
bu.BackgroundColor3 = bl
local bM = 0
pcall(function()
bM = math.floor(_:GetNetworkPing() * 1000 + 0.5)
end)
local bN = '  <font color="#55555F">|</font>  '
bw.Text = '<b>NEVER<font color="'
.. (
y(bl)
.. (
'">PASTE</font></b>'
.. (
bN
.. (
_.Name
.. (bN .. (bD .. (" fps" .. (bN .. (bM .. (" ms" .. (bN .. os.date("%H:%M"))))))))
)
)
)
)
end
local bM = {}
if bn then
local bN = a7.server
if aC.rage then
local bO = aC.rageStatus
bM[#bM + 1] = {
bO and "RAGE  " .. bO or "RAGE",
(bO == "FIRE" or bO == nil) and bl or br,
}
end
if aC.silentAim and not aC.rage then
bM[#bM + 1] = {
"SILENT",
bl,
}
end
if aC.minDmgOverride then
bM[#bM + 1] = {
"DMG " .. aC.minDmgOverrideValue,
br,
}
end
if aC.forceBody then
bM[#bM + 1] = {
"BODY",
br,
}
end
if aC.bulletTp then
bM[#bM + 1] = {
"TP",
br,
}
end
if aC.tapKill then
bM[#bM + 1] = {
"TAP " .. aC.maxTaps,
br,
}
end
if aC.doubleTap then
bM[#bM + 1] = {
"DT",
aC.rageRemote and br or bq,
}
end
if aC.backtrack then
bM[#bM + 1] = {
"BT",
bN and bq or br,
}
end
if aC.forwardTrack then
bM[#bM + 1] = {
"FT",
bN and bq or br,
}
end
if aC.wallbang or aC.wallLimit then
bM[#bM + 1] = {
"WALL",
bN and bq or br,
}
end
if aC.killAll or aC.loopKill then
bM[#bM + 1] = {
"KILL",
Color3.fromRGB(255, 86, 110),
}
end
if aC.aa then
bM[#bM + 1] = {
aC.aaManual and "AA " .. aC.aaManual:upper()
or (aC.aaAutoSide and "AA AUTO " .. aC.aaAutoSide:upper() or "AA"),
br,
}
end
if aC.rapidFire then
bM[#bM + 1] = {
"RAPID",
br,
}
end
end
for bN, bO in ipairs(bM) do
local bP = b(bN)
bP.Text, bP.TextColor3, bP.Visible = bO[1], bO[2], true
end
for bN = #bM + 1, #bz, 1 do
bz[bN].Visible = false
end
local bN = bp and aC.aa
for bO, bP in pairs(bB) do
bP.Visible = bN
if bN then
local bQ = aC.aaManual == bO
bP.TextColor3 = bQ and bl or br
bP.TextTransparency = bQ and 0 or 0.65
end
end
end)
end
do
local bl = {}
for bm = 1, 4, 1 do
local bn = Instance.new("Frame")
bn.AnchorPoint = Vector2.new(0.5, 0.5)
bn.BorderSizePixel = 0
bn.Visible = false
bn.Parent = aL
local bo = Instance.new("UIStroke", bn)
bo.Color = Color3.new(0, 0, 0)
bo.Thickness = 1
bl[bm] = {
f = bn,
st = bo,
}
end
aa.connect(O.RenderStepped, function()
local bm = p()
local bn = aC.xhair and not (bm and bm.IsAiming)
for bo, bp in ipairs(bl) do
local bq = bn and not (aC.xhairT and bo == 3)
bp.f.Visible = bq
if bq then
local br, bs = bo <= 2, (bo % 2 == 1 and -1 or 1) * (aC.xhairGap + aC.xhairLen / 2)
bp.f.Size = br and UDim2.fromOffset(aC.xhairLen, aC.xhairThick)
or UDim2.fromOffset(aC.xhairThick, aC.xhairLen)
bp.f.Position = br and UDim2.new(0.5, bs, 0.5, 0) or UDim2.new(0.5, 0, 0.5, bs)
bp.f.BackgroundColor3 = aC.xhairColor
bp.st.Enabled = aC.xhairOutline
end
end
end)
local function E(bm)
local bn = Instance.new("Frame")
bn.AnchorPoint = Vector2.new(0.5, 0.5)
bn.Position = UDim2.fromScale(0.5, 0.5)
bn.Size = UDim2.fromOffset(60, 60)
bn.BackgroundTransparency = 1
bn.Parent = bm
local bo, bp = Instance.new("UIScale", bn), {}
for bq = 1, 4, 1 do
local br = Instance.new("Frame")
br.AnchorPoint = Vector2.new(0.5, 0.5)
br.BorderSizePixel = 0
br.BackgroundTransparency = 1
br.Parent = bn
local bs = Instance.new("UIStroke", br)
bs.Color = Color3.new(0, 0, 0)
bs.Thickness = 1
bs.Transparency = 1
bp[bq] = {
f = br,
st = bs,
}
end
local bq = Instance.new("Frame")
bq.AnchorPoint = Vector2.new(0.5, 0.5)
bq.Position = UDim2.fromScale(0.5, 0.5)
bq.BackgroundTransparency = 1
bq.Visible = false
bq.Parent = bn;
(Instance.new("UICorner", bq)).CornerRadius = UDim.new(1, 0)
local br = Instance.new("UIStroke", bq)
br.Transparency = 1
local bs = Instance.new("TextLabel")
bs.AnchorPoint = Vector2.new(0.5, 0)
bs.Size = UDim2.fromOffset(80, 16)
bs.BackgroundTransparency = 1
bs.Font = Enum.Font.Gotham
bs.TextSize = 13
bs.TextStrokeTransparency = 1
bs.TextTransparency = 1
bs.Parent = bn
return {
box = bn,
scale = bo,
lines = bp,
ring = bq,
ringStroke = br,
text = bs,
tweens = {},
}
end
local bm = 0.7071
local function x(bn, bo, bp, bq, br)
if bn == "Plus" then
local bs, bt, bu =
br + bp / 2, ({
{
-1,
0,
},
{ 1, 0 },
{
0,
-1,
},
{ 0, 1 },
})[bo], bo <= 2
return bt[1] * bs, bt[2] * bs, bu and bp or bq, bu and bq or bp, 0
elseif bn == "Square" then
local bs = br + bp
if bo == 1 then
return 0, -bs, bs * 2 + bq, bq, 0
end
if bo == 2 then
return 0, bs, bs * 2 + bq, bq, 0
end
if bo == 3 then
return -bs, 0, bq, bs * 2 + bq, 0
end
return bs, 0, bq, bs * 2 + bq, 0
end
local bs, bt, bu = bo % 2 == 1 and -1 or 1, bo <= 2 and -1 or 1, (br + bp / 2) * bm
return bs * bu, bt * bu, bp, bq, bs * bt > 0 and 45 or -45
end
local function R(bn, bo, bp, bq)
for br, bs in ipairs(bn.tweens) do
pcall(function()
bs:Cancel()
end)
end
bn.tweens = {}
local br, bs, bt, bu, bv, bw, bx =
math.max(aC.hitMarkerTime, 0.05),
aC.hitMarkerSize,
aC.hitMarkerThick,
aC.hitMarkerGap,
aC.hitMarkerShape,
aC.hitMarkerAnim,
bp and aC.hitMarkerKillScale or 1
local by, bz, bA =
TweenInfo.new(br, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
TweenInfo.new(br, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
TweenInfo.new(math.min(br, 0.18), Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local function N(bB, bC, bD)
local bE = ap:Create(bB, bC, bD)
bn.tweens[#bn.tweens + 1] = bE
bE:Play()
end
bn.box.Rotation = 0
bn.scale.Scale = bw == "Shrink" and bx * 2.2 or bx
if bw == "Shrink" then
N(bn.scale, bA, { Scale = bx })
end
if bw == "Spin" then
N(bn.box, bz, { Rotation = 90 })
end
local bB, bC = aC.hitMarkerOutline and 0.3 or 1, bv == "Circle"
bn.ring.Visible = bC
if bC then
local bD = (bu + bs) * 2
bn.ring.Size = UDim2.fromOffset(bD, bD)
bn.ringStroke.Color = bo
bn.ringStroke.Thickness = bt
bn.ringStroke.Transparency = 0
N(bn.ringStroke, by, { Transparency = 1 })
if bw == "Expand" then
N(bn.ring, bz, {
Size = UDim2.fromOffset(bD * 2.4, bD * 2.4),
})
end
end
for bD, bE in ipairs(bn.lines) do
bE.f.Visible = not bC
if not bC then
local bF, bG, bH, bI, bJ = x(bv, bD, bs, bt, bu)
bE.f.Size = UDim2.fromOffset(bH, bI)
bE.f.Rotation = bJ
bE.f.Position = UDim2.new(0.5, bF, 0.5, bG)
bE.f.BackgroundColor3 = bo
bE.f.BackgroundTransparency = 0
bE.st.Transparency = bB
N(bE.f, by, { BackgroundTransparency = 1 })
N(bE.st, by, { Transparency = 1 })
if bw == "Expand" then
N(bE.f, bz, {
Position = UDim2.new(0.5, bF * 2.4, 0.5, bG * 2.4),
})
end
end
end
local bD = aC.hitMarkerDamage and bq ~= nil
bn.text.Visible = bD
if bD then
bn.text.Position = UDim2.new(0.5, 0, 0.5, (bu + bs) + 6)
bn.text.Text = tostring(bq)
bn.text.TextColor3 = bo
bn.text.TextTransparency = 0
bn.text.TextStrokeTransparency = aC.hitMarkerOutline and 0.4 or 1
N(bn.text, by, {
TextTransparency = 1,
TextStrokeTransparency = 1,
})
end
end
local bn = E(aL)
local function r(bo, bp, bq, br)
local bs = aC.hitMarkerWhere
if bs ~= "Where It Landed" or not bp then
if setthreadidentity then
pcall(setthreadidentity, 8)
end
R(bn, bo, bq, br)
end
if bs ~= "Crosshair" and bp then
local bt, bu = math.max(aC.hitMarkerTime, 0.05), Instance.new("Part")
bu.Anchored, bu.CanCollide, bu.CanQuery, bu.CanTouch = true, false, false, false
bu.Transparency = 1
bu.Size = Vector3.new(0.1, 0.1, 0.1)
bu.CFrame = CFrame.new(bp)
bu.Parent = aS
local bv = Instance.new("BillboardGui")
bv.Size = UDim2.fromOffset(260, 260)
bv.ClipsDescendants = false
bv.AlwaysOnTop = true
bv.Adornee = bu
bv.Parent = bu
R(E(bv), bo, bq, br)
if aC.hitMarkerRise > 0 then
(ap:Create(bu, TweenInfo.new(bt, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
CFrame = CFrame.new(bp + Vector3.new(0, aC.hitMarkerRise, 0)),
})):Play()
end
as:AddItem(bu, bt + 0.1)
end
end
local function y(bo, bp)
local bq = Instance.new("Part")
bq.Anchored, bq.CanCollide, bq.CanQuery, bq.CanTouch = true, false, false, false
bq.Transparency = 1
bq.Size = Vector3.new(0.1, 0.1, 0.1)
bq.CFrame = CFrame.new(bo)
bq.Parent = aS
as:AddItem(bq, bp)
return bq
end
local function P(bo, bp, bq)
local br, bs = y(bo, 1.3), Instance.new("BillboardGui")
bs.Size = UDim2.fromOffset(120, 30)
bs.AlwaysOnTop = true
bs.StudsOffset = Vector3.new((math.random() - 0.5) * 1.5, 1, 0)
bs.Adornee = br
bs.Parent = br
local bt = Instance.new("TextLabel")
bt.Size = UDim2.fromScale(1, 1)
bt.BackgroundTransparency = 1
bt.Font = Enum.Font.Gotham
bt.TextSize = 20
bt.TextColor3 = bq
bt.TextStrokeTransparency = 0.2
bt.Text = bp
bt.Parent = bs
local bu = TweenInfo.new(1.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
(ap:Create(bs, bu, {
StudsOffset = bs.StudsOffset + Vector3.new(0, 3, 0),
})):Play();
(ap:Create(bt, bu, {
TextTransparency = 1,
TextStrokeTransparency = 1,
})):Play()
end
local function q(bo, bp)
local bq = Instance.new("Part")
bq.Shape = Enum.PartType.Ball
bq.Anchored, bq.CanCollide, bq.CanQuery, bq.CanTouch, bq.CastShadow = true, false, false, false, false
bq.Material = Enum.Material.ForceField
bq.Color = bp
bq.Size = Vector3.new(1, 1, 1)
bq.CFrame = CFrame.new(bo)
bq.Parent = aS
local br = Instance.new("Part")
br.Anchored, br.CanCollide, br.CanQuery, br.CanTouch, br.CastShadow = true, false, false, false, false
br.Material = Enum.Material.Neon
br.Color = bp
br.Size = Vector3.new(0.6, 60, 0.6)
br.CFrame = CFrame.new(bo + Vector3.new(0, 27, 0))
br.Parent = aS
local bs = TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
(ap:Create(bq, bs, {
Size = Vector3.new(11, 11, 11),
Transparency = 1,
})):Play();
(ap:Create(br, bs, {
Size = Vector3.new(0.05, 60, 0.05),
Transparency = 1,
})):Play()
as:AddItem(bq, 0.7)
as:AddItem(br, 0.7)
end
local bo = false
function a_.testMarker()
local bp = U()
aU.FilterDescendantsInstances = {
_.Character,
at,
}
local bq = workspace:Raycast(bp.Position, bp.LookVector * 300, aU)
bo = not bo
r(
bo and aC.hitMarkerKill or aC.hitMarkerColor,
bq and bq.Position or bp.Position + bp.LookVector * 30,
bo,
bo and 100 or 27
)
end
function a_.onConfirm(bp, bq, br, bs, bt)
local bu = bp == "kill"
if aC.hitMarker then
r(bu and aC.hitMarkerKill or aC.hitMarkerColor, bt, bu, math.floor(br + 0.5))
end
local bv = bs and bs:FindFirstChild("Head")
if not bv then
return
end
if aC.dmgNumbers then
P(bv.Position, "-" .. math.floor(br + 0.5), bu and aC.hitMarkerKill or aC.dmgColor)
end
if bu and aC.killFx then
local bw = bs:FindFirstChild("HumanoidRootPart") or bv
q(bw.Position, aC.killFxColor)
end
end
end
bk:Section({
Title = "hit effects",
})
bk:Toggle({
Title = "confirm mark",
Value = false,
Flag = "hitMarker",
Callback = function(bl)
aC.hitMarker = bl
end,
})
bk:Colorpicker({
Title = "hit marker tint",
Default = aC.hitMarkerColor,
Flag = "hitMarkerColor",
Callback = function(bl)
aC.hitMarkerColor = bl
end,
})
bk:Colorpicker({
Title = "kill marker tint",
Default = aC.hitMarkerKill,
Flag = "hitMarkerKill",
Callback = function(bl)
aC.hitMarkerKill = bl
end,
})
bk:Dropdown({
Title = "hit marker position",
Values = {
"Crosshair",
"Where It Landed",
"Both",
},
Value = "Crosshair",
Flag = "hitMarkerWhere",
Callback = function(bl)
aC.hitMarkerWhere = type(bl) == "table" and bl[1] or bl
end,
})
bk:Dropdown({
Title = "hit marker animation",
Values = {
"Fade",
"Expand",
"Shrink",
"Spin",
},
Value = "Fade",
Flag = "hitMarkerAnim",
Callback = function(bl)
aC.hitMarkerAnim = type(bl) == "table" and bl[1] or bl
end,
})
bk:Slider({
Title = "hit marker time (s)",
Value = {
Min = 0.1,
Max = 3,
Default = 0.45,
},
Step = 0.05,
Flag = "hitMarkerTime",
Callback = function(bl)
aC.hitMarkerTime = bl
end,
})
bk:Dropdown({
Title = "hit marker shape",
Values = {
"X",
"Plus",
"Square",
"Circle",
},
Value = "X",
Flag = "hitMarkerShape",
Callback = function(bl)
aC.hitMarkerShape = type(bl) == "table" and bl[1] or bl
end,
})
bk:Slider({
Title = "hit marker scale",
Value = {
Min = 2,
Max = 40,
Default = 10,
},
Flag = "hitMarkerSize",
Callback = function(bl)
aC.hitMarkerSize = bl
end,
})
bk:Slider({
Title = "hit marker weight",
Value = {
Min = 1,
Max = 8,
Default = 2,
},
Flag = "hitMarkerThick",
Callback = function(bl)
aC.hitMarkerThick = bl
end,
})
bk:Slider({
Title = "hit marker gap",
Value = {
Min = 0,
Max = 40,
Default = 4,
},
Flag = "hitMarkerGap",
Callback = function(bl)
aC.hitMarkerGap = bl
end,
})
bk:Toggle({
Title = "hit marker outline",
Value = true,
Flag = "hitMarkerOutline",
Callback = function(bl)
aC.hitMarkerOutline = bl
end,
})
bk:Slider({
Title = "kill marker scale",
Value = {
Min = 1,
Max = 3,
Default = 1.4,
},
Step = 0.1,
Flag = "hitMarkerKillScale",
Callback = function(bl)
aC.hitMarkerKillScale = bl
end,
})
bk:Toggle({
Title = "hit marker damage",
Value = false,
Flag = "hitMarkerDamage",
Callback = function(bl)
aC.hitMarkerDamage = bl
end,
})
bk:Slider({
Title = "world marker rise",
Value = {
Min = 0,
Max = 6,
Default = 0,
},
Step = 0.5,
Flag = "hitMarkerRise",
Callback = function(bl)
aC.hitMarkerRise = bl
end,
})
bk:Button({
Title = "test hit marker",
Callback = function()
if a_.testMarker then
a_.testMarker()
end
end,
})
bk:Section({
Title = "bullet tracer",
})
bk:Toggle({
Title = "bullet tracer",
Value = false,
Flag = "tracerEnabled",
Callback = function(bl)
aC.tracer = bl
end,
})
aF = bk:Colorpicker({
Title = "tracer tint",
Default = aD,
Flag = "tracerColor",
Callback = function(bl)
aD = bl
end,
})
bk:Slider({
Title = "tracer width",
Value = {
Min = 1,
Max = 30,
Default = 6,
},
Flag = "tracerWidth",
Callback = function(bl)
aC.tracerWidth = bl / 100
end,
})
bk:Slider({
Title = "tracer lifetime (s)",
Value = {
Min = 0.1,
Max = 10,
Default = 1,
},
Step = 0.1,
Flag = "tracerLife",
Callback = function(bl)
aC.tracerLife = bl
end,
})
bk:Dropdown({
Title = "tracer style",
Values = {
"Line",
"Beam",
"Lightning",
},
Value = "Line",
Flag = "tracerStyle",
Callback = function(bl)
aC.tracerStyle = type(bl) == "table" and bl[1] or bl
end,
})
bk:Dropdown({
Title = "tracer start",
Values = {
"Gun",
"Eye",
},
Value = "Gun",
Flag = "tracerFrom",
Callback = function(bl)
aC.tracerFrom = type(bl) == "table" and bl[1] or bl
end,
})
bk:Toggle({
Title = "rainbow tracers",
Value = false,
Flag = "tracerRainbow",
Callback = function(bl)
aC.tracerRainbow = bl
end,
})
bk:Toggle({
Title = "only on hits",
Value = false,
Flag = "tracerOnlyHits",
Callback = function(bl)
aC.tracerOnlyHits = bl
end,
})
bk:Toggle({
Title = "impact marker",
Value = false,
Flag = "impactEnabled",
Callback = function(bl)
aC.impact = bl
end,
})
bk:Slider({
Title = "impact scale",
Value = {
Min = 0.1,
Max = 1.5,
Default = 0.35,
},
Step = 0.05,
Flag = "impactSize",
Callback = function(bl)
aC.impactSize = bl
end,
})
bk:Toggle({
Title = "impact glow",
Value = false,
Flag = "impactGlow",
Callback = function(bl)
aC.impactGlow = bl
end,
})
aG = bk:Colorpicker({
Title = "impact tint",
Default = aE,
Flag = "impactColor",
Callback = function(bl)
aE = bl
end,
})
bk:Section({
Title = "impact audio",
})
bk:Toggle({
Title = "impact audio",
Value = false,
Flag = "hitSound",
Callback = function(bl)
aC.hitSound = bl
end,
})
bk:Input({
Title = "hit sound id",
Value = aC.hitSoundId,
Placeholder = "3744371342",
Flag = "hitSoundId",
Callback = function(bl)
aC.hitSoundId = bl
end,
})
bk:Slider({
Title = "hit volume",
Value = {
Min = 0,
Max = 100,
Default = 60,
},
Flag = "hitVol",
Callback = function(bl)
aC.hitVol = bl / 100
end,
})
bk:Button({
Title = "test hit sound",
Callback = function()
zT(aC.hitSoundId, aC.hitVol)
end,
})
bk:Section({
Title = "eliminate audio",
})
bk:Toggle({
Title = "eliminate audio",
Value = false,
Flag = "killSound",
Callback = function(bl)
aC.killSound = bl
end,
})
bk:Input({
Title = "kill sound id",
Value = aC.killSoundId,
Placeholder = "3744371342",
Flag = "killSoundId",
Callback = function(bl)
aC.killSoundId = bl
end,
})
bk:Slider({
Title = "kill volume",
Value = {
Min = 0,
Max = 100,
Default = 100,
},
Flag = "killVol",
Callback = function(bl)
aC.killVol = bl / 100
end,
})
bk:Button({
Title = "test kill sound",
Callback = function()
zT(aC.killSoundId, aC.killVol)
end,
})
do
bk:Section({
Title = "china hat",
})
local chinaHatOn = false
local chinaHatColor = Color3.fromRGB(255, 105, 180)
local chinaHatAlpha, chinaHatGlowPower = 0.1, 0.6
local chinaHatRainbow, chinaHatRainbowSpeed = false, 0.5
local chinaHatSpin = 0
local chinaHatStyle = "Classic"
local chinaHatToggle, chinaHatPart, chinaHatHead = nil, nil, nil
local chinaHatMesh, chinaHatLight = nil, nil
local chinaHatExtra = {}
local chinaHatTick = 0
local styleDefs = {
Classic = { mesh = "rbxassetid://1033714", scale = Vector3.new(1.7, 1.1, 1.7), offset = 0.25 },
Flat = { mesh = "rbxassetid://1033714", scale = Vector3.new(2.2, 0.55, 2.2), offset = 0.18 },
Tall = { mesh = "rbxassetid://1033714", scale = Vector3.new(1.4, 1.9, 1.4), offset = 0.35 },
Wide = { mesh = "rbxassetid://1033714", scale = Vector3.new(2.6, 0.9, 2.6), offset = 0.22 },
Spike = { mesh = "rbxassetid://1033714", scale = Vector3.new(1.1, 2.4, 1.1), offset = 0.4 },
Double = { mesh = "rbxassetid://1033714", scale = Vector3.new(1.7, 1.0, 1.7), offset = 0.25, layers = 2 },
NeonRing = { mesh = "rbxassetid://1033714", scale = Vector3.new(2.0, 0.35, 2.0), offset = 0.15 },
}
local function chinaHatClear()
if chinaHatPart then
chinaHatPart:Destroy()
chinaHatPart = nil
end
for _, p in ipairs(chinaHatExtra) do
pcall(function() p:Destroy() end)
end
chinaHatExtra = {}
chinaHatMesh, chinaHatLight, chinaHatHead = nil, nil, nil
end
local function chinaHatSyncLight()
if not chinaHatPart then
return
end
if chinaHatGlowPower > 0 then
if not chinaHatLight then
chinaHatLight = Instance.new("PointLight")
chinaHatLight.Name = "NightCCChinaHatLight"
chinaHatLight.Shadows = false
chinaHatLight.Parent = chinaHatPart
end
chinaHatLight.Color = chinaHatPart.Color
chinaHatLight.Brightness = 6 * chinaHatGlowPower
chinaHatLight.Range = 8 + 12 * chinaHatGlowPower
chinaHatLight.Enabled = true
elseif chinaHatLight then
chinaHatLight:Destroy()
chinaHatLight = nil
end
end
local function chinaHatApply()
if not chinaHatPart then
return
end
local def = styleDefs[chinaHatStyle] or styleDefs.Classic
chinaHatPart.Color = chinaHatColor
chinaHatPart.Material = Enum.Material.Neon
chinaHatPart.Transparency = chinaHatAlpha
if chinaHatMesh then
chinaHatMesh.Scale = def.scale
end
for _, p in ipairs(chinaHatExtra) do
if p and p.Parent then
p.Color = chinaHatColor
p.Transparency = chinaHatAlpha
end
end
chinaHatSyncLight()
end
local function makeHatPart(name, meshId, scale, color, alpha)
local bo = Instance.new("Part")
bo.Name = name
bo.Size = Vector3.new(1, 1, 1)
bo.Anchored = true
bo.CanCollide = false
bo.CanQuery = false
bo.CanTouch = false
bo.CastShadow = false
bo.Massless = true
bo.Material = Enum.Material.Neon
bo.Color = color
bo.Transparency = alpha
local bp = Instance.new("SpecialMesh")
bp.MeshType = Enum.MeshType.FileMesh
bp.MeshId = meshId
bp.TextureId = ""
bp.VertexColor = Vector3.new(1, 1, 1)
bp.Scale = scale
bp.Parent = bo
bo.Parent = workspace
return bo, bp
end
local function chinaHatMake()
chinaHatClear()
local bm = u.LocalPlayer.Character
if not bm then return end
local bn = bm:FindFirstChild("Head") or bm:WaitForChild("Head", 5)
if not bn then return end
chinaHatHead = bn
local def = styleDefs[chinaHatStyle] or styleDefs.Classic
chinaHatPart, chinaHatMesh = makeHatPart("NightCCChinaHat", def.mesh, def.scale, chinaHatColor, chinaHatAlpha)
if def.layers and def.layers >= 2 then
local p2, m2 = makeHatPart("NightCCChinaHatL2", def.mesh, def.scale * Vector3.new(0.72, 0.85, 0.72), chinaHatColor, math.min(chinaHatAlpha + 0.15, 0.85))
table.insert(chinaHatExtra, p2)
end
chinaHatSyncLight()
end
local function chinaHatSet(bm)
chinaHatOn = bm == true
if chinaHatOn then
chinaHatMake()
else
chinaHatClear()
end
end
chinaHatToggle = bk:Toggle({
Title = "china hat",
Value = false,
Flag = "chinaHat",
Callback = function(bm)
chinaHatSet(bm)
end,
})
bk:Dropdown({
Title = "china hat style",
Values = { "Classic", "Flat", "Tall", "Wide", "Spike", "Double", "NeonRing" },
Value = "Classic",
Flag = "chinaHatStyle",
Callback = function(bm)
chinaHatStyle = type(bm) == "table" and bm[1] or bm
if chinaHatOn then
chinaHatMake()
end
end,
})
bk:Slider({
Title = "china hat fade",
Value = {
Min = 0,
Max = 90,
Default = 10,
},
Flag = "chinaHatTransparency",
Callback = function(bm)
chinaHatAlpha = math.clamp((tonumber(bm) or 0) / 100, 0, 0.9)
chinaHatApply()
end,
})
bk:Slider({
Title = "china hat glow",
Value = {
Min = 0,
Max = 100,
Default = 60,
},
Flag = "chinaHatGlowPower",
Callback = function(bm)
chinaHatGlowPower = math.clamp((tonumber(bm) or 0) / 100, 0, 1)
chinaHatSyncLight()
end,
})
bk:Colorpicker({
Title = "china hat tint",
Default = chinaHatColor,
Flag = "chinaHatColor",
Callback = function(bm)
if typeof(bm) == "Color3" then
chinaHatColor = bm
end
chinaHatApply()
end,
})
bk:Toggle({
Title = "china hat rainbow",
Value = false,
Flag = "chinaHatRainbow",
Callback = function(bm)
chinaHatRainbow = bm == true
if not chinaHatRainbow then
chinaHatApply()
end
end,
})
bk:Slider({
Title = "rainbow tempo",
Value = {
Min = 1,
Max = 50,
Default = 5,
},
Flag = "chinaHatRainbowSpeed",
Callback = function(bm)
chinaHatRainbowSpeed = math.clamp((tonumber(bm) or 5) / 10, 0.1, 5)
end,
})
bk:Slider({
Title = "china hat spin",
Value = {
Min = 0,
Max = 50,
Default = 0,
},
Flag = "chinaHatSpin",
Callback = function(bm)
chinaHatSpin = math.clamp((tonumber(bm) or 0) / 10, 0, 5)
end,
})
aa.connect(O.Heartbeat, function()
local bm = os.clock()
if bm - chinaHatTick < 0.2 then
return
end
chinaHatTick = bm
if chinaHatToggle then
local bn, bo = pcall(function()
return chinaHatToggle:Get()
end)
if bn and type(bo) == "table" then
bo = bo.Value
end
if bn and type(bo) == "boolean" and bo ~= chinaHatOn then
chinaHatSet(bo)
end
end
local bn = u.LocalPlayer.Character
chinaHatHead = bn and bn:FindFirstChild("Head") or nil
if not chinaHatOn or not chinaHatHead then
chinaHatClear()
return
end
if not chinaHatPart then
chinaHatMake()
end
end)
aa.connect(O.RenderStepped, function()
if not (chinaHatPart and chinaHatPart.Parent and chinaHatHead and chinaHatHead.Parent) then
return
end
local def = styleDefs[chinaHatStyle] or styleDefs.Classic
local off = def.offset or 0.25
if chinaHatRainbow then
local bm = Color3.fromHSV((os.clock() * chinaHatRainbowSpeed) % 1, 1, 1)
chinaHatPart.Color = bm
if chinaHatLight then
chinaHatLight.Color = bm
end
for _, p in ipairs(chinaHatExtra) do
if p and p.Parent then
p.Color = bm
end
end
end
local spinAng = 0
if chinaHatSpin ~= 0 then
spinAng = (os.clock() * chinaHatSpin * 2 * math.pi) % (2 * math.pi)
end
local base = chinaHatHead.CFrame * CFrame.new(0, chinaHatHead.Size.Y * 0.5 + off, 0) * CFrame.Angles(0, spinAng, 0)
chinaHatPart.CFrame = base
for i, p in ipairs(chinaHatExtra) do
if p and p.Parent then
p.CFrame = chinaHatHead.CFrame * CFrame.new(0, chinaHatHead.Size.Y * 0.5 + off + 0.35 * i, 0) * CFrame.Angles(0, spinAng * 1.15, 0)
end
end
end)
aa.onUnload(chinaHatClear)
end
do
bk:Section({
Title = "entity orbs",
})
local orbsOn = false
local orbsCount = 4
local orbsRadius = 3.2
local orbsSpeed = 1.2
local orbsSize = 0.45
local orbsColor = Color3.fromRGB(255, 120, 200)
local orbsRainbow = false
local orbsRainbowSpeed = 0.6
local orbsGlow = 0.7
local orbsParts = {}
local orbsLights = {}
local orbsTick = 0
local orbsToggle = nil
local function orbsClear()
for _, p in ipairs(orbsParts) do
pcall(function() p:Destroy() end)
end
orbsParts = {}
orbsLights = {}
end
local function orbsMake()
orbsClear()
local char = u.LocalPlayer.Character
if not char then return end
local hrp = char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
for i = 1, orbsCount do
local p = Instance.new("Part")
p.Name = "night_ccOrb" .. i
p.Shape = Enum.PartType.Ball
p.Size = Vector3.new(orbsSize, orbsSize, orbsSize)
p.Anchored = true
p.CanCollide = false
p.CanQuery = false
p.CanTouch = false
p.CastShadow = false
p.Massless = true
p.Material = Enum.Material.Neon
p.Color = orbsColor
p.Transparency = 0.15
p.Parent = workspace
local light = Instance.new("PointLight")
light.Shadows = false
light.Brightness = 3 * orbsGlow
light.Range = 4 + 6 * orbsGlow
light.Color = orbsColor
light.Parent = p
orbsParts[#orbsParts + 1] = p
orbsLights[#orbsLights + 1] = light
end
end
local function orbsSet(v)
orbsOn = v == true
if orbsOn then
orbsMake()
else
orbsClear()
end
end
orbsToggle = bk:Toggle({
Title = "entity orbs",
Value = false,
Flag = "playerOrbs",
Callback = function(v)
orbsSet(v)
end,
})
bk:Slider({
Title = "orbs count",
Value = { Min = 1, Max = 12, Default = 4 },
Flag = "orbsCount",
Callback = function(v)
orbsCount = math.clamp(math.floor(tonumber(v) or 4), 1, 12)
if orbsOn then orbsMake() end
end,
})
bk:Slider({
Title = "orbs range",
Value = { Min = 1, Max = 10, Default = 3.2 },
Step = 0.1,
Flag = "orbsRadius",
Callback = function(v)
orbsRadius = tonumber(v) or 3.2
end,
})
bk:Slider({
Title = "orbs tempo",
Value = { Min = 0.1, Max = 5, Default = 1.2 },
Step = 0.1,
Flag = "orbsSpeed",
Callback = function(v)
orbsSpeed = tonumber(v) or 1.2
end,
})
bk:Slider({
Title = "orbs scale",
Value = { Min = 0.15, Max = 1.5, Default = 0.45 },
Step = 0.05,
Flag = "orbsSize",
Callback = function(v)
orbsSize = tonumber(v) or 0.45
for _, p in ipairs(orbsParts) do
if p and p.Parent then
p.Size = Vector3.new(orbsSize, orbsSize, orbsSize)
end
end
end,
})
bk:Colorpicker({
Title = "orbs tint",
Default = orbsColor,
Flag = "orbsColor",
Callback = function(v)
if typeof(v) == "Color3" then
orbsColor = v
end
for i, p in ipairs(orbsParts) do
if p and p.Parent and not orbsRainbow then
p.Color = orbsColor
if orbsLights[i] then orbsLights[i].Color = orbsColor end
end
end
end,
})
bk:Toggle({
Title = "orbs rainbow",
Value = false,
Flag = "orbsRainbow",
Callback = function(v)
orbsRainbow = v == true
end,
})
bk:Slider({
Title = "orbs rainbow tempo",
Value = { Min = 1, Max = 50, Default = 6 },
Flag = "orbsRainbowSpeed",
Callback = function(v)
orbsRainbowSpeed = math.clamp((tonumber(v) or 6) / 10, 0.1, 5)
end,
})
bk:Slider({
Title = "orbs glow",
Value = { Min = 0, Max = 100, Default = 70 },
Flag = "orbsGlow",
Callback = function(v)
orbsGlow = math.clamp((tonumber(v) or 0) / 100, 0, 1)
for _, l in ipairs(orbsLights) do
if l and l.Parent then
l.Brightness = 3 * orbsGlow
l.Range = 4 + 6 * orbsGlow
end
end
end,
})
aa.connect(O.Heartbeat, function()
local t = os.clock()
if t - orbsTick < 0.25 then return end
orbsTick = t
if orbsToggle then
local ok, val = pcall(function() return orbsToggle:Get() end)
if ok and type(val) == "table" then val = val.Value end
if ok and type(val) == "boolean" and val ~= orbsOn then
orbsSet(val)
end
end
local char = u.LocalPlayer.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if not orbsOn or not hrp then
orbsClear()
return
end
if #orbsParts ~= orbsCount then
orbsMake()
end
end)
aa.connect(O.RenderStepped, function(dt)
if not orbsOn or #orbsParts == 0 then return end
local char = u.LocalPlayer.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if not hrp then return end
local n = #orbsParts
local base = os.clock() * orbsSpeed
local cf = hrp.CFrame
for i, p in ipairs(orbsParts) do
if p and p.Parent then
local ring = ((i - 1) % 3)
local idx = math.floor((i - 1) / 3)
local perRing = math.max(1, math.ceil(n / 3))
local ang = base * (1 + ring * 0.15) + (i - 1) * (2 * math.pi / n)
local yOff = (ring - 1) * 1.15 + math.sin(base * 2 + i) * 0.25
local r = orbsRadius * (0.85 + ring * 0.12)
local localPos = Vector3.new(math.cos(ang) * r, yOff, math.sin(ang) * r)
local twist = math.sin(base * 0.9 + i * 0.4) * 0.35
localPos = localPos + Vector3.new(0, 0, 0)
local world = cf:PointToWorldSpace(localPos)
p.CFrame = CFrame.new(world)
if orbsRainbow then
local c = Color3.fromHSV((os.clock() * orbsRainbowSpeed + i * 0.08) % 1, 1, 1)
p.Color = c
if orbsLights[i] then orbsLights[i].Color = c end
end
end
end
end)
aa.onUnload(orbsClear)
end
do
local function __blk()
local Players_ = game:GetService("Players")
local RunService_ = game:GetService("RunService")
local UserInputService_ = game:GetService("UserInputService")
local LP_ = Players_.LocalPlayer
local avTab = ad:Tab({
Title = "avatar",
Icon = "sparkles",
})
local S = {
wings = false, wingStyle = "Angel", wingC1 = Color3.fromRGB(255, 255, 255), wingC2 = Color3.fromRGB(150, 200, 255),
wingRainbow = false, wingSize = 1, wingSpeed = 3, wingAmp = 25,
halo = false, haloColor = Color3.fromRGB(255, 220, 120), haloSize = 1, haloSpin = 1.5,
aura = false, auraC1 = Color3.fromRGB(150, 70, 255), auraC2 = Color3.fromRGB(80, 200, 255), auraRate = 30,
trail = false, trailC1 = Color3.fromRGB(150, 70, 255), trailC2 = Color3.fromRGB(80, 200, 255), trailLife = 0.7,
ring = false, ringColor = Color3.fromRGB(120, 200, 255), ringRadius = 4, ringSpin = 1,
fxRainbow = false,
shield = false, shieldColor = Color3.fromRGB(110, 190, 255), shieldSize = 1,
electric = false, electricColor = Color3.fromRGB(170, 210, 255),
gyro = false, gyroColor = Color3.fromRGB(255, 120, 220),
fire = false, fireC1 = Color3.fromRGB(255, 120, 30), fireC2 = Color3.fromRGB(255, 220, 90), fireSize = 7,
sparkles = false, sparkleColor = Color3.fromRGB(255, 240, 150),
ripples = false, rippleColor = Color3.fromRGB(120, 200, 255),
skel = false, skelColor = Color3.fromRGB(120, 255, 200),
outline = false, outlineColor = Color3.fromRGB(255, 80, 200),
dust = false, dustC1 = Color3.fromRGB(255, 220, 120), dustC2 = Color3.fromRGB(255, 120, 200),
}
local folder
local function getFolder()
local cam = workspace.CurrentCamera
if not cam then return nil end
if folder and folder.Parent == cam then return folder end
if folder then pcall(function() folder:Destroy() end) end
folder = Instance.new("Folder")
folder.Name = "NightCCAvatar"
folder.Parent = cam
return folder
end
local function newPart(parent, size, color, transparency)
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = Enum.Material.Neon
p.Color = color
p.Transparency = transparency or 0
p.Size = Vector3.new(math.max(size.X, 0.05), math.max(size.Y, 0.05), math.max(size.Z, 0.05))
p.Parent = parent
return p
end
local function bodyParts()
local char = LP_.Character
if not char or not char.Parent then return nil end
local root = char:FindFirstChild("HumanoidRootPart")
local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
local head = char:FindFirstChild("Head")
if not (root and torso and head) then return nil end
return char, root, torso, head
end
local function feetY(char, root)
local lf, rf = char:FindFirstChild("LeftFoot"), char:FindFirstChild("RightFoot")
if lf and rf then
return math.min(lf.Position.Y - lf.Size.Y / 2, rf.Position.Y - rf.Size.Y / 2)
end
return root.Position.Y - 3
end
local W = { parts = {}, key = nil, size = nil, c1 = nil, c2 = nil }
local function wingRecipe(style)
local R = {}
if style == "Angel" then
for row = 0, 1 do
local n = row == 0 and 9 or 7
for k = 0, n - 1 do
local f = k / (n - 1)
R[#R + 1] = {
kind = "feather", row = row, tn = f,
a = math.rad((row == 0 and 55 or 50) - 100 * f),
L = (row == 0 and 4.4 or 2.8) * (1 - (row == 0 and 0.45 or 0.4) * f),
w = row == 0 and 0.46 or 0.4, th = 0.05, transp = row == 0 and 0.12 or 0.05,
}
end
end
elseif style == "Demon" then
local boneL = { 4.9, 4.5, 4.0, 3.4, 2.7 }
for k = 0, 9 do
local f = k / 9
local bl = boneL[math.min(5, math.floor(f * 4) + 1)]
R[#R + 1] = {
kind = "feather", row = 0, tn = f, a = math.rad(80 - 70 * f),
L = bl * ((k % 2 == 0) and 0.82 or 0.7), w = 0.7, th = 0.03, transp = 0.45,
}
end
for k = 0, 4 do
R[#R + 1] = {
kind = "feather", row = 1, tn = k / 4, a = math.rad(86 - 20 * k),
L = boneL[k + 1], w = 0.16, th = 0.16, transp = 0,
}
end
elseif style == "Cyber" then
for k = 0, 6 do
local f = k / 6
R[#R + 1] = {
kind = "feather", row = 0, tn = f, a = math.rad(62 - 82 * f),
L = 3.8 - 2.0 * f, w = 0.55, th = 0.05, transp = 0.05,
}
end
else
R[#R + 1] = { kind = "ell", row = 0, tn = 0.0, cx = 1.5, cy = 1.0, w = 2.8, h = 3.2, tilt = math.rad(25), transp = 0.1 }
R[#R + 1] = { kind = "ell", row = 0, tn = 0.4, cx = 1.2, cy = -0.9, w = 2.1, h = 2.4, tilt = math.rad(-20), transp = 0.1 }
R[#R + 1] = { kind = "ell", row = 1, tn = 1.0, cx = 1.7, cy = 1.3, w = 1.0, h = 1.2, tilt = math.rad(25), transp = 0.05 }
R[#R + 1] = { kind = "ell", row = 1, tn = 1.0, cx = 1.3, cy = -1.0, w = 0.8, h = 0.9, tilt = math.rad(-20), transp = 0.05 }
end
return R
end
local function clearWings()
for _, rec in ipairs(W.parts) do
pcall(function() rec.part:Destroy() end)
end
W.parts, W.key, W.size, W.c1, W.c2 = {}, nil, nil, nil, nil
end
local function buildWings()
clearWings()
local f = getFolder()
if not f then return end
local recipe = wingRecipe(S.wingStyle)
for _, side in ipairs({ 1, -1 }) do
for _, r in ipairs(recipe) do
local p
if r.kind == "ell" then
p = newPart(f, Vector3.new(r.w, r.h, 0.05), S.wingC1, r.transp)
local m = Instance.new("SpecialMesh")
m.MeshType = Enum.MeshType.Sphere
m.Parent = p
else
p = newPart(f, Vector3.new(r.w, r.L, r.th), S.wingC1, r.transp)
end
W.parts[#W.parts + 1] = { side = side, r = r, part = p }
end
end
W.key = S.wingStyle
end
local function updateWings(torso, t)
if not S.wings then
if #W.parts > 0 then clearWings() end
return
end
if W.key ~= S.wingStyle or #W.parts == 0 then buildWings() end
local scale = S.wingSize
if W.size ~= scale then
for _, rec in ipairs(W.parts) do
local r = rec.r
local sx, sy, sz
if r.kind == "ell" then sx, sy, sz = r.w, r.h, 0.05 else sx, sy, sz = r.w, r.L, r.th end
rec.part.Size = Vector3.new(math.max(sx * scale, 0.05), math.max(sy * scale, 0.05), math.max(sz * scale, 0.05))
end
W.size = scale
end
if S.wingRainbow then
for _, rec in ipairs(W.parts) do
rec.part.Color = Color3.fromHSV((t * 0.2 + rec.r.tn * 0.35) % 1, 0.8, 1)
end
W.c1, W.c2 = nil, nil
elseif W.c1 ~= S.wingC1 or W.c2 ~= S.wingC2 then
for _, rec in ipairs(W.parts) do
rec.part.Color = S.wingC1:Lerp(S.wingC2, rec.r.tn)
end
W.c1, W.c2 = S.wingC1, S.wingC2
end
local flap = math.rad(8) + math.rad(S.wingAmp) * math.sin(t * S.wingSpeed)
local sweep = math.rad(22)
local base = torso.CFrame * CFrame.new(0, 0.35, 0.62)
local hinge = {}
for _, side in ipairs({ 1, -1 }) do
hinge[side] = base * CFrame.new(side * 0.3, 0, 0) * CFrame.Angles(0, -side * sweep, 0) * CFrame.Angles(0, 0, side * flap)
end
for _, rec in ipairs(W.parts) do
local r, side = rec.r, rec.side
local z = (r.row or 0) * 0.04 * scale
if r.kind == "ell" then
rec.part.CFrame = hinge[side] * CFrame.new(side * r.cx * scale, r.cy * scale, z) * CFrame.Angles(0, 0, side * r.tilt)
else
local dx, dy = side * math.cos(r.a), math.sin(r.a)
local half = r.L * scale / 2 + 0.12
rec.part.CFrame = hinge[side] * CFrame.new(dx * half, dy * half, z) * CFrame.Angles(0, 0, math.atan2(-dx, dy))
end
end
end
local function clearList(list)
for i = #list, 1, -1 do
pcall(function() list[i]:Destroy() end)
list[i] = nil
end
end
local function buildRing(list, n, radius, dash)
clearList(list)
local f = getFolder()
if not f then return end
local chord = 2 * radius * math.sin(math.pi / n) * dash
for i = 1, n do
list[i] = newPart(f, Vector3.new(0.12, 0.06, chord), Color3.new(1, 1, 1), 0)
end
end
local function placeRing(list, center, radius, spin, c1, c2, t)
local n = #list
for i, p in ipairs(list) do
local th = spin + (i - 1) * (2 * math.pi / n)
local pos = center + Vector3.new(math.cos(th) * radius, 0, math.sin(th) * radius)
local tangent = Vector3.new(-math.sin(th), 0, math.cos(th))
p.CFrame = CFrame.lookAt(pos, pos + tangent)
p.Color = c1:Lerp(c2, 0.5 + 0.5 * math.sin(th - t))
end
end
local HALO = { list = {}, key = nil }
local function updateHalo(head, t)
if not S.halo then
if #HALO.list > 0 then clearList(HALO.list); HALO.key = nil end
return
end
local R = 0.95 * S.haloSize
local key = tostring(R)
if HALO.key ~= key or #HALO.list == 0 then
buildRing(HALO.list, 18, R, 1.08)
HALO.key = key
end
local center = head.Position + Vector3.new(0, 1.15 + 0.06 * math.sin(t * 2), 0)
placeRing(HALO.list, center, R, t * S.haloSpin, S.haloColor, S.haloColor:Lerp(Color3.new(1, 1, 1), 0.65), t * 2)
end
local RING = { outer = {}, inner = {}, key = nil }
local function updateRing(char, root, t)
if not S.ring then
if #RING.outer > 0 then clearList(RING.outer); clearList(RING.inner); RING.key = nil end
return
end
local R = S.ringRadius
local key = tostring(R)
if RING.key ~= key or #RING.outer == 0 then
buildRing(RING.outer, 36, R, 0.62)
buildRing(RING.inner, 24, R * 0.7, 0.62)
RING.key = key
end
local p = root.Position
local center = Vector3.new(p.X, feetY(char, root) + 0.08, p.Z)
local c2 = S.ringColor:Lerp(Color3.new(1, 1, 1), 0.6)
placeRing(RING.outer, center, R, t * S.ringSpin, S.ringColor, c2, t)
placeRing(RING.inner, center, R * 0.7, -t * S.ringSpin * 1.4, c2, S.ringColor, t)
end
local A = { part = nil, em = nil, c1 = nil, c2 = nil }
local function clearAura()
if A.part then pcall(function() A.part:Destroy() end) end
A.part, A.em, A.c1, A.c2 = nil, nil, nil, nil
end
local function buildAura()
clearAura()
local f = getFolder()
if not f then return end
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Transparency = 1
p.Size = Vector3.new(2.6, 0.2, 2.6)
p.Parent = f
local e = Instance.new("ParticleEmitter")
e.Rate = S.auraRate
e.Lifetime = NumberRange.new(1.1, 1.7)
e.Speed = NumberRange.new(0.5, 1.5)
e.Acceleration = Vector3.new(0, 5, 0)
e.EmissionDirection = Enum.NormalId.Top
e.SpreadAngle = Vector2.new(10, 10)
e.LightEmission = 0.9
e.LockedToPart = false
e.Rotation = NumberRange.new(0, 360)
e.RotSpeed = NumberRange.new(-60, 60)
e.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(1, 0) })
e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
e.Color = ColorSequence.new(S.auraC1, S.auraC2)
e.Parent = p
A.part, A.em, A.c1, A.c2 = p, e, S.auraC1, S.auraC2
end
local function updateAura(char, root)
if not S.aura then
if A.part then clearAura() end
return
end
if not (A.part and A.part.Parent) then buildAura() end
if not A.part then return end
if A.c1 ~= S.auraC1 or A.c2 ~= S.auraC2 then
A.em.Color = ColorSequence.new(S.auraC1, S.auraC2)
A.c1, A.c2 = S.auraC1, S.auraC2
end
A.em.Rate = S.auraRate
local p = root.Position
A.part.CFrame = CFrame.new(p.X, feetY(char, root) + 0.2, p.Z)
end
local TR = { a0 = nil, a1 = nil, trail = nil, root = nil, c1 = nil, c2 = nil, life = nil }
local function clearTrail()
for _, k in ipairs({ "trail", "a0", "a1" }) do
if TR[k] then pcall(function() TR[k]:Destroy() end) end
TR[k] = nil
end
TR.root, TR.c1, TR.c2, TR.life = nil, nil, nil, nil
end
local function updateTrail(root)
if not S.trail then
if TR.trail then clearTrail() end
return
end
if TR.root ~= root or not (TR.trail and TR.trail.Parent) then
clearTrail()
local a0 = Instance.new("Attachment")
a0.Name = "NightCCTrail0"
a0.Position = Vector3.new(0, 1.2, 0)
a0.Parent = root
local a1 = Instance.new("Attachment")
a1.Name = "NightCCTrail1"
a1.Position = Vector3.new(0, -1.4, 0)
a1.Parent = root
local tr = Instance.new("Trail")
tr.Attachment0, tr.Attachment1 = a0, a1
tr.MinLength = 0.05
tr.FaceCamera = true
tr.LightEmission = 1
tr.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
tr.WidthScale = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) })
tr.Parent = root
TR.a0, TR.a1, TR.trail, TR.root = a0, a1, tr, root
end
if TR.c1 ~= S.trailC1 or TR.c2 ~= S.trailC2 then
TR.trail.Color = ColorSequence.new(S.trailC1, S.trailC2)
TR.c1, TR.c2 = S.trailC1, S.trailC2
end
if TR.life ~= S.trailLife then
TR.trail.Lifetime = S.trailLife
TR.life = S.trailLife
end
end
local function jointsWorld(model)
local function part(n) return model:FindFirstChild(n) end
local function top(p) return p.CFrame:PointToWorldSpace(Vector3.new(0, p.Size.Y / 2, 0)) end
local function bottom(p) return p.CFrame:PointToWorldSpace(Vector3.new(0, -p.Size.Y / 2, 0)) end
local head, ut, lt = part("Head"), part("UpperTorso"), part("LowerTorso")
if head and ut and lt then
local lua, lh, rua, rh = part("LeftUpperArm"), part("LeftHand"), part("RightUpperArm"), part("RightHand")
local lul, lf, rul, rf = part("LeftUpperLeg"), part("LeftFoot"), part("RightUpperLeg"), part("RightFoot")
if lua and lh and rua and rh and lul and lf and rul and rf then
return {
head = head.Position, neck = top(ut), pelvis = lt.Position,
ls = top(lua), rs = top(rua), lh = lh.Position, rh = rh.Position,
lhip = top(lul), rhip = top(rul), lf = lf.Position, rf = rf.Position,
}
end
end
local torso, la, ra, ll, rl = part("Torso"), part("Left Arm"), part("Right Arm"), part("Left Leg"), part("Right Leg")
if head and torso and la and ra and ll and rl then
return {
head = head.Position, neck = top(torso), pelvis = bottom(torso),
ls = top(la), rs = top(ra), lh = bottom(la), rh = bottom(ra),
lhip = top(ll), rhip = top(rl), lf = bottom(ll), rf = bottom(rl),
}
end
return nil
end
local function fxColor(base, t, off)
if S.fxRainbow then return Color3.fromHSV((t * 0.2 + (off or 0)) % 1, 0.8, 1) end
return base
end
local SH = { part = nil }
local function clearShield()
if SH.part then pcall(function() SH.part:Destroy() end) end
SH.part = nil
end
local function updateShield(root, t)
if not S.shield then
if SH.part then clearShield() end
return
end
if not (SH.part and SH.part.Parent) then
local f = getFolder()
if not f then return end
local p = Instance.new("Part")
p.Shape = Enum.PartType.Ball
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = Enum.Material.ForceField
p.Parent = f
SH.part = p
end
local d = 7.5 * S.shieldSize * (1 + 0.025 * math.sin(t * 3))
SH.part.Size = Vector3.new(d, d, d)
SH.part.CFrame = CFrame.new(root.Position)
SH.part.Color = fxColor(S.shieldColor, t, 0)
SH.part.Transparency = 0.3 + 0.1 * math.sin(t * 2)
end
local EL = { arcs = {}, nextRoll = 0 }
local function clearElectric()
for _, a in ipairs(EL.arcs) do
for _, p in ipairs(a.parts) do pcall(function() p:Destroy() end) end
end
EL.arcs = {}
end
local function rollArc(a)
local dir = Vector3.new(math.random() - 0.5, (math.random() - 0.5) * 1.2, math.random() - 0.5)
if dir.Magnitude < 0.05 then dir = Vector3.new(1, 0, 0) end
dir = dir.Unit
local s0 = dir * 1.0
local e0 = dir * (2.6 + math.random() * 1.2)
local pts = { s0 }
local n = #a.parts
for i = 1, n - 1 do
local f = i / n
local jitter = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * 1.1
pts[#pts + 1] = s0 + (e0 - s0) * f + jitter
end
pts[#pts + 1] = e0
a.pts = pts
end
local function updateElectric(torso, t)
if not S.electric then
if #EL.arcs > 0 then clearElectric() end
return
end
if #EL.arcs == 0 then
local f = getFolder()
if not f then return end
for i = 1, 4 do
local a = { parts = {}, pts = nil }
for k = 1, 5 do a.parts[k] = newPart(f, Vector3.new(0.1, 0.1, 1), S.electricColor, 0) end
rollArc(a)
EL.arcs[i] = a
end
end
if t >= EL.nextRoll then
EL.nextRoll = t + 0.07
for _, a in ipairs(EL.arcs) do
if math.random() < 0.6 then rollArc(a) end
end
end
local col = fxColor(S.electricColor, t, 0)
for _, a in ipairs(EL.arcs) do
for k, p in ipairs(a.parts) do
local w0 = torso.CFrame:PointToWorldSpace(a.pts[k])
local w1 = torso.CFrame:PointToWorldSpace(a.pts[k + 1])
local len = (w1 - w0).Magnitude
if len > 0.05 then
p.Size = Vector3.new(0.1, 0.1, len)
p.CFrame = CFrame.lookAt((w0 + w1) / 2, w1)
p.Color = col
end
end
end
end
local GY = { rings = { {}, {}, {} }, key = nil }
local function clearGyro()
for _, l in ipairs(GY.rings) do clearList(l) end
GY.key = nil
end
local function updateGyro(torso, t)
if not S.gyro then
if GY.key then clearGyro() end
return
end
if not GY.key then
local radii = { 2.6, 3.0, 3.4 }
for i, l in ipairs(GY.rings) do buildRing(l, 20, radii[i], 0.7) end
GY.key = "on"
end
local radii = { 2.6, 3.0, 3.4 }
local c = torso.Position
for i, l in ipairs(GY.rings) do
local ori = CFrame.new(c) * CFrame.Angles(t * (0.9 + i * 0.35), t * (0.6 + i * 0.25), math.rad(30 * i))
for k, p in ipairs(l) do
local th = (k - 1) * (2 * math.pi / #l)
local pos = ori * Vector3.new(math.cos(th) * radii[i], 0, math.sin(th) * radii[i])
local tan = ori:VectorToWorldSpace(Vector3.new(-math.sin(th), 0, math.cos(th)))
p.CFrame = CFrame.lookAt(pos, pos + tan)
p.Color = fxColor(S.gyroColor, t, (k / #l) * 0.5 + i * 0.1)
end
end
end
local FS = { fire = nil, sparkles = nil, root = nil, fireKey = nil }
local function clearFireSparkles()
for _, k in ipairs({ "fire", "sparkles" }) do
if FS[k] then pcall(function() FS[k]:Destroy() end) end
FS[k] = nil
end
FS.root, FS.fireKey = nil, nil
end
local function updateFireSparkles(torso, t)
if S.fire then
if not (FS.fire and FS.fire.Parent == torso) then
if FS.fire then pcall(function() FS.fire:Destroy() end) end
local f = Instance.new("Fire")
f.Name = "NightCCFire"
f.Heat = 8
f.Parent = torso
FS.fire, FS.fireKey = f, nil
end
local key = tostring(S.fireC1) .. tostring(S.fireC2) .. tostring(S.fireSize) .. tostring(S.fxRainbow and math.floor(t * 8) or 0)
if FS.fireKey ~= key then
FS.fire.Color = fxColor(S.fireC1, t, 0)
FS.fire.SecondaryColor = fxColor(S.fireC2, t, 0.15)
FS.fire.Size = S.fireSize
FS.fireKey = key
end
elseif FS.fire then
pcall(function() FS.fire:Destroy() end)
FS.fire = nil
end
if S.sparkles then
if not (FS.sparkles and FS.sparkles.Parent == torso) then
if FS.sparkles then pcall(function() FS.sparkles:Destroy() end) end
local sp = Instance.new("Sparkles")
sp.Name = "NightCCSparkles"
sp.Parent = torso
FS.sparkles = sp
end
FS.sparkles.SparkleColor = fxColor(S.sparkleColor, t, 0.3)
elseif FS.sparkles then
pcall(function() FS.sparkles:Destroy() end)
FS.sparkles = nil
end
end
local RP = { nextAt = 0 }
local function updateRipples(char, root, t)
if not S.ripples then return end
local hum = char:FindFirstChildOfClass("Humanoid")
if not hum or hum.FloorMaterial == Enum.Material.Air then return end
local v = root.AssemblyLinearVelocity
if Vector3.new(v.X, 0, v.Z).Magnitude < 3 or t < RP.nextAt then return end
RP.nextAt = t + 0.32
local f = getFolder()
if not f then return end
local p = root.Position
local disc = newPart(f, Vector3.new(0.12, 1.5, 1.5), fxColor(S.rippleColor, t, 0), 0.25)
disc.Shape = Enum.PartType.Cylinder
disc.CFrame = CFrame.new(p.X, feetY(char, root) + 0.08, p.Z) * CFrame.Angles(0, 0, math.pi / 2)
local tw = game:GetService("TweenService"):Create(disc, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Size = Vector3.new(0.12, 8, 8), Transparency = 1,
})
tw:Play()
game:GetService("Debris"):AddItem(disc, 0.7)
end
local SK = { parts = {} }
local SK_PAIRS = {
{ "head", "neck" }, { "neck", "pelvis" }, { "neck", "ls" }, { "neck", "rs" }, { "ls", "lh" },
{ "rs", "rh" }, { "pelvis", "lhip" }, { "pelvis", "rhip" }, { "lhip", "lf" }, { "rhip", "rf" },
}
local function clearSkel()
clearList(SK.parts)
end
local function updateSkel(char, t)
if not S.skel then
if #SK.parts > 0 then clearSkel() end
return
end
local J = jointsWorld(char)
if not J then return end
if #SK.parts == 0 then
local f = getFolder()
if not f then return end
for i = 1, #SK_PAIRS do SK.parts[i] = newPart(f, Vector3.new(0.12, 0.12, 1), S.skelColor, 0) end
end
for i, pr in ipairs(SK_PAIRS) do
local a, b = J[pr[1]], J[pr[2]]
local len = (b - a).Magnitude
local p = SK.parts[i]
if len > 0.05 then
p.Size = Vector3.new(0.12, 0.12, len)
p.CFrame = CFrame.lookAt((a + b) / 2, b)
end
p.Color = fxColor(S.skelColor, t, i * 0.05)
end
end
local OL = { hl = nil }
local function clearOutline()
if OL.hl then pcall(function() OL.hl:Destroy() end) end
OL.hl = nil
end
local function updateOutline(char, t)
if not S.outline then
if OL.hl then clearOutline() end
return
end
if not (OL.hl and OL.hl.Parent) then
local f = getFolder()
if not f then return end
local h = Instance.new("Highlight")
h.Adornee = char
h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
h.Parent = f
OL.hl = h
end
OL.hl.Adornee = char
local c = fxColor(S.outlineColor, t, 0)
OL.hl.OutlineColor = c
OL.hl.FillColor = c
OL.hl.OutlineTransparency = 0.1 + 0.25 * (0.5 + 0.5 * math.sin(t * 3))
OL.hl.FillTransparency = 0.82
end
local DU = { part = nil, em = nil, c1 = nil, c2 = nil }
local function clearDust()
if DU.part then pcall(function() DU.part:Destroy() end) end
DU.part, DU.em, DU.c1, DU.c2 = nil, nil, nil, nil
end
local function updateDust(root, t)
if not S.dust then
if DU.part then clearDust() end
return
end
if not (DU.part and DU.part.Parent) then
local f = getFolder()
if not f then return end
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Transparency = 1
p.Size = Vector3.new(6, 6, 6)
p.Parent = f
local e = Instance.new("ParticleEmitter")
e.Rate = 35
e.Lifetime = NumberRange.new(1.5, 2.6)
e.Speed = NumberRange.new(0.3, 1.2)
e.SpreadAngle = Vector2.new(180, 180)
e.LightEmission = 1
e.LockedToPart = false
e.Rotation = NumberRange.new(0, 360)
e.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.3, 0.35), NumberSequenceKeypoint.new(1, 0) })
e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.1), NumberSequenceKeypoint.new(1, 1) })
e.Parent = p
DU.part, DU.em = p, e
end
if DU.c1 ~= S.dustC1 or DU.c2 ~= S.dustC2 then
DU.em.Color = ColorSequence.new(S.dustC1, S.dustC2)
DU.c1, DU.c2 = S.dustC1, S.dustC2
end
DU.part.CFrame = CFrame.new(root.Position)
end
local lastChar, lastFolder, hadAny = nil, nil, false
local startT = os.clock()
local function clearAll()
clearWings()
clearList(HALO.list); HALO.key = nil
clearList(RING.outer); clearList(RING.inner); RING.key = nil
clearAura()
clearTrail()
clearShield()
clearElectric()
clearGyro()
clearFireSparkles()
clearSkel()
clearOutline()
clearDust()
end
aa.connect(RunService_.RenderStepped, function()
local anyOn = S.wings or S.halo or S.ring or S.aura or S.trail
or S.shield or S.electric or S.gyro or S.fire or S.sparkles or S.ripples or S.skel or S.outline or S.dust
local char, root, torso, head = bodyParts()
if not anyOn or not char or char:GetAttribute("Dead") == true then
if hadAny then clearAll(); hadAny = false end
return
end
hadAny = true
local f = getFolder()
if char ~= lastChar or f ~= lastFolder then
clearAll()
lastChar, lastFolder = char, f
end
local t = os.clock() - startT
updateWings(torso, t)
updateHalo(head, t)
updateRing(char, root, t)
updateAura(char, root)
updateTrail(root)
updateShield(root, t)
updateElectric(torso, t)
updateGyro(torso, t)
updateFireSparkles(torso, t)
updateRipples(char, root, t)
updateSkel(char, t)
updateOutline(char, t)
updateDust(root, t)
end)
aa.onUnload(function()
pcall(clearAll)
if folder then pcall(function() folder:Destroy() end) end
folder = nil
end)
local PV = { state = "Enemy", health = 73, armor = 60, modelMode = "My character" }
local PW, PH = 250, 330
local CX, Y0, BH = 125, 70, 150
local BW = math.floor(BH * 0.52)
local X0 = CX - math.floor(BW / 2)
local STAGE_H = PH - 24
local TW, AW, LW = 38, 18, 19
local HEAD_H, TORSO_H, ARM_H = 28, 60, 58
local SKIN = Color3.fromRGB(245, 205, 48)
local SHIRT = Color3.fromRGB(13, 105, 172)
local PANTS = Color3.fromRGB(164, 189, 71)
local pvGui, pvPanel, pvStage
local O = { seg = {}, out = {}, parts = {}, glow = {}, eyes = {}, bone = {} }
local function mk(class, props, parent)
local o = Instance.new(class)
for k, v in pairs(props) do o[k] = v end
o.Parent = parent
return o
end
local function ensureGrad(inst)
local g = inst:FindFirstChildOfClass("UIGradient")
if not g then
g = Instance.new("UIGradient")
g.Parent = inst
end
return g
end
local function dropGrad(inst)
local g = inst:FindFirstChildOfClass("UIGradient")
if g then g:Destroy() end
end
local function paintFrame(frame, on, c1, c2, rot, flat)
if on then
frame.BackgroundColor3 = Color3.new(1, 1, 1)
local g = ensureGrad(frame)
g.Color = ColorSequence.new(c1, c2)
g.Rotation = rot
else
dropGrad(frame)
frame.BackgroundColor3 = flat
end
end
local function paintText(lbl, on, c1, c2, flat)
if on then
lbl.TextColor3 = Color3.new(1, 1, 1)
local g = ensureGrad(lbl)
g.Color = ColorSequence.new(c1, c2)
g.Rotation = 90
else
dropGrad(lbl)
lbl.TextColor3 = flat
end
end
local function setLine(f, x1, y1, x2, y2, th, color)
local dx, dy = x2 - x1, y2 - y1
f.AnchorPoint = Vector2.new(0.5, 0.5)
f.Size = UDim2.fromOffset(math.sqrt(dx * dx + dy * dy), th)
f.Position = UDim2.fromOffset((x1 + x2) / 2, (y1 + y2) / 2)
f.Rotation = math.deg(math.atan2(dy, dx))
f.BackgroundColor3 = color
end
local function label(name, parent, z)
return mk("TextLabel", {
Name = name, BackgroundTransparency = 1, Font = Enum.Font.GothamMedium, TextSize = 12,
TextColor3 = Color3.new(1, 1, 1), TextStrokeTransparency = 0.6, TextStrokeColor3 = Color3.new(0, 0, 0),
Text = "", Visible = false, ZIndex = z or 8,
}, parent)
end
local MODEL = { vp = nil, cam = nil, clone = nil, base = nil, center = nil, stash = nil, jp = nil, srcChar = nil, active = false, dirty = true, chamsOn = false }
local function disposeModel()
if MODEL.clone then pcall(function() MODEL.clone:Destroy() end) end
MODEL.clone, MODEL.base, MODEL.stash, MODEL.active, MODEL.chamsOn = nil, nil, nil, false, false
end
local function buildModel()
disposeModel()
MODEL.dirty = false
if PV.modelMode ~= "My character" or not MODEL.vp then return end
local char = LP_.Character
MODEL.srcChar = char
if not (char and char.Parent and char:FindFirstChild("HumanoidRootPart")) then return end
local clone
local was = char.Archivable
pcall(function() char.Archivable = true; clone = char:Clone() end)
pcall(function() char.Archivable = was end)
if not clone then return end
for _, d in ipairs(clone:GetDescendants()) do
if d:IsA("BaseScript") or d:IsA("Sound") or d:IsA("ForceField") or d:IsA("Highlight") or d:IsA("ParticleEmitter")
or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Fire") or d:IsA("Smoke") or d:IsA("Sparkles") or d:IsA("PointLight")
or d:IsA("BillboardGui") then
pcall(function() d:Destroy() end)
end
end
local visible = 0
local stash = {}
for _, d in ipairs(clone:GetDescendants()) do
if d:IsA("BasePart") then
pcall(function() d.LocalTransparencyModifier = 0 end)
local e = { inst = d, Color = d.Color, Material = d.Material, Transparency = d.Transparency }
if d:IsA("MeshPart") then e.TextureID = d.TextureID end
stash[#stash + 1] = e
if d.Name ~= "HumanoidRootPart" and d.Transparency < 0.9 then visible = visible + 1 end
elseif d:IsA("SpecialMesh") then
stash[#stash + 1] = { inst = d, TextureId = d.TextureId }
elseif d:IsA("Decal") or d:IsA("Texture") then
stash[#stash + 1] = { inst = d, Transparency = d.Transparency }
end
end
if visible < 3 then
pcall(function() clone:Destroy() end)
return
end
clone.Parent = MODEL.vp
local root = clone:FindFirstChild("HumanoidRootPart")
local pivot = clone:GetPivot()
clone:PivotTo(CFrame.Angles(0, math.pi, 0) * root.CFrame:ToObjectSpace(pivot))
local bbCF, bbSize = clone:GetBoundingBox()
if bbSize.Y < 1 then
pcall(function() clone:Destroy() end)
return
end
MODEL.center = bbCF.Position
MODEL.base = clone:GetPivot()
MODEL.clone, MODEL.stash, MODEL.active = clone, stash, true
local cam = MODEL.cam
cam.FieldOfView = 30
local spp = bbSize.Y / BH
local dist = (STAGE_H * spp / 2) / math.tan(math.rad(cam.FieldOfView) / 2)
local camY = MODEL.center.Y - (STAGE_H / 2 - (Y0 + BH / 2)) * spp
cam.CFrame = CFrame.new(MODEL.center.X, camY, MODEL.center.Z + dist)
end
local function projectToStage(p)
local cam = MODEL.cam
local lp = cam.CFrame:PointToObjectSpace(p)
local depth = -lp.Z
if depth < 0.1 then return nil end
local th = math.tan(math.rad(cam.FieldOfView) / 2)
local x = (lp.X / (depth * th * (PW / STAGE_H))) * 0.5 + 0.5
local y = 0.5 - (lp.Y / (depth * th)) * 0.5
return { x * PW, y * STAGE_H }
end
local function setChams(on, color, transparency)
if not MODEL.stash then return end
if on then
for _, e in ipairs(MODEL.stash) do
local d = e.inst
pcall(function()
if d:IsA("BasePart") then
if e.Transparency < 0.9 then
d.Color, d.Material, d.Transparency = color, Enum.Material.Neon, transparency
end
if e.TextureID ~= nil then d.TextureID = "" end
elseif d:IsA("SpecialMesh") then
d.TextureId = ""
else
d.Transparency = 1
end
end)
end
MODEL.chamsOn = true
elseif MODEL.chamsOn then
for _, e in ipairs(MODEL.stash) do
for k, v in pairs(e) do
if k ~= "inst" then pcall(function() e.inst[k] = v end) end
end
end
MODEL.chamsOn = false
end
end
local function modelStep(t, chams, dc, dT)
if MODEL.srcChar ~= LP_.Character then MODEL.dirty = true end
if MODEL.dirty then buildModel() end
if MODEL.vp then MODEL.vp.Visible = MODEL.active end
if not (MODEL.active and MODEL.clone) then return nil end
local yaw = math.sin(t * 0.7) * 0.35
local ap = Vector3.new(MODEL.center.X, 0, MODEL.center.Z)
MODEL.clone:PivotTo(CFrame.new(ap) * CFrame.Angles(0, yaw, 0) * CFrame.new(-ap) * MODEL.base)
if chams then setChams(true, dc, math.clamp(dT, 0, 0.9)) else setChams(false) end
local jw = jointsWorld(MODEL.clone)
if not jw then return nil end
local out = {}
for k, v in pairs(jw) do
local pt = projectToStage(v)
if not pt then return nil end
out[k] = pt
end
return out
end
local function buildPreview()
if pvGui then return end
pvGui = mk("ScreenGui", { Name = "NightCCEspPreview", ResetOnSpawn = false, IgnoreGuiInset = true, DisplayOrder = 230, Enabled = false },
(gethui and gethui()) or game:GetService("CoreGui"))
pvPanel = mk("Frame", {
Name = "Panel", Size = UDim2.fromOffset(PW, PH), Position = UDim2.new(1, -PW - 12, 0.5, -PH / 2),
BackgroundColor3 = Color3.fromRGB(12, 12, 16), BorderSizePixel = 0,
}, pvGui)
mk("UICorner", { CornerRadius = UDim.new(0, 12) }, pvPanel)
local panelStroke = mk("UIStroke", { Color = Color3.new(1, 1, 1), Thickness = 1 }, pvPanel)
mk("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(104, 104, 140), Color3.fromRGB(38, 38, 52)) }, panelStroke)
local BAR_COL = Color3.fromRGB(22, 22, 32)
local bar = mk("Frame", { Name = "Title", Size = UDim2.new(1, 0, 0, 24), BackgroundColor3 = BAR_COL, BorderSizePixel = 0, ZIndex = 20 }, pvPanel)
mk("UICorner", { CornerRadius = UDim.new(0, 12) }, bar)
mk("Frame", { Name = "BarCover", Position = UDim2.new(0, 0, 1, -12), Size = UDim2.new(1, 0, 0, 12), BackgroundColor3 = BAR_COL, BorderSizePixel = 0, ZIndex = 20 }, bar)
O.dot = mk("Frame", { Name = "Dot", Position = UDim2.fromOffset(11, 8), Size = UDim2.fromOffset(8, 8), BackgroundColor3 = Color3.fromRGB(255, 60, 60), BorderSizePixel = 0, ZIndex = 21 }, bar)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, O.dot)
mk("TextLabel", {
Name = "TitleText", Position = UDim2.fromOffset(26, 0), Size = UDim2.new(1, -90, 1, 0), BackgroundTransparency = 1,
Font = Enum.Font.GothamBold, TextSize = 12, TextColor3 = Color3.fromRGB(235, 235, 245), Text = "ESP preview",
TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 21,
}, bar)
mk("TextLabel", {
Name = "DragHint", Position = UDim2.new(1, -64, 0, 0), Size = UDim2.fromOffset(54, 24), BackgroundTransparency = 1,
Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(110, 110, 130), Text = "drag",
TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 21,
}, bar)
O.accent = mk("Frame", { Name = "Accent", Position = UDim2.new(0, 0, 1, -1), Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.fromRGB(255, 60, 60), BackgroundTransparency = 0.55, BorderSizePixel = 0, ZIndex = 22 }, bar)
pvStage = mk("Frame", {
Name = "Stage", Position = UDim2.fromOffset(0, 24), Size = UDim2.fromOffset(PW, STAGE_H),
BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ClipsDescendants = true,
}, pvPanel)
mk("UICorner", { CornerRadius = UDim.new(0, 12) }, pvStage)
mk("UIGradient", { Rotation = 90, Color = ColorSequence.new(Color3.fromRGB(30, 30, 44), Color3.fromRGB(13, 13, 19)) }, pvStage)
mk("Frame", { Name = "StageTop", Size = UDim2.new(1, 0, 0, 14), BackgroundColor3 = Color3.fromRGB(30, 30, 44), BorderSizePixel = 0, ZIndex = 0 }, pvStage)
for i, sz in ipairs({ 232, 172, 118 }) do
local g = mk("Frame", {
Name = "Glow" .. i, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(CX, Y0 + 74), Size = UDim2.fromOffset(sz, sz),
BackgroundColor3 = Color3.fromRGB(255, 60, 60), BackgroundTransparency = 0.97 - i * 0.012, BorderSizePixel = 0, ZIndex = 0,
}, pvStage)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, g)
O.glow[i] = g
end
local floorY = Y0 + BH
local floor = mk("Frame", {
Name = "Floor", Position = UDim2.fromOffset(0, floorY), Size = UDim2.fromOffset(PW, math.max(STAGE_H - floorY, 1)),
BackgroundColor3 = Color3.fromRGB(130, 130, 165), BorderSizePixel = 0, ZIndex = 0,
}, pvStage)
mk("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(1, 1) }) }, floor)
mk("Frame", { Name = "Horizon", Position = UDim2.fromOffset(0, floorY), Size = UDim2.fromOffset(PW, 1), BackgroundColor3 = Color3.fromRGB(160, 160, 200), BackgroundTransparency = 0.78, BorderSizePixel = 0, ZIndex = 0 }, pvStage)
for i, sh in ipairs({ { 116, 18, 0.90 }, { 90, 13, 0.82 }, { 62, 8, 0.70 } }) do
local e = mk("Frame", {
Name = "Shadow" .. i, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(CX, floorY), Size = UDim2.fromOffset(sh[1], sh[2]),
BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = sh[3], BorderSizePixel = 0, ZIndex = 0,
}, pvStage)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, e)
end
local function part(name, x, y, w, h, base, corner)
local f = mk("Frame", {
Name = name, Position = UDim2.fromOffset(x, y), Size = UDim2.fromOffset(w, h),
BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, ZIndex = 1,
}, pvStage)
mk("UICorner", { CornerRadius = UDim.new(0, corner or 3) }, f)
local st = mk("UIStroke", { Color = Color3.new(0, 0, 0), Thickness = 1, Transparency = 0.55 }, f)
local normal = ColorSequence.new({
ColorSequenceKeypoint.new(0, base:Lerp(Color3.new(0, 0, 0), 0.18)),
ColorSequenceKeypoint.new(0.35, base:Lerp(Color3.new(1, 1, 1), 0.16)),
ColorSequenceKeypoint.new(1, base:Lerp(Color3.new(0, 0, 0), 0.30)),
})
local neutral = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(184, 184, 184)),
ColorSequenceKeypoint.new(0.35, Color3.new(1, 1, 1)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150)),
})
local g = mk("UIGradient", { Rotation = 0, Color = normal }, f)
local p = { f = f, g = g, st = st, normal = normal, neutral = neutral }
O.parts[#O.parts + 1] = p
return p
end
local legTop = Y0 + HEAD_H + TORSO_H
part("LegL", CX - LW, legTop, LW, BH - HEAD_H - TORSO_H, PANTS, 3)
part("LegR", CX, legTop, LW, BH - HEAD_H - TORSO_H, PANTS, 3)
part("Torso", CX - TW / 2, Y0 + HEAD_H, TW, TORSO_H, SHIRT, 4)
O.armL = part("ArmL", CX - TW / 2 - AW, Y0 + HEAD_H + 2, AW, ARM_H, SKIN, 4)
O.armR = part("ArmR", CX + TW / 2, Y0 + HEAD_H + 2, AW, ARM_H, SKIN, 4)
for _, a in ipairs({ O.armL, O.armR }) do
a.f.AnchorPoint = Vector2.new(0.5, 0)
a.f.Position = UDim2.fromOffset(a.f.Position.X.Offset + AW / 2, a.f.Position.Y.Offset)
end
local head = part("Head", CX - 14, Y0, 28, HEAD_H, SKIN, 9)
local faceCol = Color3.fromRGB(28, 28, 34)
for i, ex in ipairs({ 9, 19 }) do
local e = mk("Frame", {
Name = "Eye" .. i, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(ex, 12), Size = UDim2.fromOffset(3, 6),
BackgroundColor3 = faceCol, BorderSizePixel = 0, ZIndex = 2,
}, head.f)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, e)
O.eyes[i] = e
end
for i, m in ipairs({ { 14, 21, 9, 0 }, { 8, 19, 4, 45 }, { 20, 19, 4, -45 } }) do
local s = mk("Frame", {
Name = "Smile" .. i, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(m[1], m[2]), Size = UDim2.fromOffset(m[3], 2),
Rotation = m[4], BackgroundColor3 = faceCol, BorderSizePixel = 0, ZIndex = 2,
}, head.f)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, s)
end
MODEL.vp = mk("ViewportFrame", {
Name = "ModelView", Size = UDim2.fromOffset(PW, STAGE_H), BackgroundTransparency = 1, BorderSizePixel = 0,
Ambient = Color3.fromRGB(170, 170, 182), LightColor = Color3.fromRGB(255, 244, 228),
LightDirection = Vector3.new(0.3, -0.6, -1), Visible = false, ZIndex = 1,
}, pvStage)
MODEL.cam = mk("Camera", { FieldOfView = 30 }, MODEL.vp)
MODEL.vp.CurrentCamera = MODEL.cam
MODEL.dirty = true
O.fill = mk("Frame", { Name = "Fill", BorderSizePixel = 0, Visible = false, ZIndex = 2 }, pvStage)
for i = 1, 8 do
O.out[i] = mk("Frame", { Name = "Out" .. i, BorderSizePixel = 0, Visible = false, ZIndex = 3 }, pvStage)
O.seg[i] = mk("Frame", { Name = "Seg" .. i, BorderSizePixel = 0, Visible = false, ZIndex = 4 }, pvStage)
end
O.hpBack = mk("Frame", { Name = "HpBack", BorderSizePixel = 0, Visible = false, ZIndex = 5 }, pvStage)
O.hpBar = mk("Frame", { Name = "HpBar", BorderSizePixel = 0, Visible = false, ZIndex = 6 }, pvStage)
O.arBack = mk("Frame", { Name = "ArBack", BorderSizePixel = 0, Visible = false, ZIndex = 5 }, pvStage)
O.arBar = mk("Frame", { Name = "ArBar", BorderSizePixel = 0, Visible = false, ZIndex = 6 }, pvStage)
O.hpText = label("HpText", pvStage)
O.name = label("Name", pvStage)
O.weapon = label("Weapon", pvStage)
O.dist = label("Dist", pvStage)
O.flags = label("Flags", pvStage)
O.flags.RichText = true
O.flags.TextXAlignment = Enum.TextXAlignment.Left
O.flags.TextYAlignment = Enum.TextYAlignment.Top
O.status = mk("TextLabel", {
Name = "Status", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -4), Size = UDim2.new(1, -10, 0, 14),
BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 10, TextColor3 = Color3.fromRGB(130, 130, 150), Text = "", ZIndex = 8,
}, pvStage)
O.headDot = mk("Frame", { Name = "HeadDot", AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, BorderSizePixel = 0, Visible = false, ZIndex = 7 }, pvStage)
mk("UICorner", { CornerRadius = UDim.new(1, 0) }, O.headDot)
O.headStroke = mk("UIStroke", { Thickness = 1 }, O.headDot)
for i = 1, 10 do
O.bone[i] = mk("Frame", { Name = "Bone" .. i, BorderSizePixel = 0, Visible = false, ZIndex = 7 }, pvStage)
end
O.snap = mk("Frame", { Name = "Snap", BorderSizePixel = 0, Visible = false, ZIndex = 7 }, pvStage)
local dragging, dragStart, startPos = false, nil, nil
bar.InputBegan:Connect(function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging, dragStart, startPos = true, input.Position, pvPanel.Position
end
end)
aa.connect(UserInputService_.InputChanged, function(input)
if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
local d = input.Position - dragStart
pvPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
end
end)
aa.connect(UserInputService_.InputEnded, function(input)
if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
dragging = false
end
end)
end
local function previewColor()
local st = PV.state
if st == "Teammate" then return aC.espTeamColor end
if st == "Visible" and aC.espVisCheck then return aC.espVisColor end
if st == "Dormant" and aC.espDormant then return Color3.fromRGB(150, 150, 160) end
if aC.espColorMode == "Team Side" then
if st == "T side" then return aC.espTColor end
if st == "CT side" then return aC.espCTColor end
end
return aC.espEnemyColor
end
local function updatePreview(t)
local bC = previewColor() or Color3.fromRGB(255, 60, 60)
local black = Color3.new(0, 0, 0)
local chams = aC.espChams == true
local dc, dT = Color3.new(1, 1, 1), 0
if chams then
dc = aC.espChamsRainbow and Color3.fromHSV((t * 0.25) % 1, 0.8, 1) or (aC.espChamsColor or bC)
dT = math.clamp(aC.espChamsTransp or 0.2, 0, 0.9)
end
if O.lastChams ~= chams then
O.lastChams = chams
for _, p in ipairs(O.parts) do p.g.Color = chams and p.neutral or p.normal end
end
for _, p in ipairs(O.parts) do
p.f.BackgroundColor3 = dc
p.f.BackgroundTransparency = dT
p.st.Transparency = math.max(dT, 0.55)
end
local sw = math.sin(t * 1.7) * 4
O.armL.f.Rotation, O.armR.f.Rotation = sw, -sw
local eyeH = (t % 4.2) > 4.05 and 1 or 6
for _, e in ipairs(O.eyes) do e.Size = UDim2.fromOffset(3, eyeH) end
for _, g in ipairs(O.glow) do g.BackgroundColor3 = bC end
O.dot.BackgroundColor3, O.accent.BackgroundColor3 = bC, bC
local jointsReal = modelStep(t, chams, chams and dc or nil, dT)
for _, p in ipairs(O.parts) do p.f.Visible = not MODEL.active end
if aC.espBox then
local style = aC.espBoxStyle
local thick = math.clamp(math.floor(aC.espBoxThickness or 1), 1, 6)
local cap = math.max(math.floor(BH * 0.05), 1)
local segs
if style == "Static" or style == "Full" then
if style == "Full" then
thick = math.max(math.min(thick, cap), math.min(2, cap))
else
thick = math.min(thick, cap)
end
segs = {
{ X0, Y0, BW, thick }, { X0, Y0 + BH - thick, BW, thick },
{ X0, Y0, thick, BH }, { X0 + BW - thick, Y0, thick, BH },
}
else
thick = math.min(thick, cap)
local bw, bh = math.ceil(BW * 0.25), math.ceil(BH * 0.25)
segs = {
{ X0, Y0, bw, thick }, { X0, Y0, thick, bh },
{ X0 + BW - bw, Y0, bw, thick }, { X0 + BW - thick, Y0, thick, bh },
{ X0, Y0 + BH - thick, bw, thick }, { X0, Y0 + BH - bh, thick, bh },
{ X0 + BW - bw, Y0 + BH - thick, bw, thick }, { X0 + BW - thick, Y0 + BH - bh, thick, bh },
}
end
for i = 1, 8 do
local s, o, g = segs[i], O.out[i], O.seg[i]
if s then
g.Visible = true
g.Position, g.Size = UDim2.fromOffset(s[1], s[2]), UDim2.fromOffset(s[3], s[4])
paintFrame(g, aC.espBoxGrad, aC.espBoxGradColor or bC, aC.espBoxGradColor2 or bC, 90, bC)
o.Visible = aC.espBoxOutline == true
o.Position, o.Size = UDim2.fromOffset(s[1] - 1, s[2] - 1), UDim2.fromOffset(s[3] + 2, s[4] + 2)
o.BackgroundColor3 = aC.espBoxOutlineColor or black
o.BackgroundTransparency = 0.25
else
g.Visible, o.Visible = false, false
end
end
else
for i = 1, 8 do O.seg[i].Visible, O.out[i].Visible = false, false end
end
O.fill.Visible = aC.espBoxFill == true
if O.fill.Visible then
O.fill.Position, O.fill.Size = UDim2.fromOffset(X0, Y0), UDim2.fromOffset(BW, BH)
paintFrame(O.fill, aC.espFillGrad, aC.espFillGradColor or bC, aC.espFillGradColor2 or aC.espFillGradColor or bC, 90, bC)
O.fill.BackgroundTransparency = math.clamp(tonumber(aC.espFill) or 0.6, 0, 1)
end
local near = math.clamp(BH / 120, 0.55, 1.15)
local b_ = math.max(math.floor((aC.espTextSize or 12) * near + 0.5), 8)
local hp = PV.health
local hbSide = aC.espHealthSide == "Right"
local hbW = math.clamp(math.min(math.floor(aC.espHealthWidth or 2), math.floor(BH * 0.035)), 1, 6)
local hbOut = aC.espHealthOutline == true
local hbPad = hbOut and 2 or 0
O.hpBack.Visible = aC.espHealth == true and hbOut
O.hpBar.Visible = aC.espHealth == true
O.hpText.Visible = aC.espHealth == true and aC.espHealthText == true and hp < 100
if aC.espHealth then
local barH = math.max(math.floor(BH * hp / 100), 1)
local hbX = hbSide and (X0 + BW + hbPad) or (X0 - hbW - hbPad)
if hbOut then
O.hpBack.Position, O.hpBack.Size = UDim2.fromOffset(hbX - 1, Y0 - 1), UDim2.fromOffset(hbW + 2, BH + 2)
O.hpBack.BackgroundColor3, O.hpBack.BackgroundTransparency = black, 0.35
end
O.hpBar.Position, O.hpBar.Size = UDim2.fromOffset(hbX, Y0 + BH - barH), UDim2.fromOffset(hbW, barH)
local hpLow = aC.espHealthColorLow or Color3.fromRGB(255, 60, 60)
local hpMax = aC.espHealthColorMax or Color3.fromRGB(90, 255, 110)
if aC.espHealthGrad then
O.hpBar.BackgroundColor3 = Color3.new(1, 1, 1)
local g = ensureGrad(O.hpBar)
g.Rotation = 90
g.Color = ColorSequence.new(hpMax, hpLow)
else
dropGrad(O.hpBar)
O.hpBar.BackgroundColor3 = hpLow:Lerp(hpMax, hp / 100)
end
if O.hpText.Visible then
O.hpText.AnchorPoint = Vector2.new(hbSide and 0 or 1, 0.5)
O.hpText.Position = UDim2.fromOffset(hbSide and (hbX + hbW + 4) or (hbX - 4), Y0 + BH - barH / 2)
O.hpText.Size = UDim2.fromOffset(30, 10)
O.hpText.TextXAlignment = hbSide and Enum.TextXAlignment.Left or Enum.TextXAlignment.Right
O.hpText.TextSize = math.max(math.floor(((aC.espTextSize or 12) - 2) * near), 8)
O.hpText.TextColor3 = Color3.new(1, 1, 1)
O.hpText.Text = tostring(hp)
end
end
local y = Y0 + BH + 2
local showArmor = aC.espArmor == true and PV.armor > 0
O.arBack.Visible, O.arBar.Visible = showArmor, showArmor
if showArmor then
local arH = math.clamp(math.floor(BH * 0.04), 2, 4)
O.arBack.Position, O.arBack.Size = UDim2.fromOffset(X0 - 1, y), UDim2.fromOffset(BW + 2, arH + 2)
O.arBack.BackgroundColor3, O.arBack.BackgroundTransparency = black, 0.35
O.arBar.Position = UDim2.fromOffset(X0, y + 1)
O.arBar.Size = UDim2.fromOffset(math.max(math.floor(BW * math.clamp(PV.armor, 0, 100) / 100), 1), arH)
local arLow = aC.espArmorColorLow or Color3.fromRGB(255, 120, 60)
local arMax = aC.espArmorColorMax or Color3.fromRGB(140, 220, 255)
if aC.espArmorGrad then
O.arBar.BackgroundColor3 = Color3.new(1, 1, 1)
local g = ensureGrad(O.arBar)
g.Rotation = 0
g.Color = ColorSequence.new(arLow, arMax)
else
dropGrad(O.arBar)
O.arBar.BackgroundColor3 = arLow:Lerp(arMax, math.clamp(PV.armor, 0, 100) / 100)
end
y = y + arH + 3
end
local tgOn = aC.espTextGrad == true
local tgC1 = aC.espTextGradColor or Color3.new(1, 1, 1)
local tgC2 = aC.espTextGradColor2 or Color3.fromRGB(120, 180, 255)
local dormant = PV.state == "Dormant" and aC.espDormant == true
O.name.Visible = aC.espNames == true
if O.name.Visible then
O.name.AnchorPoint = Vector2.new(0.5, 0)
O.name.Position = UDim2.fromOffset(CX, (Y0 - b_) - 4)
O.name.Size = UDim2.fromOffset(200, b_ + 2)
O.name.TextSize = b_
O.name.Text = dormant and (LP_.DisplayName .. "  3s ago") or LP_.DisplayName
paintText(O.name, tgOn, tgC1, tgC2, dormant and bC or Color3.new(1, 1, 1))
end
O.weapon.Visible = aC.espWeapon == true
if O.weapon.Visible then
O.weapon.AnchorPoint = Vector2.new(0.5, 0)
O.weapon.Position = UDim2.fromOffset(CX, y)
O.weapon.Size = UDim2.fromOffset(200, b_ + 2)
O.weapon.TextSize = b_
O.weapon.Text = "AK-47"
paintText(O.weapon, tgOn, tgC1, tgC2, bC)
y = y + b_ + 1
end
O.dist.Visible = aC.espDistance == true
if O.dist.Visible then
O.dist.AnchorPoint = Vector2.new(0.5, 0)
O.dist.Position = UDim2.fromOffset(CX, y)
O.dist.Size = UDim2.fromOffset(200, b_ + 2)
O.dist.TextSize = math.max(b_ - 1, 8)
O.dist.Text = "42m"
paintText(O.dist, tgOn, tgC1, tgC2, Color3.fromRGB(210, 210, 215))
end
O.flags.Visible = aC.espFlags == true
if O.flags.Visible then
local function tag(color, text)
return tgOn and text or ('<font color="%s">%s</font>'):format(color, text)
end
local lines = { tag("#7CE38B", "$4750"), tag("#6FB4FF", "HK"), tag("#D0D0D8", "DUCK") }
local b4 = math.max(b_ - 2, 8)
O.flags.AnchorPoint = Vector2.new(0, 0)
O.flags.Position = UDim2.fromOffset(X0 + BW + 4, Y0 - 1)
O.flags.Size = UDim2.fromOffset(70, #lines * (b4 + 2) + 2)
O.flags.TextSize = b4
O.flags.Text = table.concat(lines, "\n")
paintText(O.flags, tgOn, tgC1, tgC2, Color3.new(1, 1, 1))
end
O.headDot.Visible = aC.espHeadDot == true
if O.headDot.Visible then
local d = math.max(math.floor(BH * 0.13), 3)
local hx, hy = CX, Y0 + 14
if jointsReal then hx, hy = jointsReal.head[1], jointsReal.head[2] end
O.headDot.Position, O.headDot.Size = UDim2.fromOffset(hx, hy), UDim2.fromOffset(d, d)
O.headStroke.Color = bC
end
local AY = Y0 + HEAD_H + 2
local function hand(px, deg)
local r = math.rad(deg)
return { px - ARM_H * math.sin(r), AY + ARM_H * math.cos(r) }
end
local pelvisY = Y0 + HEAD_H + TORSO_H
local armOff = TW / 2 + AW / 2
local J = {
head = { CX, Y0 + HEAD_H / 2 }, neck = { CX, Y0 + HEAD_H }, pelvis = { CX, pelvisY },
ls = { CX - TW / 2, AY + 3 }, rs = { CX + TW / 2, AY + 3 },
lh = hand(CX - armOff, sw), rh = hand(CX + armOff, -sw),
lhip = { CX - LW / 2, pelvisY + 2 }, rhip = { CX + LW / 2, pelvisY + 2 },
lf = { CX - LW / 2, Y0 + BH - 2 }, rf = { CX + LW / 2, Y0 + BH - 2 },
}
if jointsReal then J = jointsReal end
local pairsList = {
{ "head", "neck" }, { "neck", "pelvis" }, { "neck", "ls" }, { "neck", "rs" }, { "ls", "lh" },
{ "rs", "rh" }, { "pelvis", "lhip" }, { "pelvis", "rhip" }, { "lhip", "lf" }, { "rhip", "rf" },
}
for i, pr in ipairs(pairsList) do
local f = O.bone[i]
f.Visible = aC.espSkeleton == true
if f.Visible then
local a, b = J[pr[1]], J[pr[2]]
setLine(f, a[1], a[2], b[1], b[2], 1, bC)
end
end
O.snap.Visible = aC.espSnap == true
if O.snap.Visible then
local fromY = aC.espSnapFrom == "Top" and 0 or aC.espSnapFrom == "Center" and STAGE_H / 2 or STAGE_H
setLine(O.snap, CX + 40, fromY, CX, Y0 + BH, 1, bC)
end
O.status.Text = (aC.esp and "overlay: on" or "overlay: off (enable it in display)") .. "  |  " .. (MODEL.active and "your character" or "stylized model")
end
aa.connect(RunService_.RenderStepped, function()
if not (pvGui and pvGui.Enabled) then return end
pcall(updatePreview, os.clock() - startT)
end)
aa.onUnload(function()
disposeModel()
if pvGui then pcall(function() pvGui:Destroy() end) end
pvGui = nil
end)
local function pick(v)
if type(v) == "table" then v = v[1] end
return tostring(v)
end
;(function()
local Lighting_ = game:GetService("Lighting")
local SoundService_ = game:GetService("SoundService")
local ST = {
on = false, rain = true, amount = 90, rainColor = Color3.fromRGB(175, 205, 255),
lightning = true, every = 8, flash = true, flashPower = 0.35, gloom = true,
puddle = true, puddleSize = 9, prints = true, shine = true, mist = true,
thunderId = "", thunderVol = 0.8,
}
local RADIUS = 26
local MIST_TEXTURE = "rbxasset://textures/particles/smoke_main.dds"
local rng = Random.new()
local stormFolder
local drops, rings, prints, bolts, puddleParts = {}, {}, {}, {}, {}
local wet = setmetatable({}, { __mode = "k" })
local cc, mist
local groundY, groundOk, sheltered, lastSheltered = 0, false, false, nil
local nextBolt, flashT0, nextRing, lastPrintT, printSide, wetAt = 0, -10, 0, 0, 1, 0
local active = false
local rayParams = RaycastParams.new()
rayParams.FilterType = Enum.RaycastFilterType.Exclude
local function mkPart(parent, size, color, transp, mat)
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = mat or Enum.Material.Neon
p.Color = color
p.Transparency = transp
p.Size = Vector3.new(math.max(size.X, 0.05), math.max(size.Y, 0.05), math.max(size.Z, 0.05))
p.Parent = parent
return p
end
local function folderGet()
local cam = workspace.CurrentCamera
if not cam then return nil end
if stormFolder and stormFolder.Parent == cam then return stormFolder end
if stormFolder then pcall(function() stormFolder:Destroy() end) end
drops, rings, prints, bolts, puddleParts, mist = {}, {}, {}, {}, {}, nil
lastSheltered = nil
stormFolder = Instance.new("Folder")
stormFolder.Name = "NightCCStorm"
stormFolder.Parent = cam
return stormFolder
end
local function wetBody(char, on)
if on and char then
for _, p in ipairs(char:GetDescendants()) do
if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and wet[p] == nil then
wet[p] = p.Reflectance
p.Reflectance = math.max(p.Reflectance, 0.28)
end
end
else
for p, r in pairs(wet) do
if p.Parent then pcall(function() p.Reflectance = r end) end
wet[p] = nil
end
end
end
local function clearStorm()
wetBody(nil, false)
if stormFolder then pcall(function() stormFolder:Destroy() end) end
stormFolder = nil
drops, rings, prints, bolts, puddleParts, mist = {}, {}, {}, {}, {}, nil
lastSheltered = nil
if cc then pcall(function() cc:Destroy() end) end
cc = nil
end
local function respawnDrop(d, ox, oz, y)
local a = rng:NextNumber(0, math.pi * 2)
local r = math.sqrt(rng:NextNumber()) * RADIUS
d.x, d.z, d.y = ox + math.cos(a) * r, oz + math.sin(a) * r, y
d.v = rng:NextNumber(62, 88)
end
local function ensureDrops(f, count)
while #drops < count do
local p = mkPart(f, Vector3.new(0.05, 1.5, 0.05), ST.rainColor, 0.55)
drops[#drops + 1] = { part = p, x = 0, y = 0, z = 0, v = 70, fresh = true }
end
while #drops > count do
local d = table.remove(drops)
pcall(function() d.part:Destroy() end)
end
end
local PUD = { { 1.0, 0.82, 0.03 }, { 0.72, 0.7, 0.045 }, { 0.46, 0.55, 0.06 } }
local function ensurePuddle(f)
if #puddleParts == 3 and puddleParts[1].Parent then return end
for _, p in ipairs(puddleParts) do pcall(function() p:Destroy() end) end
puddleParts = {}
for i = 1, 3 do
local p = mkPart(f, Vector3.new(0.05, 4, 4), Color3.fromRGB(18, 26, 40), 0.8, Enum.Material.SmoothPlastic)
p.Shape = Enum.PartType.Cylinder
p.Reflectance = 0.5
puddleParts[i] = p
end
end
local function updatePuddle(root, t, on)
for i, p in ipairs(puddleParts) do
if on and groundOk then
local d = ST.puddleSize * PUD[i][1] * (1 + 0.03 * math.sin(t * 1.7 + i))
p.Size = Vector3.new(0.05, d, d)
p.CFrame = CFrame.new(root.Position.X, groundY + PUD[i][3], root.Position.Z) * CFrame.Angles(0, 0, math.pi / 2)
p.Transparency = PUD[i][2]
else
p.Transparency = 1
end
end
end
local function spawnRing(f, x, y, z, life, maxD, t)
local r
for _, c in ipairs(rings) do
if not c.active then r = c break end
end
if not r then
if #rings >= 36 then return end
local p = mkPart(f, Vector3.new(0.05, 0.4, 0.4), Color3.new(1, 1, 1), 1)
p.Shape = Enum.PartType.Cylinder
r = { part = p, active = false }
rings[#rings + 1] = r
end
r.active, r.t0, r.life, r.maxD, r.x, r.y, r.z = true, t, life, maxD, x, y, z
r.part.Color = ST.rainColor:Lerp(Color3.new(1, 1, 1), 0.5)
end
local function updateRings(t)
for _, r in ipairs(rings) do
if r.active then
local a = (t - r.t0) / r.life
if a >= 1 then
r.active = false
r.part.Transparency = 1
else
local d = 0.3 + r.maxD * a
r.part.Size = Vector3.new(0.05, d, d)
r.part.CFrame = CFrame.new(r.x, r.y, r.z) * CFrame.Angles(0, 0, math.pi / 2)
r.part.Transparency = 0.35 + 0.65 * a
end
end
end
end
local function updatePrints(f, root, t)
for _, pr in ipairs(prints) do
if pr.active then
local a = (t - pr.t0) / 5
if a >= 1 then
pr.active = false
pr.part.Transparency = 1
else
pr.part.Transparency = 0.45 + 0.55 * a
end
end
end
if not ST.prints or not groundOk or t - lastPrintT < 0.28 then return end
local v = root.AssemblyLinearVelocity
if Vector3.new(v.X, 0, v.Z).Magnitude < 4 then return end
lastPrintT = t
printSide = -printSide
local pr
for _, c in ipairs(prints) do
if not c.active then pr = c break end
end
if not pr then
if #prints >= 24 then return end
local p = mkPart(f, Vector3.new(0.05, 1.1, 1.1), Color3.fromRGB(12, 18, 28), 1, Enum.Material.SmoothPlastic)
p.Shape = Enum.PartType.Cylinder
p.Reflectance = 0.5
pr = { part = p, active = false }
prints[#prints + 1] = pr
end
pr.active, pr.t0 = true, t
local pos = root.Position + root.CFrame.RightVector * (0.6 * printSide)
pr.part.CFrame = CFrame.new(pos.X, groundY + 0.05, pos.Z) * CFrame.Angles(0, 0, math.pi / 2)
pr.part.Transparency = 0.45
end
local function boltPath(a, b, n, jitter)
local pts = { a }
for i = 1, n - 1 do
local k = i / n
local j = jitter * (1 - k * 0.6)
pts[#pts + 1] = a:Lerp(b, k) + Vector3.new(rng:NextNumber(-j, j), 0, rng:NextNumber(-j, j))
end
pts[#pts + 1] = b
return pts
end
local function playThunder(dist)
local id = tostring(ST.thunderId or ""):gsub("%D", "")
if id == "" then return end
task.delay(0.25 + dist * 0.012, function()
if not ST.on then return end
local s = Instance.new("Sound")
s.SoundId = "rbxassetid://" .. id
s.Volume = ST.thunderVol
s.PlaybackSpeed = rng:NextNumber(0.85, 1.05)
s.Parent = SoundService_
s:Play()
task.delay(15, function() if s.Parent then s:Destroy() end end)
end)
end
local function strike(f, root, t)
local ang = rng:NextNumber(0, math.pi * 2)
local dist = rng:NextNumber(35, 110)
local g = Vector3.new(root.Position.X + math.cos(ang) * dist, groundY, root.Position.Z + math.sin(ang) * dist)
local top = g + Vector3.new(rng:NextNumber(-18, 18), 130, rng:NextNumber(-18, 18))
local parts = {}
local function addPath(pts, w)
for i = 1, #pts - 1 do
local a0, b0 = pts[i], pts[i + 1]
local len = (b0 - a0).Magnitude
if len > 0.05 then
local up = math.abs((b0 - a0).Unit.Y) > 0.999 and Vector3.zAxis or Vector3.yAxis
local p = mkPart(f, Vector3.new(w, w, len), Color3.fromRGB(215, 230, 255), 0)
p.CFrame = CFrame.lookAt(a0, b0, up) * CFrame.new(0, 0, -len / 2)
parts[#parts + 1] = p
end
end
end
local main = boltPath(top, g, 16, 9)
addPath(main, 0.55)
for _ = 1, rng:NextInteger(1, 2) do
local s = main[rng:NextInteger(5, 11)]
local e = s + Vector3.new(rng:NextNumber(-30, 30), -rng:NextNumber(25, 50), rng:NextNumber(-30, 30))
addPath(boltPath(s, e, 6, 4), 0.28)
end
bolts[#bolts + 1] = { parts = parts, t0 = t }
flashT0 = t
playThunder(dist)
end
local function updateBolts(t)
for i = #bolts, 1, -1 do
local b = bolts[i]
local age = t - b.t0
if age > 0.5 then
for _, p in ipairs(b.parts) do pcall(function() p:Destroy() end) end
table.remove(bolts, i)
else
local flick = (age < 0.12 or (age > 0.18 and age < 0.3)) and 0 or 0.7
local tr = math.clamp(flick + (age / 0.5) * 0.3, 0, 1)
for _, p in ipairs(b.parts) do p.Transparency = tr end
end
end
end
local function updateScreen(t)
if not (ST.flash or ST.gloom) then
if cc then cc.Enabled = false end
return
end
if not cc or not cc.Parent then
cc = Instance.new("ColorCorrectionEffect")
cc.Name = "NightCCStormCC"
cc.Parent = Lighting_
end
cc.Enabled = true
local age = t - flashT0
local pulse = 0
if age >= 0 and age < 0.9 then
pulse = math.exp(-age * 9)
if age > 0.14 then pulse = math.max(pulse, 0.7 * math.exp(-(age - 0.14) * 7)) end
end
cc.Brightness = (ST.gloom and -0.06 or 0) + (ST.flash and pulse * ST.flashPower or 0)
cc.Saturation = ST.gloom and -0.25 or 0
cc.Contrast = ST.gloom and 0.06 or 0
cc.TintColor = ST.gloom and Color3.fromRGB(205, 218, 240) or Color3.new(1, 1, 1)
end
local function updateMist(f, root, on)
if on then
if not mist or not mist.Parent then
local p = mkPart(f, Vector3.new(16, 0.5, 16), Color3.new(1, 1, 1), 1, Enum.Material.SmoothPlastic)
local e = Instance.new("ParticleEmitter")
e.Texture = MIST_TEXTURE
e.Rate = 7
e.Lifetime = NumberRange.new(3, 5)
e.Speed = NumberRange.new(0.4, 1)
e.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 6), NumberSequenceKeypoint.new(1, 13) })
e.Transparency = NumberSequence.new({
NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.25, 0.86), NumberSequenceKeypoint.new(1, 1),
})
e.Color = ColorSequence.new(Color3.fromRGB(200, 210, 225))
e.LightInfluence = 0.6
e.Parent = p
mist = p
end
mist.CFrame = CFrame.new(root.Position.X, groundY + 0.8, root.Position.Z)
elseif mist then
pcall(function() mist:Destroy() end)
mist = nil
end
end
aa.connect(RunService_.RenderStepped, function(dt)
if not ST.on then
if active then clearStorm(); active = false end
return
end
local char, root = bodyParts()
if not char or char:GetAttribute("Dead") == true then
if active then clearStorm(); active = false end
return
end
local f = folderGet()
if not f then return end
active = true
local t = os.clock()
local rp = root.Position
rayParams.FilterDescendantsInstances = { char, f }
local hit = workspace:Raycast(rp, Vector3.new(0, -14, 0), rayParams)
if hit then groundY, groundOk = hit.Position.Y, true else groundOk = false end
sheltered = workspace:Raycast(rp, Vector3.new(0, 60, 0), rayParams) ~= nil
if ST.rain then
ensureDrops(f, math.floor(ST.amount))
if sheltered ~= lastSheltered then
lastSheltered = sheltered
for _, d in ipairs(drops) do d.part.Transparency = sheltered and 1 or 0.55 end
end
local prs, cfs = {}, {}
for i, d in ipairs(drops) do
if d.fresh then
d.fresh = false
respawnDrop(d, rp.X, rp.Z, groundY + rng:NextNumber(0, 26))
end
d.y = d.y - d.v * dt
local dx, dz = d.x - rp.X, d.z - rp.Z
if d.y < groundY or dx * dx + dz * dz > RADIUS * RADIUS * 1.2 then
respawnDrop(d, rp.X, rp.Z, groundY + 24 + rng:NextNumber(0, 6))
end
prs[i] = d.part
cfs[i] = CFrame.new(d.x, d.y, d.z) * CFrame.Angles(0, 0, 0.1)
end
pcall(workspace.BulkMoveTo, workspace, prs, cfs, Enum.BulkMoveMode.FireCFrameChanged)
elseif #drops > 0 then
ensureDrops(f, 0)
end
if ST.puddle then ensurePuddle(f) end
updatePuddle(root, t, ST.puddle)
if ST.puddle and ST.rain and groundOk and not sheltered and t >= nextRing then
nextRing = t + 1 / math.max(ST.amount * 0.35, 4)
local a = rng:NextNumber(0, math.pi * 2)
local r = math.sqrt(rng:NextNumber()) * ST.puddleSize * 0.5
spawnRing(f, rp.X + math.cos(a) * r, groundY + 0.07, rp.Z + math.sin(a) * r, 0.55, 1.6, t)
end
updateRings(t)
updatePrints(f, root, t)
if ST.shine then
if t >= wetAt then
wetAt = t + 1
wetBody(char, true)
end
elseif next(wet) ~= nil then
wetBody(nil, false)
end
if ST.lightning and t >= nextBolt then
if nextBolt ~= 0 and groundOk then strike(f, root, t) end
nextBolt = t + ST.every * rng:NextNumber(0.5, 1.5)
end
updateBolts(t)
updateScreen(t)
updateMist(f, root, ST.mist and groundOk)
end)
aa.onUnload(function()
ST.on = false
pcall(clearStorm)
end)
avTab:Section({ Title = "storm and wet floor" })
avTab:Toggle({ Title = "storm", Value = false, Flag = "avStorm", Callback = function(v)
ST.on = v
if v then nextBolt = 0 end
end })
avTab:Toggle({ Title = "rain", Value = true, Flag = "avStormRain", Callback = function(v) ST.rain = v end })
avTab:Slider({ Title = "rain amount", Value = { Min = 20, Max = 200, Default = 90 }, Flag = "avStormAmount",
Callback = function(v) ST.amount = math.clamp(math.floor(tonumber(v) or 90), 20, 200) end })
avTab:Colorpicker({ Title = "rain color", Default = ST.rainColor, Flag = "avStormRainColor", Callback = function(c)
ST.rainColor = c
for _, d in ipairs(drops) do d.part.Color = c end
end })
avTab:Toggle({ Title = "lightning", Value = true, Flag = "avStormBolt", Callback = function(v) ST.lightning = v end })
avTab:Slider({ Title = "lightning every (s)", Value = { Min = 3, Max = 20, Default = 8 }, Flag = "avStormEvery",
Callback = function(v) ST.every = math.clamp(tonumber(v) or 8, 3, 20) end })
avTab:Toggle({ Title = "screen flash", Value = true, Flag = "avStormFlash", Callback = function(v) ST.flash = v end })
avTab:Slider({ Title = "flash strength", Value = { Min = 0, Max = 100, Default = 35 }, Flag = "avStormFlashPower",
Callback = function(v) ST.flashPower = math.clamp((tonumber(v) or 35) / 100, 0, 1) end })
avTab:Toggle({ Title = "storm gloom", Value = true, Flag = "avStormGloom", Callback = function(v) ST.gloom = v end })
avTab:Toggle({ Title = "wet floor puddle", Value = true, Flag = "avStormPuddle", Callback = function(v) ST.puddle = v end })
avTab:Slider({ Title = "puddle size", Value = { Min = 4, Max = 16, Default = 9 }, Flag = "avStormPuddleSize",
Callback = function(v) ST.puddleSize = math.clamp(tonumber(v) or 9, 4, 16) end })
avTab:Toggle({ Title = "wet footprints", Value = true, Flag = "avStormPrints", Callback = function(v) ST.prints = v end })
avTab:Toggle({ Title = "wet body shine", Value = true, Flag = "avStormShine", Callback = function(v) ST.shine = v end })
avTab:Toggle({ Title = "ground mist", Value = true, Flag = "avStormMist", Callback = function(v) ST.mist = v end })
avTab:Input({ Title = "thunder sound id (empty = off)", Value = "", Placeholder = "numeric asset id", Flag = "avStormThunderId",
Callback = function(v) ST.thunderId = tostring(v or "") end })
avTab:Slider({ Title = "thunder volume", Value = { Min = 0, Max = 100, Default = 80 }, Flag = "avStormThunderVol",
Callback = function(v) ST.thunderVol = math.clamp((tonumber(v) or 80) / 100, 0, 1) end })
end)()
avTab:Section({ Title = "esp preview" })
avTab:Toggle({
Title = "show esp preview", Value = false, Flag = "avEspPreview",
Callback = function(v)
if v then buildPreview(); MODEL.dirty = true end
if pvGui then pvGui.Enabled = v end
end,
})
avTab:Dropdown({
Title = "preview player", Values = { "Enemy", "Teammate", "Visible", "Dormant", "T side", "CT side" }, Value = "Enemy", Flag = "avPreviewState",
Callback = function(v) PV.state = pick(v) end,
})
avTab:Slider({
Title = "preview health", Value = { Min = 1, Max = 100, Default = 73 }, Flag = "avPreviewHealth",
Callback = function(v) PV.health = math.clamp(math.floor(tonumber(v) or 73), 1, 100) end,
})
avTab:Slider({
Title = "preview armor", Value = { Min = 0, Max = 100, Default = 60 }, Flag = "avPreviewArmor",
Callback = function(v) PV.armor = math.clamp(math.floor(tonumber(v) or 60), 0, 100) end,
})
avTab:Dropdown({
Title = "preview model", Values = { "My character", "Stylized" }, Value = "My character", Flag = "avPreviewModel",
Callback = function(v)
PV.modelMode = pick(v)
MODEL.dirty = true
end,
})
avTab:Button({ Title = "refresh preview model", Callback = function() MODEL.dirty = true end })
avTab:Section({ Title = "wings" })
avTab:Toggle({ Title = "wings", Value = false, Flag = "avWings", Callback = function(v) S.wings = v end })
avTab:Dropdown({
Title = "wing style", Values = { "Angel", "Demon", "Cyber", "Butterfly" }, Value = "Angel", Flag = "avWingStyle",
Callback = function(v) S.wingStyle = pick(v) end,
})
avTab:Colorpicker({ Title = "wing color", Default = S.wingC1, Flag = "avWingC1", Callback = function(c) S.wingC1 = c end })
avTab:Colorpicker({ Title = "wing tip color", Default = S.wingC2, Flag = "avWingC2", Callback = function(c) S.wingC2 = c end })
avTab:Toggle({ Title = "wing rainbow", Value = false, Flag = "avWingRainbow", Callback = function(v) S.wingRainbow = v end })
avTab:Slider({
Title = "wing size x10", Value = { Min = 5, Max = 25, Default = 10 }, Flag = "avWingSize",
Callback = function(v) S.wingSize = math.clamp((tonumber(v) or 10) / 10, 0.5, 2.5) end,
})
avTab:Slider({
Title = "flap speed", Value = { Min = 0, Max = 12, Default = 3 }, Flag = "avWingSpeed",
Callback = function(v) S.wingSpeed = tonumber(v) or 3 end,
})
avTab:Slider({
Title = "flap angle", Value = { Min = 0, Max = 60, Default = 25 }, Flag = "avWingAmp",
Callback = function(v) S.wingAmp = tonumber(v) or 25 end,
})
avTab:Section({ Title = "halo and ground ring" })
avTab:Toggle({ Title = "halo", Value = false, Flag = "avHalo", Callback = function(v) S.halo = v end })
avTab:Colorpicker({ Title = "halo color", Default = S.haloColor, Flag = "avHaloColor", Callback = function(c) S.haloColor = c end })
avTab:Slider({
Title = "halo size x10", Value = { Min = 6, Max = 20, Default = 10 }, Flag = "avHaloSize",
Callback = function(v) S.haloSize = math.clamp((tonumber(v) or 10) / 10, 0.6, 2) end,
})
avTab:Toggle({ Title = "ground ring", Value = false, Flag = "avRing", Callback = function(v) S.ring = v end })
avTab:Colorpicker({ Title = "ring color", Default = S.ringColor, Flag = "avRingColor", Callback = function(c) S.ringColor = c end })
avTab:Slider({
Title = "ring radius", Value = { Min = 2, Max = 9, Default = 4 }, Flag = "avRingRadius",
Callback = function(v) S.ringRadius = math.clamp(tonumber(v) or 4, 2, 9) end,
})
avTab:Section({ Title = "aura and trail" })
avTab:Toggle({ Title = "aura", Value = false, Flag = "avAura", Callback = function(v) S.aura = v end })
avTab:Colorpicker({ Title = "aura color", Default = S.auraC1, Flag = "avAuraC1", Callback = function(c) S.auraC1 = c end })
avTab:Colorpicker({ Title = "aura color 2", Default = S.auraC2, Flag = "avAuraC2", Callback = function(c) S.auraC2 = c end })
avTab:Slider({
Title = "aura density", Value = { Min = 5, Max = 80, Default = 30 }, Flag = "avAuraRate",
Callback = function(v) S.auraRate = tonumber(v) or 30 end,
})
avTab:Toggle({ Title = "trail", Value = false, Flag = "avTrail", Callback = function(v) S.trail = v end })
avTab:Colorpicker({ Title = "trail color", Default = S.trailC1, Flag = "avTrailC1", Callback = function(c) S.trailC1 = c end })
avTab:Colorpicker({ Title = "trail color 2", Default = S.trailC2, Flag = "avTrailC2", Callback = function(c) S.trailC2 = c end })
avTab:Slider({
Title = "trail length x10", Value = { Min = 2, Max = 20, Default = 7 }, Flag = "avTrailLife",
Callback = function(v) S.trailLife = math.clamp((tonumber(v) or 7) / 10, 0.2, 2) end,
})
avTab:Section({ Title = "energy effects" })
avTab:Toggle({ Title = "rainbow for new effects", Value = false, Flag = "avFxRainbow", Callback = function(v) S.fxRainbow = v end })
avTab:Toggle({ Title = "energy shield", Value = false, Flag = "avShield", Callback = function(v) S.shield = v end })
avTab:Colorpicker({ Title = "shield color", Default = S.shieldColor, Flag = "avShieldColor", Callback = function(c) S.shieldColor = c end })
avTab:Slider({
Title = "shield size x10", Value = { Min = 6, Max = 20, Default = 10 }, Flag = "avShieldSize",
Callback = function(v) S.shieldSize = math.clamp((tonumber(v) or 10) / 10, 0.6, 2) end,
})
avTab:Toggle({ Title = "electric arcs", Value = false, Flag = "avElectric", Callback = function(v) S.electric = v end })
avTab:Colorpicker({ Title = "arc color", Default = S.electricColor, Flag = "avElectricColor", Callback = function(c) S.electricColor = c end })
avTab:Toggle({ Title = "gyro rings", Value = false, Flag = "avGyro", Callback = function(v) S.gyro = v end })
avTab:Colorpicker({ Title = "gyro color", Default = S.gyroColor, Flag = "avGyroColor", Callback = function(c) S.gyroColor = c end })
avTab:Section({ Title = "fire, sparkles, dust" })
avTab:Toggle({ Title = "flame body", Value = false, Flag = "avFire", Callback = function(v) S.fire = v end })
avTab:Colorpicker({ Title = "flame color", Default = S.fireC1, Flag = "avFireC1", Callback = function(c) S.fireC1 = c end })
avTab:Colorpicker({ Title = "flame edge color", Default = S.fireC2, Flag = "avFireC2", Callback = function(c) S.fireC2 = c end })
avTab:Slider({
Title = "flame size", Value = { Min = 3, Max = 15, Default = 7 }, Flag = "avFireSize",
Callback = function(v) S.fireSize = math.clamp(tonumber(v) or 7, 3, 15) end,
})
avTab:Toggle({ Title = "sparkles", Value = false, Flag = "avSparkles", Callback = function(v) S.sparkles = v end })
avTab:Colorpicker({ Title = "sparkle color", Default = S.sparkleColor, Flag = "avSparkleColor", Callback = function(c) S.sparkleColor = c end })
avTab:Toggle({ Title = "stardust", Value = false, Flag = "avDust", Callback = function(v) S.dust = v end })
avTab:Colorpicker({ Title = "dust color", Default = S.dustC1, Flag = "avDustC1", Callback = function(c) S.dustC1 = c end })
avTab:Colorpicker({ Title = "dust color 2", Default = S.dustC2, Flag = "avDustC2", Callback = function(c) S.dustC2 = c end })
avTab:Section({ Title = "body effects" })
avTab:Toggle({ Title = "neon skeleton", Value = false, Flag = "avSkel", Callback = function(v) S.skel = v end })
avTab:Colorpicker({ Title = "skeleton color", Default = S.skelColor, Flag = "avSkelColor", Callback = function(c) S.skelColor = c end })
avTab:Toggle({ Title = "pulsing outline", Value = false, Flag = "avOutline", Callback = function(v) S.outline = v end })
avTab:Colorpicker({ Title = "outline color", Default = S.outlineColor, Flag = "avOutlineColor", Callback = function(c) S.outlineColor = c end })
avTab:Toggle({ Title = "footstep ripples", Value = false, Flag = "avRipples", Callback = function(v) S.ripples = v end })
avTab:Colorpicker({ Title = "ripple color", Default = S.rippleColor, Flag = "avRippleColor", Callback = function(c) S.rippleColor = c end })
;(function()
local Lighting_ = game:GetService("Lighting")
local V = {
holo = false, holoColor = Color3.fromRGB(80, 220, 255), holoAlpha = 0.55,
orbs = false, orbStyle = "Orbs", orbCount = 6, orbColor = Color3.fromRGB(150, 90, 255), orbRadius = 4, orbSpeed = 1.4,
circle = false, circleColor = Color3.fromRGB(255, 90, 160), circleSize = 6,
ambient = false, ambientStyle = "Fireflies", ambientColor = Color3.fromRGB(255, 230, 120), ambientAmount = 40,
ghost = false, ghostColor = Color3.fromRGB(120, 200, 255), ghostLife = 0.45,
shock = false, shockColor = Color3.fromRGB(255, 255, 255),
light = false, lightColor = Color3.fromRGB(150, 120, 255), lightRange = 18, lightBright = 2,
bloom = false, bloomInt = 0.4, rays = false, raysInt = 0.1, grade = "Off", gradeInt = 0.6,
rainbow = false, bright = 0.6,
}
local rng = Random.new()
local vf
local pools = { orbs = {}, circle = {}, amb = {}, ghosts = {}, waves = {} }
local orbsStyle, ambStyle
local active = false
local holoOrig = setmetatable({}, { __mode = "k" })
local holoAt, lastGhost, lastFloor, lastVy = 0, 0, true, 0
local fx = {}
local function mkPart(parent, size, color, transp)
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = Enum.Material.Neon
p.Color = color
p.Transparency = transp
p.Size = Vector3.new(math.max(size.X, 0.05), math.max(size.Y, 0.05), math.max(size.Z, 0.05))
p.Parent = parent
return p
end
local function col(base, t, i)
local c = base
if V.rainbow then c = Color3.fromHSV((t * 0.15 + (i or 0) * 0.08) % 1, 0.75, 1) end
local k = 0.35 + 0.65 * V.bright
return Color3.new(c.R * k, c.G * k, c.B * k)
end
local function tr(x)
return 1 - (1 - x) * V.bright
end
local function bulk(parts, cfs)
if #parts == 0 then return end
pcall(workspace.BulkMoveTo, workspace, parts, cfs, Enum.BulkMoveMode.FireCFrameChanged)
end
local function folderGet()
local cam = workspace.CurrentCamera
if not cam then return nil end
if vf and vf.Parent == cam then return vf end
if vf then pcall(function() vf:Destroy() end) end
pools = { orbs = {}, circle = {}, amb = {}, ghosts = {}, waves = {} }
orbsStyle, ambStyle = nil, nil
vf = Instance.new("Folder")
vf.Name = "NightCCVisuals"
vf.Parent = cam
return vf
end
local function killPool(key)
for _, e in ipairs(pools[key]) do
if typeof(e) == "Instance" then
pcall(function() e:Destroy() end)
elseif e.part then
pcall(function() e.part:Destroy() end)
elseif e.parts then
for _, p in ipairs(e.parts) do pcall(function() p:Destroy() end) end
end
end
pools[key] = {}
end
local holoExtra = {}
local function holoCapture(p)
holoOrig[p] = { p.Material, p.Color, p.Transparency }
if p:IsA("MeshPart") and p.TextureID ~= "" then
holoExtra[#holoExtra + 1] = { "tex", p, p.TextureID }
p.TextureID = ""
end
for _, c in ipairs(p:GetChildren()) do
if c:IsA("SurfaceAppearance") then
holoExtra[#holoExtra + 1] = { "sa", c, p }
c.Parent = nil
elseif c:IsA("Decal") or c:IsA("Texture") then
holoExtra[#holoExtra + 1] = { "decal", c, c.Transparency }
c.Transparency = 1
end
end
end
local function holoApply(char, t)
if t >= holoAt then
holoAt = t + 1
for _, p in ipairs(char:GetDescendants()) do
if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and holoOrig[p] == nil and p.Transparency < 0.9 then
holoCapture(p)
end
end
end
local flick = 0.05 * math.sin(t * 23)
if math.sin(t * 3.1) > 0.9 then flick = flick * 3 end
local c = col(V.holoColor, t, 0)
for p, o in pairs(holoOrig) do
if p.Parent then
p.Material = Enum.Material.ForceField
p.Color = c
p.Transparency = math.clamp(math.max(o[3], V.holoAlpha + (1 - V.bright) * 0.3) + flick, 0, 0.95)
end
end
end
local function holoRestore()
for p, o in pairs(holoOrig) do
if p.Parent then pcall(function() p.Material, p.Color, p.Transparency = o[1], o[2], o[3] end) end
holoOrig[p] = nil
end
for _, e in ipairs(holoExtra) do
pcall(function()
if e[1] == "tex" then
e[2].TextureID = e[3]
elseif e[1] == "sa" then
e[2].Parent = e[3]
else
e[2].Transparency = e[3]
end
end)
end
holoExtra = {}
end
local function updateOrbs(f, root, t)
local n = math.clamp(math.floor(V.orbCount), 1, 16)
local pool, style = pools.orbs, V.orbStyle
if orbsStyle ~= style then
killPool("orbs")
pool = pools.orbs
orbsStyle = style
end
while #pool < n do
local size = style == "Orbs" and Vector3.new(0.7, 0.7, 0.7) or style == "Cubes" and Vector3.new(0.6, 0.6, 0.6)
or style == "Diamonds" and Vector3.new(0.5, 0.5, 0.5) or Vector3.new(0.25, 0.25, 1.2)
local p = mkPart(f, size, V.orbColor, 0.05)
if style == "Orbs" then p.Shape = Enum.PartType.Ball end
pool[#pool + 1] = p
end
while #pool > n do
local p = table.remove(pool)
pcall(function() p:Destroy() end)
end
local base = root.Position + Vector3.new(0, 0.5, 0)
local cfs = {}
for i, p in ipairs(pool) do
local a = t * V.orbSpeed + (i - 1) * (math.pi * 2 / n)
local pos = base + Vector3.new(math.cos(a) * V.orbRadius, math.sin(t * 1.3 + i) * 1.1, math.sin(a) * V.orbRadius)
if style == "Shards" then
cfs[i] = CFrame.lookAt(pos, base)
elseif style == "Diamonds" then
cfs[i] = CFrame.new(pos) * CFrame.Angles(math.rad(45), t * 1.2 + i, math.rad(45))
else
cfs[i] = CFrame.new(pos) * CFrame.Angles(t * 1.5 + i, t * 1.1, i)
end
p.Color = col(V.orbColor, t, i)
p.Transparency = tr(0.05)
end
bulk(pool, cfs)
end
local function updateCircle(f, char, root, t)
local pool = pools.circle
local OUT, INN = 28, 18
local total = OUT + INN + 6
while #pool < total do pool[#pool + 1] = mkPart(f, Vector3.new(0.14, 0.05, 0.5), V.circleColor, 0.1) end
local gy = feetY(char, root) + 0.06
local cx, cz = root.Position.X, root.Position.Z
local R = V.circleSize
local cfs, idx = {}, 0
local function ring(r, count, th0)
local chord = 2 * r * math.sin(math.pi / count) + 0.03
for k = 0, count - 1 do
idx = idx + 1
local a = th0 + (math.pi * 2) * k / count
local pos = Vector3.new(cx + math.cos(a) * r, gy, cz + math.sin(a) * r)
cfs[idx] = CFrame.lookAt(pos, pos + Vector3.new(-math.sin(a), 0, math.cos(a)))
pool[idx].Size = Vector3.new(0.14, 0.05, chord)
end
end
ring(R, OUT, t * 0.6)
ring(R * 0.72, INN, -t * 0.9)
local rs, th = R * 0.72, t * 0.6
for k = 0, 5 do
local a1, a2 = th + k * math.pi / 3, th + (k + 2) * math.pi / 3
local p1 = Vector3.new(cx + math.cos(a1) * rs, gy, cz + math.sin(a1) * rs)
local p2 = Vector3.new(cx + math.cos(a2) * rs, gy, cz + math.sin(a2) * rs)
idx = idx + 1
cfs[idx] = CFrame.lookAt((p1 + p2) / 2, p2)
pool[idx].Size = Vector3.new(0.1, 0.05, (p2 - p1).Magnitude)
end
for i = 1, idx do
pool[i].Color = col(V.circleColor, t, i * 0.3)
pool[i].Transparency = tr(0.1)
end
bulk(pool, cfs)
end
local function updateAmbient(f, char, root, dt, t)
local n = math.clamp(math.floor(V.ambientAmount), 10, 150)
local style = V.ambientStyle
local pool = pools.amb
if ambStyle ~= style then
killPool("amb")
pool = pools.amb
ambStyle = style
end
while #pool < n do
local size = style == "Snow" and Vector3.new(0.16, 0.16, 0.16) or style == "Petals" and Vector3.new(0.3, 0.03, 0.2)
or Vector3.new(0.2, 0.2, 0.2)
local p = mkPart(f, size, V.ambientColor, 0.2)
if style == "Fireflies" or style == "Embers" or style == "Snow" then p.Shape = Enum.PartType.Ball end
pool[#pool + 1] = { part = p, fresh = true, x = 0, y = 0, z = 0, ph = rng:NextNumber(0, 6.28) }
end
while #pool > n do
local d = table.remove(pool)
pcall(function() d.part:Destroy() end)
end
local rp = root.Position
local gy = feetY(char, root)
local parts, cfs = {}, {}
for i, d in ipairs(pool) do
local dx, dz = d.x - rp.X, d.z - rp.Z
local out = d.fresh or dx * dx + dz * dz > 324 or d.y < gy - 1 or d.y > gy + 12
if out then
local top = style == "Snow" or style == "Petals"
d.x, d.z = rp.X + rng:NextNumber(-16, 16), rp.Z + rng:NextNumber(-16, 16)
if d.fresh then
d.y = gy + rng:NextNumber(0, 9)
elseif top then
d.y = gy + 9 + rng:NextNumber(0, 3)
elseif style == "Embers" then
d.y = gy + rng:NextNumber(0, 1)
else
d.y = gy + rng:NextNumber(0.5, 7)
end
d.fresh = false
end
local alpha, rot = 0.2, CFrame.identity
if style == "Fireflies" then
d.x = d.x + math.cos(t * 0.7 + d.ph) * 1.2 * dt
d.z = d.z + math.sin(t * 0.9 + d.ph * 1.3) * 1.2 * dt
d.y = d.y + math.sin(t * 1.1 + d.ph) * 0.8 * dt
alpha = 0.15 + 0.75 * (0.5 - 0.5 * math.sin(t * 2.5 + d.ph))
elseif style == "Snow" then
d.y = d.y - 2.8 * dt
d.x = d.x + math.sin(t + d.ph) * 0.8 * dt
d.z = d.z + math.cos(t * 0.8 + d.ph) * 0.8 * dt
alpha = 0.1
elseif style == "Petals" then
d.y = d.y - 1.6 * dt
d.x = d.x + math.sin(t * 0.9 + d.ph) * 1.6 * dt
d.z = d.z + math.cos(t * 0.7 + d.ph) * 1.2 * dt
rot = CFrame.Angles(t * 1.7 + d.ph, t + d.ph, t * 1.3)
alpha = 0.1
else
d.y = d.y + 2.2 * dt
d.x = d.x + math.sin(t * 2 + d.ph) * 0.6 * dt
alpha = math.clamp((d.y - gy) / 11, 0, 1) * 0.85 + 0.1 * math.sin(t * 12 + d.ph)
end
d.part.Transparency = math.clamp(tr(alpha), 0, 1)
d.part.Color = col(V.ambientColor, t, i * 0.05)
parts[i] = d.part
cfs[i] = CFrame.new(d.x, d.y, d.z) * rot
end
bulk(parts, cfs)
end
local function updateGhost(f, char, root, t)
local g = pools.ghosts
for i = #g, 1, -1 do
local s = g[i]
local a = (t - s.t0) / V.ghostLife
if a >= 1 then
for _, p in ipairs(s.parts) do pcall(function() p:Destroy() end) end
table.remove(g, i)
else
for _, p in ipairs(s.parts) do p.Transparency = tr(0.45 + 0.55 * a) end
end
end
if t - lastGhost < 0.09 or #g >= 10 then return end
local v = root.AssemblyLinearVelocity
if Vector3.new(v.X, 0, v.Z).Magnitude < 4 then return end
lastGhost = t
local snap = { t0 = t, parts = {} }
local c = col(V.ghostColor, t, #g)
for _, p in ipairs(char:GetChildren()) do
if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" and p.Transparency < 0.9 then
local cp = mkPart(f, p.Size, c, 0.45)
cp.CFrame = p.CFrame
snap.parts[#snap.parts + 1] = cp
end
end
g[#g + 1] = snap
end
local function spawnWave(f, pos, maxD, t)
local w = { t0 = t, maxD = maxD, pos = pos, parts = {} }
for i = 1, 2 do
local p = mkPart(f, Vector3.new(0.12, 1, 1), col(V.shockColor, t, i), 0.3)
p.Shape = Enum.PartType.Cylinder
w.parts[i] = p
end
pools.waves[#pools.waves + 1] = w
end
local function updateWaves(f, char, root, t)
local hum = char:FindFirstChildOfClass("Humanoid")
if hum then
local onFloor = hum.FloorMaterial ~= Enum.Material.Air
local vy = root.AssemblyLinearVelocity.Y
local at = Vector3.new(root.Position.X, feetY(char, root) + 0.08, root.Position.Z)
if onFloor and not lastFloor and lastVy < -14 then
spawnWave(f, at, math.clamp(-lastVy * 0.45, 6, 22), t)
elseif lastFloor and not onFloor and vy > 8 then
spawnWave(f, at, 6, t)
end
lastFloor = onFloor
if not onFloor then lastVy = vy end
end
local waves = pools.waves
for i = #waves, 1, -1 do
local w = waves[i]
local a = (t - w.t0) / 0.55
if a >= 1 then
for _, p in ipairs(w.parts) do pcall(function() p:Destroy() end) end
table.remove(waves, i)
else
for k, p in ipairs(w.parts) do
local ka = math.clamp(a - (k - 1) * 0.12, 0, 1)
local d = 1 + w.maxD * ka
p.Size = Vector3.new(0.12, d, d)
p.CFrame = CFrame.new(w.pos) * CFrame.Angles(0, 0, math.pi / 2)
p.Transparency = tr(0.25 + 0.75 * ka)
end
end
end
end
local function updateLight(root, t, on)
local l = root:FindFirstChild("NightCCLight")
if on then
if not l then
l = Instance.new("PointLight")
l.Name = "NightCCLight"
l.Shadows = false
l.Parent = root
end
l.Color = col(V.lightColor, t, 0)
l.Range = V.lightRange
l.Brightness = V.lightBright * (0.4 + 0.6 * V.bright) * (0.88 + 0.12 * math.sin(t * 3))
elseif l then
l:Destroy()
end
end
local GRADES = {
Cyber = { tint = Color3.fromRGB(170, 200, 255), sat = 0.25, con = 0.12, bri = -0.02 },
Sunset = { tint = Color3.fromRGB(255, 200, 160), sat = 0.2, con = 0.1, bri = 0 },
Noir = { tint = Color3.fromRGB(255, 255, 255), sat = -1, con = 0.25, bri = -0.03 },
Frost = { tint = Color3.fromRGB(200, 230, 255), sat = -0.1, con = 0.08, bri = 0.03 },
Neon = { tint = Color3.fromRGB(230, 200, 255), sat = 0.6, con = 0.2, bri = 0 },
Vintage = { tint = Color3.fromRGB(255, 235, 200), sat = -0.2, con = 0.05, bri = 0 },
}
local function effect(key, class, name)
local e = fx[key]
if e and e.Parent then return e end
e = Instance.new(class)
e.Name = name
e.Parent = Lighting_
fx[key] = e
return e
end
local function dropEffect(key)
local e = fx[key]
if e then pcall(function() e:Destroy() end) end
fx[key] = nil
end
local function updateCinema()
if V.bloom then
local b = effect("bloom", "BloomEffect", "NightCCBloom")
b.Intensity, b.Size, b.Threshold = V.bloomInt, 28, 0.9
else
dropEffect("bloom")
end
if V.rays then
local r = effect("rays", "SunRaysEffect", "NightCCRays")
r.Intensity, r.Spread = V.raysInt, 0.6
else
dropEffect("rays")
end
local g = GRADES[V.grade]
if g then
local c = effect("grade", "ColorCorrectionEffect", "NightCCGrade")
local k = V.gradeInt
c.TintColor = Color3.new(1, 1, 1):Lerp(g.tint, k)
c.Saturation, c.Contrast, c.Brightness = g.sat * k, g.con * k, g.bri * k
else
dropEffect("grade")
end
end
local function anyOn()
return V.holo or V.orbs or V.circle or V.ambient or V.ghost or V.shock or V.light
end
local function clearAll()
holoRestore()
if vf then pcall(function() vf:Destroy() end) end
vf = nil
pools = { orbs = {}, circle = {}, amb = {}, ghosts = {}, waves = {} }
orbsStyle, ambStyle = nil, nil
local char = LP_.Character
local root = char and char:FindFirstChild("HumanoidRootPart")
local l = root and root:FindFirstChild("NightCCLight")
if l then l:Destroy() end
end
aa.connect(RunService_.RenderStepped, function(dt)
if not anyOn() then
if active then clearAll(); active = false end
return
end
local char, root = bodyParts()
if not char or char:GetAttribute("Dead") == true then
if active then clearAll(); active = false end
return
end
local f = folderGet()
if not f then return end
active = true
local t = os.clock()
if V.holo then holoApply(char, t) elseif next(holoOrig) ~= nil then holoRestore() end
if V.orbs then updateOrbs(f, root, t) elseif #pools.orbs > 0 then killPool("orbs") end
if V.circle then updateCircle(f, char, root, t) elseif #pools.circle > 0 then killPool("circle") end
if V.ambient then updateAmbient(f, char, root, dt, t) elseif #pools.amb > 0 then killPool("amb") end
if V.ghost then updateGhost(f, char, root, t) elseif #pools.ghosts > 0 then killPool("ghosts") end
if V.shock then updateWaves(f, char, root, t) elseif #pools.waves > 0 then killPool("waves") end
updateLight(root, t, V.light)
end)
aa.onUnload(function()
V.holo, V.orbs, V.circle, V.ambient, V.ghost, V.shock, V.light = false, false, false, false, false, false, false
V.bloom, V.rays, V.grade = false, false, "Off"
pcall(clearAll)
pcall(updateCinema)
end)
avTab:Section({ Title = "hologram and orbs" })
avTab:Slider({ Title = "visual brightness", Value = { Min = 10, Max = 100, Default = 60 }, Flag = "avVisBright",
Callback = function(x) V.bright = math.clamp((tonumber(x) or 60) / 100, 0.1, 1) end })
avTab:Toggle({ Title = "hologram body", Value = false, Flag = "avHolo", Callback = function(v) V.holo = v end })
avTab:Colorpicker({ Title = "hologram color", Default = V.holoColor, Flag = "avHoloColor", Callback = function(c) V.holoColor = c end })
avTab:Slider({ Title = "hologram opacity", Value = { Min = 10, Max = 90, Default = 55 }, Flag = "avHoloAlpha",
Callback = function(x) V.holoAlpha = math.clamp((tonumber(x) or 55) / 100, 0.1, 0.9) end })
avTab:Toggle({ Title = "orbiting objects", Value = false, Flag = "avOrbs", Callback = function(v) V.orbs = v end })
avTab:Dropdown({ Title = "orbit style", Values = { "Orbs", "Cubes", "Diamonds", "Shards" }, Value = "Orbs", Flag = "avOrbStyle",
Callback = function(v) V.orbStyle = tostring(v) end })
avTab:Colorpicker({ Title = "orbit color", Default = V.orbColor, Flag = "avOrbColor", Callback = function(c) V.orbColor = c end })
avTab:Slider({ Title = "orbit count", Value = { Min = 1, Max = 16, Default = 6 }, Flag = "avOrbCount",
Callback = function(x) V.orbCount = math.clamp(math.floor(tonumber(x) or 6), 1, 16) end })
avTab:Slider({ Title = "orbit radius", Value = { Min = 2, Max = 10, Default = 4 }, Flag = "avOrbRadius",
Callback = function(x) V.orbRadius = math.clamp(tonumber(x) or 4, 2, 10) end })
avTab:Slider({ Title = "orbit speed", Value = { Min = 1, Max = 40, Default = 14 }, Flag = "avOrbSpeed",
Callback = function(x) V.orbSpeed = math.clamp((tonumber(x) or 14) / 10, 0.1, 4) end })
avTab:Section({ Title = "magic circle and ambient" })
avTab:Toggle({ Title = "magic circle", Value = false, Flag = "avCircle", Callback = function(v) V.circle = v end })
avTab:Colorpicker({ Title = "magic circle color", Default = V.circleColor, Flag = "avCircleColor", Callback = function(c) V.circleColor = c end })
avTab:Slider({ Title = "magic circle size", Value = { Min = 3, Max = 12, Default = 6 }, Flag = "avCircleSize",
Callback = function(x) V.circleSize = math.clamp(tonumber(x) or 6, 3, 12) end })
avTab:Toggle({ Title = "ambient particles", Value = false, Flag = "avAmbient", Callback = function(v) V.ambient = v end })
avTab:Dropdown({ Title = "ambient style", Values = { "Fireflies", "Snow", "Petals", "Embers" }, Value = "Fireflies", Flag = "avAmbientStyle",
Callback = function(v) V.ambientStyle = tostring(v) end })
avTab:Colorpicker({ Title = "ambient color", Default = V.ambientColor, Flag = "avAmbientColor", Callback = function(c) V.ambientColor = c end })
avTab:Slider({ Title = "ambient amount", Value = { Min = 10, Max = 150, Default = 40 }, Flag = "avAmbientAmount",
Callback = function(x) V.ambientAmount = math.clamp(math.floor(tonumber(x) or 40), 10, 150) end })
avTab:Section({ Title = "afterimage and shockwave" })
avTab:Toggle({ Title = "afterimage", Value = false, Flag = "avGhost", Callback = function(v) V.ghost = v end })
avTab:Colorpicker({ Title = "afterimage color", Default = V.ghostColor, Flag = "avGhostColor", Callback = function(c) V.ghostColor = c end })
avTab:Slider({ Title = "afterimage life", Value = { Min = 20, Max = 120, Default = 45 }, Flag = "avGhostLife",
Callback = function(x) V.ghostLife = math.clamp((tonumber(x) or 45) / 100, 0.2, 1.2) end })
avTab:Toggle({ Title = "jump and landing shockwave", Value = false, Flag = "avShock", Callback = function(v) V.shock = v end })
avTab:Colorpicker({ Title = "shockwave color", Default = V.shockColor, Flag = "avShockColor", Callback = function(c) V.shockColor = c end })
avTab:Section({ Title = "light and cinematic" })
avTab:Toggle({ Title = "glow light", Value = false, Flag = "avLight", Callback = function(v) V.light = v end })
avTab:Colorpicker({ Title = "glow light color", Default = V.lightColor, Flag = "avLightColor", Callback = function(c) V.lightColor = c end })
avTab:Slider({ Title = "glow light range", Value = { Min = 8, Max = 40, Default = 18 }, Flag = "avLightRange",
Callback = function(x) V.lightRange = math.clamp(tonumber(x) or 18, 8, 40) end })
avTab:Slider({ Title = "glow light brightness", Value = { Min = 1, Max = 10, Default = 2 }, Flag = "avLightBright",
Callback = function(x) V.lightBright = math.clamp(tonumber(x) or 2, 1, 10) end })
avTab:Toggle({ Title = "bloom", Value = false, Flag = "avBloom", Callback = function(v) V.bloom = v; updateCinema() end })
avTab:Slider({ Title = "bloom strength", Value = { Min = 1, Max = 30, Default = 4 }, Flag = "avBloomInt",
Callback = function(x) V.bloomInt = math.clamp((tonumber(x) or 4) / 10, 0.1, 3); updateCinema() end })
avTab:Toggle({ Title = "sun rays", Value = false, Flag = "avRays", Callback = function(v) V.rays = v; updateCinema() end })
avTab:Slider({ Title = "sun rays strength", Value = { Min = 1, Max = 100, Default = 10 }, Flag = "avRaysInt",
Callback = function(x) V.raysInt = math.clamp((tonumber(x) or 10) / 100, 0.01, 1); updateCinema() end })
avTab:Dropdown({ Title = "color grade", Values = { "Off", "Cyber", "Sunset", "Noir", "Frost", "Neon", "Vintage" }, Value = "Off", Flag = "avGrade",
Callback = function(v) V.grade = tostring(v); updateCinema() end })
avTab:Slider({ Title = "color grade strength", Value = { Min = 10, Max = 100, Default = 60 }, Flag = "avGradeInt",
Callback = function(x) V.gradeInt = math.clamp((tonumber(x) or 60) / 100, 0.1, 1); updateCinema() end })
avTab:Toggle({ Title = "rainbow for these visuals", Value = false, Flag = "avVisRainbow", Callback = function(v) V.rainbow = v end })
end)()
end
__blk()
end
;(function()
local RunService_ = game:GetService("RunService")
local GC = { on = false, color = Color3.fromRGB(150, 90, 255), rainbow = false, speed = 0.25, sat = 1, skipTeam = false }
local saved, busy, acc = {}, false, 0
local function eligible(e)
if e.flag == "gcColor" then return false end
if not GC.skipTeam then return true end
local t = string.lower(e.title)
return not (string.find(t, "team", 1, true) or string.find(t, "enemy", 1, true))
end
local function applyAll(c, silent)
if busy then return end
busy = true
for _, e in ipairs(ac._colorEls or {}) do
if eligible(e) then
if saved[e.flag] == nil then saved[e.flag] = e.get() end
if silent then pcall(e.obj.Apply, e.obj, c) else pcall(e.obj.Set, e.obj, c) end
end
end
busy = false
end
local function restoreAll()
if busy then return end
busy = true
for _, e in ipairs(ac._colorEls or {}) do
local c = saved[e.flag]
if c ~= nil then
pcall(e.obj.Set, e.obj, c)
saved[e.flag] = nil
end
end
busy = false
end
local gt = ad:Tab({ Title = "color", Icon = "sparkles" })
gt:Section({ Title = "global color" })
local gcObj = gt:Colorpicker({ Title = "global color", Default = GC.color, Flag = "gcColor", Callback = function(c)
GC.color = c
if GC.on and not GC.rainbow then applyAll(c) end
end })
gt:Toggle({ Title = "use global color for everything", Value = false, Flag = "gcOn", Callback = function(v)
GC.on = v
if v then
if GC.rainbow then applyAll(GC.color, true) else applyAll(GC.color) end
else
restoreAll()
end
end })
gt:Toggle({ Title = "global rainbow", Value = false, Flag = "gcRainbow", Callback = function(v)
GC.rainbow = v
if not v and GC.on then applyAll(GC.color) end
end })
gt:Slider({ Title = "rainbow speed", Value = { Min = 1, Max = 100, Default = 25 }, Flag = "gcSpeed",
Callback = function(x) GC.speed = math.clamp((tonumber(x) or 25) / 100, 0.01, 1) end })
gt:Slider({ Title = "rainbow saturation", Value = { Min = 10, Max = 100, Default = 100 }, Flag = "gcSat",
Callback = function(x) GC.sat = math.clamp((tonumber(x) or 100) / 100, 0.1, 1) end })
gt:Toggle({ Title = "keep team and enemy colors separate", Value = false, Flag = "gcSkipTeam", Callback = function(v)
GC.skipTeam = v
if GC.on and not GC.rainbow then applyAll(GC.color) end
end })
gt:Section({ Title = "quick colors" })
local PRE = {
{ "pink", Color3.fromRGB(255, 85, 150) }, { "purple", Color3.fromRGB(150, 90, 255) }, { "cyan", Color3.fromRGB(70, 220, 255) },
{ "red", Color3.fromRGB(255, 60, 60) }, { "green", Color3.fromRGB(90, 255, 150) }, { "gold", Color3.fromRGB(255, 205, 80) },
{ "white", Color3.fromRGB(255, 255, 255) },
}
for _, p in ipairs(PRE) do
gt:Button({ Title = p[1], Callback = function()
if gcObj and gcObj.Set then gcObj:Set(p[2]) else GC.color = p[2] end
end })
end
gt:Button({ Title = "random color", Callback = function()
local c = Color3.fromHSV(math.random(), 0.7 + math.random() * 0.3, 1)
if gcObj and gcObj.Set then gcObj:Set(c) else GC.color = c end
end })
gt:Button({ Title = "apply now (keep originals)", Callback = function() applyAll(GC.color) end })
gt:Button({ Title = "restore original colors", Callback = function() restoreAll() end })
aa.connect(RunService_.Heartbeat, function(dt)
if not (GC.on and GC.rainbow) then return end
acc = acc + dt
if acc < 0.066 then return end
acc = 0
applyAll(Color3.fromHSV((os.clock() * GC.speed) % 1, GC.sat, 1), true)
end)
aa.onUnload(function() GC.on = false end)
end)()
local bl = ad:Tab({
Title = "motion",
Icon = "move",
})
bl:Section({
Title = "bunny hop",
})
do
local bm = bl:Toggle({
Title = "auto bhop",
Value = false,
Flag = "bhop",
Callback = function(bm)
vT(bm)
end,
})
ak.register("Auto Bhop", bm, {
kind = "toggle",
title = "Auto Bhop",
isActive = function()
return aC.bhop
end,
setState = function(bn)
vT(bn)
pcall(function()
bm:Set(bn)
end)
end,
})
end
bl:Toggle({
Title = "crouch hop",
Value = false,
Flag = "bhopCrouch",
Callback = function(v)
aC.bhopCrouch = v
end,
})
bl:Toggle({
Title = "air speed boost",
Value = false,
Flag = "bhopSpeedBoost",
Callback = function(v)
aC.bhopSpeedBoost = v
end,
})
bl:Slider({
Title = "boost power (% per frame)",
Value = { Min = 1, Max = 5, Default = 2 },
Flag = "bhopBoostPct",
Callback = function(v)
aC.bhopBoostPct = tonumber(v) or 2
end,
})
bl:Slider({
Title = "speed cap",
Value = { Min = 20, Max = 150, Default = 80 },
Flag = "bhopMaxSpeed",
Callback = function(v)
aC.bhopMaxSpeed = tonumber(v) or 80
end,
})
bl:Slider({
Title = "jump delay after landing (ms)",
Value = { Min = 0, Max = 300, Default = 0 },
Flag = "bhopDelay",
Callback = function(v)
aC.bhopDelay = tonumber(v) or 0
end,
})
bl:Slider({
Title = "bhop hit chance (%)",
Value = { Min = 1, Max = 100, Default = 100 },
Flag = "bhopChance",
Callback = function(v)
aC.bhopChance = tonumber(v) or 100
end,
})
bl:Toggle({
Title = "edge jump",
Value = false,
Flag = "bhopEdge",
Callback = function(v)
aC.bhopEdge = v
end,
})
bl:Toggle({
Title = "bhop speed hud",
Value = false,
Flag = "bhopHud",
Callback = function(v)
aC.bhopHud = v
end,
})
bl:Section({
Title = "auto strafe",
})
do
local bm = bl:Toggle({
Title = "silent auto strafe",
Value = false,
Flag = "strafe",
Callback = function(bm)
aC.strafe = bm
end,
})
ak.register("Auto Strafe", bm, {
kind = "toggle",
title = "Auto Strafe",
isActive = function()
return aC.strafe
end,
setState = function(bn)
aC.strafe = bn
pcall(function()
bm:Set(bn)
end)
end,
})
end
bl:Dropdown({
Title = "strafe style",
Values = {
"Rage",
"Legit",
},
Value = "Rage",
Flag = "strafeMode",
Callback = function(bm)
aC.strafeMode = type(bm) == "table" and bm[1] or bm
end,
})
bl:Toggle({
Title = "fast turn",
Value = true,
Flag = "strafeFastTurn",
Callback = function(bm)
aC.fastTurn = bm
end,
})
bl:Slider({
Title = "align threshold",
Value = {
Min = 1,
Max = 30,
Default = 6,
},
Flag = "strafeAlign",
Callback = function(bm)
aC.alignDeg = bm
end,
})
local bm, bn, bo, bp, bq, br, bs, bt, bu, bv =
game:GetService("Lighting"), {
Galaxy = {
Bk = "rbxassetid://159454299",
Dn = "rbxassetid://159454296",
Ft = "rbxassetid://159454293",
Lf = "rbxassetid://159454286",
Rt = "rbxassetid://159454300",
Up = "rbxassetid://159454288",
},
["Pink Sky"] = {
Lf = "rbxassetid://271042310",
Bk = "rbxassetid://271042516",
Dn = "rbxassetid://271077243",
Ft = "rbxassetid://271042556",
Rt = "rbxassetid://271042467",
Up = "rbxassetid://271077958",
},
Sunset = {
Bk = "rbxassetid://458016711",
Dn = "rbxassetid://458016826",
Ft = "rbxassetid://458016532",
Lf = "rbxassetid://458016655",
Rt = "rbxassetid://458016782",
Up = "rbxassetid://458016792",
},
Night = {
Bk = "rbxassetid://48020371",
Dn = "rbxassetid://48020144",
Ft = "rbxassetid://48020234",
Lf = "rbxassetid://48020211",
Rt = "rbxassetid://48020254",
Up = "rbxassetid://48020383",
},
Custom = {},
Evening = {
Lf = "rbxassetid://7950573918",
Bk = "rbxassetid://7950569153",
Dn = "rbxassetid://7950570785",
Ft = "rbxassetid://7950572449",
Rt = "rbxassetid://7950575055",
Up = "rbxassetid://7950627627",
},
}, false, Color3.fromRGB(75, 58, 222), Color3.fromRGB(109, 58, 206), false, 12, 0, false, "Galaxy"
local bw, bx, by, bz = bm.Ambient, bm.OutdoorAmbient, bm.ClockTime, Instance.new("ColorCorrectionEffect")
bz.Name = "NightCCSaturation"
bz.Enabled = false
bz.Parent = bm
aa.onUnload((function(bA)
return function()
if bo then
bm.Ambient = bw
bm.OutdoorAmbient = bx
end
if br then
pcall(function()
bm.ClockTime = by
end)
end
pcall(function()
bm.GlobalShadows = bA
end)
pcall(function()
bz:Destroy()
end)
local bB = bm:FindFirstChild("NightCCSky")
if bB then
bB:Destroy()
end
end
end)(bm.GlobalShadows))
local function BU()
local bA = bm:FindFirstChild("NightCCSky")
if bu then
local bB = bn[bv]
if not (bB and bB.Bk) then
return
end
local bC = bA or Instance.new("Sky")
bC.Name = "NightCCSky"
bC.SkyboxBk, bC.SkyboxDn, bC.SkyboxFt = bB.Bk, bB.Dn, bB.Ft
bC.SkyboxLf, bC.SkyboxRt, bC.SkyboxUp = bB.Lf, bB.Rt, bB.Up
bC.Parent = bm
elseif bA then
bA:Destroy()
end
end
aa.connect(O.Heartbeat, function()
if bo then
bm.Ambient = bp
bm.OutdoorAmbient = bq
end
if br then
bm.ClockTime = bs
end
end)
local bA = ad:Tab({
Title = "environment",
Icon = "globe",
})
bA:Section({
Title = "lighting",
})
bA:Toggle({
Title = "ambience",
Value = false,
Flag = "wrl_ambient",
Callback = function(bB)
bo = bB
if not bB then
bm.Ambient = bw
bm.OutdoorAmbient = bx
end
end,
})
local bB, bC =
bA:Colorpicker({
Title = "ambient tint",
Default = bp,
Flag = "wrl_ambientColor",
Callback = function(bB)
bp = bB
end,
}), bA:Colorpicker({
Title = "outdoor tint",
Default = bq,
Flag = "wrl_outdoorColor",
Callback = function(bB)
bq = bB
end,
})
bA:Toggle({
Title = "shadow map",
Value = bm.GlobalShadows,
Flag = "wrl_shadows",
Callback = function(bD)
pcall(function()
bm.GlobalShadows = bD
end)
end,
})
bA:Toggle({
Title = "force time",
Value = false,
Flag = "wrl_forcetime",
Callback = function(bD)
br = bD
if not bD then
pcall(function()
bm.ClockTime = by
end)
end
end,
})
bA:Slider({
Title = "time",
Value = {
Min = 0,
Max = 24,
Default = 12,
},
Step = 1,
Flag = "wrl_time",
Callback = function(bD)
bs = bD
end,
})
bA:Section({
Title = "effects",
})
bA:Toggle({
Title = "saturation",
Value = false,
Flag = "wrl_saturation",
Callback = function(bD)
bz.Enabled = bD
end,
})
bA:Slider({
Title = "saturation value",
Value = {
Min = -1,
Max = 5,
Default = 0,
},
Step = 0.05,
Flag = "wrl_satvalue",
Callback = function(bD)
bt = bD
bz.Saturation = bD
end,
})
bA:Section({
Title = "sky layer",
})
bA:Toggle({
Title = "sky layer",
Value = false,
Flag = "wrl_skybox",
Callback = function(bD)
bu = bD
BU()
end,
})
bA:Dropdown({
Title = "skybox kind",
Values = {
"Galaxy",
"Pink Sky",
"Sunset",
"Night",
"Evening",
"Custom",
},
Value = "Galaxy",
Flag = "wrl_skyboxtype",
Callback = function(bD)
bv = type(bD) == "table" and bD[1] or bD
BU()
end,
})
bA:Input({
Title = "custom skybox id",
Value = "",
Placeholder = "asset id",
Flag = "wrl_skyboxid",
Callback = function(bD)
local bE, bF = AT(bD), bn.Custom
bF.Bk, bF.Dn, bF.Ft, bF.Lf, bF.Rt, bF.Up = bE, bE, bE, bE, bE, bE
BU()
end,
})
do
local bD, bE, bF, bG =
{
fullbright = false,
bright = false,
brightness = 2,
exposure = 0,
fog = "Default",
fogColor = Color3.fromRGB(190, 200, 220),
fogStart = 0,
fogEnd = 400,
noPost = false,
night = false,
nightStrength = 0.6,
asus = false,
asusValue = 0.5,
tint = false,
tintColor = Color3.fromRGB(110, 90, 255),
tintStrength = 0.5,
weather = "Off",
weatherAmount = 1,
}, {
Brightness = bm.Brightness,
Exposure = bm.ExposureCompensation,
FogColor = bm.FogColor,
FogStart = bm.FogStart,
FogEnd = bm.FogEnd,
}, Color3.new(1, 1, 1), Instance.new("ColorCorrectionEffect")
bG.Name = "NightCCGrade"
bG.Enabled = false
bG.Parent = bm
local bH = Instance.new("ColorCorrectionEffect")
bH.Name = "NightCCNight"
bH.Enabled = false
bH.Parent = bm
local bI = Instance.new("BloomEffect")
bI.Name = "NightCCBloom"
bI.Enabled = false
bI.Parent = bm
local bJ = {}
local function y(bK)
bD.fog = bK
if bK == "Default" then
for bL, bM in ipairs(bJ) do
pcall(function()
bM.Parent = bm
end)
end
bJ = {}
bm.FogColor, bm.FogStart, bm.FogEnd = bE.FogColor, bE.FogStart, bE.FogEnd
else
for bL, bM in ipairs(bm:GetChildren()) do
if bM:IsA("Atmosphere") then
bJ[#bJ + 1] = bM
bM.Parent = nil
end
end
end
end
local bK = {}
local function q()
for bL, bM in ipairs({ bm, at }) do
for bN, bO in ipairs(bM:GetChildren()) do
if bO:IsA("PostEffect") and bO.Name:sub(1, 8) ~= "NightCC" then
if bK[bO] == nil then
bK[bO] = bO.Enabled
end
if bO.Enabled then
bO.Enabled = false
end
end
end
end
end
local function v()
for bL, bM in pairs(bK) do
pcall(function()
bL.Enabled = bM
end)
end
bK = {}
end
local bL, bM, bN = {}, 0, false
local function C()
return bD.asus or bD.tint
end
local function Q()
bM = bM + 1
local bO = bM
task.spawn(function()
local bP = { [at] = true }
for bQ, bR in ipairs({
"Characters",
"Debris",
}) do
local bS = workspace:FindFirstChild(bR)
if bS then
bP[bS] = true
end
end
local bQ = 0
local function z(bR)
if not bR:IsA("BasePart") or bR:IsA("Terrain") then
return
end
local bS = bL[bR]
if not bS then
if not C() then
return
end
bS = {
bR.Transparency,
bR.Color,
}
bL[bR] = bS
end
bR.Transparency = (bD.asus and bS[1] < 1) and math.max(bS[1], bD.asusValue) or bS[1]
bR.Color = bD.tint and bS[2]:Lerp(bD.tintColor, bD.tintStrength) or bS[2]
end
for bR, bS in ipairs(workspace:GetChildren()) do
if not bP[bS] and not u:GetPlayerFromCharacter(bS) then
pcall(z, bS)
for bU, bV in ipairs(bS:GetDescendants()) do
if bO ~= bM then
return
end
pcall(z, bV)
bQ = bQ + 1
if bQ % 2500 == 0 then
task.wait()
end
end
end
end
if not C() then
bL = {}
end
end)
end
local function b()
if bN then
return
end
bN = true
task.delay(0.3, function()
bN = false
if not aa.unloaded then
Q()
end
end)
end
local bO = Instance.new("Part")
bO.Name = "NightCCWeather"
bO.Anchored, bO.CanCollide, bO.CanQuery, bO.CanTouch, bO.CastShadow = true, false, false, false, false
bO.Transparency = 1
bO.Size = Vector3.new(140, 1, 140)
bO.Parent = aS
local bP = Instance.new("ParticleEmitter")
bP.EmissionDirection = Enum.NormalId.Bottom
bP.Enabled = false
bP.Parent = bO
local function w()
local bQ, bR = bD.weather, bD.weatherAmount
bP.Enabled = bQ ~= "Off"
if bQ == "Snow" then
bP.Rate = 350 * bR
bP.night.cc = NumberRange.new(7, 9)
bP.Speed = NumberRange.new(8, 12)
bP.SpreadAngle = Vector2.new(12, 12)
bP.Acceleration = Vector3.new(1.5, 0, 0.5)
bP.Size = NumberSequence.new(0.22)
bP.Transparency = NumberSequence.new(0.15)
bP.Color = ColorSequence.new(bF)
bP.LightEmission = 0.6
bP.RotSpeed = NumberRange.new(-60, 60)
pcall(function()
bP.Orientation = Enum.ParticleOrientation.FacingCamera
end)
pcall(function()
bP.Squash = NumberSequence.new(0)
end)
elseif bQ == "Rain" then
bP.Rate = 1400 * bR
bP.night.cc = NumberRange.new(0.8, 1)
bP.Speed = NumberRange.new(85, 95)
bP.SpreadAngle = Vector2.new(2, 2)
bP.Acceleration = Vector3.new(0, 0, 0)
bP.Size = NumberSequence.new(0.14)
bP.Transparency = NumberSequence.new(0.45)
bP.Color = ColorSequence.new(Color3.fromRGB(170, 195, 255))
bP.LightEmission = 0.3
bP.RotSpeed = NumberRange.new(0)
pcall(function()
bP.Orientation = Enum.ParticleOrientation.VelocityParallel
end)
pcall(function()
bP.Squash = NumberSequence.new(6)
end)
end
end
local bQ, bR = 0, workspace:GetAttribute("Map")
aa.connect(O.RenderStepped, function()
if bD.fullbright then
bm.Ambient, bm.OutdoorAmbient = bF, bF
bm.Brightness = 2
elseif bD.bright then
bm.Brightness = bD.brightness
end
if bD.bright then
bm.ExposureCompensation = bD.exposure
end
if bD.fog == "None" then
bm.FogStart, bm.FogEnd = 1000000, 1000000
elseif bD.fog == "Custom" then
bm.FogColor, bm.FogStart, bm.FogEnd = bD.fogColor, bD.fogStart, math.max(bD.fogEnd, bD.fogStart + 1)
end
if bD.weather ~= "Off" then
bO.CFrame = CFrame.new(at.CFrame.Position + Vector3.new(0, bD.weather == "Rain" and 45 or 35, 0))
end
local bS = os.clock()
if bS - bQ > 0.5 then
bQ = bS
if bD.noPost then
q()
end
if bD.fog ~= "Default" and bm:FindFirstChildOfClass("Atmosphere") then
y(bD.fog)
end
local bU = workspace:GetAttribute("Map")
if bU ~= bR then
bR = bU
bL = {}
if C() then
task.delay(3, function()
if not aa.unloaded then
Q()
end
end)
end
end
end
end)
local function o()
if not bD.fullbright and not bD.bright then
bm.Brightness = bE.Brightness
end
if not bD.fullbright and not bo then
bm.Ambient, bm.OutdoorAmbient = bw, bx
end
if not bD.bright then
bm.ExposureCompensation = bE.Exposure
end
end
aa.onUnload(function()
bD.fullbright, bD.bright, bD.noPost, bD.asus, bD.tint = false, false, false, false, false
pcall(o)
pcall(y, "Default")
pcall(v)
bM = bM + 1
for bS, bU in pairs(bL) do
pcall(function()
bS.Transparency, bS.Color = bU[1], bU[2]
end)
end
bG:Destroy()
bH:Destroy()
bI:Destroy()
end)
local function n()
local bS = bD.nightStrength
bH.Enabled = bD.night
bH.Brightness = -0.28 * bS
bH.Contrast = 0.2 * bS
bH.Saturation = -0.15 * bS
bH.TintColor = bF:Lerp(Color3.fromRGB(140, 155, 255), bS)
end
bA:Section({
Title = "brightness",
})
bA:Toggle({
Title = "no night",
Value = false,
Flag = "wrl_fullbright",
Callback = function(bS)
bD.fullbright = bS
if not bS then
o()
end
end,
})
bA:Toggle({
Title = "custom brightness",
Value = false,
Flag = "wrl_bright",
Callback = function(bS)
bD.bright = bS
if not bS then
o()
end
end,
})
bA:Slider({
Title = "sun brightness",
Value = {
Min = 0,
Max = 10,
Default = 2,
},
Step = 0.1,
Flag = "wrl_brightness",
Callback = function(bS)
bD.brightness = bS
end,
})
bA:Slider({
Title = "exposure",
Value = {
Min = -3,
Max = 3,
Default = 0,
},
Step = 0.05,
Flag = "wrl_exposure",
Callback = function(bS)
bD.exposure = bS
end,
})
bA:Toggle({
Title = "night style",
Value = false,
Flag = "wrl_night",
Callback = function(bS)
bD.night = bS
n()
end,
})
bA:Slider({
Title = "night strength",
Value = {
Min = 0.1,
Max = 1,
Default = 0.6,
},
Step = 0.05,
Flag = "wrl_nightStrength",
Callback = function(bS)
bD.nightStrength = bS
n()
end,
})
bA:Section({
Title = "mist",
})
bA:Dropdown({
Title = "mist",
Values = {
"Default",
"None",
"Custom",
},
Value = "Default",
Flag = "wrl_fog",
Callback = function(bS)
y(type(bS) == "table" and bS[1] or bS)
end,
})
bA:Colorpicker({
Title = "fog tint",
Default = bD.fogColor,
Flag = "wrl_fogColor",
Callback = function(bS)
bD.fogColor = bS
end,
})
bA:Slider({
Title = "fog start",
Value = {
Min = 0,
Max = 1000,
Default = 0,
},
Step = 10,
Flag = "wrl_fogStart",
Callback = function(bS)
bD.fogStart = bS
end,
})
bA:Slider({
Title = "fog end",
Value = {
Min = 20,
Max = 3000,
Default = 400,
},
Step = 10,
Flag = "wrl_fogEnd",
Callback = function(bS)
bD.fogEnd = bS
end,
})
bA:Section({
Title = "post processing",
})
bA:Toggle({
Title = "remove game effects",
Value = false,
Flag = "wrl_noPost",
Callback = function(bS)
bD.noPost = bS
if bS then
q()
else
v()
end
end,
})
bA:Toggle({
Title = "tint grading",
Value = false,
Flag = "wrl_grade",
Callback = function(bS)
bG.Enabled = bS
end,
})
bA:Slider({
Title = "contrast",
Value = {
Min = -1,
Max = 2,
Default = 0,
},
Step = 0.05,
Flag = "wrl_contrast",
Callback = function(bS)
bG.Contrast = bS
end,
})
bA:Slider({
Title = "grade brightness",
Value = {
Min = -1,
Max = 1,
Default = 0,
},
Step = 0.05,
Flag = "wrl_gradeBright",
Callback = function(bS)
bG.Brightness = bS
end,
})
bA:Colorpicker({
Title = "screen tint",
Default = bF,
Flag = "wrl_gradeTint",
Callback = function(bS)
bG.TintColor = bS
end,
})
bA:Toggle({
Title = "bloom",
Value = false,
Flag = "wrl_bloom",
Callback = function(bS)
bI.Enabled = bS
end,
})
bA:Slider({
Title = "bloom intensity",
Value = {
Min = 0,
Max = 5,
Default = 1,
},
Step = 0.05,
Flag = "wrl_bloomIntensity",
Callback = function(bS)
bI.Intensity = bS
end,
})
bA:Slider({
Title = "bloom scale",
Value = {
Min = 0,
Max = 56,
Default = 24,
},
Flag = "wrl_bloomSize",
Callback = function(bS)
bI.Size = bS
end,
})
bA:Slider({
Title = "bloom threshold",
Value = {
Min = 0,
Max = 4,
Default = 2,
},
Step = 0.05,
Flag = "wrl_bloomThreshold",
Callback = function(bS)
bI.Threshold = bS
end,
})
bA:Section({
Title = "map",
})
bA:Toggle({
Title = "see-through walls",
Value = false,
Flag = "wrl_asus",
Callback = function(bS)
bD.asus = bS
Q()
end,
})
bA:Slider({
Title = "wall fade",
Value = {
Min = 10,
Max = 95,
Default = 50,
},
Step = 5,
Flag = "wrl_asusValue",
Callback = function(bS)
bD.asusValue = bS / 100
if bD.asus then
b()
end
end,
})
bA:Toggle({
Title = "map tint",
Value = false,
Flag = "wrl_tint",
Callback = function(bS)
bD.tint = bS
Q()
end,
})
bA:Colorpicker({
Title = "tint tint",
Default = bD.tintColor,
Flag = "wrl_tintColor",
Callback = function(bS)
bD.tintColor = bS
if bD.tint then
b()
end
end,
})
bA:Slider({
Title = "tint strength",
Value = {
Min = 5,
Max = 100,
Default = 50,
},
Step = 5,
Flag = "wrl_tintStrength",
Callback = function(bS)
bD.tintStrength = bS / 100
if bD.tint then
b()
end
end,
})
bA:Section({
Title = "weather",
})
bA:Dropdown({
Title = "weather",
Values = {
"Off",
"Snow",
"Rain",
},
Value = "Off",
Flag = "wrl_weather",
Callback = function(bS)
bD.weather = type(bS) == "table" and bS[1] or bS
w()
end,
})
bA:Slider({
Title = "weather amount",
Value = {
Min = 0.2,
Max = 3,
Default = 1,
},
Step = 0.1,
Flag = "wrl_weatherAmount",
Callback = function(bS)
bD.weatherAmount = bS
w()
end,
})
end
do
local bD, bE, bF =
{
drops = false,
dropColor = Color3.fromRGB(235, 235, 240),
dropDist = 150,
bomb = false,
shotChams = false,
shotColor = Color3.fromRGB(120, 190, 255),
shotLife = 2,
sun = false,
sunLatitude = 40,
lightColor = Color3.fromRGB(255, 170, 110),
noCelestial = false,
noStars = false,
noClouds = false,
}, Color3.fromRGB(255, 86, 110), Instance.new("Folder")
bF.Name = "WorldItems"
bF.Parent = aS
local bG, bH, bI = {}, nil, nil
local function l(bJ)
local bK = bJ:IsA("Model") and bJ.PrimaryPart
or bJ:IsA("BasePart") and bJ
or bJ:FindFirstChildWhichIsA("BasePart", true)
if not bK then
return nil
end
local bL = Instance.new("BillboardGui")
bL.Size = UDim2.fromOffset(160, 30)
bL.AlwaysOnTop = true
bL.StudsOffset = Vector3.new(0, 1, 0)
bL.Adornee = bK
bL.Parent = bF
local bM = Instance.new("TextLabel")
bM.Size = UDim2.fromScale(1, 1)
bM.BackgroundTransparency = 1
bM.Font = Enum.Font.Gotham
bM.TextSize = 12
bM.TextStrokeTransparency = 0.4
bM.Parent = bL
local bN = {
gui = bL,
label = bM,
part = bK,
}
bG[bJ] = bN
return bN
end
local function r(bJ)
local bK = bG[bJ]
if bK then
bK.gui:Destroy()
bG[bJ] = nil
end
end
local bJ = Instance.new("Frame")
bJ.AnchorPoint = Vector2.new(0.5, 0)
bJ.Position = UDim2.new(0.5, 0, 0, 150)
bJ.Size = UDim2.fromOffset(240, 26)
bJ.BackgroundColor3 = Color3.fromRGB(13, 13, 17)
bJ.BackgroundTransparency = 0.1
bJ.BorderSizePixel = 0
bJ.Visible = false
bJ.Parent = aL;
(Instance.new("UICorner", bJ)).CornerRadius = UDim.new(0, 4)
local bK = Instance.new("Frame")
bK.Position = UDim2.new(0, 0, 1, -2)
bK.Size = UDim2.new(1, 0, 0, 2)
bK.BorderSizePixel = 0
bK.Parent = bJ
local bL = Instance.new("TextLabel")
bL.Size = UDim2.new(1, 0, 1, -2)
bL.BackgroundTransparency = 1
bL.Font = Enum.Font.Gotham
bL.TextSize = 13
bL.TextColor3 = Color3.fromRGB(235, 235, 240)
bL.Parent = bJ
local bM = 0
aa.connect(O.RenderStepped, function()
local bN = os.clock()
if not (bD.drops or bD.bomb) then
if next(bG) then
for bO in pairs(bG) do
r(bO)
end
end
bJ.Visible = false
bH = nil
return
end
if bN - bM > 0.25 then
bM = bN
local bO, bP = workspace:FindFirstChild("Debris"), {}
bH = nil
if bO then
for bQ, bR in ipairs(bO:GetChildren()) do
if bR:IsA("Model") then
local bS = bR:GetAttribute("BombPlanted")
if type(bS) == "string" then
if bD.bomb then
bH = bR
local bU, bV = pcall(ar.JSONDecode, ar, bS)
bI = bU and (type(bV) == "table" and bV) or {}
bP[bR] = true
end
elseif bD.drops and type(bR:GetAttribute("Weapon")) == "string" then
bP[bR] = true
end
end
end
end
if bD.bomb and not bH then
for bQ, bR in ipairs((game:GetService("CollectionService")):GetTagged("Bomb")) do
local bS = bR:GetAttribute("BombPlanted")
if type(bS) == "string" and bR:IsDescendantOf(workspace) then
bH = bR
local bU, bV = pcall(ar.JSONDecode, ar, bS)
bI = bU and (type(bV) == "table" and bV) or {}
bP[bR] = true
break
end
end
end
for bQ in pairs(bG) do
if not bP[bQ] or not bQ.Parent then
r(bQ)
end
end
for bQ in pairs(bP) do
if not bG[bQ] then
l(bQ)
end
end
end
local bO = (U()).Position
for bP, bQ in pairs(bG) do
if bP ~= bH and bQ.part.Parent then
local bR, bS = (bQ.part.Position - bO).Magnitude, bP:GetAttribute("Weapon")
local bU = bS == "C4"
bQ.gui.Enabled = bU or bR <= bD.dropDist
bQ.label.TextColor3 = bU and bE or bD.dropColor
bQ.label.Text = tostring(bS) .. ("  " .. (math.floor(bR * 0.28) .. "m"))
end
end
local bP = false
if bH and (bH.Parent and bG[bH]) then
local bQ, bR, bS =
bG[bH],
math.max(tonumber(bI.TimeUntilExplode) or 40, 0.1),
tonumber(bI.Time) or workspace:GetServerTimeNow()
local bU, bV, bW =
math.max((bS + bR) - workspace:GetServerTimeNow(), 0),
bH:GetAttribute("Defused") == true,
bH:GetAttribute("Exploded") == true or bH:GetAttribute("Exploding") == true
local bX = bV and "DEFUSED" or bW and "EXPLODED" or ("%.1fs"):format(bU)
bQ.gui.Enabled = true
bQ.label.TextColor3 = bE
bQ.label.Text = "C4  " .. (bX .. ("  " .. (math.floor((bQ.part.Position - bO).Magnitude * 0.28) .. "m")))
bP = true
local bY, bZ = bV and 1 or math.clamp(bU / bR, 0, 1), type(bI.Site) == "string" and " " .. bI.Site or ""
bL.Text = "BOMB" .. (bZ .. ("  " .. bX))
bK.Size = UDim2.new(bY, 0, 0, 2)
bK.BackgroundColor3 = bV and Color3.fromRGB(110, 230, 140)
or (Color3.fromRGB(255, 70, 90)):Lerp(Color3.fromRGB(110, 230, 140), bY)
end
bJ.Visible = bP
end)
local bN, bO =
{
"Head",
"UpperTorso",
"LowerTorso",
"LeftUpperArm",
"LeftLowerArm",
"LeftHand",
"RightUpperArm",
"RightLowerArm",
"RightHand",
"LeftUpperLeg",
"LeftLowerLeg",
"LeftFoot",
"RightUpperLeg",
"RightLowerLeg",
"RightFoot",
}, a_.onConfirm
function a_.onConfirm(bP, bQ, bR, bS, bU)
if bO then
pcall(bO, bP, bQ, bR, bS, bU)
end
if not bD.shotChams or not bS then
return
end
local bV = Instance.new("Model")
bV.Name = "ShotCham"
local bW = 0
for bX, bY in ipairs(bN) do
local bZ = bS:FindFirstChild(bY)
if bZ and bZ:IsA("BasePart") then
local b_ = Instance.new("Part")
b_.Anchored, b_.CanCollide, b_.CanQuery, b_.CanTouch, b_.CastShadow = true, false, false, false, false
b_.Material = Enum.Material.Neon
b_.Color = bD.shotColor
b_.Transparency = 0.75
b_.Size = bZ.Size
b_.CFrame = bZ.CFrame
b_.Parent = bV
bW = bW + 1
end
end
if bW == 0 then
bV:Destroy()
return
end
local bX = Instance.new("Highlight")
bX.FillColor, bX.OutlineColor = bD.shotColor, bD.shotColor
bX.FillTransparency = 0.6
bX.OutlineTransparency = 0
bX.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
bX.Parent = bV
bV.Parent = bF
local bY = TweenInfo.new(bD.shotLife, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
(ap:Create(bX, bY, {
FillTransparency = 1,
OutlineTransparency = 1,
})):Play()
for bZ, b_ in ipairs(bV:GetChildren()) do
if b_:IsA("BasePart") then
(ap:Create(b_, bY, { Transparency = 1 })):Play()
end
end
as:AddItem(bV, bD.shotLife + 0.1)
end
local bP = game:GetService("Lighting")
local bQ, bR, bS, bU = {
latitude = bP.GeographicLatitude,
top = bP.ColorShift_Top,
}, {}, nil, {}
local function w()
for bV, bW in ipairs(bP:GetChildren()) do
if bW:IsA("Sky") then
if not bR[bW] then
bR[bW] = {
bW.CelestialBodiesShown,
bW.StarCount,
bW.SunAngularSize,
bW.MoonAngularSize,
}
end
local bX = bR[bW]
bW.CelestialBodiesShown = not bD.noCelestial and bX[1]
bW.SunAngularSize = bD.noCelestial and 0 or bX[3]
bW.MoonAngularSize = bD.noCelestial and 0 or bX[4]
bW.StarCount = bD.noStars and 0 or bX[2]
elseif bW:IsA("SunRaysEffect") then
if bU[bW] == nil then
bU[bW] = bW.Enabled
end
bW.Enabled = not bD.noCelestial and bU[bW]
end
end
for bV, bW in ipairs(at:GetChildren()) do
if bW:IsA("SunRaysEffect") then
if bU[bW] == nil then
bU[bW] = bW.Enabled
end
bW.Enabled = not bD.noCelestial and bU[bW]
end
end
local bV = workspace.Terrain:FindFirstChildOfClass("Clouds")
if bV then
if bS == nil then
bS = bV.Enabled
end
bV.Enabled = not bD.noClouds and bS
end
end
local bV = 0
aa.connect(O.Heartbeat, function()
if bD.sun then
bP.GeographicLatitude = bD.sunLatitude
bP.ColorShift_Top = bD.lightColor
end
if (bD.noCelestial or bD.noStars or bD.noClouds) and os.clock() - bV > 0.5 then
bV = os.clock()
pcall(w)
end
end)
aa.connect(bP.ChildAdded, function(bW)
if (bD.noCelestial or bD.noStars) and (bW:IsA("Sky") or bW:IsA("SunRaysEffect")) then
task.defer(function()
pcall(w)
end)
end
end)
local function n()
bP.GeographicLatitude = bQ.latitude
bP.ColorShift_Top = bQ.top
end
aa.onUnload(function()
pcall(n)
bD.noCelestial, bD.noStars, bD.noClouds = false, false, false
pcall(w)
pcall(function()
bJ:Destroy()
end)
pcall(function()
bF:Destroy()
end)
a_.onConfirm = bO
end)
bA:Section({
Title = "items",
})
bA:Toggle({
Title = "dropped loadouts",
Value = false,
Flag = "wrl_drops",
Callback = function(bW)
bD.drops = bW
end,
})
bA:Colorpicker({
Title = "dropped loadout tint",
Default = bD.dropColor,
Flag = "wrl_dropColor",
Callback = function(bW)
bD.dropColor = bW
end,
})
bA:Slider({
Title = "dropped loadout range",
Value = {
Min = 20,
Max = 600,
Default = 150,
},
Step = 10,
Flag = "wrl_dropDist",
Callback = function(bW)
bD.dropDist = bW
end,
})
bA:Toggle({
Title = "bomb timer",
Value = false,
Flag = "wrl_bomb",
Callback = function(bW)
bD.bomb = bW
end,
})
end
do
local wrl = {
trail = false,
spotlight = false,
cleanDebris = false,
muteAmbient = false,
letterbox = false,
fps = false,
jumpRing = false,
trailColor = Color3.fromRGB(120, 200, 255),
spotColor = Color3.fromRGB(255, 240, 210),
}
local trailParts = {}
local spot = nil
local letterGui = nil
local fpsGui = nil
local fpsLabel = nil
local lastFpsT, frames = os.clock(), 0
local cleanTick = 0
local muted = {}
local function clearTrail()
for _, p in ipairs(trailParts) do
pcall(function() p:Destroy() end)
end
trailParts = {}
end
local function ensureSpot()
if spot and spot.Parent then return spot end
local s = Instance.new("SpotLight")
s.Name = "NightCC_Spot"
s.Brightness = 3
s.Range = 28
s.Angle = 70
s.Face = Enum.NormalId.Front
s.Color = wrl.spotColor
s.Parent = workspace.CurrentCamera
spot = s
return s
end
local function clearSpot()
if spot then pcall(function() spot:Destroy() end) spot = nil end
end
local function ensureLetterbox()
if letterGui and letterGui.Parent then return end
local cg = gethui and gethui() or game:GetService("CoreGui")
local sg = Instance.new("ScreenGui")
sg.Name = "NightCC_Letterbox"
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147482900
sg.Parent = cg
for _, side in ipairs({"Top", "Bottom"}) do
local f = Instance.new("Frame")
f.BackgroundColor3 = Color3.new(0, 0, 0)
f.BorderSizePixel = 0
f.Size = UDim2.new(1, 0, 0, 70)
f.Position = side == "Top" and UDim2.new(0, 0, 0, 0) or UDim2.new(0, 0, 1, -70)
f.Parent = sg
end
letterGui = sg
end
local function clearLetterbox()
if letterGui then pcall(function() letterGui:Destroy() end) letterGui = nil end
end
local function ensureFps()
if fpsGui and fpsGui.Parent then return end
local cg = gethui and gethui() or game:GetService("CoreGui")
local sg = Instance.new("ScreenGui")
sg.Name = "NightCC_FPS"
sg.IgnoreGuiInset = true
sg.DisplayOrder = 2147482910
sg.Parent = cg
local lbl = Instance.new("TextLabel")
lbl.BackgroundTransparency = 1
lbl.Position = UDim2.new(1, -120, 0, 8)
lbl.Size = UDim2.fromOffset(110, 20)
lbl.Font = Enum.Font.Gotham
lbl.TextSize = 14
lbl.TextColor3 = Color3.fromRGB(180, 255, 180)
lbl.TextXAlignment = Enum.TextXAlignment.Right
lbl.Text = "0 fps"
lbl.Parent = sg
fpsGui, fpsLabel = sg, lbl
end
local function clearFps()
if fpsGui then pcall(function() fpsGui:Destroy() end) end
fpsGui, fpsLabel = nil, nil
end
local function spawnJumpRing(pos)
local p = Instance.new("Part")
p.Anchored = true
p.CanCollide = false
p.CanQuery = false
p.CanTouch = false
p.CastShadow = false
p.Material = Enum.Material.Neon
p.Color = Color3.fromRGB(120, 220, 255)
p.Transparency = 0.2
p.Size = Vector3.new(1, 0.15, 1)
p.CFrame = CFrame.new(pos + Vector3.new(0, 0.1, 0))
p.Parent = workspace
local ts = game:GetService("TweenService")
ts:Create(p, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
Size = Vector3.new(9, 0.12, 9),
Transparency = 1,
}):Play()
game:GetService("Debris"):AddItem(p, 0.6)
end
bA:Section({ Title = "nightcc extras" })
bA:Toggle({
Title = "entity trail",
Value = false,
Flag = "wrl_trail",
Callback = function(v)
wrl.trail = v == true
if not wrl.trail then clearTrail() end
end,
})
bA:Colorpicker({
Title = "trail tint",
Default = wrl.trailColor,
Flag = "wrl_trailColor",
Callback = function(v)
if typeof(v) == "Color3" then wrl.trailColor = v end
end,
})
bA:Toggle({
Title = "entity spotlight",
Value = false,
Flag = "wrl_spotlight",
Callback = function(v)
wrl.spotlight = v == true
if wrl.spotlight then ensureSpot() else clearSpot() end
end,
})
bA:Colorpicker({
Title = "spotlight tint",
Default = wrl.spotColor,
Flag = "wrl_spotColor",
Callback = function(v)
if typeof(v) == "Color3" then
wrl.spotColor = v
if spot then spot.Color = v end
end
end,
})
bA:Toggle({
Title = "clean debris",
Desc = "periodically clear workspace Debris folder",
Value = false,
Flag = "wrl_cleanDebris",
Callback = function(v)
wrl.cleanDebris = v == true
end,
})
bA:Toggle({
Title = "mute ambient",
Desc = "mute non-weapon ambient/world sounds",
Value = false,
Flag = "wrl_muteAmbient",
Callback = function(v)
wrl.muteAmbient = v == true
if not v then
for s, vol in pairs(muted) do
pcall(function() if s.Parent then s.Volume = vol end end)
end
muted = {}
end
end,
})
bA:Toggle({
Title = "cinematic bars",
Value = false,
Flag = "wrl_letterbox",
Callback = function(v)
wrl.letterbox = v == true
if wrl.letterbox then ensureLetterbox() else clearLetterbox() end
end,
})
bA:Toggle({
Title = "fps counter",
Value = false,
Flag = "wrl_fps",
Callback = function(v)
wrl.fps = v == true
if wrl.fps then ensureFps() else clearFps() end
end,
})
bA:Toggle({
Title = "jump ring",
Desc = "neon ring when you land",
Value = false,
Flag = "wrl_jumpRing",
Callback = function(v)
wrl.jumpRing = v == true
end,
})
do
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local touch = game:GetService("UserInputService").TouchEnabled
local NS, NSK, CS = NumberSequence.new, NumberSequenceKeypoint.new, ColorSequence.new
local fadeInOut = NS({ NSK(0, 1), NSK(0.12, 0.15), NSK(0.85, 0.15), NSK(1, 1) })
local presets = {
["Winter"] = {
ambient = Color3.fromRGB(140, 160, 190), outdoor = Color3.fromRGB(165, 185, 215), fog = Color3.fromRGB(200, 215, 235),
clock = 14, atmoColor = Color3.fromRGB(210, 225, 245), atmoDecay = Color3.fromRGB(190, 205, 230),
density = 0.32, haze = 1.2, glare = 0, tint = Color3.fromRGB(225, 238, 255), sat = -0.12, contrast = 0.05, bright = 0.02,
bloom = 0.3, bloomSize = 24, bloomThr = 1,
rate = 140, life = NumberRange.new(7, 10), speed = NumberRange.new(6, 10), spread = Vector2.new(20, 20),
dir = Enum.NormalId.Bottom, height = 40, size = NS(0.24), color = CS(Color3.fromRGB(255, 255, 255), Color3.fromRGB(205, 225, 255)),
glow = 0.6, accel = Vector3.new(3, 0, 2), rot = NumberRange.new(-40, 40),
},
["Halloween"] = {
ambient = Color3.fromRGB(70, 40, 85), outdoor = Color3.fromRGB(90, 45, 95), fog = Color3.fromRGB(60, 30, 70),
clock = 18.9, atmoColor = Color3.fromRGB(255, 120, 50), atmoDecay = Color3.fromRGB(120, 50, 160),
density = 0.38, haze = 1.8, glare = 0.3, tint = Color3.fromRGB(255, 200, 160), sat = 0.15, contrast = 0.12, bright = -0.03,
bloom = 0.5, bloomSize = 26, bloomThr = 0.95,
rate = 45, life = NumberRange.new(5, 8), speed = NumberRange.new(1.5, 4), spread = Vector2.new(35, 35),
dir = Enum.NormalId.Top, height = -4, size = NS({ NSK(0, 0.4), NSK(1, 0) }), color = CS(Color3.fromRGB(255, 150, 40), Color3.fromRGB(150, 60, 220)),
glow = 1, accel = Vector3.new(0.5, 1.2, 0), rot = NumberRange.new(0, 360),
},
["Neon night"] = {
ambient = Color3.fromRGB(60, 20, 90), outdoor = Color3.fromRGB(40, 30, 120), fog = Color3.fromRGB(30, 10, 60),
clock = 0, atmoColor = Color3.fromRGB(120, 60, 255), atmoDecay = Color3.fromRGB(255, 0, 160),
density = 0.3, haze = 1.4, glare = 0.2, tint = Color3.fromRGB(230, 190, 255), sat = 0.25, contrast = 0.15, bright = 0,
bloom = 0.9, bloomSize = 30, bloomThr = 0.8,
rate = 60, life = NumberRange.new(6, 9), speed = NumberRange.new(1, 3), spread = Vector2.new(180, 180),
dir = Enum.NormalId.Top, height = 2, size = NS(0.3), color = CS(Color3.fromRGB(0, 255, 255), Color3.fromRGB(255, 0, 200)),
glow = 1, accel = Vector3.new(0, 0.3, 0), rot = NumberRange.new(0, 360),
},
}
local active, name, strength = false, "Winter", 0.6
local saved, cc, bloom, atmo, anchor, emitter
local acc, height = 0, 40
local function put(obj, prop, value)
if obj[prop] ~= value then obj[prop] = value end
end
local function snapshot()
saved = {
Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient, FogColor = Lighting.FogColor,
FogStart = Lighting.FogStart, FogEnd = Lighting.FogEnd, ClockTime = Lighting.ClockTime,
}
end
local function destroyAll()
for _, obj in ipairs({ cc, bloom, atmo, anchor }) do
pcall(function() obj:Destroy() end)
end
cc, bloom, atmo, anchor, emitter = nil, nil, nil, nil, nil
end
local function restore()
if saved then
for prop, value in pairs(saved) do
pcall(function() Lighting[prop] = value end)
end
saved = nil
end
destroyAll()
end
local function ensure()
if not cc or cc.Parent ~= Lighting then
cc = Instance.new("ColorCorrectionEffect")
cc.Name = "SeasonFx_CC"
cc.Parent = Lighting
end
if not bloom or bloom.Parent ~= Lighting then
bloom = Instance.new("BloomEffect")
bloom.Name = "SeasonFx_Bloom"
bloom.Parent = Lighting
end
if not atmo or atmo.Parent ~= Lighting then
atmo = Instance.new("Atmosphere")
atmo.Name = "SeasonFx_Atmosphere"
atmo.Offset = 0.2
atmo.Parent = Lighting
end
local cam = workspace.CurrentCamera
if cam and (not anchor or anchor.Parent ~= cam) then
if anchor then pcall(function() anchor:Destroy() end) end
anchor = Instance.new("Part")
anchor.Name = "SeasonFx_Emitter"
anchor.Anchored = true
anchor.CanCollide = false
anchor.CanQuery = false
anchor.CanTouch = false
anchor.CastShadow = false
anchor.Transparency = 1
anchor.Size = Vector3.new(90, 1, 90)
anchor.Parent = cam
emitter = Instance.new("ParticleEmitter")
emitter.Name = "SeasonFx_Particles"
emitter.Transparency = fadeInOut
emitter.LightInfluence = 0
emitter.Parent = anchor
end
end
local function apply()
local p = presets[name]
if not (active and p) then return end
if not saved then snapshot() end
ensure()
local k = 0.35 + 0.65 * strength
put(Lighting, "Ambient", saved.Ambient:Lerp(p.ambient, k))
put(Lighting, "OutdoorAmbient", saved.OutdoorAmbient:Lerp(p.outdoor, k))
put(Lighting, "FogColor", saved.FogColor:Lerp(p.fog, k))
put(Lighting, "ClockTime", p.clock)
if cc then
put(cc, "TintColor", Color3.new(1, 1, 1):Lerp(p.tint, strength))
put(cc, "Saturation", p.sat * strength)
put(cc, "Contrast", p.contrast * strength)
put(cc, "Brightness", p.bright * strength)
end
if bloom then
put(bloom, "Intensity", p.bloom * strength)
put(bloom, "Size", p.bloomSize)
put(bloom, "Threshold", p.bloomThr)
end
if atmo then
put(atmo, "Color", p.atmoColor)
put(atmo, "Decay", p.atmoDecay)
put(atmo, "Density", p.density * strength)
put(atmo, "Haze", p.haze)
put(atmo, "Glare", p.glare)
end
if emitter then
put(emitter, "Rate", p.rate * strength * (touch and 0.5 or 1))
put(emitter, "Lifetime", p.life)
put(emitter, "Speed", p.speed)
put(emitter, "SpreadAngle", p.spread)
put(emitter, "EmissionDirection", p.dir)
put(emitter, "Size", p.size)
put(emitter, "Color", p.color)
put(emitter, "LightEmission", p.glow)
put(emitter, "Acceleration", p.accel)
put(emitter, "Rotation", p.rot)
height = p.height
end
end
bA:Toggle({
Title = "season atmosphere",
Desc = "winter, halloween or neon night mood (only you see it)",
Value = false,
Flag = "wrl_season",
Callback = function(v)
active = v == true
if active then apply() else restore() end
end,
})
bA:Dropdown({
Title = "season",
Values = { "Winter", "Halloween", "Neon night" },
Value = "Winter",
Flag = "wrl_seasonType",
Callback = function(v)
local choice = type(v) == "table" and v[1] or v
if presets[choice] then
name = choice
apply()
end
end,
})
bA:Slider({
Title = "season intensity",
Value = { Min = 0, Max = 100, Default = 60 },
Step = 1,
Flag = "wrl_seasonStrength",
Callback = function(v)
strength = math.clamp((tonumber(v) or 60) / 100, 0, 1)
apply()
end,
})
aa.connect(RunService.RenderStepped, function(dt)
if not active or not anchor or not anchor.Parent then return end
local cam = workspace.CurrentCamera
if cam then
anchor.CFrame = CFrame.new(cam.CFrame.Position + Vector3.new(0, height, 0))
end
acc = acc + dt
if acc >= 0.25 then
acc = 0
apply()
end
end)
aa.onUnload(restore)
end
local trailAcc = 0
local muteTick = 0
aa.connect(O.Heartbeat, function(dt)
local char = u.LocalPlayer.Character
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if wrl.trail and hrp then
trailAcc = trailAcc + dt
if trailAcc >= 0.07 then
trailAcc = 0
local p = Instance.new("Part")
p.Anchored = true
p.CanCollide = false
p.CanQuery = false
p.CanTouch = false
p.CastShadow = false
p.Material = Enum.Material.Neon
p.Color = wrl.trailColor
p.Size = Vector3.new(0.35, 0.35, 0.35)
p.Transparency = 0.15
p.CFrame = hrp.CFrame * CFrame.new(0, -2.5, 0)
p.Parent = workspace
table.insert(trailParts, p)
game:GetService("TweenService"):Create(p, TweenInfo.new(0.8), {
Transparency = 1,
Size = Vector3.new(0.05, 0.05, 0.05),
}):Play()
game:GetService("Debris"):AddItem(p, 0.85)
if #trailParts > 40 then
local old = table.remove(trailParts, 1)
pcall(function() old:Destroy() end)
end
end
end
if wrl.spotlight then
local s = ensureSpot()
if hrp then
s.Parent = hrp
s.Face = Enum.NormalId.Front
end
end
if wrl.cleanDebris then
local now = os.clock()
if now - cleanTick > 2.5 then
cleanTick = now
local d = workspace:FindFirstChild("Debris")
if d then
local n = 0
for _, ch in ipairs(d:GetChildren()) do
if n > 80 then break end
if ch:GetAttribute("BombPlanted") == nil and ch:GetAttribute("Weapon") == nil then
pcall(function() ch:Destroy() end)
n = n + 1
end
end
end
end
end
if wrl.muteAmbient and os.clock() - muteTick >= 1 then
muteTick = os.clock()
for _, s in ipairs(workspace:GetDescendants()) do
if s:IsA("Sound") and s.IsPlaying and not muted[s] then
local id = tostring(s.SoundId or "")
if s.Volume > 0 and (s.RollOffMaxDistance > 50 or s.Parent == workspace) then
muted[s] = s.Volume
s.Volume = 0
end
end
end
end
end)
aa.connect(O.RenderStepped, function()
if wrl.fps then
frames = frames + 1
local now = os.clock()
if now - lastFpsT >= 0.5 then
local fps = math.floor(frames / (now - lastFpsT) + 0.5)
frames = 0
lastFpsT = now
if fpsLabel then
fpsLabel.Text = tostring(fps) .. " fps"
end
end
end
end)
local wasAir = false
aa.connect(O.Heartbeat, function()
if not wrl.jumpRing then return end
local char = u.LocalPlayer.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if not (hum and hrp) then return end
local air = hum.FloorMaterial == Enum.Material.Air
if wasAir and not air then
spawnJumpRing(hrp.Position - Vector3.new(0, 2.8, 0))
end
wasAir = air
end)
aa.onUnload(function()
clearTrail()
clearSpot()
clearLetterbox()
clearFps()
for s, vol in pairs(muted) do
pcall(function() if s.Parent then s.Volume = vol end end)
end
end)
end
local bD, bE, bF = {}, "nightcc/skins.json", {}
local function UU()
pcall(function()
if isfolder and (makefolder and not isfolder("nightcc")) then
if not isfolder("nightcc") then
makefolder("nightcc")
end
makefolder("nightcc")
end
writefile(
bE,
ar:JSONEncode({
skins = bD,
knife = aC.knife,
knifeSkin = aC.knifeSkin,
})
)
end)
end
pcall(function()
if isfile and isfile(bE) then
local bG = ar:JSONDecode(readfile(bE))
if type(bG) == "table" then
bD = type(bG.skins) == "table" and bG.skins or {}
aC.knife, aC.knifeSkin = bG.knife, bG.knifeSkin
end
end
end)
local bG, bH =
{
"Rifle",
"Pistol",
"SMG",
"Heavy",
"Knife",
}, {
Rifle = {},
Pistol = {},
SMG = {},
Heavy = {},
Knife = {},
}
do
local bI = {}
for bJ, bK in ipairs(aB:GetChildren()) do
if not bI[bK.Name] then
bI[bK.Name] = true
local bL, bM = pcall(require, bK)
if bL and type(bM) == "table" then
local bN
if bM.Class == "Melee" then
bN = "Knife"
bF[bK.Name] = true
elseif bM.Class == "Weapon" and bH[bM.Type] ~= nil then
bN = bM.Type
end
if bN then
local bO, bP = pcall(az.GetAllSkinsForWeapon, bK.Name)
if bO and type(bP) == "table" then
for bQ, bR in pairs(bP) do
if type(bR) == "table" and (bR.skin and (bR.skin ~= "Stock" and bR.isEnabled ~= false)) then
local bS = bR.wearImages and (bR.wearImages[1] and bR.wearImages[1].assetId)
table.insert(bH[bN], {
weapon = bK.Name,
skin = bR.skin,
rarity = bR.rarity,
image = bS or "",
})
end
end
end
end
end
end
end
for bJ, bK in pairs(bH) do
table.sort(bK, function(bL, bM)
if bL.weapon ~= bM.weapon then
return bL.weapon < bM.weapon
end
return bL.skin < bM.skin
end)
end
end
do
local bI
bI = Q(aA.new, function(bJ, bK, bL, bM)
if aa.unloaded or not aC.skins then
return bI(bJ, bK, bL, bM)
end
if aC.knife and (aC.knifeSkin and bF[bK]) then
if bK ~= aC.knife then
bJ.ViewmodelCameraWeapon = nil
end
return bI(bJ, aC.knife, aC.knifeSkin, bM)
end
return bI(bJ, bK, bD[bK] or bL, bM)
end)
pcall(function()
local bJ = require(L.Database.Components.Common.AttachGlovesToViewmodel)
if type(bJ) ~= "function" or type(az.GetGloves) ~= "function" then
return
end
local bK
bK = Q(bJ, function(bL, bM, ...)
if not aa.unloaded and (aC.skins and (aC.glove and aC.gloveSkin)) then
local bN, bO = pcall(az.GetGloves, aC.glove, aC.gloveSkin, aC.float)
if bN and typeof(bO) == "Instance" then
local bP = bO:GetChildren()
if #bP > 0 then
return bK(bP, bM, ...)
end
end
end
return bK(bL, bM, ...)
end)
end)
local bJ
bJ = Q(az.GetCameraModel, function(bK, bL, bM, bN, ...)
if aa.unloaded or not aC.skins then
return bJ(bK, bL, bM, bN, ...)
end
local bO = aC.statTrak and aC.statTrakCount or nil
local bP, bQ = pcall(bJ, bK, bL, aC.float, bO, ...)
if bP and bQ then
return bQ
end
return bJ(bK, bL, bM, bN, ...)
end)
pcall(function()
local bK
bK = Q(aA.claim, function(...)
if not aa.unloaded and aC.skins then
return nil
end
return bK(...)
end)
end)
end
local bI
do
local bJ = false
local function E()
bJ = false
if aa.unloaded then
return
end
local bK = _.Character
if not bK then
return
end
local bL, bM = pcall(filtergc, "table", {
Keys = {
"Viewmodel",
"Skin",
"Slot",
},
}, false)
if not bL or type(bM) ~= "table" then
return
end
if setthreadidentity then
pcall(setthreadidentity, 2)
end
for bN, bO in ipairs(bM) do
local bP = rawget(bO, "Viewmodel")
if
bO.Player == _
and (
not bO.Character
and (
not bO.IsDestroyed
and (type(bP) == "table" and (not bP.IsDestroyed and type(bP.construct) == "function"))
)
)
then
local bQ, bR = bO.Name, bO.Skin
if aC.skins then
if aC.knife and (aC.knifeSkin and bF[bO.Name]) then
bQ, bR = aC.knife, aC.knifeSkin
else
bR = bD[bO.Name] or bO.Skin
end
end
bP.Weapon, bP.CameraModelWeapon, bP.Skin = bQ, bQ, bR
pcall(bP.construct, bP, bK, bO)
if bP.IsEquipped then
pcall(bP.equip, bP, true)
end
end
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
end
bI = function()
if bJ then
return
end
bJ = true
task.defer(E)
end
end
pcall(function()
if type(bI) == "function" then
bI()
end
end)
-- ===== presets: save a full setup under a name and load it later (replaces the old config section) =====
do
	local selected = ag
	local presetDrop
	local dialog

	local function say(title, content)
		pcall(function()
			ac:Notify({ Title = title, Content = content, Duration = 3 })
		end)
	end

	local function refreshList(select)
		if not presetDrop then return end
		pcall(function() presetDrop:Refresh(K()) end)
		if select then
			pcall(function() presetDrop:Select(select) end)
		end
	end

	-- own text dialog: the menu's Input element does not draw a text box in this UI
	local function ask(title, placeholder, onOk, clean)
		if dialog then pcall(function() dialog:Destroy() end) end
		local gui = Instance.new("ScreenGui")
		gui.Name = "NightCCPresetDialog"
		gui.ResetOnSpawn = false
		gui.IgnoreGuiInset = true
		gui.DisplayOrder = 2000
		gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
		dialog = gui

		local dim = Instance.new("TextButton")
		dim.Size = UDim2.fromScale(1, 1)
		dim.BackgroundColor3 = Color3.new(0, 0, 0)
		dim.BackgroundTransparency = 0.45
		dim.BorderSizePixel = 0
		dim.AutoButtonColor = false
		dim.Text = ""
		dim.Parent = gui

		local box = Instance.new("Frame")
		box.AnchorPoint = Vector2.new(0.5, 0.5)
		box.Position = UDim2.fromScale(0.5, 0.42)
		box.Size = UDim2.fromOffset(340, 150)
		box.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
		box.BorderSizePixel = 0
		box.Parent = gui
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 12)
		local st = Instance.new("UIStroke", box)
		st.Color = Color3.fromRGB(70, 70, 90)

		local head = Instance.new("TextLabel")
		head.BackgroundTransparency = 1
		head.Position = UDim2.fromOffset(16, 12)
		head.Size = UDim2.new(1, -32, 0, 20)
		head.Font = Enum.Font.GothamBold
		head.TextSize = 15
		head.TextColor3 = Color3.fromRGB(240, 240, 250)
		head.TextXAlignment = Enum.TextXAlignment.Left
		head.Text = title
		head.Parent = box

		local tb = Instance.new("TextBox")
		tb.Position = UDim2.fromOffset(16, 46)
		tb.Size = UDim2.new(1, -32, 0, 36)
		tb.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
		tb.BorderSizePixel = 0
		tb.Font = Enum.Font.Gotham
		tb.TextSize = 14
		tb.TextColor3 = Color3.fromRGB(240, 240, 250)
		tb.PlaceholderText = placeholder
		tb.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
		tb.TextXAlignment = Enum.TextXAlignment.Left
		tb.ClearTextOnFocus = false
		tb.Text = ""
		tb.Parent = box
		Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 8)
		local pad = Instance.new("UIPadding", tb)
		pad.PaddingLeft, pad.PaddingRight = UDim.new(0, 10), UDim.new(0, 10)

		local function button(text, x, primary)
			local b = Instance.new("TextButton")
			b.Position = UDim2.new(0, x, 1, -50)
			b.Size = UDim2.fromOffset(148, 36)
			b.BackgroundColor3 = primary and Color3.fromRGB(235, 235, 245) or Color3.fromRGB(34, 34, 46)
			b.BorderSizePixel = 0
			b.Font = Enum.Font.GothamBold
			b.TextSize = 14
			b.TextColor3 = primary and Color3.fromRGB(10, 10, 14) or Color3.fromRGB(230, 230, 240)
			b.Text = text
			b.AutoButtonColor = true
			b.Parent = box
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
			return b
		end
		local okBtn, cancelBtn = button("ok", 16, true), button("cancel", 176, false)

		local function close()
			if gui.Parent then gui:Destroy() end
			if dialog == gui then dialog = nil end
		end
		local function submit()
			local text = tb.Text or ""
			if clean then text = clean(text) end
			if text == "" then return end
			close()
			pcall(onOk, text)
		end
		okBtn.MouseButton1Click:Connect(submit)
		cancelBtn.MouseButton1Click:Connect(close)
		dim.MouseButton1Click:Connect(close)
		tb.FocusLost:Connect(function(enter) if enter then submit() end end)
		task.defer(function() pcall(function() tb:CaptureFocus() end) end)
	end

	local function cleanName(text)
		text = tostring(text or ""):gsub("[^%w _%-]", ""):gsub("^%s+", ""):gsub("%s+$", "")
		return text:sub(1, 32)
	end

	aa.onUnload(function()
		if dialog then pcall(function() dialog:Destroy() end) end
	end)

	local pr = ad:Tab({
		Title = "presets",
		Icon = "layers",
	})

	pr:Section({ Title = "presets" })
	presetDrop = pr:Dropdown({
		Title = "preset",
		Values = K(),
		Value = ag,
		Callback = function(v)
			selected = type(v) == "table" and v[1] or v
		end,
	})
	pr:Button({
		Title = "load preset",
		Callback = function()
			local ok = ah and ah(selected)
			say(ok and "preset loaded" or "load failed", tostring(selected))
		end,
	})
	pr:Button({
		Title = "save to selected preset",
		Callback = function()
			local ok = ai and ai(selected)
			say(ok and "preset saved" or "save failed", tostring(selected))
		end,
	})
	pr:Button({
		Title = "save as new preset...",
		Callback = function()
			ask("new preset name", "my full setup", function(name)
				local ok = ai and ai(name)
				if ok then selected = name end
				refreshList(ok and name or nil)
				say(ok and "preset saved" or "save failed", name)
			end, cleanName)
		end,
	})
	pr:Button({
		Title = "delete selected preset",
		Callback = function()
			local ok = aj and aj(selected)
			refreshList()
			say(ok and "preset deleted" or "delete failed", tostring(selected))
		end,
	})
	pr:Button({ Title = "refresh list", Callback = function() refreshList() end })
	pr:Toggle({
		Title = "load last preset on start",
		Value = true,
		Flag = "cfgAutoload",
		Callback = function(v) aC.cfgAutoload = v end,
	})
	pr:Toggle({
		Title = "autosave preset",
		Value = false,
		Flag = "cfgAutosave",
		Callback = function(v) aC.cfgAutosave = v end,
	})

	pr:Section({ Title = "share" })
	pr:Button({
		Title = "export share code (copy)",
		Callback = function()
			local ok, code = pcall(function()
				local fn = getgenv and getgenv().NightCFG_Export
				if type(fn) == "function" then
					return fn(selected or "NightCC")
				end
				if aa.cfgCode and aa.cfgCode.export then
					return aa.cfgCode.export()
				end
				return nil
			end)
			if ok and type(code) == "string" and #code > 0 then
				pcall(function() (setclipboard or toclipboard)(code) end)
				say("share code copied", #code .. " chars, send it to a friend")
			else
				say("export failed", "could not build a share code")
			end
		end,
	})
	pr:Button({
		Title = "import share code...",
		Callback = function()
			ask("paste share code", "NCC1:... or NL1:...", function(code)
				local ok, applied, name = pcall(function()
					local fn = getgenv and getgenv().NightCFG_Import
					if type(fn) == "function" then
						local a, n = fn(code)
						return a, n
					end
					if aa.cfgCode and aa.cfgCode.import then
						return aa.cfgCode.import(code), nil
					end
					return nil
				end)
				if ok and applied then
					local msg = type(applied) == "number" and ("applied " .. applied .. " values") or "preset applied"
					if type(name) == "string" then msg = msg .. " -> " .. name end
					refreshList()
					say("preset imported", msg)
				else
					say("import failed", "not a valid share code")
				end
			end, function(text) return (tostring(text or ""):gsub("%s", "")) end)
		end,
	})
end

local bR = ad:Tab({
Title = "extra",
Icon = "settings",
})
bR:Section({
Title = "name spoofer",
})
do
local bS, bU, bV, bW = false, "", setmetatable({}, {
__mode = "k",
}), {}
for bX, bY in ipairs({
_.Name,
_.DisplayName,
}) do
if type(bY) == "string" and (#bY > 0 and not table.find(bW, bY)) then
bW[#bW + 1] = bY
end
end
table.sort(bW, function(bX, bY)
return #bX > #bY
end)
local function R(bX, bY, bZ)
local b_, b0 = {}, 1
while true do
local b1, b2 = bX:find(bY, b0, true)
if not b1 then
break
end
b_[#b_ + 1] = bX:sub(b0, b1 - 1)
b_[#b_ + 1] = bZ
b0 = b2 + 1
end
b_[#b_ + 1] = bX:sub(b0)
return table.concat(b_)
end
local function l(bX)
local bY = bX.Text
if bY == "" then
return
end
local bZ = bV[bX]
if bZ and bZ.out == bY then
return
end
local b_ = bY
for b0, b1 in ipairs(bW) do
if b_:find(b1, 1, true) then
b_ = R(b_, b1, bU)
end
end
if b_ ~= bY then
bV[bX] = {
orig = bY,
out = b_,
}
bX.Text = b_
end
end
local function r()
for bX, bY in pairs(bV) do
pcall(function()
if bX.Text == bY.out then
bX.Text = bY.orig
end
end)
end
table.clear(bV)
end
aa.onUnload(r)
local function y(bX)
return bX:IsA("TextLabel") or bX:IsA("TextButton") or bX:IsA("TextBox")
end
local function P()
return bS and (bU ~= "" and not aa.unloaded)
end
local bX, bY, bZ, b_ = false, setmetatable({}, {
__mode = "k",
}), {}, 1
local function c(b0)
if bY[b0] then
return
end
bY[b0] = true
aa.connect(b0:GetPropertyChangedSignal("Text"), function()
if P() then
pcall(l, b0)
end
end)
end
local function C(b0)
if not bX or not y(b0) then
return
end
c(b0)
if P() then
pcall(l, b0)
end
end
local b0 = _:FindFirstChildOfClass("PlayerGui")
if b0 then
aa.connect(b0.DescendantAdded, C)
end
pcall(function()
aa.connect((game:GetService("CoreGui")).DescendantAdded, C)
end)
local function b()
bX = true
bZ, b_ = {}, 1
local function d(b1)
if not b1 then
return
end
for b2, b3 in ipairs(b1:GetDescendants()) do
if y(b3) then
bZ[#bZ + 1] = b3
end
end
end
d(b0)
if setthreadidentity then
pcall(setthreadidentity, 8)
end
pcall(function()
d(game:GetService("CoreGui"))
end)
end
aa.connect(O.Heartbeat, function()
if b_ > #bZ then
return
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
local b1 = math.min(b_ + 199, #bZ)
for b2 = b_, b1, 1 do
local b3 = bZ[b2]
if b3.Parent then
pcall(c, b3)
if P() then
pcall(l, b3)
end
end
end
b_ = b1 + 1
if b_ > #bZ then
bZ, b_ = {}, 1
end
end)
bR:Toggle({
Title = "name spoofer",
Value = false,
Flag = "nameSpoof",
Callback = function(b1)
bS = b1
if b1 then
b()
else
r()
end
end,
})
bR:Input({
Title = "fake name",
Value = "",
Placeholder = "any text",
Flag = "nameSpoofText",
Callback = function(b1)
b1 = tostring(b1 or "")
if b1 == bU then
return
end
r()
bU = b1
if bS and bU ~= "" then
b()
end
end,
})
end
bR:Section({
Title = "appearance",
})
local bS = {}
for bU in pairs(ac:GetThemes()) do
table.insert(bS, bU)
end
table.sort(bS)
do
local bU, bV =
bR:Dropdown({
Title = "theme",
Values = {
ac:GetCurrentTheme(),
},
Value = ac:GetCurrentTheme(),
SearchBarEnabled = true,
Flag = "theme",
Callback = function(bU)
if type(bU) == "table" then
bU = bU[1]
end
if bU == ac:GetCurrentTheme() then
return
end
pcall(function()
ac:SetTheme(bU)
end)
end,
}), false
local bW = bU and bU.ElementFrame
if bW then
aa.connect(bW.MouseEnter, function()
if bV then
return
end
bV = true
if setthreadidentity then
pcall(setthreadidentity, 8)
end
local bX = ac:GetCurrentTheme()
pcall(function()
bU:Refresh(bS)
end)
pcall(function()
bU:Select(bX)
end)
end)
end
end
bR:Section({
Title = "interface",
})
do
local Players_ = game:GetService("Players")
local snap = setmetatable({}, { __mode = "k" })
local state = { style = "Classic", font = "Default" }
local descConn, token = nil, 0
local FAMILIES = {
["Builder Sans"] = "rbxasset://fonts/families/BuilderSans.json",
["Montserrat"] = "rbxasset://fonts/families/Montserrat.json",
["Nunito"] = "rbxasset://fonts/families/Nunito.json",
["Ubuntu"] = "rbxasset://fonts/families/Ubuntu.json",
}
local WEIGHT = {
Gotham = Enum.FontWeight.Regular,
GothamMedium = Enum.FontWeight.Medium,
GothamSemibold = Enum.FontWeight.SemiBold,
GothamBold = Enum.FontWeight.Bold,
GothamBlack = Enum.FontWeight.Heavy,
SourceSans = Enum.FontWeight.Regular,
SourceSansLight = Enum.FontWeight.Light,
SourceSansSemibold = Enum.FontWeight.SemiBold,
SourceSansBold = Enum.FontWeight.Bold,
}
local function findRoot()
local parents = {}
pcall(function() if gethui then parents[#parents + 1] = gethui() end end)
pcall(function() parents[#parents + 1] = game:GetService("CoreGui") end)
pcall(function() parents[#parents + 1] = Players_.LocalPlayer:FindFirstChildOfClass("PlayerGui") end)
for _, p in ipairs(parents) do
local g = p and p:FindFirstChild("NightCCUICS2")
if g then return g end
end
return nil
end
local function isSkipped(inst)
local n = string.lower(inst.Name)
if n:find("colorpicker") or n:find("swatch") or n:find("preview") or n:find("svcursor") or n == "inline" then
return true
end
if inst:GetAttribute("IsShadowLayer") then return true end
return inst:FindFirstAncestor("ColorPickerFrame") ~= nil
end
local function celestialColor(c)
local h, s, v = c:ToHSV()
local l = 0.299 * c.R + 0.587 * c.G + 0.114 * c.B
if l > 0.32 or (s > 0.35 and v > 0.3) then return nil end
local k = l * 0.92
return Color3.new(math.min(0.031 + k, 1), math.min(0.035 + k, 1), math.min(0.062 + k * 1.06, 1))
end
local function remember(inst)
local s = snap[inst]
if s then return s end
s = {}
if inst:IsA("GuiObject") then s.bg = inst.BackgroundColor3 end
if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then s.font = inst.Font end
if inst:IsA("UICorner") then s.radius = inst.CornerRadius end
snap[inst] = s
return s
end
local function applyOne(inst)
if not inst or not inst.Parent then return end
local ok = pcall(function()
if isSkipped(inst) then return end
if state.style == "Celestial" then
if inst:IsA("GuiObject") and inst.BackgroundTransparency < 0.99 then
local s = remember(inst)
local nc = s.bg and celestialColor(s.bg)
if nc then
inst.BackgroundColor3 = nc
s.setBg = nc
end
elseif inst:IsA("UICorner") then
local s = remember(inst)
local r = s.radius
if r and r.Scale == 0 and r.Offset >= 4 and r.Offset <= 11 then
local nr = UDim.new(0, math.min(math.floor(r.Offset * 1.4 + 0.5), 14))
inst.CornerRadius = nr
s.setRadius = nr
end
end
end
if state.font ~= "Default" and FAMILIES[state.font] then
if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
local s = remember(inst)
local w = s.font and WEIGHT[s.font.Name]
if w then
local ff = Font.new(FAMILIES[state.font], w, Enum.FontStyle.Normal)
inst.FontFace = ff
s.setFont = ff
end
end
end
end)
return ok
end
local function revertAll()
for inst, s in pairs(snap) do
pcall(function()
if s.setBg and inst.BackgroundColor3 == s.setBg then inst.BackgroundColor3 = s.bg end
if s.setRadius and inst.CornerRadius == s.setRadius then inst.CornerRadius = s.radius end
if s.setFont and inst.FontFace == s.setFont then inst.Font = s.font end
end)
snap[inst] = nil
end
end
local function refresh()
token = token + 1
local my = token
revertAll()
local active = state.style ~= "Classic" or state.font ~= "Default"
if descConn then
descConn:Disconnect()
descConn = nil
end
if not active then return end
local root = findRoot()
if not root then
ac:Notify({ Title = "interface", Content = "window root not found", Duration = 3 })
return
end
descConn = root.DescendantAdded:Connect(function(d)
task.defer(applyOne, d)
end)
task.spawn(function()
local n = 0
for _, d in ipairs(root:GetDescendants()) do
if token ~= my then return end
applyOne(d)
n = n + 1
if n % 500 == 0 then task.wait() end
end
end)
end
aa.onUnload(function()
token = token + 1
if descConn then pcall(function() descConn:Disconnect() end) end
descConn = nil
state.style, state.font = "Classic", "Default"
pcall(revertAll)
end)
local function pick(v)
if type(v) == "table" then v = v[1] end
return tostring(v)
end
bR:Dropdown({
Title = "gui style",
Values = { "Classic", "Celestial" },
Value = "Classic",
Flag = "guiStyle",
Callback = function(v)
v = pick(v)
if v ~= "Classic" and v ~= "Celestial" then return end
if v == state.style then return end
state.style = v
refresh()
end,
})
bR:Dropdown({
Title = "gui font",
Values = { "Default", "Builder Sans", "Montserrat", "Nunito", "Ubuntu" },
Value = "Default",
Flag = "guiFont",
Callback = function(v)
v = pick(v)
if v ~= "Default" and not FAMILIES[v] then return end
if v == state.font then return end
state.font = v
refresh()
end,
})
end
bR:Section({
Title = "kill effects",
})
do
local TweenService_ = game:GetService("TweenService")
local Debris_ = game:GetService("Debris")
local rng = Random.new()
local L = { enabled = true, flash = true, style = "Lightning", color = Color3.fromRGB(200, 220, 255) }
local alive = true
local function segment(a, b, thickness, color, transparency, parent)
local len = (b - a).Magnitude
if len < 0.05 then return nil end
local p = Instance.new("Part")
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = Enum.Material.Neon
p.Color = color
p.Transparency = transparency
p.Size = Vector3.new(thickness, thickness, len)
p.CFrame = CFrame.lookAt((a + b) / 2, b)
p.Parent = parent
return p
end
local function jagged(s, e, n, amp)
local dir = e - s
local unit = dir.Unit
local ref = math.abs(unit.Y) > 0.95 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)
local p1 = dir:Cross(ref).Unit
local p2 = dir:Cross(p1).Unit
local pts = { s }
for i = 1, n - 1 do
local f = i / n
local off = (p1 * rng:NextNumber(-1, 1) + p2 * rng:NextNumber(-1, 1)) * amp * (1 - f * 0.85)
pts[#pts + 1] = s + dir * f + off
end
pts[#pts + 1] = e
return pts
end
local function groundPoint(p, char)
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = char and { char } or {}
local hit = workspace:Raycast(p + Vector3.new(0, 2, 0), Vector3.new(0, -14, 0), params)
return hit and hit.Position or (p - Vector3.new(0, 3, 0))
end
local function screenFlash()
pcall(function()
local host = (gethui and gethui()) or game:GetService("CoreGui")
local g = Instance.new("ScreenGui")
g.Name = "NightCCLightningFlash"
g.IgnoreGuiInset = true
g.ResetOnSpawn = false
g.DisplayOrder = 300
g.Parent = host
local f = Instance.new("Frame")
f.Size = UDim2.fromScale(1, 1)
f.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
f.BackgroundTransparency = 0.88
f.BorderSizePixel = 0
f.Parent = g
TweenService_:Create(f, TweenInfo.new(0.28, Enum.EasingStyle.Quad), { BackgroundTransparency = 1 }):Play()
Debris_:AddItem(g, 0.4)
end)
end
local function strike(ground, char)
local cam = workspace.CurrentCamera
if not cam then return end
local folder = Instance.new("Folder")
folder.Name = "NightCCLightning"
folder.Parent = cam
Debris_:AddItem(folder, 1.5)
local parts = {}
local function add(p, base)
if p then parts[#parts + 1] = { part = p, base = base } end
end
local sky = ground + Vector3.new(rng:NextNumber(-8, 8), 130, rng:NextNumber(-8, 8))
local pts = jagged(sky, ground, 14, 9)
for i = 1, #pts - 1 do
add(segment(pts[i], pts[i + 1], 1.5, L.color, 0.65, folder), 0.65)
add(segment(pts[i], pts[i + 1], 0.35, Color3.new(1, 1, 1), 0, folder), 0)
end
for _ = 1, 2 do
local origin = pts[rng:NextInteger(4, 10)]
local tip = origin + Vector3.new(rng:NextNumber(-18, 18), -rng:NextNumber(14, 28), rng:NextNumber(-18, 18))
local fp = jagged(origin, tip, 5, 3)
for i = 1, #fp - 1 do
add(segment(fp[i], fp[i + 1], 0.2, L.color, 0.15, folder), 0.15)
end
end
local anchor = Instance.new("Part")
anchor.Anchored, anchor.CanCollide, anchor.CanQuery, anchor.CanTouch, anchor.CastShadow = true, false, false, false, false
anchor.Transparency = 1
anchor.Size = Vector3.new(1, 1, 1)
anchor.CFrame = CFrame.new(ground)
anchor.Parent = folder
local light = Instance.new("PointLight")
light.Color = L.color
light.Brightness = 12
light.Range = 45
light.Parent = anchor
local sparks = Instance.new("ParticleEmitter")
sparks.Rate = 0
sparks.Lifetime = NumberRange.new(0.3, 0.7)
sparks.Speed = NumberRange.new(20, 45)
sparks.SpreadAngle = Vector2.new(180, 180)
sparks.Color = ColorSequence.new(L.color)
sparks.LightEmission = 1
sparks.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) })
sparks.Parent = anchor
sparks:Emit(28)
if char and char.Parent then
pcall(function()
local hl = Instance.new("Highlight")
hl.Adornee = char
hl.FillColor = Color3.new(1, 1, 1)
hl.OutlineColor = L.color
hl.FillTransparency = 0
hl.OutlineTransparency = 0
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = folder
TweenService_:Create(hl, TweenInfo.new(0.55, Enum.EasingStyle.Quad), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
end)
end
if L.flash then screenFlash() end
task.spawn(function()
local function setAlpha(hidden)
for _, e in ipairs(parts) do
if e.part.Parent then e.part.Transparency = hidden and 1 or e.base end
end
light.Enabled = not hidden
end
task.wait(0.07); setAlpha(true)
task.wait(0.04); setAlpha(false)
task.wait(0.09)
for _, e in ipairs(parts) do
if e.part.Parent then
TweenService_:Create(e.part, TweenInfo.new(0.35, Enum.EasingStyle.Quad), { Transparency = 1 }):Play()
end
end
TweenService_:Create(light, TweenInfo.new(0.35), { Brightness = 0 }):Play()
end)
end
local function newFolder(life)
local cam = workspace.CurrentCamera
if not cam then return nil end
local f = Instance.new("Folder")
f.Name = "NightCCLightning"
f.Parent = cam
Debris_:AddItem(f, life or 1.5)
return f
end
local function fxPart(shape, size, cframe, material, color, transparency, parent)
local p = Instance.new("Part")
if shape then p.Shape = shape end
p.Anchored, p.CanCollide, p.CanQuery, p.CanTouch, p.CastShadow = true, false, false, false, false
p.Material = material
p.Color = color
p.Transparency = transparency
p.Size = size
p.CFrame = cframe
p.Parent = parent
return p
end
local function victimGlow(char, folder, fill)
if not (char and char.Parent) then return end
pcall(function()
local hl = Instance.new("Highlight")
hl.Adornee = char
hl.FillColor = fill or Color3.new(1, 1, 1)
hl.OutlineColor = L.color
hl.FillTransparency = 0
hl.OutlineTransparency = 0
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = folder
TweenService_:Create(hl, TweenInfo.new(0.55, Enum.EasingStyle.Quad), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
end)
end
local function burst(pos, folder, count, speed, upward)
local a = Instance.new("Part")
a.Anchored, a.CanCollide, a.CanQuery, a.CanTouch, a.CastShadow = true, false, false, false, false
a.Transparency = 1
a.Size = Vector3.new(1, 1, 1)
a.CFrame = CFrame.new(pos)
a.Parent = folder
local e = Instance.new("ParticleEmitter")
e.Rate = 0
e.Lifetime = NumberRange.new(0.5, 1.2)
e.Speed = NumberRange.new(speed * 0.5, speed)
e.SpreadAngle = Vector2.new(180, 180)
e.Acceleration = Vector3.new(0, upward or 0, 0)
e.Color = ColorSequence.new(L.color)
e.LightEmission = 1
e.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0) })
e.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) })
e.Parent = a
e:Emit(count)
end
local FX = {}
function FX.Pillar(ground, char)
local folder = newFolder(1.5)
if not folder then return end
local H = 150
local up = CFrame.new(ground + Vector3.new(0, H / 2, 0)) * CFrame.Angles(0, 0, math.pi / 2)
local beam = fxPart(Enum.PartType.Cylinder, Vector3.new(H, 0.4, 0.4), up, Enum.Material.Neon, L.color, 0.2, folder)
local core = fxPart(Enum.PartType.Cylinder, Vector3.new(H, 0.2, 0.2), up, Enum.Material.Neon, Color3.new(1, 1, 1), 0, folder)
TweenService_:Create(beam, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(H, 3.4, 3.4) }):Play()
TweenService_:Create(core, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(H, 1.2, 1.2) }):Play()
task.delay(0.22, function()
for _, p in ipairs({ beam, core }) do
if p.Parent then
TweenService_:Create(p, TweenInfo.new(0.5, Enum.EasingStyle.Quad), { Size = Vector3.new(H, 0.1, 0.1), Transparency = 1 }):Play()
end
end
end)
burst(ground, folder, 24, 25, 0)
victimGlow(char, folder)
end
function FX.Shockwave(ground, char)
local folder = newFolder(1.2)
if not folder then return end
local bubble = fxPart(Enum.PartType.Ball, Vector3.new(2, 2, 2), CFrame.new(ground + Vector3.new(0, 2, 0)), Enum.Material.ForceField, L.color, 0.35, folder)
TweenService_:Create(bubble, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(30, 30, 30), Transparency = 1 }):Play()
for i = 0, 1 do
task.delay(i * 0.12, function()
if not folder.Parent then return end
local disc = fxPart(Enum.PartType.Cylinder, Vector3.new(0.25, 2, 2),
CFrame.new(ground + Vector3.new(0, 0.3, 0)) * CFrame.Angles(0, 0, math.pi / 2),
Enum.Material.Neon, L.color, 0.45, folder)
TweenService_:Create(disc, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = Vector3.new(0.25, 44, 44), Transparency = 1 }):Play()
end)
end
burst(ground, folder, 20, 30, 0)
victimGlow(char, folder)
end
function FX.Ashes(ground, char)
local folder = newFolder(2)
if not folder then return end
victimGlow(char, folder, Color3.fromRGB(40, 40, 40))
local a = Instance.new("Part")
a.Anchored, a.CanCollide, a.CanQuery, a.CanTouch, a.CastShadow = true, false, false, false, false
a.Transparency = 1
a.Size = Vector3.new(2, 4, 2)
a.CFrame = CFrame.new(ground + Vector3.new(0, 3, 0))
a.Parent = folder
local ash = Instance.new("ParticleEmitter")
ash.Rate = 0
ash.Lifetime = NumberRange.new(1.0, 1.8)
ash.Speed = NumberRange.new(2, 8)
ash.SpreadAngle = Vector2.new(60, 60)
ash.Acceleration = Vector3.new(0, 7, 0)
ash.Color = ColorSequence.new(Color3.fromRGB(70, 70, 70), Color3.fromRGB(200, 200, 200))
ash.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.45), NumberSequenceKeypoint.new(1, 0) })
ash.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.1), NumberSequenceKeypoint.new(1, 1) })
ash.Parent = a
ash:Emit(70)
burst(ground + Vector3.new(0, 3, 0), folder, 22, 14, 10)
end
FX.Lightning = strike
local old = a_.onConfirm
a_.onConfirm = function(evt, plr, dmg, char, pos)
if alive and L.enabled and evt == "kill" then
pcall(function()
local root = char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head"))
local p = root and root.Position or pos
if typeof(p) == "Vector3" then
(FX[L.style] or FX.Lightning)(groundPoint(p, char), char)
end
end)
end
if old then return old(evt, plr, dmg, char, pos) end
end
aa.onUnload(function()
alive = false
pcall(function()
local cam = workspace.CurrentCamera
local f = cam and cam:FindFirstChild("NightCCLightning")
if f then f:Destroy() end
end)
end)
bR:Dropdown({
Title = "kill effect style",
Values = { "Lightning", "Pillar", "Shockwave", "Ashes" },
Value = "Lightning",
Flag = "killEffectStyle",
Callback = function(v)
if type(v) == "table" then v = v[1] end
if FX[tostring(v)] then L.style = tostring(v) end
end,
})
bR:Toggle({ Title = "kill effect", Description = "visual effect on the player you kill (only you see it)", Value = true, Flag = "killLightning", Callback = function(v) L.enabled = v end })
bR:Toggle({ Title = "lightning screen flash (Lightning style)", Value = true, Flag = "killLightningFlash", Callback = function(v) L.flash = v end })
bR:Colorpicker({ Title = "kill effect color", Default = L.color, Flag = "killLightningColor", Callback = function(c) L.color = c end })
end
pcall(function()
local _orig = a_.onConfirm
a_.onConfirm = function(evtType, plr, dmg, char, pos)
if evtType == "kill" then
_nightVis.onKill(plr and plr.DisplayName or "target", pos)
elseif evtType == "hit" then
local isHead = char and char:FindFirstChild("Head") and pos and
(char.Head.Position - pos).Magnitude < 1.5 or false
_nightVis.onHit(isHead, pos)
end
if _orig then pcall(_orig, evtType, plr, dmg, char, pos) end
end
end)
bR:Section({
Title = "window",
})
bR:Keybind({
Title = "draw / mask ui",
Value = "K",
Flag = "toggleKey",
Callback = function(bX)
pcall(function()
ad:SetToggleKey(Enum.KeyCode[bX])
end)
end,
})
bR:Section({
Title = "hud",
})
bR:Toggle({
Title = "keybind list",
Value = true,
Flag = "showKeybindList",
Callback = function(bX)
ab = bX
pcall(function() ac._window.KeybindList.setEnabled(bX) end)
end,
})
ab = true
pcall(function() ac._window.KeybindList.setEnabled(true) end)
do
bR:Toggle({
Title = "hit logs",
Value = true,
Flag = "hitLogs",
Callback = function(bX)
aC.hitLogs = bX
end,
})
end
do
bR:Section({ Title = "nightcc visuals" })
bR:Toggle({
Title = "hit effects",
Description = "blood/spark particles on hit",
Value = true,
Callback = function(v) pcall(function() _nightVis.setHitFx(v) end) end,
})
bR:Toggle({
Title = "kill effect",
Description = "screen banner + flash on kill",
Value = true,
Callback = function(v) pcall(function() _nightVis.setKillFx(v) end) end,
})
bR:Toggle({
Title = "tracers",
Description = "lines from bottom of screen to enemies",
Value = true,
Callback = function(v) pcall(function() _nightVis.setTracers(v) end) end,
})
bR:Toggle({
Title = "impact audio",
Description = "click sound on hit / louder on kill",
Value = true,
Callback = function(v) pcall(function() _nightVis.setHitSound(v) end) end,
})
end
if ae then
local bX = ad.ConfigManager
local function E()
pcall(function()
if aF and aF.Default then
aD = aF.Default
end
if aG and aG.Default then
aE = aG.Default
end
if bB and bB.Default then
bp = bB.Default
end
if bC and bC.Default then
bq = bC.Default
end
end)
pcall(f)
end
local function I(bY)
local bZ = bY.Value
if type(bZ) == "table" then
return tostring(bZ.Default)
elseif bZ ~= nil then
return tostring(bZ)
else
return tostring(bY.Default)
end
end
local function M()
local bY = af and af.Elements
if type(bY) ~= "table" then
return nil
end
local bZ = {}
for b_, b0 in next, bY do
bZ[#bZ + 1] = tostring(b_) .. ("=" .. I(b0))
end
table.sort(bZ)
return table.concat(bZ, ";")
end
local bY
local function x(bZ, b_)
local b0 = b_.__type
if b0 == "Toggle" or b0 == "Input" or b0 == "Keybind" then
return bZ.Value == b_.value
elseif b0 == "Slider" then
return type(bZ.Value) == "table" and bZ.Value.Default == tonumber(b_.value)
elseif b0 == "Colorpicker" then
return typeof(bZ.Default) == "Color3"
and (
(bZ.Default:ToHex()):lower() == (tostring(b_.value)):lower()
and (bZ.Transparency or 0) == (b_.transparency or 0)
)
elseif b0 == "Dropdown" then
local b1, b2 = bZ.Value, b_.value
if type(b1) == "table" or type(b2) == "table" then
return ar:JSONEncode(b1) == ar:JSONEncode(b2)
end
return b1 == b2
end
return false
end
local function K(bZ)
local b_ = bZ and bZ.Path
if not (b_ and (isfile and isfile(b_))) then
return false
end
local b0, b1 = pcall(function()
return ar:JSONDecode(readfile(b_))
end)
if not b0 or type(b1) ~= "table" then
return false
end
if not b1.__version then
b1 = {
__elements = b1,
__custom = {},
}
end
pcall(function()
if ad.PendingFlags then
for b2, b3 in next, ad.PendingFlags do
bZ:Register(b2, b3)
end
end
end)
bZ.CustomData = b1.__custom or {}
local b2, b3 = bX.Parser, {}
for b4, b5 in next, b1.__elements or {} do
local b6 = bZ.Elements[b4]
if b6 and (type(b5) == "table" and b2[b5.__type]) then
local b7, b8 = pcall(x, b6, b5)
if not (b7 and b8) then
b3[#b3 + 1] = { b6, b5 }
end
end
end
local b4 = 1
while b4 <= #b3 do
local b5, b6 = os.clock(), 0
while b4 <= #b3 and (b6 < 8 and os.clock() - b5 < 0.004) do
local b7 = b3[b4]
task.spawn(function()
pcall(b2[b7[2].__type].Load, b7[1], b7[2])
end)
b4, b6 = b4 + 1, b6 + 1
end
if b4 <= #b3 and coroutine.isyieldable() then
task.wait()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
end
end
return true
end
local function c(bZ)
if bZ and ae.Elements then
bZ.Elements = ae.Elements
end
end
ai = function(bZ)
bZ = ((tostring(bZ or "")):gsub("^%s+", "")):gsub("%s+$", "")
if bZ == "" then
return false
end
local b_ = bX:GetConfig(bZ) or bX:CreateConfig(bZ)
if not b_ then
return false
end
c(b_)
pcall(function()
b_:SetAsCurrent()
end)
af, ag = b_, bZ
if ak and ak.saveBinds then
ak.saveBinds(false)
end
local b0 = pcall(function()
b_:Save()
end)
bY = M()
return b0
end
ah = function(bZ)
if not bZ or bZ == "" then
return false
end
local b_ = bX:GetConfig(bZ) or bX:CreateConfig(bZ)
if not b_ then
return false
end
c(b_)
pcall(function()
b_:SetAsCurrent()
end)
af, ag = b_, bZ
local b0 = K(b_)
E()
pcall(function()
if ak and ak.loadBinds then
ak.loadBinds()
end
end)
bY = M()
return b0
end
aj = function(bZ)
if not bZ or bZ == "" then
return false
end
local b_ = bX:GetConfig(bZ) or bX:CreateConfig(bZ)
if not b_ or not b_.Delete then
return false
end
local b0 = pcall(function()
b_:Delete()
end)
if bZ == ag then
af, ag = ae, "NightCC"
end
return b0
end
aa.cfgCode = (function()
local bZ, b_, b0, b1, b2, b3, b4, b5 =
bX.Parser,
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmn",
"opqrstuvwxyz0123456789-_",
[[silentAim,fovRadius,showFov,fovColor,aimPart,wallCheck,teamCheck,noSpread,noRecoil,rage,rageAutoFire,rageAutowall,rageHitbox,rageTargetMode,preferBodyLethal,rageMulti,rageScanHz,minDmg,minDmgOverride,minDmgOverrideValue,aa,aaBase,aaYaw,aaSpin,aaJitter,aaJitterDelay,aaPitch,aaOffShot,autoReload,reloadAt,remoteReload,instaReload,reloadSpeed,esp,espEnemyColor,espColorMode,espTColor,espCTColor,espFade,espVisCheck,espVisColor,espTeam,espTeamColor,espDormant,espDormantTime,espMaxDist,espChams,espChamsMode,espChamsOccluded,espFill,espBox,espBoxStyle,espBoxFill,espHealth,espHealthText,espArmor,espArmorGrad,espArmorColorLow,espArmorColorMax,espNames,espWeapon,espFlags,espDistance,espTextSize,espTextGrad,espTextGradColor,espTextGradColor2,espSkeleton,espHeadDot,espSnap,espSnapFrom,espArrows,espArrowRadius,espArrowSize,soundEsp,soundEspColor,soundEspBox,soundEspLife,thirdPerson,tpDistance,tpHeight,tpShoulder,tpCollide,tpHeadRot,tpHeadFollow,grenadeRadius_,fovChanger,fovSlider,noScopeZoom,noScopeBorders,scopeStyle,scopeColor,scopeLen,scopeGap,scopeThick,noShake,antiFlash,vmChanger,vmChams,vmChamsMaterial,vmChamsColor,vmChamsTransp,charChanger,charChangerTarget,charChangerModel,charChangerFile,charChangerUser,hitMarker,hitMarkerColor,hitMarkerKill,hitMarkerWhere,hitMarkerAnim,hitMarkerTime,hitMarkerShape,hitMarkerSize,hitMarkerThick,hitMarkerGap,hitMarkerOutline,hitMarkerKillScale,hitMarkerDamage,hitMarkerRise,tracerEnabled,tracerColor,tracerWidth,tracerLife,tracerStyle,tracerFrom,tracerRainbow,tracerOnlyHits,impactEnabled,impactSize,impactGlow,impactColor,hitSound,hitSoundId,hitVol,killSound,killSoundId,killVol,bhop,strafe,strafeMode,strafeFastTurn,strafeAlign,wrl_ambient,wrl_ambientColor,wrl_outdoorColor,wrl_shadows,wrl_forcetime,wrl_time,wrl_saturation,wrl_satvalue,wrl_skybox,wrl_skyboxtype,wrl_skyboxid,wrl_fullbright,wrl_bright,wrl_brightness,wrl_exposure,wrl_night,wrl_nightStrength,wrl_fog,wrl_fogColor,wrl_fogStart,wrl_fogEnd,wrl_noPost,wrl_grade,wrl_contrast,wrl_gradeBright,wrl_gradeTint,wrl_bloom,wrl_bloomIntensity,wrl_bloomSize,wrl_bloomThreshold,wrl_asus,wrl_asusValue,wrl_tint,wrl_tintColor,wrl_tintStrength,wrl_weather,wrl_weatherAmount,wrl_drops,wrl_dropColor,wrl_dropDist,wrl_bomb,skinsEnabled,skinFloat,skinStatTrak,skinStatTrakCount,gloveType,gloveSkin,nameSpoof,nameSpoofText,theme,toggleKey,showKeybindList,hitLogs,knifeBot,knifeHeavy,knifeBotRange,autoBuy,buyPrimary,buySecondary,buyZeus,buyNades,buyDelay,espChamsStyle,espChamsMaterial,espChamsColor,espChamsTransp,espChamsGlow,espBoxOutline,espBoxOutlineColor,espBoxThickness,espBoxGrad,espBoxGradColor,espBoxGradColor2,espFillGrad,espFillGradColor,espFillGradColor2,espHealthSide,espHealthWidth,espHealthGrad,espHealthColorLow,espHealthColorMax,espHealthOutline]],
{
Hold = "h",
Toggle = "t",
Always = "a",
},
{
h = "Hold",
t = "Toggle",
a = "Always",
},
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local function v(b6)
local b7 = {}
for b8 = 1, #b6, 3 do
local b9, ca, cb = b6:byte(b8, b8 + 2)
local cc = (b9 * 65536 + (ca or 0) * 256) + (cb or 0)
local cd = {
math.floor(cc / 262144) % 64,
math.floor(cc / 4096) % 64,
math.floor(cc / 64) % 64,
cc % 64,
}
b7[#b7 + 1] = b5:sub(cd[1] + 1, cd[1] + 1)
.. (
b5:sub(cd[2] + 1, cd[2] + 1)
.. (
(ca and b5:sub(cd[3] + 1, cd[3] + 1) or "=")
.. (cb and b5:sub(cd[4] + 1, cd[4] + 1) or "=")
)
)
end
return table.concat(b7)
end
local function K(b6)
b6 = b6:gsub("[^%w%+/]", "")
local b7, b8, b9 = {}, 0, 0
for ca = 1, #b6, 1 do
local cb = b5:find(b6:sub(ca, ca), 1, true) - 1
b8, b9 = b8 * 64 + cb, b9 + 6
if b9 >= 8 then
b9 = b9 - 8
local cc = math.floor(b8 / 2 ^ b9)
b7[#b7 + 1] = string.char(cc)
b8 = b8 - cc * 2 ^ b9
end
end
return table.concat(b7)
end
local function c(b6)
return (tostring(b6)):gsub("[%%,;|~!=%s]", function(b7)
return string.format("%%%02X", b7:byte())
end)
end
local function C(b6)
return b6:gsub("%%(%x%x)", function(b7)
return string.char(tonumber(b7, 16))
end)
end
local function Q(b6)
b6 = tonumber(b6) or 0
if b6 == math.floor(b6) and math.abs(b6) < 1000000000 then
return tostring(math.floor(b6))
end
local b7 = ((string.format("%.4f", b6)):gsub("0+$", "")):gsub("^(%-?)0%.", "%1.")
return b7
end
local function b(b6)
local b7, b8 = b6.__type, b6.value
if b7 == "Toggle" then
return b8 and "1" or "0"
end
if b7 == "Slider" then
return Q(b8)
end
if b7 == "Colorpicker" then
local b9 = tonumber(b6.transparency) or 0
return (tostring(b8)):lower() .. (b9 ~= 0 and "~" .. Q(b9) or "")
end
if b7 == "Dropdown" and type(b8) == "table" then
local b9 = {}
for ca, cb in ipairs(b8) do
b9[ca] = c(cb)
end
return "|" .. table.concat(b9, "|")
end
return c(b8 == nil and "" or b8)
end
local function a(b6, b7)
if b6 == "Toggle" then
return {
__type = b6,
value = b7 == "1",
}
end
if b6 == "Slider" then
return {
__type = b6,
value = tonumber(b7) or 0,
}
end
if b6 == "Colorpicker" then
local b8, b9 = b7:match("^([^~]*)~?(.*)$")
return {
__type = b6,
value = b8,
transparency = tonumber(b9),
}
end
if b6 == "Dropdown" and b7:sub(1, 1) == "|" then
local b8 = {}
for b9 in (b7:sub(2)):gmatch("[^|]+") do
b8[#b8 + 1] = C(b9)
end
return {
__type = b6,
value = b8,
}
end
return {
__type = b6,
value = C(b7),
}
end
local function T(b6)
local b7 = bZ[b6.__type]
if not b7 then
return nil
end
local b8, b9 = pcall(b7.Save, b6)
return b8 and (type(b9) == "table" and b(b9)) or nil
end
local b6, b7 = {}, {}
do
local b8 = 0
for b9 in b2:gmatch("[^,]+") do
local ca
if b8 < #b0 then
ca = b0:sub(b8 + 1, b8 + 1)
else
local cb = b8 - #b0
local cc = math.floor(cb / 64)
if cc < #b1 then
ca = b1:sub(cc + 1, cc + 1) .. b_:sub(cb % 64 + 1, cb % 64 + 1)
end
end
if ca then
b6[b9], b7[ca] = ca, b9
end
b8 = b8 + 1
end
end
local function Z()
local b8 = {}
for b9 in next, ae.Elements do
b8[b9] = b6[b9] or "!" .. (c(b9) .. "=")
end
return b8, b7
end
local function o(b8, b9)
if b8:sub(1, 1) == "!" then
local ca = b8:find("=", 2, true)
if not ca then
return nil
end
return C(b8:sub(2, ca - 1)), b8:sub(ca + 1)
end
local ca = b0:find(b8:sub(1, 1), 1, true) and 1 or 2
return b9[b8:sub(1, ca)], b8:sub(ca + 1)
end
local b8 = {}
pcall(function()
if ad.PendingFlags then
for b9, ca in next, ad.PendingFlags do
ae:Register(b9, ca)
end
end
end)
for b9, ca in next, ae.Elements do
b8[b9] = T(ca)
end
local b9 = {}
function b9.export()
local ca, cb = Z(), {}
for cc, cd in next, ae.Elements do
local ce = b8[cc] and T(cd)
if ce and ce ~= b8[cc] then
cb[#cb + 1] = ca[cc] .. ce
end
end
table.sort(cb)
local cc = {}
pcall(function()
if ak and ak.saveBinds then
ak.saveBinds(false)
end
local cd = ar:JSONDecode((af or ae):Get("nightccBinds") or "{}")
for ce, cf in next, cd do
if type(cf) == "table" and cf.key then
local cg = ce:match("^auto:(.+)$")
local ch = cg and ca[cg]
if not ch or ch:sub(1, 1) == "!" then
ch = "!" .. (c(ce) .. "=")
end
cc[#cc + 1] = ch .. ((b3[cf.mode] or "h") .. c(cf.key))
end
end
end)
table.sort(cc)
return v("z1" .. (table.concat(cb, ",") .. (#cc > 0 and ";" .. table.concat(cc, ",") or "")))
end
function b9.import(ca)
ca = (tostring(ca or "")):gsub("%s", "")
if ca:sub(1, 2) ~= "z1" then
ca = K(ca)
end
if ca:sub(1, 2) ~= "z1" then
return nil
end
local cb, cc = (ca:sub(3)):match("^([^;]*);?(.*)$")
local cd, ce = Z()
local cf = {}
for cg in cb:gmatch("[^,]+") do
local ch, ci = o(cg, ce)
if ch then
cf[ch] = ci
end
end
local cg = {}
for ch, ci in next, ae.Elements do
local cj = cf[ch] or b8[ch]
if cj and (bZ[ci.__type] and T(ci) ~= cj) then
cg[#cg + 1] = {
ci,
a(ci.__type, cj),
}
end
end
local ch = {}
for ci in cc:gmatch("[^,]+") do
local cj, ck = o(ci, ce)
if cj and ci:sub(1, 1) ~= "!" then
cj = "auto:" .. cj
end
if cj and #ck >= 2 then
ch[cj] = {
key = C(ck:sub(2)),
mode = b4[ck:sub(1, 1)] or "Hold",
}
end
end
local ci = 1
while ci <= #cg do
local cj, ck = os.clock(), 0
while ci <= #cg and (ck < 8 and os.clock() - cj < 0.004) do
local cl = cg[ci]
task.spawn(function()
pcall(bZ[cl[2].__type].Load, cl[1], cl[2])
end)
ci, ck = ci + 1, ck + 1
end
if ci <= #cg and coroutine.isyieldable() then
task.wait()
if setthreadidentity then
pcall(setthreadidentity, 8)
end
end
end
pcall(function()
local cj = af or ae
cj:Set("nightccBinds", ar:JSONEncode(ch))
if ak and ak.loadBinds then
ak.loadBinds()
end
end)
E()
return #cg
end
return b9
end)()
aa.building = false
pcall(function()
task.defer(function()
task.wait(0.5)
if not ak or not ak.register then return end
local bindable = ac and ac._bindable
if type(bindable) ~= "table" then return end
local seen = {}
for flag, info in pairs(bindable) do
if type(info) == "table" and info.title and not seen[info.title] then
seen[info.title] = true
pcall(function()
ak.register(info.title, info.obj or {}, {
kind = "toggle",
title = info.title,
auto = true,
isActive = info.get or function()
return ac._flags[flag] == true
end,
setState = function(v)
if info.set then info.set(v) end
end,
})
end)
end
end
pcall(function()
if ak.loadBinds then ak.loadBinds() end
end)
end)
end)
K(ae)
E()
pcall(function()
if ak and ak.loadBinds then
ak.loadBinds()
end
end)
end
task.spawn(function()
task.wait(1)
if aa.unloaded then
return
end
if setthreadidentity then
pcall(setthreadidentity, 8)
end
end)
pcall(function()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local startT = os.clock()
local MATS = {
ForceField = Enum.Material.ForceField, Neon = Enum.Material.Neon, Glass = Enum.Material.Glass, Ice = Enum.Material.Ice,
Metal = Enum.Material.Metal, ["Smooth Plastic"] = Enum.Material.SmoothPlastic, Plastic = Enum.Material.Plastic,
}
local saved = setmetatable({}, { __mode = "k" })
local curChar, hl = nil, nil
local function restoreOne(part, o)
if part.Parent then
pcall(function()
part.Material, part.Color, part.Transparency, part.Reflectance = o.m, o.c, o.t, o.r
if o.tex then part.TextureID = o.tex end
for _, s in ipairs(o.sa) do s.Parent = part end
end)
end
end
local function restoreParts()
for part, o in pairs(saved) do restoreOne(part, o) end
table.clear(saved)
end
local function dropGlow()
if hl then pcall(function() hl:Destroy() end) end
hl = nil
end
local function step()
local c = aC
if not c then return end
local char = LP.Character
if not c.selfChams or not char or not char.Parent or char:GetAttribute("Dead") == true then
if next(saved) ~= nil then restoreParts() end
if hl then dropGlow() end
curChar = nil
return
end
if curChar ~= char then
restoreParts()
dropGlow()
curChar = char
end
local t = os.clock() - startT
local col = c.selfChamsRainbow and Color3.fromHSV((t * 0.25) % 1, 0.8, 1) or (c.selfChamsColor or Color3.new(1, 1, 1))
local mat = MATS[tostring(c.selfChamsMaterial or "ForceField")]
if mat then
local tr = math.clamp(tonumber(c.selfChamsTransp) or 0, 0, 0.95)
local acc = c.selfChamsAcc ~= false
for _, d in ipairs(char:GetDescendants()) do
if d:IsA("BasePart") and not d:FindFirstAncestorOfClass("Tool") then
local o = saved[d]
if not acc and d:FindFirstAncestorOfClass("Accessory") then
if o then restoreOne(d, o); saved[d] = nil end
else
if not o and d.Name ~= "HumanoidRootPart" and d.Transparency < 0.95 then
o = { m = d.Material, c = d.Color, t = d.Transparency, r = d.Reflectance, sa = {} }
if d:IsA("MeshPart") and d.TextureID ~= "" then o.tex = d.TextureID end
for _, ch in ipairs(d:GetChildren()) do
if ch:IsA("SurfaceAppearance") then o.sa[#o.sa + 1] = ch end
end
saved[d] = o
end
if o then
for _, s in ipairs(o.sa) do
if s.Parent == d then s.Parent = nil end
end
if o.tex and d.TextureID ~= "" then d.TextureID = "" end
if d.Material ~= mat then d.Material = mat end
if d.Color ~= col then d.Color = col end
if d.Transparency ~= tr then d.Transparency = tr end
if d.Reflectance ~= 0 then d.Reflectance = 0 end
end
end
end
end
elseif next(saved) ~= nil then
restoreParts()
end
local outlineOn = c.selfChamsOutline ~= false
local fillOn = mat == nil
if fillOn or outlineOn then
local cam = workspace.CurrentCamera
if cam then
if not (hl and hl.Parent) then
dropGlow()
hl = Instance.new("Highlight")
hl.Name = "NightSelfChams"
hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent = cam
end
hl.Adornee = char
hl.Enabled = true
hl.FillColor = col
hl.FillTransparency = fillOn and math.clamp(tonumber(c.selfChamsFill) or 0.45, 0, 1) or 1
hl.OutlineColor = c.selfChamsRainbow and col or (c.selfChamsOutlineColor or Color3.new(1, 1, 1))
hl.OutlineTransparency = outlineOn and 0.2 or 1
end
elseif hl then
dropGlow()
end
end
local conn = (type(aa) == "table" and aa.connect) or function(sig, fn) return sig:Connect(fn) end
conn(RunService.Heartbeat, function() pcall(step) end)
if type(aa) == "table" and aa.onUnload then
aa.onUnload(function()
pcall(restoreParts)
pcall(dropGlow)
end)
end
end)
pcall(function()
if aC then
aC.selfChams = aC.selfChams or false
aC.selfChamsColor = aC.selfChamsColor or Color3.fromRGB(255, 255, 255)
aC.selfChamsFill = aC.selfChamsFill or 0.45
aC.selfChamsOutline = aC.selfChamsOutline ~= false
aC.selfChamsMaterial = aC.selfChamsMaterial or "ForceField"
aC.selfChamsOutlineColor = aC.selfChamsOutlineColor or Color3.fromRGB(255, 255, 255)
aC.selfChamsRainbow = aC.selfChamsRainbow or false
aC.selfChamsTransp = aC.selfChamsTransp or 0
aC.selfChamsAcc = aC.selfChamsAcc ~= false
end
end)
pcall(function()
local RunService = game:GetService("RunService")
RunService.Heartbeat:Connect(function()
if not aC or not aC.espChamsRainbow or not aC.espChams then return end
local h = (tick() * 0.25) % 1
local col = Color3.fromHSV(h, 0.9, 1)
aC.espChamsColor = col
end)
end)
pcall(function()
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LP = game:GetService("Players").LocalPlayer
local wasAir, landedAt, rolled, rollOk = false, os.clock(), false, true
local streak, lastEdge, speedSmooth = 0, 0, 0
local hudGui, hudLabel
local function destroyHud()
if hudGui then pcall(function() hudGui:Destroy() end) end
hudGui, hudLabel = nil, nil
end
local function ensureHud()
if hudGui and hudGui.Parent then return end
destroyHud()
hudGui = Instance.new("ScreenGui")
hudGui.Name = "NightCCBhopHud"
hudGui.ResetOnSpawn = false
hudGui.IgnoreGuiInset = true
hudGui.DisplayOrder = 220
hudGui.Parent = (gethui and gethui()) or game:GetService("CoreGui")
hudLabel = Instance.new("TextLabel")
hudLabel.AnchorPoint = Vector2.new(0.5, 0.5)
hudLabel.Position = UDim2.new(0.5, 0, 0.86, 0)
hudLabel.Size = UDim2.fromOffset(230, 26)
hudLabel.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
hudLabel.BackgroundTransparency = 0.35
hudLabel.BorderSizePixel = 0
hudLabel.Font = Enum.Font.GothamBold
hudLabel.TextSize = 14
hudLabel.TextColor3 = Color3.fromRGB(110, 255, 140)
hudLabel.Text = ""
hudLabel.Parent = hudGui
local c = Instance.new("UICorner")
c.CornerRadius = UDim.new(1, 0)
c.Parent = hudLabel
end
local conn = RunService.RenderStepped:Connect(function(dt)
if not aC then return end
local char = LP.Character
local hum = char and char:FindFirstChildOfClass("Humanoid")
local hrp = char and char:FindFirstChild("HumanoidRootPart")
if not (hum and hrp) then destroyHud(); return end
local now = os.clock()
local onGround = hum.FloorMaterial ~= Enum.Material.Air
if onGround and wasAir then landedAt, rolled = now, false end
if (not onGround) and not wasAir then
streak = (now - landedAt < 0.25) and (streak + 1) or 1
end
wasAir = not onGround
if aC.bhop or aC.bhopCrouch then
local st = hum:GetState()
if st == Enum.HumanoidStateType.Freefall or st == Enum.HumanoidStateType.Jumping then
if aC.bhopCrouch then
pcall(function() hum.Crouching = true end)
pcall(function() hum.Parent:SetAttribute("Crouching", true) end)
end
elseif onGround then
if aC.bhop and UIS:IsKeyDown(Enum.KeyCode.Space) then
if not rolled then
rolled = true
rollOk = (math.random() * 100) <= (aC.bhopChance or 100)
end
if rollOk and (now - landedAt) * 1000 >= (aC.bhopDelay or 0) then
hum.Jump = true
end
end
if aC.bhopCrouch then
pcall(function() hum.Crouching = false end)
end
end
end
if aC.bhopSpeedBoost and not onGround then
local v = hrp.AssemblyLinearVelocity
local horiz = Vector3.new(v.X, 0, v.Z)
local cap = aC.bhopMaxSpeed or 80
local mul = 1 + (aC.bhopBoostPct or 2) / 100
if horiz.Magnitude > 2 and horiz.Magnitude < cap then
local m = math.min(horiz.Magnitude * mul, cap)
hrp.AssemblyLinearVelocity = Vector3.new(horiz.Unit.X * m, v.Y, horiz.Unit.Z * m)
end
end
if aC.bhopEdge and onGround and now - lastEdge > 0.35 then
local v = hrp.AssemblyLinearVelocity
local horiz = Vector3.new(v.X, 0, v.Z)
if horiz.Magnitude > 4 then
local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Exclude
params.FilterDescendantsInstances = { char }
local ahead = hrp.Position + horiz.Unit * math.clamp(horiz.Magnitude * 0.12, 1.5, 4)
if not workspace:Raycast(ahead, Vector3.new(0, -6, 0), params) then
hum.Jump = true
lastEdge = now
end
end
end
if aC.bhopHud then
ensureHud()
local v = hrp.AssemblyLinearVelocity
local sp = Vector3.new(v.X, 0, v.Z).Magnitude
speedSmooth = speedSmooth + (sp - speedSmooth) * math.min(1, (dt or 0.016) * 12)
local hops = (onGround and now - landedAt > 0.5) and 0 or streak
hudLabel.Text = ("%.1f speed  |  %d hops"):format(speedSmooth, hops)
local k = math.clamp(speedSmooth / (aC.bhopMaxSpeed or 80), 0, 1)
local green, yellow, red = Color3.fromRGB(110, 255, 140), Color3.fromRGB(255, 220, 80), Color3.fromRGB(255, 80, 80)
hudLabel.TextColor3 = k < 0.5 and green:Lerp(yellow, k * 2) or yellow:Lerp(red, (k - 0.5) * 2)
else
destroyHud()
end
end)
pcall(function()
aa.onUnload(function()
conn:Disconnect()
destroyHud()
end)
end)
end)
task.spawn(function()
local function scrub(root)
if not root then return end
for _, d in ipairs(root:GetDescendants()) do
pcall(function()
if d:IsA("TextLabel") or d:IsA("TextButton") then
local tx = tostring(d.Text or "")
local low = string.lower(tx)
if low:find("-") and not low:find(" ") and #tx < 48 then
if low:find("arrow") or low:find("head") or low:find("phone") or low:find("user") or low:find("cross") or low:find("target") or low:find("flame") or low:find("eye") or low:find("settings") then
d.Text = ""
d.Visible = false
return
end
end
if low:find("yaw") or low:find("cchah") or low:find("tgknight") or low:find("horizontal") then
d.Text = ""
d.Visible = false
return
end
if tx == "NL" or tx == "n" or tx == "N" then
d.Text = ""
d.Visible = false
return
end
local bad = 0
for i = 1, #tx do
local b = string.byte(tx, i)
if b and (b > 127 or b < 32) then bad += 1 end
end
if #tx > 4 and bad > #tx * 0.25 then
d.Visible = false
end
elseif d:IsA("ImageLabel") or d:IsA("ImageButton") then
local n = string.lower(d.Name)
if n:find("logo") or n:find("badge") then
d.ImageTransparency = 1
d.Visible = false
end
end
end)
end
end
while true do
pcall(function()
if gethui then scrub(gethui()) end
scrub(game:GetService("CoreGui"))
local lp = game:GetService("Players").LocalPlayer
if lp then scrub(lp:FindFirstChildOfClass("PlayerGui")) end
end)
task.wait(0.5)
end
end)
pcall(function()
task.defer(function()
task.wait(1)
local roots = {}
pcall(function() if gethui then roots[#roots+1]=gethui() end end)
roots[#roots+1] = game:GetService("CoreGui")
for _, root in ipairs(roots) do
local p = root:FindFirstChild("NightCCKeybinds", true)
if p then
pcall(function() p:Destroy() end)
end
local w = root:FindFirstChild("night_ccWatermark", true)
if w then pcall(function() w:Destroy() end) end
end
end)
end)
pcall(function()
local RunService = game:GetService("RunService")
getgenv().NightPredictPos = function(part)
if not (aC and aC.ragePrediction and part) then
return part and part.Position
end
local amt = tonumber(aC.ragePredictionAmount) or 0.12
local v = part.AssemblyLinearVelocity or Vector3.zero
return part.Position + v * amt
end
end)
task.spawn(function()
while true do
pcall(function()
if aC then
aC.autoBuy = false
aC.buyZeus = false
aC.knifeBot = false
aC.knifeHeavy = false
end
end)
task.wait(1)
end
end)
pcall(function()
task.spawn(function()
while true do
pcall(function()
if aC then aC.ufoEnabled = false end
local w = workspace:FindFirstChild("NightUFO")
if w then w:Destroy() end
end)
task.wait(2)
end
end)
end)