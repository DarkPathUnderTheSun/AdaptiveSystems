=begin
            Welcome to my fuzzy logic ruby code!
            It's a just-for-fun little progrqam intended to help me study 
            fuzzy logic, by the best method possible - by programming it!

            Do not expect genius stuff or amazing results. I just works
            for the exercices we see in class, and I hope it results auxiliar
            for some of the homework.

            How to use the program: 
            - Add a matrix object containing the vertexes of your funcion de pertenencia.

                    funcionDePertenenciaTriangular = [0,20,40]
                    funcionDePertenenciaTrapezoidal = [0,20,40,60]

            - Pick a umber to feed the program. The code will calculate just how much does
              the number belong to the fuzzy set.
                    
                    number = 15

            - Input these to one of the pertenence functions.

                    triangularPertenenceDegree(number,funcionDePertenenciaTriangular)

            Warning: be sure to use the corresponding functions. I.e.: don't input trapezoids
            to the trapezoidal function. The code WILL give you a wrong answer.


            Thanks for reading, have fun!
=end


#These functions are models of mathematical functions to calculate stuff.

def triangularPertenenceDeegree(x, triangle)
    x=x.to_f
    if x <= triangle[0]
        return 0
    elsif (triangle[0] < x)&&(x<=triangle[1])
        return ((x-triangle[0])/(triangle[1]-triangle[0]))
    elsif (triangle[1] < x)&&(x<triangle[2])
        return ((triangle[2]-x)/(triangle[2]-triangle[1]))
    elsif x >= triangle[2]
        return 0
    end
end

def trapezoidalPertenenceDeegree(x, trapezoid)
    x=x.to_f
    if (trapezoid[0]<=x)&&(x <= trapezoid[1]) 
        return ((x-trapezoid[0])/(trapezoid[1]-trapezoid[0]))
    elsif (trapezoid[1] <= x)&&(x<=trapezoid[2])
        return 1
    elsif (trapezoid[2] <= x)&&(x<=trapezoid[3])
        return ((trapezoid[3]-x)/(trapezoid[3]-trapezoid[2]))
    else
        return 0
    end
end

#End of the math stuff.

#Here you can put your code. Don't forget to print the results!


#-------------------------------------------------------------
#Implementación del sistema para resolver el problema de TARS:
#-------------------------------------------------------------

#Obtencion de datos
puts "SENSORS FEED ME DATA!\nA que ÁNGULO está el objeto?"
angle = gets.chomp.to_i
if ((angle > 90) or (angle < 0))
    while ((angle > 90) or (angle < 0))
        puts "Incorrecto. Los ángulos aceptables son 0°-90°. A que ÁNGULO está el objeto?"
        angle = gets.chomp.to_i
    end
end
puts "A que DISTANCIA está el objeto?"
distance = gets.chomp.to_i
if ((distance > 10) or (distance < 0))
    while ((distance > 10) or (distance < 1))
        puts "Incorrecto. Las distancias aceptables son 1-10. A que DISTANCIA está el objeto?"
        distance = gets.chomp.to_i
    end
end

#Declaración de conjuntos difusos
bigAngle = [65.0,90.0,90.0,90.0] #Half-Trapezoidal (L)
midAngle = [15.0,40.0,50.0,75.0] #Trapezoidal
lilAngle = [0.0,0.0,0.0,25.0]    #Half-Trapezoidal (R)

veryLongDistance =  [7.0,10.0,10.0,10.0]    #Half-Trapezoidal (L)
longDistance =      [4.0, 6.0, 8.0]         #Triangular
shortDistance =     [1.0, 3.5, 5.5]         #Triangular

verySlowSpeed = [100.0,100.0,300.0]    #Half-Trapezoidal (L)
slowSpeed = [200.0,350.0,500.0]        #Triangular
fastSpeed = [400.0,550.0,700.0]        #Triangular
veryFastSpeed = [600.0,750.0,900.0]    #Triangular
topSpeed = [800.0,1000.0,1000.0]       #Half-Trapezoidal (R)

#Obtencion de grados de pertenencia
fuzzyAngle = [0,0,0]
fuzzyDistance = [0,0,0]

fuzzyAngle[2] = trapezoidalPertenenceDeegree(angle, lilAngle)
fuzzyAngle[1] = trapezoidalPertenenceDeegree(angle, midAngle)
fuzzyAngle[0] = trapezoidalPertenenceDeegree(angle, bigAngle)

fuzzyDistance[2] = triangularPertenenceDeegree(distance, shortDistance)
fuzzyDistance[1] = triangularPertenenceDeegree(distance, longDistance)
fuzzyDistance[0] = trapezoidalPertenenceDeegree(distance, veryLongDistance)

#Aplicación de variables lingüísticas
if fuzzyAngle.max == fuzzyAngle[0]
    languageAngle = "big"
elsif fuzzyAngle.max == fuzzyAngle[1]
    languageAngle = "medium"
elsif fuzzyAngle.max == fuzzyAngle[2]
    languageAngle = "little"
end

if fuzzyDistance.max == fuzzyDistance[0]
    languageDistance = "very long"
elsif fuzzyDistance.max == fuzzyDistance[1]
    languageDistance = "long"
elsif fuzzyDistance.max == fuzzyDistance[2]
    languageDistance = "short"
end

# Inferencia
var3 = 0
rule = {0=>0,1=>0,2=>0,3=>0,4=>0,5=>0,6=>0,7=>0,8=>0}
for var1 in 0..2
    for var2 in 0..2
        rule[var3] = [fuzzyAngle[var1], fuzzyDistance[var2]].min
        var3 = var3 + 1
    end
end

#Defusificación
maximumRule = rule.max_by{|k,v| v}

if maximumRule[0] == 0
    answer = topSpeed[1]
    speed = "punch it!"
elsif maximumRule[0] == 1
    answer = veryFastSpeed[1]
    speed = "very fast"
elsif maximumRule[0] == 2
    answer = fastSpeed[1]
    speed = "fast"
elsif maximumRule[0] == 3
    answer = veryFastSpeed[1]
    speed = "very fast"
elsif maximumRule[0] == 4
    answer = fastSpeed[1]
    speed = "fast"
elsif maximumRule[0] == 5
    answer = slowSpeed[1]
    speed = "slow"
elsif maximumRule[0] == 6
    answer = veryFastSpeed[1]
    speed = "very fast"
elsif maximumRule[0] == 7
    answer = slowSpeed[1]
    speed = "slow"
elsif maximumRule[0] == 8
    answer = verySlowSpeed[1]
    speed = "very slow"
end

#Respuesta
puts "Respuesta lingüística del modulo de razonamiento: #{speed}"
puts "Respuesta numérica del modulo de razonamiento: #{answer}"


=begin
#--------------DEBUGGING--------------
puts ""
puts "grado de pertenencia angular"
puts fuzzyAngle
puts "grado de pertenencia linear"
puts fuzzyDistance
puts ""
puts "maximo angular"
puts languageAngle
puts fuzzyAngle.max
puts "maximo linear"
puts fuzzyDistance.max
puts languageDistance
puts rule

puts "maximo = #{maximumRule}"
#   puts rule.max_by{|k,v| v}[1]+1    gives me an array with the 
#   maximum key and value of the hash, and adds one to the value
=end