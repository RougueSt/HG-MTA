--[[ 
COMANDO CRIADOS NESSE SCRIPT + EXPLICAÇÂO
/wall --> Comando usado para ligar o wall hack
/wall 0 --> Comando para desligar o wallhack
/spec [jogador]--> para telar outro jogar e ainda funcionar o wallhack, se telar usando o spec do painel não funciona!!
/spec --> para sair do spec
/specname --> Copia o nick do jogador no ctrl + v se o nick do cara for muito complicado 
]]


addEventHandler('onResourceStart', getResourceRootElement(getThisResource()), function()
    local lista = getElementsByType('player')
        for i,j in ipairs(lista) do 
            local conta = getAccountName(getPlayerAccount(j))
            if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then        
                outputChatBox('Commands: \n')
                outputChatBox('Script Developed by #29e014Rougue#8075', j, 230,230,230, true)
                outputChatBox('--------------------------------------------', j, 230,30,30)
                        
                outputChatBox('/wall --> Turn wall on', j, 230,230,230)
                outputChatBox('/wall 0 --> Turn wall off', j, 230,230,230)
                outputChatBox('/spec [nick]--> to spectate player and still see behind the walls', j, 230,230,230)
                outputChatBox('/spec --> to stop specteting', j, 230,230,230)
                outputChatBox('/name --> Copy player name to clipboard ', j, 230,230,230)
                outputChatBox('/spechelp --> To show script\'s commands ', j, 230,230,230)
                outputChatBox('--------------------------------------------\n', j, 230,30,30)
            end
        end
end)








addCommandHandler('wall', function(Player, comando, arg1)

    local conta = getAccountName(getPlayerAccount(Player))
    if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
        if arg1 == '0' then
            local jogadores = getElementsByType('Player')
            for i,j in ipairs(jogadores) do
                local conta = getAccountName(getPlayerAccount(j))
                if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
                    outputChatBox(getPlayerName(Player).. ' deactivate the wallhack', j, 230, 30, 30)
                end
            end
            outputServerLog(getPlayerName(Player) .. ' deactivate the wallhack')
            triggerClientEvent(Player, 'hack', Player, arg1)
            return
        end
        triggerClientEvent(Player, 'hack', Player, arg1)
        local jogadores = getElementsByType('Player')
        for i,j in ipairs(jogadores) do
            local conta = getAccountName(getPlayerAccount(j))
            if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
                outputChatBox(getPlayerName(Player).. ' activate the wallhack', j, 30, 230, 30)
            end
        end
        outputServerLog(getPlayerName(Player).. ' activate the wallhack')
    end


end, false, false)



function spec (staff, comando, player)

    local conta = getAccountName(getPlayerAccount(staff))
    if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
    
        if player == nil then
            if (getCameraTarget(staff) == staff) then
                outputChatBox('you\'re not in spec mode', staff, 230, 30, 30)
                return
            end
            setCameraTarget(staff, staff)
            setElementFrozen(staff, false)
            if isPedInVehicle(staff) then
                local vehicle = getPedOccupiedVehicle(staff)
                setElementFrozen(vehicle, false)
            end
            return
        end 

        

        local spectado = getPlayerFromName(player)
        if not isElement(spectado) then
            outputChatBox('Type the Player name correctly or /spec to stop spectating', staff, 230, 30, 30)
            return
        end

        if spectado == staff then
            outputChatBox('You cannot spectate yourself', staff)
            return
        end

        if isPedInVehicle(staff) then
            local vehicle = getPedOccupiedVehicle(staff)
            setElementFrozen(vehicle, true)
        end

        setElementFrozen(staff, true)
        setCameraTarget(staff, spectado)
        outputChatBox('Type /spec to stop spectating the player: '.. getPlayerName(spectado), staff, 30, 230, 30)
    end

end

addCommandHandler('spec', spec, false, false)


addCommandHandler('name', function(staff)
    local conta = getAccountName(getPlayerAccount(staff))
    if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then    
        if (getCameraTarget(staff) == staff) or getPedOccupiedVehicle(staff) == getCameraTarget(staff) then
            outputChatBox('you\'re not in spec mode', staff, 230, 30, 30)
            return 
        end
        triggerClientEvent(staff, 'copiar:nome', staff, getPlayerName(getCameraTarget(staff)))
    end
end, false, false)

addCommandHandler('spechelp', function(j)
    local conta = getAccountName(getPlayerAccount(j))
    if isObjectInACLGroup ("user."..conta, aclGetGroup ("Admin")) or isObjectInACLGroup ("user."..conta, aclGetGroup ("Console")) then
        outputChatBox('Utilize os comandos: \n')
        outputChatBox('Commands: \n')
        outputChatBox('--------------------------------------------', j, 230,30,30)
                
        outputChatBox('/wall --> Turn wall on', j, 230,230,230)
        outputChatBox('/wall 0 --> Turn wall off', j, 230,230,230)
        outputChatBox('/spec [nick]--> to spectate player and still see behind the walls', j, 230,230,230)
        outputChatBox('/spec --> to stop spectating', j, 230,230,230)
        outputChatBox('/name --> Copy player name to clipboard ', j, 230,230,230)
        outputChatBox('/spechelp --> To show script\'s commands ', j, 230,230,230)
        outputChatBox('--------------------------------------------\n', j, 230,30,30)

    end
end)