abstract type AbstractAroundRobot <: AbstractRobot end

get_coordinates(robot::AbstractAroundRobot) = get_coordinates(get_baserobot(robot))
get_direct(robot::AbstractAroundRobot) = get_direct(get_baserobot(robot))

function around!(robot::AbstractAroundRobot)
    edge_robot = get_baserobot(robot) # - это лишнее
    move!(edge_robot)
    while get_coordinates(edge_robot) ≠ Coordinates(0,0) || get_direct(edge_robot) ≠ start_direct
        move!(edge_robot)
    end
end

#---------------------------------------------

struct AroundRobot{TypeRobot} <: AbstractAroundRobot
    robot::EdgeRobot{TypeRobot} # ориентирован положительно, т.е. граница всегда слева от робота
    coords::Coordinates
    start_direct::HorizonSide
    function AroundRobot{TypeRobot}(robot, edge_side::HorizonSide) where TypeRobot 
        edge_robot = EdgeRobot{TypeRobot}(robot, orientation=Positive, edge_side)
        new(edge_robot, Coordinates(0,0), get_direct(edge_robot))
    end
end

get_baserobot(robot::AroundRobot) = robot.robot
HSR.move!(robot::AroundRobot) = move!(robot.robot)

#---------------------------------------------

mutable struct AreaRobot <: AbstractAroundRobot
    robot::AroundRobot{Robot}
    coords::Coordinates
    area::Int64
    AreaRobot(robot, edge_side) = new(AroundRobotrobot{Robot}(robot, edge_side), Coordinates(0,0), 0)
end

function HSR.move!(robot::AreaRobot)
    if get_direct(robot) == Ost
        robot.area -= (get_coordinates(robot)[2]+1)
    elseif get_direct(robot) == West
        robot.area += (get_coordinates(robot)[2]+1)
    end

    # Тут надо ещё проверять условия: 
    # - когда робот делает поворот во внутреннем углу
    # - когда робот делает разворот в узком месте
    # Без этого подсчет площади будет неправильный
    move!(get_baserobot(robot))
end


#----------------------------------------------------------------------------------

mutable struct CountRotsRobot <: AbstractAroundRobot
    robot::AroundRobot{Robot}
    coords::Coordinates # - наверное.,  это лишнее
    num_left::Int64
    num_right::Int64
    CountRotsRobot(robot, edge_side) = new(AroundRobotrobot{Robot}(robot, edge_side), Coordinates(0,0), 0)
end

function HSR.move!(robot::CountRotsRobot) # - тут ошибка: прибавлять в некоторых случаях надо 2 (если робот развернулся в тупике)
    prev_direct = get_direct(robot)
    move!(get_baserobot(robot))
    if get_direct(robot) == left(prev_direct) 
        robot.num_left += 1
    elseif get_direct(robot) == right(prev_direct) 
        robot.num_right += 1
    elseif isborder(robot, left) && isborder(robot, right) # робот развернулся в тупике на 180 градусов
        robot.num_right += 2 # т.к. робот движется в положительном направлении вдоль границы
    end
    nothing
end

#--------------------------------------------------------

# определяет положение робота: внутри или снаружи замкнутого лабирина
function is_inside(robot, edge_side::HorizonSide)
    robot = CountRotsRobot(robot, edge_side)
    round!(robot)
    return (robot.num_right > robot.num_left)
end

#--------------------------------------------------------------

#=
ДРУГИЕ ВАРИАНТЫ ПРОЕКТИРОВАНИЯ
- Возможно, тип CountRotsRobot должен быть производным типом от AbstractEdgeRobot ?

Но, если определить абстрактный тип AbstractEdgeRobot <: AbstractDirectRobot, то тогда, наверное, 
уже не понадобится параметрический тип EdgeRobot{TypeRobot} - вместо него будут конкретные типы

- Возможно, также стоит определить абстрактный тип AbstractCountRotsRobot 
или сделать CountRotsRobot параметрическим?

=#