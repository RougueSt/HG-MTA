
local Font = 1
started = false

function wall(comando, arg1)
    player = getCameraTarget(localPlayer)
    if not isElement(player) then
        return
    end
    a, b, c = getElementPosition(player)
    ped = getElementsWithinRange(a, b, c, 300 , "player")
    car = getElementsWithinRange(a, b, c, 300 , "vehicle")
    for i,j in pairs(car) do
        
        x, y, z = getElementPosition(j)
        distance = getDistanceBetweenPoints3D(a,b,c, x,y,z)
        if distance < 300 then 
            Px, Py, Pz = getScreenFromWorldPosition(x, y, z)
            if Px and Py then
                dxDrawText(getVehicleName(j).. '| '.. math.floor(Pz).. 'm', Px+1, Py+2, Px, Py, tocolor(0,0,0), Font, 'clear')
                dxDrawText(getVehicleName(j).. '| '.. math.floor(Pz).. 'm', Px, Py, Px, Py, tocolor(250,250,250), Font, 'clear')
            end
                
        end
    end
    for i,j in pairs(ped) do
        x, y, z = getElementPosition(j)
        distance = getDistanceBetweenPoints3D(a,b,c, x,y,z)
        if distance < 300 then 
            Px, Py, Pz = getScreenFromWorldPosition(x, y, z)
            if Px and Py then
                dxDrawText(getPlayerName(j)..' | ' .. math.floor(Pz).. 'm', Px+1, Py + 7, Px, Py, tocolor(0,0,0), Font, 'clear')
                dxDrawText(getPlayerName(j)..' | ' .. math.floor(Pz).. 'm', Px, Py + 5, Px, Py, tocolor(30,230,230), Font, 'clear')
                --[[ dxDrawText('Player '.. '| '.. math.floor(Pz).. 'm', Px+1, Py+2 + 5, Px, Py, tocolor(0,0,0), Font, 'clear')
                dxDrawText('Player '.. '| '.. math.floor(Pz).. 'm', Px, Py + 5, Px, Py, tocolor(30,230,230), Font, 'clear') ]]
            end
                
        end
    end
end

local controle
function ligar(arg1)

    if arg1 == '0' then 
        removeEventHandler('onClientPreRender', root, wall)
        controle = false
        return
    end

    if controle == true then
        return
    end
    addEventHandler('onClientPreRender', root, wall)
    controle = true

end


addEvent('hack', true)
addEventHandler('hack', localPlayer, ligar)


function copiarNome(stringNome)
    setClipboard(stringNome)
    outputChatBox('Nome do jogador telado copiado para o CTRL + V', 30, 230, 30)
end

addEvent('copiar:nome', true)
addEventHandler('copiar:nome',root, copiarNome)
