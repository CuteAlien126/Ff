using HorizonSideRobots
r=Robot(animate=true)
inverse(Side::HorizonSide)=HorizonSide(mod(Int(Side)+2,4))
right(Side::HorizonSide)::HorizonSide=HorizonSide(mod(Int(Side)+1, 4))

function mark_chess!(r)
    p=move_angle!(r, Nord, Ost)
    S, W=move_angle_kol!(r, Sud, West)
    if mod(S+count(p, "0"), 2)==mod(W+count(p, "1"), 2)
        putmarker!(r)
    end
    dlin!(r, Nord, S)
    dlin!(r, Ost, W)
    dlin!(r, Sud, S)
    snake!(r, West, Nord, S, W)
    move_angle!(r, Nord, Ost)
    return!(r, Sud, West, p)
end

function pr_move!(r,Side,s)
    for x in 1:s
        pr_dvij!(r,Side)
    end
end

function pr_dvij!(r, Side)
    if !isborder(r, Side) 
        move!(r, Side)
        return true
    else 
        return false
    end
end

function wall(r::Robot, Side::HorizonSide, state1::Int, state2::Int)
    R=right(Side)
    if pr_dvij!(r, Side)
        state2+=1
        if !isborder(r, inverse(R))
            for i in 1:(state1)
                move!(r, inverse(R))
            end
            return state1, state2
        else
            if state1==0
                return (0, 1) 
            end
            state1, state2=wall(r, Side, state1, state2)
        end
        return (state1, state2)
    else
        if isborder(r, Side)
            move!(r, R)
            x, y=wall(r, Side, state1+1, state2)
            state1=x
            state2=y
            return (state1, state2)
        end
    end
end

function return!(r, Side1, Side2, par)
    par=reverse(par)
    for x in par
        if x=='0'
            move!(r, Side1)
        else
            move!(r, Side2)
        end
    end
end

function move_angle!(r, Side1, Side2)
    par=""
    while !(isborder(r, Side1) & isborder(r, Side2))
        if !isborder(r, Side1)
            move!(r, Side1)
            par*="0"
        end    
        if !isborder(r, Side2)
            move!(r, Side2)
            par*="1"
        end  
    end
    return par
end

function move_angle_kol!(r, Side1, Side2)
    kol1,kol2 = 1,1
    while !(isborder(r, Side1) & isborder(r, Side2))
        if !isborder(r, Side1)
            move!(r, Side1)
            kol1+= 1
        end    
        if !isborder(r, Side2)
            move!(r, Side2)
            kol2+=1
        end  
    end
    return kol1, kol2
end

function corr!(r, t)
    if mod(t, 2)==0
        putmarker!(r)
    end
end

function dlin!(r, Side, shir)
    t=1
    if ismarker(r)
        shir-=1
        move!(r,Side)
    end
    corr!(r, t)
    while t<shir
        t+=wall(r, Side, 0, 0)[2]
        corr!(r, t)
    end
    if shir!= t
        move!(r, Side)
        corr!(r, t)
    end
end

function snake!(r, Side, osn, vis, shir)
    t=1
    while t<vis
       dlin!(r, Side, shir)
       Side=inverse(Side)
       move!(r, osn)
       t+=1
    end
end

mark_chess!(r)
