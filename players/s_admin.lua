
local function coordenadas(player, comando, arg)
    
    local x, y, z = getElementPosition(player)
    local a, b, c = getElementRotation(player)

    outputChatBox('XYZ: '.. x .. ', ' .. y ..', ' .. z, localPlayer)
    outputChatBox('XrYrZr: '.. a .. ', '.. b ..', ' .. c, localPlayer)
end

addCommandHandler('pos2',coordenadas)


addCommandHandler('setkill', function(source, comando, jogador, arg1)
    if jogador == nil or not isElement(getPlayerFromName(jogador)) then 
        return outputChatBox('Wrong nickname or not online', source, 230,30,30)
    end
    local player = getPlayerFromName(jogador)
    
    
    setElementData(player, 'kills', arg1)
    outputChatBox('Kills has been changed', source, 30,230,30)

end)
addCommandHandler('setpoints', function(source, comando, jogador, arg1)
    
    if jogador == nil or not isElement(getPlayerFromName(jogador)) then 
        return outputChatBox('Wrong nickname or not online', source, 230,30,30)
    end
    
    setElementData(player, 'points', arg1)
    outputChatBox('points has been changed', source, 30,230,30)

end)

addCommandHandler('setcash', function(source, comando, jogador, arg1)
    
    if jogador == nil or not isElement(getPlayerFromName(jogador)) then 
        return outputChatBox('Wrong nickname or not online', source, 230,30,30)
    end
    
    local player = getPlayerFromName(jogador)
    
    setElementData(player, 'cash', arg1)
    outputChatBox('Player cash has been changed', source, 30,230,30)

end)

addCommandHandler('setdeath', function(source, comando, jogador, arg1)

    if jogador == nil or not isElement(getPlayerFromName(jogador)) then 
        return outputChatBox('Wrong nickname or not online', source, 230,30,30)
    end
    

    local player = getPlayerFromName(jogador)
    setElementData(player, 'death', arg1)
    outputChatBox('Player death has been changed', source, 30,230,30)

end)