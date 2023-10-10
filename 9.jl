using HorizonSideRobots
r=Robot(animate=true)

function chess!(r)
    putmarker!(r)
    nums=markchessrow!(r,0)
    k=chessside!(r,Nord)
    move_n!(r,Sud,k)
    k=chessside!(r,Sud)
    move_n!(r,Nord,k)
    while !isborder(r,West)
        move!(r,West)
    end
    move_n!(r,Ost,nums)

    
end

function markchessrow!(r)
    flag=false
    for Side in (West, Ost)
        while !isborder(r, Side)
            move!(r,Side)
            flag && putmarker!(r)
            flag=!flag
        end
    end

end

function markchessrow!(r, numspets)
    flag=false
    if ismarker(r)
        flag=true
    end
    for Side in (West, Ost)
        while !isborder(r,Side)
            move!(r,Side)
            !flag && putmarker!(r)
            flag=!flag
            if Side==West
                numspets+=1
            end
        end
    end
    return numspets
end

function chessside!(r,Side)
    k=0
    while !isborder(r,Side)
        flag=false
        if ismarker(r)
            flag=true
        end
        move!(r,Side)
        if flag
            move!(r,West)
            markchessrow!(r)
        else
            markchessrow!(r)
            flag=!flag
        end
        k+=1
    end
    return k
end

function move_n!(r, Side::HorizonSide, n::Int)
    for x in 1:n
        move!(r,Side)
    end    
end

chess!(r)