

if game.CoreGui:FindFirstChild("ui") then
    game.CoreGui["ui"]:Destroy()
end

local autoSwing = false
local autoSpin = false
local autoBringAll = false
local autoCollect = false
local playerHead = game.Players.LocalPlayer.Character.Head
local spinSpeed = 30
local bringDist = 10
function getRoot(char)
    local rootPart =
        char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
    return rootPart
end

local function swing()
    spawn(
        function()
            while autoSwing == true do
                pcall(
                    function()
                        task.wait()
                        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                    end
                )
                if not autoSwing then
                    break
                end
            end
        end
    )
end

local function collectGingerbread()
    spawn(
        function()
            while autoCollect == true do
                task.wait()
                for i, v in pairs(game:GetService("Workspace").Terrain.Claims:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        firetouchinterest(playerHead, v.Parent, 0)
                    end
                end
                if not autoCollect then
                    break
                end
            end
        end
    )
end

local function spin()
    spawn(
        function()
            while autoSpin == true do
                pcall(
                    function()
                        task.wait()
                        for i, v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
                            if v.Name == "Spinning" then
                                v:Destroy()
                            end
                        end
                        local Spin = Instance.new("BodyAngularVelocity")
                        Spin.Name = "Spinning"
                        Spin.Parent = getRoot(game.Players.LocalPlayer.Character)
                        Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                        Spin.AngularVelocity = Vector3.new(0, spinSpeed, 0)
                    end
                )
                if not autoSpin then
                    for i, v in pairs(getRoot(game.Players.LocalPlayer.Character):GetChildren()) do
                        if v.Name == "Spinning" then
                            v:Destroy()
                        end
                    end
                end
            end
        end
    )
end

local function bring()
    spawn(
        function()
            while autoBringAll == true do
                pcall(
                    function()
                        task.wait()
                        for i, v in next, game.Players:GetChildren() do
                            if v ~= game.Players.LocalPlayer then
                                if v.Character:FindFirstChild("Humanoid") then
                                    v.Character:PivotTo(
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame +
                                            Vector3.new(bringDist, 0, 0)
                                    )
                                end
                            end
                        end
                    end
                )
            end
        end
    )
end

local lib = loadstring(game:HttpGet "https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt")()

local win =
    lib:Window(
    "Obscurity | " .. game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
    Color3.fromRGB(67, 36, 206),
    Enum.KeyCode.RightControl
)
local tab = win:Tab("Main")

tab:Toggle(
    "Auto Swing",
    false,
    function(t)
        autoSwing = t
        if autoSwing then
            swing()
        end
    end
)

tab:Toggle(
    "Auto Spin",
    false,
    function(t)
        autoSpin = t
        if autoSpin then
            spin()
        end
    end
)

tab:Slider(
    "Spin Speed",
    1,
    250,
    spinSpeed,
    function(t)
        spinSpeed = t
    end
)

tab:Toggle(
    "Auto Bring Players",
    false,
    function(t)
        autoBringAll = t
        if autoBringAll then
            bring()
        end
    end
)

tab:Slider(
    "Bring Distance",
    0,
    250,
    bringDist,
    function(t)
        bringDist = t
    end
)

tab:Toggle(
    "Auto Collect Gingerbread",
    false,
    function(t)
        autoCollect = t
        if autoCollect then
            collectGingerbread()
        end
    end
)

tab:Button("TP To Safe Zone", function()
    game.Players.LocalPlayer.Character:PivotTo(CFrame.new(-712.602, 104.324, -382.113))
    end)

local tab = win:Tab("Player")

tab:Slider(
    "WalkSpeed",
    16,
    500,
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,
    function(t)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = t
    end
)
tab:Slider(
    "JumpPower",
    50,
    500,
    game.Players.LocalPlayer.Character.Humanoid.JumpPower,
    function(t)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = t
    end
)
