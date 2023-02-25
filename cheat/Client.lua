local VBRlist = {
    'num_0',
    'num_1',
    'num_2',
    'num_3',
    'num_4',
    'num_5',
    'num_6',
    'num_7',
    'num_8',
    'num_9'
}

--[[ local VBRlist2 = {
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
} ]]


local status = 'Fechou'
addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()), function()
    status = 'Fechou'
end)

addEventHandler('onClientKey', root, function(botao, apertou)
    if botao == 'insert' and apertou then
        if status == 'Fechou' then 
            status = 'Abriu'
        else
            status = 'Fechou'
        end
        triggerServerEvent('cheater:aviso',localPlayer, localPlayer, botao, status)
        return
    end

    if botao == 'F12' and apertou then
        local status2 = 'Atualizou'
        triggerServerEvent('cheater:aviso',localPlayer, localPlayer, botao, status2)
        return
    end
    
end)

local function VBRanti()
    if getKeyState('lshift') then
        local status3 = 'VBR'
        triggerServerEvent('cheater:aviso',localPlayer, localPlayer, botao, status3)
        return
    end
end

local function VBRanti2()
    for i,j in ipairs(VBRlist) do
        if getKeyState(j) then
            local status3 = 'VBR'
            triggerServerEvent('cheater:aviso',localPlayer, localPlayer, botao, status3)
            return
        end
    end
end

bindKey('lshift', 'down', VBRanti2)

addEventHandler('onClientResourceStart',getResourceRootElement(getThisResource()), function()
    for i,j in pairs(VBRlist) do
        bindKey(j, 'down', VBRanti)
    end
end)