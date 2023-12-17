using HorizonSideRobots
r=Robot(animate=true)

function sl_pr!(r)
    kol_sud,kol_west=bot_left_kol!(r)
    for Side in (Nord,Ost,Sud,West)
        per!(r,Side)
    end
    bot_left_kol!(r)
    return!(r,kol_sud,kol_west)
end

function per!(r,Side)
    while !isborder(r,Side)
        putmarker!(r)
        move!(r,Side)
    end
end

function bot_left_kol!(r::Robot)
    kol_sud=kol_west=0
    while !isborder(r,Sud) || !isborder(r,West)
        kol_sud+=move_!border!(r,Sud)
        kol_west+=move_!border!(r,West)
    end
    return(kol_sud,kol_west)
end

function move_!border!(r::Robot, Side::HorizonSide)
    kol=0
    while !isborder(r,Side)
        move!(r,Side)
        kol+=1
    end
    return kol
end

function return!(r,kol_Nord,kol_Ost)
    for x in 1:kol_Nord
        move!(r, Nord)
    end
    for x in 1:kol_Ost
        move!(r,Ost)
    end
end

sl_pr!(r)

