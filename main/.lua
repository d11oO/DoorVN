local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({IntroText = "m gay",Name = "Door (Việt Hóa)", HidePremium = false, SaveConfig = true, ConfigFolder = "DoorWS"})
if game.PlaceId == 6516141723 then
    OrionLib:MakeNotification({
        Name = "Error",
        Content = "Please execute when in game, not in lobby.",
        Time = 2
    })
end
local VisualsTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
local CF = CFrame.new
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom
local ChaseStart = game:GetService("ReplicatedStorage").GameData.ChaseStart
local KeyChams = {}
--[[VisualsTab:AddToggle({
    Name = "Key Chams",
    Default = false,
    Flag = "KeyToggle",
    Save = true,
    Callback = function(Value)
        for i,v in pairs(KeyChams) do
            v.Enabled = Value
        end
    end    
})

local function ApplyKeyChams(inst)
    wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(0.980392, 0.670588, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Adornee = inst
    Cham.Enabled = OrionLib.Flags["KeyToggle"].Value
    Cham.RobloxLocked = true
    return Cham
end

local KeyCoroutine = coroutine.create(function()
    workspace.CurrentRooms.DescendantAdded:Connect(function(inst)
        if inst.Name == "KeyObtain" then
            table.insert(KeyChams,ApplyKeyChams(inst))
        end
    end)
end)
for i,v in ipairs(workspace:GetDescendants()) do
    if v.Name == "KeyObtain" then
        table.insert(KeyChams,ApplyKeyChams(v))
    end
end
coroutine.resume(KeyCoroutine)]]

local BookChams = {}
VisualsTab:AddToggle({
    Name = "Ở Door 50 Thì Mấy Quyển Sách Sẽ Sáng Lên",
    Default = false,
    Flag = "BookToggle",
    Save = true,
    Callback = function(Value)
        for i,v in pairs(BookChams) do
            v.Enabled = Value
        end
    end    
})

local FigureChams = {}
VisualsTab:AddToggle({
    Name = "Nhìn Thấy Figure Xuyên Tường",
    Default = false,
    Flag = "FigureToggle",
    Save = true,
    Callback = function(Value)
        for i,v in pairs(FigureChams) do
            v.Enabled = Value
        end
    end
})






local function ApplyBookChams(inst)
    if inst:IsDescendantOf(game:GetService("Workspace").CurrentRooms:FindFirstChild("50")) and game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 50 then
        wait()
        local Cham = Instance.new("Highlight")
        Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Cham.FillColor = Color3.new(0, 1, 0.749019)
        Cham.FillTransparency = 0.5
        Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
        Cham.Parent = game:GetService("CoreGui")
        Cham.Enabled = OrionLib.Flags["BookToggle"].Value
        Cham.Adornee = inst
        Cham.RobloxLocked = true
        return Cham
    end
end

local function ApplyEntityChams(inst)
    wait()
    local Cham = Instance.new("Highlight")
    Cham.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    Cham.FillColor = Color3.new(1, 0, 0)
    Cham.FillTransparency = 0.5
    Cham.OutlineColor = Color3.new(0.792156, 0.792156, 0.792156)
    Cham.Parent = game:GetService("CoreGui")
    Cham.Enabled = OrionLib.Flags["FigureToggle"].Value
    Cham.Adornee = inst
    Cham.RobloxLocked = true
    return Cham
end

local BookCoroutine = coroutine.create(function()
    task.wait(1)
    for i,v in pairs(game:GetService("Workspace").CurrentRooms["50"].Assets:GetDescendants()) do
        if v.Name == "LiveHintBook" then
            table.insert(BookChams,ApplyBookChams(v))
        end
    end
end)
local EntityCoroutine = coroutine.create(function()
    local Entity = game:GetService("Workspace").CurrentRooms["50"].FigureSetup:WaitForChild("FigureRagdoll",5)
    Entity:WaitForChild("Torso",2.5)
    table.insert(FigureChams,ApplyEntityChams(Entity))
end)


local GameTab = Window:MakeTab({
    Name = "Game",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
local CharTab = Window:MakeTab({
    Name = "Character",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MobTab = Window:MakeTab({
    Name = "Mobile",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local UiTab = Window:MakeTab({
    Name = "UI",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})



UiTab:AddButton({
    Name = "Destroy The GUI",
    Callback = function()
        OrionLib:Destroy()
      end    
})

local TargetWalkspeed
local Speed = CharTab:AddSlider({
    Name = "Tốc Độ Chạy",
    Min = 0,
    Max = 2,
    Default = 0,
    Color = Color3.fromRGB(255,255,255),
    Increment = 0.1,
    Callback = function(Value)
        TargetWalkspeed = Value
    end    
})

MobTab:AddButton({
    Name = "Chạy Nhanh (Mobile)",
    Callback = function()
        TargetWalkspeed = 2 
    end    
})

MobTab:AddButton({
    Name = "Quay Lại Speed Ban Đầu (Mobile)",
    Callback = function()
        TargetWalkspeed = 0
    end    
})


function isEntitySpawned(): boolean
    local entity = workspace:FindFirstChild("RushMoving") or workspace:FindFirstChild("AmbushMoving")

    if entity then
        if not entity.PrimaryPart then 
            repeat
                task.wait()
            until entity.PrimaryPart or not entity:IsDescendantOf(workspace)
        end

        if entity and distanceFromCharacter(entity:GetPivot().Position) < 2000 then
            return true
        end
    end

    return false
end
--

function isEyesSpawned(): boolean
    local eyes = nil

    if not isBackdoor then
        eyes = workspace:FindFirstChild("Eyes")
    else
        eyes = workspace:FindFirstChild("Lookman")
    end

    return eyes ~= nil
end

if entityName == "Eyes" then
    entity.PrimaryPart:WaitForChild("Ambience"):GetPropertyChangedSignal("Playing"):Connect(function()
        if not entity.PrimaryPart.Ambience.Playing then
            entityEsp.Delete()
        end
    end)

    if OrionLib.Flags["AntiEyes"].Value and isEyesSpawned() then
        remotesFolder.MotorReplication:FireServer(0, -89, 0, false)
    end
end



local pcl = Instance.new("SpotLight")
pcl.Brightness = 1
pcl.Face = Enum.NormalId.Front
pcl.Range = 90
pcl.Parent = game.Players.LocalPlayer.Character.Head
pcl.Enabled = false


CharTab:AddToggle({
    Name = "Ánh Sáng Của Đảng",
    Default = false,
    Callback = function(Value)
        pcl.Enabled = Value
    end
})

GameTab:AddToggle({
    Name = "Đéch Có Cái Tay Của Seek Và Lửa Chùa",
    Default = false,
    Flag = "NoSeek",
    Save = true
})

GameTab:AddToggle({
    Name = "Ấn Một Phát Mở Đc Cửa",
    Default = false,
    Flag = "InstantToggle",
    Save = true
})
GameTab:AddButton({
    Name = "Ko Cs JumpScare",
    Callback = function()
        pcall(function()
            game:GetService("ReplicatedStorage").Bricks.Jumpscare:Destroy()
        end)
    end    
})

GameTab:AddToggle({
    Name = "Nhìn Thẳng Vào Mặt Eyes Cg Ko Die =))",
    Default = true,
    Save = true,
    Flag = "Eyes"
})

GameTab:AddToggle({
    Name = "Lên Trên Nóc Nhà Để Né Rush/Ambush:D",
    Default = false,
    Flag = "AvoidRushToggle",
    Save = true
})
GameTab:AddToggle({
    Name = "Psst? Nuh uh",
    Default = false,
    Flag = "ScreechToggle",
    Save = true
})

GameTab:AddToggle({
    Name = "Ko Lm J cg Thắng Đc Heartbeat",
    Default = false,
    Flag = "HeartbeatWin",
    Save = true
})

GameTab:AddToggle({
    Name = "Dự Đoán Rush / Ambush",
    Default = false,
    Flag = "PredictToggle" ,
    Save = true
})
GameTab:AddToggle({
    Name = "Cảnh Báo Khi Có J Đó Spawn",
    Default = false,
    Flag = "MobToggle" ,
    Save = true
})
GameTab:AddButton({
    Name = "Tự Đông Hoàn Thành Sửa Điện Ở Door 100 =))",
    Callback = function()
        game:GetService("ReplicatedStorage").Bricks.EBF:FireServer()
    end    
})
GameTab:AddButton({
    Name = "Skip Door 50",
    Callback = function()
        local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom+1)]:WaitForChild("Door")
        game.Players.LocalPlayer.Character:PivotTo(CF(CurrentDoor.Door.Position))
    end    
})
GameTab:AddParagraph("Warning","You may need to open/close the panel a few times for this to work, fixing soon.")

--// ok actual code starts here

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        if game.Players.LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0 then
            game.Players.LocalPlayer.Character:TranslateBy(game.Players.LocalPlayer.Character.Humanoid.MoveDirection * TargetWalkspeed/50)
        end
    end)
end)

game:GetService("Workspace").CurrentRooms.DescendantAdded:Connect(function(descendant)
    if OrionLib.Flags["NoSeek"].Value == true and descendant.Name == ("Seek_Arm" or "ChandelierObstruction") then
        task.spawn(function()
            wait()
            descendant:Destroy()
        end)
    end
end)

game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
    if OrionLib.Flags["InstantToggle"].Value == true then
        fireproximityprompt(prompt)
    end
end)

local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    
    if tostring(self) == 'Screech' and method == "FireServer" and OrionLib.Flags["ScreechToggle"].Value == true then
        args[1] = true
        return old(self,unpack(args))
    end
    if tostring(self) == 'ClutchHeartbeat' and method == "FireServer" and OrionLib.Flags["HeartbeatWin"].Value == true then
        args[2] = true
        return old(self,unpack(args))
    end
    
    return old(self,...)
end))

