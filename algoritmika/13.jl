using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))

function mark_chess!(r)
    S,W=move_angle!(r, Sud, West)
    if mod(S, 2)==mod(W, 2)
        putmarker!(r)
    end
    snake!(()->isborder(r, Nord),r, Ost, Nord)
    move_angle!(r, Sud, West)
    return!(r, Nord, S)
    return!(r, Ost, W)
end

function kol_numsteps!(stop,r, Side)::Int
    kol=0
    while !stop()
        move!(r, Side)
        kol+=1
    end
    return kol
end

function return!(r,Side,num_steps)
    for x in 1:num_steps
        move!(r,Side)
    end
end

function move_angle!(r, Side1, Side2)
    n1=kol_numsteps!(()->isborder(r, Side1), r, Side1)
    n2=kol_numsteps!(()->isborder(r, Side2), r, Side2)
    return n1, n2
end

function state_pr!(r, state)
    if state==1
        putmarker!(r)
        state=0
    else
        state=1
    end
    return state
end

function dlin!(stop, r, Side)
    if !ismarker(r)
        move!(r, Side)
        putmarker!(r)
    else
        state=1
    end
    state=0
    while !stop()
        move!(r, Side)
        state=state_pr!(r, state)
    end
end

function snake!(stop, r, t, d)
    while !stop()
        dlin!(()->isborder(r, t), r, t)
        if ismarker(r)
            move!(r, d)
        else
            move!(r, d)
            putmarker!(r)
        end
        t=inverse(t)
    end
    dlin!(() -> isborder(r, t), r, t)
end

mark_chess!(r)