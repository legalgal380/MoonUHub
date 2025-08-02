local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")
local cam = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Tabela de jogadores
local NomesJogadores = {}
for _, player in ipairs(Players:GetPlayers()) do
    table.insert(NomesJogadores, player.Name)
end

-- Interface WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Moon hub",
    Icon = "moon",
    Author = "Por BloxerOfc",
    Folder = "MoonUHub",
    Size = UDim2.fromOffset(280, 420),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 200,
    Background = "",
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true,
    ScrollBarEnabled = false,
    User = {
        Enabled = false,
        Anonymous = true,
        Callback = function() end,
    },
})

-- Tabs
local MainTab = Window:Tab({ Title = "Main", Icon = "house", Locked = false })
local PlayerTab = Window:Tab({ Title = "Player", Icon = "user", Locked = false })
local PlayersTab = Window:Tab({ Title = "Players", Icon = "users", Locked = false })
local ToolTab = Window:Tab({ Title = "Tools", Icon = "hammer", Locked = false })
local SoundTab = Window:Tab({ Title = "Som", Icon = "music", Locked = false })
local TpTab = Window:Tab({ Title = "Tp", Icon = "car", Locked = false })
local CreditsTab = Window:Tab({ Title = "Créditos", Icon = "id-card", Locked = false })

Window:SelectTab(1)

-- Sliders
PlayerTab:Slider({
    Title = "Velocidade do jogador",
    Step = 1,
    Value = { Min = 16, Max = 888, Default = 16 },
    Callback = function(value)
        Character.Humanoid.WalkSpeed = value
    end
})

PlayerTab:Slider({
    Title = "Força do pulo do jogador",
    Step = 1,
    Value = { Min = 50, Max = 1200, Default = 50 },
    Callback = function(value)
        Character.Humanoid.JumpPower = value
    end
})

-- RGB Toggles
local isNameRGBActive = false
local isBioRGBActive = false
local isCarRGBActive = false
_G.CarRGBSpeed = 0.02

PlayerTab:Toggle({
    Title = "Rbg de nome",
    Desc = "Dá um rbg no nome",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isNameRGBActive = state
        if state then
            task.spawn(function()
                while isNameRGBActive do
                    for h = 0, 1, 0.01 do
                        if not isNameRGBActive then break end
                        local color = Color3.fromHSV(h, 1, 1)
                        ReplicatedStorage.RE:WaitForChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor", color)
                        task.wait(0.02)
                    end
                end
            end)
        else
            ReplicatedStorage.RE:WaitForChild("1RPNam1eColo1r"):FireServer("PickingRPNameColor", Color3.fromRGB(255,255,255))
        end
    end
})

PlayerTab:Toggle({
    Title = "Rbg de bio",
    Desc = "Dá um rbg na bio",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isBioRGBActive = state
        if state then
            task.spawn(function()
                while isBioRGBActive do
                    for h = 0, 1, 0.01 do
                        if not isBioRGBActive then break end
                        local color = Color3.fromHSV(h, 1, 1)
                        ReplicatedStorage.RE:WaitForChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor", color)
                        task.wait(0.02)
                    end
                end
            end)
        else
            ReplicatedStorage.RE:WaitForChild("1RPNam1eColo1r"):FireServer("PickingRPBioColor", Color3.fromRGB(255,255,255))
        end
    end
})

PlayerTab:Slider({
    Title = "Velocidade RGB do carro",
    Step = 0.01,
    Value = { Min = 0.01, Max = 0.2, Default = 0.02 },
    Callback = function(val)
        _G.CarRGBSpeed = val
    end
})