workspace.CurrentCamera.ChildAdded:Connect(function(child)
    if child.Name == "Screech" and OrionLib.Flags["ScreechToggle"].Value == true then
        child:Destroy()
    end
end)

local NotificationCoroutine = coroutine.create(function()
    LatestRoom.Changed:Connect(function()
        if OrionLib.Flags["PredictToggle"].Value == true then
            local n = ChaseStart.Value - LatestRoom.Value
            if 0 < n and n < 4 then
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = "Event in " .. tostring(n) .. " rooms.",
                    Time = 5
                })
            end
        end
        if OrionLib.Flags["BookToggle"].Value == true then
            if LatestRoom.Value == 50 then
                coroutine.resume(BookCoroutine)
            end
        end
        if OrionLib.Flags["FigureToggle"].Value == true then
            if LatestRoom.Value == 50 then
                coroutine.resume(EntityCoroutine)
            end
        end
    end)
    workspace.ChildAdded:Connect(function(inst)
        if inst.Name == "RushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = "Avoiding Rush. Please wait.",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()

                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = "Rush Spawn Kìa, Trốn Đi (Có Thể Là Fake)",
                    Time = 5
                })
            end
        elseif inst.Name == "AmbushMoving" and OrionLib.Flags["MobToggle"].Value == true then
            if OrionLib.Flags["AvoidRushToggle"].Value == true then
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = "Avoiding Ambush. Please wait.",
                    Time = 5
                })
                local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                local con = game:GetService("RunService").Heartbeat:Connect(function()
                    game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,20,0))
                end)
                
                inst.Destroying:Wait()
                con:Disconnect()
                
                game.Players.LocalPlayer.Character:MoveTo(OldPos)
            else
                OrionLib:MakeNotification({
                    Name = "Warning!",
                    Content = "Ambush Spawn kìa, Trốn Đi (Có Thể Là Fake)",
                    Time = 5
                })
            end
        end
    end)
end)

--// ok actual code ends here

local CreditsTab = Window:MakeTab({
    Name = "Credits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

CreditsTab:AddParagraph("u gay")

coroutine.resume(NotificationCoroutine)

OrionLib:Init()

task.wait(2)