-- Toggle RGB do carro com RemoteEvent SetColor
local RbgCarToggle = PlayerTab:Toggle({
    Title = "Rbg de carro",
    Desc = "Dá um rbg no carro (apenas Premium)",
    Icon = "bird",
    Type = "Checkbox",
    Default = false,
    Callback = function(state)
        isCarRGBActive = state

        if isCarRGBActive then
            task.spawn(function()
                while isCarRGBActive do
                    for hue = 0, 1, 0.01 do
                        if not isCarRGBActive then break end
                        local args = { ColorRGB }
                        game:GetService("Players").LocalPlayer
                            :WaitForChild("PlayerGui")
                            :WaitForChild("MainGUIHandler")
                            :WaitForChild("VehicleControl")
                            :WaitForChild("UIColorPicker")
                            :WaitForChild("SetColor")
                            :FireServer(unpack(args))
                        task.wait(_G.CarRGBSpeed or 0.02)
                    end
                end
            end)
        else
            local args = { Color3.fromRGB(255, 255, 255) }
            game:GetService("Players").LocalPlayer
                :WaitForChild("PlayerGui")
                :WaitForChild("MainGUIHandler")
                :WaitForChild("VehicleControl")
                :WaitForChild("UIColorPicker")
                :WaitForChild("SetColor")
                :FireServer(unpack(args))
        end
    end
})

-- Jogador selecionado para ações
local selectedPlayerName
PlayersTab:Dropdown({
    Title = "Jogador",
    Values = NomesJogadores,
    Value = NomesJogadores[1],
    Callback = function(name)
        selectedPlayerName = name
    end
})

local function KillPlayerCouch()
    if not selectedPlayerName then
        warn("Erro: Nenhum jogador selecionado")
        return
    end

    local target = Players:FindFirstChild(selectedPlayerName)
    if not target or not target.Character then
        warn("Erro: Jogador alvo não encontrado ou sem personagem")
        return
    end

    local char = LocalPlayer.Character
    if not char then
        warn("Erro: Personagem do jogador local não encontrado")
        return
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    local tRoot = target.Character:FindFirstChild("HumanoidRootPart")

    if not hum or not root or not tRoot then
        warn("Erro: Componentes necessários não encontrados")
        return
    end

    -- Salvar posição original
    local originalPos = root.CFrame

    -- Limpar e pegar sofá
    ReplicatedStorage:WaitForChild("RE"):WaitForChild("1Clea1rTool1s"):FireServer("ClearAllTools")
    task.wait(0.2)
    ReplicatedStorage.RE:FindFirstChild("1Too1l"):InvokeServer("PickingTools", "Couch")
    task.wait(0.3)

    local tool = LocalPlayer.Backpack:FindFirstChild("Couch")
    if tool then
        tool.Parent = char
    else
        warn("Erro: Sofá não encontrado na mochila")
        return
    end
    task.wait(0.3)

    local sitting = false
    task.spawn(function()
        while not sitting and target and target.Character do
            if not char or not char:FindFirstChild("HumanoidRootPart") then break end

            local tPos = tRoot.Position
            local time = tick() * 15
            local offset = Vector3.new(
                math.sin(time * 2) * 2,
                -2.5 + math.cos(time * 4) * 1.5, -- mais embaixo como você pediu
                math.cos(time * 2) * 2
            )

            local rot = CFrame.Angles(
                math.rad(time * 400 % 360),
                math.rad(time * 600 % 360),
                math.rad(time * 800 % 360)
            )

            root.CFrame = CFrame.new(tPos + offset) * rot
            task.wait(0.01)
        end
    end)

    task.wait(1)

    local couchTool = char:FindFirstChild("Couch")
    if couchTool and couchTool:FindFirstChild("RemoteEvent") then
        couchTool.RemoteEvent:FireServer()
        sitting = true
    else
        warn("Erro: Sofá ou evento remoto não encontrado")
    end

    task.wait(0.3)
    cam.CameraSubject = tRoot
end

-- Botão para matar com sofá
PlayersTab:Button({
    Title = "Matar jogador com sofá",
    Desc = "Teleporta o jogador pro void com sofá",
    Locked = false,
    Callback = KillPlayerCouch
})
